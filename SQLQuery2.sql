--DDL
--category Table
create table CrimeCategory(
CategoryID int primary key , 
categoryName nchar(255) 
)
-- Criminal Table
CREATE TABLE Criminal (
    CriminalID INT PRIMARY KEY,
    Name VARCHAR(255),
    Address VARCHAR(255)
);

-- Victim Table
CREATE TABLE Victim (
    VictimID INT PRIMARY KEY,
    VictimName VARCHAR(255)
);

-- Location Table
CREATE TABLE Location (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(255),
    Address VARCHAR(255)
);
-- Report Table
CREATE TABLE Report (
    ReportID INT PRIMARY KEY,
    CrimeActivity TEXT,
    RDate DATE,
    CategoryID INT,
    LocationID INT,
    FOREIGN KEY (CategoryID) REFERENCES CrimeCategory(CategoryID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);

-- CrimeCriminals Table (Many-to-Many)
CREATE TABLE CrimeCriminals (
    ReportID INT,
    CriminalID INT,
    PRIMARY KEY (ReportID, CriminalID),
    FOREIGN KEY (ReportID) REFERENCES Report(ReportID),
    FOREIGN KEY (CriminalID) REFERENCES Criminal(CriminalID)
);

-- CrimeVictims Table (Many-to-Many)
CREATE TABLE CrimeVictims (
    ReportID INT,
    VictimID INT,
    PRIMARY KEY (ReportID, VictimID),
    FOREIGN KEY (ReportID) REFERENCES Report(ReportID),
    FOREIGN KEY (VictimID) REFERENCES Victim(VictimID)
);
--DML
INSERT INTO Criminal (CriminalID, Name, Address) VALUES
(1, 'Ali Hassan', 'Cairo'),
(2, 'Mohamed Salah', 'Giza'),
(3, 'Omar Khaled', 'Alexandria'),
(4, 'Youssef Adel', 'Mansoura');

INSERT INTO Victim(VictimID,VictimName) VALUES
(1,'AHMED FATHY'),
(2, 'Fatma Ibrahim'),
(3, 'Mona Khaled'),
(4, 'Mostafa Hassan');

INSERT INTO Location (LocationID, LocationName, Address) VALUES
(1, 'Downtown Cairo', 'Tahrir Square, Cairo'),
(2, 'Giza Zoo Area', 'Giza Street, Giza'),
(3, 'Stanley Bridge', 'Corniche, Alexandria'),
(4, 'City Center', 'Mansoura, Dakahlia');

INSERT INTO CrimeCategory (CategoryID, CategoryName) VALUES
(1, 'Theft'),
(2, 'Drugs'),
(3, 'Murder'),
(4, 'Fraud');

INSERT INTO Report (ReportID, CrimeActivity, RDate, CategoryID, LocationID) VALUES
(101, 'Armed robbery at a jewelry store.', '2025-03-15', 1, 1),
(102, 'Drug trafficking busted in an apartment.', '2025-03-20', 2, 2),
(103, 'Murder of a government official.', '2025-03-25', 3, 3),
(104, 'Major fraud in real estate deals.', '2025-03-28', 4, 4),
(105, 'Attempted bank theft.', '2025-04-01', 1, 1),
(106, 'Large drug smuggling operation.', '2025-04-05', 2, 3);

INSERT INTO Report (ReportID, RDate, CategoryID, LocationID) VALUES
(108,  '2024-01-2', 4, 2),
(109, '2025-02-18', 1, 1);
INSERT INTO Report (ReportID) VALUES
(108),
(109);
INSERT INTO CrimeCriminals (ReportID, CriminalID) VALUES
(101, 1),
(101, 2),
(102, 3),
(103, 2),
(103, 4),
(104, 1),
(104, 3),
(105, 2),
(105, 3),
(106, 4),
(106, 1);
INSERT INTO CrimeVictims (ReportID, VictimID) VALUES
(101, 1),
(101, 2),
(103, 3),
(104, 4),
(105, 1),
(106, 2);
INSERT INTO Victim(VictimID,VictimName) VALUES(5,'mai mohamed'),(6,'salah abaas');
--DQL
-- 1. Display the name of the Criminals who performed the same crime category more than three times.
SELECT c.Name, cc.CategoryName, COUNT(*) AS CrimeCount
FROM Criminal c
JOIN CrimeCriminals ccj ON c.CriminalID = ccj.CriminalID
JOIN Report r ON ccj.ReportID = r.ReportID
JOIN CrimeCategory cc ON r.CategoryID = cc.CategoryID
GROUP BY c.CriminalID, cc.CategoryID
HAVING COUNT(*) > 3;



-- 3. Most frequent crime category.
SELECT top 1 cc.CategoryName, COUNT(*) AS CrimeCount
FROM Report r
JOIN CrimeCategory cc ON r.CategoryID = cc.CategoryID
GROUP BY cc.categoryName
ORDER BY CrimeCount ASC


-- 4. Total number of crimes in each category last year.
SELECT cc.CategoryName, COUNT(*) AS CrimeCount
FROM Report r
JOIN CrimeCategory cc ON r.CategoryID = cc.CategoryID
WHERE EXTRACT(YEAR FROM r.RDate) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
GROUP BY cc.CategoryID;

-- 5. Total number of crimes for each Criminal.
SELECT c.CriminalID, c.Name, COUNT(DISTINCT ccj.ReportID) AS TotalCrimes
FROM Criminal c
JOIN CrimeCriminals ccj ON c.CriminalID = ccj.CriminalID
GROUP BY c.CriminalID;

-- 6. Details of the Criminal who performed the maximum number of crimes.
SELECT c.*
FROM Criminal c
JOIN (
    SELECT CriminalID, COUNT(*) AS CrimeCount
    FROM CrimeCriminals
    GROUP BY CriminalID
    ORDER BY CrimeCount DESC
    LIMIT 1
) max_c ON c.CriminalID = max_c.CriminalID;

-- 7. Locations of drug-related crimes.
SELECT DISTINCT l.LocationName
FROM Report r
JOIN CrimeCategory cc ON r.CategoryID = cc.CategoryID
JOIN Location l ON r.LocationID = l.LocationID
WHERE cc.CategoryName = 'drugs';

-- 8. Criminals who performed more than two crimes from different categories.
SELECT c.CriminalID, c.Name, COUNT(DISTINCT r.CategoryID) AS DifferentCategories
FROM Criminal c
JOIN CrimeCriminals ccj ON c.CriminalID = ccj.CriminalID
JOIN Report r ON ccj.ReportID = r.ReportID
GROUP BY c.CriminalID
HAVING COUNT(DISTINCT r.CategoryID) > 2;

-- 9. Crime performed by the maximum number of Criminals.
SELECT r.ReportID, COUNT(ccj.CriminalID) AS NumCriminals
FROM Report r
JOIN CrimeCriminals ccj ON r.ReportID = ccj.ReportID
GROUP BY r.ReportID
ORDER BY NumCriminals DESC

-- 10. Crimes performed by only one Criminal.
SELECT r.ReportID, cc.CategoryName AS CrimeType, ccj.CriminalID, r.RDate
FROM Report r
JOIN CrimeCategory cc ON r.CategoryID = cc.CategoryID
JOIN CrimeCriminals ccj ON r.ReportID = ccj.ReportID
WHERE r.ReportID IN (
    SELECT ReportID
    FROM CrimeCriminals
    GROUP BY ReportID
    HAVING COUNT(CriminalID) = 1
);


