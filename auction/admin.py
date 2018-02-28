from django.contrib import admin

# Register your models here.
from auction.models import AuctionItem, PricedItem, Buyer, Booth, Purchase, Payment

admin.site.register(AuctionItem)
admin.site.register(PricedItem)
admin.site.register(Buyer)
admin.site.register(Payment)
admin.site.register(Purchase)
admin.site.register(Booth)
