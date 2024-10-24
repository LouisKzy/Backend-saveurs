# Ruby On Rails + PostgreSQL

### Make sure you have Ruby and Rails, installed on your system.
To use all the features you will need a MailJet acount, Stripe account and an AWS account with S3

Don't forget to save all your keys in an .env file

## Version
* Ruby version: 3.2.2
* Rails version: 7.1.3.2


## Configuration
* Configure the PostgreSQL database in the ```database.yml``` file.
* In the ```serveur``` folder, execute ```bundle install``` to install necessary gems.
* Create and migrate the database by running  ```rails db:create``` and ```rails db:migrate```.
* Start the backend server by running ```rails server```.
* The application runs by default on the localhost URL ```http://localhost:3000```.

