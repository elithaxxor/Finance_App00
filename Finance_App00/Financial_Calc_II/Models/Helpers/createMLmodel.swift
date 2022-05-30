//
//  createMLmodel.swift
//  Finance_App00
//
//  Created by a-robota on 5/28/22.
//

import UIKit
import SwiftyJSON
import CoreML
import SwifteriOS


// api key 6HE1wYuuAOF9UQvxtI9aMlcfX

// secret key r0XWPP9uUT0FW9q1yQ9KrnkT8Kxgmr2oiL9MeC7c70HyUlgc39

// bearer token AAAAAAAAAAAAAAAAAAAAAHZudAEAAAAAQVQhVshdEIqL5ViZAPg8rVDYVgg%3DNvwO9U3BCfGgPs8kqYWBFcTR91qcbsbkzZX7qlfSpy2vzvKLzE

struct loadML {

    func runTrainingModule() {
    // train then test -> 80/20 SPLIT - Column Name [class] && row [text]
    let(trainingData, testingData) = Data.randomSplit(by: 0.8, seed: 0.2 )
    let data = MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/adelal-aali/Desktop/Finance_App00/twitter-sanders-apple3.csv"))

    let sentimentClassifier = try MLTextClassifier(trainingData:, colLabel: "text", rowlabel:"class")

    //MARK: EVALUATE Errors in Classification

    let testingMetrics = sentimentClassifier.evaluation(testingData)
    let classificiationErr = (1.0 - testingMetrics.classificationError) * 100

    try sentimentClassifier.write(URL(fileURLWithPath: "Users/adelal-aali/Desktop/Finance_App00/"))
    try sentimentClassifier.prediction("@do not buy twitter stock")
    try sentimentClassifier.prediction("@I wrote a scam app, do not buy")
    try sentimentClassifier.prediction("@Google does not make a safe phone")
    }
}

func sentimentClassifier () {

}

