import Security
import Foundation


public enum KeyChain {
    
    static let token: String = "academy_token"
    
    static func saveTokenToKeychain(token: String) {
        guard let data = token.data(using: .utf8) else {
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "academy_token",
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            return
        }
    }
    
    static func isTokenExistingInKeychain(token: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeyChain.token,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status == errSecSuccess {
            guard let existingItem = item as? [String: Any],
                  let existingData = existingItem[kSecValueData as String] as? Data,
                  let existingToken = String(data: existingData, encoding: .utf8) else {
                return false
            }
            
            return existingToken == token
        } else {
            return false
        }
    }
    
    static func deleteTokenFromKeychain(token: String) {
        guard let data = token.data(using: .utf8) else {
            return
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: KeyChain.token,
            kSecValueData as String: data
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            return
        }
    }
}

