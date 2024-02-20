//
//  GliderStore.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/18/24.
//

import Foundation

// Handles the persistent storage of the primary glider
class GliderStore: ObservableObject {
    @Published var glider: Glider?
    
    init() {
        Task {
            try await self.gliderLoad()
        }
    }
    
    private static func retrieveGliderURL() throws -> URL {
        do {
            let gliderURL = try FileManager.default.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: true)
                .appendingPathComponent("glider.data")
            return gliderURL
        } catch {
            throw GliderStoreError.gliderURLRetrievalError
        }
    }
    
    func gliderLoad() async throws {
        let task = Task<Glider?, Error> {
            do {
                let gliderURL = try Self.retrieveGliderURL()
                do {
                    let gliderData = try Data(contentsOf: gliderURL)
                    let decodedGliderData = try JSONDecoder().decode(Glider.self, from: gliderData)
                    return decodedGliderData
                } catch {
                    throw GliderStoreError.parsingGliderDataError
                }
            } catch {
                throw error
            }
        }
        self.glider = try? await task.value
    }
    
    @discardableResult
    func gliderSave(glider: Glider) async throws -> Glider? {
        let task = Task<Glider?, Error> {
            do {
                let gliderURL = try Self.retrieveGliderURL()
                do {
                    let encodedGlider = try JSONEncoder().encode(glider)
                    try encodedGlider.write(to: gliderURL)
                    try await self.gliderLoad()
                    return glider
                } catch {
                    throw GliderStoreError.gliderSaveError
                }
            } catch {
                throw error
            }
        }
        return try? await task.value
    }
    
    func gliderRemove() async throws -> Void {
        let task = Task<Void, Error> {
            do {
                let gliderURL = try Self.retrieveGliderURL()
                do {
                    let emptyGlider = Data()
                    try emptyGlider.write(to: gliderURL)
                } catch {
                    throw GliderStoreError.gliderRemoveError
                }
            } catch {
                throw error
            }
            return
        }
        return try await task.value
    }
}
