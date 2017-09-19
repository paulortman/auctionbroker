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
    url(r'^items/$', views.AuctionItemList.as_view(), name="auctionitem_list"),
    url(r'^item/create/$', views.AuctionItemCreate.as_view(), name="auctionitem_create"),
    url(r'^item/(?P<pk>\d+)/$', views.AuctionItemDetail.as_view(), name="auctionitem_detail"),
    url(r'^item/(?P<pk>\d+)/edit/$', views.AuctionItemUpdate.as_view(), name="auctionitem_update"),
    url(r'^item/(?P<pk>\d+)/delete/$', views.AuctionItemDelete.as_view(), name="auctionitem_delete"),

    url(r'^bidders/$', views.BidderList.as_view(), name="bidder_list"),
    url(r'^bidder/create/$', views.BidderCreate.as_view(), name="bidder_create"),
    url(r'^bidder/(?P<pk>\d+)/$', views.BidderDetail.as_view(), name="bidder_detail"),
    url(r'^bidder/(?P<pk>\d+)/edit/$', views.BidderUpdate.as_view(), name="bidder_update"),
    url(r'^bidder/(?P<pk>\d+)/delete/$', views.BidderDelete.as_view(), name="bidder_delete"),

    url(r'^sale/$', views.RandomSale.as_view(), name="test_sale"),
]
