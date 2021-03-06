--LOGIC CONTROL AND BRANCHING : LABEL , GOTO STATEMENT , LOOP STRUCTURES ,  IF-THEN-ELSE STRUCTURES , CASE STRUCTURES


--LABEL
--WE WRITE LABEL WITH ANGLA BRACKETS << LABELNAME >> 
--THEY CAN BE PLACED ANYWHERE WITHIN A BLOCK
DECLARE 
    --DECLARE TYPE
    TYPE EMP_RECORD
    IS RECORD (
                    ID                  EMPLOYEES.EMPLOYEE_ID%TYPE,
                    NAME                EMPLOYEES.FIRST_NAME%TYPE,
                    SURNAME             EMPLOYEES.LAST_NAME%TYPE,
                    SALARY              EMPLOYEES.SALARY%TYPE,      
                    BONUS_PAYMENT       NUMBER(6)
            );
            
    --DECLARE VARIABLES
    HIGHER_EMPLOYEE   EMP_RECORD;
    LOWER_EMPLOYEE   EMP_RECORD;
BEGIN
<<HIGH_SALARY_EMPLOYEE>>
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , 5000
    INTO HIGHER_EMPLOYEE
    FROM EMPLOYEES
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES)
    AND ROWNUM <=1;

<<DISPLAY_HIGHER_EMPLOYEE>>
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE NAME WHO GAIN HIGH SALARY :  ' || HIGHER_EMPLOYEE.NAME);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE  SALARY WHO GAIN HIGH SALARY : ' || HIGHER_EMPLOYEE.SALARY);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE  BONUS PAYMENT WHO GAIN HIGH SALARY : '  || HIGHER_EMPLOYEE.BONUS_PAYMENT);


<<LOW_SALARY_EMPLOYEE>>
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , 0
    INTO LOWER_EMPLOYEE
    FROM EMPLOYEES
    WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
    AND ROWNUM <=1;

<<DISPLAY_LOWER_EMPLOYEE>>
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE NAME WHO GAIN LOW SALARY : ' || LOWER_EMPLOYEE.NAME);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEES SALARY WHO GAIN LOW SALARY : '|| LOWER_EMPLOYEE.SALARY);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEES BONUS PAYMENT WHO GAIN LOW SALARY : ' || LOWER_EMPLOYEE.BONUS_PAYMENT);

END;
            


--GOTO STATEMENT
DECLARE 
    --DECLARE TYPE
    TYPE EMP_RECORD
    IS RECORD (
                    ID                  EMPLOYEES.EMPLOYEE_ID%TYPE,
                    NAME                EMPLOYEES.FIRST_NAME%TYPE,
                    SURNAME             EMPLOYEES.LAST_NAME%TYPE,
                    SALARY              EMPLOYEES.SALARY%TYPE,      
                    BONUS_PAYMENT       NUMBER(6)
            );
            
    --DECLARE VARIABLES
    HIGHER_EMPLOYEE     EMP_RECORD;
    LOWER_EMPLOYEE      EMP_RECORD;
BEGIN
<<HIGH_SALARY_EMPLOYEE>>
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , 5000
    INTO HIGHER_EMPLOYEE
    FROM EMPLOYEES
    WHERE SALARY = (SELECT MAX(SALARY) FROM EMPLOYEES)
    AND ROWNUM <=1;

<<DISPLAY_HIGHER_EMPLOYEE>>
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE NAME WHO GAIN HIGH SALARY :  ' || HIGHER_EMPLOYEE.NAME);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE  SALARY WHO GAIN HIGH SALARY : ' || HIGHER_EMPLOYEE.SALARY);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE  BONUS PAYMENT WHO GAIN HIGH SALARY : '  || HIGHER_EMPLOYEE.BONUS_PAYMENT);


<<LOW_SALARY_EMPLOYEE>>
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , 0
    INTO LOWER_EMPLOYEE
    FROM EMPLOYEES
    WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
    AND ROWNUM <=1;
    
    IF HIGHER_EMPLOYEE.ID = LOWER_EMPLOYEE.ID THEN --IF THIS STATEMENT IS TRUE GOTO CONCLUSION LABEL AND RETURN NULL
        GOTO CONCLUSION;
    END IF;

    <<DISPLAY_LOWER_EMPLOYEE>>
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE NAME WHO GAIN LOW SALARY : ' || LOWER_EMPLOYEE.NAME);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEES SALARY WHO GAIN LOW SALARY : '|| LOWER_EMPLOYEE.SALARY);
    DBMS_OUTPUT.PUT_LINE('EMPLOYEES BONUS PAYMENT WHO GAIN LOW SALARY : ' || LOWER_EMPLOYEE.BONUS_PAYMENT);
    
    
    <<CONCLUSION>>
    NULL;


END;
            




