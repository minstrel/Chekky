# Chekky the Checklist

A basic checklist app.  Not meant for groceries, but for work-related task
lists that need to be archived and not deleted after they're created.
Items are added to the to-do list, checked off and moved to the completed list.
The completed tab displays the most recent 50 by default and allows clicking
the checkbox to put them back on to-do.

Like my other stuff, I'd like to make this generic so you can type in a couple
Rake tasks and have whatever fields you like populated.

For now, if someone likes this and wants to use it, I recommend creating a new
migration with the fields you want.  Then go through the views (and
views/layout) and controller and replacing as needed.

## Get it Running with Docker
(Assumes you have docker running and familiar with running containers)

1. Clone the repo.

2. Modify the database.sh file and add you database password.  Do the same for
config/database.yml.

3. Run database.sh to create the database container.

4. Create your application container, replacing "my-\*" with your naming
conventions:

       docker build -t my-repository/my-app-image:my-version .

5. Run the container, linking it to the database:

       docker run -d --name my-app-container --link
       checklist_database:checklist_datbase -P my-repository/my-app-image:my-version
