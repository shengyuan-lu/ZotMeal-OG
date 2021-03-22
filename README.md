# ZotMeal - Version 1.0

## Inspiration
UCI has two main dining halls that withstand a huge volume of student capacity. However, the dining hall service adopts a rather traditional method for its communication with students: a website. We decided to facilitate this process by integrating the web information from the dining hall website into an app: ZotMeal, and supply additional features to further optimize the user experience.

## What it does
ZotMeal obtains a daily menu from the web and then displays it in a friendly user-interface. Both Brandywine and Anteatery’s menu is included with the most up-to-date information! Dining hall service hours can also be found in the app. Moreover, users are able to do a quick Google search on the food simply by clicking the menu. More features yet to come...

## How we built it
The project is comprised of two major components:

## IOS App Development: 
Multiple view controllers are used to manage the interactions between the user interface and the underlying data. JSON protocol is used to parse incoming raw data. We used Sketch for design-related tasks, such as making the app icon.

## Web Data Management: 
A Python script is used to scrape data from the web. The data is stored in a private server and then transferred to the app interface via a customized API.

## Challenges we ran into
Figuring out a proper data management mechanism on a third party server that can automatically update the menu information then storing it in the cloud.
Integrating more detailed information about the meal itself. Loading app data when the user is offline.

## Accompaniments that we’re proud of
The app is able to acquire live information from the private server then update the menu.
Animation is integrated into the user interface for a better UX experience.
Google search is implemented to familiarize the users with the dining options.

## What we learned
The team experimented with multiple methods to implement the data transmission from the back end to the iOS app. During this process, we honed our programming and development skills. Web scraping techniques are significant in this project and cloud data management became crucial in connecting the web application to the IOS environment.

## What’s next for ZotMeal
We aim to add more user-friendly features, such as notifications and widgets. Data management will be transferred from the current private server to Google Cloud Computing Platform for dynamic updating and better data security.

## Time Spent
Time spent: **24** hours spent in total

## User Stories

- [x] User can receive a list of menus from the Web API.
- [x] User can pull to refresh.
- [x] When the API connection failed, a sample menu is displayed.
- [x] The app covers both Brandywine and Anteatery menus.
- [x] User can get dining hall hours from the app.
- [x] User can tap on a food cell and get a custom google search about the food.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='https://i.imgur.com/i0f7Lgi.gif' width=500 />
