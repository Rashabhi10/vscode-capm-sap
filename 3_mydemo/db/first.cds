namespace rv.db;

using {
    cuid,
    Currency
} from '@sap/cds/common';

context airline {
    entity scarr : cuid {
        key carrid   : String(3);
            carrname : String(35);
            currcode : Currency;
    }

    entity sflight : cuid {
        key carrid     : String(3);
        key connid     : String(4);
            fldate     : Date;
            price      : Decimal(15, 2);
            currency   : Currency;
            planetype  : String(10);
            seatsmax   : Integer;
            seatsocc   : Integer;
            paymentsum : Decimal(17, 2);
    }
}
