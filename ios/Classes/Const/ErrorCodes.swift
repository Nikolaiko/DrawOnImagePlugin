let errorCovertingImageCode: String = "0"
let wrongEnvelopParameterTypeCode: String = "1"
let errorCovertingImageToDataCode: String = "2"
let errorSavingImageCode: String = "3"

let errorMessages: [String : String] = [
    errorCovertingImageCode : "Error converting image from data",
    wrongEnvelopParameterTypeCode : "Wrong type of parameter in encodeSuccessEnvelope",
    errorCovertingImageToDataCode : "Error converting image to data during envelope",
    errorSavingImageCode : "Error saving image to phone disk"
]

let errorConvertingImage = FlutterError(code: errorCovertingImageCode,
                                        message: errorMessages[errorCovertingImageCode],
                                        details: nil)

let wrongEnvelopParameterType = FlutterError(code: wrongEnvelopParameterTypeCode,
                                        message: errorMessages[wrongEnvelopParameterTypeCode],
                                        details: nil)

let errorConvertingImageToData = FlutterError(code: errorCovertingImageToDataCode,
                                        message: errorMessages[errorCovertingImageToDataCode],
                                        details: nil)

let errorSavingImage = FlutterError(code: errorSavingImageCode,
                                        message: errorMessages[errorSavingImageCode],
                                        details: nil)

