//
//  MassageViewController.swift
//  d07
//
//  Created by Kevin VIGNAU on 10/10/18.
//  Copyright © 2018 Kevin VIGNAU. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import ForecastIO
import RecastAI

class MassageViewController:  JSQMessagesViewController {

    let token = ""
    let apiKey = ""


    var bot : RecastAIClient?
    var foreCast: DarkSkyClient?
    var location: Location?
    var messages = [JSQMessage]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        let message = self.messages[indexPath.row]
        if let username = message.senderDisplayName {
            let messageUserName = username
            return NSAttributedString(string: messageUserName)
        }
        return NSAttributedString(string: "Default name")
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        return 15
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        self.createMessage(id: "0", name: "Bot", text: "I don't accept attachments")
    }
    
    func sendQuestion(question: String) {
        guard let bot = self.bot else { return }
        bot.textRequest(question, successHandler: { (response) in
            guard let resp = response.entities!["location"] as? [NSDictionary], let myLat = resp[0]["lat"], let myLng = resp[0]["lng"] else { self.createMessage(id: "0", name: "Bot", text: "No Result"); return }
            
            self.foreCast!.getForecast(latitude: myLat as! Double, longitude: myLng as! Double) { result in
                switch result {
                case .success(let currentForecast, _):
                    guard let weather = currentForecast.currently?.summary, let temperature = currentForecast.currently?.temperature else { self.createMessage(id: "0", name: "Bot", text: "Oups ! I can't find the weather for the moment ... sorry !"); return }
                    
                    DispatchQueue.main.async {
                        self.createMessage(id: "0", name: "Bot", text: "It's " + weather + " and the temperature is " + String(temperature) + "F")
                    }
                case .failure(_):
                    if let error = result.error {
                        print(error.localizedDescription)
                    }
                }
            }
        }, failureHandle: { (error) in
            print(error.localizedDescription)
        })
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        self.createMessage(id: "1", name: "Me", text: text)
        sendQuestion(question: text)
        finishSendingMessage()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleImage = JSQMessagesBubbleImageFactory()
        let message = self.messages[indexPath.row]
        
        if message.senderId == "1" {
            return bubbleImage?.incomingMessagesBubbleImage(with: .blue)
        }
        return bubbleImage?.incomingMessagesBubbleImage(with: .lightGray)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bot = RecastAIClient(token : token, language: "fr")
        self.foreCast = DarkSkyClient(apiKey: apiKey)
        self.senderId = "1"
        self.senderDisplayName = "Me"
        createMessage(id: "0", name: "Bot", text: "What can I do for you ?")
    }
    
    func createMessage(id: String, name: String, text: String) {
        self.messages.append(JSQMessage(senderId: id, displayName: name, text: text))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
