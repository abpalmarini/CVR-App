# CVR App - How to manage data on Firebase

----------------------------------------------------------------------------

Warning:
This is a realtime database so any changes you make will be immediately
updated in the app. There is also no way to undo mistakes, so please be careful
with any changes you make. If you have any questions you can email me:
alessandro.palmarini1@gmail.com

Getting to the database:
From the Firebase console (https://console.firebase.google.com/) select 'CVR
App' and then 'Database' located top left. This will be the only window you
ever need.

----------------------------------------------------------------------------

## EVENTS
To add a new event: 
1. Select either 'meetings' or 'seminars' in the first column. 
2. At the top of the second column click on 'Add document'.
3. Here you can leave the Document ID blank and then fill out the necessary
   fields.  

Fields are case sensitive and must not end in any spaces. For seminars and 
meetings there are 6 possible fields:

- title
- speaker
- building
- room
- url
- time

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
   column when under the meetings or seminars section. 

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

## CATEGORIES
All other categories have the same layout structure. The only difference between
them is their location and their individual fields. 

Searching:
If you ever want to find a specific entry navigate to the correct section and then
you can use cmd+f on mac or ctrl+f on windows to find it.

Adding an entry:
I will go over an example of how to add someone to the 'Useful Contacts' section
of the app, but the same applies for adding an entry to any other category below. 

1. Navigate to the correct header. (For the Useful Contacts case you would select
   'categories' in the first column, then 'contacts' in the second column).
2. Find the correct subset (for Useful Contacts this would be 'Key') and
   click on the + sign beside the subset header. You should see the word 'array'
   in brackets to the left of the +.
3. Beside the entry number change the type from 'string' to 'map'. 
4. Enter the correct field names and their corresponding values. See below for
   the correct fields for each section. All types for individual fields should be
   left as the default type string. (For Useful Contacts we would add the fields
   'name' and 'role').

Deleting an entry:
You should never delete the main fields such as Key and People under contacts,
but you can delete individual entries for any section.

Simply click on the delete icon beside the entry number you want to delete. You
should see the word 'map' in brackets to the left.

Editing an entry:
You can edit the value of any field for an individual entry (as in any field
below an entry number) by double clicking or clicking on the edit icon.

----------------------------------------------------------------------------

## Contacts

categories -> contacts -> Key
                       |
                       -> People

Fields for a Key entry:
- name
- role

Fields for a People entry:
- firstname
- surname
- email
- building
- room
- telephone

*When entering a telephone number, enter only the last 4 digits. If entering
2 numbers then seperate them by a forward slash (/)*

----------------------------------------------------------------------------

## Equipment

categories -> equipment -> Flow Cytometry
                        |
                        -> General
                        |
                        -> Imaging
                        |
                        -> Molecular Purification & Quantitation
                        |
                        -> Next Generation Sequencing

Fields for all equipment subset entries:
- name
- application
- building
- room
- booking
- charges
- curator
- extension
- curator2 (only if applicable)
- extension2 (only if applicable)

*When entering an extension number, enter only the last 4 digits and unlike
the people section, only enter one number*

----------------------------------------------------------------------------

## Forms

categories -> links -> Forms

Fields for a Forms entry:
- form
- url

----------------------------------------------------------------------------
