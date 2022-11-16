
/**
 *  Calls and instantiates a single instance of ComplianceCheckFactory Class
 *  called from ComplainceCheck VF page
 *  @author RaviSankar Siddam
 *  @since  27/08/2019
 */
public without sharing class ComplianceCheckService {
	
	    private String queryObjFields {get; set;}
	
        public String objectId {get; private set;}
        
        public Boolean ComplianceOK {get; private set;}
	
	    public ComplianceCheckService() { 
  
	    }
        
        public void checkCompliance(List<String> serialIds)
        {
        	
        }
        //Passing Sobjects to the Complaincecheckerfactory from the Rest/Controller class
	    public Boolean checkCompliance(List<Sobject> sObjList)
        {
          ComplianceCheckFactory factory = ComplianceCheckFactory.getInstance(sObjList);
          
          system.debug('I am in check compliance method');
          
          // Calling the getComplainceChecker method from Factory class
          //which creates an instance of the compliancechecker
          ComplianceChecker achecker = factory.getComplianceChecker(sObjList);
          
          //Calling the checkcompliance method from the relevant compliancechecker
          //based on the sobject type passed
          //achecker.checkCompliance();
         
          return achecker.checkCompliance();
        }        
              
   }