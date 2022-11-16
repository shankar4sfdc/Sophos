@isTest
public class ComplianceCheckServiceTest {

    static testMethod void testOneCountryNotCompliant() {
        
        List<Country__c> countries = new List<Country__c>();
                 
        Country__c c1 = new Country__c(Name = 'Test Country1', ISO_Code__c = 'TC', Export_Prohibited__c= True);
        countries.add(c1);
        
        Country__c c2 = new Country__c(Name = 'Test Country2', ISO_Code__c = 'TC', Export_Prohibited__c= False);
        countries.add(c2);
        
        insert countries;
        
        List<SObject> sObj = new  List<SObject>();        
     
        for(Country__c c :[Select 
                              Id
                             ,Export_Prohibited__c 
                             from Country__c 
                             where name =:countries[0].Name 
                             or name =:countries[1].Name ])
        {
       	 sObj.add(c);
       	 system.debug('Country: '+c.Id);
        }       

        ComplianceCheckService ccs = new ComplianceCheckService();
        ccs.checkCompliance(sObj); 
        system.assertequals(ccs.ComplianceOK,false);        
    }    
 
    public static testMethod void testTwoInstances() {
        
        List<Country__c> countries = new List<Country__c>();
                 
        Country__c c1 = new Country__c(Name = 'Test Country1', ISO_Code__c = 'TC', Export_Prohibited__c= True);
        countries.add(c1);
        
        Country__c c2 = new Country__c(Name = 'Test Country2', ISO_Code__c = 'TC', Export_Prohibited__c= False);
        countries.add(c2);
        
        insert countries;
        
        List<SObject> sObj = new  List<SObject>();        
     
        for(Country__c c :[Select 
                              Id
                             ,Export_Prohibited__c 
                             from Country__c 
                             where name =:countries[0].Name 
                             or name =:countries[1].Name ])
        {
       	 sObj.add(c);
       	 system.debug('Country: '+c.Id);
        }       
             

        CountryComplianceChecker ccf = CountryComplianceChecker.getInstance(sObj);
        ccf.checkCompliance();
        
        List<Country__c> countries2 = new List<Country__c>();
                 
        Country__c c3 = new Country__c(Name = 'Test Country3', ISO_Code__c = 'TC', Export_Prohibited__c= True);
        countries2.add(c3);
        
        Country__c c4 = new Country__c(Name = 'Test Country4', ISO_Code__c = 'TC', Export_Prohibited__c= True);
        countries2.add(c4);
        
        insert countries2;
        
        List<SObject> sObj2 = new  List<SObject>();        
     
        for(Country__c c :[Select 
                              Id
                             ,Export_Prohibited__c 
                             from Country__c 
                             where name =:countries[0].Name 
                             or name =:countries[1].Name ])
        {
       	 sObj2.add(c);
       	 system.debug('Country: '+c.Id);
        }            
        
        CountryComplianceChecker ccf2 = CountryComplianceChecker.getInstance(sObj2);
        ccf2.checkCompliance();
        
        system.debug(ccf.isCompliant);
        system.debug(ccf2.isCompliant);
        
        //system.debug(ccf.instance);
        //system.debug(ccf2.instance);
        system.assertequals(ccf.isCompliant,false);
        system.assertequals(ccf2.isCompliant,false);          
     
    }      
}