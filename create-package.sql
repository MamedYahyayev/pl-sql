CREATE OR REPLACE PACKAGE package_test AS
    PROCEDURE insert_employee (
        input_name      IN   VARCHAR2,
        input_surname   IN   VARCHAR2,
        input_email     IN   VARCHAR2,
        input_salary    IN   NUMBER
    );

    PROCEDURE raise_salary (
        result_message        OUT   VARCHAR2,
        emp_id                IN    NUMBER,
        increase_salary_pct   IN    NUMBER
    );

    FUNCTION check_salary (
        id IN NUMBER
    ) RETURN BOOLEAN;
    
    FUNCTION WHAT_IS_SALARY_CAP RETURN NUMBER;

END package_test;

--NOW WE HAVE 4 PROGRAM-UNITS : 2 PROCEDURES AND 2 FUNCTIONS IN THE PACKAGE HEADER ALSO KNOWN PACKAGE SPECIFICATION

