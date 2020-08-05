--COMPARISON OPERATORS
DECLARE 
    NAME  VARCHAR2(20) := 'SAMIR';
    MESSAGE VARCHAR(40) := 'STRING PROPERLY ENDED';
    
BEGIN
    --CHECK
    IF NAME = 'SAMIR' 
    OR NAME != 'SAMIR'
    OR NAME IS NOT NULL
    OR NAME IN ('SAMIR' , 'ASIM')
    OR NAME BETWEEN 'SAM' AND 'SAN'
    OR NAME LIKE 'S%'
    THEN
        DBMS_OUTPUT.PUT_LINE(MESSAGE);
    END IF;
END;