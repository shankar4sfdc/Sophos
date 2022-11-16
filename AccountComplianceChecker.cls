/**
 *  Checks the compliance for Account
 *  called from ComplainceCheckFactory
 *  @author RaviSankar Siddam
 *  @since  03/09/2019
 */
public class AccountComplianceChecker Extends ComplianceChecker{

    public static AccountComplianceChecker instance = null;
    
    @testVisible    
    public Boolean isCompliant {get; private set;}
    
    public static List<Account> accounts  = new List<Account>();
    public static List<Country__c> countries  = new List<Country__c>();
    public static Set<AddressComplianceChecker.Address> addressList  = new Set<AddressComplianceChecker.Address>();
    public AddressComplianceChecker.Address address;   
    
    //Private Constructor with sObject List as parameter
    private AccountComplianceChecker(List<Sobject> sobjectRecords)
    {
    	isCompliant = true;    	
    	accounts = (List<Account>) sobjectRecords;
    }        
   
    //checkCompliance method which will be called after complianceChecker
    //is instantiated in the getComplianceChecker() method from the factory class
    //Need to add more logic to call the checkcompliance of addresschecker and
    //logic to check compliance of account object fields
    public override Boolean checkCompliance() {
    
        system.debug('I am in checkcompliance in Account');
        
        //For Each account in the list get the billing country and add to countries list for checking the compliance
        //Also get the alt address, billing and shipping address and add to address list for compliance check    
        for(Account acc: accounts)
        {
          //To get the billing country and add to list of countries for compliance check	
          Country__c con = new Country__c(id= acc.Billing_Country__c, name=acc.Billing_Country__r.name, Export_prohibited__c=acc.Billing_Country__r.Export_prohibited__c);
          if(!countries.contains(con))             
          countries.add(con);
          
          //To get the different address to add to list of addresses for compliance check
          if(acc.ALT_City__c!=null)
          {
           address = new AddressComplianceChecker.Address(acc.ALT_City__c, acc.ALT_Country__c);
           if (!addressList.contains(address))
           {
           	addressList.add(address);
           }        
          }
          
          if(acc.BillingCity!=null)
          {
           address = new AddressComplianceChecker.Address(acc.BillingCity, acc.BillingCountry);
           if (!addressList.contains(address))
           {
           	addressList.add(address);
           }        
          }
          
          if(acc.ShippingCity!=null)
          {
           address = new AddressComplianceChecker.Address(acc.ShippingCity, acc.ShippingCountry);
           if (!addressList.contains(address))
           {
           	addressList.add(address);
           }        
          }
        }
        
        // Calling the getInstance static method from Factory class for countries list    
        ComplianceCheckFactory factory = ComplianceCheckFactory.getInstance(countries);          
          
        // Calling the getComplainceChecker method from Factory class for countries list
        ComplianceChecker achecker = factory.getComplianceChecker(countries);
          
        isCompliant = achecker.checkCompliance();
        
        return isCompliant;       

    }
       
    // a static method that returns the instance of the record type
    public static AccountComplianceChecker getInstance(List<Sobject> sobjectRecords){    	

      //only initialize the instance if it doesn't already exist. If it exists add the new list of accounts to the existing list
      //for compliance check
      if (instance == null) instance = new AccountComplianceChecker(sobjectRecords); else 
      {
      	   for(Sobject sObj:sobjectRecords)
      	   {
      	   	Account acc = (Account)sObj;
      	   	if(!accounts.isEmpty() && !accounts.contains(acc))
      	   	{
      	   		accounts.add(acc);
      	   	}
      	   }
      }
          
      return instance;
    }
}