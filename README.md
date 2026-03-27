# police_database
# Crime Management Database System

## 📋 Project Description

This is a relational database project designed to manage criminal records, including crimes, criminals, victims, and crime locations. The system tracks detailed crime reports and establishes relationships between reports, criminals, and victims.

The database supports many-to-many relationships and includes analytical queries for crime statistics and patterns.

## 🗃️ Database Structure (DDL)

### Main Tables:
- **CrimeCategory** — Crime types (Theft, Drugs, Murder, Fraud, etc.)
- **Criminal** — Information about criminals
- **Victim** — Information about victims
- **Location** — Geographical locations of crimes
- **Report** — Crime reports (activity description, date, category, location)
- **CrimeCriminals** — Junction table linking reports to multiple criminals
- **CrimeVictims** — Junction table linking reports to multiple victims

## 📥 Sample Data (DML)

The project includes sample data for:
- 4 criminals
- 6 victims
- 4 locations
- 4 crime categories
- Multiple crime reports (theft, drug trafficking, murder, fraud)

## 🔍 Analytical Queries (DQL)

The project contains 10 important SQL queries, including:

1. Names of criminals who committed the same crime category more than three times
2. Most frequent crime category
3. Total number of crimes in each category during the previous year
4. Total number of crimes committed by each criminal
5. Details of the criminal who committed the highest number of crimes
6. Locations where drug-related crimes occurred
7. Criminals who committed crimes from more than two different categories
8. Crime report involving the largest number of criminals
9. Crimes committed by only one criminal
10. Additional analytical insights

## 🚀 How to Use

1. Create a new database in **SQL Server** (or any compatible RDBMS)
2. Execute the **DDL** scripts to create all tables and relationships
3. Run the **DML** scripts to insert sample data
4. Test the **DQL** queries for analysis

## 📌 Notes

- Some fields use `nchar(255)` to properly support Arabic text
- Foreign key constraints ensure data integrity
- The design is flexible and can be extended with more features
- A few queries may need minor adjustments depending on the database system (e.g., `TOP 1` vs `LIMIT`)

## 👩‍💻 Author

**Fatma**
