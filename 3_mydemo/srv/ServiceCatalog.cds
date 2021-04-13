using {rv.db.airline} from '../db/first';

service ServiceCatalog @(path : '/ServiceCatalog') {
    entity scarrSet   as projection on airline.scarr;
    entity sflightSet as projection on airline.sflight;
}
