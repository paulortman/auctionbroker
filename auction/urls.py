"""auctionbroker URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^items/$', views.ItemList.as_view(), name="item_list"),
    url(r'^item/create/$', views.ItemCreate.as_view(), name="item_create"),
    url(r'^item/(?P<pk>\d+)/$', views.ItemDetail.as_view(), name="item_detail"),
    url(r'^item/(?P<pk>\d+)/edit/$', views.ItemUpdate.as_view(), name="item_update"),
    url(r'^item/(?P<pk>\d+)/delete/$', views.ItemDelete.as_view(), name="item_delete"),

    url(r'^buyers/$', views.BuyerList.as_view(), name="buyer_list"),
    url(r'^buyer/create/$', views.BuyerCreate.as_view(), name="buyer_create"),
    url(r'^buyer/(?P<pk>\d+)/$', views.BuyerDetail.as_view(), name="buyer_detail"),
    url(r'^buyer/(?P<pk>\d+)/edit/$', views.BuyerUpdate.as_view(), name="buyer_update"),
    url(r'^buyer/(?P<pk>\d+)/delete/$', views.BuyerDelete.as_view(), name="buyer_delete"),

    url(r'^sale/$', views.RandomSale.as_view(), name="test_sale"),
    url(r'^add_charge/$', views.AddCharge.as_view(), name="add_charge"),
]
