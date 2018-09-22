from django.contrib import admin

# Register your models here.
from auction.models import AuctionItem, Patron, Booth, Purchase, Payment

admin.site.register(AuctionItem)
admin.site.register(Patron)
admin.site.register(Payment)
admin.site.register(Purchase)
admin.site.register(Booth)
