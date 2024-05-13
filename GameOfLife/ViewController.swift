//
//  ViewController.swift
//  GameOfLife
//
//  Created by Lambert Lani on 5/13/24.
//

import UIKit

struct Cell {
    var isAlive: Bool
    var isLife: Bool?
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonNew: UIButton!
    @IBOutlet weak var lable: UILabel!
    
    var cells: [Cell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        userInterface()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    func userInterface() {
        let clr = UIColor(red: 84/255.0, green: 55/255.0, blue: 111/255.0, alpha: 1.0)
        
        lable.textColor = .white
        lable.textAlignment = .center
        
        buttonNew.tintColor = .white
        buttonNew.backgroundColor = clr
        buttonNew.layer.cornerRadius = 5
        buttonNew.setTitle("СОТВОРИТЬ", for: .normal)
        
        
        let gradientLayerView = CAGradientLayer()
        gradientLayerView.frame = view.bounds
        gradientLayerView.colors = [clr.cgColor, UIColor.black.cgColor]
        gradientLayerView.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayerView, at: 0)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = tableView.bounds
        gradientLayer.colors = [clr.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.0, 1.0]

        let gradientView = UIView(frame: tableView.bounds)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        tableView.backgroundView = gradientView
    }
    
    @IBAction func makeCell(_ sender: Any) {
        let newCell = Cell(isAlive: Bool.random())
        cells.append(newCell)

        let indexPath = IndexPath(row: cells.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        
        if cells.count > 3 && isActiveFunc(1) && isActiveFunc(2) && isActiveFunc(3) {
            let bonusCell = Cell(isAlive: false, isLife: true)
            cells.append(bonusCell)
            let indexPath = IndexPath(row: cells.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        } else if cells.count > 3 && !isActiveFunc(1) && !isActiveFunc(2) && !isActiveFunc(3) && !isLifeFunc(3) {
            var lastLifeIndex: Int?
            for i in (0..<cells.count).reversed() {
                if cells[i].isLife == true {
                    lastLifeIndex = i
                    break
                }
            }
            if let index = lastLifeIndex {
                let deathCell = Cell(isAlive: false, isLife: false)
                cells[index] = deathCell
                let indexPath = IndexPath(row: index, section: 0)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }

    func isActiveFunc(_ i: Int) -> Bool {
        if cells[cells.count - i].isAlive {
            return true
        }
        return false
    }
    
    func isLifeFunc(_ i: Int) -> Bool {
        if let a = cells[cells.count - i].isLife {
            return true
        }
        return false
    }
}

// MARK: Delegate

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCell

        let isAlive = cells[indexPath.row].isAlive

        let imageName: String
        let text: String
        let textLitle: String
        
        if let isLife = cells[indexPath.row].isLife {
            if isLife {
                imageName = "chicken"
                text = "Жизнь"
                textLitle = "Ку-ку!"
            } else {
                imageName = "death"
                text = "Смерть"
                textLitle = "Уже совсем мёртвая"
            }
        } else if isAlive {
            imageName = "spark"
            text = "Живая"
            textLitle = "и шевелится!"
        } else {
            imageName = "death"
            text = "Мёртвая"
            textLitle = "или прикидывается"
        }
        
        cell.configure(with: imageName, text: text, textLitle: textLitle)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
}
