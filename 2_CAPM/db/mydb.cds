namespace rv.demo;

using {
    cuid,
    managed,
    temporal,
    Currency
} from '@sap/cds/common';

using {rv.common} from './common';


type Guid : String(32);


context master {
    entity bp : cuid {
        key NODE_KEY      : Guid;
            BP_ROLE       : String(2);
            EMAIL_ADDRESS : common.Email;
            PHONE_NUMBER  : common.PhoneNumber;
            FAX_NUMBER    : String(32);
            WEB_ADDRESS   : String(44);
            ADDRESS_GUID  : Association to address;
            BP_ID         : String(32);
            COMPANY_NAME  : String(250);
    }

    entity address {
        key NODE_KEY       : Guid;
            CITY           : String(44);
            POSTAL_CODE    : String(8);
            STREET         : String(44);
            BUILDING       : String(128);
            COUNTRY        : String(44);
            ADDRESS_TYPE   : String(44);
            VAL_START_DATE : Date;
            VAL_END_DATE   : Date;
            LATITUDE       : Decimal;
            LONGITUDE      : Decimal;
            BP             : Association to one bp
                                 on BP.ADDRESS_GUID = $self;
    }

    entity employees : cuid {
        nameFirst     : String(40);
        nameMiddle    : String(40);
        nameLast      : String(40);
        nameInitials  : String(40);
        sex           : common.Gender;
        language      : String(1);
        phoneNumber   : common.PhoneNumber;
        email         : common.Email;
        loginName     : String(12);
        Currency      : Currency;
        salaryAmount  : common.AmountT;
        accountNumber : String(16);
        bankId        : String(20);
        bankName      : String(64);
    }

    entity prodtext {
        key NODE_KEY   : Guid;
            PARENT_KEY : Guid;
            LANGUAGE   : String(2);
            TEXT       : String(200);
    }

    entity product {
        key NODE_KEY       : Guid;
            PRODUCT_ID     : String(28);
            TYPE_CODE      : String(2);
            CATEGORY       : String(32);
            DESCRIPTION    : localized String(255);
            SUPPLIER_GUID  : Association to master.bp;
            TAX_TARIF_CODE : Integer;
            MEASURE_UNIT   : String(2);
            WEIGHT_MEASURE : Decimal(5, 2);
            WEIGHT_UNIT    : String(2);
            CURRENCY_CODE  : String(4);
            PRICE          : Decimal(15, 2);
            WIDTH          : Decimal(5, 2);
            DEPTH          : Decimal(5, 2);
            HEIGHT         : Decimal(5, 2);
            DIM_UNIT       : String(2);

    }

}

context transaction {

    entity purchaseorder : common.Amount {
        key NODE_KEY         : Guid;
            PO_ID            : String(24);
            PARTNER_GUID     : Association to master.bp;
            LIFECYCLE_STATUS : String(1);
            OVERALL_STATUS   : String(1);
            Items            : Association to many poitems
                                   on Items.PARENT_KEY = $self
    }

    entity poitems : common.Amount {
        key NODE_KEY     : Guid;
            PARENT_KEY   : Association to purchaseorder;
            PO_ITEM_POS  : Integer;
            PRODUCT_GUID : Association to master.product;

    }

}
