BEGIN TRANSACTION;

CREATE TABLE IF NOT EXISTS "ROLE" (
    "ROLE_ID"   INTEGER NOT NULL,
    "ROLE_NAME" TEXT NOT NULL,
    "ROLE_DESCRIPTION" TEXT NOT NULL,
    PRIMARY KEY("ROLE_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "EMPLOYEE" (
    "EMPLOYEE_ID"   INTEGER NOT NULL,
    "FIRST_NAME"    TEXT NOT NULL,
    "LAST_NAME"     TEXT NOT NULL,
    "ROLE_ID"       INTEGER NOT NULL,
    "STREET"        TEXT NOT NULL,
    "CITY"          TEXT NOT NULL,
    "ZIPCODE"       TEXT NOT NULL,
    "STATE"         TEXT NOT NULL,
    "PHONE_NUMBER"  TEXT NOT NULL,
    "YEARS_IN_SERVICE"  INTEGER NOT NULL,
    PRIMARY KEY("EMPLOYEE_ID" AUTOINCREMENT),
    FOREIGN KEY("ROLE_ID") REFERENCES "ROLE"("ROLE_ID")
);

CREATE TABLE IF NOT EXISTS "STORAGE_PROTOCOL" (
    "STORAGE_PROTOCOL_ID" INTEGER NOT NULL,
    "MIN_TEMP_CELSUIS"    REAL NOT NULL,
    "MAX_TEMP_CELSUIS"    REAL NOT NULL,
    "OPTIMAL_HUMIDITY_RH" REAL NOT NULL,
    PRIMARY KEY("STORAGE_PROTOCOL_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "SUPPLIER" (
    "SUPPLIER_ID"   INTEGER NOT NULL,
    "NAME"          TEXT NOT NULL,
    "STREET"        TEXT NOT NULL,
    "CITY"          TEXT NOT NULL,
    "ZIPCODE"       TEXT NOT NULL,
    "STATE"         TEXT NOT NULL,
    "PHONE_NUMBER"  TEXT NOT NULL,
    "EMAIL"         TEXT NOT NULL,
    PRIMARY KEY("SUPPLIER_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "RECIPE_INGREDIENT" (
    "RECIPE_ID"         INTEGER NOT NULL,
    "INGREDIENT_ID"     INTEGER NOT NULL,
    "QUANTITY"          TEXT NOT NULL,
    "MEASUREMENT_UNIT"  TEXT NOT NULL,
    FOREIGN KEY("INGREDIENT_ID") REFERENCES "INGREDIENT"("INGREDIENT_ID"),
    FOREIGN KEY("RECIPE_ID") REFERENCES "RECIPE"("RECIPE_ID"),
    PRIMARY KEY("INGREDIENT_ID","RECIPE_ID")
);

CREATE TABLE IF NOT EXISTS "LOYALTY_MEMBER" (
    "MEMBER_ID"        INTEGER NOT NULL,
    "FIRST_NAME"       TEXT NOT NULL,
    "LAST_NAME"        TEXT NOT NULL,
    "PHONE_NUMBER"     TEXT NOT NULL UNIQUE,
    "AVAILABLE_POINTS" INTEGER NOT NULL,
    "LIFETIME_POINTS"  INTEGER NOT NULL,
    "ENROLLMENT_DATE"  TEXT NOT NULL,
    "BIRTHDAY"         TEXT NOT NULL,
    PRIMARY KEY("MEMBER_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "INVENTORY_ORDER" (
    "INVENTORY_ORDER_ID" INTEGER NOT NULL,
    "SUPPLIER_ID"        INTEGER NOT NULL,
    "PURCHASE_DATE"      TEXT NOT NULL,
    "TOTAL_PRICE"        REAL,
    FOREIGN KEY("SUPPLIER_ID") REFERENCES "SUPPLIER"("SUPPLIER_ID"),
    PRIMARY KEY("INVENTORY_ORDER_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "INGREDIENT" (
    "INGREDIENT_ID"        INTEGER NOT NULL,
    "NAME"                 TEXT NOT NULL,
    "SHELF_LIFE_DAYS"      TEXT NOT NULL,
    "STORAGE_PROTOCOL_ID"  INTEGER NOT NULL,
    "ALLERGEN_ID"          INTEGER,
    FOREIGN KEY("STORAGE_PROTOCOL_ID") REFERENCES "STORAGE_PROTOCOL"("STORAGE_PROTOCOL_ID"),
    FOREIGN KEY("ALLERGEN_ID") REFERENCES "ALLERGEN"("ALLERGEN_ID"),
    PRIMARY KEY("INGREDIENT_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "INVENTORY_ORDER_DETAILS" (
    "INVENTORY_ORDER_DETAILS_ID" INTEGER NOT NULL,
    "INGREDIENT_ID"             INTEGER NOT NULL,
    "INVENTORY_ORDER_ID"        INTEGER NOT NULL,
    "QUANTITY_IN_ORDER"         INTEGER NOT NULL,
    "COST_PER_INGREDIENT"       REAL NOT NULL,
    FOREIGN KEY("INVENTORY_ORDER_ID") REFERENCES "INVENTORY_ORDER"("INVENTORY_ORDER_ID"),
    FOREIGN KEY("INGREDIENT_ID") REFERENCES "INGREDIENT"("INGREDIENT_ID"),
    PRIMARY KEY("INVENTORY_ORDER_DETAILS_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "INVENTORY" (
    "INGREDIENT_ID"          INTEGER NOT NULL,
    "QUANTITY_IN_INVENTORY"  INTEGER NOT NULL,
    FOREIGN KEY("INGREDIENT_ID") REFERENCES "INGREDIENT"("INGREDIENT_ID")
);

CREATE TABLE IF NOT EXISTS "MENU_ITEM" (
    "MENU_ITEM_ID"   INTEGER NOT NULL,
    "RECIPE_ID"      INTEGER NOT NULL,
    "MENU_ITEM_NAME" TEXT NOT NULL,
    "DESCRIPTION"    TEXT NOT NULL,
    "PRICE"          REAL NOT NULL,
    FOREIGN KEY("RECIPE_ID") REFERENCES "RECIPE"("RECIPE_ID"),
    PRIMARY KEY("MENU_ITEM_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "CUSTOMER_ORDER" (
    "CUSTOMER_ORDER_ID" INTEGER NOT NULL,
    "DATE"              TEXT NOT NULL,
    "TIME_OF_PURCHASE"  TEXT NOT NULL,
    "MEMBER_ID"         INTEGER,
    "EMPLOYEE_ID"       INTEGER NOT NULL,
    "TOTAL_PRICE"       REAL,
    FOREIGN KEY("MEMBER_ID") REFERENCES "LOYALTY_MEMBER"("MEMBER_ID"),
    FOREIGN KEY("EMPLOYEE_ID") REFERENCES "EMPLOYEE"("EMPLOYEE_ID"),
    PRIMARY KEY("CUSTOMER_ORDER_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "PAYROLL" (
    "ROLE_ID"          INTEGER NOT NULL,
    "YEARS_IN_SERVICE" INTEGER NOT NULL,
    "HOURLY_PAY"       REAL NOT NULL,
    FOREIGN KEY("ROLE_ID") REFERENCES "ROLE"("ROLE_ID"),
    PRIMARY KEY("ROLE_ID","YEARS_IN_SERVICE")
);

CREATE TABLE IF NOT EXISTS "RECIPE_INSTRUCTIONS" (
    "INSTRUCTION_ID"   INTEGER NOT NULL,
    "RECIPE_ID"        INTEGER NOT NULL,
    "STEP_NUMBER"      INTEGER NOT NULL,
    "INSTRUCTION_TEXT" TEXT NOT NULL,
    FOREIGN KEY("RECIPE_ID") REFERENCES "RECIPE"("RECIPE_ID"),
    PRIMARY KEY("INSTRUCTION_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "CUSTOMER_ORDER_DETAILS" (
    "CUSTOMER_ORDER_ID" INTEGER NOT NULL,
    "MENU_ITEM_ID"      INTEGER NOT NULL,
    "QUANTITY"          INTEGER NOT NULL,
    "CUSTOMIZATION"     TEXT,
    "TOPPINGS"          TEXT,
    "FROSTING"          TEXT,
    FOREIGN KEY("MENU_ITEM_ID") REFERENCES "MENU_ITEM"("MENU_ITEM_ID"),
    FOREIGN KEY("CUSTOMER_ORDER_ID") REFERENCES "CUSTOMER_ORDER"("CUSTOMER_ORDER_ID"),
    PRIMARY KEY("CUSTOMER_ORDER_ID","MENU_ITEM_ID")
);

CREATE TABLE IF NOT EXISTS "ALLERGEN" (
    "ALLERGEN_ID"           INTEGER NOT NULL,
    "ALLERGEN_NAME"         TEXT NOT NULL,
    "ALLERGEN_DESCRIPTION"  TEXT NOT NULL,
    PRIMARY KEY("ALLERGEN_ID" AUTOINCREMENT)
);

CREATE TABLE IF NOT EXISTS "RECIPE" (
    "RECIPE_ID"       INTEGER NOT NULL,
    "PREP_TIME_MINUTES"       INTEGER,
    "ACTIVE_TIME_MINUTES"     INTEGER,
    "RECIPE_NAME"     TEXT NOT NULL,
    PRIMARY KEY("RECIPE_ID" AUTOINCREMENT)
);

CREATE VIEW ManagerPayrollView AS
SELECT 
    e.EMPLOYEE_ID,
    e.FIRST_NAME,
    e.LAST_NAME,
    r.ROLE_NAME,
    (
        SELECT p.HOURLY_PAY
        FROM PAYROLL p
        WHERE p.ROLE_ID = e.ROLE_ID AND p.YEARS_IN_SERVICE = e.YEARS_IN_SERVICE
    ) AS HOURLY_PAY
FROM EMPLOYEE e
JOIN ROLE r ON e.ROLE_ID = r.ROLE_ID;

CREATE VIEW InventoryView AS
SELECT 
    i.INGREDIENT_ID,
    i.NAME,
    inv.QUANTITY_IN_INVENTORY,
    i.SHELF_LIFE_DAYS,
    sp.MIN_TEMP_CELSUIS,
    sp.MAX_TEMP_CELSUIS,
    sp.OPTIMAL_HUMIDITY_RH
FROM INVENTORY inv
JOIN INGREDIENT i ON inv.INGREDIENT_ID = i.INGREDIENT_ID
JOIN STORAGE_PROTOCOL sp ON i.STORAGE_PROTOCOL_ID = sp.STORAGE_PROTOCOL_ID;

CREATE VIEW GuestMenuView AS
SELECT 
    mi.MENU_ITEM_NAME,
    mi.DESCRIPTION,
    mi.PRICE,
    r.RECIPE_NAME,
    GROUP_CONCAT(i.NAME, ', ') AS INGREDIENTS,
    GROUP_CONCAT(a.ALLERGEN_NAME, ', ') AS ALLERGENS
FROM MENU_ITEM mi
JOIN RECIPE r ON mi.RECIPE_ID = r.RECIPE_ID
JOIN RECIPE_INGREDIENT ri ON r.RECIPE_ID = ri.RECIPE_ID
JOIN INGREDIENT i ON ri.INGREDIENT_ID = i.INGREDIENT_ID
LEFT JOIN ALLERGEN a ON i.ALLERGEN_ID = a.ALLERGEN_ID
GROUP BY mi.MENU_ITEM_NAME, mi.DESCRIPTION, mi.PRICE;

COMMIT;
