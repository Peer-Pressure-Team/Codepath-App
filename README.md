Original App Design Project - README Template
===

# Peer Pressure

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Our app is going to be a social platform app that shares people's goals to have people support them and keep them accountable.

Keep yourself accountable in all of your habits by sharing them with others. Having the social pressure to finish your habits is all the motivation you need

Who said peer pressure is a bad thing?
We are the "PEER PRESSURE TEAM" now!!!

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social, Productivity, Lifestyle
- **Mobile:** Camera, real-time, location, push notifications
- **Story:** Form groups with similar goals and show progress
- **Market:** Huge market potential as people are looking for friends right now during Covid and would like to pursue their goals with other people to keep them on track and accountable. Link with social media platforms to share progress
- **Habit:** Push notifications sent from the system and other users in your group, user interactions "liking". Average user would use it depending on their habits 2-5+ times a week. Average user would both consume content of others habits as well as create their own to share. 
- **Scope:** It might be technically challenging to get a server to host a database of app's user content for realtime updates. Yes, a stripped down version would be useful for small groups of people who want to keep everyone in the group notified and on track of reacing their goals.
## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] Individual user's habit page/profile
- [x] Adjust habits in settings
- [x] Feed showing other people's status/habits
- [x] React to other people's progress

**Optional Nice-to-have Stories**

- [] Visually display habit progress
- [] Share on social media platforms
- [] Find users with similar goals
- [x] Search for groups or create a group
- [] Challenge other users to complete a goal or form a habit
- [] Privacy settings

### 2. Screen Archetypes

* Feed
   * Feed showing other people's habits
   * React to other people's progress
   * Visit a user's profile
* Individual profile
   * Individual user's habit page/profile
   * Adjust habits in settings
* Group page
   * React to other people's progress
   * Adjust group preferences in settings (how often to remind others..?)
* Explore
    * Shows all the available groups
    * Users can create new groups
    * Users can search for existing groups and join existing groups

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Feed
* Group page
* Individual profile

**Flow Navigation** (Screen to Screen)

* Individual profile
   * Display individual habits, groups, and progress
   * Individual settings
* Group page
   * Display group members and each person's progress
   * Group settings
* Feed
   * Add a comment or reaction(like), send a push notification, message, visit profiles

## Wireframes
[Add picture of your hand sketched wireframes in this section]
[Link to wireframe image](https://imgur.com/1nfvZnf)
[Link to figma] (https://www.figma.com/file/lU8u3Om4JEVqezgVsB6YdN/Qiru-Hu-s-team-library?node-id=0%3A1)

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

#### User
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | usertId       | String   | unique id for the user (default field) |
   | username      | String   | username |
   | image         | File     | user profile image |
   | location       | String   | location of the user |
   | publicity | Boolean   | public is true, private is false |
   | likesCount    | Number   | number of likes for the post |
   | posts     | Array of pointer to Status object | posts the user have made |
   | habbits     | Array of pointer to Habbits object | habbits the user have |
   | groups     | Array of pointer to Groups object | groups the user have joined |
   | friends     | Array of pointer to User object | the friends of the user |
 
#### Group
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | groupId       | String   | unique id for the group (default field) |
   | groupname      | String   | name of the group |
   | location       | String   | location of the group |
   | image         | File     | group profile image |
   | groupProgess  | Number     | the average progress of the group |
   | individualProgress     | Array of Status object | the progress of each group member |
   | habbits     | Array of pointer to Habbits object | habbits the group have |
   | members     | Array of pointer to User object | the members in the group |
   
   
#### Status
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the status object (default field) |
   | user        | Pointer to User| user |
   | progressUpdate       | String   | caption by author |
   | repliesCount | Number   | number of replies |
   | likesCount    | Number   | number of likes for the post |
   
#### Habbit
   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the habbit object (default field) |
   | habbitName        | String| the name of the habbit |
   | progressUpdate       | String   | caption by author |
   | goalCounts | Number   | number of times the user want to practice this habbit per week |
   | actualCount    | Number   | number of times the user actually practice this habbit per week |
   | lastUpdated     | DateTime | date when the user progress is last updated |
   | createdAt     | DateTime | date when the habbit is created |
   


### Networking
#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all status
         ```swift
         let query = PFQuery(className:"Post")
         query.whereKey("author", equalTo: currentUser)
         query.order(byDescending: "createdAt")
         query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error { 
               print(error.localizedDescription)
            } else if let posts = posts {
               print("Successfully retrieved \(posts.count) posts.")
           // TODO: Do something with posts...
            }
         }
         ```
      - (Create/POST) Create a new like on a status
      - (Delete) Delete existing like
      - (Create/POST) Create a new reply on a status
   - Progress Update Screen
      - (Create/POST) Create a new Status object
   - Individual Profile Screen
      - (Read/GET) Query the information of a user
      - (Update/PUT) Update the progress of the habbit
   - Individual Setting Screen
      - (Update/PUT) Update the user name
      - (Update/PUT) Update location
      - (Update/PUT) Update publicity
      - (Update/PUT) Update the profile image
      - (Read/GET) Query all status the user have posted
   - My Groups Screen
      - (Read/GET) Query all groups the user have joined
   - Group Details Screen
      - (Read/GET) Query the specific group the user clicked
   - Group Setting Screen
      - (Update/PUT) Update group profile image
      - (Update/PUT) Update group name
      - (Update/PUT) Delete group
      - (Update/PUT) Leave group (delete the user from Group.members and delete the group from User.groups)
      - (Read/GET) Query existing habbits
      - (Create/POST) Add a new Habbit object
  - Create Group Screen
        - (Create/POST) Create a new Group object
  - Explore Screen (Not done)
      - (Create/POST) Create a new post object

### Models
[Add table of models]
