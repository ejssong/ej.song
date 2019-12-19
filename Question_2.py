import json, csv, sys

dic_quantity = {}
dic_id = {}

num_purchase = 0
num_purchase_arr = []

quan_goods = 0
quan_goods_arr = []

data = []
file_name = 'SWE sample data - Q2 data.csv'
with open(file_name,'r') as data_file:
    reader = csv.reader(data_file)
    reader_data = list(reader)
    print (reader_data)
    for line in reader_data:
        for data in line: 
            data_split = data.split(", ")
            user_id = data_split[0][13:20]
            product_id = data_split[1][15:18]
            quantity = data_split[2]
            print(data_split)
            try:
                while product_id in (dic_quantity , dic_id):
                    dic_quantity[product_id] += quantity
                    if user_id not in (dic_quantity[product_id], dic_id[product_id]):
                        dic_id[product_id][user_id] = 1 
                    else:
                        dic_id[product_id][user_id] += 1 
                        dic_quantity[product_id] = quantity

            #........
            except ValueError as e:
                pass

