# CodePath-Yelp

This is an iOS application leveraging the Yelp API to display businesses in a listView, mapView, and detailView.

###Time spent: 18 hours

###Completed required user stories:
* [x] Search results page with dynamic row height
* [x] Custom listView cells with Auto Layout constraints
* [x] Search bar in the navigation bar
* [x] Filter page with category, sort, distance, and deals
* [x] Filter page is organized into groups
* [x] Filter page Search button triggers an API call with selected filters

###Completed optional user stories:
* [x] Infinite scroll in the Search results
* [x] Map View of search results
* [x] Distance filter expands like in real Yelp app
* [ ] Categories shows only a subset with "Sell All" row to expand
* [x] Restaurant detail page

###Notes:
In addition I have added the following:
* Segment controller to toggle the list/map views
* Functional searchBar in both list/map views
* Review class to contain a Business Review
* API methods to query a particular Business' reviews 
* UITableView in DetailViewController to showcase the reviews
* Added extension for UIColor to use hex
* Added launchscreen
