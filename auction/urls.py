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
    url(r'^items/$', views.AuctionItemList.as_view(), name="item_list"),
    url(r'^item/create/$', views.AuctionItemCreate.as_view(), name="item_create"),
    url(r'^item/(?P<item_number>\d+)/$', views.AuctionItemDetail.as_view(), name="item_detail"),
    url(r'^item/(?P<item_number>\d+)/edit/$', views.AuctionItemUpdate.as_view(), name="item_update"),
    url(r'^item/(?P<item_number>\d+)/delete/$', views.AuctionItemDelete.as_view(), name="item_delete"),

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
    url(r'^buyer/(?P<pk>\d+)/pay/$', views.BuyerPay.as_view(), name="buyer_pay"),
    # url(r'^buyer/(?P<pk>\d+)/donate/$', views.BuyerDonate.as_view(), name="buyer_donate"),

    url(r'^payments/$', views.PaymentList.as_view(), name="payment_list"),
    url(r'^payment/create/$', views.PaymentCreate.as_view(), name="payment_create"),
    url(r'^payment/(?P<pk>\d+)/$', views.PaymentDetail.as_view(), name="payment_detail"),
    url(r'^payment/(?P<pk>\d+)/edit/$', views.PaymentUpdate.as_view(), name="payment_update"),
    url(r'^payment/(?P<pk>\d+)/delete/$', views.PaymentDelete.as_view(), name="payment_delete"),

    url(r'^purchase/$', views.PurchaseList.as_view(), name="purchase_list"),
    url(r'^purchase/create/$', views.PurchaseCreate.as_view(), name="purchase_create"),
    url(r'^purchase/(?P<pk>\d+)/$', views.PurchaseDetail.as_view(), name="purchase_detail"),
    url(r'^purchase/(?P<pk>\d+)/edit/$', views.PurchaseUpdate.as_view(), name="purchase_update"),
    url(r'^purchase/(?P<pk>\d+)/delete/$', views.PurchaseDelete.as_view(), name="purchase_delete"),

    url(r'^dashboard/$', views.TemplateView.as_view(template_name='dashboard.html'), name="dashboard"),

    url(r'^bidding/(?P<item_number>\d+)/$', views.BiddingRecorder.as_view(), name='bidding_recorder'),
    url(r'^management/$', views.AuctionItemManagement.as_view(), name='item_management'),

    url(r'^donate/$', views.Donate.as_view(), name="donate"),
    url(r'^donate/(?P<pk>\d+)/$', views.BuyerDonate.as_view(), name="buyer_donate"),

    url(r'^(?P<booth_slug>[-\w]+)/checkout/$', views.CheckoutBuyer.as_view(), name='checkout_buyer'),
    url(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/$', views.CheckoutPurchase.as_view(), name='checkout_purchase'),
    url(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/confirm/$', views.CheckoutConfirm.as_view(), name='checkout_confirm'),

    url(r'^ajax/buyer_search/$', views.BuyerSearch.as_view(), name='buyer_search'),
    url(r'^ajax/item_search/$', views.AuctionItemSearch.as_view(), name='item_search')
]
