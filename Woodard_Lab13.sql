/*Steven Woodard
5-Mar-19
Lab 13*/

/*#1*/
/*Assignment 1:  Create a view that lists the name and phone number of the contact person at each publisher. 
Don’t include the publisher’s ID in the view. Name the view CONTACT. */
CREATE OR REPLACE VIEW CONTACT AS SELECT contact, phone FROM publisher;

/*#2*/
/*Assignment 2: Change the CONTACT view so that no users can accidentally perform DML operations on the view*/
CREATE OR REPLACE VIEW CONTACT AS SELECT contact, phone FROM publisher WITH READ ONLY;

/*#3*/
/*Assignment 5: Create a view that lists the ISBN and title for each book in inventory along with the name and 
phone number of the person to contact if the book needs to be reordered. Name the view REORDERINFO. */
CREATE VIEW REORDERINFO AS SELECT b.isbn, b.title, p.contact, p.phone FROM books b, publisher p WHERE b.pubid = p.pubid;

/*#4*/
/*Assignment 6:  Try to change the name of a contact person in the REORDERINFO view to your name. 
Was an error message displayed when performing this step? If so, what was the cause of the error message?
*/
UPDATE reorderinfo SET contact = 'STEVEN WOODARD' WHERE contact = 'TOMMIE SEYMOUR';
/*it won't work because it is a non key-preserved table*/

/*#5*/
/*Assignment 8:  Delete the record in the REORDERINFO view containing your name. 
(If you weren’t able to perform #6 successfully, delete one of the contacts already listed in the table.) 
Was an error message displayed when performing this step? If so, what was the cause of the error message? */
DELETE reorderinfo WHERE contact = 'TOMMIE SEYMOUR';
/*It won't work because that record has a foreign key dependency. I can't delete something that is being referred to elsewhere.*/

/*#6 AND #7*/
/*Assignment 9 AND 10: 9) Issue a rollback command to undo any changes made with the preceding DML operations
 10) Delete the REORDERINFO view
*/
rollback;
DROP VIEW reorderinfo;