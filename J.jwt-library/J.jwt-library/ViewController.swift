//
//  ViewController.swift
//  J.jwt-library
//
//  Created by JinYoung Lee on 2021/01/11.
//

import UIKit
import JWTKit

class ViewController: UIViewController {

    private let privateKey = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDOhHJJWCIDw7ZO\neQB+j5a4DxlEYKwotFcVol4icdhH51POkDMh3fM6D9ushgDF/hVnOHANPlSc6XtW\nSlR3cQyC3KHG0IT1EMY2//70L9ikMpsun9kV5OWLPrnWY9BK3WB7nPg5lua80clO\n6kwQPkcji428YAdFWK9EWaWfKlM5+2gu7AXJm+VHkzdPZnCIROt39JsImQj8HKEs\nK1SA24bQZO9zy2vwCdoFeAEI4cAFJjXqYnnwZg8L0/yRQXiXqZAApzisDfBA2yS+\nZ08kxexC6sZ9BkDeWMqy7TYGpx5VUDmyTA6Pgw3HQNefIplRByHS9uIg4cjlfnHd\nfoBYDvzVAgMBAAECggEAJkB8Fr+/VSksHG7nO4oHJcKOMI8jdEqrErPHcePaZr8f\nU9R71BsTUT7ctqD/hazhdAQNJTbVX1cT5FDSQmlrItYRFQ1Mg0P/IvLZ24r9OrSw\n77rl79s89UTCEUbdrvBATcUuaSRdSr4k5nwZaKzQanIP58N1tU+O7z8XoVqqncNx\nKpAxhfZwfMv1h6V3tI75kPsU0AT7lmnfkx2/lUvKi8PoGZsuZ9Oqr0mmVeoiZb54\nsL0ASFr5lw38MVMeg7cspUWL/R7TUOLOe0eguJpfQg78IFkoW2MYHZAmbQHo7duI\nM+A1cmR/Wsm1gIRPROai9Kud7nsCHTWR3cmVRT3XpQKBgQDxTKKU/R9xNXzC+OZk\nv2hbErDe9bYkn5iPBCT7sOQ75UZgQBI/A4RJyVHwvCxcSFe+q3wJBowjc3OSsUCg\nFoq/XxeZ1VNdvky/nzq51zwffLRoE2VOfDMmRzhGXqXSQNmDmeAfSXGA8QBu2h3U\nRwVWEbpEIWo39nG4WybOqdXGDwKBgQDbGVfCHWfXA/g/fz6JOMRPGtPh9/shs3o4\n+0Ra5jUApvM0AI4stn10VckyB7zJB+LkVb8BDLS9z22RY61AikeSjn4Roi3FyJcj\no3E/yCtNg4t1j7WkMd1cB3xq8IXy22h5lRIBD2grD+L6iElAFtosMEeXhYKlfbPl\nXemLcyaS2wKBgQC/fpwANSlAxLvwV2swRR7iN+EZ8FHOmsGNrjJTdDyMtBW3yOEy\nFO5lSFm4/P0Pd3H7JUhYOVP5xmPP5M9uvLT7ztGCCeQRHzb1U75dQcy7CFJ7zfi1\n4qcNF7Q3VGGwjDqS0AknizeCpsA7OOo3Tu2TMppp+0K6iuAQ+HXByNKYTQKBgEZh\nMauNPpn3EHt1KGVz8rtmZsGjouwEdzJupFp+sG/xMRZ3RzRdupbwJ50Gl0IMYnnu\ngViY+EYwp4WYe0LMKImPdDe93O43rTUpf2t5pU9U/itZaoO/8NdrIDBJ6v1ENZ84\nn3vvswqCI+tOdBk+Pf8L0zN9E6aNZog7TpYY+z8ZAoGBAMCnyhV5nPCztWGcup+T\nGysoxKeWH+qMsKuvOzRr2mDgYz9bW2GKT79gk2Q9YsTTSYDdn6UHVvCfYCgmZOPw\nNVwNEwXIbmf4SbKqk+wKLiTP7NV2luqNXfvlCyKnNqIGjZMdnvn9XQ7+aNz2U7U4\n50kvPpg1Q/GvzPlBXPp6Srqr\n-----END PRIVATE KEY-----\n"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let key = try! RSAKey.private(pem: privateKey)
        
        let jwtSigner = JWTSigner.rs256(key: key)
        
        print(Date.init().addingTimeInterval(3600).description)
        
        let payload = TokenPayload (
            subject: .init(value: "jinyoung-bbb95@appspot.gserviceaccount.com"),
            expiration: .init(value: Date.init().addingTimeInterval(3600)),
            audience: .init(value: "https://arcorecloudanchor.googoleapis.com/"),
            issuedAtClaim: .init(value: Date.init()),
            issuer: "jinyoung-bbb95@appspot.gserviceaccount.com"
        )
                            
        let jwt = try? jwtSigner.sign(payload, kid: "df4f94f5e7ba4f3918f56ae62ea1a98b318d5e90")
        print(jwt)
    }
}


struct TokenPayload: JWTPayload {
    
    enum CodingKeys: String, CodingKey {
        case subject = "sub"
        case expiration = "exp"
        case audience = "aud"
        case issuedAtClaim = "iat"
        case issuer = "iss"
    }
    
    var subject: SubjectClaim
    var expiration: ExpirationClaim
    var audience: AudienceClaim
    var issuedAtClaim: IssuedAtClaim
    var issuer: IssuerClaim
    
    func verify(using signer: JWTSigner) throws {
        try self.expiration.verifyNotExpired()
    }
}
