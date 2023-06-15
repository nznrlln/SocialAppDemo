//
//  AuthManager.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 01.04.2023.
//

import FirebaseAuth

class AuthManager {
    static let shared = AuthManager()

    private let auth = Auth.auth()

    private var verificationID: String?

    private init() {}

    // Send a verification code to the user's phone
    // Firebase sends a silent push notification to your app, or issues a reCAPTCHA challenge to the user. After your app receives the notification or the user completes the reCAPTCHA challenge, Firebase sends an SMS message containing an authentication code to the specified phone number and passes a verification ID to your completion function. You will need both the verification code and the verification ID to sign in the user.
    func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
            guard let verificationID = verificationID, error == nil else {
                completion(false)
                return
            }
            self?.verificationID = verificationID
            completion(true)
        }
    }

    // Sign in the user with the verification code
    func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {

        guard let verificationID = verificationID else {
            completion(false)
            return
        }

        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: smsCode)

        auth.signIn(with: credential) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }

    }
}
