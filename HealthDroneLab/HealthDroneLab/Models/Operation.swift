import Foundation


// MARK: - OperationPastElement
struct Operation: Codable {
    
    let uniqueIdentifier, company: String
    let geoZone: GeoZone
    let takeOffPosition, landPosition: Position
    let crew: Crew
    let uases: [Uas]
    let status, type: String
    let validationResult: ValidationResult
    let rulesetCode: String
    let flightStatus: Status
    let uas: Uas
    let rural, obstacleRisk: Bool
    let pilotUUID, environment: String
    let crowdRisk: Bool
    let originalGeometry: OriginalGeometry
    let lineOfSightType: String
    
    
    enum CodingKeys: String, CodingKey {
        case uniqueIdentifier, company, geoZone, takeOffPosition, landPosition, crew, uases, status, type, validationResult, rulesetCode, flightStatus, uas, rural, obstacleRisk
        case pilotUUID = "pilotUuid"
        case environment, crowdRisk, originalGeometry, lineOfSightType
    }
    
}

// MARK: - Crew
struct Crew: Codable {
    let contact: Contact
    let pilot: String
    let hasPicture: Bool
}

// MARK: - Contact
struct Contact: Codable {
    let lastName, firstName, email, name: String
}

enum Status: String, Codable {
    case landed = "LANDED"
    
}

// MARK: - GeoZone
struct GeoZone: Codable {
    let startTime, endTime, name: String
    let upperLimit: UpperLimit
}

// MARK: - UpperLimit
struct UpperLimit: Codable {
    let reference: String
    let altitude: Int
    let unit: String
}

// MARK: - Position
struct Position: Codable {
    let longitude, latitude: Double
    
    func getCoordinateAsString() -> String {
        return ("Longitude: \(longitude) Latitude: \(latitude)")
    }
}

// MARK: - OriginalGeometry
struct OriginalGeometry: Codable {
    let type: String
    let coordinates: [[[Double]]]
    
}

// MARK: - Uas
struct Uas: Codable {
    let version: Int
    let uniqueIdentifier: String
    let model: Model
    let series: Series
    let nickname: String
    let mtom: Double
    let flightStatus: Status
    let hasPicture: Bool
    let generalFeatures: GeneralFeatures
    let flightFeatures: FlightFeatures
    let controllerFeatures: ControllerFeatures
    let status: Status
    let fullModel: FullModel
}

// MARK: - ControllerFeatures
struct ControllerFeatures: Codable {
    let operatingRange: Int
    let controllerFrequency: String
    let controlSystem: ControlSystem
}

enum ControlSystem: String, Codable {
    case remoteControlPhoneTablet = "Remote Control + Phone/Tablet"
}

// MARK: - FlightFeatures
struct FlightFeatures: Codable {
    let maxFlightTime: Int
    let payloadCapacity: Double
    let maximumSpeed, maximumAltitude, minimumOperatingTemperature, maximumOperatingTemperature: Int
    let mtom: Double
}

enum FullModel: String, Codable {
    case djiPhantom1 = "DJI - Phantom 1"
}

// MARK: - GeneralFeatures
struct GeneralFeatures: Codable {
    let type: TypeEnum
    let brand: Model
    let model: Series
    let mainImageFile: MainImageFile
    let images: [MainImageFile]
    let numberOfRotors, wingspan: Int
    let weight: Double
    let bodyMaterial: BodyMaterial
}

enum BodyMaterial: String, Codable {
    case plastic = "Plastic"
}

enum Model: String, Codable {
    case dji = "DJI"
}

enum MainImageFile: String, Codable {
    case djiPhantom1_1Jpg = "DJI_Phantom_1_1.jpg"
    case djiPhantom1_2Jpg = "DJI_Phantom_1_2.jpg"
}

enum Series: String, Codable {
    case phantom1 = "Phantom 1"
}

enum TypeEnum: String, Codable {
    case rotaryWing = "ROTARY_WING"
}

// MARK: - ValidationResult
struct ValidationResult: Codable {
    let status: String
}

typealias OperationPast = [Operation]
