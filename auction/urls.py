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
from django.views.generic import TemplateView

from . import views

urlpatterns = [
    url(r'^items/$', views.AuctionItemList.as_view(), name="item_list"),
    url(r'^item/create/$', views.AuctionItemCreate.as_view(), name="item_create"),
    url(r'^item/create/(?P<booth_slug>[-\w]+)/$', views.AuctionItemCreate.as_view(), name="item_create"),
    url(r'^item/(?P<item_number>\d+)/$', views.AuctionItemDetail.as_view(), name="item_detail"),
    url(r'^item/(?P<item_number>\d+)/edit/$', views.AuctionItemUpdate.as_view(), name="item_update"),
    url(r'^item/(?P<item_number>\d+)/delete/$', views.AuctionItemDelete.as_view(), name="item_delete"),

    url(r'^booths/$', views.BoothList.as_view(), name="booth_list"),
    url(r'^booth/create/$', views.BoothCreate.as_view(), name="booth_create"),
    url(r'^booth/(?P<pk>\d+)/$', views.BoothDetail.as_view(), name="booth_detail"),
    url(r'^booth/(?P<pk>\d+)/edit/$', views.BoothUpdate.as_view(), name="booth_update"),
    url(r'^booth/(?P<pk>\d+)/delete/$', views.BoothDelete.as_view(), name="booth_delete"),

    url(r'^patrons/$', views.PatronList.as_view(), name="patron_list"),
    url(r'^patrons/xlsx/$', views.PatronListXLSX.as_view(), name="patron_list_xlsx"),
    url(r'^patron/create/$', views.PatronCreate.as_view(), name="patron_create"),
    url(r'^patron/(?P<pk>\d+)/$', views.PatronDetail.as_view(), name="patron_detail"),
    url(r'^patron/(?P<pk>\d+)/edit/$', views.PatronUpdate.as_view(), name="patron_update"),
    url(r'^patron/(?P<pk>\d+)/delete/$', views.PatronDelete.as_view(), name="patron_delete"),
    url(r'^patron/(?P<pk>\d+)/receipt/$', views.PatronReceipt.as_view(), name="patron_receipt"),
    url(r'^patron/(?P<pk>\d+)/payment/cc/$', views.PatronPaymentWizardCC.as_view(), {'step': 'cc'}, name="payment_wizard_cc"),
    url(r'^patron/(?P<pk>\d+)/payment/cc/fee/$', views.PatronPaymentWizardCCFee.as_view(), {'step': 'ccfee'}, name="payment_wizard_ccfee"),
    url(r'^patron/(?P<pk>\d+)/payment/cash/$', views.PatronPaymentWizardCash.as_view(), {'step': 'cash'}, name="payment_wizard_cash"),
    url(r'^patron/jump/$', views.PatronJump.as_view(), name="patron_jump"),

    url(r'^payments/$', views.PaymentList.as_view(), name="payment_list"),
    url(r'^payment/create/$', views.PaymentCreate.as_view(), name="payment_create"),
    url(r'^payment/(?P<pk>\d+)/$', views.PaymentDetail.as_view(), name="payment_detail"),
    url(r'^payment/(?P<pk>\d+)/edit/$', views.PaymentUpdate.as_view(), name="payment_update"),
    url(r'^payment/(?P<pk>\d+)/delete/$', views.PaymentDelete.as_view(), name="payment_delete"),

    url(r'^purchases/$', views.PurchaseList.as_view(), name="purchase_list"),
    url(r'^purchase/create/$', views.PurchaseCreate.as_view(), name="purchase_create"),
    url(r'^purchase/(?P<pk>\d+)/$', views.PurchaseDetail.as_view(), name="purchase_detail"),
    url(r'^purchase/(?P<pk>\d+)/edit/$', views.PurchaseUpdate.as_view(), name="purchase_update"),
    url(r'^purchase/(?P<pk>\d+)/delete/$', views.PurchaseDelete.as_view(), name="purchase_delete"),

    url(r'^fee/(?P<pk>\d+)/delete/$', views.FeeDelete.as_view(), name="fee_delete"),

    url(r'^dashboard/$', views.SalesDashboard.as_view(template_name='dashboard.html'), name="dashboard"),

    url(r'^bidding/(?P<item_number>\d+)/$', views.BiddingRecorder.as_view(), name='bidding_recorder'),
    url(r'^management/(?P<booth_slug>[-\w]+)/$', views.AuctionItemManagement.as_view(), name='item_management'),
    # url(r'^management/$', views.AuctionItemManagement.as_view(), name='item_management'),

    url(r'^donate/$', views.Donate.as_view(), name="donate"),
    url(r'^donate/(?P<pk>\d+)/$', views.PatronDonate.as_view(), name="patron_donate"),

    url(r'^(?P<booth_slug>[-\w]+)/checkout/$', views.CheckoutPatron.as_view(), name='checkout_patron'),
    url(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/$', views.CheckoutPurchase.as_view(), name='checkout_purchase'),
    url(r'^(?P<booth_slug>[-\w]+)/checkout/(?P<buyer_num>\d+)/confirm/$', views.CheckoutConfirm.as_view(), name='checkout_confirm'),

    url(r'^ajax/patron_search/$', views.PatronSearch.as_view(), name='patron_search'),
    url(r'^ajax/patron_lookup/$', views.PatronLookup.as_view(), name='patron_lookup'),
    url(r'^ajax/item_search/$', views.AuctionItemSearch.as_view(), name='item_search'),

    url(r'^reports/$', views.Reports.as_view(), name='reports'),
    url(r'^reports/unsettled_accounts/$', views.UnsettledAccounts.as_view(), name='report_unsettled_accounts'),
    url(r'^reports/sales_by_booth/$', views.SalesByBooth.as_view(), name='sales_by_booth'),
    url(r'^reports/all_sales/$', views.AllSales.as_view(), name='all_sales'),

    url(r'^setup/populate_attendees/$', views.PopulateAttendees.as_view(), name='populate_attendees'),
    url(r'^setup/populate_auctionitems/$', views.PopulateAuctionItems.as_view(), name='populate_auctionitems'),
    url(r'^setup/success/$', TemplateView.as_view(template_name='setup/success.html'), name='setup_success')
]
