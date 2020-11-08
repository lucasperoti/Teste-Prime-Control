import logging
from datetime import date

def logger (levelname, message):
    logger = logging.getLogger('Teste Clash Royale')
    logger.setLevel(logger.info)

    file_handler = logging.FileHandler('log ' + date.today(), mode='a')
    console_handler = logging.StreamHandler()
    formatter = logging.Formatter('%(asctime)s %(levelname)s: %(message)s')
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)
    console_handler.setFormatter(formatter)
    file_handler.setFormatter(formatter)

    if str(levelname).upper() == "INFO" :
        file_handler.setLevel(logging.info)
        console_handler.setLevel(logging.INFO)
        logging.info(message)
    elif str(levelname).upper() == "DEBUG" :
        file_handler.setLevel(logging.DEBUG)
        console_handler.setLevel(logging.DEBUG)
        logging.debug(message)
    elif str(levelname).upper() == "ERROR" :
        file_handler.setLevel(logging.ERROR)
        console_handler.setLevel(logging.ERROR)
        logging.error(message)

if __name__ == "__main__" :
    logger("info", "teste")        