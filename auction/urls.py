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

    url(r'^booths/$', views.BoothList.as_view(), name="booth_list"),
    url(r'^booth/create/$', views.BoothCreate.as_view(), name="booth_create"),
    url(r'^booth/(?P<pk>\d+)/$', views.BoothDetail.as_view(), name="booth_detail"),
    url(r'^booth/(?P<pk>\d+)/edit/$', views.BoothUpdate.as_view(), name="booth_update"),
    url(r'^booth/(?P<pk>\d+)/delete/$', views.BoothDelete.as_view(), name="booth_delete"),

    url(r'^buyers/$', views.BuyerList.as_view(), name="buyer_list"),
    url(r'^buyer/create/$', views.BuyerCreate.as_view(), name="buyer_create"),
    url(r'^buyer/(?P<pk>\d+)/$', views.BuyerDetail.as_view(), name="buyer_detail"),
    url(r'^buyer/(?P<pk>\d+)/edit/$', views.BuyerUpdate.as_view(), name="buyer_update"),
    url(r'^buyer/(?P<pk>\d+)/delete/$', views.BuyerDelete.as_view(), name="buyer_delete"),
    url(r'^buyer/(?P<pk>\d+)/receipt/$', views.BuyerReceipt.as_view(), name="buyer_receipt"),

    url(r'^payments/$', views.PaymentList.as_view(), name="payment_list"),
    url(r'^payment/create/$', views.PaymentCreate.as_view(), name="payment_create"),
    url(r'^payment/(?P<pk>\d+)/$', views.PaymentDetail.as_view(), name="payment_detail"),
    url(r'^payment/(?P<pk>\d+)/edit/$', views.PaymentUpdate.as_view(), name="payment_update"),
    url(r'^payment/(?P<pk>\d+)/delete/$', views.PaymentDelete.as_view(), name="payment_delete"),

    url(r'^sale/$', views.RandomSale.as_view(), name="test_sale"),
    url(r'^add_charge/$', views.priced_item_checkout, name="add_charge"),

    url(r'^bidding/(?P<item_pk>\d+)/$', views.BiddingRecorder.as_view(), name='bidding_recorder'),
    url(r'^management/$', views.ItemManagement.as_view(), name='item_management'),

    url(r'^(?P<booth_slug>[-\w]+)/checkout/$', views.CheckoutBuyer.as_view(), name='checkout_buyer'),
    url(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/$', views.CheckoutPurchase.as_view(), name='checkout_purchase'),
    url(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/confirm/$', views.CheckoutConfirm.as_view(), name='checkout_confirm'),
]
