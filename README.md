# Genimo Server (BE)
A  web server that provides APIs for the GeNimo project, built with Express JS and PostgreSQL. This project is used to utilize business processes in Nimo Highland.

### Stack
- Express JS
- PostgreSQL

### Features
Provides APIs for :  
1.  Overviewing Sales (Dashboard)
2.  CRUD Customers
3.  CRUD Spots
4.  Read Activity (Logs)
5.  Trigger Reader (bracelet scanner)
6.  User Authentication and Authorization
7.  Account Management 

## Deployed Server
-  Using GCDP 
or
-  Local PC Server at Nimo Highland

## Installation

Note : You should install Node.Js and PostgreSQL before running this server
```bash
# Clone this project
git clone https://github.com/getsensync/GeNimo_Dashboard_BE

-- Dependencies Installation
# Cd to 'GeNimo_Dashboard_BE' Folder
cd "GeNimo_Dashboard_BE"
# Install Dependencies Using Node
npm install

### -> { GO TO Database Setup, before continuing} <- ###

-- Development Mode
# Start Web App Development Mode
npm run dev

-- Build Mode (Not needed, Using CI/CD instead)
# Build Web App
npm build
```

## Database Setup & Migration

Note : You should install Node.Js and PostgreSQL. Use PgAdmin/ DBeaver for Database GUI (Best Practice)
```bash
-- Database Setup
# 1. Make a New Connection of PostgreSQL
# 2. Set User = postgres
# 3. Set Password = root
# 4. Set Port = 5432
# 5. Set Host = localhost
# 6. Make New Database, Name = genimo_db
# 7. Run db-migrate for initialization
command : db-migrate up init

-- Database Migration
# Used when there is any change in the database
# 1. Check the 'Migrations' folder
# 2. Find the latest sql file with format {timestamp}-{name}.js
example : 20230725-insertData.js
# 3. Run db-migrate for the latest file
command : db-migrate up {name}

-- Customize PostgreSQL settings in Server
## There are 2 files that should be modified
# 1. database.json
{
   "dev": {
      "driver": "pg",
       "user": {your user},
       "password": {your password},
       "host": "localhost",
       "database": "genimo_db"
   }
}
# 2. .env (dotenv)
DB_HOST = "localhost"
DB_USER = {your user}
DB_PASS = {your password}
DB_NAME = "genimo_db"
DB_PORT = 5432
```

## Directory structure code

```
GeNimo_Dashboard_BE
├─ .env
├─ .git
├─ .gitignore
├─ database.json
├─ migrations
│  ├─ 20230724182637-init.js
│  ├─ 20230724203611-insertData.js
│  └─ sqls
│     ├─ 20230724182637-init-down.sql
│     ├─ 20230724182637-init-up.sql
│     ├─ 20230724203611-insertData-down.sql
│     ├─ 20230724203611-insertData-up.sql
│     └─ ...
├─ package-lock.json
├─ package.json
├─ server.js
└─ utils
   └─ database.js

```
