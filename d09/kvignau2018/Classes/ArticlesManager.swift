import UIKit
import CoreData

public class ArticlesManager {
    public var context : NSManagedObjectContext
    
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let modelUrl: URL = Bundle(for: Articles.self).url(forResource: "article", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl)!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "Articles.sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: nil)
        } catch {
            fatalError("Unable to Load Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()

    public init() {
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        print("ok")
    }
    
    public func     newArticle() -> Articles
    {
        var article: Articles?

        context.performAndWait {
            let ent = NSEntityDescription.entity(forEntityName: "Articles", in: context)!
            article = Articles(entity: ent, insertInto: context)
        }
        return article!
    }
    
    public func     save()
    {
        context.performAndWait {
            do {
                try context.save()
            } catch {
                print("Error save")
            }
        }
    }
    
    public func     getArticles() -> [Articles]
    {
        var fetchResults: [Articles] = []
        let fetchRequest: NSFetchRequest<Articles> = (Articles).fetchRequest()
        context.performAndWait {
            do {
                    fetchResults = try context.fetch(fetchRequest)
            }
            catch {
                print("Error fetch")
            }
        }
        return (fetchResults)
    }
    
    public func     getArticles(withLang lang : String) -> [Articles]
    {
        var fetchResults : [Articles] = []
        let fetchRequest: NSFetchRequest<Articles> = (Articles).fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "langue = %@", lang)
        context.performAndWait {
            do {
                fetchResults = try context.fetch(fetchRequest)
            }
            catch {
                print("Error fetch")
            }
        }
        return (fetchResults)
    }
    
    public func     getArticles(containString str : String) -> [Articles]
    {
        var fetchResults : [Articles] = []
        
        let contentKeyPredicate = NSPredicate(format: "content CONTAINS %@", str)
        let langueKeyPredicate = NSPredicate(format: "langue CONTAINS %@", str)
        let titreKeyPredicate = NSPredicate(format: "titre CONTAINS %@", str)

        let allPredicate = NSCompoundPredicate(type: .or, subpredicates: [contentKeyPredicate, langueKeyPredicate, titreKeyPredicate])
        
        let fetchRequest: NSFetchRequest<Articles> = (Articles).fetchRequest()
        fetchRequest.predicate = allPredicate
        context.performAndWait {
            do {
                fetchResults = try context.fetch(fetchRequest)
            }
            catch {
                print("Error fetch")
            }
        }
        return fetchResults
    }
    
    public func     removeArticle(article: Articles)
    {
        context.performAndWait {
            context.delete(article)
        }
    }
}
