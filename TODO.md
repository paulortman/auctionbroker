# Todo

## 2019 Todo

- Better Auction Management Screen
- Paginate patron list and/or auction lists
- Allow combining two buyer numbers into one payment
- Seems to be bug when checking out a booth and getting spaces? in the buyer number field -- generated "500" errors numerous times
- Configure Papertrail logging to save production data logs



## Other
- in-kind donation recording for goods and services
    - donor field search/autocomplete
- add images to AuctionItems (https://github.com/alexsdutton/django-camera-imagefield ?)
- cancel button on "record auction bid" page does nothing...

## Dashboard/Reports

- Sales Stats
- All Receipts?
- Dollars over time graph?
- Auction Booklet?
- 

# Done
- "Record Bid and Next Item ...." button when recording bids
- Lots of bugs with Auction categories when adding/editing auction items
    - returns to wrong page on save
    - save and add another does not work
    - save and return to list does not work
- Move In-Kind Donations on the Patron screen to much lower -- very confusing for those checking out
- manually enter buyer numbers
- admin dashboard/reports
- payments with CC need multiple steps to correctly calculate fees (must fix)
- search buyers by name, number, address
- Buyers should really be Patrons
- priced item editing should synchronize amount paid and fmv
- add fee model to record CC purchase fees paid
- the widget for amounts/money should have a $ tied to the form-field
- All messages about successfully donating need to include buyer number
- Unsettled accounts shows people with balance of $0.00, annoying
- Allow eding descriptions of transactions when editing during checkout
- Fix rounding error for CC payemnts (too many decimal places become invalid form entry)
- Add donor info to Auction Item List
- Order Patron list by last name, first name
- Order donor selection for auction items by last name, first_name
- Green link text on white for Patron names (and others) is pretty hard to read
- Add patron search to toolbar/menubar so you don't need to list all patrons
- Login form is screwy at small screen sizes
- Make interface to bulk add blessing bids
    - something to enter bid amount categories with multiple bidders per
      category
