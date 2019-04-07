//
//  ArticleManager.swift
//  mdubus2019
//
//  Created by Morgane DUBUS on 4/5/19.
//

import Foundation
import CoreData

public class ArticleManager:NSObject {
    
    // MARK: - Properties
    
    private let modelName: String = "article"
    
    // MARK: - Initialization
    
    public override init() {
        super.init()
    }
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                              configurationName: nil,
                                                              at: persistentStoreURL,
                                                              options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
    
    public func newArticle() -> Article {
        return NSEntityDescription.insertNewObject(forEntityName: "Article", into: managedObjectContext) as! Article
    }
    
    public func getAllArticles() -> [Article]? {
        let articles = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            return try managedObjectContext.fetch(articles) as? [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return nil
    }
    
    public func getArticles(withLang lang : String) -> [Article]? {
        
        let articles = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        articles.predicate = NSPredicate(format: "langue == %@", lang)
        do {
            return try managedObjectContext.fetch(articles) as? [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return nil
    }
    
    public func getArticles(containString str : String) -> [Article]? {
        
        let articles = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        articles.predicate = NSPredicate(format: "titre == %@", str)
        do {
            return try managedObjectContext.fetch(articles) as? [Article]
        } catch {
            fatalError("Failed to fetch articles: \(error)")
        }
        return nil
    }
    
    public func removeArticle(article : Article) {
        managedObjectContext.delete(article)
    }
    
    public func save() {
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
}
