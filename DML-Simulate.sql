USE JFAutomobile
GO

------- RENTAL TRANSACTION PROCESS -------

--STEP 1
--Pelanggan datang ke JFAutomobile dan melihat-lihat mobil yang tersedia beserta spesifikasi & harga yang tertera

SELECT CarBrandName,
	   CarName,
	   CarSeatCapacity,
	   CarEngineCapacity,
	   CarAvailability,
	   CarPricePerKM

FROM MsCar mc JOIN MsCarBrand mcb ON mc.CarBrandID = mcb.CarBrandID

ORDER BY CarPricePerKM DESC

--STEP 2
--Jika pelanggan tersebut merasa cocok dengan mobil yang diinginkan, ia akan melakukan proses penyewaan

--Staf akan meminta pelanggan untuk mengisi data diri seperti:
--ID, Nama, Email, Jenis Kelamin, Alamat, dan Nomor Handphone

--Jika pelangan tersebut tidak menemukan mobil yang diinginkan, ia akan meninggalkan JFAutomobile

INSERT INTO MsCustomer VALUES
('CS-011', 'Bernard Sidjabat', 'ben10@gmail.com', 'Male', 'Mutumanikam Street', '+6281121222344')

--STEP 3 
--Setelah pelanggan melengkapi data diri, staf akan mengisi nota bukti tanda penyewaan mobil berisi:
--Nomor Transaksi, ID Staff, ID Customer

--Setelah bon bukti tersebut diserahkan ke pelanggan, maka ia dapat membawa mobil yang disewanya

--Setelah mobil tersebut disewakan staf akan mengubah nomor ketersediaan mobil menjadi 0

INSERT INTO TrRentalHeader VALUES
('TR-016', 'SF-005', 'CS-011')

UPDATE MsCar
SET CarAvailability = 0

FROM MsCar

WHERE CarId = 'CR-007'

--STEP 4
--Setelah pelanggan selesai menyewa dan mengembalikan mobil yang disewanya, 
--staf akan mengecek apa mobil yang disewa, 
--mengalkulasi jarak tempuh dengan biaya per kilometer untuk menentukan harga sewa 

--Setelah mobil tersebut dikembalikan maka nomor ketersediaan mobil diubah kembali menjadi 1

INSERT INTO TrRentalDetail VALUES
('TR-016', 'CR-007', '2022-06-17', '2022-06-18', 15)

SELECT trh.RentalID, 
	   StaffId, 
	   [StaffName] = AsMsStaff.GetStaffName,
	   [StaffPhone] = AsMsStaff.GetStaffPhone, 
	   [CustomerID] = AsMsCustomer.GetCustomerID,
	   [CustomerName] = AsMsCustomer.GetCustomerName,
	   [CustomerPhone] = AsMsCustomer.GetCustomerPhone,
	   [Car Name] = CONCAT(CONCAT(CarBrandName, ' '), CarName ),
	   RentalStartDate,
	   RentalReturnDate,
	   [Price Per Kilometer] = 'Rp.' + CAST(AsMsCar.GetCarPricePerKM AS varchar),
	   [Total Payment] = 'Rp.' + CAST(AsMsCar.GetCarPricePerKM * RentalDistanceTravelled AS varchar)

FROM TrRentalHeader trh JOIN TrRentalDetail trd ON trh.RentalID = trd.RentalID
	 JOIN MsCar mc ON trd.CarID = mc.CarID
	 JOIN MsCarBrand mcb ON mc.CarBrandID = mcb.CarBrandID,
(
	SELECT [GetCustomerID] = CustomerID,
	       [GetCustomerName] = CustomerName,
		   [GetCustomerPhone] = CustomerPhone
	FROM MsCustomer
	WHERE CustomerId = 'CS-011'
) AsMsCustomer,
(
	SELECT [GetStaffName] = StaffName, 
	       [GetStaffPhone] = StaffPhone
	FROM MsStaff
	WHERE StaffId = 'SF-005'
) AsMsStaff,
(
	SELECT [GetCarName] = CarName,
		   [GetCarBrand] = CarBrandName,
		   [GetCarPricePerKM] = CarPricePerKM
	FROM MsCar mc JOIN MsCarBrand mcb ON mc.CarBrandID = mcb.CarBrandID
	WHERE CarID = 'CR-007'
) AsMsCar

WHERE trh.RentalID = 'TR-016'

UPDATE MsCar
SET CarAvailability = 1

FROM MsCar

WHERE CarId = 'CR-007'

------- SERVICE TRANSACTION PROCESS -------

--STEP 1
--Mekanik akan datang ke JFAutomobile untuk melamar pekerjaan

--Mekanik yang lulus seleksi akan diarahkan staf untuk mengisi data diri

--Mekanik yang tidak lulus seleksi akan meninggalkan JFAutomobile

INSERT INTO MsMechanic VALUES
('MC-011', 'Raymond Christian', 'decul.demit@mail.com', 'Male', 'Camp Bernabeu street', '+6285110240913')

SELECT *

FROM MsMechanic

WHERE MechanicID = 'MC-011' AND 
      MechanicGender = 'Male'

--STEP 2
--Mekanik lalu akan diarahkan ke bengkel untuk mengecek mobil berkendala yang dibawa oleh staf,

--Mekanik akan mengisi nota bayangan yang berisi:
--nomor servis, ID staff yang membawa mobil, dan ID nya sendiri

INSERT INTO TrServiceHeader VALUES
('TS-016', 'SF-008', 'MC-011')

--STEP 3
--Sebagai bentuk pertanggungjawaban ke JFAutomobile Mekanik akan melengkapi data dari nota bayangan yang tadi berisi:
--nomor jenis servis, nomor servis, nomor ID mobil, dan tanggal kapan servis dijalankan

INSERT INTO TrServiceDetail VALUES
('SV-009', 'TS-016', 'CR-007', '2022-07-06')

SELECT tsh.ServiceID,
       msa.StaffID,
	   StaffName,
	   mm.MechanicID,
	   MechanicName,
	   ServiceName,
	   [Car Name] = CONCAT(CONCAT(CarBrandName, ' '), CarName ),
	   ServicePrice,
	   ServiceDate
	   
FROM TrServiceDetail tsd JOIN MsService mse ON tsd.ServiceNameID = mse.ServiceNameID
	 JOIN MsCar mc ON mc.CarID = tsd.CarID
	 JOIN MsCarBrand mcb ON mc.CarBrandID = mcb.CarBrandID
	 JOIN TrServiceHeader tsh ON tsd.ServiceID = tsh.ServiceID
	 JOIN MsStaff msa ON tsh.StaffID = msa.StaffID
     JOIN MsMechanic mm ON tsh.MechanicID = mm.MechanicID

WHERE tsh.ServiceID = 'TS-016'
