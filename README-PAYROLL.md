# Mainframe Payroll Processing System

A comprehensive payroll processing system written in IBM System/370 Assembler Language, designed for mainframe environments running OS/VS2.

## Overview

This project demonstrates enterprise-level payroll processing using mainframe assembler. The system processes employee data, calculates gross pay, federal and state withholdings, and generates detailed payroll reports with summary statistics.

## Technical Specifications

- **Platform**: IBM System/370
- **Operating System**: OS/VS2
- **Language**: IBM Assembler (S/370)
- **Assembler**: ASSIST 4.0/A2-05/15/82
- **Architecture**: Modular design with multiple CSECTs and DSECTs

## System Architecture

The system is composed of four main modules:

### 1. **PAYROLL** (Main Program)
   - Coordinates overall program execution
   - Manages linkage between subprograms
   - Handles system save areas and register management

### 2. **BUILDTBL** (Table Builder)
   - Reads employee data from external dataset
   - Constructs in-memory employee table
   - Validates and stores federal/state tax rates
   - Processes up to 117 employee records

### 3. **PROCTBL** (Processing Module)
   - Calculates gross pay (hours × rate + bonuses - deductions)
   - Computes federal withholding (3.25% of gross)
   - Computes state withholding (7.75% of gross)
   - Calculates net pay
   - Accumulates totals for summary reporting

### 4. **PRNTTABL** (Report Generator)
   - Produces formatted payroll reports with pagination
   - Displays individual employee details
   - Formats currency with proper decimal alignment
   - Generates company headers and column labels

### 5. **PRNTSUMR** (Summary Reporter)
   - Calculates and displays aggregate statistics
   - Shows total and average values for all pay components
   - Reports total employee count

## Data Structures

### Employee Table Entry (TTABLE)
```
- Employee ID (9 digits, packed decimal)
- Hourly Rate (3 bytes, packed decimal)
- Hours Worked (3 bytes, packed decimal)
- Deductions (3 bytes, packed decimal)
- Bonus (3 bytes, packed decimal)
- Name (24 characters)
- Gross Pay (6 bytes, packed decimal)
- Federal Withholding (6 bytes, packed decimal)
- State Withholding (6 bytes, packed decimal)
- Net Pay (6 bytes, packed decimal)
Total: 65 bytes per employee
```

### Input Record Format (INREC)
```
- Employee ID: 8 zoned decimal digits
- Hourly Rate: 5 zoned decimal digits (includes 2 decimal places)
- Hours Worked: 5 zoned decimal digits (includes 2 decimal places)
- Deductions: 5 zoned decimal digits (includes 2 decimal places)
- Bonus: 5 zoned decimal digits (includes 2 decimal places)
- Employee Name: 24 characters
```

## Key Features

- **Packed Decimal Arithmetic**: Efficient storage and calculation using BCD format
- **Modular Design**: Separate CSECTs for maintainability and reusability
- **Dynamic Memory Management**: Table size configurable for up to 117 employees
- **Formatted Output**: Professional report layout with proper alignment and pagination
- **Summary Statistics**: Automatic calculation of totals and averages
- **Error Handling**: Built-in validation and overflow protection

## Calculations

### Gross Pay Formula
```
Gross Pay = (Hourly Rate × Hours Worked) + Bonus - Deductions
```

### Tax Withholding
```
Federal Withholding = Gross Pay × 3.25%
State Withholding = Gross Pay × 7.75%
Net Pay = Gross Pay - Federal Withholding - State Withholding
```

## Sample Output

```
                          CHICAGO SOFTWARE COMPANY, INC
                              EMPLOYEE PAYROLL REPORT

EMPLOYEE   EMPLOYEE                     HOURLY     HOURS            EMPLOYEE    
ID         NAME                            PAY    WORKED           GROSS PAY   
---------  -------------------------   -------   -------     ---------------   

12-345678  JOHANN SEBASTIAN BACH        $12.50     80.00           $1,000.00
           EMPLOYEE FEDERAL WITHHOLDING: $32.50
           EMPLOYEE STATE WITHHOLDING: $77.50
           EMPLOYEE NET PAY: $890.00
```

## Dataset Information

**Note**: The input data (DATA8) used in this project was provided by my professor as part of the course curriculum. It contains sample employee records for demonstration and testing purposes.

### Dataset Configuration
- **Dataset Name**: KC02322.CSCI360.DATAFA24(DATA8)
- **Format**: Fixed-block sequential
- **Record Length**: Based on INREC DSECT specification
- **Purpose**: Academic demonstration of payroll processing

## Compilation and Execution

### JCL Job Stream
```jcl
//KC03CDBA JOB ,'YOUR NAME',MSGCLASS=H
//JSTEP01  EXEC PGM=ASSIST
//STEPLIB  DD DSN=KC00NIU.ASSIST.LOADLIB,DISP=SHR
//SYSIN    DD *
    [Assembler source code]
/*
//FT05F001 DD DSN=KC02322.CSCI360.DATAFA24(DATA8),DISP=SHR
//FT06F001 DD SYSOUT=*
//SYSPRINT DD SYSOUT=*
```

### Execution Results
- **Execution Time**: < 0.01 seconds
- **Instructions Executed**: ~11,728
- **Performance**: ~2,932,000 instructions/second
- **Status**: Normal termination (RC=0000)

## Technical Highlights

### Register Usage
- **R12**: Base register for PAYROLL CSECT
- **R13**: Save area pointer
- **R14**: Return address
- **R15**: Entry point address / return code
- **R1**: Parameter list pointer

### Assembler Directives Used
- `CSECT` - Control Section definition
- `DSECT` - Dummy Section for data mapping
- `DC` - Define Constant
- `DS` - Define Storage
- `USING` - Base register assignment
- `LTORG` - Literal pool generation

### System Services
- XREAD - Read input records
- XPRNT - Print output lines
- XDECI - Convert zoned decimal to packed
- XDECO - Convert packed to zoned decimal

## Learning Outcomes

This project demonstrates:

1. **Low-level programming skills** in mainframe assembler
2. **Understanding of binary/packed decimal arithmetic**
3. **System architecture** and modular program design
4. **Memory management** in constrained environments
5. **JCL and MVS** operational procedures
6. **Business application development** at the system level

## Project Metrics

- **Lines of Code**: ~913 lines of assembler
- **Modules**: 5 separate program sections
- **Data Capacity**: 117 employee records maximum
- **Output Pages**: 8 pages of formatted reports
- **Test Employees**: 117 records processed

## Author

**Sang Pham**  
Course: CSCI 360 - Computer Organization  
Institution: Northern Illinois University  
Date: December 6, 2024

## Acknowledgments

Special thanks to my professor for providing the dataset and course materials that made this project possible.

## License

This project was developed for academic purposes as part of a Computer Science course at Northern Illinois University.

---

*This project showcases fundamental concepts in system programming, mainframe architecture, and business application development using IBM System/370 assembler language.*
