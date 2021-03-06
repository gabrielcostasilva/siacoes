CREATE TABLE `appconfig` (
    `theme` SMALLINT NOT NULL,
	`host` VARCHAR(255) NOT NULL,
	`sigacenabled` TINYINT NOT NULL,
	`sigesenabled` TINYINT NOT NULL,
	`sigetenabled` TINYINT NOT NULL
);

CREATE TABLE `ldapconfig` (
  `idldapconfig` INT NOT NULL AUTO_INCREMENT ,
  `host` VARCHAR(100) NOT NULL ,
  `port` INT NOT NULL ,
  `useSSL` TINYINT NOT NULL ,
  `ignoreCertificates` TINYINT NOT NULL ,
  `basedn` VARCHAR(100) NOT NULL ,
  `uidField` VARCHAR(100) NOT NULL ,
  `cpfField` VARCHAR(100) NOT NULL ,
  `registerField` VARCHAR(100) NOT NULL ,
  `nameField` VARCHAR(100) NOT NULL ,
  `emailField` VARCHAR(100) NOT NULL ,
  PRIMARY KEY (`idldapconfig`)
);

CREATE TABLE `emailconfig` (
  `idemailconfig` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `port` int(11) NOT NULL,
  `enableSsl` tinyint(4) NOT NULL,
  `authenticate` tinyint(4) NOT NULL,
  `signature` TEXT NOT NULL,
  PRIMARY KEY (`idemailconfig`)
);

CREATE TABLE `emailmessage` (
  `idemailmessage` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `datafields` text NOT NULL,
  `module` tinyint(4) NOT NULL,
  PRIMARY KEY (`idemailmessage`)
);

CREATE TABLE `campus` (
  `idcampus` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `initials` VARCHAR(50) NOT NULL,
  `address` varchar(100) NOT NULL,
  `site` varchar(255) NOT NULL,
  `logo` mediumblob,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`idcampus`)
);

