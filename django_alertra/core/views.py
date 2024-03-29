from rest_framework import status, authentication, permissions
from rest_framework.decorators import api_view, authentication_classes,permission_classes
from rest_framework.views import APIView
from rest_framework.response import Response

from .models import Report, ReportSearchResult, Alert, School, Source, KeyWord
from .serializers import ReportSerializer, AlertSerializer, UserDataSerializer, SchoolSerializer

import pandas as pd 
from sklearn.feature_extraction import text
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.cluster import KMeans
from nltk.tokenize import RegexpTokenizer
from nltk.stem.snowball import SnowballStemmer
from googlesearch import search
from GoogleNews import GoogleNews

class ReportList(APIView):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, format=None):
        reports = Report.objects.filter(school=request.user.school)
        serializer = ReportSerializer(reports, many=True)
        return Response(serializer.data)


class SchoolList(APIView):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, format=None):
        schools = School.objects.all()
        serializer = SchoolSerializer(schools, many=True)
        return Response(serializer.data)

class AlertList(APIView):
    authentication_classes = [authentication.TokenAuthentication]
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request, format=None):
        alerts = Alert.objects.filter(recipient=request.user.role, school=request.user.school)
        serializer = AlertSerializer(alerts, many=True)
        return Response(serializer.data)


def webscrape(town, incident):
    return search(town + ' ' + incident, num_results=3, lang="en")

# function to create csv datasets with search headlines for kmeans clustering
def createData(filePath, headlines):
    lstReturnData = []
    for index, headline in enumerate(headlines):
        lstReturnData.append([index, headline])

    return lstReturnData

# Find safety related news for given city and state from Google News
def findSafetyNews(strCity, strState):
    gn = GoogleNews()
    strSafetyIndicators = "danger"
    foundNews = gn.search(strCity + " " + strState + " " + strSafetyIndicators)
    lstArticles = foundNews['entries']
    lstReturnNews = []
    lstReturnSources = []
    for dicItem in lstArticles:
        lstReturnNews.append(dicItem['title'])
        lstReturnSources.append(dicItem['links'][0]['href'])
    return lstReturnNews, lstReturnSources

def findSource(word, headlines, sources):
    for intCtr, headline in enumerate(headlines):
        if word in headline.lower():
            return sources[intCtr]


