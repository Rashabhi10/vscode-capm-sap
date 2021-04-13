using {rv.demo.CDSView} from '../db/CDSView';

service CDSService @(path : '/CDSService') {

    entity POWorklist as projection on CDSView.POWorklist;

}
