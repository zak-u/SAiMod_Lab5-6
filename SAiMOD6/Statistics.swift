//
//  Statistics.swift
//  SAiMOD4
//
//  Created by Zakhary on 10/26/21.
//

import Foundation

class Statistics {
    let lambda : Double
    let mu : Double
    let time : Double


    var servedCount : Int = 0
    var timeWithoutLatency : Double = 0
    var commonTime : Double = 0
    
    var current_time : Double = 0
    var sourceFlags : Bool = false
    var sourceTime : Double = 0
    var channelTime : Double = 0
    var channelFlags : Bool = false
    
    var queue : Int = 0
    var state : StateType = .state00
    
    var sgenericSignal : Double = 0
    let pi1 : Double
    let pi2 : Double 
    var Potk : Double = 0
    var Pbl : Double = 0
    var Loch : Double = 0
    var Lc : Double = 0
    var A : Double = 0
    var Kch1 : Double = 0
    var Kch2 : Double = 0
    var Woch : Double = 0
    var Wc : Double = 0
    var Ttaktov : Double = 0
    var AllTime : Int = 0
    var AllOut : Int = 0
    var array : [Request?] = [nil,nil,nil,nil]
    var tactOutSum : Double = 0
    var timeOut : Int = 0
    
    public func updateRequst() {
        for req in array {
            if req != nil {
                req?.time += 1
            }
        }
    }

    init(lambda: Double, mu : Double, time : Double) {
        self.lambda = lambda
        self.mu = mu
        self.time = time
    }
    
    public func run(current_time : Double){
        self.current_time = current_time
        generateNextRequests()
        if (current_time >= self.time) {
            return
        }
        updateChannels()
    }
    
    public func generateNextRequests(){
        if (!sourceFlags) {
            sourceFlags = true
            var tmpTime : Double = 0
    //        if (i == channelFlags[j]) {
    //            tmpTime = channelTime[j];
    //        }
            sourceTime = tmpTime + -log(Double.random(in: 0.0 ... 1.0)) / lambda
        }
    }
    
//    public func nextRequest(){
//        sourceFlags = true
//        var tmpTime : Double = 0
////        if (i == channelFlags[j]) {
////            tmpTime = channelTime[j];
////        }
//        sourceTime = tmpTime + -log(Double.random(in: 0.0 ... 1.0)) / lambda
//    }
    
    public func updateChannels(){
        var minTime = time
        var tmpTime : Double = 0
        tmpTime = handleRequest()
        if (tmpTime < minTime) {
            minTime = tmpTime
        }
        run(current_time: minTime)
    }
    
    
    public func handleRequest() -> Double {
        if (current_time >= channelTime)
        {
            sourceFlags = false
            servedCount += 1
            channelFlags = true
            let tmp : Double = -log(Double.random(in: 0.0 ... 1.0)) /  mu
            timeWithoutLatency += tmp;
            if (sourceTime > current_time){
                channelTime = sourceTime + tmp
            }else{
                channelTime = current_time + tmp
            }
            commonTime += channelTime - sourceTime
        }
        return channelTime
    }
    







    
    public func incSgenericSignal(){
        sgenericSignal += 1
    }
    
    public func incPotk(){
        Potk += 1
    }
    
    public func incPbl(){
        Pbl += 1
    }
    
    public func incLoch(){
        Loch += 1
    }
    
    public func incLc(count : Int = 1){
        Lc += Double(count)
    }
    
    public func incA(){
        A += 1
    }
    
    public func incKch1(){
        Kch1 += 1
    }
    
    public func incKch2(){
        Kch2 += 1
    }
    
    //state
    
    
    
    public func getResults() -> (Potk : Double,
                                 Pbl : Double,
                                 Loch : Double,
                                 Lc : Double,
                                 A : Double,
                                 Kch1 : Double,
                                 Kch2 : Double,
                                 Woch : Double,
                                 Wc : Double){
        return ( Potk: Potk/sgenericSignal, Pbl: Pbl/N, Loch : Loch/N,Lc: Lc/N, A:A/N,Kch1 : Kch1 / N, Kch2: Kch2 / N, Woch: Loch/A, Wc : Lc / sgenericSignal )
    }
    

}
