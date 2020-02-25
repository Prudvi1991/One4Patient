//
//  Preferences.swift
//  Medico
//
//  Created by Lallu Sukendh on 27/03/18.
//  Copyright © 2018 g10solution. All rights reserved.
//

import Foundation

class Preferences {
    

    class func setUserToken(type: String) {
        UserDefaults.standard.set(type, forKey: "user_token")
    }
    
    class func getUserToken() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "user_token") {
            return type
        } else {
            return ""
        }
    }
    
    class func setslotId(firstName: String) {
        UserDefaults.standard.set(firstName, forKey: "slot_id")
    }
    
    class func getslotId() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "slot_id") {
            return type
        } else {
            return ""
        }
    }
    
    class func setLoginStatus(status: Bool) {
        UserDefaults.standard.set(status, forKey: "login_status")
    }
    

    
    class func getLoginStatus() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "login_status")
        return status
    }
    
    
  
    
    class func setKey(type: String) {
        UserDefaults.standard.set(type, forKey: "key_value")
    }
    
    class func getKey() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "key_value") {
            return type
        } else {
            return ""
        }
    }
    
    class func setTimeZone(type: String) {
        UserDefaults.standard.set(type, forKey: "timezone_value")
    }
    
    class func getTimeZone() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "timezone_value") {
            return type
        } else {
            return ""
        }
    }
    
    class func setCategoryId(type: String) {
        UserDefaults.standard.set(type, forKey: "category_id")
    }
    
    class func getCategoryId() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "category_id") {
            return type
        } else {
            return ""
        }
    }
    
    class func setEventId(type: String) {
        UserDefaults.standard.set(type, forKey: "event_id")
    }
    
    class func getEventId() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "event_id") {
            return type
        } else {
            return ""
        }
    }
    
    class func setProfileId(profileId: String) {
        UserDefaults.standard.set(profileId, forKey: "profile_id")
    }
    
    class func getProfileId() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "profile_id") {
            print(type)
            return type
        } else {
            return ""
        }
    }
    
    class func setUserFirstName(firstName: String) {
        UserDefaults.standard.set(firstName, forKey: "first_name")
    }
    
    class func getUserFirstName() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "first_name") {
            return type
        } else {
            return ""
        }
    }
    
    //Last name
    class func setUserLastName(lastName: String) {
        UserDefaults.standard.set(lastName, forKey: "last_name")
        
        
    }
    
    class func getUserLastName() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "last_name") {
            print(type)
            return type
        } else {
            return ""
        }
    }
    
    //Specialty
    
    class func setUserSpeciality(userSpeciality: String) {
        UserDefaults.standard.set(userSpeciality, forKey: "speciality_name")
    }
    
    class func getUserSpeciality() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "speciality_name") {
            
            return type
        } else {
            return ""
        }
    }
    class func setGender(userSpeciality: String) {
        UserDefaults.standard.set(userSpeciality, forKey: "gender")
    }
    
    class func getGender() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "gender") {
            return type
        } else {
            return ""
        }
    }
    
    
    class func setInpractice(userSpeciality: String) {
        UserDefaults.standard.set(userSpeciality, forKey: "in_practice")
    }
    
    class func getInpractice() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "in_practice") {
            return type
        } else {
            return ""
        }
    }
    
    class func setHospitalId(HospitalId: String) {
        UserDefaults.standard.set(HospitalId, forKey: "hospital_id")
    }
    
    class func getHospitalId() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "hospital_id") {
            return type
        } else {
            return ""
        }
    }
    
    class func setDomainName(userNAme: String) {
        UserDefaults.standard.set(userNAme, forKey: "domain_name")
    }
    
    class func getDomainName() -> String {
        if let userNAme: String = UserDefaults.standard.string(forKey: "domain_name") {
            return userNAme
        } else {
            return ""
        }
    }
    
    class func setMobPrefix(prefix: String) {
        UserDefaults.standard.set(prefix, forKey: "prefix")
    }
    
    class func getPrefix() -> String {
        if let prefix: String = UserDefaults.standard.string(forKey: "prefix") {
            return prefix
        } else {
            return ""
        }
    }
    
    class func setMobileNo(mobile: String) {
        UserDefaults.standard.set(mobile, forKey: "mobile_no")
    }
    
    class func getMobileNo() -> String {
        if let mobile: String = UserDefaults.standard.string(forKey: "mobile_no") {
            return mobile
        } else {
            return ""
        }
    }
    
    class func setBHSApproveStatus(status: Bool) {
        UserDefaults.standard.set(status, forKey: "bhs_approve_status")
    }
    
    class func getBHSApproveStatus() -> Bool {
        let status: Bool = UserDefaults.standard.bool(forKey: "bhs_approve_status")
        return status
    }
    

    
    class func setProfileImageUrl(imageUrl: String) {
        UserDefaults.standard.set(imageUrl, forKey: "profile_image_url")
    }
    
    class func getProfileImageUrl() -> String {
        if let image: String = UserDefaults.standard.string(forKey: "profile_image_url") {
            return image
        } else {
            return ""
        }
    }
    
    class func clearPreference () {
        UserDefaults.standard.removeObject(forKey: "user_name")
        UserDefaults.standard.removeObject(forKey: "password")
        UserDefaults.standard.removeObject(forKey: "isUserLogin")
        UserDefaults.standard.removeObject(forKey: "profile_id")
        UserDefaults.standard.removeObject(forKey: "first_name")
        UserDefaults.standard.removeObject(forKey: "last_name")
    }
}

