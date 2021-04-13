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
            sflight  : Association to many sflight
                           on sflight.carrid = $self;
    }

    entity sflight : cuid {
        key carrid     : Association to scarr;
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
