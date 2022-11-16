/*
    AUTHOR:         RaviSankar Siddam
    NAME:           ComplianceChecker
    CALLED FROM:    ComplianceChecker
    DESCRIPTION:    Manages calls to the respective sobject compliance checker class and instantiates a single instance of the same
    TEST CLASS:     ComplianceCheckerTest.
    NOTE:           None.
*/
	public abstract class ComplianceChecker {
		
		public static ComplianceChecker instance = null;
		
		public Boolean isCompliant {get; set;}
		
		public Map<String,SObject> ObjectsToCheck = new Map<String,Sobject>();
		
		public virtual Boolean checkCompliance() {			
		
		 return isCompliant;
		}
		
        // a static method that returns the instance of the record type
        public static ComplianceChecker getInstance(List<Sobject> sobjectRecords){
        //only initialize if it doesn't already exist
        //if(instance == null) instance = new ComplianceChecker();
          return instance;
        }
        
	}