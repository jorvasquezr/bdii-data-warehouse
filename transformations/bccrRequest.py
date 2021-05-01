import requests
import xml.etree.ElementTree as ET
from datetime import date
import sys
import pyodbc

conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=case.local;'
                      'Database=DW;'
                      'UID=clase;'
                      'PWD=clase;'
                      'Trusted_Connection=no;')
conn.autocommit = False

def actualizarValores(fechaIni,fechaFinal):
    
    cursor = conn.cursor()
    data = obtenerValoresDeCambioRangoFechas(fechaIni,fechaFinal)
    for key, value in data.items():
        sqpQuery= 'UPDATE [dbo].[DIM_DATE] SET VentaDolar='+value[1]+',CompraDolar='+value[0]+' WHERE Date =\'' +key+'\';'
        cursor.execute(sqpQuery)
    conn.commit()

    
def getToday():
    today = date.today()
    return  today.strftime('%d/%m/%Y')
        


#Indicador 317: Compra
#Indicador 318: Venta

#Retorna un diccionario con fecha:[valorCompra, valorVenta]
def obtenerValoresDeCambioRangoFechas(fechaIni,fechaFinal):
    resultado = {}
    compra = 317
    venta = 318
    tree = request(compra,fechaIni,fechaFinal)
    for child in tree:
        resultado[child[1].text.split('T')[0] ] = [(child[2].text)]
        
    tree = request(venta,fechaIni,fechaFinal)
    for child in tree:
        resultado[child[1].text.split('T')[0]] = resultado[child[1].text.split('T')[0]] + [(child[2].text)]
        
    return resultado

def request(valor,fechaIni,fechaFinal):
    r = requests.get('https://gee.bccr.fi.cr/Indicadores/Suscripciones/WS/wsindicadoreseconomicos.asmx/ObtenerIndicadoresEconomicosXML?Indicador='+str(valor)+'&FechaInicio='+fechaIni+'&FechaFinal='+fechaFinal+'+&Nombre=Jorge&SubNiveles=N&CorreoElectronico=arturovasq.1234@gmail.com&Token=EO314MR29S')
    tree = ET.fromstring(r.text)
    return ET.fromstring(tree.text)


actualizarValores('01/01/2001',getToday())


