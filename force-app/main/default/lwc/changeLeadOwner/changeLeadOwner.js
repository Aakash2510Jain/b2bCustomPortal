import { LightningElement, api, track } from 'lwc';
import updateOwner from '@salesforce/apex/changeLeadOwnerHelper.updateOwner';
import { CloseActionScreenEvent} from 'lightning/actions';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class ChangeLeadOwner extends NavigationMixin(LightningElement) {

    @api recordId;
    @track boolVisible = true;
    @track objName = '';

    connectedCallback(){
        setTimeout(()=>{
            debugger;
            this.doUpdate();
        },300);
    }

    doUpdate(){
        debugger;
        updateOwner({leadId : this.recordId, objName : 'Lead'}).then(result =>{
            debugger;
            console.log('RESULT -- ', result);          
            this.handleListViewNavigation();
            this.boolVisible = false;
            this.dispatchEvent(new CloseActionScreenEvent());
        }).catch(error =>{
            console.log('ERROR -- ', error);
            this.showNotification('Error', error.body.message, 'error');
            this.boolVisible = false;
            this.dispatchEvent(new CloseActionScreenEvent());
        })
        
    }

    handleListViewNavigation() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Lead',
                actionName: 'list'
            },
            state: {
                filterName: 'Recent' 
            }
        });
    }

    showNotification(title, message, variant){
        debugger;
        //alert('TOAST');
        const evt = new ShowToastEvent({
            title : title,
            message : message,
            variant : variant
        });
        this.dispatchEvent(evt);
    }

    updateView(){
        debugger;
        alert('VIEW');
        setTimeout(() =>{
            eval("$A.get('e.force:refreshView').fire();");
        }, 300);
    }
}