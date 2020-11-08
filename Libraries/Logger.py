import logging
from datetime import date

#Metado para executar os logs do processo
#levelname recebe qual tipo de log deve ser feito 
#message recebe a mensagem que sera escrita no log
def logger (levelname, message):

    logger = logging.getLogger('Teste Clash Royale')
    logger.setLevel(logging.INFO)

    file_handler = logging.FileHandler('logs/log ' + str(date.today()), mode='a')
    console_handler = logging.StreamHandler()

    formatter = logging.Formatter('%(asctime)s %(levelname)s: %(message)s')
    
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    console_handler.setFormatter(formatter)
    file_handler.setFormatter(formatter)
    
    #Seleciona qual tipo de log sera utilizado

    if str(levelname).upper() == "INFO" :
        file_handler.setLevel(logging.INFO)
        console_handler.setLevel(logging.INFO)
        logger.info(message)

    if str(levelname).upper() == "DEBUG" :
        file_handler.setLevel(logging.DEBUG)
        console_handler.setLevel(logging.DEBUG)
        logger.debug(message)

    if str(levelname).upper() == "ERROR" :
        file_handler.setLevel(logging.ERROR)
        console_handler.setLevel(logging.ERROR)
        logger.error(message)

