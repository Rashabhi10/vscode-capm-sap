namespace rv.demo;

using {
    rv.demo.master,
    rv.demo.transaction
} from './mydb';


context CDSView {

    define view![POWorklist] as
        select from transaction.purchaseorder {
            key PO_ID                             as![PurchaseOrderID],
                PARTNER_GUID.BP_ID                as![BusinessPartnerID],
                PARTNER_GUID.COMPANY_NAME         as![CompanyName],
                GROSS_AMOUNT                      as![GrossAmount],
                NET_AMOUNT                        as![NetAmount],
                TAX_AMOUNT                        as![TaxAmount],
                CURRENCY_CODE                     as![CurrencyCode],
                LIFECYCLE_STATUS                  as![POStatus],
            key Items.PO_ITEM_POS                 as![POItem],
                Items.PRODUCT_GUID.PRODUCT_ID     as![ProductID],
                Items.PRODUCT_GUID.DESCRIPTION    as![ProductName],
                PARTNER_GUID.ADDRESS_GUID.CITY    as![City],
                PARTNER_GUID.ADDRESS_GUID.COUNTRY as![Country],
                Items.GROSS_AMOUNT                as![POItemGrossAmount],
                Items.NET_AMOUNT                  as![POItemNetAmount],
                Items.TAX_AMOUNT                  as![POItemTaxAmount]

        };

    define view![ProductValueHelp] as
        select from master.product {
            @EndUserText.label : [{
                language : 'EN',
                text     : 'Product ID'
            }, {
                language : 'DE',
                text     : 'Prodekt ID'
            }]
            PRODUCT_ID  as![ProductID],
            @EndUserText.label : [{
                language : 'EN',
                text     : 'Product Desc'
            }, {
                language : 'EN',
                text     : 'Product Desc'
            }]
            DESCRIPTION as![Desscription]
        };

    define view![ItemView] as
        select from transaction.poitems {
            PARENT_KEY.PARTNER_GUID.NODE_KEY as![Partner],
            PRODUCT_GUID.NODE_KEY            as![ProductID],
            CURRENCY_CODE                    as![CurrencyCode],
            NET_AMOUNT                       as![NetAmount],
            GROSS_AMOUNT                     as![GrossAmount],
            TAX_AMOUNT                       as![TaxAmount],
            PARENT_KEY.OVERALL_STATUS        as![POStatus]
        };

    define view![ProductViewSum] as
        select from master.product as prod {
            PRODUCT_ID        as ![ProductID],
            texts.DESCRIPTION as ![ProductDescription],
            (
                select from transaction.poitems as a {
                    SUM(
                        a.GROSS_AMOUNT
                    ) as SUM
                }
                where
                    a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
            )                 as PO_SUM
        };

    define view![ProductView] as
        select from master.product
        mixin {
            PO_ORDERS : Association[ * ] to ItemView
                            on PO_ORDERS.ProductID = $projection.ProductID
        }
        into {
            NODE_KEY                           as![ProductID],
            DESCRIPTION,
            CATEGORY                           as![Category],
            PRICE                              as![Price],
            TYPE_CODE                          as![TypeCode],
            SUPPLIER_GUID.BP_ID                as![PartnerID],
            SUPPLIER_GUID.COMPANY_NAME         as![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY    as![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as![Country],
            //Exposed  Association, lazy loading
            PO_ORDERS
        };

    define view![CProductView] as
        select from ProductView {
            PartnerID              as![ProductID],
            Country                as![Country],
            PO_ORDERS.CurrencyCode as![CurrencyCode],
            sum(
                PO_ORDERS.GrossAmount
            )                      as![POGrossAmount]
        }
        group by
            ProductID,
            Country,
            PO_ORDERS.CurrencyCode

}
