CREATE TYPE genderEnum AS ENUM ('Male', 'Female', 'NonBinary', 'Other');

CREATE TABLE "Hospital" (
    "Id" SERIAL PRIMARY KEY,
    "Name" VARCHAR(255) NOT NULL,
    "Address" VARCHAR(255) NOT NULL
);

CREATE TABLE "Department" (
    "Id" SERIAL PRIMARY KEY,
	"HospitalId" INT NOT NULL,
    "Name" VARCHAR(255) NOT NULL,
    "Capacity" INT NOT NULL,
    CONSTRAINT "FK_Department_Hospital_HospitalId" 
		FOREIGN KEY ("HospitalId") 
		REFERENCES "Hospital"("Id")
);

CREATE TABLE "Patient" ( 
    "Id" SERIAL PRIMARY KEY,
    "DepartmentId" INT NOT NULL,
    "FirstName" VARCHAR(255) NOT NULL,
    "LastName" VARCHAR(255) NOT NULL,
    "Age" INT NOT NULL,
    "BirthDate" DATE NOT NULL,
    "Gender" genderEnum NOT NULL,
    CONSTRAINT "FK_Patient_Department_DepartmentId"
		FOREIGN KEY ("DepartmentId") 
		REFERENCES "Department"("Id")
);

CREATE TABLE "Staff" (
    "Id" SERIAL PRIMARY KEY,
    "DepartmentId" INT NOT NULL,
    "Education" VARCHAR(255) NOT NULL,
    "FirstName" VARCHAR(255) NOT NULL,
    "LastName" VARCHAR(255) NOT NULL,
    "Age" INT NOT NULL,
    "BirthDate" DATE NOT NULL,
    "Gender" genderEnum NOT NULL,
    CONSTRAINT "FK_Staff_Department_DepartmentId"
		FOREIGN KEY ("DepartmentId") 
		REFERENCES "Department"("Id")
);

CREATE TABLE "Doctor" (
    "Id" SERIAL PRIMARY KEY,
    "StaffId" INT NOT NULL UNIQUE,
    "Speciality" VARCHAR(255) NOT NULL,
    CONSTRAINT "FK_Doctor_Staff_StaffId"
		FOREIGN KEY ("StaffId") 
		REFERENCES "Staff"("Id")
);

CREATE TABLE "Nurse" (
    "Id" SERIAL PRIMARY KEY,
    "StaffId" INT NOT NULL UNIQUE,
    CONSTRAINT "FK_Nurse_Staff_StaffId"
		FOREIGN KEY ("StaffId") 
		REFERENCES "Staff"("Id")
);

CREATE TABLE "Record" (
    "Id" SERIAL PRIMARY KEY,
	"PatientId" INT NOT NULL UNIQUE,
    "Sickness" VARCHAR(255) NOT NULL,
    "Prescriptions" VARCHAR(255) NOT NULL,
    "Allergies" VARCHAR(255) NOT NULL,
    CONSTRAINT "FK_Record_Patient_PatientId"
		FOREIGN KEY ("PatientId") 
		REFERENCES "Patient"("Id")
);

CREATE TABLE "RecordDoctor" (
    "Id" SERIAL PRIMARY KEY,
    "DoctorId" INT NOT NULL,
    "RecordId" INT NOT NULL,
    CONSTRAINT "FK_RecordDoctor_Doctor_DoctorId"
		FOREIGN KEY ("DoctorId") 
		REFERENCES "Doctor"("Id"),
    CONSTRAINT "FK_RecordDoctor_Record_RecordId"
		FOREIGN KEY ("RecordId") 
		REFERENCES "Record"("Id")
);
