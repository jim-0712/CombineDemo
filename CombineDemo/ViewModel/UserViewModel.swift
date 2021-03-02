//
//  UserViewModel.swift
//  CombineDemo
//
//  Created by Fu Jim on 2021/3/2.
//

import Foundation
import Combine

struct Users: Codable {
    let name: String
    let email: String
    let company: Company
}

struct Company: Codable {
    let name: String
}

class UserViewModel {
    
    private let urlString = "https://jsonplaceholder.typicode.com/users"
    var users = [Users]()
    var usersSubjects = PassthroughSubject<[Users], Error>()
    var subscribetion = Set<AnyCancellable>()
    
    var userPublisher: AnyPublisher<[Users], Error> {
        let url = URL(string: urlString)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data})
            .decode(type: [Users].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    internal
    func fetchUser() {
        userPublisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print(".finished")
                self.usersSubjects.send(completion: .finished)
            case .failure(let error):
                print(".failure(\(error)")
                self.usersSubjects.send(completion: .failure(error))
                break
            }
        },
        receiveValue: {
            self.usersSubjects.send($0)
        }).store(in: &subscribetion)
    }
}
