CVR App - How to manage data on Firebase
----------------------------------------------------------------------------

Getting to the database:
From the Firebase console (https://console.firebase.google.com/) select 'CVR
App' and then 'Database' located top left. This will be the only window you
ever need.
----------------------------------------------------------------------------

EVENTS:
To add a new event: 
1. Select either 'meetings' or 'seminars' in the first column. 
2. At the top of the second column click on 'Add document'.
3. Here you can leave the Document ID blank and then fill out the necessary
   fields.  

Fields are case sensitive and must not end in any spaces. For seminars and 
meetings there are 6 possible fields:

title
speaker
building
room
url
time

You can provide both a title and speaker or just one of the two. The time 
field must be created and then either building and room if it's an in person
event, or just url if it's an online event. 

4. Enter one of the fields into the Filed box, ensure it's Type is correct
   and then enter it's value. All fields, except the time field, should 
   be of type 'string'. The time field type should instead be 'timestamp'.
   Click the + button below to add more fields and repeat as necessary.

   Once saved you can edit any of the values by double clicking or clicking
   on the edit button. However, you can not edit any of the fields. If you
   make a typo with one of the field names you should delete the entire
   document by clicking on the three dots in the top right of the *third*
   column. 

Deleting events:
After an event has passed it will no longer appear on the app, but it will
remain in the database. It is not necessary to delete it from the database,
but it is recommended that old events get deleted every so often to prevent
the app from slowing down. For example after a break where there are no
upcoming events in the database.

If there are no upcoming events in the database you can quickly remove all
old events as follows (Note that the following only applies for seminars and
meetings and not other categories):
1. At the top of the second column, beside the header seminars or meetings,
   click the three dots and then delete collection. 
2. At the top of the first column click Add collection and then set the
   collection ID to whatever you just deleted. Either 'seminars' or 
   'meetings'. Ensure that it's spelt exactly as shown.
----------------------------------------------------------------------------
