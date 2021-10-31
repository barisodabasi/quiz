//
//  ViewController.swift
//  Trivial
//
//  Created by BarisOdabasi on 12.12.2020.
//

import UIKit
import Alamofire
import SwiftyJSON

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var answerStatusLabel: UILabel!
    var options = ["", "", "", ""]
    var indexes = [0, 1, 2, 3]
    var spinner: UIActivityIndicatorView?
    var spinnerContainer: UIView?
    var currentQuestion: QuestionData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
        fetchNextQuestion()
    }
    
    func fetchNextQuestion(){
        showIndicator()
        NetworkUtils().fetchQuestion(completionHandler: {(questionData, error) in
            self.hideIndicator()
            if (questionData != nil){
                self.currentQuestion = questionData
                let mIndex = Int.random(in: 0...3)
                self.options[mIndex] = questionData!.correct_answer
                
                if (mIndex == 0){
                    self.options[1] = questionData!.incorrect_answers[0]
                    self.options[2] = questionData!.incorrect_answers[1]
                    self.options[3] = questionData!.incorrect_answers[2]
                } else if (mIndex == 1){
                    self.options[0] = questionData!.incorrect_answers[0]
                    self.options[2] = questionData!.incorrect_answers[1]
                    self.options[3] = questionData!.incorrect_answers[2]
                } else if (mIndex == 2){
                    self.options[0] = questionData!.incorrect_answers[0]
                    self.options[1] = questionData!.incorrect_answers[1]
                    self.options[3] = questionData!.incorrect_answers[2]
                } else if (mIndex == 3){
                    self.options[0] = questionData!.incorrect_answers[0]
                    self.options[1] = questionData!.incorrect_answers[1]
                    self.options[2] = questionData!.incorrect_answers[2]
                }
                self.setupUI()
            } else {
                self.answerStatusLabel.text = error
            }
        })
    }
    
    func setupUI() {
        var questionText = currentQuestion!.question
        questionText = questionText.replacingOccurrences(of: "&quot;", with: "\"")
        questionLabel.text = questionText
        optionsTableView.isHidden = false
        optionsTableView.reloadData()
        resultView.isHidden = true
    }
    
    func showIndicator(){
        spinnerContainer = UIView.init(frame: self.view.frame)
        spinnerContainer!.center = self.view.center
        spinnerContainer!.backgroundColor = .init(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
        self.view.addSubview(spinnerContainer!)
        
        spinner = UIActivityIndicatorView.init(style: .large)
        spinner!.center = spinnerContainer!.center
        spinnerContainer!.addSubview(spinner!)
        
        spinner!.startAnimating()
    }
    
    func hideIndicator(){
        spinner?.removeFromSuperview()
        spinnerContainer?.removeFromSuperview()
    }


    @IBAction func onTapNext(_ sender: Any) {
        fetchNextQuestion()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell") as! OptionCell
        cell.optionTextLabel.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        resultView.isHidden = false
        if (options[indexPath.row] == currentQuestion?.correct_answer) {
            answerStatusLabel.text = "Well done !"
        } else {
            answerStatusLabel.text = "Wrong answer !"
        }
    }
    
}

