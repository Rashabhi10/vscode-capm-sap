using {
    rv.demo.master,
    rv.demo.transaction
} from '../db/mydb';

service CalatogService @(path : '/CatalogService') {

    entity addressSet       as projection on master.address;
    entity bpSet            as projection on master.bp;
    entity employeesSet     as projection on master.employees;
    entity prodtextSet      as projection on master.prodtext;
    entity productSet       as projection on master.product;
    entity poitemSet        as projection on transaction.poitems;
    entity purchaseorderSet as projection on transaction.purchaseorder;
}
