# Netflix iOS Clone

This is the project where I developed a netflix ios application clone to learn MVVM architecture, UIKit, Swift and networking.

List movies and tv shows according the categories, such as, Trending Movies, Top rated Tv shows, or Upcoming Movies etc.

The app has 4 main screen, same as netflix itself, Home, Upcoming, Top Search and Downloads


### *App demo*
<video src="https://user-images.githubusercontent.com/47990723/190715554-a5b282a4-cec2-427a-bdfb-41662ab31236.mp4
" controls="controls" style="max-width: 730px;"> </video>

### *Demo Highlights*
• Detail view properly handles the situation where the some details are not provided by the API. <br /><br />
• Used **CoreData** to store title informations when tapped on download button <br /><br />
• All title datas provided by themoviedb.org's API. <br/><br/>
• When any Title is downloaded, it notify the Downloads screen via swift's own Notification Center, and all the data that makes up the page are recalculated. <br/><br/>

### *Code Highlights*
• Thanks to sdwebimage, photos can be cached and provide uninterrupted slide animations.  <br /><br />
• Uses Swift's Result type <br /><br />
• Every view has been created ***programmatically*** <br /><br />
• Each page loads 10 countries, thanks to the "limit 10" parameter in the network layer. When it comes to the bottom of the page, it automatically pulls the other page from the internet and merges it with the previous one. This way, both the pages contain little data and the next page can be loaded quickly and I get a fluent experience on UI. <br /><br />

### *Used UIKit Components*
• CollectionView <br /><br />
• TableView <br /><br />
• UINavigationController <br /><br />
• UITabBarController <br /><br />
• Webkit <br /><br />
