struct FileHelper {
    func saveImageToDocuments(image: UIImage) -> String? {
        guard let documentsDirectory =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        let fileName = "image001.png"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)        
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                return nil
            }
        }
        
        guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
        do {
            try data.write(to: fileURL)
        } catch {
            return nil
        }        
        return fileName
    }
}
