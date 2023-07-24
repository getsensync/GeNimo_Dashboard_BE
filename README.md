# Genimo Server (BE)
A  web server that provide APIs for GeNimo project, built with Express JS and PostgreSQL. This project is used to utilize business process in Nimo Highland.

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

Note : You should install Node.Js and PostgreSQL before run this server
```bash
# Clone this project
git clone https://github.com/getsensync/GeNimo_Dashboard_BE

-- Dependencies Installation
# Cd to 'GeNimo_Dashboard_BE' Folder
cd "GeNimo_Dashboard_BE"
# Install Depencies Using Node
npm install

### -> { GO TO Database Setup, before continue } <- ###

-- Development Mode
# Start Web App Development Mode
npm run dev

-- Build Mode (Not needed, Using CI/CD instead)
# Build Wep App
npm build
```

## Database Setup & Migration

Note : You should install Node.Js and PostgreSQL. Use PgAdmin/ DBeaver for Database GUI (Best Practice)
```bash
-- Database Setup
# 1. Make New Connection of PostgreSQL
# 2. Set User = postgres
# 3. Set Password = root
# 4. Set Port = 5432
# 5. Set Host = localhost
# 6. Make New Database, Name = genimo_db
# 7. Run db-migrate for initialization
command : db-migrate up init

-- Database Migration
# Used when there is any change in database
# 1. Check 'Migrations' folder
# 2. Find latest sql file with format {timestamp}-{name}.sql
# 3. Run db-migrate for latest file
command : db-migrate up {name}
```

## Directory sturcture code

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
│     └─ 20230724203611-insertData-up.sql
├─ package-lock.json
├─ package.json
├─ server.js
└─ utils
   └─ database.js

```