//
//  StateType.swift
//  SAiMOD4
//
//  Created by Zakhary on 10/26/21.
//

import Foundation

enum StateType  {
    case state00
    case state01
    case state02
    case state03
    case state11
    case state12
    case state13
    case state21
    case state22
    case state23
}


class Request {
    var time : Int = 0
    var tactIn : Int = 0
    var tactOut : Int = 0
}
protocol StateAction {
    
    func performAction(statistics: Statistics, lCurrent : Double, mCurrent : Double) -> StateType?
}

class State00Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP2000()
        return StateType.state1000
    }
    
}

class State01Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP1000()
        statistics.incSgenericSignal()
        
        statistics.array[1] = Request()
        
        return StateType.state2100
    }
}

class State02Action: StateAction {

    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP2100()
        
        statistics.updateRequst()
        
        statistics.incLc()
        statistics.incKch1()
        if (lCurrent < statistics.pi1 ) {
            return StateType.state1100
        }
        if (lCurrent >= statistics.pi1) {
            
            statistics.array[3] = statistics.array[1]!
            statistics.array[1] = nil
            
            return StateType.state1001
        }
        else {
            return nil
        }
    }
    
}

class State03Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP1100()
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
//        statistics.array[0] = Request()
        
        statistics.incLc()
        statistics.incKch1()
        if (lCurrent < statistics.pi1 ) {
            
            statistics.array[0] = Request()
            
            return StateType.state0100
        }
        if (lCurrent >= statistics.pi1) {
            
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = Request()
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
    
}

class State11Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP0100()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 2)
        statistics.incKch1()
        statistics.incPbl()
        if (lCurrent < statistics.pi1 ) {
            return StateType.state0100
        }
        if (lCurrent >= statistics.pi1) {
            
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = statistics.array[0]
            statistics.array[0] = nil
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
}

class State12Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP1001()
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incLc()
        statistics.incKch2()
        if (mCurrent < statistics.pi2 ) {
            
            statistics.array[1] = Request()
            return StateType.state2101
        }
        if (mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.array[1] = Request()
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state2100
        }
        else {
            return nil
        }
    }
    
}

class State13Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP2101()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 2)
        statistics.incKch1()
        statistics.incKch2()
        if (lCurrent < statistics.pi1 && mCurrent < statistics.pi2) {
            return StateType.state1101
        }
        if (lCurrent < statistics.pi1 && mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state1100
        }
        if (lCurrent >= statistics.pi1 && mCurrent < statistics.pi2) {
            
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = nil
            
            return StateType.state1011
        }
        if (lCurrent >= statistics.pi1 && mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllOut +=  1

            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = nil
            
            return StateType.state1001
        }
        else {
            return nil
        }
    }
    
}
//this blok
class State21Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incP1101()
        statistics.incLc(count: 2)
        statistics.incKch1()
        statistics.incKch2()
        if (lCurrent < statistics.pi1 && mCurrent < statistics.pi2) {
            statistics.array[0] = Request()
            return StateType.state0101
        }
        if (lCurrent < statistics.pi1 && mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = nil
            statistics.array[0] = Request()
            
            statistics.AllOut +=  1
            
            return StateType.state0100
        }
        if (lCurrent >= statistics.pi1 && mCurrent < statistics.pi2) {
            
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = Request()
            
            return StateType.state2111
        }
        if (lCurrent >= statistics.pi1 && mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[1]
            statistics.array[1] = Request()
            
            statistics.AllOut +=  1
            
            return StateType.state2101
        }
        else {
            return nil
        }
    }
}

class State22Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incSgenericSignal()
        
        statistics.updateRequst()
        
        statistics.incP1011()
        statistics.incLc(count: 2)
        statistics.incLoch()
        statistics.incKch2()
        if (mCurrent < statistics.pi2 ) {
            
            statistics.array[1] = Request()
            
            return StateType.state2111
        }
        if (mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = nil
            statistics.array[1] = Request()
            
            statistics.AllOut +=  1
            
            return StateType.state2101
        }
        else {
            return nil
        }
        
        
    }
    
}

class State23Action: StateAction {
    func performAction(statistics: Statistics, lCurrent: Double, mCurrent: Double) -> StateType? {
        statistics.incP2111()
        
        statistics.updateRequst()
        
        statistics.incLc(count: 3)
        statistics.incKch1()
        statistics.incKch2()
        statistics.incLoch()
        if (lCurrent < statistics.pi1 && mCurrent < statistics.pi2) {
            return StateType.state1111
        }
        if (lCurrent < statistics.pi1 && mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state1101
        }
        if (lCurrent >= statistics.pi1 && mCurrent < statistics.pi2) {
            statistics.incPotk()
            statistics.timeOut  += statistics.array[1]!.time
            statistics.array[1] = nil
            
            return StateType.state1011
        }
        if (lCurrent >= statistics.pi1 && mCurrent >= statistics.pi2) {
            statistics.incA()
            
            statistics.AllTime +=  statistics.array[3]!.time
            statistics.array[3] = statistics.array[2]
            statistics.array[2] = statistics.array[1]
            statistics.array[1] = nil
            
            statistics.AllOut +=  1
            
            return StateType.state1011
        }
        else {
            return nil
        }
    }
    
}

