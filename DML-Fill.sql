USE JFAutomobile
GO

INSERT INTO MsCustomer VALUES --10
('CS-001', 'John Marston', 'john.m@mail.com', 'Male', 'Meditation Lane', '+6282330602071'),
('CS-002', 'Jimmy Neutron', 'jimmyatom@mail.com', 'Male', 'Stardust Way', '+6281286616893'),
('CS-003', 'Samantha Kerr', 'sammykerr@mail.com', 'Female', 'Park Lane Hotel', '+6283870239357'),
('CS-004', 'Maria Mercedes', 'marimar@mail.com', 'Female', 'Margarita Road', '+6281219550857'),
('CS-005', 'Peter Griffin', 'peeteargriffin@mail.com', 'Male', 'Quahog Street', '+6283870815121'),
('CS-006', 'Homer Simpson', 'homiesimp@mail.com', 'Male', 'Evergreen Terrace', '+6282192013087'),
('CS-007', 'Lois Lane', 'loiskent@mail.com', 'Female', 'Smallville Park', '+6281284123448'),
('CS-008', 'Velma Dinkley', 'dinky@mail.com', 'Female', 'Crystal Cove', '+6281284123447'),
('CS-009', 'Ash Ketchum', 'ash.pika@mail.com', 'Male', 'Pallet Town', '+6289630309951'),
('CS-010', 'Sandy Cheeks', 'sandysquirrel@mail.com', 'Female', 'Bikini Bottom', '+6283871576645');

INSERT INTO MsStaff VALUES --10
('SF-001', 'Victor von Doom', 'doctordoom@mail.com', 'Male', 'Three Stars Road', '+6282190630447'),
('SF-002', 'Mario Gotze', 'supermario@mail.com', 'Male', 'Signal Allianz Arena', '+6282193947112'),
('SF-003', 'Julia Roberts', 'rob.julia@mail.com', 'Female', 'Ben-hur Road', '+6282190730146'),
('SF-004', 'Kim Basinger', 'kimbass28@mail.com', 'Female', 'Windflower Lane', '+6285213931566'),
('SF-005', 'Shawn Xu', 'kungfuboy@mail.com', 'Male', 'Ten Rings Circle', '+6281219550857'),
('SF-006', 'Nobita Nobi', 'smartman55@mail.com', 'Male', 'Takaoka City', '+6285776422447'),
('SF-007', 'Sandra Bullock', 'bullfighter@mail.com', 'Female', 'West Sunset Street', '+6285397243555'),
('SF-008', 'Jennifer Lawrence', 'jenn.law@mail.com', 'Female', 'Blue Mountain Park', '+6285213789773'),
('SF-009', 'Sergio Aguero', 'agueroooo@mail.com', 'Male', 'Etihad Street', '+6287879177716'),
('SF-010', 'Myra Meadows', 'myra.meadows@mail.com', 'Female', 'Thousand Island Court', '+6287873509773');

INSERT INTO MsMechanic VALUES --10
('MC-001', 'Ansu Fati', 'fati.ansu@mail.com', 'Male', 'Catalan street', '+6285286237915'),
('MC-002', 'Mark Wahlberg', 'warkwalnut@mail.com', 'Male', 'Optimus street', '+6289694938291'),
('MC-003', 'Sabreena Dressler', 'sabreena10@mail.com', 'Female', 'Perth street', '+6281297145560'),
('MC-004', 'Alexia Putellas', 'alexiap@mail.com', 'Female', 'Camp Nou street', '+6282312446655'),
('MC-005', 'Virat Kohli', 'v.kohli@mail.com', 'Male', 'Cricket street', '+6285233739104'),
('MC-006', 'Chris Wood', 'woodychris@mail.com', 'Male', 'Newcastle street', '+6285712825874'),
('MC-007', 'Emma Raducanu', 'emmatennis@mail.com', 'Female', 'New England street', '+6281219550857'),
('MC-008', 'Greta Thunberg', 'greta22@mail.com', 'Female', 'Greenpeace street', '+6285338534457'),
('MC-009', 'Roman Abramovich', 'romanovich@mail.com', 'Male', 'Chelsea street', '+6282190672986'),
('MC-010', 'Megan Rapinoe', 'megrapie@mail.com', 'Female', 'Old America street', '+6285776422447');

