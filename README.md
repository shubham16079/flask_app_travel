
Introduction
Welcome to the Travel Website Flask project! This application is designed to provide a travel website experience with both frontend and backend functionalities. The backend offers an admin interface accessible at 127.0.0.1:5000/admin, where you can log in using the provided credentials (username: admin@gmail.com, password: password). The frontend includes common search functionalities for destinations and experiences, along with categorized data.

Getting Started
Prerequisites
Python installed on your machine
MySQL database
travel_new.sql file (located in the root directory) to be imported into the MySQL database

Clone the repository to your local machine.
git clone https://github.com/shubham16079/flask_app_travel.git

Navigate to the project directory.

Create a virtual environment (optional but recommended).
python -m venv venv

Activate the virtual environment.

On Windows: venv\Scripts\activate
On macOS/Linux: source venv/bin/activate

Install project dependencies
pip install -r requirements.txt

Make sure you have a MySQL server running.
Create a new database in MySQL.
Import the travel_new.sql file into the newly created database 

Configuration

If you wish to change the database name or other configurations, modify the config.py file in the root directory.

Running the Application
To start the application, run the following command:
python run.py

Admin Interface
Access the admin interface at http://127.0.0.1:5000/admin with the provided credentials:

Username: admin@gmail.com
Password: password

Frontend Features
Explore the frontend for common search functionalities related to destinations and experiences. Discover categorized data for a rich user experience.

Contributing
Feel free to contribute to this project by submitting issues or pull requests. Your feedback and contributions are highly appreciated.

Enjoy your travel website experience with Flask!