//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet var answerButtons: [UIButton]!

    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let userAnswer = sender.currentTitle else { return }
        let userGotItRight = quizBrain.checkAnswer(userAnswer)

        guard userGotItRight else {
            sender.backgroundColor = UIColor.red
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
            return
        }
        sender.backgroundColor = UIColor.green
        quizBrain.nextQuestion()
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
    }

    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
        progressBar.progress = quizBrain.getProgress()
        let questionAnswers = quizBrain.getQuestionAnswer()

        for (answerButton, questionAnswer) in zip(answerButtons, questionAnswers) {
            answerButton.setTitle(questionAnswer, for: .normal)
            answerButton.backgroundColor = UIColor.clear
        }
    }

}

