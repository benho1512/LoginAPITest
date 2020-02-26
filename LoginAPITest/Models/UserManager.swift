//
//  UserManager.swift
//  LoginDemo
//
//  Created by Nguyen Duy anh on 2/20/20.
//  Copyright © 2020 Nguyen Duy anh. All rights reserved.
//

import UIKit


class UserManager {
    
    static let shared = UserManager()
    
    var userModels = [UserModel]()
    
    func fetchUsers(completion: @escaping (Result<[UserModel], Error>) -> ()) {
        let urlString = "https://5e4f5f1043b2b200142a35fe.mockapi.io/users"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error: ", error!)
                return
            }
            
            guard let safeData = data else { return }
            do {
                let users = try JSONDecoder().decode([UserModel].self, from: safeData)
                
                completion(.success(users))

            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}
