//
//  TwitterPredictViewController.swift
//  Finance_App00
//
//  Created by a-robota on 5/28/22.
//

import UIKit
import SwiftyJSON
import CoreML
import SwifteriOS


@IBDesignable
class TwitterPredictViewController: ViewControllerLogger {

    public enum twitterAPIerr : Error {
        case encoding
        case badRequest
        case success
        case failure
    } // error handling


    let sentimentClassifier = TweetSentimentClassifier()



    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!




    override func viewDidLoad() {
        super.viewDidLoad()
        createLogFile()
        fetchTweets()
        NSLog("[LOGGING--> <START> [CALCULATOR VC]")

    }


    @IBAction func fetchTweets(_ sender: Any) {

        var tweetCount = 150

        if let swifter.searchTweet(using: "@GOOG", lang: "en", count: tweetCount, tweetMode: .extended, success: { ( results, metaData ) in
            print("[+] API Fetch Results [\(results)]")
            var tweets = [TweetSentimentClassifierInput]()

            for i in 0..<self.tweetCount {
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }

            self.makePrediction(with: tweets)

        }) { (error) in
            print("There was an error with the Twitter API Request, \(error)")
        }
    }

    public func searchTweet(using Query: String
                            geoCode: String? = nil,
                            lang:String? = nil,
                            locale:String? = nil,
                            resultType:String? = nil,
                            count:Int? = nil,
                            until: String? = nil,
                            sinceID: String? = nil,
                            maxID: String? = nil,
                            includeEntities: Bool = nil,
                            callBack: String? = nil,
                            tweetMode: TweetMode = TweetMode.default,
                            success: SearchResultHandler? = nil
                            failure: @escaping FailureHandler) {
        let path = "search/tweets.json"

        var parameters = [String : Any]()
        paramaters["q"] = query
        paramaters["geocode"] ??= geoCode
        paramaters["lang"] ??= lang
        paramaters["locale"] ??= locale
        paramaters["resultType"] ??= resultType
        paramaters["sinceID"] ??= sinceID
        paramaters["maxID"] ??= maxID
        paramaters["includeEntities"] ??= includeEntities
        paramaters["callBack"] ??= callBack
        paramaters["tweetMode"] ??= tweetMode
        paramaters["success"] ??= success
        paramaters["failure"] ??= failure






    }

    ) {

    }



    private func makePrediction(with tweets: String) {
        do {
            let predictions = try self.sentimentClassifier.predictions(input: tweets)

            var sentimentScore = 0
            for pred in predictions {
                let sentiment = pred.label

                if sentiment == "Pos"  {
                    sentiment += 1
                } else if sentiment == "Neg"{
                    sentimentScore -= 1
                }

                updateUI(score: sentimentScore)

            }
        } catch {
            print("Error \(error)")
        }
    }

    func initApi(){
        let consumerKey = "r0XWPP9uUT0FW9q1yQ9KrnkT8Kxgmr2oiL9MeC7c70HyUlgc39"
        let privKey = "r0XWPP9uUT0FW9q1yQ9KrnkT8Kxgmr2oiL9MeC7c70HyUlgc39"
        let swifter = Swifter(consumerKey:consumerKey , consumerSecret: privKey )
    }


    func updateUI(sentimentScore: Int ) {

        if sentimentScore > 20 {
            self.sentimentLabel.text = "😍"
        } else if sentimentScore > 10 {
            self.sentimentLabel.text = "😀"
        } else if sentimentScore > 0 {
            self.sentimentLabel.text = "🙂"
        } else if sentimentScore == 0 {
            self.sentimentLabel.text = "😐"
        } else if sentimentScore > -10 {
            self.sentimentLabel.text = "😕"
        } else if sentimentScore > -20 {
            self.sentimentLabel.text = "😡"
        } else {
            self.sentimentLabel.text = "🤮"
        }
    }
}

