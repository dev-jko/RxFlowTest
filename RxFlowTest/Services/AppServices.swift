//
//  AppServices.swift
//  RxFlowTest
//
//  Created by Jaedoo Ko on 2020/09/11.
//  Copyright © 2020 jko. All rights reserved.
//

import Foundation
import RxSwift

struct AppServices {
    
    init() {
        
    }
    
    func returnBool(returnValue: Bool) -> Observable<Bool> {
        return Observable.just(returnValue)
    }
    
    func watchedMovies() -> [Movie] {
        return [
            Movie(id: 21212,
                  title: "Star Trek Beyond",
                  year: 2016,
                  budget: 185000000,
                  director: "Justin Lin",
                  writer: "S. Pegg",
                  image: "startrek",
                  watched: false),
            Movie(id: 14323,
                  title: "Starwars: The force awakens",
                  year: 2015,
                  budget: 245000000,
                  director: "JJ. Abrams",
                  writer: "L. Kasdan",
                  image: "starwars",
                  watched: false),
            Movie(id: 23452,
                  title: "Avatar",
                  year: 2009,
                  budget: 237000000,
                  director: "J. Cameron",
                  writer: "J. Cameron",
                  image: "avatar",
                  watched: false),
            Movie(id: 35423,
                  title: "Blade Runner",
                  year: 1982,
                  budget: 28000000,
                  director: "R. Scott",
                  writer: "H. Fetcher",
                  image: "bladerunner",
                  watched: false),
            Movie(id: 43424,
                  title: "The Terminator",
                  year: 1984,
                  budget: 6400000,
                  director: "J. Cameron",
                  writer: "J. Cameron",
                  image: "terminator",
                  watched: true),
            Movie(id: 55423,
                  title: "Predator",
                  year: 1987,
                  budget: 15000000,
                  director: "J. McTiernan",
                  writer: "J. Thomas",
                  image: "predator",
                  watched: true),
            Movie(id: 64323,
                  title: "Dune",
                  year: 1984,
                  budget: 40000000,
                  director: "D. Lynch",
                  writer: "F. Herbert",
                  image: "dune",
                  watched: true),
            Movie(id: 7253,
                  title: "First Constact",
                  year: 1996,
                  budget: 45000000,
                  director: "J. Frakes",
                  writer: "G. Roddenberry",
                  image: "firstcontact",
                  watched: true),
            Movie(id: 5864,
                  title: "Dune",
                  year: 1984,
                  budget: 40000000,
                  director: "D. Lynch",
                  writer: "F. Herbert",
                  image: "dune",
                  watched: true),
            Movie(id: 9432,
                  title: "First Constact",
                  year: 1996,
                  budget: 45000000,
                  director: "J. Frakes",
                  writer: "G. Roddenberry",
                  image: "firstcontact",
                  watched: true)
        ]
    }
}
