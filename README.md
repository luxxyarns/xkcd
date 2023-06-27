# AKCD - another xkcd comics browser

The following are the main 8 requirements

- R1: browse through the comics,
- R2: see the comic details, including its description,
- R3: search for comics by the comic number as well as text,
- R4: get the comic explanation
- R5: favorite the comics, which would be available offline too,
- R6: send comics to others,
- R7: get notifications when a new comic is published,
- R8: support multiple form factors.


Iteration 1 of the app is a first MVP draft

It contains the following user stories per requirement

R1: 
- user can initially see the first comic 
- user can proceed to next or previous comic if available

R2: 
- user is able to see title, comic number, max number of comics, creation date, image, alt text and transcript
- user can scroll and read the comic transcript
- user can click on a comic image to see it full screen

R3:
- user can navigate to a comic ID by entering the ID
- user can perform a text based search to see available matching comics and select one for display

R4: 
- user can read the full explanation page by navigating to safari

R5: 
- user can favorite a comic to read it later
- user can see all favorited comics
- user can remove a favorited comic
- user sees online / offline status in the top right corner of the browsing screen

R6:
- user can share a comic

R7: not part of MVP (no push backend to send notifications available yet)

R8:  
- user can use the app on the iphone in portrait mode
- user can use the app on the ipad in portrait or landscape mode (navigation area will be automatically available in landscape mode) 

 

Comments
+ code is structured in a way to group the various types of files (main views in views folder, other views in auxviews, the single model in the models folder)
+ the controller class performs is thought to abstract the network operations, but should be refactored soon
+ the manager class is a singleton to be used as an environment object across all main views to allow for some session management 

Some outstanding tasks could not be completed due to lacking time, but are very useful to do:
+ write more unit tests
+ add more comments - currently only limited comments
+ more logging (currently mostly error logging)
+ more detailed http response code behavior reactions (like timeout, etc)
+ possibly make output more generic to be based on layout class (compact, regular) instead of idiom type 
+ UX improvements could be e.g. adding swipes / animations instead of prev/next buttons