INSERT INTO MsCarBrand VALUES --10
('CB-001', 'Suzuki', 'Japan'),
('CB-002', 'Mitsubishi', 'Japan'),
('CB-003', 'Mercedes Benz', 'German'),
('CB-004', 'Jeep', 'United States'),
('CB-005', 'Tesla', 'United States'),
('CB-006', 'Ford', 'United States'),
('CB-007', 'Toyota', 'Japan'),
('CB-008', 'Volkswagen', 'German'),
('CB-009', 'Audi', 'German'),
('CB-010', 'Nissan', 'Japan');

INSERT INTO MsCar VALUES --10
('CR-001', 'CB-002', 'Lancer', 2500, 4, 1500, 1),
('CR-002', 'CB-004', 'Wrangler Sahara', 2700, 4, 2000, 1),
('CR-003', 'CB-005', 'Cybertruck', 3000, 4, 2000, 0),
('CR-004', 'CB-006', 'Focus RS', 2100, 4, 2000, 1),
('CR-005', 'CB-007', 'Supra', 4000, 2, 2500, 1),
('CR-006', 'CB-001', 'Karimun Wagon R', 2000, 4, 1000, 1 ),
('CR-007', 'CB-010', 'Silvia', 4000, 2, 2000, 1),
('CR-008', 'CB-009', 'R8', 3800, 2, 3000, 1),
('CR-009', 'CB-003', 'SLS-250', 3500, 2, 3000, 1),
('CR-010', 'CB-008', 'Beetle', 3200, 4, 2000, 0);

INSERT INTO TrRentalHeader VALUES --15
('TR-001', 'SF-001', 'CS-005'),
('TR-002', 'SF-003', 'CS-005'), 
('TR-003', 'SF-010', 'CS-002'), 
('TR-004', 'SF-008', 'CS-001'), 
('TR-005', 'SF-007', 'CS-007'), 
('TR-006', 'SF-002', 'CS-001'),
('TR-007', 'SF-009', 'CS-002'), 
('TR-008', 'SF-010', 'CS-003'), 
('TR-009', 'SF-004', 'CS-003'), 
('TR-010', 'SF-005', 'CS-004'), 
('TR-011', 'SF-008', 'CS-008'), 
('TR-012', 'SF-005', 'CS-010'), 
('TR-013', 'SF-002', 'CS-006'), 
('TR-014', 'SF-006', 'CS-009'),
('TR-015', 'SF-008', 'CS-003');

INSERT INTO TrRentalDetail VALUES --25
('TR-001', 'CR-009', '2022-02-06', '2022-06-18', 1500),
('TR-003', 'CR-001', '2022-06-06', '2022-06-22', 400),
('TR-007', 'CR-006', '2022-04-06', '2022-06-22', 1105),
('TR-012', 'CR-001', '2022-06-16', '2022-06-24', 300),
('TR-004', 'CR-007', '2022-06-18', '2022-06-27', 420),
('TR-005', 'CR-004', '2022-06-19', '2022-06-29', 550),
('TR-007', 'CR-008', '2022-06-21', '2022-06-23', 55),
('TR-008', 'CR-009', '2022-06-22', '2022-06-24', 80),
('TR-006', 'CR-005', '2022-06-12', '2022-06-17', 140),
('TR-009', 'CR-005', '2022-06-12', '2022-06-18', 330),
('TR-015', 'CR-008', '2022-06-22', '2022-06-25', 200),
('TR-013', 'CR-006', '2022-06-01', '2022-06-18', 1000),
('TR-014', 'CR-009', '2022-06-15', '2022-06-20', 100),
('TR-011', 'CR-006', '2022-06-10', '2022-06-22', 670),
('TR-002', 'CR-006', '2022-06-18', '2022-06-24', 520),
('TR-004', 'CR-007', '2022-06-17', '2022-06-27', 420),
('TR-003', 'CR-006', '2022-06-18', '2022-06-24', 225),
('TR-014', 'CR-001', '2022-06-14', '2022-06-20', 480),
('TR-012', 'CR-001', '2022-06-15', '2022-06-19', 650),
('TR-011', 'CR-002', '2022-06-18', '2022-06-24', 330),
('TR-009', 'CR-002', '2022-06-16', '2022-06-20', 220),
('TR-010', 'CR-006', '2022-06-25', '2022-06-28', 120),
('TR-002', 'CR-009', '2022-06-12', '2022-06-19', 400),
('TR-002', 'CR-007', '2022-06-11', '2022-06-18', 60),
('TR-002', 'CR-004', '2022-03-18', '2022-06-17', 1080);

