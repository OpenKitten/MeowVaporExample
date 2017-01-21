// Generated using Sourcery 0.5.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


import HTTP
import Vapor
import Foundation
import MeowVapor






  
    // Optional(String)
    extension Gender : ConcreteSingleValueSerializable {
      init(value: ValueConvertible) throws {
        let value: String = try Meow.Helpers.requireValue(value.makeBSONPrimitive() as? String, keyForError: "")
        let me: Gender = try Meow.Helpers.requireValue(Gender(rawValue: value), keyForError: "")

        self = me
      }

      func meowSerialize() -> ValueConvertible {
        return self.rawValue
      }

      struct VirtualInstance {
        static func ==(lhs: VirtualInstance, rhs: Gender) -> Query {
          return lhs.keyPrefix == rhs.meowSerialize()
        }

        var keyPrefix: String

        init(keyPrefix: String = "") {
          self.keyPrefix = keyPrefix
        }
      }
    }
  



extension Article : ConcreteSerializable {
  func meowSerialize() -> Document {
    
      var doc: Document = ["_id": self.id]
    

    

    
      // id: ObjectId (ObjectId)
      
        
      
    
      // title: String (String)
      
        
          doc["title"] = self.title
        
      
    
      // author: Reference<User, Ignore> (Reference<User, Ignore>)
      
        
          doc["author"] = self.author.id
        
      
    
      // readers: [Reference<User, Ignore>] ([Reference<User, Ignore>])
      
        
          doc["readers"] = self.readers.map { $0.id }
        
        // TODO: Support [Embeddable]?
      
    

    return doc
  }

  convenience init(fromDocument source: Document) throws {
    var source = source
      // Extract all properties
      
      
        
        // loop: id

        
          
            let idValue: ObjectId = try Meow.Helpers.requireValue(source.removeValue(forKey: "_id") as? ObjectId, keyForError: "id")
        
      
     
        
        // loop: title

        
          
             // The property is a BSON type, so we can just extract it from the document:
             
                  let titleValue: String = try Meow.Helpers.requireValue(source.removeValue(forKey: "title") as? String, keyForError: "title")
             
          
      
     
        
        // loop: author

        
          
             // o the noes it is a reference
             let authorId: ObjectId? = source.removeValue(forKey: "author") as? ObjectId
             let authorValue: Reference<User, Ignore>

             
                authorValue = Reference(restoring: try Meow.Helpers.requireValue(authorId, keyForError: "author"))
             
        
      
     
        
        // loop: readers

        
          
            // o the noes it is a reference
            let readersIds = try Meow.Helpers.requireValue(source.removeValue(forKey: "readers") as? Document, keyForError: "readers").arrayValue
            let readersValue: [Reference<User, Ignore>]

            
               readersValue = try readersIds.map {
                  Reference(restoring: try Meow.Helpers.requireValue($0 as? ObjectId, keyForError: "readers"))
                }
            
          
        
     

      // initializerkaas:
      try self.init(
        
        
          author: authorValue
          
        
      )

      
      
        
        
          self.id = idValue
        
      
        
        
          self.title = titleValue
        
      
        
        
          self.author = authorValue
        
      
        
        
          self.readers = readersValue
        
      
  }

  struct VirtualInstance {
    var keyPrefix: String

    
    
      
      // id: ObjectId
      
        var id: VirtualObjectId { return VirtualObjectId(name: keyPrefix + "id") }
      
    
      
      // title: String
      
        var title: VirtualString { return VirtualString(name: keyPrefix + "title") }
      
    
      
      // author: Reference<User, Ignore>
      
        var author: VirtualReference<Reference<User, Ignore>.Model, Reference<User, Ignore>.DeleteRule> { return VirtualReference(name: keyPrefix + "author") }
      
    
      
      // readers: [Reference<User, Ignore>]
      
        var readers: VirtualReferenceArray<Reference<User, Ignore>.Model, Reference<User, Ignore>.DeleteRule> { return VirtualReferenceArray<Reference<User, Ignore>.Model, Reference<User, Ignore>.DeleteRule>(name: keyPrefix + "readers") }
      
    

    init(keyPrefix: String = "") {
      self.keyPrefix = keyPrefix
    }
  }

