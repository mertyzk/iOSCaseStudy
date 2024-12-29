//
//  FavoriteStore.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import CoreData
import UIKit

final class FavoriteStore: FavoriteHandler {
    
    private let context: NSManagedObjectContext
    private let entityName = "Favorite"
    
    
    // MARK: - Initializer
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    
    // MARK: - Add
    func addToLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            completion(.failure(.addObjectError))
            return
        }
        
        let favoriteItem = NSManagedObject(entity: entity, insertInto: context)
        
        favoriteItem.setValue(product.brand, forKey: ProductKey.brand.rawValue)
        favoriteItem.setValue(product.createdAt, forKey: ProductKey.createdAt.rawValue)
        favoriteItem.setValue(product.description, forKey: ProductKey.description.rawValue)
        favoriteItem.setValue(product.id, forKey: ProductKey.id.rawValue)
        favoriteItem.setValue(product.image, forKey: ProductKey.image.rawValue)
        favoriteItem.setValue(product.model, forKey: ProductKey.model.rawValue)
        favoriteItem.setValue(product.name, forKey: ProductKey.name.rawValue)
        favoriteItem.setValue(product.price, forKey: ProductKey.price.rawValue)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.addObjectError))
        }
        
    }
    
    
    // MARK: - Delete
    func deleteFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id ?? "")
        
        do {
            let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            if let objects = objects, !objects.isEmpty {
                objects.forEach { context.delete($0) }
                try context.save()
                completion(.success(()))
            } else {
                completion(.failure(.delObjectError))
            }
        } catch {
            completion(.failure(.delObjectError))
        }
    }
    
    
    // MARK: - Fetch
    func fetchProductsFromLocalDB(completion: @escaping (Result<[Product], DBErrors>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            if let results = try context.fetch(fetchRequest) as? [NSManagedObject] {
                let products = results.map { result in
                    Product(
                        createdAt: result.value(forKey: ProductKey.brand.rawValue) as? String,
                        name: result.value(forKey: ProductKey.createdAt.rawValue) as? String,
                        image: result.value(forKey: ProductKey.description.rawValue) as? String,
                        price: result.value(forKey: ProductKey.id.rawValue) as? String,
                        description: result.value(forKey: ProductKey.image.rawValue) as? String,
                        model: result.value(forKey: ProductKey.model.rawValue) as? String,
                        brand: result.value(forKey: ProductKey.name.rawValue) as? String,
                        id: result.value(forKey: ProductKey.price.rawValue) as? String
                    )
                }
                completion(.success(products))
            } else {
                completion(.success([]))
            }
        } catch {
            completion(.failure(.fetchDataError))
        }
    }
}