CREATE TABLE `department` (
  `iddepartment` int(11) NOT NULL AUTO_INCREMENT,
  `idcampus` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `initials` VARCHAR(50) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `site` varchar(255) NOT NULL,
  `logo` mediumblob,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`iddepartment`),
  KEY `fk_department_campus_idx` (`idcampus`),
  CONSTRAINT `fk_department_campus` FOREIGN KEY (`idcampus`) REFERENCES `campus` (`idcampus`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `semester` (
    `idcampus` INT NOT NULL,
    `semester` SMALLINT NOT NULL,
    `year` INT NOT NULL,
    `startDate` DATE NOT NULL,
    `endDate` DATE NOT NULL,
    CONSTRAINT `semester_pkey` PRIMARY KEY (`idcampus`, `semester`, `year`),
    CONSTRAINT `fk_semester_idcampus` FOREIGN KEY (`idcampus`) REFERENCES `campus` (`idcampus`) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE  TABLE `sigacconfig` (
  `iddepartment` INT NOT NULL ,
  `minimumScore` DOUBLE NOT NULL ,
  PRIMARY KEY (`iddepartment`) ,
  CONSTRAINT `fk_sigacconfig_iddepartment` FOREIGN KEY (`iddepartment` ) REFERENCES `department` (`iddepartment` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `sigesconfig` (
  `iddepartment` INT NOT NULL ,
  `minimumScore` DOUBLE NOT NULL ,
  `supervisorPonderosity` DOUBLE NOT NULL ,
  `companySupervisorPonderosity` DOUBLE NOT NULL ,
  `showgradestostudent` TINYINT NOT NULL ,
  `supervisorfilter` SMALLINT NOT NULL ,
  PRIMARY KEY (`iddepartment`) ,
  CONSTRAINT `fk_sigesconfig_iddepartment` FOREIGN KEY (`iddepartment` ) REFERENCES `department` (`iddepartment` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `sigetconfig` (
  `iddepartment` INT NOT NULL ,
  `minimumScore` DOUBLE NOT NULL ,
  `registerProposal` TINYINT NOT NULL ,
  `showgradestostudent` TINYINT NOT NULL ,
  `supervisorfilter` SMALLINT NOT NULL ,
  `cosupervisorfilter` SMALLINT NOT NULL ,
  PRIMARY KEY (`iddepartment`) ,
  CONSTRAINT `fk_sigetconfig_iddepartment` FOREIGN KEY (`iddepartment` ) REFERENCES `department` (`iddepartment` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `country` (
  `idcountry` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`idcountry`)
);

CREATE TABLE `state` (
  `idstate` int(11) NOT NULL AUTO_INCREMENT,
  `idcountry` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `initials` varchar(10) NOT NULL,
  PRIMARY KEY (`idstate`),
  KEY `fk_state_country_idx` (`idcountry`),
  CONSTRAINT `fk_state_country` FOREIGN KEY (`idcountry`) REFERENCES `country` (`idcountry`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `city` (
  `idcity` int(11) NOT NULL AUTO_INCREMENT,
  `idstate` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`idcity`),
  KEY `fk_city_state_idx` (`idstate`),
  CONSTRAINT `fk_city_state` FOREIGN KEY (`idstate`) REFERENCES `state` (`idstate`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `company` (
  `idcompany` int(11) NOT NULL AUTO_INCREMENT,
  `idcity` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `cnpj` varchar(20) NOT NULL,
  `phone` varchar(45) NOT NULL,
  `email` varchar(100) NOT NULL,
  `company` varchar(50) NOT NULL,
  PRIMARY KEY (`idcompany`),
  KEY `fk_company_city_idx` (`idcity`),
  CONSTRAINT `fk_company_city` FOREIGN KEY (`idcity`) REFERENCES `city` (`idcity`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartment` int(11) DEFAULT NULL,
  `idcompany` INT NULL,
  `name` varchar(255) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(500) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` VARCHAR(100) NOT NULL,
  `institution` varchar(100) NOT NULL,
  `research` text NOT NULL,
  `external` tinyint(4) NOT NULL,
  `lattes` varchar(100) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `area` varchar(100) NOT NULL,
  `sigacmanager` tinyint(4) NOT NULL,
  `sigesmanager` tinyint(4) NOT NULL,
  `sigetmanager` tinyint(4) NOT NULL,
  `departmentmanager` tinyint(4) NOT NULL,
  `studentCode` varchar(45) NOT NULL,
  `registerSemester` tinyint(4) NOT NULL,
  `registerYear` smallint(6) NOT NULL,
  `photo` mediumblob DEFAULT NULL,
  PRIMARY KEY (`iduser`),
  KEY `fk_user_department_idx` (`idDepartment`),
  KEY `fk_user_company_idx` (`idcompany`),
  CONSTRAINT `fk_user_department` FOREIGN KEY (`idDepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_company` FOREIGN KEY (`idcompany` ) REFERENCES `company` (`idcompany` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `userprofile` (
    `iduser` integer NOT NULL,
    `profile` smallint NOT NULL,
    PRIMARY KEY (`iduser`, `profile`),
	KEY `fk_userprofile_user_idx` (`iduser`),
    CONSTRAINT `fk_userprofile_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE `certificate` (
  `idcertificate` int(11) NOT NULL AUTO_INCREMENT,
  `iddepartment` int(11) NOT NULL,
  `iduser` int(11) NOT NULL,
  `module` tinyint(4) NOT NULL,
  `date` datetime NOT NULL,
  `guid` varchar(100) NOT NULL,
  `file` mediumblob NOT NULL,
  PRIMARY KEY (`idcertificate`),
  KEY `fk_certificate_department_idx` (`iddepartment`),
  KEY `fk_certificate_user_idx` (`iduser`),
  CONSTRAINT `fk_certificate_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_certificate_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `themesuggestion` (
  `idthemesuggestion` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartment` int(11) NOT NULL,
  `idUser` INT(11) NULL,
  `title` varchar(255) NOT NULL,
  `proponent` varchar(100) NOT NULL,
  `objectives` text NOT NULL,
  `proposal` text NOT NULL,
  `submissiondate` date NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`idthemesuggestion`),
  KEY `fk_themesuggestion_department_idx` (`idDepartment`),
  KEY `fk_themesuggestion_user_idx` (`idUser`),
  CONSTRAINT `fk_themesuggestion_department` FOREIGN KEY (`idDepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_themesuggestion_user` FOREIGN KEY (`idUser` ) REFERENCES `user` (`iduser` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `internship` (
  `idinternship` int(11) NOT NULL AUTO_INCREMENT,
  `iddepartment` int(11) NOT NULL,
  `idcompany` int(11) NOT NULL,
  `idcompanysupervisor` int(11) NOT NULL,
  `idsupervisor` int(11) NOT NULL,
  `idstudent` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `comments` text NOT NULL,
  `reportTitle` VARCHAR(255) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `totalHours` int(11) NOT NULL,
  `internshipPlan` mediumblob NOT NULL,
  `finalReport` mediumblob,
  PRIMARY KEY (`idinternship`),
  KEY `fk_internship_company_idx` (`idcompany`),
  KEY `fk_internship_companysupervisor_idx` (`idcompanysupervisor`),
  KEY `fk_internship_supervisor_idx` (`idsupervisor`),
  KEY `fk_internship_student_idx` (`idstudent`),
  KEY `fk_internship_department_idx` (`iddepartment`),
  CONSTRAINT `fk_internship_company` FOREIGN KEY (`idcompany`) REFERENCES `company` (`idcompany`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internship_companysupervisor` FOREIGN KEY (`idcompanysupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internship_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internship_student` FOREIGN KEY (`idstudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internship_supervisor` FOREIGN KEY (`idsupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `internshipreport` (
  `idinternshipreport` int(11) NOT NULL AUTO_INCREMENT,
  `idinternship` int(11) NOT NULL,
  `report` mediumblob NOT NULL,
  `type` tinyint(4) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`idinternshipreport`),
  KEY `fk_internshipreport_internship_idx` (`idinternship`),
  CONSTRAINT `fk_internshipreport_internship` FOREIGN KEY (`idinternship`) REFERENCES `internship` (`idinternship`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `internshipevaluationitem` (
  `idinternshipevaluationitem` INT NOT NULL AUTO_INCREMENT ,
  `iddepartment` INT NOT NULL ,
  `description` VARCHAR(255) NOT NULL ,
  `ponderosity` DOUBLE NOT NULL ,
  `active` TINYINT NOT NULL ,
  `sequence` SMALLINT NOT NULL ,
  `type` TINYINT NOT NULL ,
  PRIMARY KEY (`idinternshipevaluationitem`) ,
  INDEX `fk_internshipevaluationitem_iddepartment_idx` (`iddepartment` ASC) ,
  CONSTRAINT `fk_internshipevaluationitem_iddepartment` FOREIGN KEY (`iddepartment` ) REFERENCES `department` (`iddepartment` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `internshipjury` (
  `idinternshipjury` INT NOT NULL AUTO_INCREMENT ,
  `idinternship` INT NOT NULL ,
  `date` DATETIME NOT NULL ,
  `local` VARCHAR(100) NOT NULL ,
  `comments` TEXT NOT NULL ,
  `startTime` TIME NOT NULL ,
  `endTime` TIME NOT NULL ,
  `minimumScore` DOUBLE NOT NULL ,
  `supervisorPonderosity` DOUBLE NOT NULL ,
  `companySupervisorPonderosity` DOUBLE NOT NULL ,
  `companySupervisorScore` DOUBLE NOT NULL ,
  `result` TINYINT NOT NULL,
  PRIMARY KEY (`idinternshipjury`) ,
  INDEX `fk_internshipjury_idinternship_idx` (`idinternship` ASC) ,
  CONSTRAINT `fk_internshipjury_idinternship` FOREIGN KEY (`idinternship` ) REFERENCES `internship` (`idinternship` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `internshipjuryappraiser` (
  `idinternshipjuryappraiser` INT NOT NULL AUTO_INCREMENT ,
  `idinternshipjury` INT NOT NULL ,
  `idappraiser` INT NOT NULL ,
  `file` MEDIUMBLOB NULL ,
  `filetype` SMALLINT NOT NULL ,
  `comments` TEXT NOT NULL ,
  PRIMARY KEY (`idinternshipjuryappraiser`) ,
  INDEX `fk_internshipjuryappraiser_idinternshipjury_idx` (`idinternshipjury` ASC) ,
  INDEX `fk_internshipjuryappraiser_idappraiser_idx` (`idappraiser` ASC) ,
  CONSTRAINT `fk_internshipjuryappraiser_idinternshipjury` FOREIGN KEY (`idinternshipjury` ) REFERENCES `internshipjury` (`idinternshipjury` ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internshipjuryappraiser_idappraiser` FOREIGN KEY (`idappraiser` ) REFERENCES `user` (`iduser` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);
	
CREATE  TABLE `internshipjuryappraiserscore` (
  `idinternshipjuryappraiserscore` INT NOT NULL AUTO_INCREMENT ,
  `idinternshipJuryAppraiser` INT NOT NULL ,
  `idinternshipEvaluationItem` INT NOT NULL ,
  `score` DOUBLE NOT NULL ,
  PRIMARY KEY (`idinternshipjuryappraiserscore`) ,
  INDEX `fk_internshipjuryappraiserscore_idinternshipjury_idx` (`idinternshipJuryAppraiser` ASC) ,
  INDEX `fk_internshipjuryappraiserscore_idinternshipevaluationitem_idx` (`idinternshipEvaluationItem` ASC) ,
  CONSTRAINT `fk_internshipjuryappraiserscore_idinternshipjuryappraiser` FOREIGN KEY (`idinternshipJuryAppraiser` ) REFERENCES `internshipjuryappraiser` (`idinternshipjuryappraiser` ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internshipjuryappraiserscore_idinternshipevaluationitem` FOREIGN KEY (`idinternshipEvaluationItem` ) REFERENCES `internshipevaluationitem` (`idinternshipevaluationitem` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `internshipjurystudent` (
  `idinternshipjurystudent` INT NOT NULL AUTO_INCREMENT ,
  `idinternshipJury` INT NOT NULL ,
  `idStudent` INT NOT NULL ,
  PRIMARY KEY (`idinternshipjurystudent`) ,
  INDEX `fk_internshipjurystudent_idinternshipjury_idx` (`idinternshipJury` ASC) ,
  INDEX `fk_internshipjurystudent_idstudent_idx` (`idStudent` ASC) ,
  CONSTRAINT `fk_internshipjurystudent_idinternshipjury` FOREIGN KEY (`idinternshipJury` ) REFERENCES `internshipjury` (`idinternshipjury` ) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_internshipjurystudent_idstudent` FOREIGN KEY (`idStudent` ) REFERENCES `user` (`iduser` ) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `internshipfinaldocument` (
  `idinternshipfinaldocument` int(11) NOT NULL AUTO_INCREMENT,
  `idinternship` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `submissionDate` date NOT NULL,
  `file` mediumblob NOT NULL,
  `private` TINYINT NOT NULL,
  `supervisorFeedbackDate` DATE NULL,
  `supervisorFeedback` SMALLINT NOT NULL,
  `comments` TEXT NOT NULL,
  PRIMARY KEY (`idinternshipfinaldocument`),
  KEY `fk_internshipfinaldocument_idinternship_idx` (`idinternship`),
  CONSTRAINT `fk_internshipfinaldocument_idinternship` FOREIGN KEY (`idinternship`) REFERENCES `internship` (`idinternship`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `activityunit` (
  `idactivityunit` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL,
  `fillAmount` tinyint(4) NOT NULL,
  PRIMARY KEY (`idactivityunit`)
);

CREATE TABLE `activitygroup` (
  `idactivitygroup` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `sequence` int(11) NOT NULL,
  `minimumScore` int(11) NOT NULL,
  `maximumScore` int(11) NOT NULL,
  PRIMARY KEY (`idactivitygroup`)
);

CREATE TABLE `activity` (
  `idactivity` int(11) NOT NULL AUTO_INCREMENT,
  `idactivitygroup` int(11) NOT NULL,
  `idactivityunit` int(11) NOT NULL,
  `iddepartment` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `score` double NOT NULL,
  `maximumInSemester` double NOT NULL,
  `active` tinyint(4) NOT NULL,
  `sequence` int(11) NOT NULL,
  PRIMARY KEY (`idactivity`),
  KEY `fk_activity_activitygroup_idx` (`idactivitygroup`),
  KEY `fk_activity_activityunit_idx` (`idactivityunit`),
  KEY `fk_activity_department_idx` (`iddepartment`),
  CONSTRAINT `fk_activity_activitygroup` FOREIGN KEY (`idactivitygroup`) REFERENCES `activitygroup` (`idactivitygroup`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_activityunit` FOREIGN KEY (`idactivityunit`) REFERENCES `activityunit` (`idactivityunit`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activity_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `activitysubmission` (
  `idactivitysubmission` int(11) NOT NULL AUTO_INCREMENT,
  `idStudent` int(11) NOT NULL,
  `idfeedbackuser` INT NULL,
  `iddepartment` int(11) NOT NULL,
  `idActivity` int(11) NOT NULL,
  `semester` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `submissionDate` date NOT NULL,
  `file` mediumblob NOT NULL,
  `filetype` smallint(6) NOT NULL,
  `amount` double NOT NULL,
  `feedback` tinyint(4) NOT NULL,
  `feedbackDate` date DEFAULT NULL,
  `validatedAmount` double NOT NULL,
  `comments` TEXT NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idactivitysubmission`),
  KEY `fk_activitysubmission_student_idx` (`idStudent`),
  KEY `fk_activitysubmission_department_idx` (`iddepartment`),
  KEY `fk_activitysubmission_activity_idx` (`idActivity`),
  KEY `fk_activitysubmission_feedbackuser_idx` (`idfeedbackuser`),
  CONSTRAINT `fk_activitysubmission_activity` FOREIGN KEY (`idActivity`) REFERENCES `activity` (`idactivity`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activitysubmission_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activitysubmission_student` FOREIGN KEY (`idStudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_activitysubmission_feedbackuser` FOREIGN KEY (`idfeedbackuser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `finalsubmission` (
    `idfinalsubmission` INT NOT NULL AUTO_INCREMENT,
    `iddepartment` INT NOT NULL,
    `idstudent` INT NOT NULL,
    `idfeedbackuser` INT NOT NULL,
	`finalscore` double NOT NULL,
    `date` DATE NOT NULL,
    `report` mediumblob NOT NULL,
    PRIMARY KEY (`idfinalsubmission`),
	KEY `fk_finalsubmission_department_idx` (`iddepartment`),
	KEY `fk_finalsubmission_student_idx` (`idStudent`),
	KEY `fk_finalsubmission_feedbackuser_idx` (`idfeedbackuser`),
    CONSTRAINT `fk_finalsubmission_department` FOREIGN KEY (`iddepartment`) REFERENCES `department` (`iddepartment`) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT `fk_finalsubmission_student` FOREIGN KEY (`idstudent`) REFERENCES `user` (`iduser`) ON UPDATE NO ACTION ON DELETE NO ACTION,
    CONSTRAINT `fk_finalsubmission_feedbackuser` FOREIGN KEY (`idfeedbackuser`) REFERENCES `user` (`iduser`) ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE `document` (
  `iddocument` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartment` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `sequence` int(11) NOT NULL,
  `file` mediumblob NOT NULL,
  `module` smallint(6) NOT NULL,
  PRIMARY KEY (`iddocument`),
  KEY `fk_document_department_idx` (`idDepartment`),
  CONSTRAINT `fk_document_department` FOREIGN KEY (`idDepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `deadline` (
  `iddeadline` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartment` int(11) NOT NULL,
  `semester` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `proposalDeadline` date NOT NULL,
  `projectDeadline` date NOT NULL,
  `thesisDeadline` date NOT NULL,
  PRIMARY KEY (`iddeadline`),
  KEY `fk_deadline_department_idx` (`idDepartment`),
  CONSTRAINT `fk_deadline_department` FOREIGN KEY (`idDepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `proposal` (
  `idproposal` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartment` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subarea` varchar(255) NOT NULL,
  `idStudent` int(11) NOT NULL,
  `idSupervisor` int(11) NOT NULL,
  `idCoSupervisor` int(11) DEFAULT NULL,
  `file` mediumblob DEFAULT NULL,
  `semester` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `submissionDate` date NOT NULL,
  `fileType` tinyint(4) NOT NULL,
  `invalidated` TINYINT NOT NULL,
  PRIMARY KEY (`idproposal`),
  KEY `fk_proposal_student_idx` (`idStudent`),
  KEY `fk_proposal_advisor_idx` (`idSupervisor`),
  KEY `fk_proposal_cosupervisor_idx` (`idCoSupervisor`),
  KEY `fk_proposal_department_idx` (`idDepartment`),
  CONSTRAINT `fk_proposal_cosupervisor` FOREIGN KEY (`idCoSupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_department` FOREIGN KEY (`idDepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_student` FOREIGN KEY (`idStudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_supervisor` FOREIGN KEY (`idSupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `proposalappraiser` (
  `idproposalAppraiser` int(11) NOT NULL AUTO_INCREMENT,
  `idProposal` int(11) NOT NULL,
  `idAppraiser` int(11) NOT NULL,
  `feedback` tinyint(4) NOT NULL,
  `comments` text NOT NULL,
  `allowEditing` tinyint(4) NOT NULL,
  PRIMARY KEY (`idproposalAppraiser`),
  KEY `fk_proposalappraiser_proposal_idx` (`idProposal`),
  KEY `fk_proposalappraiser_appraiser_idx` (`idAppraiser`),
  CONSTRAINT `fk_proposalappraiser_appraiser` FOREIGN KEY (`idAppraiser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposalappraiser_proposal` FOREIGN KEY (`idProposal`) REFERENCES `proposal` (`idproposal`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `attendance` (
  `idattendance` int(11) NOT NULL AUTO_INCREMENT,
  `idproposal` int(11) NOT NULL,
  `idstudent` int(11) NOT NULL,
  `idsupervisor` int(11) NOT NULL,
  `date` date NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `comments` text NOT NULL,
  `nextMeeting` text NOT NULL,
  `stage` int(11) NOT NULL,
  PRIMARY KEY (`idattendance`),
  KEY `fk_attendance_proposal_idx` (`idproposal`),
  KEY `fk_attendance_student_idx` (`idstudent`),
  KEY `fk_attendance_supervisor_idx` (`idsupervisor`),
  CONSTRAINT `fk_attendance_proposal` FOREIGN KEY (`idproposal`) REFERENCES `proposal` (`idproposal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_attendance_student` FOREIGN KEY (`idstudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_attendance_supervisor` FOREIGN KEY (`idsupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `supervisorchange` (
  `idsupervisorchange` int(11) NOT NULL AUTO_INCREMENT,
  `idProposal` int(11) NOT NULL,
  `idOldSupervisor` int(11) NOT NULL,
  `idNewSupervisor` int(11) NOT NULL,
  `idOldCosupervisor` int(11) DEFAULT NULL,
  `idNewCosupervisor` int(11) DEFAULT NULL,
  `date` datetime NOT NULL,
  `comments` varchar(255) NOT NULL,
  `approved` tinyint(4) NOT NULL,
  `approvalDate` datetime DEFAULT NULL,
  `approvalComments` varchar(255) NOT NULL,
  PRIMARY KEY (`idsupervisorchange`),
  KEY `fk_supervisorchange_oldsupervisor_idx` (`idOldSupervisor`),
  KEY `fk_supervisorchange_newsupervisor_idx` (`idNewSupervisor`),
  KEY `fk_supervisorchange_oldcosupervisor_idx` (`idOldCosupervisor`),
  KEY `fk_supervisorchange_newcosupervisor_idx` (`idNewCosupervisor`),
  KEY `fk_supervisorchange_proposal_idx` (`idProposal`),
  CONSTRAINT `fk_supervisorchange_newcosupervisor` FOREIGN KEY (`idNewCosupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_supervisorchange_newsupervisor` FOREIGN KEY (`idNewSupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_supervisorchange_oldcosupervisor` FOREIGN KEY (`idOldCosupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_supervisorchange_oldsupervisor` FOREIGN KEY (`idOldSupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_supervisorchange_proposal` FOREIGN KEY (`idProposal`) REFERENCES `proposal` (`idproposal`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `project` (
  `idproject` int(11) NOT NULL AUTO_INCREMENT,
  `idproposal` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subarea` varchar(255) NOT NULL,
  `idstudent` int(11) NOT NULL,
  `idsupervisor` int(11) NOT NULL,
  `file` mediumblob NOT NULL,
  `filetype` smallint(6) NOT NULL,
  `semester` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `submissiondate` date NOT NULL,
  `idcosupervisor` int(11) DEFAULT NULL,
  `abstract` text NOT NULL,
  PRIMARY KEY (`idproject`),
  KEY `fk_project_proposal_idx` (`idproposal`),
  KEY `fk_project_student_idx` (`idstudent`),
  KEY `fk_project_supervisor_idx` (`idsupervisor`),
  KEY `fk_project_cosupervisor_idx` (`idcosupervisor`),
  CONSTRAINT `fk_project_cosupervisor` FOREIGN KEY (`idcosupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_proposal` FOREIGN KEY (`idproposal`) REFERENCES `proposal` (`idproposal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_student` FOREIGN KEY (`idstudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_supervisor` FOREIGN KEY (`idsupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `thesis` (
  `idthesis` int(11) NOT NULL AUTO_INCREMENT,
  `idproject` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subarea` varchar(255) NOT NULL,
  `idstudent` int(11) NOT NULL,
  `idsupervisor` int(11) NOT NULL,
  `file` mediumblob NOT NULL,
  `filetype` smallint(6) NOT NULL,
  `semester` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `submissiondate` date NOT NULL,
  `idcosupervisor` int(11) DEFAULT NULL,
  `abstract` text NOT NULL,
  PRIMARY KEY (`idthesis`),
  KEY `fk_thesis_project_idx` (`idproject`),
  KEY `fk_thesis_student_idx` (`idstudent`),
  KEY `fk_thesis_supervisor_idx` (`idsupervisor`),
  KEY `fk_thesis_cosupervisor_idx` (`idcosupervisor`),
  CONSTRAINT `fk_thesis_cosupervisor` FOREIGN KEY (`idcosupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_thesis_project` FOREIGN KEY (`idproject`) REFERENCES `project` (`idproject`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_thesis_student` FOREIGN KEY (`idstudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_thesis_supervisor` FOREIGN KEY (`idsupervisor`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `finaldocument` (
  `idfinaldocument` int(11) NOT NULL AUTO_INCREMENT,
  `idProject` int(11) DEFAULT NULL,
  `idThesis` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `submissionDate` date NOT NULL,
  `file` mediumblob NOT NULL,
  `private` TINYINT NOT NULL,
  `companyInfo` TINYINT NOT NULL,
  `patent` TINYINT NOT NULL,
  `supervisorFeedbackDate` DATE NULL,
  `supervisorFeedback` SMALLINT NOT NULL,
  `comments` TEXT NOT NULL,
  PRIMARY KEY (`idfinaldocument`),
  KEY `fk_finaldocument_idproject_idx` (`idProject`),
  KEY `fk_finaldocument_idthesis_idx` (`idThesis`),
  CONSTRAINT `fk_finaldocument_idproject` FOREIGN KEY (`idProject`) REFERENCES `project` (`idproject`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_finaldocument_idthesis` FOREIGN KEY (`idThesis`) REFERENCES `thesis` (`idthesis`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `evaluationitem` (
  `idevaluationItem` int(11) NOT NULL AUTO_INCREMENT,
  `idDepartment` int(11) NOT NULL,
  `description` varchar(255) NOT NULL,
  `ponderosity` double NOT NULL,
  `stage` smallint(6) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `sequence` smallint(6) NOT NULL,
  `type` tinyint(4) NOT NULL,
  PRIMARY KEY (`idevaluationItem`),
  KEY `fk_evaluationitem_department_idx` (`idDepartment`),
  CONSTRAINT `fk_evaluationitem_department` FOREIGN KEY (`idDepartment`) REFERENCES `department` (`iddepartment`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `jury` (
  `idjury` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `local` varchar(100) NOT NULL,
  `idproject` int(11) DEFAULT NULL,
  `idthesis` int(11) DEFAULT NULL,
  `comments` text NOT NULL,
  `startTime` time NOT NULL,
  `endTime` time NOT NULL,
  `minimumScore` double NOT NULL,
  PRIMARY KEY (`idjury`),
  KEY `fk_jury_project_idx` (`idproject`),
  KEY `fk_jury_thesis_idx` (`idthesis`),
  CONSTRAINT `fk_jury_project` FOREIGN KEY (`idproject`) REFERENCES `project` (`idproject`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jury_thesis` FOREIGN KEY (`idthesis`) REFERENCES `thesis` (`idthesis`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `juryappraiser` (
  `idjuryappraiser` int(11) NOT NULL AUTO_INCREMENT,
  `idjury` int(11) NOT NULL,
  `idappraiser` int(11) NOT NULL,
  `file` mediumblob NULL,
  `filetype` smallint(6) NOT NULL,
  `comments` TEXT NOT NULL,
  PRIMARY KEY (`idjuryappraiser`),
  KEY `fk_juryappraiser_jury_idx` (`idjury`),
  KEY `fk_juryappraiser_appraiser_idx` (`idappraiser`),
  CONSTRAINT `fk_juryappraiser_appraiser` FOREIGN KEY (`idappraiser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_juryappraiser_jury` FOREIGN KEY (`idjury`) REFERENCES `jury` (`idjury`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `juryappraiserscore` (
  `idjuryappraiserscore` int(11) NOT NULL AUTO_INCREMENT,
  `idjuryappraiser` int(11) NOT NULL,
  `idevaluationitem` int(11) NOT NULL,
  `score` float NOT NULL,
  PRIMARY KEY (`idjuryappraiserscore`),
  KEY `id_juryappraiserscore_juryappraiser_idx` (`idjuryappraiser`),
  KEY `id_juryappraiserscore_evaluationitem_idx` (`idevaluationitem`),
  CONSTRAINT `id_juryappraiserscore_evaluationitem` FOREIGN KEY (`idevaluationitem`) REFERENCES `evaluationitem` (`idevaluationItem`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `id_juryappraiserscore_juryappraiser` FOREIGN KEY (`idjuryappraiser`) REFERENCES `juryappraiser` (`idjuryappraiser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `jurystudent` (
  `idjurystudent` int(11) NOT NULL AUTO_INCREMENT,
  `idjury` int(11) NOT NULL,
  `idstudent` int(11) NOT NULL,
  PRIMARY KEY (`idjurystudent`),
  KEY `fk_jurystudent_jury_idx` (`idjury`),
  KEY `fk_jurystudent_student_idx` (`idstudent`),
  CONSTRAINT `fk_jurystudent_jury` FOREIGN KEY (`idjury`) REFERENCES `jury` (`idjury`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_jurystudent_student` FOREIGN KEY (`idstudent`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE  TABLE `bugreport` (
  `idbugreport` INT NOT NULL AUTO_INCREMENT,
  `iduser` INT NOT NULL,
  `module` SMALLINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `type` SMALLINT NOT NULL,
  `reportDate` DATETIME NOT NULL,
  `status` SMALLINT NOT NULL,
  `statusDate` DATETIME NULL,
  `statusDescription` TEXT NOT NULL,
  PRIMARY KEY (`idbugreport`),
  INDEX `fk_bugreport_user_idx` (`iduser` ASC),
  CONSTRAINT `fk_bugreport_user` FOREIGN KEY (`iduser`) REFERENCES `user` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(1, 2, '', '', '{student};{group};{activity};{semester};{year};{comments}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(2, 2, '', '', '{student};{group};{activity};{semester};{year};{comments};{feedbackUser};{feedback}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(3, 3, '', '', '{student};{company};{companySupervisor};{supervisor};{type};{startDate};{comments}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(4, 3, '', '', '{student};{company};{companySupervisor};{supervisor};{type};{startDate};{comments}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(5, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(6, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(7, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(8, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(9, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(10, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(11, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea};{appraiser}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(12, 1, '', '', '{student};{supervisor};{cosupervisor};{title};{subarea};{appraiser};{feedback};{comments}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(13, 1, '', '', '{student};{title};{appraiser};{date};{time};{local};{stage}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(14, 1, '', '', '{student};{title};{appraiser};{date};{time};{local};{stage}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(15, 1, '', '', '{student};{title};{appraiser};{date};{time};{local};{stage}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(16, 1, '', '', '{student};{title};{appraiser};{date};{time};{local};{stage}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(17, 1, '', '', '{student};{title};{appraiser};{date};{time};{local};{stage}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(18, 3, '', '', '{student};{title};{appraiser};{company};{date};{time};{local}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(19, 3, '', '', '{student};{title};{appraiser};{company};{date};{time};{local}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(20, 3, '', '', '{student};{title};{appraiser};{company};{date};{time};{local}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(21, 3, '', '', '{student};{title};{appraiser};{company};{date};{time};{local}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(22, 3, '', '', '{student};{title};{appraiser};{company};{date};{time};{local}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(23, 1, '', '', '{documenttype};{student};{title};{supervisor}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(24, 1, '', '', '{documenttype};{student};{title};{supervisor};{feedback};{manager}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(25, 3, '', '', '{student};{company};{supervisor}');
INSERT INTO emailmessage(idemailmessage, module, subject, message, datafields) VALUES(26, 3, '', '', '{student};{company};{supervisor};{feedback};{manager}');