/**
 *  Checks the compliance for Country
 *  called from ComplainceCheckFactory
 *  @author RaviSankar Siddam
 *  @since  26/08/2019
 */
public class CountryComplianceChecker Extends ComplianceChecker{

    public static CountryComplianceChecker instance = null;
    
    @testVisible    
    public Boolean isCompliant {get; private set;}
    public static List<Country__c> countries  = new List<Country__c>();  
    
    //Private Constructor with sObject List as parameter
    private CountryComplianceChecker(List<Sobject> sobjectRecords)
    {
    	isCompliant = true;    	
    	countries = (List<Country__c>) sobjectRecords;
    }        
    
    //checkCompliance method which will be called after complianceChecker
    //is instantiated in the getComplianceChecker() method from the factory class
    public override Boolean checkCompliance() {
    
    system.debug('I am in checkcompliance in country');
            for(Country__c country: countries)
            {
              if(country.Export_Prohibited__c){
                 isCompliant = false;
                 system.debug('one of the country is non compliant');                           
               }              
            }
                        
            return isCompliant;    
    }
       
    // a static method that returns the instance of the record type
    public static CountryComplianceChecker getInstance(List<Sobject> sobjectRecords){    	

      //only initialize if it doesn't already exist
      if
       (instance == null) instance = new CountryComplianceChecker(sobjectRecords); else 
      {
      	   for(Sobject sObj:sobjectRecords)
      	   {
      	   	Country__c con = (Country__c)sObj;
      	   	if(!countries.isEmpty() && !countries.contains(con))
      	   	{
      	   		countries.add(con);
      	   	}
      	   }
      }
          
      return instance;
    }    
    

}