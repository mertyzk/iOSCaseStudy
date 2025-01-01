//
//  CartStore.swift
//  E-Market
//
//  Created by Macbook Air on 29.12.2024.
//

import UIKit
import CoreData

final class CartStore: CartHandler {
    
    private let context: NSManagedObjectContext
    private let entityName = "Cart"
    
    
    // MARK: - Initializer
    init(context: NSManagedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) {
        self.context = context
    }
    
    
    // MARK: - Add Product
    func addToLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            completion(.failure(.addObjectError))
            return
        }
        
        let cartItem = NSManagedObject(entity: entity, insertInto: context)
        
        cartItem.setValue(product.brand, forKey: ProductKey.brand.rawValue)
        cartItem.setValue(product.createdAt, forKey: ProductKey.createdAt.rawValue)
        cartItem.setValue(product.description, forKey: ProductKey.description.rawValue)
        cartItem.setValue(product.id, forKey: ProductKey.id.rawValue)
        cartItem.setValue(product.image, forKey: ProductKey.image.rawValue)
        cartItem.setValue(product.model, forKey: ProductKey.model.rawValue)
        cartItem.setValue(product.name, forKey: ProductKey.name.rawValue)
        cartItem.setValue(product.price, forKey: ProductKey.price.rawValue)
        cartItem.setValue(product.quantity, forKey: ProductKey.quantity.rawValue)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(.addObjectError))
        }
    }
    
    
    // MARK: - Delete Product
    func deleteFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id ?? "")
        
        do {
            let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            if let cartItem = objects?.first {
                context.delete(cartItem)
                try context.save()
                completion(.success(()))
            } else {
                completion(.failure(.delObjectError))
            }
        } catch {
            completion(.failure(.delObjectError))
        }
    }
    
    
    // MARK: - Fetch Products
    func fetchProductsFromLocalDB(completion: @escaping (Result<[Product], DBErrors>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            if let result = try context.fetch(fetchRequest) as? [NSManagedObject] {
                let products = result.map {
                    Product(
                        createdAt: $0.value(forKey: ProductKey.createdAt.rawValue) as? String,
                        name: $0.value(forKey: ProductKey.name.rawValue) as? String,
                        image: $0.value(forKey: ProductKey.image.rawValue) as? String,
                        price: $0.value(forKey: ProductKey.price.rawValue) as? String,
                        description: $0.value(forKey: ProductKey.description.rawValue) as? String,
                        model: $0.value(forKey: ProductKey.model.rawValue) as? String,
                        brand: $0.value(forKey: ProductKey.brand.rawValue) as? String,
                        id: $0.value(forKey: ProductKey.id.rawValue) as? String,
                        quantity: $0.value(forKey: ProductKey.quantity.rawValue) as? Int
                    )
                }
                completion(.success(products))
            } else {
                completion(.failure(.fetchDataError))
            }
        } catch {
            completion(.failure(.fetchDataError))
        }
    }
    
    
    // MARK: - Update Product
    func updateProductFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@", product.id ?? "")
        
        do {
            let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
            
            if let cartItem = objects?.first {
                cartItem.setValue(product.quantity, forKey: ProductKey.quantity.rawValue)
                try context.save()
                completion(.success(()))
            } else {
                completion(.failure(.updObjectError))
            }
        } catch {
            completion(.failure(.updObjectError))
        }
    }

    
    // MARK: - Remove Product
    func removeFromCartFromLocalDB(product: Product, completion: @escaping (Result<Void, DBErrors>) -> Void) {
        fetchProductsFromLocalDB { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let productlist):
                if let index = productlist.firstIndex(where: { $0.id == product.id }) {
                    var existingProduct = productlist[index] // Copy to a local variable
                    
                    if existingProduct.quantity ?? 0 > 1 {
                        existingProduct.quantity = (existingProduct.quantity ?? 0) - 1
                        updateProductFromLocalDB(product: existingProduct) { result in
                            switch result {
                            case .success():
                                completion(.success(()))
                            case .failure:
                                completion(.failure(.updObjectError))
                            }
                        }
                    } else {
                        removeFromCartFromLocalDB(product: existingProduct) { result in
                            switch result {
                            case .success:
                                completion(.success(()))
                            case .failure:
                                completion(.failure(.removeCartError))
                            }
                        }
                    }
                } else {
                    completion(.failure(.removeCartError))
                }
            case .failure:
                completion(.failure(.fetchDataError))
            }
        }
        
        NotificationCenter.default.post(name: .changeCartDB, object: nil)
    }

    
    // MARK: - Clear All
    func clearCartFromLocalDB(completion: @escaping (Result<Void, DBErrors>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
            try context.save()
            completion(.success(()))
            NotificationCenter.default.post(name: .changeCartDB, object: nil)
        } catch {
            completion(.failure(.clearCartError))
        }
    }
}
