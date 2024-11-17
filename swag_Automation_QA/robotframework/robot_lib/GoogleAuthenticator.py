import pyotp
from dataInfo import data

class GoogleAuthenticator:

    def getGoogleVerifyCode(self):
        secret_key = data.secret_key()

        # 創建一個 TOTP 對象
        totp = pyotp.TOTP(secret_key)

        # 獲取當前時間的一次性密碼
        current_otp = totp.now()
        return current_otp
