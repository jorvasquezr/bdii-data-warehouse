import csv


def replace(string,cant):
    x = string.split(".",cant-1)
    result = ""
    for i in range(len(x)-1):
        result += x[i] + ","
    return result + x[len(x)-1]
        
    
r = csv.reader(open("CSV 301-400.csv"), delimiter = ";")
        
with open('CSV 301-400-Fixed.csv', mode='w', newline='') as file:
    writer = csv.writer(file, delimiter=';', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for j in r:
        if (j[len(j)-2]).count('.') >= 2:
            j[len(j)-2] = replace(j[len(j)-2],j[len(j)-2].count('.'))
            writer.writerow(j)
        else:
            writer.writerow(j)

