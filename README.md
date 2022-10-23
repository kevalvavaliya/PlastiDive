## 💡Inspiration
We live in a beautiful City in India. Our country is surrounded by the Indian Ocean, the Indian ocean has an exceptionally rich marine diversity. the total number of marine species known to us is about 240,000 species. One of the biggest threats to this diverse marine life is plastic pollution. Over 8 Million tons of plastic are dumped in the world's oceans every year.
We have made a game to spread awareness, inspire and help eliminate plastic.

## ⚙ What it does
Our app "plastidive" is built with features:

Click some polluted photos of the beach, the app will upload them to the server.
YOLO model will determine the level of plastic and show it up on the map for help from society.
Virtuous will help clean the place and upload the photo.
YOLO model will check if the beach is clean or not and will reward virtuous with virtual currency.

## 🛠 How we built it

We have used YOLOv5(compound-scaled object detection model) to get the best accuracy and trained it with 1800 data samples and hosted it with the flask server to communicate with the client device and give the client minimum computing load as we wanted It to be accessible to all the devices.

Our flutter front-end communicates with the flask backend which will identify the plastic waste, and manage other data like coordinates in the map, Images on the blob storage, and user data.

## 💪 Challenges we ran into

- The biggest challenge was to host the backend as replit was not working with this python-OpenCV, so we had to figure it out and at last, we hosted it using apache, it was a bit overwhelming to write configuration files from scratch and made it accessible over the internet.
- We faced some issues in maps as flutter is a new framework and finding all the solutions are bit difficult compared to other frameworks as lots of packages in flutter are not updated and face null safety issues.

## 📌 Accomplishments that we're proud of

- We were able to bring some awareness with these games and social messages.
- Being able to make the object detection API work correctly so that it could identify trash.
- integrating object detection with the flutter app.

## What we learned
- We learned about YOLOv5
- It was the first time we used apache from scratch and exposed an application to the internet.
- Using object detection with a web service.

## What's next for plastidive
- improving UI/UX and increasing user engagement by introducing the NFT as reward.
- We aim to create more interactive and educational games, with more levels and different functions to increase the quality of our games.
