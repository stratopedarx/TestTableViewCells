import UIKit

class NewEmodjiTableViewController: UITableViewController {

    var emodji = Emodji(emodji: "", name: "", description: "", isFavourite: false)

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emodjiTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSaveButtonState()
    }

    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    private func updateSaveButtonState() {
        let emodji = emodjiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""

        saveButton.isEnabled = !emodji.isEmpty && !name.isEmpty && !description.isEmpty
    }

    private func updateUI() {
        emodjiTF.text = emodji.emodji
        nameTF.text = emodji.name
        descriptionTF.text = emodji.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else { return }
        let emodji = emodjiTF.text ?? ""
        let name = nameTF.text ?? ""
        let description = descriptionTF.text ?? ""
        self.emodji = Emodji(emodji: emodji, name: name, description: description, isFavourite: self.emodji.isFavourite)
    }
}
