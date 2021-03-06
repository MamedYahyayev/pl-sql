SET SERVEROUTPUT ON;

DECLARE
    --DECLARE THE CURSOR
    CURSOR employee_cursor IS
    SELECT
        *
    FROM
        employees;

    --DECLARE THE ROWTYPE OF EMPLOYEE

    emp_record employees%rowtype;
BEGIN
    --OPEN THE CURSOR
    OPEN employee_cursor;

    --AND WE FETCH ALL DATAS FROM THE CURSOR
    LOOP
        --WE FETCH DATA FROM CURSOR AND INSERT INTO EMP_RECORD
        FETCH employee_cursor INTO emp_record;
    
        --AND WE TEST IF DATA NOT FOUND , WE EXIT LOOP
        EXIT WHEN employee_cursor%notfound; 
        
        --DISPLAY THE EMPLOYEES
        dbms_output.put_line('EMPLOYEE : '
                             || emp_record.first_name
                             || ' '
                             || emp_record.last_name);

    END LOOP;
    
    --CLOSE THE CURSOR

    CLOSE employee_cursor;
END;