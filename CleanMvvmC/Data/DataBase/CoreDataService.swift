//
//  CoreDataService.swift
//  CleanMvvmC
//
//  Created by 윤형찬 on 12/26/24.
//

import CoreData
import RxSwift

class CoreDataService {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer) {
        self.container = container
    }
    
    func getUser(by id: String) -> Observable<User> {
        return Observable.create { observer in
            let context = self.container.viewContext
            // CoreData 조회 로직
            return Disposables.create()
        }
    }
    
    func saveUser(_ user: User) -> Observable<Void> {
        return Observable.create { observer in
            let context = self.container.viewContext
            // CoreData 저장 로직
            return Disposables.create()
        }
    }
}
