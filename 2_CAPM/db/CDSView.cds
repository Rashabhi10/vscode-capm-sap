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

        }
}