--LOOP 
DECLARE 
    --DECLARE TYPE
    TYPE EMP_RECORD
    IS RECORD (
                    ID                  EMPLOYEES.EMPLOYEE_ID%TYPE,
                    NAME                EMPLOYEES.FIRST_NAME%TYPE,
                    SURNAME             EMPLOYEES.LAST_NAME%TYPE,
                    SALARY              EMPLOYEES.SALARY%TYPE,      
                    BONUS_PAYMENT       NUMBER(6)
            );
            
    --DECLARE VARIABLES
    LOWER_EMPLOYEE     EMP_RECORD;

BEGIN
    FOR I IN 1..3 LOOP
        --RETRIEVE EMPLOYEE FROM EMPLOYEES TABLE
          SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , 0
          INTO LOWER_EMPLOYEE
          FROM EMPLOYEES
          WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
          AND ROWNUM <= 1;      
          
         
        --REMOVE EMPLOYEES FROM EMPLOYEES TABLE 
        DELETE FROM EMPLOYEES
        WHERE EMPLOYEES.EMPLOYEE_ID = LOWER_EMPLOYEE.ID;
      
        COMMIT;
    
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE WHO WAS TRANSFERRED : ' || LOWER_EMPLOYEE.NAME);
    END LOOP;
    
    
END;
 

SELECT * FROM EMPLOYEES;

--NOW LET'S INSERT DATA TO EMPLOYEES TABLE WITH FOR LOOP
DECLARE
    
    COUNT_EMPLOYEE NUMBER(5);
BEGIN
        
    FOR I IN 1..15 LOOP
        INSERT INTO EMPLOYEES(EMPLOYEE_ID , FIRST_NAME , LAST_NAME , SALARY , HIRE_DATE)
        VALUES (EMPLOYEE_SEQ.NEXTVAL, 'SAMIR' , 'SAMIROV' , 2500, SYSDATE);
    END LOOP;

    COMMIT;

    --THIS ADD EMPLOYEE COUNTS TO COUNT_EMPLOYEE        
        SELECT COUNT(EMPLOYEE_ID)
        INTO COUNT_EMPLOYEE
        FROM EMPLOYEES;
       
      --DISPLAY EMPLOYEES COUNT
     DBMS_OUTPUT.PUT_LINE('EMPLOYEES COUNT : ' || COUNT_EMPLOYEE); 
       
      --WHEN EXCEPTION OCCURS , IT WILL BE ROLL BACK  
       EXCEPTION
            WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('EXCEPTION OCCURS' );
        ROLLBACK;
        
     
END;



--INDEFINITE LOOP
DECLARE 
    --DECLARE THE TYPE
    TYPE EMP_RECORD
    IS RECORD (
        ID          EMPLOYEES.EMPLOYEE_ID%TYPE,
        NAME        EMPLOYEES.FIRST_NAME%TYPE,
        SURNAME     EMPLOYEES.LAST_NAME%TYPE,
        SALARY      EMPLOYEES.SALARY%TYPE
       );
   
   EMP_RECORD_COUNT  SIMPLE_INTEGER := 0;
       
   TRANSFERRED_EMPLOYEE         EMP_RECORD;   
   
   
BEGIN
   --RETRIEVE DATA FROM EMPLOYEES TABLE     
  
  LOOP 
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME  , SALARY     
    INTO TRANSFERRED_EMPLOYEE
    FROM EMPLOYEES
    WHERE  SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
    AND ROWNUM <=1;
   
   DBMS_OUTPUT.PUT_LINE('TRANSFERRED_EMPLOYEE: ' || TRANSFERRED_EMPLOYEE.NAME); 
    
   DELETE FROM EMPLOYEES
   WHERE EMPLOYEE_ID = transferred_employee.ID;
    
   COMMIT;
   
   SELECT COUNT(*)
   INTO EMP_RECORD_COUNT
   FROM EMPLOYEES;
    
   
    
   EXIT WHEN  EMP_RECORD_COUNT < 150;
  
  END LOOP;
  
END;
    



--CONDITIONAL LOOP

DECLARE 
    --DECLARE THE TYPE
    TYPE EMP_RECORD
    IS RECORD (
        ID          EMPLOYEES.EMPLOYEE_ID%TYPE,
        NAME        EMPLOYEES.FIRST_NAME%TYPE,
        SURNAME     EMPLOYEES.LAST_NAME%TYPE,
        SALARY      EMPLOYEES.SALARY%TYPE
       );
   
   EMP_RECORD_COUNT  SIMPLE_INTEGER := 0;
       
   TRANSFERRED_EMPLOYEE         EMP_RECORD;   
   
   