# function to initialize the User model
@api_view(['POST'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def createUser(request):

    data = request.data
    user = request.user

    role = data['role']
    school = data['school']

    user.school = School.objects.get(name=school)
    user.role = role
    user.save()

    return Response(status=status.HTTP_200_OK)


# function to retrieve data from the User model fields
@api_view(['GET'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def getUserData(request):

    user = request.user

    return Response({
        'role': user.role,
        'school': user.school.name,
        'username': user.username,
    })


# function to retrieve data from the User model fields
@api_view(['GET'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def getSchoolData(request):

    user = request.user
    school = user.school

    serializer = SchoolSerializer(school)
    return Response(serializer.data)


# function to initialize the Report model
@api_view(['POST'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def createReport(request):

    data = request.data
    user = request.user
    school = user.school

    try:
        # see if the report has the 'description'
        location = data['location']
        priority = data['priority']
        description = data['description']
        report_type = data['report_type']
        picture = data['picture']

        new_report = Report.objects.create(user=user, description=description, location=location, priority=priority, school=school, report_type=report_type, picture=picture)
    except: 
        # if it doesn't it is an emergency report with only the report type and a default of high priority
        description = data['description']
        report_type = data['report_type']
        
        priority = 'high'

        new_report = Report.objects.create(user=user, report_type=report_type, priority=priority, school=school, description=description)


    new_report.save()
    
    try:
        url1, url2, url3 = webscrape(school.city, report_type)
    except: 
        url1, url2, url3 = webscrape(school.city, description)

    try:
        new_search1 = ReportSearchResult.objects.create(report=new_report, url=url1)
        new_search1.save()
        new_search2 = ReportSearchResult.objects.create(report=new_report, url=url2)
        new_search2.save()
        new_search3 = ReportSearchResult.objects.create(report=new_report, url=url3)
        new_search3.save()
    except:
        # no matching results
        pass

    return Response(status=status.HTTP_201_CREATED)


@api_view(['POST'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def getReportData(request):

    report_id = request.data['report_id']
    report = Report.objects.get(id=report_id)
    serializer = ReportSerializer(report)

    return Response(serializer.data)




# function to initialize the Alert model
@api_view(['POST'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def createAlert(request):

    data = request.data
    user = request.user

    headline = data['headline']
    content = data['content']
    recipient = data['recipient']
    priority = data['priority']
    alert_type = data['alert_type']
    school = School.objects.get(name=user.school.name)

    try: 
        report_id = data['report_id']
        report = Report.objects.get(id=report_id)

        if recipient == 'All':
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Teacher', school=school, linked_report=report, priority=priority)
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Student', school=school, linked_report=report, priority=priority)
        elif recipient == 'Teachers':
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Teacher', school=school, linked_report=report, priority=priority)
        elif recipient == 'Students':
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Student', school=school, linked_report=report, priority=priority)

    except:

        # no linked report

        if recipient == 'All':
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Teacher', school=school, priority=priority)
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Student', school=school, priority=priority)
        elif recipient == 'Teachers':
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Teacher', school=school, priority=priority)
        elif recipient == 'Students':
            new_alert = Alert.objects.create(user=user, headline=headline, content=content, alert_type=alert_type, recipient='Student', school=school, priority=priority)



    new_alert.save()


    return Response(status=status.HTTP_201_CREATED)


# function to initialize the School model
@api_view(['POST'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def createSchool(request):

    data = request.data
    user = request.user

    name = data['name']
    address = data['address']
    city = data['city']
    state = data['state']

    new_school = School.objects.create(name=name, address=address, city=city, state=state)
    new_school.save()
    
    # filePath = 'django_peddiehacks\\extras\\datasets\\{}.csv'.format(name)
    filePath = 'django_peddiehacks/extras/datasets/{}.csv'.format(name)
    headlines, sources = findSafetyNews(city, state)
    print('HEADLINES: ')
    print(headlines)
    print('SOURCES:')
    print(sources)

    # Following code is for clustering to find the most frequent types of safety issues in a school's city
    # data = pd.read_csv("C:\\Users\\suchi\\Dropbox (Sandipan.com)\\Creative\\RitiCode\\PeddieHacks 2021\\django_peddiehacks\\extras\\datasets\\{}.csv".format(name), error_bad_lines=False, usecols =["headline_text"])
    # data = pd.read_csv("/home/antz/vscode/App/flutter/peddiehacks-2021/django_peddiehacks/extras/datasets/{}.csv".format(name), error_bad_lines=False, usecols =["headline_text"])
    data = pd.DataFrame(createData(filePath, headlines), columns = ['index', 'headline_text'])

    # Dictionary of words indicating danger in news articles
    dicDangerWords = {
        'weapons': ['gun', 'shooting', 'rifle', 'shoot', 'weapon'],
        'assault': ['beating', 'assault', 'beat', 'harm', 'hurt', 'bleeding'],
        'drugs': ['narcotic', 'drug', 'cannabis', 'opium', 'opioid', 'marijuana', 'cocaine', 'weed'],
        'storm': ['weather', 'tornado', 'hurricane', 'storm']
    }

    # Deleting duplicate headlines (if any)
    data[data['headline_text'].duplicated(keep=False)].sort_values('headline_text').head(8)
    data = data.drop_duplicates('headline_text')

    # NLP:
    punc = ['.', ',', '"', "'", '?', '!', ':', ';', '(', ')', '[', ']', '{', '}',"%"]
    stop_words = text.ENGLISH_STOP_WORDS.union(punc)
    desc = data['headline_text'].values
    vectorizer = TfidfVectorizer(stop_words = stop_words)
    X = vectorizer.fit_transform(desc)

    word_features = vectorizer.get_feature_names()
    print('LENGTH OF WORD FEATURES:')
    print(len(word_features))
    print('WORD FEATURES')
    print(word_features[5000:5100])

    # Tokenizing
    stemmer = SnowballStemmer('english')
    tokenizer = RegexpTokenizer(r'[a-zA-Z\']+')

    def tokenize(text):
        return [stemmer.stem(word) for word in tokenizer.tokenize(text.lower())]

    # Vectorization with stop words(words irrelevant to the model), stemming and tokenizing
    vectorizer2 = TfidfVectorizer(stop_words = stop_words, tokenizer = tokenize)
    X2 = vectorizer2.fit_transform(desc)
    word_features2 = vectorizer2.get_feature_names()
    print('LENGTH OF WORD FEATURES 2:')
    print(len(word_features2))
    print('WORD FEATURES 2')
    print(word_features2[:50]) 

    vectorizer3 = TfidfVectorizer(stop_words = stop_words, tokenizer = tokenize, max_features = 1000)
    X3 = vectorizer3.fit_transform(desc)
    words = vectorizer3.get_feature_names()

    # K-means clustering
    wcss = []
    for i in range(1,11):
        kmeans = KMeans(n_clusters=i,init='k-means++',max_iter=300,n_init=10,random_state=0)
        kmeans.fit(X3)
        wcss.append(kmeans.inertia_)

    print('K-MEANS CLUSTERING WORDS:')
    print(words[250:300])

    # 2 clusters
    kmeans = KMeans(n_clusters = 3, n_init = 20, n_jobs = 1) # n_init(number of iterations for clsutering) n_jobs(number of cpu cores to use)
    kmeans.fit(X3)
    # We look at the 2 clusters generated by k-means.
    common_words = kmeans.cluster_centers_.argsort()[:,-1:-26:-1]
    lstWordCategories = []
    for num, centroid in enumerate(common_words):
        # print(words[centroid[0]])
        # print(str(num) + ' : ' + ', '.join(words[word] for word in centroid))
        # print(words[word] for word in centroid)
        lstWords = []
        for word in centroid:
            lstWords.append(words[word])
        lstWordCategories.append(lstWords)

    lstKeyWords = []
    lstSources = []
    for cluster in lstWordCategories:
        for word in cluster:
            for key, lstValue in dicDangerWords.items():
                if word in lstValue and key not in lstKeyWords:
                    lstKeyWords.append(key)
                    lstSources.append(findSource(word, headlines, sources))
    
    for src in lstSources:
        new_source = Source.objects.create(school=new_school, url=src)
        new_source.save()
    for word in lstKeyWords:
        new_key_word = KeyWord.objects.create(school=new_school, word=word)
        new_key_word.save()

    print('FINAL SOURCES')
    print(lstSources)
    print('FINAL WORDS')
    print(lstKeyWords)

    return Response(status=status.HTTP_201_CREATED)  


@api_view(['PUT'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def deleteReport(request):
    data = request.data
    report_id = data['id']

    report = Report.objects.get(id=report_id).delete()

    return Response(status=status.HTTP_200_OK)  


@api_view(['PUT'])
@authentication_classes([authentication.TokenAuthentication])
@permission_classes([permissions.IsAuthenticated])
def approveReport(request):
    data = request.data
    report_id = data['id']
    approved = data['approved']

    report = Report.objects.get(id=report_id)
    report.approved = approved

    report.save()

    return Response(status=status.HTTP_200_OK) 