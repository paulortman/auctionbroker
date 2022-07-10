"""auctionbroker URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.10/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  re_path(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  re_path(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.conf.urls import url, include
    2. Add a URL to urlpatterns:  re_path(r'^blog/', include('blog.urls'))
"""
from django.urls import re_path
from django.views.generic import TemplateView

from . import views

urlpatterns = [
    re_path(r'^items/$', views.AuctionItemList.as_view(), name="item_list"),
    re_path(r'^item/create/$', views.AuctionItemCreate.as_view(), name="item_create"),
    re_path(r'^item/create/(?P<booth_slug>[-\w]+)/$', views.AuctionItemCreate.as_view(), name="item_create"),
    re_path(r'^item/(?P<item_number>\d+)/$', views.AuctionItemDetail.as_view(), name="item_detail"),
    re_path(r'^item/(?P<item_number>\d+)/edit/$', views.AuctionItemUpdate.as_view(), name="item_update"),
    re_path(r'^item/(?P<item_number>\d+)/delete/$', views.AuctionItemDelete.as_view(), name="item_delete"),

    re_path(r'^booths/$', views.BoothList.as_view(), name="booth_list"),
    re_path(r'^booth/create/$', views.BoothCreate.as_view(), name="booth_create"),
    re_path(r'^booth/(?P<pk>\d+)/$', views.BoothDetail.as_view(), name="booth_detail"),
    re_path(r'^booth/(?P<pk>\d+)/edit/$', views.BoothUpdate.as_view(), name="booth_update"),
    re_path(r'^booth/(?P<pk>\d+)/delete/$', views.BoothDelete.as_view(), name="booth_delete"),

    re_path(r'^patrons/$', views.PatronList.as_view(), name="patron_list"),
    re_path(r'^patrons/xlsx/$', views.PatronListXLSX.as_view(), name="patron_list_xlsx"),
    re_path(r'^patron/create/$', views.PatronCreate.as_view(), name="patron_create"),
    re_path(r'^patron/(?P<pk>\d+)/$', views.PatronDetail.as_view(), name="patron_detail"),
    re_path(r'^patron/(?P<pk>\d+)/edit/$', views.PatronUpdate.as_view(), name="patron_update"),
    re_path(r'^patron/(?P<pk>\d+)/delete/$', views.PatronDelete.as_view(), name="patron_delete"),
    re_path(r'^patron/(?P<pk>\d+)/receipt/$', views.PatronReceipt.as_view(), name="patron_receipt"),
    re_path(r'^patron/(?P<pk>\d+)/payment/cc/$', views.PatronPaymentWizardCC.as_view(), {'step': 'cc'}, name="payment_wizard_cc"),
    re_path(r'^patron/(?P<pk>\d+)/payment/cc/fee/$', views.PatronPaymentWizardCCFee.as_view(), {'step': 'ccfee'}, name="payment_wizard_ccfee"),
    re_path(r'^patron/(?P<pk>\d+)/payment/cash/$', views.PatronPaymentWizardCash.as_view(), {'step': 'cash'}, name="payment_wizard_cash"),
    re_path(r'^patron/jump/$', views.PatronJump.as_view(), name="patron_jump"),

    re_path(r'^payments/$', views.PaymentList.as_view(), name="payment_list"),
    re_path(r'^payment/create/$', views.PaymentCreate.as_view(), name="payment_create"),
    re_path(r'^payment/(?P<pk>\d+)/$', views.PaymentDetail.as_view(), name="payment_detail"),
    re_path(r'^payment/(?P<pk>\d+)/edit/$', views.PaymentUpdate.as_view(), name="payment_update"),
    re_path(r'^payment/(?P<pk>\d+)/delete/$', views.PaymentDelete.as_view(), name="payment_delete"),

    re_path(r'^purchases/$', views.PurchaseList.as_view(), name="purchase_list"),
    re_path(r'^purchase/create/$', views.PurchaseCreate.as_view(), name="purchase_create"),
    re_path(r'^purchase/(?P<pk>\d+)/$', views.PurchaseDetail.as_view(), name="purchase_detail"),
    re_path(r'^purchase/(?P<pk>\d+)/edit/$', views.PurchaseUpdate.as_view(), name="purchase_update"),
    re_path(r'^purchase/(?P<pk>\d+)/delete/$', views.PurchaseDelete.as_view(), name="purchase_delete"),

    re_path(r'^fee/(?P<pk>\d+)/delete/$', views.FeeDelete.as_view(), name="fee_delete"),

    re_path(r'^dashboard/$', views.SalesDashboard.as_view(template_name='dashboard.html'), name="dashboard"),

    re_path(r'^bidding/(?P<item_number>\d+)/$', views.BiddingRecorder.as_view(), name='bidding_recorder'),
    re_path(r'^management/(?P<booth_slug>[-\w]+)/$', views.AuctionItemManagement.as_view(), name='item_management'),
    # re_path(r'^management/$', views.AuctionItemManagement.as_view(), name='item_management'),

    re_path(r'^donate/$', views.Donate.as_view(), name="donate"),
    re_path(r'^donate/(?P<pk>\d+)/$', views.PatronDonate.as_view(), name="patron_donate"),

    re_path(r'^(?P<booth_slug>[-\w]+)/checkout/$', views.CheckoutPatron.as_view(), name='checkout_patron'),
    re_path(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/$', views.CheckoutPurchase.as_view(), name='checkout_purchase'),
    re_path(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/confirm/$', views.CheckoutConfirm.as_view(), name='checkout_confirm'),

    re_path(r'^ajax/patron_search/$', views.PatronSearch.as_view(), name='patron_search'),
    re_path(r'^ajax/patron_lookup/$', views.PatronLookup.as_view(), name='patron_lookup'),
    re_path(r'^ajax/item_search/$', views.AuctionItemSearch.as_view(), name='item_search'),

    re_path(r'^reports/$', views.Reports.as_view(), name='reports'),
    re_path(r'^reports/unsettled_accounts/$', views.UnsettledAccounts.as_view(), name='report_unsettled_accounts'),
    re_path(r'^reports/sales_by_booth/$', views.SalesByBooth.as_view(), name='sales_by_booth'),
    re_path(r'^reports/all_sales/$', views.AllSales.as_view(), name='all_sales'),

    re_path(r'^setup/populate_attendees/$', views.PopulateAttendees.as_view(), name='populate_attendees'),
    re_path(r'^setup/populate_auctionitems/$', views.PopulateAuctionItems.as_view(), name='populate_auctionitems'),
    re_path(r'^setup/success/$', TemplateView.as_view(template_name='setup/success.html'), name='setup_success')
]
