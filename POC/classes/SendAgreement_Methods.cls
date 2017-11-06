public class SendAgreement_Methods 
{
    public static void sendAgreement(Id temId, Id cntId)
    {
   // String tempid='a0G7F000000X7SH';
    //String mstid='0037F000004u1Q7';
    echosign_dev1.AgreementTemplateService.load(temid, cntid);
    echosign_dev1__SIGN_Agreement__c test=[Select id from echosign_dev1__SIGN_Agreement__c order by createddate desc limit 1];
        system.debug('testid'+test.Id);
    echosign_dev1.EchoSignApiService.sendDocument(test.Id);
    }
 /* @future (callout=true)
    public static void sendAgreement(Id temId, Id cntId)
    {
        System.debug('FutureTested');
       String endpoint='https://api.na1.echosign.com/api/rest/v5/agreements';
            HttpRequest req = new HttpRequest(); 
            req.setEndpoint(endPoint); 
            req.setMethod('POST'); 
            req.setHeader('Access-Token', '3AAABLblqZhBIj0nKCPq3AAyVhjci36d2QjYYS3YAwvAUmT1qJXe6qReWS9aw6K4IJCjTnng_ZZ2H_3nCuoLIL-QvVviOPAmL'); 
            req.setHeader('Content-Type','application/json'); 
            String json='{'+
' '+   
    '"documentCreationInfo":{'+      
     '   "fileInfos":[{'+
      '      "transientDocumentId":"3AAABLblqZhD0tVrfkIunSURkwWH3Tnvfp7Kz6_EldDUGyCRWB084_DdMhfxBkmbVFMJGRnE5tTdisjqtngon3OeLB2fqcUltBrYUH7KWVb8LFAPNhMlTK-b24BDclX8bzAcj6hJ6nqBR_wpS8jAJFYi9JjkbqdnPzo0NOLkz55_j83yI0O1DmzGVUKWwcFB_OnXZdfWeI55-UTAVIFvSkGfWxFre6o8yQzXxiOdW2YI_ntDDjcxgpWCuINymiWZmHGk6c0T5WkeFcBTW04SI-PMnBVlc-UjNgPrB08d9l6UYfCcZMLaBB8X6tbKIZeoKwNibNklnsbQ**"'+         
       '  }],'+      
        '"name":"MyTestAgreement",'+  
        '"recipientSetInfos":['+
        '    {'+
         '       "recipientSetMemberInfos":['+
          '          {'+
           '             "email":"vignesh4812@gmail.com"'+
            '        }'+
             '    ],'+            
              '  "recipientSetRole":"SIGNER"'+
            '}'+
       ' ],'+      
        '"signatureType":"ESIGN",'+      
        '"signatureFlow":"SENDER_SIGNATURE_NOT_REQUIRED"'+   
    '}'+
'}';
            req.setBody(json); 
            Http http = new Http(); 
            HTTPResponse res; 
            try{ 
                
                res = http.send(req); 
                system.debug('Response'+ res.getBody()); 
            } 
            catch(Exception e){ 
               System.debug('e'+e);
                //ApexPages.addMessage( new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage())); 
            }  
    }*/
    
}