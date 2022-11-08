Original App Design Project - README
===

# Books!

## Table of Contents
1. [Overview](#Overview)
3. [Product Spec](#Product-Spec)
4. [Wireframes](#Wireframes)
5. [Schema](#Schema)

## Overview
### Description
Users can scroll through trending/new books on the homepage and be able to select a book to get general details about it as well as ratings from other people. Users have their own profile to save book titles and add friends who also use the app!

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Books
- **Mobile:** iOS, but could possibly develop into a functional website.
- **Story:** Users can keep track of book titles they want to read and be able to get information about it. Users can also use the book's discussion board and talk to other people.
- **Market:** People of all ages can enjoy this app. People who love to read will find this very helpful as well.
- **Habit:** Users can use the app frequently to get latest updates on trending books. Users can use the app whenever they feel like discussing about a book they've read.
- **Scope:** This started off as a way for Users to track books they are interested in and get general info/ratings on the book. But can eventually become a social app to friend and engage with other people who love books and have similar interests.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can log in
- [x] User can scroll through trending books page
- [x] User can search for specific book titles
- [x] User can select book to get more information
- [x] User can view book information and ratings
- [x] User can save book titles
- [x] User can navigate between tabs in tab bar
- [x] User can view profile
- [x] User can view saved book titles list
- [ ] User can view Book's discussion board

**Optional Nice-to-have Stories**

- [x] User can sign up
* User can add friends
* User can message friends
* User can edit their saved list
* User can add books to a "Have Read" list
- [x] User can have access to settings

### 2. Screen Archetypes

* **Login Screen**
   * User can log in
* **Homepage Screen**
   * User can scroll through trending books page
   * User can select book to get more information
* **Book Details Screen**
   * User can save book titles
   * User can view book information and ratings
   * User can view book's discussion board
* **Search Screen**
   * User can search for specific book titles
* Library Screen
   * User can view saved book titles list
   * User can add books to a "Have Read" list
* **Profile Screen**
   * User can view profile

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Homepage
* Search
* Library
* Profile

**Flow Navigation** (Screen to Screen)

* Login Screen
   * => Homepage
* Homepage Screen
   * => Book Details Screen, once you click on a book cell
* Search Screen
   * => Book Details Screen
* Profile Screen
   * => Settings Screen, this is implements later as bonus

## Wireframes
<img src="https://i.imgur.com/NonZiYn.jpg" width=500>

### [BONUS] Digital Wireframes & Mockups

<img src="https://i.imgur.com/fzR6YJt.png" width=800>

### [BONUS] Interactive Prototype

## Schema 
### Models
#### Book

   | Property            | Type     | Description |
   | ------------------- | -------- | ------------|
   | bookId              | String   | unique id for the book (default field) |
   | authorName          | String   | author of book |
   | bookCoverImage      | File     | image of book cover |
   | bookTitle           | String   | title of the book |
   | bookDescriptionText | String   | book synopsis |
   | recommendationsCount| Int      | number of people recommending the book |
   | yearOfRelease       | Int      | year the book was released |
   | bookGenre           | String   | genre of the book |
   
#### User

   | Property      | Type           | Description |
   | ------------- | --------       | ------------|
   | usernameId    | String         | unique id for the user's account (default field) |
   | userEmail     | String         | email linked to user's account |
   | password      | String         | user's password |
   | profileImage  | File           | profile image for user |
   | userBio       | String         | bio desription of user |
   | commentsCount | Int            | number of comments that has been posted by user |
   | friendsCount  | Int            | number of likes for the post |
   | groupCount    | Int            | number of groups that user is in |
   
### Networking
 - Saved Books Screen: queries all book titles saved by user
```swift
        let query = PFQuery(className:"Books")
        query.whereKey("user", equalTo: user)
        
        query.findObjectsInBackground { (myBooks, error) in
            if myBooks != nil {
                self.myBooks = myBooks!
                self.myBooksCollectionView.reloadData()
            }
        }
```

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]

Sprint 1 - GIF Walkthrough

![](http://g.recordit.co/JAW2WuTVxC.gif)
