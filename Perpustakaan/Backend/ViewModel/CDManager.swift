//
//  CDManager.swift
//  Perpustakaan
//
//  Created by Adimas Surya Perdana Putra on 16/05/22.
//

import Foundation
import CoreData

class CDManager {
    static let shared = CDManager()
    var persistentContainer: NSPersistentContainer!
    
    init() {
        persistentContainer = NSPersistentContainer(name: "Perpustakaan")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func updateFoto() {
            
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
        
    }
    
    func getAllPemasukan() -> [Saving] {
        let fetchRequest: NSFetchRequest<Saving> = Saving.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
        
    func hapusFoto(foto: Saving) {
        
        persistentContainer.viewContext.delete(foto)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error)")
        }
        
    }
    
//
//    
//    func simpanPemasukan(kate_In: String, desk_In: String) {
//        let letPemasukan = Saving(context: persistentContainer.viewContext)
//        letPemasukan.id_kategori = kate_In
//        letPemasukan.deskripsi = desk_In
//        
//        do {
//            try persistentContainer.viewContext.save()
//        } catch {
//            print("Failed to save movie \(error)")
//        }
//    }

}
// close tutorial azamsharp