class UserInfo {
    
    class func setUserEmail(type: String) {
        UserDefaults.standard.set(type, forKey: "user_email")
    }
    
    class func getUserEmail() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "user_email") {
            return type
        } else {
            return ""
        }
    }
    
    class func setUserPass(type: String) {
           UserDefaults.standard.set(type, forKey: "user_Pass")
       }
       
       class func getUserPass() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "user_Pass") {
               return type
           } else {
               return ""
           }
       }
    
    class func setGetMe(type: Bool) {
              UserDefaults.standard.set(type, forKey: "user_Me")
          }
          
          class func getGetMe() -> Bool {
            if let type:Bool = UserDefaults.standard.bool(forKey: "user_Me") {
                  return type
              } else {
                  return false
              }
          }
       
       
    
    
}



class DoctorInfo {
    
    class func setDocName(type: String) {
        UserDefaults.standard.set(type, forKey: "doctor_name")
    }
    
    class func getDocName() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "doctor_name") {
            return type
        } else {
            return ""
        }
    }
    
    
    class func setDocImg(type: String) {

        UserDefaults.standard.set(type, forKey: "doctor_IMG")
    }
    
    class func getDocImg() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "doctor_IMG") {
            return type
        } else {
            return ""
        }
    }
    
    
}
class ChatInfo {
    
    class func setDocName(type: String) {
        UserDefaults.standard.set(type, forKey: "chatDocName")
    }
    
    class func getDocName() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "chatDocName") {
            return type
        } else {
            return ""
        }
    }
    
    
    class func setDocImg(type: String) {

        UserDefaults.standard.set(type, forKey: "chatDocImg")
    }
    
    class func getDocImg() -> String {
        if let type: String = UserDefaults.standard.string(forKey: "chatDocImg") {
            return type
        } else {
            return ""
        }
    }
    
    
}

// Account Information
class AccountInfo {
    
    class func setUserName(type:String) {
           UserDefaults.standard.set(type, forKey: "user_name")
           
           }
       
