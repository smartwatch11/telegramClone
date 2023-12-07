//
//  Service.swift
//  telegramClone
//
//  Created by Egor Rybin on 04.07.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class Service {
    static let shared = Service()
    
    init() {}
    
    
    func createNewUser(_ data: LoginField, complition: @escaping (ResponseCode)->()) {
        Auth.auth().createUser(withEmail: data.email, password: data.password){
            [weak self] result, error in
            if error == nil {
                if result != nil {
                    let userId = result?.user.uid
                    let email = data.email
                    let data: [String: Any] = ["email": email]
                    
                    Firestore.firestore().collection("users").document(userId!).setData(data)
                    complition(ResponseCode(code: 1))
                }
            } else {
                complition(ResponseCode(code: 0))
            }
        }
    }
    
    
    func confirmEmail() {
        Auth.auth().currentUser?.sendEmailVerification(completion: {
            err in
            if err != nil {
                print(err!.localizedDescription)
            }
        })
    }
    
    func authInApp(_ data: LoginField, complition: @escaping (AuthResponse)->()){
        Auth.auth().signIn(withEmail: data.email, password: data.password) { result, error in
            if error != nil {
                complition(.error)
            } else {
                if let result = result {
                    if result.user.isEmailVerified {
                        complition(.success)
                    } else {
                        self.confirmEmail()
                        complition(.noVerify)
                    }
                }
            }
        }
    }
    
    
    func getUserStatus(){
        //
    }
    
    func getAllUsers(complition: @escaping ([CurrentUser])->()){
        
        guard let email = Auth.auth().currentUser?.email else { return }
        
        var currentUsers = [CurrentUser]()
        
        Firestore.firestore().collection("users")
            .whereField("email", isNotEqualTo: email)
            .getDocuments { snap, err in
            if err == nil {
                //var emailList = [String]()
                if let docs = snap?.documents {
                    for doc in docs {
                        let data = doc.data()
                        let userId = doc.documentID
                        let email = data["email"] as! String
                        
                        currentUsers.append(CurrentUser(id: userId, email: email))
                        //emailList.append(email)
                    }
                }
                complition(currentUsers)
            }
        }
    }
    
    
    
    // MARK: -- Messenger
    
    func sendMessage(otherId: String?, convoId: String?, text: String, complition: @escaping (String) -> ()){
        
        if let uid = Auth.auth().currentUser?.uid {
            if convoId == nil {
                //create new convo
                let convoId = UUID().uuidString
                let selfData: [String: Any] = [
                    "date": Date(),
                    "otherId": otherId!
                ]
                
                Firestore.firestore().collection("users")
                    .document(uid)
                    .collection("conversation")
                    .document(convoId)
                    .setData(selfData)
                
                
                let otherData: [String: Any] = [
                    "date": Date(),
                    "otherId": uid
                ]
                
                Firestore.firestore().collection("users")
                    .document(otherId!)
                    .collection("conversation")
                    .document(convoId)
                    .setData(otherData)
                
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                let convoInfo: [String: Any] = [
                    "date": Date(),
                    "selfSender": uid,
                    "otherSender": otherId!
                ]
                
                Firestore.firestore().collection("conversations")
                    .document(convoId)
                    .setData(convoInfo) { err in
                        if let err = err {
                            print(err.localizedDescription)
                            return
                        }
                        
                        Firestore.firestore().collection("conversations")
                            .document(convoId)
                            .collection("messages")
                            .addDocument(data: msg) { err in
                                if err == nil {
                                    complition(convoId)
                                }
//                                else {
//                                    complition(convoId)
//                                }
                            }
                    }
                
                
            } else {
                let msg: [String: Any] = [
                    "date": Date(),
                    "sender": uid,
                    "text": text
                ]
                
                Firestore.firestore().collection("conversations").document(convoId!).collection("messages").addDocument(data: msg) { err in
                    if err == nil {
                        complition(convoId!)
                    }
//                    else {
//                        complition(false)
//                    }
                }
            }
        }
    }
    
    func updateConvo(){
        
    }
    
    func getConvoId(otherId: String, complition: @escaping (String)->()){
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("users").document(uid).collection("conversation").whereField("otherId", isEqualTo: otherId).getDocuments { snap, err in
                if err != nil {
                    return
                }
                
                if let snap = snap, !snap.documents.isEmpty {
                    let doc = snap.documents.first
                    if let convoId = doc?.documentID {
                        complition(convoId)
                    }
                }
            }
        }
    }
    
    func getAllMessage(chatId: String, complition: @escaping ([Message])->()){
        if let uid = Auth.auth().currentUser?.uid {
            let ref = Firestore.firestore()
            
            ref.collection("conversations")
                .document(chatId)
                .collection("messages")
                .limit(to: 50)
                .order(by: "date", descending: false)
                .addSnapshotListener { snap, err in
                    if err != nil {
                        return
                    }
                    
                    if let snap = snap, !snap.documents.isEmpty {
                        var msgs = [Message]()
                        //Message(sender: selfSender, messageId: "", sentDate: Date(), kind: .text(text))
                        var sender = Sender(senderId: uid, displayName: "Me")
                        for doc in snap.documents{
                            let data = doc.data()
                            let userId = data["sender"] as! String
                            let msgId = doc.documentID
                            let date = data["date"] as! Timestamp
                            let sentDate = date.dateValue()
                            let text = data["text"] as! String
                            
                            if userId == uid {
                                sender = Sender(senderId: "1", displayName: "")
                            } else {
                                sender = Sender(senderId: "2", displayName: "")
                            }
                            
                            msgs.append(Message(sender: sender, messageId: msgId, sentDate: sentDate, kind: .text(text)))
                        }
                        complition(msgs)
                    }
                }
        }
    }
    
    func getOneMessage(){
        
    }
    
}
