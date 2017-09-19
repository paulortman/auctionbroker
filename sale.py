from auction.models import AuctionItem, Bidder
from auction.modelfactory import AuctionItemFactory, BidderFactory
b = BidderFactory.create()
ai = AuctionItemFactory.create(winning_bidder=b)
