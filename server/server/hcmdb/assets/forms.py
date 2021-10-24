# coding:utf-8
from django import forms
from assets.models import dataCenter, asset

class assetForm(forms.ModelForm):
    def __init__(self, *args, **kwargs):
       super(assetForm, self).__init__(*args, **kwargs)
       self.fields['group'].queryset = dataCenter.objects.filter(availabity=1)
    class Meta:
        model = asset
        fields = ['group', 'server_type', 'ip', 'other_ip', 'port', 'is_monitoring', 'is_backup', 'config', 'app_name', 'role_name', 'editor']

class idcForm(forms.ModelForm):
    class Meta:
        model = dataCenter
        fields = ['account_number', 'name', 'area', 'editor']



from models import CarModel
from models import CarList

class CarForm(forms.ModelForm):
    class Meta:
        model = CarModel
        fields = ('number', 'mileage')


class CarinfoForm(forms.ModelForm):
    class Meta:
        model = CarList
        fields = ('number', 'date', 'zaoban', 'zhongban', 'wanban')

