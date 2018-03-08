from django.contrib import admin

# Register your models here.
from auction.models import AuctionItem, PricedItem, Patron, Booth, Purchase, Payment

admin.site.register(AuctionItem)
admin.site.register(PricedItem)
admin.site.register(Patron)
admin.site.register(Payment)
admin.site.register(Purchase)
admin.site.register(Booth)
