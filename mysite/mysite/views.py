from __future__ import absolute_import
from __future__ import unicode_literals

# Put Standard Library Imports Here:
import json
import traceback
import os

# Put Third Party/Django Imports Here:
# from django.contrib.auth.decorators import permission_required
from django.http import HttpResponse
from django.views.decorators.http import require_GET
from django.views.decorators.http import require_POST

@require_GET
def getInfo(httpRequest):
    title = 'lambda api-gateway demo !'
    data_file = os.path.join(os.path.dirname(os.path.abspath(__file__)) , "data.txt")
    with open (data_file, "r") as myfile:
        data = myfile.readlines()
    response = "{0}<br>{1}".format(title, data)
    return HttpResponse(response, content_type="text/html")
