//
//  Copyright © 2019 Matias Marek. All rights reserved.
//

import Foundation


class Hospital {
    
    private var name: String?
    private var adress: String?
    private var latitude: Double?
    private var longtiude: Double?
    
    
    //MARK: Initialization
    init(name: String) {
        
        switch checkSettingsOrReturnParameter(name: name) {
            
        case "Svendborg":
            initializeSvendborg()
            break
            
        case "Ærø":
            initializeÆrø()
            break
            
        case "Odense":
            initializeOdense()
            break
            
        default:
            initializeSvendborg()
        }
    }
    
    
    private func checkSettingsOrReturnParameter(name: String) -> String{
        return getHospitalNameSetting() ?? name
    }
    
    public func getHospitalNameSetting() -> String? {
        return UserDefaults.standard.string(forKey: "name")
    }
    
    public func setDefaultHospital(hospitalName: String) {
        UserDefaults.standard.set(hospitalName, forKey: "name")
    }
    
    private func saveDefaultHospital(hospitalName: String) {
        UserDefaults.standard.set(hospitalName, forKey: "hospitalName")
    }
    
    private func isDeffaultHospitalSet() -> Bool {
        if (loadDefaultHospital() != nil) {
            return true
        }
        return false
    }
    
    private func loadDefaultHospital() -> String? {
        let name = UserDefaults.standard.string(forKey: "hospitalName")
        return name
    }
    
    
    private func initializeSvendborg(){
        self.name = "Svendborg"
        self.adress = "Baagøes Alle 31"
        self.latitude = 55.055721
        self.longtiude = 10.605734
    }
    
    private func initializeÆrø(){
        self.name = "Ærø"
        self.adress = "Sygehusvejen 18, 5970 Ærøskøbing"
        self.latitude = 54.892865
        self.longtiude = 10.406590
    }
    
    private func initializeOdense(){
        self.name = "Odense"
        self.adress = "J. B. Winsløws Vej 4, 5000 Odense"
        self.latitude = 55.384768
        self.longtiude = 10.367734
    }
    
    public func getLatitude() -> Double {
        return self.latitude ?? 0
    }
    
    public func getLongtiude() -> Double {
        return self.longtiude ?? 0  }
    
    public func getHospitalName() -> String {
        return self.name!
    }
    
}