  var meowReferencesWithValue: [(key: String, destinationType: ConcreteModel.Type, deleteRule: DeleteRule.Type, id: ObjectId)] {
      var result = [(key: String, destinationType: ConcreteModel.Type, deleteRule: DeleteRule.Type, id: ObjectId)]()
      _ = result.popLast() // to silence the warning of not mutating above variable in the case of a type with no references

      
        
      
        
      
        
          
            let authorValue = self.author
          
          result.append(("author", authorValue.destinationType, authorValue.deleteRule, authorValue.id))
          
        
      
        
      

      return result
  }
}

extension User : ConcreteSerializable {
  func meowSerialize() -> Document {
    
      var doc: Document = ["_id": self.id]
    

    

    
      // id: ObjectId (ObjectId)
      
        
      
    
      // email: String (String)
      
        
          doc["email"] = self.email
        
      
    
      // name: String (String)
      
        
          doc["name"] = self.name
        
      
    
      // gender: Gender? (Gender)
      
        
          doc[raw: "gender"] = self.gender?.meowSerialize()
        
      
    
      // articles: [Reference<Article, Cascade>] ([Reference<Article, Cascade>])
      
        
          doc["articles"] = self.articles.map { $0.id }
        
        // TODO: Support [Embeddable]?
      
    

    return doc
  }

  convenience init(fromDocument source: Document) throws {
    var source = source
      // Extract all properties
      
      
        
        // loop: id

        
          
            let idValue: ObjectId = try Meow.Helpers.requireValue(source.removeValue(forKey: "_id") as? ObjectId, keyForError: "id")
        
      
     
        
        // loop: email

        
          
             // The property is a BSON type, so we can just extract it from the document:
             
                  let emailValue: String = try Meow.Helpers.requireValue(source.removeValue(forKey: "email") as? String, keyForError: "email")
             
          
      
     
        
        // loop: name

        
          
             // The property is a BSON type, so we can just extract it from the document:
             
                  let nameValue: String = try Meow.Helpers.requireValue(source.removeValue(forKey: "name") as? String, keyForError: "name")
             
          
      
     
        
        // loop: gender

        
          
          
              let genderValue: Gender?
              
                  if let sourceVal = source.removeValue(forKey: "gender") {
                    genderValue = try Gender(value: sourceVal)
                  } else {
                    genderValue = nil
                  }
                
          
        
      
     
        
        // loop: articles

        
          
            // o the noes it is a reference
            let articlesIds = try Meow.Helpers.requireValue(source.removeValue(forKey: "articles") as? Document, keyForError: "articles").arrayValue
            let articlesValue: [Reference<Article, Cascade>]

            
               articlesValue = try articlesIds.map {
                  Reference(restoring: try Meow.Helpers.requireValue($0 as? ObjectId, keyForError: "articles"))
                }
            
          
        
     

      // initializerkaas:
      try self.init(
        
        
          email: emailValue
          
          ,
          
        
          name: nameValue
          
          ,
          
        
          gender: genderValue
          
        
      )

      
      
        
        
          self.id = idValue
        
      
        
        
          self.email = emailValue
        
      
        
        
          self.name = nameValue
        
      
        
        
          self.gender = genderValue
        
      
        
        
          self.articles = articlesValue
        
      
  }

  struct VirtualInstance {
    var keyPrefix: String

    
    
      
      // id: ObjectId
      
        var id: VirtualObjectId { return VirtualObjectId(name: keyPrefix + "id") }
      
    
      
      // email: String
      
        var email: VirtualString { return VirtualString(name: keyPrefix + "email") }
      
    
      
      // name: String
      
        var name: VirtualString { return VirtualString(name: keyPrefix + "name") }
      
    
      
      // gender: Gender?
      
        var gender: Gender.VirtualInstance { return Gender.VirtualInstance(keyPrefix: "gender.") }
      
    
      
      // articles: [Reference<Article, Cascade>]
      
        var articles: VirtualReferenceArray<Reference<Article, Cascade>.Model, Reference<Article, Cascade>.DeleteRule> { return VirtualReferenceArray<Reference<Article, Cascade>.Model, Reference<Article, Cascade>.DeleteRule>(name: keyPrefix + "articles") }
      
    

    init(keyPrefix: String = "") {
      self.keyPrefix = keyPrefix
    }
  }