       class func getUserName() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "user_name") {
               print(type)
               return type
           } else {
               return ""
           }
       }
    class func setUserEmail(type: String) {
              UserDefaults.standard.set(type, forKey: "user_email")
              
              }
          
          class func getUserEmail() -> String {
              if let type: String = UserDefaults.standard.string(forKey: "user_email") {
                  print(type)
                  return type
              } else {
                  return ""
              }
          }
       
       class func setUserMobile(type: String) {
           UserDefaults.standard.set(type, forKey: "user_mobile")
           
           }
       
       class func getUserMobile() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "user_mobile") {
               print(type)
               return type
           } else {
               return ""
           }
       }
      class func setAccountID(type: Int) {
         UserDefaults.standard.set(type, forKey: "account_ID")
         }
                 
         class func getAccountID() -> Int {
         if let type: Int = UserDefaults.standard.integer(forKey: "account_ID") {
         print(type)
         return type
         } else {
         return 0
         }
         }
    class func setEducationID(type: Int) {
    UserDefaults.standard.set(type, forKey: "Education_ID")
    }
            
    class func getEducationID() -> Int {
    if let type: Int = UserDefaults.standard.integer(forKey: "Education_ID") {
    print(type)
    return type
    } else {
    return 0
    }
    }
    
    class func setSplID(type: Int) {
       UserDefaults.standard.set(type, forKey: "Spl_ID")
       }
               
       class func getSplID() -> Int {
       if let type: Int = UserDefaults.standard.integer(forKey: "Spl_ID") {
       print(type)
       return type
       } else {
       return 0
       }
       }
    
    class func setProfileID(type: Int) {
       UserDefaults.standard.set(type, forKey: "profileID")
       }
               
       class func getProfileID() -> Int {
       if let type: Int = UserDefaults.standard.integer(forKey: "profileID") {
       print(type)
       return type
       } else {
       return 0
       }
       }
       
    class func setFirstName(type: String) {
       UserDefaults.standard.set(type, forKey: "first_name")
       }
               
       class func getFirstName() -> String {
       if let type: String = UserDefaults.standard.string(forKey: "first_name") {
       print(type)
       return type
       } else {
       return ""
       }
       }
       
    class func setLastName(type: String) {
       UserDefaults.standard.set(type, forKey: "last_name")
       }
               
//       class func getAccountID() -> String {
//       if let type: String = UserDefaults.standard.string(forKey: "last_name") {
//       print(type)
//       return type
//       } else {
//       return ""
//       }
//       }
    
    class func setUserDOB(type: String) {
          UserDefaults.standard.set(type, forKey: "DateofBirth")
          }
                  
          class func getUserDOB() -> String {
          if let type: String = UserDefaults.standard.string(forKey: "DateofBirth") {
          print(type)
          return type
          } else {
          return ""
          }
          }
    class func setUserGen(type: String) {
    UserDefaults.standard.set(type, forKey: "user_Gender")
    }
            
    class func getUserGen() -> String {
    if let type: String = UserDefaults.standard.string(forKey: "user_Gender") {
    print(type)
    return type
    } else {
    return ""
    }
    }
    
    class func setUserImg(type: String) {
       UserDefaults.standard.set(type, forKey: "user_Img")
       }
               
       class func getUserImg() -> String {
       if let type: String = UserDefaults.standard.string(forKey: "user_Img") {
       print(type)
       return type
       } else {
       return ""
       }
       }
       
          

    
    
    
    
}

class AppointmentInfo {
    
    class func setDocName(type: String) {
           UserDefaults.standard.set(type, forKey: "chatDocName")
       }
       
       class func getDocName() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "chatDocName") {
               return type
           } else {
               return ""
           }
       }
       
       
       class func setDocImg(type: String) {

           UserDefaults.standard.set(type, forKey: "chatDocImg")
       }
       
       class func getDocImg() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "chatDocImg") {
               return type
           } else {
               return ""
           }
       }
       
    class func setDocDegree(type: String) {
           UserDefaults.standard.set(type, forKey: "doc_degree")
       }
       
       class func getDocDegree() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "doc_degree") {
               return type
           } else {
               return ""
           }
       }
       
       
       class func setDocType(type: String) {

           UserDefaults.standard.set(type, forKey: "doc_type")
       }
       
       class func getDocType() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "doc_type") {
               return type
           } else {
               return ""
           }
       }
    
    class func setAppDate(type: String) {
           UserDefaults.standard.set(type, forKey: "app_date")
       }
       
       class func getAppDate() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "app_date") {
               return type
           } else {
               return ""
           }
       }
       
       
       class func setAppTime(type: String) {

           UserDefaults.standard.set(type, forKey: "app_time")
       }
       
       class func getAppTime() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "app_time") {
               return type
           } else {
               return ""
           }
       }
    class func setAppType(type: String) {
           UserDefaults.standard.set(type, forKey: "app_type")
       }
       
       class func getAppType() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "app_type") {
               return type
           } else {
               return ""
           }
       }
       
       
       class func setConType(type: String) {

           UserDefaults.standard.set(type, forKey: "cont_type")
       }
       
       class func getConType() -> String {
           if let type: String = UserDefaults.standard.string(forKey: "cont_type") {
               return type
           } else {
               return ""
           }
       }

       
    
    
}
