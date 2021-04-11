using {rv.db.airline} from '../db/first';

service ServiceCatalog @(path : '/ServiceCatalog') {
    entity scarr   as projection on airline.scarr;
    entity sflight as projection on airline.sflight;
}
