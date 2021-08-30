import UIKit

class EmodjiTableViewController: UITableViewController {
    var objects = [
        Emodji(emodji: "😍", name: "Love", description: "Let`s love each other", isFavourite: false),
        Emodji(emodji: "😎", name: "Glasses", description: "Let`s glass each other", isFavourite: false),
        Emodji(emodji: "🐈‍⬛", name: "Cat", description: "Cat. This is good", isFavourite: true)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emodji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else { return }
        let sourceVC = segue.source as! NewEmodjiTableViewController
        let emodji = sourceVC.emodji
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emodji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
            let newIndexPath = IndexPath(row: objects.count, section: 0)
            objects.append(emodji)
            tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmodji" else { return }
        let indexPath = tableView.indexPathForSelectedRow!
        let emodji = objects[indexPath.row]
        // сначала добираемся до навигейшн вию контроллер, а потом до нью эмоджи табле вью контроллер
        let navigationVC = segue.destination as! UINavigationController
        let newEmodjiVC = navigationVC.topViewController as! NewEmodjiTableViewController
        newEmodjiVC.emodji = emodji
        newEmodjiVC.title = "Edit"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emodjiCell", for: indexPath) as! EmodjiTableViewCell
        let emodji = objects[indexPath.row]
        cell.set(object: emodji)
        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmodji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmodji, at: destinationIndexPath.row)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }

    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { action, view, completion in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }

    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") { action, view, completion in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
