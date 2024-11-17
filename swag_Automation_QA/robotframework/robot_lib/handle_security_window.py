# scripts/handle_security_window.py
import pyautogui
import time

def handle_security_window():
    try:
        time.sleep(2)
        
        # 嘗試各種按鍵組合
        # 單鍵
        pyautogui.press('esc')
        time.sleep(1)
        
        # Alt + F4
        pyautogui.hotkey('alt', 'f4')
        time.sleep(1)
        
        # 點擊取消按鈕
        pyautogui.click(800, 500)  # 調整座標
        time.sleep(1)
        
        # Windows + D (最小化所有視窗)
        pyautogui.hotkey('win', 'd')
        time.sleep(1)
        
        print("已執行所有關閉視窗的操作")
        return True
            
    except Exception as e:
        print(f"發生錯誤: {str(e)}")
        return False

if __name__ == "__main__":
    handle_security_window()