//
//  AuthService.swift
//  QuizlyGit
//
//  Created by Виктор Евграфов on 29.04.2025.
//

import FirebaseAuth

actor AuthService{
    static let shared = AuthService(); private init() { }
    let auth = Auth.auth()
    
    var currentUser: User? { auth.currentUser}
    
    //MARK: Auth
    func signIn(withEmail email: String, password: String) async throws -> Profile {
        let user = try await auth.signIn(withEmail: email,
                                         password: password).user
        let profile = try await FirestoreService.shared.getProfile(user.uid)
        return profile
    }
    
    //MARK: Reg
    func signUp(withEmail email: String, password: String) async throws -> Profile {
        let user =  try await auth.createUser(withEmail: email,
                                              password: password).user
        
        let profile = Profile(id: user.uid, name: "", email: user.email!, score: 0)
        return try await FirestoreService.shared.createProfile(profile)
    }
    
    //MARK: Out
    func singOut(){
        try? auth.signOut()
    }
}
