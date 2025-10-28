Payroll Processing System

An IBM System/370 Assembler program that processes employee payroll data.

About

This project was created for CSCI 360 - Computer Organization at Northern Illinois University. It demonstrates mainframe programming using IBM assembler language to calculate employee payroll including gross pay, tax withholdings, and net pay.

What It Does

- Reads employee data from input files
- Calculates gross pay based on hours worked and hourly rate
- Computes federal withholding (3.25%)
- Computes state withholding (7.75%)
- Generates formatted payroll reports
- Provides summary statistics (totals and averages)

Technical Details

- Language: IBM System/370 Assembler
- Platform: Mainframe (OS/VS2)
- Capacity: Processes up to 117 employees
- Input: Employee records with ID, rate, hours, deductions, bonus, and name
- Output: Formatted payroll reports with pagination

Project Structure

- PAYROLL.asm - Main assembler source code
- Includes modules for:
  - Building employee data table
  - Processing payroll calculations
  - Generating reports
  - Creating summary statistics

Dataset

The input data was provided by my professor for this academic project.

Sample Output

CHICAGO SOFTWARE COMPANY, INC
EMPLOYEE PAYROLL REPORT

EMPLOYEE   EMPLOYEE                     HOURLY     HOURS      GROSS PAY
ID         NAME                            PAY    WORKED                
---------  -------------------------   -------   -------   ------------

12-345678  JOHANN SEBASTIAN BACH        $12.50     80.00      $1,000.00

Author

Sang Pham
Northern Illinois University
December 2024

Acknowledgments

Thanks to my professor for providing the course materials and dataset for this project.
