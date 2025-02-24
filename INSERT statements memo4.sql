CREATE TABLE Classification
( 
	classID              char(1)  NOT NULL ,
	className            char(9)  NULL ,
	PRIMARY KEY  CLUSTERED (classID ASC)
)
go

CREATE TABLE Participant
( 
	participantID        char(5)  NOT NULL ,
	name                 char(14)  NULL ,
	StartDate            date  NULL ,
	EndDate              date  NULL ,
	PRIMARY KEY  CLUSTERED (participantID ASC)
)
go

CREATE TABLE Technician
( 
	participantID        char(5)  NOT NULL ,
	classID              char(1)  NULL ,
	PRIMARY KEY  CLUSTERED (participantID ASC),
	 FOREIGN KEY (classID) REFERENCES Classification(classID),
	 FOREIGN KEY (participantID) REFERENCES Participant(participantID)
)
go

CREATE TABLE Status
( 
	StatusCode           int  NOT NULL ,
	StatusDescription    char(14)  NULL ,
	PRIMARY KEY  CLUSTERED (StatusCode ASC)
)
go

CREATE TABLE Region
( 
	regionID             char(2)  NOT NULL ,
	size                 char(3)  NULL ,
	regionName           char(14)  NULL ,
	PRIMARY KEY  CLUSTERED (regionID ASC)
)
go

CREATE TABLE Study
( 
	StudyID              char(3)  NOT NULL ,
	StudyName            char(12)  NULL ,
	regionID             char(2)  NULL ,
	PRIMARY KEY  CLUSTERED (StudyID ASC),
	 FOREIGN KEY (regionID) REFERENCES Region(regionID)
)
go

CREATE TABLE Species
( 
	speciesCode          char(1)  NOT NULL ,
	speciesName          char(12)  NULL ,
	averagePHT           decimal(5,1)  NULL ,
	PRIMARY KEY  CLUSTERED (speciesCode ASC)
)
go

CREATE TABLE Animal
( 
	AnimalNumber         int  NOT NULL ,
	StudyID              char(3)  NOT NULL ,
	speciesCode          char(1)  NULL ,
	sex                  char(1)  NULL ,
	PRIMARY KEY  CLUSTERED (AnimalNumber ASC,StudyID ASC),
	 FOREIGN KEY (StudyID) REFERENCES Study(StudyID),
	 FOREIGN KEY (speciesCode) REFERENCES Species(speciesCode)
)
go

CREATE TABLE Sample
( 
	sampleNumber         int  NOT NULL ,
	AnimalNumber         int  NOT NULL ,
	StudyID              char(3)  NOT NULL ,
	StatusCode           int  NULL ,
	classID              char(1)  NULL ,
	sampleDate           char(8)  NULL ,
	location             char(6)  NULL ,
	PRIMARY KEY  CLUSTERED (sampleNumber ASC,AnimalNumber ASC,StudyID ASC),
	 FOREIGN KEY (StatusCode) REFERENCES Status(StatusCode),
	 FOREIGN KEY (classID) REFERENCES Classification(classID),
	 FOREIGN KEY (AnimalNumber,StudyID) REFERENCES Animal(AnimalNumber,StudyID)
)
go

CREATE TABLE Dogs
( 
	participantID        char(5)  NOT NULL ,
	Samples              int  NULL ,
	PRIMARY KEY  CLUSTERED (participantID ASC),
	 FOREIGN KEY (participantID) REFERENCES Participant(participantID)
)
go

CREATE TABLE Scat
( 
	sampleNumber         int  NOT NULL ,
	AnimalNumber         int  NOT NULL ,
	StudyID              char(3)  NOT NULL ,
	phtValue             decimal(5,1)  NULL ,
	participantID        char(5)  NULL ,
	PRIMARY KEY  CLUSTERED (sampleNumber ASC,AnimalNumber ASC,StudyID ASC),
	 FOREIGN KEY (sampleNumber,AnimalNumber,StudyID) REFERENCES Sample(sampleNumber,AnimalNumber,StudyID),
	 FOREIGN KEY (participantID) REFERENCES Dogs(participantID)
)
go

CREATE TABLE ProjectDirector
( 
	participantID        char(5)  NOT NULL ,
	ReviewDate           date  NULL ,
	PRIMARY KEY  CLUSTERED (participantID ASC),
	 FOREIGN KEY (participantID) REFERENCES Participant(participantID)
)
go

