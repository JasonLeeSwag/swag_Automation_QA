from webdriver_manager.chrome import ChromeDriverManager # type: ignore

def get_chromedriver_path():
    path = ChromeDriverManager().install()
    return path