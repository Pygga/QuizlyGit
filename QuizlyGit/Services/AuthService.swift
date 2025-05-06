//
//  AuthService.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import FirebaseAuth
//Сервис для работы с аунтефикацией
actor AuthService{
    static let shared = AuthService(); private init() { }
    let auth = Auth.auth()
    
    var currentUser: User? { auth.currentUser }
    
    //MARK: Auth
    func signIn(withEmail email: String, password: String) async throws -> Profile {
        let user = try await Auth.auth().signIn(withEmail: email,
                                         password: password).user
        print("User found")
        let profile = try await FirestoreService.shared.getProfile(user.uid)
        return profile
    }
    
    //MARK: Reg
    func signUp(withEmail email: String, password: String) async throws -> Profile {
        let user = try await Auth.auth().createUser(withEmail: email,
                                              password: password)
        let currentUser = user.user
        print("User created")
        let profile = Profile(id: currentUser.uid, name: "", email: currentUser.email!, score: 0)
        return try await FirestoreService.shared.createProfile(profile)
    }
    
    //MARK: Out
    func singOut(){
        try? auth.signOut()
    }
}
