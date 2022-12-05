# read excel file
import pandas as pd
import pprint
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', -1)
# read excel file
dfren = pd.read_excel(r'C:\Users\adamszeq\Desktop\ren_v3.xlsx')
dfnb = pd.read_excel(r'C:\Users\adamszeq\Desktop\nb_v3.xlsx')

def removeDuplicates(df):
    df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOn'], keep='first')


    # get all policyaddons associated with a customerid as a new column for the dataframe

    # convet policyaddon column to string
    df['PolicyAddOn'] = df['PolicyAddOn'].astype(str)
    df['PolicyAddOns'] = df.groupby('Customerid')['PolicyAddOn'].transform(lambda x: ','.join(x))
    # df = df.groupby('Customerid')['PolicyAddOn'].apply(list).reset_index(name='PolicyAddOn')

    df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOns'], keep='first') 

    # create two new columns called Contents_AD and Buildings_AD where you mark Contents_AD as 'Y' if the policyaddons contains 'Contents Accidental Damage' and Buildings_AD as 'Y' if the policyaddon contains 'Buildings Accidental Damage'
    df['Contents_AD'] = df['PolicyAddOns'].str.contains('Contents Accidental Damage').astype(str)
    df['Buildings_AD'] = df['PolicyAddOns'].str.contains('Buildings Accidental Damage').astype(str)

    # of columns is True then set the value to 'Y' else 'N'
    df['Contents_AD'] = df['Contents_AD'].apply(lambda x: 'Y' if x == 'True' else 'N')
    df['Buildings_AD'] = df['Buildings_AD'].apply(lambda x: 'Y' if x == 'True' else 'N')

    # count duplicate rows  
    df['count'] = df.groupby('Customerid')['Customerid'].transform('count')
    

    # colsdrop = ['Customerid','First_Name', 'Last_Name', 'Last_Name', 'Is_Sale', 'EndDate', 'ProductStatus', 'ProductNumber', 'RenewalProductCode',  'PolicyAddOn','PolicyAddOns','count' ]

    # insert contentsAD near contentssuminsured and buildingsAD near buildingssuminsured columns
    # df.insert(8, 'Contents_AD ', df['Contents_AD'])
    # df.insert(10, 'Buildings_AD ', df['Buildings_AD'])

    # colsdrop = ['Customerid','First_Name', 'Last_Name', 'Last_Name', 'Is_Sale', 'EndDate', 'ProductStatus', 'ProductNumber', 'RenewalProductCode',  'PolicyAddOn','PolicyAddOns','count','Contents_AD','Buildings_AD' ]
    

    # drop columns in colsdrop list
    # df = df.drop(colsdrop, axis=1)

    return df

df = removeDuplicates(dfren)


dfnb = (removeDuplicates(dfnb))
# if Buildings_AD = 'Y' then change Contents_AD to 'Y' IN dfnb

# dfnb.loc[df['Buildings_AD'] == 'Y', 'Contents_AD'] = 'Y'

# send dfnb to excel
dfnb.to_excel(r'C:\Users\adamszeq\Desktop\dfnboutv3.xlsx', index=False)
df.to_excel(r'C:\Users\adamszeq\Desktop\dfrenoutv3.xlsx', index=False)




# print(movecol(df, cols_to_move=['Contents_AD '], ref_col='ContentsSumInsured', place='After').to_markdown())


# # print number of times a customerid appears as a new colu=mn
# df['count'] = df.groupby('Customerid')['Customerid'].transform('count')

# # print number of rows with count 1

# print(len(df[df['count'] == 1]))
# print(len(df[df['count'] != 1]))
# # print(len(df))

# # print(len(df[df['count'] == 5]))