  var meowReferencesWithValue: [(key: String, destinationType: ConcreteModel.Type, deleteRule: DeleteRule.Type, id: ObjectId)] {
      var result = [(key: String, destinationType: ConcreteModel.Type, deleteRule: DeleteRule.Type, id: ObjectId)]()
      _ = result.popLast() // to silence the warning of not mutating above variable in the case of a type with no references

      
        
      
        
      
        
      
        
      
        
      

      return result
  }
}



extension Article : ConcreteModel {
    static let meowCollection = Meow.database["article"]

    static func find(matching closure: ((VirtualInstance) -> (Query))) throws -> Cursor<Article> {
        let query = closure(VirtualInstance())
        return try self.find(matching: query)
    }

    static func findOne(matching closure: ((VirtualInstance) -> (Query))) throws -> Article? {
        let query = closure(VirtualInstance())
        return try self.findOne(matching: query)
    }

    static func count(matching closure: ((VirtualInstance) -> (Query))) throws -> Int {
        let query = closure(VirtualInstance())
        return try self.count(matching: query)
    }
}

extension Article : StringInitializable {
  public convenience init?(from string: String) throws {
    guard let document = try Article.meowCollection.findOne(matching: "_id" == (try ObjectId(string))) else {
      return nil
    }

    try self.init(fromDocument: document)
  }
}

extension Article : ValueConvertible {
  public func makeBSONPrimitive() -> BSONPrimitive {
    return self.meowSerialize()
  }
}

extension Article : ResponseRepresentable {
  public func makeResponse() -> Response {
    return self.makeExtendedJSON().makeResponse()
  }
}

extension User : ConcreteModel {
    static let meowCollection = Meow.database["user"]

    static func find(matching closure: ((VirtualInstance) -> (Query))) throws -> Cursor<User> {
        let query = closure(VirtualInstance())
        return try self.find(matching: query)
    }

    static func findOne(matching closure: ((VirtualInstance) -> (Query))) throws -> User? {
        let query = closure(VirtualInstance())
        return try self.findOne(matching: query)
    }

    static func count(matching closure: ((VirtualInstance) -> (Query))) throws -> Int {
        let query = closure(VirtualInstance())
        return try self.count(matching: query)
    }
}

extension User : StringInitializable {
  public convenience init?(from string: String) throws {
    guard let document = try User.meowCollection.findOne(matching: "_id" == (try ObjectId(string))) else {
      return nil
    }

    try self.init(fromDocument: document)
  }
}

extension User : ValueConvertible {
  public func makeBSONPrimitive() -> BSONPrimitive {
    return self.meowSerialize()
  }
}

extension User : ResponseRepresentable {
  public func makeResponse() -> Response {
    return self.makeExtendedJSON().makeResponse()
  }
}


extension Droplet {
  public func start(_ mongoURL: String) throws -> Never {
    let meow = try Meow.init(mongoURL)

    
      
    
      
        
          self.get("users", "/") { request in
        

        

        

        
        // TODO: Reverse isVoid when that works
           let responseObject = try User.list(
            
          )

          
            
              return responseObject
            
          
        
          }
      
        
          self.get("users", "filtered") { request in
        

        
          
            guard let query = request.query, case .object(let parameters) = query else {
                return Response(status: .badRequest)
            }
          

          
            

              
                guard let email = parameters["email"]?.string else {
                  return Response(status: .badRequest)
                }
              
            
          
        

        

        
        // TODO: Reverse isVoid when that works
           let responseObject = try User.find(
            
              email: email
              
            
          )

          
            
              return try Meow.Helpers.requireValue(responseObject, keyForError: "")
            
          
        
          }
      
        
          self.get("users", "containing") { request in
        

        
          
            guard let query = request.query, case .object(let parameters) = query else {
                return Response(status: .badRequest)
            }
          

          
            

              
                guard let email = parameters["email"]?.string else {
                  return Response(status: .badRequest)
                }
              
            
          
        

        

        
        // TODO: Reverse isVoid when that works
           let responseObject = try User.find(
            
              email: email
              
            
          )

          
            
              return try Meow.Helpers.requireValue(responseObject, keyForError: "")
            
          
        
          }
      
        
          self.delete("users", User.self, "/") { request, model in
        

        

        

        
        // TODO: Reverse isVoid when that works
           try model.remove(
            
          )

            
              return Response(status: .ok)
            
          
          }
      
    
    self.run()
  }
}
