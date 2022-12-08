# clean axa data request
import pandas as pd
import pprint
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', -1)

def clean(path):
    df = pd.read_excel(path)    
    df['Smoke_Locks_Watch'] = df.apply(lambda x: 'Y' if x['Smoke_Alarm'] == 'Y' or x['Locks'] == 'Y' or x['Neighbourhood_Watch'] == 'Y' else 'N', axis=1)
    # df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOn'], keep='first')
    df['PolicyAddOn'] = df['PolicyAddOn'].astype(str)
    df['PolicyAddOns'] = df.groupby('Customerid')['PolicyAddOn'].transform(lambda x: ','.join(x))
    df = df.drop_duplicates(subset=['Customerid', 'PolicyAddOns','Eircode'], keep='first') 

    
    
    df['Package'] = df['PolicyAddOns'].apply(lambda x: 'CO' if 'Contents Accidental Damage' in x and 'Buildings Accidental Damage' not in x else 'BO' if 'Contents Accidental Damage' not in x and 'Buildings Accidental Damage'  in x else 'B&C' if 'Contents Accidental Damage' in x and 'Buildings Accidental Damage'  in x else ' ')

    df['count'] = df.groupby('Customerid')['Customerid'].transform('count')
    
    insurerPercent = (df['Insurer'].value_counts(normalize=True))
    dfana = df[(df['Bicycles'].notnull()) & (df['Caravans'] == 'Y') & (df['Eircode'].notnull())]
    dfana = df.groupby('Insurer').head(52)
    

    dfFin = dfana.groupby('Insurer').apply(lambda x: x.sample(frac=insurerPercent[x.name]))
    colsdrop = ['StartDate','ProductCode','Customerid','First_Name', 'Last_Name', 'Last_Name', 'Is_Sale', 'EndDate', 'ProductStatus',  'PolicyAddOn','PolicyAddOns','count', 'Smoke_Alarm',	'Locks',	'Neighbourhood_Watch']
    # colsdrop = ['Customerid','First_Name', 'Last_Name', 'Last_Name', 'Is_Sale', 'EndDate', 'ProductStatus',  'PolicyAddOn','PolicyAddOns','count', 'Smoke_Alarm',	'Locks',	'Neighbourhood_Watch']

    dfinished = dfFin.drop(colsdrop, axis=1)
    return dfinished, dfana

path = r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\axaren2.xlsx'
pathnb = r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\axanb2.xlsx'

    

dfren, dfanal = clean(path)
dfren['Source_of_Business'] = 'Renewal'
dfren.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\axarenoutput.xlsx', index=False)
dfnb, dfanaly = clean(pathnb)
dfnb['Source_of_Business'] = 'New Business (Broker Only)'
dfnb.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\axanboutput.xlsx', index=False)



dfanal.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\dfanal'+path.split('\\')[-1].split('.')[0]+'.xlsx', index=False)
dfanaly.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\dfanaly'+pathnb.split('\\')[-1].split('.')[0]+'.xlsx', index=False)


columnList =  ['Source of Business',	'Intermediary',	'Economy Product ',
'Package',	'Buildings Sum Insured',	'Contents Sum Insured',
'All Risks Specified SI',	'All Risks Unspecified SI',
'Standard of Construction',	'Year of Construction',
'NCD Years',	'Age Insured',	'Smoke/Locks/Watch',
'Alarm',	'Motor Insurance Policy',
'Current Insurer',	'Voluntary Excess',	'Claim Free 3+ years',	'Bicycles',
'Caravans',	'structure SI',	'contents SI',	'Firearms',
'Childminding 7 children or less',	'Childminding more than 8 children',
'Music Tutor',	'Art Tutor',	'Surgery',	'Students',	'Small Area Code']    

dfinal = pd.concat([dfren,dfnb])

dfinal.columns = columnList

dfinal.insert(0, 'Quote ID', range(100000000
, 100000000
 + len(dfinal)))

dfinal.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\Batch Input Template-AXA Broker Home.xlsx', index=False)

