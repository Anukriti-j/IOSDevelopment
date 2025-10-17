import Foundation

@Observable class UserViewModel {
    var user: User 
    
    init(user: User) {
        self.user = user
    }
    
    func increaseFollower() {
        user.followerCount += 1
    }
}