BEGIN
   --RETRIEVE DATA FROM EMPLOYEES TABLE     
    SELECT COUNT(*)
   INTO EMP_RECORD_COUNT
   FROM EMPLOYEES;
    
   WHILE emp_record_count > 140 LOOP
   
    SELECT EMPLOYEE_ID , FIRST_NAME , LAST_NAME  , SALARY     
    INTO TRANSFERRED_EMPLOYEE
    FROM EMPLOYEES
    WHERE  SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
    AND ROWNUM <=1;
   
   DBMS_OUTPUT.PUT_LINE('TRANSFERRED_EMPLOYEE: ' || TRANSFERRED_EMPLOYEE.NAME); 
    
   DELETE FROM EMPLOYEES
   WHERE EMPLOYEE_ID = transferred_employee.ID;
    
   COMMIT;
   
   SELECT COUNT(*)
   INTO EMP_RECORD_COUNT
   FROM EMPLOYEES;
   
  END LOOP; 
   
END;    


--NESTED LOOPS
DECLARE
BEGIN
    FOR I IN 1..3 LOOP
        FOR Y IN 1..3 LOOP  
            DBMS_OUTPUT.PUT_LINE('I=' || I || ','|| 'Y=' || Y);
        END LOOP;
    
    END LOOP;
END;




--IF THEN ELSE
DECLARE

    --DECLARE VARIABLES
    BIRTH_MONTH  CHAR(3) := '&ENTER_MONTH';
    MESSAGE VARCHAR2(30) ;

BEGIN
    IF UPPER(BIRTH_MONTH) = 'JAN' THEN        
        MESSAGE := 'IT IS JANUARY';
    ELSE 
        MESSAGE := 'IT IS OTHER MONTHS';
    END IF;

    --DISPLAY MESSAGE 
    DBMS_OUTPUT.PUT_LINE(MESSAGE);

END;




--IF , ELSIF ,  ELSE
DECLARE

    --DECLARE VARIABLES
    BIRTH_MONTH  CHAR(3) := UPPER('&ENTER_MONTH');
    MESSAGE VARCHAR2(30) ;

BEGIN
    IF BIRTH_MONTH = 'JAN' THEN   
    
        MESSAGE := 'IT IS JANUARY';
        
    ELSIF BIRTH_MONTH = 'FEB' THEN 
    
        MESSAGE := 'IT IS FEBRUARY';
        
    ELSE 
    
        MESSAGE := 'IT IS OTHER MONTHS';
        
    END IF;

    --DISPLAY MESSAGE 
    DBMS_OUTPUT.PUT_LINE(MESSAGE);

END;





--CASE STATEMENT
DECLARE
        
     MESSAGE VARCHAR2(40);   
     ENTERED_EMPLOYEE_ID  NUMBER := &EMPLOYEE_ID;       
     X_HIRE_DATE DATE;
     HIRE_DATE_MONTH  CHAR(3);
     EMP_NAME VARCHAR2(30);
     
BEGIN
    
      SELECT HIRE_DATE , FIRST_NAME
      INTO X_HIRE_DATE , EMP_NAME
      FROM  EMPLOYEES 
      WHERE EMPLOYEE_ID = ENTERED_EMPLOYEE_ID;

        --COVERT TO HIRE_DATE TO MONTH
        HIRE_DATE_MONTH := TO_CHAR(X_HIRE_DATE , 'MON');

        CASE HIRE_DATE_MONTH 
            WHEN 'JAN' THEN MESSAGE := ' HIRE MONTH IS JANUARY';
            WHEN 'FEB' THEN MESSAGE := ' HIRE MONTH IS FEBRUARY';
            WHEN 'MAR' THEN MESSAGE := ' HIRE MONTH IS MART';
            WHEN 'APR' THEN MESSAGE := ' HIRE MONTH IS APRIL';
            WHEN 'MAY' THEN MESSAGE := ' HIRE MONTH IS MAY';
         ELSE MESSAGE := 'THIS IS NOT A MONTH';   
        
        END CASE;
        
       --DISPLAY THE RESULT
       DBMS_OUTPUT.PUT_LINE(EMP_NAME || '  ' || MESSAGE);

END;





--CASE WHEN
DECLARE
    MESSAGE VARCHAR2(30);
    X_SALARY  HR.EMPLOYEES.SALARY%TYPE;
    ENTERED_EMPLOYEE_ID  NUMBER := &ENTERED_VALUE;
    
BEGIN
    
    SELECT SALARY
    INTO X_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = ENTERED_EMPLOYEE_ID;
    
    
    CASE 
        WHEN  X_SALARY > 20000 THEN MESSAGE := 'THIS EMPLOYEE IS VERY RICH';
        
        WHEN X_SALARY BETWEEN 10000 AND 20000 THEN MESSAGE := 'THIS EMPLOYEE IS RICH';
        
        WHEN X_SALARY < 10000 THEN 
            MESSAGE := 'THIS EMPLOYEE IS POOR';
        
        ELSE 
            MESSAGE := 'THIS IS NOT A SALARY';
    END CASE;

    --DISPLAY THE RESULT
    DBMS_OUTPUT.PUT_LINE(MESSAGE);


END;

