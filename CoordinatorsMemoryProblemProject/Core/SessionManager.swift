//
//  SessionManager.swift
//  CoordinatorsMemoryProblemProject
//
//  Created by Charles Prado on 11/12/2020.
//

import Foundation
import RxSwift

class SessionManager {
    private init() {}
    
    public let didFinishSession = PublishSubject<Void>()
    
    public static let shared = SessionManager()
}
