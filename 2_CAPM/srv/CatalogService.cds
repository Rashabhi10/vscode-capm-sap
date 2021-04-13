using {
    rv.demo.master,
    rv.demo.transaction
} from '../db/mydb';

service CalatogService @(path : '/CatalogService') {

    entity addressSet                          as projection on master.address;
    entity bpSet                               as projection on master.bp;
    entity employeesSet                        as projection on master.employees;
    // entity prodtextSet      as projection on master.prodtext;
    entity productSet                          as projection on master.product;

    entity pohead @(title : '{i18n>pohead}')   as projection on transaction.purchaseorder {
        * , Items : redirected to POitems
    }

    entity POitems @(title : '{i18n>poitems}') as projection on transaction.poitems {
        * , PARENT_KEY : redirected to pohead, PRODUCT_GUID : redirected to productSet
    }
}
