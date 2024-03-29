from django.contrib.auth.models import AbstractUser
from django.db import models



# School model serves as a link between all of the Users, Reports, and Alerts in a school
class School(models.Model):
    name = models.CharField(max_length=128)
    address = models.CharField(max_length=128)
    city = models.CharField(max_length=128)
    state = models.CharField(max_length=128)

    def __str__(self):
        return f"{self.name}"

class Source(models.Model):
    school = models.ForeignKey(School, on_delete=models.CASCADE, null=True, blank=True, related_name='sources')
    url = models.URLField(max_length=200)

    def __str__(self):
        return f"{self.url}"

class KeyWord(models.Model):
    school = models.ForeignKey(School, on_delete=models.CASCADE, null=True, blank=True, related_name='key_words')
    word = models.CharField(max_length=64)

    def __str__(self):
        return f"{self.word}"

class User(AbstractUser):
    # teacher, student
    role = models.CharField(max_length=64, null=True, blank=True)
    school = models.ForeignKey(School, on_delete=models.CASCADE, null=True, blank=True)



class Report(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reports')
    # low, medium, high
    priority = models.CharField(max_length=64, default='low')
    school = models.ForeignKey(School, on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    approved = models.BooleanField(default=False)
    description = models.CharField(max_length=128, null=True, blank=True)
    altitude = models.CharField(max_length=64, null=True, blank=True)
    floor = models.CharField(max_length=64, null=True, blank=True)
    latitude = models.CharField(max_length=64, null=True, blank=True)
    longitude = models.CharField(max_length=64, null=True, blank=True)
    address = models.CharField(max_length=64, null=True, blank=True)
    report_type = models.CharField(max_length=64, null=True, blank=True)
    picture = models.ImageField(upload_to='uploads/', null=True, blank=True)

    class Meta:
        ordering = ('-time',)

    def __str__(self):
        return f"{self.report_type} Report"

    def get_picture(self):
        if self.picture:
            return 'http://10.0.2.2:5000' + self.picture.url
        return ''
    

# Search results that may corroborate with a report
class ReportSearchResult(models.Model):
    report = models.ForeignKey(Report, on_delete=models.CASCADE, related_name='search_results')
    url = models.URLField(max_length=200)

    def __str__(self):
        return f"{self.url} ({self.report})"


class Alert(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='alerts')
    # low, medium, high
    priority = models.CharField(max_length=64, default='low')
    headline = models.CharField(max_length=64, null=True, blank=True)
    content = models.CharField(max_length=1000)
    alert_type = models.CharField(max_length=64, null=True, blank=True)
    # teacher, student, all
    recipient = models.CharField(max_length=64)
    school = models.ForeignKey(School, on_delete=models.CASCADE)
    time = models.DateTimeField(auto_now_add=True, null=True, blank=True)
    linked_report = models.ForeignKey(Report, on_delete=models.CASCADE, null=True, blank=True)

    def __str__(self):
        return f"{self.headline}"