INSERT INTO MsService VALUES --10
('SV-001', 'Full Body Repair', 1000000),
('SV-002', 'Electrical Components Inspection', 350000),
('SV-003', 'Tire Patch', 100000),
('SV-004', 'Cabin Filter Exchange', 520000),
('SV-005', 'Radiator & Coolant Hose Check', 725000),
('SV-006', 'Spooring', 100000),
('SV-007', 'Balancing', 250000),
('SV-008', 'Air Conditioning Inspection', 750000),
('SV-009', 'Spark Plugs Change', 375000),
('SV-010', 'Extensive Brake Inspection', 500000);

INSERT INTO TrServiceHeader VALUES --15
('TS-001', 'SF-001', 'MC-005'),
('TS-002', 'SF-003', 'MC-005'),
('TS-003', 'SF-010', 'MC-002'),
('TS-004', 'SF-008', 'MC-001'),
('TS-005', 'SF-007', 'MC-007'),
('TS-006', 'SF-002', 'MC-001'),
('TS-007', 'SF-009', 'MC-002'),
('TS-008', 'SF-001', 'MC-003'),
('TS-009', 'SF-004', 'MC-005'),
('TS-010', 'SF-005', 'MC-004'),
('TS-011', 'SF-001', 'MC-008'),
('TS-012', 'SF-009', 'MC-010'),
('TS-013', 'SF-001', 'MC-005'),
('TS-014', 'SF-006', 'MC-009'),
('TS-015', 'SF-008', 'MC-003');

INSERT INTO TrServiceDetail VALUES --25
('SV-010', 'TS-001', 'CR-001', '2022-06-18'),
('SV-001', 'TS-003', 'CR-008', '2022-06-24'),
('SV-009', 'TS-008', 'CR-002', '2022-06-21'),
('SV-001', 'TS-008', 'CR-001', '2022-06-17'),
('SV-009', 'TS-007', 'CR-004', '2022-06-30'),
('SV-005', 'TS-002', 'CR-006', '2022-06-29'),
('SV-007', 'TS-009', 'CR-007', '2022-06-25'),
('SV-008', 'TS-010', 'CR-009', '2022-06-27'),
('SV-001', 'TS-004', 'CR-006', '2022-06-29'),
('SV-006', 'TS-005', 'CR-004', '2022-06-24'),
('SV-001', 'TS-008', 'CR-003', '2022-06-22'),
('SV-004', 'TS-005', 'CR-001', '2022-06-18'),
('SV-001', 'TS-002', 'CR-008', '2022-07-01'),
('SV-001', 'TS-006', 'CR-001', '2022-07-05'),
('SV-001', 'TS-008', 'CR-004', '2022-06-23'),
('SV-001', 'TS-002', 'CR-009', '2022-07-10'),
('SV-009', 'TS-009', 'CR-001', '2022-07-06'),
('SV-009', 'TS-010', 'CR-002', '2022-06-24'),
('SV-003', 'TS-004', 'CR-007', '2022-06-25'),
('SV-001', 'TS-005', 'CR-005', '2022-06-27'),
('SV-001', 'TS-008', 'CR-004', '2022-06-28'),
('SV-009', 'TS-005', 'CR-003', '2022-06-29'),
('SV-001', 'TS-002', 'CR-010', '2022-06-30'),
('SV-002', 'TS-006', 'CR-009', '2022-07-02'),
('SV-001', 'TS-008', 'CR-007', '2022-07-04');

