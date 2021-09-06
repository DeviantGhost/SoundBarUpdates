//
//  FirebaseHandler.swift
//  SoundBar
//
//  Created by Danesh Rajasolan on 2020-08-03.
//  Copyright © 2020 Danesh Rajasolan. All rights reserved.
//

import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseHandler: NSObject {
    
    var storageRef: StorageReference?
    var database = Firestore.firestore()
    
    override init() {
        super.init()
        storageRef = Storage.storage().reference()
    }
    
    func handleSignUp(email:String, username: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if self.displayError(error: error) {
                print("Successfully created user. \(result?.user.email ?? "")")
                let changeProfileRequest = result?.user.createProfileChangeRequest()
                changeProfileRequest?.displayName = username
                changeProfileRequest?.commitChanges(completion: { (error) in
                    if self.displayError(error: error) {
                        print("Successfully made changes.")
                    }
                })
            }
        }
    }
    
    func handleLogin(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if self.displayError(error: error) {
                print("Successfully logged in user: \(result?.user.displayName ?? "")")
            }
        }
    }
    
    func handleAudioUpload() {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!)
        let soundFileUrl = url
        storageRef?.child("audio").child("song").putFile(from: soundFileUrl, metadata: nil) { (metadata, error) in
            if self.displayError(error: error) {
                print("Successfully uploaded \(metadata?.name ?? "")")
            }
        }
    }
    
    func handleAudioArtworkUpload(string: String, name: String) {
        if let data = try? Data(contentsOf: URL(string: string)!) {
            let childs = storageRef?.child("artwork").child(name)
            childs?.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document updated successfully.")
                    childs?.downloadURL { url, error in
                        if let error = error {
                            print("an error occured: \(error.localizedDescription)")
                        } else {
                          print("url for download is \(url)")
                        }
                    }
                }
            }
        }
    }
    
    func homeFeedDownload() {
        let query = database.collection("homefeed")
        query.getDocuments { (snapshot, err) in
            var dataSource = [SongPresentation]()
            guard let documents = snapshot?.documents else { return }
            for doc in documents {
                let dict = doc.data() as [String: AnyObject]
                let songpresentation = SongPresentation(fullLink:
                    dict["full_song_link"] as? String,
                                                        snippetLink: dict["snippet_song_link"] as? String,
                                                        artist: dict["artist"] as? String,
                                                        songName: dict["song_name"] as? String,
                                                        imageLink: dict["image_link"] as? String,
                                                        comments: dict["comments"] as? String,
                                                        likes: dict["likes"] as? String,
                                                        listens: dict["listens"] as? String,
                                                        songCaption: dict["song_caption"] as? String)
                dataSource.append(songpresentation)
            }
        }
    }
    
    func handleAudioArtworkDownload() {
        
    }
    
    func handleUserArtworkUpload(profImageLink: String, coverImageLink: String, name: String) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        if let data = try? Data(contentsOf: URL(string: profImageLink)!) {
            let childs = storageRef?.child("userProfileImages").child(name)
            childs?.child("prof-\(name)").putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document updated successfully.")
                    childs?.child("prof-\(name)").downloadURL { url, error in
                        if let error = error {
                            print("an error occured: \(error.localizedDescription)")
                        } else {
                          print("profile url for download is \(url)")
                        }
                    }
                }
            }
        }
        if let data = try? Data(contentsOf: URL(string: coverImageLink)!) {
            let childs = storageRef?.child("userProfileImages").child(name)
            childs?.child("cover-\(name)").putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Document updated successfully.")
                    childs?.child("cover-\(name)").downloadURL { url, error in
                        if let error = error {
                            print("an error occured: \(error.localizedDescription)")
                        } else {
                          print("cover url for download is \(url)")
                        }
                    }
                }
            }
        }
    }
}

extension NSObject {
    func displayError(error: Error?) -> Bool {
        if error != nil {
            print("An error occured: \(error?.localizedDescription ?? "")")
            return false
        }
        return true
    }
}
