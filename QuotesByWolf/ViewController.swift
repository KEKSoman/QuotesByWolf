import UIKit
import AVFoundation

private let imageUrl = "https://picsum.photos/200"

class ViewController: UIViewController {
    @IBOutlet var button: UIButton!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func actionButton(_ sender: UIButton) {
        fetchImage()
        currentQuote()
        
    }
    
    private func fetchImage(){
        guard let url = URL(string: imageUrl) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            if  let error = error {
                print(error.localizedDescription)
                return
            }
            if let response = response {
                print(response)
            }
            if let data = data, let image = UIImage(data: data){
                DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        }.resume()
    }
    private func currentQuote(){
        messageLabel.text = quotes.randomElement()
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: messageLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru-RU")
        synthesizer.speak(utterance)
        
    }
}

