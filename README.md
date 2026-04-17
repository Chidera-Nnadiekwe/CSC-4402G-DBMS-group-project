# International Trade Relations Database (ITRD)
CSC 4402G — Database Systems | Group 6 | LSU

A relational database application for analyzing international trade data, including trade flows, tariffs, sanctions, and trade agreements across 101 countries.

---

## Prerequisites

- [MySQL](https://dev.mysql.com/downloads/mysql/) (Community Server)
- [Node.js](https://nodejs.org/) v18 or higher
- [DBeaver](https://dbeaver.io/) (optional, for browsing the database)

---

## 1. Set Up the Database

1. Open **DBeaver** and connect to your MySQL server (`localhost`, port `3306`)
2. Create a new database called `itrd`
3. Right-click `itrd` → **SQL Editor > New SQL Script**
4. Open `sql_codes/GROUP_6_DBMS_SCHEMA.sql`, copy all, paste and run with `Alt+X`
5. Open `sql_codes/GROUP_6_DBMS_INSERT_STATEMENTS.sql`, copy all, paste and run with `Alt+X`
6. Open `sql_codes/GROUP_6_DBMS_USEFUL_VIEWS.sql`, copy all, paste and run with `Alt+X`

Verify the data loaded correctly:
```sql
SELECT COUNT(*) FROM regions;          -- 10
SELECT COUNT(*) FROM countries;        -- 101
SELECT COUNT(*) FROM products;         -- 50
SELECT COUNT(*) FROM trade_agreements; -- 15
SELECT COUNT(*) FROM trade_flows;      -- 50
```

---

## 2. Configure the Backend

1. Navigate to the `backend` folder:
   ```bash
   cd backend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Edit the `.env` file and set your MySQL password:
   ```
   DB_HOST=localhost
   DB_USER=root
   DB_PASSWORD=your_password_here
   DB_NAME=itrd
   PORT=3001
   ```
4. Start the backend server:
   ```bash
   node server.js
   ```
   You should see:
   ```
   ITRD Backend running on http://localhost:3001
   ```
5. Test it by visiting: `http://localhost:3001/api/health`

---

## 3. Run the Frontend

Open a **new terminal**, then:

1. Navigate to the `frontend` folder:
   ```bash
   cd frontend
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   npm run dev
   ```
4. Open your browser and go to: `http://localhost:5173`

---

## Usage

- **Blue countries** on the map are in the database — click them to explore
- **Yellow** = currently selected country
- The right panel shows three tabs:
  - **Trade** — bilateral trade flows for the selected country
  - **Balance** — trade surplus/deficit by year
  - **Sanctions** — active and historical sanctions

---

## Project Structure

```
CSC-4402G-DBMS-group-project/
├── sql_codes/
│   ├── GROUP_6_DBMS_SCHEMA.sql              # Table definitions
│   ├── GROUP_6_DBMS_INSERT_STATEMENTS.sql   # All data (101 countries, 50 products)
│   ├── GROUP_6_DBMS_USEFUL_VIEWS.sql        # 3 analytical views
│   └── GROUP_6_DBMS_TRADE_QUERIES.sql       # 15 SELECT + 5 UPDATE queries
├── backend/
│   ├── db/connection.js                     # MySQL connection pool
│   ├── routes/countries.js                  # Country API endpoints
│   ├── routes/trade.js                      # Trade API endpoints
│   ├── server.js                            # Express server
│   └── .env                                 # DB credentials (not committed)
├── frontend/
│   ├── src/
│   │   ├── components/WorldMap.jsx          # Interactive world map
│   │   ├── components/CountryPanel.jsx      # Country detail panel
│   │   ├── services/api.js                  # API calls
│   │   └── App.jsx                          # Main app
│   └── vite.config.js
├── GROUP_6_DBMS_E-R_SCHEMA.mermaid          # E-R diagram
└── README.md
```

---

## Group 6 Members

Bryce Shifflett, Chidera C. Nnadiekwe, Jacob Pham, Iago T. Nonaka,
Carlos Rodriguez Coronel, Michael Brennan, Jonathan Heber, Abdul Mutaal,
Isaac Humphries, Jacob Atkinson, Parker Ryan

**Course:** CSC 4402 — Database Systems | **Instructor:** Dr. Jianhua Chen | **LSU**