CREATE TABLE Manager
( 
	participantID        char(5)  NOT NULL ,
	regionID             char(2)  NULL ,
	AccessDate           date  NULL ,
	PRIMARY KEY  CLUSTERED (participantID ASC),
	 FOREIGN KEY (regionID) REFERENCES Region(regionID),
	 FOREIGN KEY (participantID) REFERENCES Participant(participantID)
)
go

CREATE TABLE Hair_Telemetry
( 
	sampleNumber         int  NOT NULL ,
	AnimalNumber         int  NOT NULL ,
	StudyID              char(3)  NOT NULL ,
	PRIMARY KEY  CLUSTERED (sampleNumber ASC,AnimalNumber ASC,StudyID ASC),
	 FOREIGN KEY (sampleNumber,AnimalNumber,StudyID) REFERENCES Sample(sampleNumber,AnimalNumber,StudyID)
)
go



-- Table names (region(RegionID - size, regionName), study(StudyID - Studyname, RegionID FK), species(speciesCode - speciesName, averagePHT), Animal(animalNumber, StudyID FK - speciesCode FK, sex), Status(StatusCode - StatusDescription ), classification(classID - className), sample(sampleNumber, animalNumber FK, StudyID FK - StatusCode FK, ClassID FK, sampleDate, location), hair&telemetry(sampleNumber FK, animalNumber FK, StudyID FK), Participant(participantID - name, StartDate, EndDate), technician(participantID FK - classID FK), dogs(participantID FK - Samples ), projectDirector(participantID FK - ReviewDate, regionID FK), Manager(participantID FK - regionID FK, AccessDate), Scat(sampleNumber FK, animalNumber FK, StudyID FK - phtValue, participantID FK))

INSERT INTO Region (regionID, size, regionName) VALUES ('NR', '9x9', 'North Region');
INSERT INTO Region (regionID, size, regionName) VALUES ('SR', '5x5', 'South Region');
INSERT INTO Region (regionID, size, regionName) VALUES ('CR', '9x9', 'Central Region');

INSERT INTO Study (StudyID, StudyName, regionID) VALUES ('N22', 'North 2022', 'NR');
INSERT INTO Study (StudyID, StudyName, regionID) VALUES ('S22', 'South 2022', 'SR');
INSERT INTO Study (StudyID, StudyName, regionID) VALUES ('C22', 'Central 2022', 'CR');
INSERT INTO Study (StudyID, StudyName, regionID) VALUES ('C23', 'Central 2022', 'CR');

INSERT INTO Species (speciesCode, speciesName, averagePHT) VALUES ('B', 'Black bear', 113);
INSERT INTO Species (speciesCode, speciesName, averagePHT) VALUES ('G', 'Grizzly bear', 142);
INSERT INTO Species (speciesCode, speciesName, averagePHT) VALUES ('U', 'Undetermined', NULL);

INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (42, 'N22', 'B', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (89, 'S22', 'B', 'F');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (59, 'C22', 'B', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (113, 'C22', 'G', 'F');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (59, 'C23', 'B', 'F');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (50, 'C23', 'B', '?');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (118, 'N22', 'B', 'F');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (112, 'C23', 'G', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (66, 'C22', 'G', 'F');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (66, 'N22', 'U', '?');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (66, 'S22', 'B', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (42, 'N22', 'B', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (113, 'N22', 'G', 'F');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (63, 'S22', 'B', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (114, 'C22', 'G', 'M');
INSERT INTO Animal (AnimalNumber, StudyID, speciesCode, sex) VALUES (114, 'C22', 'G', '?');

INSERT INTO Status (StatusCode, StatusDescription) VALUES (0, 'Sample used up');
INSERT INTO Status (StatusCode, StatusDescription) VALUES (1, 'Sample exists');

INSERT INTO Classification (classID, className) VALUES ('S', 'Scat');
INSERT INTO Classification (classID, className) VALUES ('T', 'Telemetry');
INSERT INTO Classification (classID, className) VALUES ('H', 'Hair snag');

INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (17, 42, 'N22', 1, 'S', 'Jul 2022', '05:8:3');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (22, 89, 'S22', 1, 'T', 'Nov 2022', '93:2:4');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (44, 59, 'C22', 0, 'T', 'Sep 2022', '32:1:9');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (45, 113, 'C22', 0, 'H', 'Oct 2022', '40:1:1');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (47, 59, 'C22', 0, 'T', 'Sep 2022', '41:2:3');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (48, 59, 'C23', 1, 'S', 'Sep 2023', '34:4:4');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (56, 50, 'C23', 1, 'S', 'Jul 2023', '40:1:1');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (59, 118, 'N22', 1, 'S', 'Jun 2022', '07:1:2');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (79, 112, 'C23', 1, 'S', 'Jul 2023', '32:5:5');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (82, 66, 'C22', 0, 'T', 'Nov 2022', '31:5:8');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (100, 66, 'N22', 0, 'S', 'Jul 2022', '01:1:9');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (68, 66, 'S22', 0, 'H', 'Jul 2022', '80:3:2');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (27, 42, 'N22', 1, 'S', 'Aug 2022', '15:2:6');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (11, 113, 'N22', 0, 'S', 'Jul 2022', '19:4:7');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (45, 63, 'S22', 0, 'S', 'Jul 2022', '90:3:4');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (17, 114, 'C22', 1, 'T', 'Oct 2022', '40:4:1');
INSERT INTO Sample (sampleNumber, AnimalNumber, StudyID, StatusCode, classID, sampleDate, location) VALUES (18, 114, 'C22', 1, 'S', 'Oct 2022', '40:4:1');


INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (22, 89, 'S22');
INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (44, 59, 'C22');
INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (45, 113, 'C22');
INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (47, 59, 'C22');
INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (82, 66, 'C22');
INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (68, 66, 'S22');
INSERT INTO Hair_Telemetry (sampleNumber, AnimalNumber, StudyID) VALUES (17, 114, 'C22');

INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P2001', 'Bill Brown', '2022-02-14', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P2004', 'Jane Brown', '2022-02-14', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P2036', 'Frank Martin', '2020-08-15', '2022-01-01');
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P2045', 'Anne Dough', '2021-06-12', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P2046', 'Mike Green', '2020-10-28', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P3070', 'Adolfo Pozos', '2024-12-02', NULL);

INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('D0004', 'Max', '2022-06-01', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('D0008', 'Sampson', '2022-02-05', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('D0013', 'Cindy', '2021-12-10', '2022-12-20');
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('D0022', 'Rover', '2022-05-20', NULL);

INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P0000', 'Bob Bureaucrat', '2024-09-11', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P0101', NULL, '2023-05-23', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P0102', NULL, '2023-05-23', NULL);
INSERT INTO Participant (participantID, name, StartDate, EndDate) VALUES ('P0103', NULL, '2023-05-23', NULL);

INSERT INTO Technician (participantID, classID) VALUES ('P2001', 'T');
INSERT INTO Technician (participantID, classID) VALUES ('P2004', 'H');
INSERT INTO Technician (participantID, classID) VALUES ('P2036', 'T');
INSERT INTO Technician (participantID, classID) VALUES ('P2045', 'T');
INSERT INTO Technician (participantID, classID) VALUES ('P2046', 'H');
INSERT INTO Technician (participantID, classID) VALUES ('P3070', 'T');

INSERT INTO Dogs (participantID, Samples) VALUES ('D0004', 3);
INSERT INTO Dogs (participantID, Samples) VALUES ('D0008', 3);
INSERT INTO Dogs (participantID, Samples) VALUES ('D0013', 2);
INSERT INTO Dogs (participantID, Samples) VALUES ('D0022', 2);

INSERT INTO ProjectDirector (participantID, ReviewDate) VALUES ('P0000', NULL);

INSERT INTO Manager (participantID, regionID, AccessDate) VALUES ('P0101', 'NR', NULL);
INSERT INTO Manager (participantID, regionID, AccessDate) VALUES ('P0102', 'CR', NULL);
INSERT INTO Manager (participantID, regionID, AccessDate) VALUES ('P0103', 'SR', NULL);

INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (17, 42, 'N22', 109, 'D0004');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (48, 59, 'C23', 100, 'D0013');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (56, 50, 'C23', 103.5, 'D0004');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (59, 118, 'N22', 120, 'D0022');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (79, 112, 'C23', 135, 'D0004');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (100, 66, 'N22', NULL, 'D0022');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (27, 42, 'N22', 115, 'D0008');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (11, 113, 'N22', 135, 'D0008');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (45, 63, 'S22', 117, 'D0013');
INSERT INTO Scat (sampleNumber, AnimalNumber, StudyID, phtValue, participantID) VALUES (18, 114, 'C22', 150, 'D0004');

