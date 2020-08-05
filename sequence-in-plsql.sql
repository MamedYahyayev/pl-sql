--SEQUENCE IN PL/SQL 

CREATE SEQUENCE DOCTOR_SEQ;

--FIRST METHOD (ALTERNATIVE METHOD)
DECLARE 
    NEW_DOCTOR_ID  EMPLOYEES.EMPLOYEE_ID%TYPE;
BEGIN

    NEW_DOCTOR_ID := DOCTOR_SEQ.NEXTVAL;
    
    INSERT INTO DOCTOR
    VALUES(NEW_DOCTOR_ID , 'SAMIR' , 'SAMIROV' , 1200);

    DBMS_OUTPUT.PUT_LINE('DOCTOR ADDED SUCCESSFULLY');

END;



--SECOND METHOD
DECLARE 
    NEW_DOCTOR_ID   EMPLOYEES.EMPLOYEE_ID%TYPE;
    
BEGIN
    SELECT DOCTOR_SEQ.NEXTVAL
    INTO NEW_DOCTOR_ID
    FROM DUAL;
    
    
    INSERT INTO DOCTOR
    VALUES(NEW_DOCTOR_ID,'SAMIR' , 'SAMIROV' , 1200 );
    
    DBMS_OUTPUT.PUT_LINE('DOCTOR ADDED SUCCESSFULLY');
END;

--SECOND METHOD IS BAD METHOD BECAUSE WE WRITE SELECT STATEMENT FOR ADD SEQUENCE VALUE TO NEW_DOCTOR_ID AND THIS WILL BE SLOWER