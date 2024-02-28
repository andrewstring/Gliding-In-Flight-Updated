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
    
    init(thermalChangeHandler: ([Thermal]) -> Void) {
        self.socketManager = SocketManager(
            socketURL: URL(string: SocketConfig.url)!,
            config: [.log(true), .compress]
        )
        
        self.socket = self.socketManager.defaultSocket
        
        self.socket.on(clientEvent: .connect) { data, ack in
            print("Socket Connected")
        }
        self.socket.on("change") { data, ack in
            print("DATA")
            print(data[0])
            print((data[0]) as? Thermal)
            print("JKLJKL")
        }
        self.socket.connect()
    }
}
