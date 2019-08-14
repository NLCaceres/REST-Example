//
//  Post.swift
//  ITPRestApplication
//
//  Created by Demo on 1/28/16.
//

class Post : ModelBase, ModelProtocol, Codable {
    var cName : String?
    var cMessage : String?
    var cMessageDate : String?

//    override init() {
//        self.cName = nil
//        self.cMessage = nil
//        self.cMessageDate = nil
//    }
    init(cName : String? = nil, cMessage : String? = nil, cMessageDate : String? = nil) {
        self.cName = cName
        self.cMessage = cMessage
        self.cMessageDate = cMessageDate
    }
    
    enum TopCodingKey: String, CodingKey {
        case message
    }
    enum SubCodingKeys: String, CodingKey {
        case cName = "name"
        case cMessage = "message"
        case cMessageDate = "message_date"
    }
    
    required convenience init(from decoder: Decoder) throws {
        let fullJson = try decoder.container(keyedBy: TopCodingKey.self)
        let messages = try fullJson.nestedContainer(keyedBy: SubCodingKeys.self, forKey: .message)
        let name = try? messages.decode(String.self, forKey: .cName)
        let message = try? messages.decode(String.self, forKey: .cMessage)
        let messageDate = try? messages.decode(String.self, forKey: .cMessageDate)
        
        self.init(cName: name, cMessage: message, cMessageDate: messageDate)
    }
    
    override func objectMapping() -> Dictionary<String, String>{
        
        let objecMapping = [
            "cName":"name",
            "cMessage":"message",
            "cMessageDate":"message_date"
        
        ]
        
        return objecMapping
        
    }
    
}
