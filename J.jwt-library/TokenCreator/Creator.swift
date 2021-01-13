//
//  Creator.swift
//  TokenCreator
//
//  Created by JinYoung Lee on 2021/01/11.
//w

import Foundation
import JWTKit

class Creator {
    private let privateKey = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDXzVpdT4maY5eT\nBU1Xd5ZVkFoSoMgMNtWGpkMey/kp2wRW7GLngeD+JZ6OIAxlSE5SIN4MNcJX7lx0\nbKXutdxnpA241RE2rF0dslmzDLu9A7m1Un7hZrVKaiN4RiWGm3b8u3J37SDbO+dU\ns6xGcdDXGZmNTrQVDdQ2raNRT9mEVHgtuUBQfkgoofWqYO0IbRLoZpUuwPv5ur8J\nPaPBtUOlVAq7QCj2t4iWXSrCHwVYukHVafNEF/oo8C8eeL2rOj41uvhYmg0fGrw7\nicRLYwdn+TSHInKiujo3J9/nZXsJmoCFN8Q7tP/m6wfWVxt7y/1Ig0UC8Ptg5nvA\n0FxBqRt7AgMBAAECggEAHT0aCr19j9kBju5vebPevw4VXiPBpwIA8ULyoigRxM2D\na4GQrvxGbzjKoEgQVeKzleYVH8Ni5wYJKc8UtmCWkcZFA69+qxE0dpMVGzDU+PmZ\nvksEnOaNFp2F28RpTjEfMIP3MO+EfZ/CqpPDejHukU5LIz2wIZAjmhrxn1E5z/dg\nM8JU7hBjQuGqBBCVQavz8/J266H5j7mdIp3Kc+4IbqU498WjQQN2LvxDgDpKIGbu\niEVxLI5IFNymHUdkL/RbIHOdeVcUIBYAbXcPH3UBguCAphUpKnNl/BgXq9BIctE9\nuQWqv3Eni9uRUFnmWjWMsO8KsNF+RAMYn3/2lAx6yQKBgQDu3BXxpk453HwYEp1r\nzD5BjE05K6GfHn5e9/h1NyfC605uCkDdFtPU5i0lpdPxfU0qGWo+X4yHuHMA/2qx\nCLFYaOO+z41lrswiw/5ruEGY/K1GG/0MkzXrUbEpqTUNDl76vqUOaXGFoU6l5RRx\nU/gNKmQuKrplOyXnue1Tqc3ukwKBgQDnSbGz4InTEmrF+V3IHzAVL7ApMhrQ+szV\nkuEyH87zsoWD3lgxv/QZyvVK8CjunfjsG6i2WUfOjG73qaSH52jSSZj3sBlIZPVl\nzcMdsCUM6vx8/0DsshNS0Ue5mrjKQ8dkcKlZSW/kKnMFNixm1VUWO2Rdf2VNyGrr\nR40SxR5IeQKBgQC8e7lpNaV27TCTQmUsgkACM3dgjLh9um9X+2749+wNWOdL2BV1\nISVJU9T+Z0vGvOyeMu3uiDF5i6hcejCzwDtJm4NTt65JNdTp/iUO1ZgV5BXLRBy7\nxpJ+vbkCOf6d7eAvFy9iHvywySgpqoomH2+W3AOvlpH9fd4cbFAFe/H/twKBgAL9\nOdW4Ti+zKjwax/KBLK7pad5ublhLFYChIFX0gUk3AnC82+jwsSfwLpFkXzMOSZxL\nkzegGcR6niiHQcAb5ofpOZfh58G+xEkniqEEmMX893xqFB27A3Lrj4C/linPDHGo\n3xdvUonhXpEvrQ07LplV9SscLWP+9hrKVvFqKMUJAoGAFAmfn5N8a53sCLZzx1zx\nsmD9wfT/3eB+de+VHeHLTTttbKgefrnCdFMloIcvsVsPY8gU7ye4kANYqkPGVmKr\nxGh1At1HXvnIK7V6W1l9CwYRR7lFJ9rCCa5IMo11X8wT8HGgZ30V0YTLdBI3yo0Y\nymeZfwuq/EOKvsuw7gKnN9I=\n-----END PRIVATE KEY-----\n"
    
    public func Create() -> String {
        let key = try! RSAKey.private(pem: privateKey)
        
        let jwtSigner = JWTSigner.rs256(key: key)
        
        let payload = TokenPayload (
            subject: .init(value: "jinyoung-bbb95@appspot.gserviceaccount.com"),
            expiration: .init(value: Date.init().addingTimeInterval(3600)),
            audience: .init(value: "https://arcorecloudanchor.googoleapis.com/"),
            issuedAtClaim: .init(value: Date.init()),
            issuer: "jinyoung-bbb95@appspot.gserviceaccount.com"
        )
                            
        let jwt = try? jwtSigner.sign(payload, kid: "01518acd9aea779943c388c47ae6ad8261bbf57c")
        print(jwt);
        return jwt
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
