UPDATE Patient
SET insurance_type = 
    CASE 
        WHEN patient_id % 3 = 0 THEN 'PrimeCare'
        WHEN patient_id % 3 = 1 THEN 'LifeCare'
        ELSE 'HealthFirst'
    END;

