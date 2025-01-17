//
//  QuestionTableViewController.swift
//  Q-and-A
//
//  Created by Alex Shillingford on 6/6/19.
//  Copyright © 2019 Alex Shillingford. All rights reserved.
//

import UIKit

class QuestionTableViewController: UITableViewController {
    
    var questionController = QuestionController()
    var cellTapped: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return questionController.questions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as? QuestionTableViewCell else { return UITableViewCell() }
        cell.questionTextLabel.text = questionController.questions[indexPath.row].question
        cell.askedByLabel.text = questionController.questions[indexPath.row].asker
        
        cellTapped = indexPath.row

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let question = questionController.questions[indexPath.row]
            
            questionController.delete(deleteQuestion: question)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AskQuestionSegue" {
            guard let questionDestinationVC = segue.destination as? AskQuestionViewController else { return }
            questionDestinationVC.questionController = questionController
        }
        
        if segue.identifier == "ShowAnswerSegue" {
            guard let answerDestinationVC = segue.destination as? AnswerQuestionViewController else { return }
            answerDestinationVC.questionController = questionController
            answerDestinationVC.question = questionController.questions[cellTapped]
        }
    }
    

}
