import UIKit
func getImage(from string: String) -> UIImage? {
    //2. Get valid URL
    guard let url = URL(string: string)
        else {
            print("Unable to create URL")
            return nil
    }

    var image: UIImage? = nil
    do {
        //3. Get valid data
        let data = try Data(contentsOf: url, options: [])

        //4. Make image
        image = UIImage(data: data)
    }
    catch {
        print(error.localizedDescription)
    }

    return image
}

//1. Get valid string
let string = "https://images.freeimages.com/images/large-previews/f2c/effi-1-1366221.jpg"

if let image = getImage(from: string) {
    //5. Apply image
    cell.imageView.image = image
}
