////
////  FirebaseHandler.swift
////  SoundBar
////
////  Created by Danesh Rajasolan on 2020-08-03.
////  Copyright © 2020 Soundbar LLC. All rights reserved.
////
//
////import FirebaseStorage
////import FirebaseAuth
////import FirebaseFirestore
//
//class FirebaseHandler: NSObject {
//
//    // use the users auth id as the #userid so we can at any point find the users #userid by using firebaseauth.currentid or something
//
//    var storageRef: StorageReference?
//    var database = Firestore.firestore()
//
//    // for datasource related tasks
//    var explore_dict_values = [String: Any]()
//    var recommendedHits = [String: Any]()
//    // end datasource related tasks
//
//    override init() {
//        super.init()
//        storageRef = Storage.storage().reference()
//    }
//
////    func handleSignUp(email:String, username: String, password: String) {
////        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
////            if self.displayError(error: error) {
////                print("Successfully created user. \(result?.user.email ?? "")")
////                let changeProfileRequest = result?.user.createProfileChangeRequest()
////                changeProfileRequest?.displayName = username
////                changeProfileRequest?.commitChanges(completion: { (error) in
////                    if self.displayError(error: error) {
////                        print("Successfully made changes.")
////                    }
////                })
////            }
////        }
////    }
//
////    func handleLogin(email: String, password: String) {
////        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
////            if self.displayError(error: error) {
////                print("Successfully logged in user: \(result?.user.displayName ?? "")")
////            }
////        }
////    }
//
//    func handleAudioUpload() {
//        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "song", ofType: "mp3")!)
//        let soundFileUrl = url
//        storageRef?.child("audio").child("song").putFile(from: soundFileUrl, metadata: nil) { (metadata, error) in
//            if self.displayError(error: error) {
//                print("Successfully uploaded \(metadata?.name ?? "")")
//            }
//        }
//    }
//
//    func handleAudioArtworkUpload(string: String, name: String) {
//        if let data = try? Data(contentsOf: URL(string: string)!) {
//            let childs = storageRef?.child("artwork").child(name)
//            childs?.putData(data, metadata: nil) { (metadata, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
////                    print("Document updated successfully.")
//                    childs?.downloadURL { url, error in
//                        if let error = error {
//                            print("an error occured: \(error.localizedDescription)")
//                        } else {
//                          print("url for download is \(url)")
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    func songDownload(songIDS: [String], completion: @escaping ([SongPresentation]) -> Void) {
//        var songs_data = [SongPresentation]()
//
//        //reformat getting data back
//        var downloadsCompleted = 0
//        for ids in songIDS {
//            FirebaseHandler().increaseSongListens(songID: ids)
//            let query = database.collection("songs").document(ids)
//            query.getDocument { (snapshot, err) in
//                let result = Result {
//                    try snapshot?.data()
//                }
//                switch result {
//                case .success(let song):
//                    if var song = song {
////                        song.id = ids
////                        songs_data.append(song)
//                    }
//                case .failure(let error):
//                    print(error)
//                }
//                downloadsCompleted += 1
//            }
//        }
//        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
//            if !songs_data.isEmpty && downloadsCompleted == songIDS.count {
//                timer.invalidate()
//                completion(songs_data)
//            }
//        }
//    }
//
//    func userHomefeedDownload(userID: String?, completion: @escaping ([SongPresentation]) -> Void) {
//        let query = database.collection("homefeed").document(userID!)
//        query.getDocument { (snapshot, err) in
//            let data = snapshot?.data()?["songs_id"]
//            self.songDownload(songIDS: data as? [String] ?? []) { (songs) in
//                completion(songs)
//            }
//        }
//    }
//
//    func profileFeedDownload(userid: String?, completion: @escaping ([String: Any]) -> Void) {
//        var dict_values = [String: Any]()
//        let profile_header_query = database.collection("artist_id").document(userid!).collection("profile_header").document("data")
//        let profile_music_query = database.collection("artist_id").document(userid!).collection("profile_music")
//
//        profile_header_query.getDocument { (snapshot, err) in
//            var dict = snapshot?.data()
//            dict?["id"] = userid
//            dict_values["profile_header"] = dict
//
//        }
//
//        profile_music_query.getDocuments { (snapshot, err) in
//            for docs in snapshot!.documents {
//                let favorites = docs.data()["favorites"]
//                let playlists = docs.data()["playlists"]
//                let tracks = docs.data()["tracks"]
//                if favorites != nil {
//                    dict_values["favorites"] = favorites as? [String]
//                    dict_values["playlists"] = playlists as? [String: Any]
//                } else {
//                    dict_values["tracks"] = tracks as? [String]
//                }
//            }
//        }
//
//        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
//            if dict_values.count == 4 {
//                timer.invalidate()
//                completion(dict_values)
//            } else if (userid != userID) && dict_values.count == 2 {
//                timer.invalidate()
//                completion(dict_values)
//            }
//        }
//    }
//
//    func hashtagDownload(hashtag: String, completion: @escaping ([SongPresentation]) -> Void) {
//        var songs = [String]()
//        let hashtagQuery = database.collection("hashtags").document(hashtag)
//        hashtagQuery.getDocument { (snapshot, err) in
//            if let error = err {
//                print("An error occured: \(error.localizedDescription)")
//            } else {
//                let data = snapshot!.data()
//                for song in data!.keys {
//                    songs.append(song)
//                }
//                self.songDownload(songIDS: songs) { (songs) in
//                    completion(songs)
//                }
//            }
//        }
//    }
//
//    func trendingHashtagsDownload(userID: String, completion: @escaping ([String: [SongPresentation]]) -> Void) {
//        var hashtagsSongs = [String: [SongPresentation]]()
//        let trendingHashtags = database.collection("explore").document("trending_hashtags")
//        var hashtagsCompleted = 0
//
//        trendingHashtags.getDocument { (snapshot, err) in
//            if let error = err {
//                print("Error occured: \(error.localizedDescription)")
//            } else {
//                let data = snapshot!.data()!
//                hashtagsCompleted = data.count
//                for hashtag in data.keys {
//                    self.hashtagDownload(hashtag: hashtag) { (songs) in
//                        hashtagsSongs[hashtag] = songs
//                    }
//                }
//            }
//        }
//
//        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { (timer) in
//            if !hashtagsSongs.isEmpty && hashtagsSongs.count == hashtagsCompleted {
//                completion(hashtagsSongs)
//                timer.invalidate()
//            }
//        }
//    }
//
//    func trendingBarsDownload(completion: @escaping ([SongPresentation]) -> Void) {
//        let trendingBars = database.collection("explore").document("trending_bars")
//        var datas = [String]()
//
//        trendingBars.getDocument { (snapshot, err) in
//            if let error = err {
//                print("Error occured: \(error.localizedDescription)")
//            } else {
//                let data = snapshot!.data()
//                self.explore_dict_values["trending_bars"] = data?.keys
//                for song in data!.keys {
//                    datas.append(song)
//                }
//                self.songDownload(songIDS: datas) { (songs) in
//                    completion(songs)
//                }
//            }
//        }
//    }
//
//    func recommendedSongsDownload(userID: String, completion: @escaping ([SongPresentation]) -> Void) {
//        let recommended = database.collection("explore").document("recommended").collection(userID)
//
//        recommended.document("songs").getDocument { (snapshot, err) in
//            if let error = err {
//                print("Error occured: \(error.localizedDescription)")
//            } else {
//                let data = snapshot!.data()?["songs"] as? [String]
//                self.songDownload(songIDS: data ?? []) { (songs) in
//                    completion(songs)
//                }
//            }
//        }
//    }
//
//    func recommendedFriendsDownload(userID: String, completion: @escaping ([[String: Any]]) -> Void) {
//        let recommended = database.collection("explore").document("recommended").collection(userID)
//
//        recommended.document("friends").getDocument { (snapshot, err) in
//            if let error = err {
//                print("Error occured: \(error.localizedDescription)")
//            } else {
//                let data = snapshot?.data()?["friends"] as? [String]
//                var profiles = [[String: Any]]()
//                for user in data ?? [] {
//                    self.profileFeedDownload(userid: user) { (dict_profiles) in
//                        profiles.append(dict_profiles)
//                    }
//                }
//                Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
//                    if profiles.count == data?.count {
//                        completion(profiles)
//                        timer.invalidate()
//                    }
//                })
//            }
//        }
//    }
//
//    func updateProfileData(user: String, userData: ProfileHeader) {
//        let profile = database.collection("artist_id").document(user).collection("profile_header").document("data")
//
//        let username = userData.username
//        let fullname = userData.fullName
//        let bio = userData.bio
//        let link = userData.bioLink
//
//        profile.updateData(["username" : username!, "full_name": fullname!, "bio": bio!, "bio_link": link!]) { (err) in
//            if let error = err {
//                print("found an error: \(error)")
//            } else {
//                print("Document successfully updated")
//            }
//        }
//    }
//
//    func followUser(currentUser: String, toFollow: String) {
//        let otherUserFollowers = database.collection("artist_id").document(toFollow).collection("followers").document("users_followers")
//        let updateOtherProfileHeader = database.collection("artist_id").document(toFollow).collection("profile_header").document("data")
//
//        let currentUserFollowing = database.collection("artist_id").document(currentUser).collection("following").document("users_following")
//        let updateCurrentProfileHeader = database.collection("artist_id").document(currentUser).collection("profile_header").document("data")
//
//        currentUserFollowing.updateData(["following": FieldValue.arrayUnion([toFollow])], completion: nil)
//        updateCurrentProfileHeader.updateData(["followers": FieldValue.increment(Int64(1))]) { (err) in
//            if let error = err {
//                print("an error occurred: \(error.localizedDescription)")
//            } else {
//                print("\(currentUser) is following \(toFollow).")
//            }
//        }
//
//        otherUserFollowers.updateData(["followers": FieldValue.arrayUnion([currentUser])], completion: nil)
//        updateOtherProfileHeader.updateData(["followers": FieldValue.increment(Int64(1))]) { (err) in
//            if let error = err {
//                print("an error occurred: \(error.localizedDescription)")
//            } else {
//                print("\(toFollow) has \(currentUser) as a follower.")
//            }
//        }
//    }
//
//    func unfollowUser(currentUser: String, toUnfollow: String) {
//        let updateOtherProfileHeader = database.collection("artist_id").document(toUnfollow).collection("profile_header").document("data")
//        let otherUsersFollowers = database.collection("artist_id").document(toUnfollow).collection("followers").document("users_followers")
//
//        let currentUserFollowing = database.collection("artist_id").document(currentUser).collection("following").document("users_following")
//        let updateCurrentProfileHeader = database.collection("artist_id").document(currentUser).collection("profile_header").document("data")
//
//        currentUserFollowing.updateData(["following": FieldValue.arrayRemove([toUnfollow])], completion: nil)
//        updateCurrentProfileHeader.updateData(["following": FieldValue.increment(Int64(-1))]) { (err) in
//            if let error = err {
//                print("an error occurred: \(error.localizedDescription)")
//            } else {
//                print("\(currentUser) is not following \(toUnfollow) anymore.")
//            }
//        }
//
//        otherUsersFollowers.updateData(["followers": FieldValue.arrayRemove([currentUser])], completion: nil)
//        updateOtherProfileHeader.updateData(["followers": FieldValue.increment(Int64(-1))]) { (err) in
//            if let error = err {
//                print("an error occurred: \(error.localizedDescription)")
//            } else {
//                print("\(toUnfollow) has lost \(currentUser) as a follower.")
//            }
//        }
//    }
//
//    func isCurrentUserFollowing(current: String, user: String, completion: @escaping (Bool) -> Void) {
//        let followingQuery = database.collection("artist_id").document(current).collection("following").document("users_following")
//
//        followingQuery.getDocument { (snapshot, err) in
//            if let error = err {
//                print("an error occurred: \(error.localizedDescription)")
//            } else {
//                let data = snapshot?.data() as? [String: Any]
//                let following = data?["following"] as! [String]
//                completion(following.contains(user))
//            }
//        }
//    }
//
//    func likeSong(songID: String, increaseLike: Bool) {
//        // add this user in firebase interactions collection as well
//        let songRef = database.collection("songs").document(songID)
//        songRef.updateData(["likes": increaseLike ? (FieldValue.increment(Int64(1))) : (FieldValue.increment(Int64(-1)))]) { (err) in
//            if let error = err {
//                print("An error occured: \(error.localizedDescription)")
//            } else {
//                increaseLike ? (print("\(songID) has been liked.")) : (print("\(songID) has been unliked."))
//            }
//        }
//    }
//
//    func shareSong(songID: String) {
//        let songRef = database.collection("songs").document(songID)
//        songRef.updateData(["shares": FieldValue.increment(Int64(1))]) { (err) in
//            if let error = err {
//                print("An error occured: \(error.localizedDescription)")
//            } else {
//                print("\(songID) has been shared.")
//            }
//        }
//    }
//
//    func commentSong(songID: String, increaseComment: Bool) {
//        let songRef = database.collection("songs").document(songID)
//        songRef.updateData(["comments": increaseComment ? (FieldValue.increment(Int64(1))) : (FieldValue.increment(Int64(-1)))]) { (err) in
//            if let error = err {
//                print("An error occured: \(error.localizedDescription)")
//            } else {
////                print("Document successfully updated.")
//            }
//        }
//    }
//
//    func increaseSongListens(songID: String) {
//        let songRef = database.collection("songs").document(songID)
//        songRef.updateData(["listens": FieldValue.increment(Int64(1))]) { (err) in
//            if let error = err {
//                print("An error occured: \(error.localizedDescription)")
//            } else {
////                print("\(songID) is being listened to.")
//            }
//        }
//    }
//
//    func handleAudioArtworkDownload() {
//
//    }
//
//    func handleUserArtworkUpload(profImageLink: String, coverImageLink: String, name: String) {
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        if let data = try? Data(contentsOf: URL(string: profImageLink)!) {
//            let childs = storageRef?.child("userProfileImages").child(name)
//            childs?.child("prof-\(name)").putData(data, metadata: metadata) { (metadata, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
//                    print("Document updated successfully.")
//                    childs?.child("prof-\(name)").downloadURL { url, error in
//                        if let error = error {
//                            print("an error occured: \(error.localizedDescription)")
//                        } else {
//                          print("profile url for download is \(url)")
//                        }
//                    }
//                }
//            }
//        }
//        if let data = try? Data(contentsOf: URL(string: coverImageLink)!) {
//            let childs = storageRef?.child("userProfileImages").child(name)
//            childs?.child("cover-\(name)").putData(data, metadata: metadata) { (metadata, error) in
//                if let error = error {
//                    print(error.localizedDescription)
//                } else {
//                    print("Document updated successfully.")
//                    childs?.child("cover-\(name)").downloadURL { url, error in
//                        if let error = error {
//                            self.displayError(error: error)
//                        } else {
//                          print("cover url for download is \(url)")
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//extension NSObject {
//    func displayError(error: Error?) -> Bool {
//        if error != nil {
//            print("An error occured: \(error?.localizedDescription ?? "")")
//            return false
//        }
//        return true
//    }
//}
