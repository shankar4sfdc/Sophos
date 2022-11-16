
/**
 *  Calls and instantiates a single instance of ComplianceCheckFactory Class
 *  called from ComplainceCheckService and test class used ComplainceCheckFactoryTest
 *  @author RaviSankar Siddam
 *  @since  26/08/2019
 */
	public class ComplianceCheckFactory {		
      
        //interface for complianceCheckable 
        public interface complianceCheckable
        {
          void getKey();          
          void equals(Object obj);          
        }
        
        public Boolean ComplianceOK {get; private set;} 
        
        private static ComplianceCheckFactory instance = null;
   
   //Get Complaince Checker Method which is called from compliance service class
   //This checks the instance of the Sobject and instantiates
   //the relevant Complaince checker class and calls the checkComplaince method from that      
        public ComplianceChecker getComplianceChecker(List<Sobject> objRec)
		{
			ComplianceChecker ccc = null;

			system.debug('I am in getcompliancechecker');
			
     		If (objRec.get(0) instanceof Country__c) {                
			//If the sobject is instanceof country
                ccc = CountryComplianceChecker.getInstance(objRec);                    
            }Else If (objRec.get(0) instanceof Account) {                
             //If the sobject is instanceof Account
                ccc = AccountComplianceChecker.getInstance(objRec);   
            }               
        
            return ccc;	
		}

		
	    // a static method that returns the instance of the record type
        public static ComplianceCheckFactory getInstance(List<SObject> sobjectRecords){
        //only initialize if it doesn't already exist
        //creating New instance if doesn't Exits
          if(instance == null) instance = new ComplianceCheckFactory();
          system.debug('I am in factory class getinstance method');
          return instance;
        }
        
	}