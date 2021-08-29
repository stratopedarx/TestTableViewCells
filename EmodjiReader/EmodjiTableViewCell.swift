import UIKit

class EmodjiTableViewCell: UITableViewCell {

    @IBOutlet weak var emodjiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(object: Emodji) {
        self.emodjiLabel.text = object.emodji
        self.nameLabel.text = object.name
        self.descriptionLabel.text = object.description
    }
}
