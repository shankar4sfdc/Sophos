/**
 *  Checks the compliance for Address
 *  called from AddressComplianceChecker
 *  @author RaviSankar Siddam
 *  @since  26/08/2019
 */
public class AddressComplianceChecker Extends ComplianceChecker{

    public static AddressComplianceChecker instance = null;
    
    @testVisible    
    public Boolean isCompliant {get; private set;}
    private List<Country__c> countries;
    private Set<Address> addressSet = new Set<Address>();
    
    //Private Constructor with sObject List as parameter
    private AddressComplianceChecker(Set<Address> addressList)
    {
    	setObjectsToCheck(addressList);
    }
    
    //A setObjectsToCheck method to add the list of addresses that need to be compliance checked
    //to a set which needs to be called from the getinstance() static method
    public void setObjectsToCheck(Set<Address> addressList)
    {
    	
    }          
  
    //checkCompliance method which will be called after complianceChecker
    //is instantiated in the getComplianceChecker() method from the factory class
    //Logic needs to be implemented for addressChecker 
    public override Boolean checkCompliance() {
    	
    	return isCompliant;                       

    }
       
    // a static method that returns the instance of the record type
    public static AddressComplianceChecker getInstance(Set<Address> addressList){
      //only initialize if it doesn't already exist
      if(instance == null) instance = new AddressComplianceChecker(addressList);
          return instance;
    }
    
    //Inner Address class to create a wrapper object of the address fields 
    //and implement getkey() method
    public class Address 
    {
    	String addressKey {get; private set;}
    	String city {get; private set;}
    	String countryISOCode {get; private set;}
    	
    	public Address(String objCity,String objcountryISOCode)
    	{
    		city = objCity;
    		countryISOCode = objcountryISOCode;
    		addressKey = getKey();  	
    	}
   	
    	public String getKey()
    	{
    		return countryISOCode + city;
    	}   	   	   	
   	 
    }
}