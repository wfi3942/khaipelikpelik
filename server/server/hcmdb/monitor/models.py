from django.db import models
from django.utils.translation import ugettext_lazy as _


# Create your models here.


class BrowserHistory(models.Model):
    uid = models.CharField(max_length=128, default=0, verbose_name=_("UID"))
    browser_type = models.CharField(max_length=128, verbose_name=_("Browser type"))
    browser_url = models.CharField(max_length=6000, verbose_name=_("url"))
    browser_datetime = models.CharField(max_length=32, verbose_name=_("datetime"))
    browser_title = models.CharField(max_length=6000, verbose_name=_("title"))

    class Meta:
        db_table = "BrowserHistory"


class Agent(models.Model):
    uid = models.CharField(max_length=128, default=0, verbose_name=_("UID"))
    host_ip = models.CharField(max_length=32, verbose_name=_("ip"))
    host_name = models.CharField(max_length=128, verbose_name=_("hostname"))
    agent_status = models.CharField(max_length=5, default=0, verbose_name=_("agent status"))

    class Meta:
        db_table = "Agent"
