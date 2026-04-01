/* 
Assignment 1: SQL Queries
Student: Darrah Borinaga
Database: Chinook (SQLite)
*/

/* =========================
   Problem 1: Single Table
   ========================= */

-- 1a: Customer full name, company, city, state ordered by city
SELECT
  FirstName || ' ' || LastName AS FullName,
  Company,
  City,
  State
FROM Customers
ORDER BY City;

-- 1b: Customers from Canada or the United States
SELECT
  FirstName || ' ' || LastName AS FullName,
  Company,
  City,
  State
FROM Customers
WHERE Country IN ('Canada', 'USA')
ORDER BY City;

-- 1c: Customers from Canada or USA with last name starting with 'M'
SELECT
  FirstName || ' ' || LastName AS FullName,
  Company,
  City,
  State
FROM Customers
WHERE Country IN ('Canada', 'USA')
  AND LastName LIKE 'M%'
ORDER BY City;


/* =========================
   Problem 2: Joining Tables
   ========================= */

-- 2a: Artist, album, and track names
SELECT
  ar.Name  AS ArtistName,
  al.Title AS AlbumTitle,
  t.Name   AS TrackName
FROM Artists ar
JOIN Albums al ON al.ArtistId = ar.ArtistId
JOIN Tracks t  ON t.AlbumId  = al.AlbumId
ORDER BY ar.Name;

-- 2b: Tracks containing the word 'dancing'
SELECT
  ar.Name  AS ArtistName,
  al.Title AS AlbumTitle,
  t.Name   AS TrackName
FROM Artists ar
JOIN Albums al ON al.ArtistId = ar.ArtistId
JOIN Tracks t  ON t.AlbumId  = al.AlbumId
WHERE LOWER(t.Name) LIKE '%dancing%'
ORDER BY ar.Name;

-- 2c: Employee and their manager
SELECT
  e.FirstName || ' ' || e.LastName AS Employee,
  m.FirstName || ' ' || m.LastName AS Manager
FROM Employees e
JOIN Employees m ON e.ReportsTo = m.EmployeeId
ORDER BY Employee;

-- 2d: Include General Manager reporting to himself
SELECT
  e.FirstName || ' ' || e.LastName AS Employee,
  COALESCE(m.FirstName || ' ' || m.LastName,
           e.FirstName || ' ' || e.LastName) AS Manager
FROM Employees e
LEFT JOIN Employees m ON e.ReportsTo = m.EmployeeId
ORDER BY Employee;


/* =========================
   Problem 3: Aggregation
   ========================= */

-- 3a: Album and number of tracks
SELECT
  al.Title AS AlbumTitle,
  COUNT(t.TrackId) AS TrackCount
FROM Albums al
JOIN Tracks t ON t.AlbumId = al.AlbumId
GROUP BY al.AlbumId, al.Title
ORDER BY TrackCount DESC;

-- 3b: Albums with more than 10 tracks
SELECT
  al.Title AS AlbumTitle,
  COUNT(t.TrackId) AS TrackCount
FROM Albums al
JOIN Tracks t ON t.AlbumId = al.AlbumId
GROUP BY al.AlbumId, al.Title
HAVING COUNT(t.TrackId) > 10
ORDER BY TrackCount DESC;

