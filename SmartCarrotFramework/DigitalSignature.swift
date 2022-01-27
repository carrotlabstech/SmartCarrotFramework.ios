//
//  DigitalSignature.swift
//  SmartCarrotFramework
//
//  Copyright © 2019 CarrotLabs gmbh. All rights reserved.
//

import Foundation

internal class DigitalSignature {
    internal let PUBLIC_KEY_BYTES : [UInt8] = [91, 72, 95, 84, 13, 54, 55, 46, 42, 37, 89, 15, 38, 35, 32, 61, 37, 79, 57, 42, 59, 75, 88, 5, 66, 95, 101, 47, 47, 40, 106, 58, 9, 32, 58, 43, 8, 5, 7, 13, 25, 16, 103, 77, 5, 89, 33, 42, 40, 26, 53, 32, 45, 59, 37, 46, 21, 87, 35, 43, 60, 97, 44, 49, 8, 41, 37, 32, 78, 54, 34, 82, 16, 88, 40, 22, 52, 32, 6, 17, 99, 39, 51, 44, 86, 41, 45, 25, 74, 78, 57, 126, 12, 41, 31, 68, 56, 23, 77, 3, 55, 66, 92, 16, 41, 78, 110, 65, 55, 0, 34, 44, 53, 12, 2, 14, 27, 21, 114, 66, 2, 61, 44, 57, 33, 24, 53, 57, 34, 23, 44, 23, 62, 36, 39, 41, 28, 94, 1, 93, 21, 47, 54, 22, 124, 54, 40, 85, 27, 17, 87, 91, 65, 49, 48, 15, 42, 14, 52, 59, 57, 5, 22, 22, 66, 14, 84, 19, 35, 13, 70, 13, 84, 39, 62, 29, 29, 70, 38, 90, 5, 88, 76, 5, 38, 24, 13, 45, 30, 65, 34, 45, 65, 29, 22, 62, 93, 24, 50, 28, 15, 111, 24, 57, 92, 77, 8, 42, 31, 5, 40, 21, 39, 26, 89, 56, 58, 82, 42, 85, 103, 121, 11, 55, 57, 59, 2, 47, 68, 85, 11, 47, 22, 17, 2, 48, 12, 15, 64, 42, 52, 54, 58, 69, 31, 57, 11, 56, 0, 20, 20, 113, 34, 48, 88, 52, 9, 84, 16, 32, 19, 9, 35, 81, 56, 13, 39, 48, 10, 26, 20, 71, 5, 36, 18, 44, 27, 47, 54, 27, 57, 27, 54, 63, 11, 35, 104, 54, 34, 112, 87, 49, 88, 44, 41, 46, 71, 28, 15, 49, 16, 46, 11, 95, 63, 23, 49, 52, 100, 19, 30, 88, 1, 9, 86, 19, 33, 40, 20, 63, 16, 57, 49, 95, 82, 60, 45, 66, 3, 19, 87, 22, 40, 19, 77, 65, 13, 84, 18, 61, 46, 25, 25, 80, 26, 43, 73, 16, 21, 51, 5, 97, 64, 57, 59, 14, 22, 69, 54, 92, 64, 24, 24, 2, 18, 102, 88, 37, 12, 9, 35, 12, 91, 26, 39, 8, 68, 91, 58, 92, 46, 55, 54, 60, 77, 66, 49, 42, 1, 88, 9, 108, 18, 36, 57, 2, 82, 62, 49, 35, 56, 33, 7, 99, 5, 31, 68, 39, 46, 45, 29, 50, 10, 9, 7, 14, 101, 8, 60, 86, 56, 52, 71, 4, 64, 63, 59, 17, 3, 108, 36, 80, 9, 3, 16, 28, 51, 6, 27, 21, 69, 99, 34, 19, 89, 6, 81, 7, 126, 57, 22, 2, 71, 30, 33, 57, 66, 51, 93, 58, 114, 6, 60, 57, 17, 83, 9, 112, 5, 57, 63, 49, 16, 32, 63, 11, 24, 20, 30, 91, 59, 120, 9, 77, 35, 8, 68, 25, 1, 25, 56, 58, 22, 9, 25, 93, 51, 82, 118, 63, 48, 33, 23, 92, 65, 7, 28, 27, 90, 13, 42, 93, 59, 22, 82, 8, 34, 103, 53, 3, 94, 85, 48, 25, 121, 53, 25, 55, 17, 29, 33, 95, 70, 52, 52, 77, 78, 36, 52, 19, 91, 33, 40, 45, 67, 52, 102, 27, 83, 91, 1, 44, 50, 12, 57, 103, 21, 70, 68, 20, 95, 57, 25, 11, 40, 46, 95, 40, 88, 65, 30, 47, 53, 21, 78, 4, 5, 29, 82, 0, 49, 21, 50, 18, 14, 24, 60, 31, 48, 64, 23, 43, 47, 110, 86, 74, 88, 33, 85, 48, 90, 75, 83, 82, 49, 28, 5, 31, 6, 78, 10, 115, 17, 29, 62, 59, 76, 42, 1, 12, 39, 43, 41, 5, 83, 64, 43, 26, 0, 52, 64, 106, 92, 24, 21, 73, 63, 32, 88, 57, 4, 87, 3, 6, 26, 38, 47, 23, 57, 63, 11, 70, 29, 32, 57, 35, 72, 54, 67, 81, 34, 95, 82, 33, 22, 62, 24, 41, 7, 80, 93, 58, 68, 5, 86, 5, 35, 1, 14, 20, 46, 35, 38, 4, 48, 86, 35, 46, 11, 0, 35, 8, 40, 24, 60, 105, 28, 55, 14, 37, 4, 6, 26, 12, 53, 8, 20, 69, 64, 4, 88, 87, 31, 41, 88, 11, 53, 15, 48, 61, 32, 54, 14, 82, 17, 58, 110, 34, 0, 7, 54, 17, 50, 45, 48, 9, 47, 37, 17, 35, 33, 101, 48, 30, 39, 7, 41, 48, 13, 43, 47, 38, 70, 29, 18, 89, 76, 1, 63, 23, 64, 34, 55, 79, 101, 55, 51, 30, 38, 42, 56, 14, 78, 92, 102, 89, 75, 66, 95, 66, 39, 40, 49, 8, 63, 39, 45, 46, 47, 34, 9, 56, 38, 56, 89, 68, 66, 67, 91]
    
//    internal let PUBLIC_KEY = """
//-----BEGIN PUBLIC KEY-----
//MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA3d1GxBEthCSAE5BTF9/U
//jFm+Zq8+X03rO/G2TaVEZbtkilR6pTORXGFXNcJxLKEOivn/zMPwUEK4ox857TBv
//zFRZnoI1o8gEb4b6AK5r4I8c9evEyyDq/TH3d6J/qQwv0kX09nEmjJsR26JU0L4N
//hVMRmA20yV6epYod9uGWV1yVyWbraYMB7Vo59SphW8WcQUxc43wMqGbpEzUoPPyL
//PWX8C7NOOnolPdGd1IrCMDgl1bb/LRIxKvVC00ZXjla8tNrd2n5fTAwo5hRidgZf
//9fHoz1P32wzdgN7WckEmriDi02U2XRDEm6CCb3p3aEUv4QCLZGrKjm+EHL4Aihsg
//fJ3JMgp2VXzz3W1ewvsAiys0KMa6d7fWJuc3wNW4V/CRrNPr8p/vXSEvOMdzrksT
//f/EimjbxLSygo8A+VKBHt78Xoz6yL2Iy0nWOZq17VxPFzVetN10QF4nPFz8JQr0U
//o54sCPjLOz4+v9X0xKO+A7/hJGlnpwt1kHJAsblZpB/uMZF987C3Qs803Eujqp+x
//1iLR/AxSTJEq5/YubR5B3jz+YAqJg6wouHYrKF+2oIZH1i00N+4NdQzOrx2H+g0d
//rmuZJIjF3QW+tQaKsE6oVbQbihcWnam/v75yHqxVnDTOXx7cCNVrnUzKrChCQwLS
//RxR/FBbIIGonq88hPy6GE6ECAwEAAQ==
//-----END PUBLIC KEY-----
//"""

    internal func validate(license: String, signature: String) throws -> Bool {
        let PUBLIC_KEY = Obfuscator(with: String().v.e.r.y.space.t.r.i.c.k.y.underscore.s.a.l.t.f.o.r.o.b.f.u.paren_left.o.r.o.b.f.a.paren_right.s.c.a.t.i.o.n).reveal(key: PUBLIC_KEY_BYTES)
                
        let publicKey = try PublicKey(pemEncoded: PUBLIC_KEY)
        
        let clear = try ClearMessage(string: license, using: .utf8)
        let signatureBase64Encoded = try Signature(base64Encoded: signature)
        
        let isSuccessful = try clear.verify(with: publicKey, signature: signatureBase64Encoded, digestType: .sha256)
        
        return isSuccessful
    }
}
