# clean axa data request
import pandas as pd
import pprint
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', -1)
path = r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\axaren1.xlsx'

def clean(df):
    df = pd.read_excel(path)    
    df['Smoke_Locks_Watch'] = df.apply(lambda x: 'Y' if x['Smoke_Alarm'] == 'Y' or x['Locks'] == 'Y' or x['Neighbourhood_Watch'] == 'Y' else 'N', axis=1)
    df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOn'], keep='first')
    df['PolicyAddOn'] = df['PolicyAddOn'].astype(str)
    df['PolicyAddOns'] = df.groupby('Customerid')['PolicyAddOn'].transform(lambda x: ','.join(x))
    df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOns'], keep='first') 

    df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOns'], keep='first') 
    
    df['Package'] = df['PolicyAddOns'].apply(lambda x: 'CO' if 'Contents Accidental Damage' in x and 'Buildings Accidental Damage' not in x else 'BO' if 'Contents Accidental Damage' not in x and 'Buildings Accidental Damage'  in x else 'B&C' if 'Contents Accidental Damage' in x and 'Buildings Accidental Damage'  in x else ' ')

    df['count'] = df.groupby('Customerid')['Customerid'].transform('count')
    colsdrop = ['Customerid','First_Name', 'Last_Name', 'Last_Name', 'Is_Sale', 'EndDate', 'ProductStatus', 'ProductNumber', 'RenewalProductCode',  'PolicyAddOn','PolicyAddOns','count', 'Smoke_Alarm',	'Locks',	'Neighbourhood_Watch']
    df = df.drop(colsdrop, axis=1)

    

    return df


print(clean(path).head(10).to_markdown())
# send file to direcotory
df= clean(path)
df.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\axarenoutput.xlsx', index=False)