# -*- coding: utf-8 -*-
from django.shortcuts import render_to_response
from django.http import HttpResponse
from django.template import RequestContext
from django.views.decorators.csrf import csrf_exempt
from ht_cmdb.settings import logger
from monitor.models import Agent, BrowserHistory
from lib.lib import pages
from django.utils.encoding import smart_str
import sys


@csrf_exempt
def MonitorInfoAdd(request):
    if sys.getdefaultencoding() != 'utf-8':
        reload(sys)
        sys.setdefaultencoding('utf-8')
        defaultencoding = sys.getdefaultencoding()
    request.encoding = 'utf-8'
    ip_add = request.POST.get('ip')
    ip_add = smart_str(ip_add)
    host_name = request.POST.get('hostname')
    history = request.POST.get('history_info')
    Browser_Type = request.POST.get('BrowserType')
    uuid = request.POST.get('uid')
    status = request.POST.get('status')
    logger.info('GET ip: {}'.format(type(ip_add)))
    logger.info('GET uuid: {}'.format(uuid))
    logger.info('GET HOSTNAME:{}'.format(host_name))
    logger.info('GET BROWSERTYPE:{}'.format(Browser_Type))
    res = eval(history)
    if len(res) != 0:
        logger.info('GET BROWSER HISTORY:{}'.format(res[0]))
    else:
        logger.info('NO BROWSERHISTORY WAIT...')
    try:
        Agent.objects.get(uid=uuid)
        logger.info('The employees computer information is exist....')
    except:
        Agent.objects.create(uid=uuid, host_name=host_name, host_ip=ip_add)
    for i in res:
        r = smart_str(i[1])
        logger.info("类型数据数据{}".format(i[1]))
        logger.info('+++++++{}'.format(i))
        BrowserHistory.objects.create(uid=uuid, browser_type=Browser_Type, browser_url=i[0], browser_datetime=i[2],
                                      browser_title=i[1])
    return HttpResponse('success')


def user_info(request):
    AgentList = Agent.objects.all()
    return render_to_response('monitor/AgentList.html', locals(), context_instance=RequestContext(request))


def MonitorInfoList(request):
    uid = request.GET.get('uid')
    BrowserHistoryList = BrowserHistory.objects.filter(uid=uid)
    BrowserHistoryList = list(set(BrowserHistoryList))
    s_url = request.get_full_path()
    ontact_list, p, contacts, page_range, current_page, show_first, show_end = pages(BrowserHistoryList, request)
    return render_to_response('monitor/browserhistoryList.html', locals(), context_instance=RequestContext(request))

