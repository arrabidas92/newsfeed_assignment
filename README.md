### Summary
Create an iOS App to display a news feed.
### High-level requirements:
1. Use the data from the json file:
https://saurav.tech/NewsAPI/everything/cnn.json
2. Use UICollectionViewCompositionalLayout to present the
feed.
3. The top section of the feed should have horizontal scroll
direction. This component should show news with their titles
and images. (Latest 6 news from json file)
4. The bottom section of the feed should have vertical scroll
direction. This component should show all news with their
titles, dates, images and full descriptions.

### Details:
1. Load data using URLSession and Combine. Use Codable to
decode the data.
2. App should only support vertical orientation.
3. Use UIKit and MVVM architecture.
4. Display loading indicator for async tasks.
