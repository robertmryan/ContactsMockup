//
//  ViewController.swift
//  ContactsMockup
//
//  Created by Robert Ryan on 1/14/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint?
    @IBOutlet weak var profileLabel: UILabel!

    let minHeight: CGFloat = 150
    let maxHeight: CGFloat = 200

    let minPointSize: CGFloat = 16
    let maxPointSize: CGFloat = 26

    override func viewDidLoad() {
        super.viewDidLoad()

        heightConstraint?.constant = maxHeight
        
        tableView.clipsToBounds = false

        // IB is not letting me change move these subviews where I want them in the hierarchy, so I'll do it programmatically
        view.bringSubviewToFront(backgroundView)
        view.bringSubviewToFront(headerView)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell", for: indexPath) as! ContentCell

        let subviews = cell.stackView.arrangedSubviews
        for subview in subviews {
            cell.stackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }

        for i in 1 ... 100 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "Field \(i)"
            cell.stackView.addArrangedSubview(label)
        }

        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = min(scrollView.contentOffset.y, maxHeight - minHeight)
        heightConstraint?.constant = maxHeight - offset

        let percent = 1 - offset / (maxHeight - minHeight)
        profileLabel.font = UIFont.systemFont(ofSize: minPointSize + (maxPointSize - minPointSize) * percent)
    }
}
