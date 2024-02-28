//
//  SocketConnection.swift
//  Updated Gliding
//
//  Created by Andrew Stringfellow on 2/27/24.
//

import Foundation
import SocketIO


class SocketConnection {
    let socket: SocketIOClient
    let socketManager: SocketManager
    
    init(thermalChangeHandler: @escaping ( [Thermal]) -> Void) {
        self.socketManager = SocketManager(
            socketURL: URL(string: SocketConfig.url)!,
            config: [.log(true), .compress]
        )
        
        self.socket = self.socketManager.defaultSocket
        
        self.socket.on(clientEvent: .connect) { data, ack in
            print("Socket Connected")
        }
        self.socket.on("change") { data, ack in
            do {
                let thermalJSONData = String(describing: data[0]).data(using: .utf8)!
                let thermal = try JSONDecoder().decode(Thermal.self, from: thermalJSONData)
                print("THERMAL")
                thermalChangeHandler([thermal])
                
            } catch {
                print(error)
            }
        }
        self.socket.connect()
    }
    
}
