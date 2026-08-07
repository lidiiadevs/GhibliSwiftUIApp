//
//  GhibliSwiftUIAppTests.swift
//  GhibliSwiftUIAppTests
//
//  Created by Lidiia Diachkovskaia on 7/15/26.
//

import Foundation
import Testing
@testable import GhibliSwiftUIApp
//import XCTest


struct GhibliSwiftUIAppTests {  // unit test
    
    struct MockGhibliService: GhibliAPIService {
        
        let mockFilms: [Film]
        let shouldThrowError: Bool
        let fetchDelay: Duration
        
        init(mockFilms: [Film], shouldThrowError: Bool = false, fetchDelay: Duration = .zero) {
            self.mockFilms = mockFilms
            self.shouldThrowError = shouldThrowError
        }
        
        //MARK: - Protocol comformance
        
        func fetchFilms() async throws -> [Film] {
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "Test", code: -1))
            }
            
            if fetchDelay > .zero {
                try await Task.sleep(for: fetchDelay)
            }
            
            return mockFilms
        }
        
        func searchFilm(for searchTerm: String) async throws -> [Film] {
            if shouldThrowError {
                throw APIError.networkError(NSError(domain: "Test", code: -1))
            }
            if searchTerm.isEmpty {
                return mockFilms
            }
            
            return mockFilms.filter{
                $0.title.localizedCaseInsensitiveContains(searchTerm)
            }
        }
        
        func fetchPerson(from URLString: String) async throws -> Person {
            return Person(id: <#T##String#>, name: <#T##String#>, gender: <#T##String#>, age: <#T##String#>, eyeColor: <#T##String#>, hairColor: <#T##String#>, films: <#T##[String]#>, species: <#T##String#>, url: <#T##String#>)
        }
    }
    
    //MARK: - Test Data
    
    let mockFilms = [
        Film(
            id: "1",
            title: "My Neighbor Totoro",
            image: "",
            description: "Two sisters discover Totoro",
            director: "Hayao Miyazaki",
            producer: "Isao Takahata",
            people: [],
            bannerImage: "",
            releaseYear: "1988",
            duration: "",
            score: "93"
        ),
        Film(
            id: "2",
            title: "Spiritted Away",
            image: "",
            description: "A girl enters a spirit world",
            director: "Hayao Miyazaki",
            producer: "Toshio Suzuki",
            people: [],
            bannerImage: "",
            releaseYear: "2001",
            duration: "",
            score: "97"
        )
    ]
    
    
    @MainActor
    @Test func testInitialState() async throws {
        let service = MockGhibliService(mockFilms: mockFilms)
        let viewModel = SearchFilmsViewModel(service: service)
        
        #expect(viewModel.state.data == nil)
        if case .idle = viewModel.state {
            
        } else {
            Issue.record("Expects idle state")
        }
    }
    
    @MainActor
    @Test("Search with query filters results")
    func testSearchWithQuery() async {
        let service = MockGhibliService(mockFilms: mockFilms)
        let viewModel = SearchFilmsViewModel(service: service)
        
        await viewModel.fetch(for: "Totoro")
        
        #expect(viewModel.state.data?.count == 1)
        #expect(viewModel.state.data?.first?.title == "My Neighbor Totoro")
        
    }
    
    @MainActor
    @Test("Search result gives error")
    func testSearchWithError() async {
        let service = MockGhibliService(mockFilms: mockFilms, shouldThrowError: true)
        let viewModel = SearchFilmsViewModel(service: service)
        
        await viewModel.fetch(for: "Totoro")
        
        #expect(viewModel.state.error != nil)
        
    }
    
    @MainActor
    @Test("Task Cancellation after API call prevents state update")
    func testCancellationAfterAPICall() async {
        let service = MockGhibliService(mockFilms: mockFilms, fetchDelay: .milliseconds(100))
        let viewModel = SearchFilmsViewModel(service: service)
        
        let task = Task {
            await viewModel.fetch(for: "tot")
        }
        
    }
  
}


//final class GhibliSwiftUIAppTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

