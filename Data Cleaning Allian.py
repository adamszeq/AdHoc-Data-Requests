# Clean Allian Data
import pandas as pd
import pprint
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)
pd.set_option('display.width', None)
pd.set_option('display.max_colwidth', -1)
# read excel file


def removeDuplicates(path):
    df = pd.read_excel(path)
    df = df.dropna(thresh=11)
    df = df.dropna(subset=['Eircode'])



    # df = df[(df.Building_Sum_Insured != 0) & (df.Contents_Sum_Insured != 0)]
    # df = df[(df['Unspecified_Risks_Sum_Insured'].notna()) | (df['Specified_Items_Photographic'].notna()) | (df['Specified_Items_Glasses_Contacts'].notna()) | (df['Occupancy_Type'] != 'Owner Occupied')]


 

    # df = df[(df['Occupancy_Type'] != 'Owner Occupied') | (df['Specified_Items_Cash'].notna()) | (df['Specified_Items_Other'].notna()) | (df['Specified_Items_Bicycles'].notna()) | (df['Specified_Items_Hearing_Aids'].notna()) | (df['Specified_Items_Mobile_Phones'].notna()) | (df['Specified_Items_Laptops'].notna()) | (df['Specified_Items_Photographic'].notna()) | (df['Specified_Items_Glasses_Contacts'].notna()) | (df['Specified_Items_Jewellery'].notna())]
    # # df = df[df['Specified_Items_Cash'].notna()]
    # df = df[df['Specified_Items_Other'].notna()]
    # df = df[df['Specified_Items_Bicycles'].notna()]
    # df = df[df['Specified_Items_Hearing_Aids'].notna()]
    # df = df[df['Specified_Items_Mobile_Phones'].notna()]
    # df = df[df['Specified_Items_Laptops'].notna()]
    # df = df[df['Specified_Items_Photographic'].notna()]


    df = df[df['Year_Built'].notna()]
    # df = df[df['Employment_Status'].notna()]
    # df = df[df['YearsClaimFree'].notna()]
    df = df[df['Date_of_Birth'].notna()]

    df = df.drop_duplicates(subset=['ProductCode'], keep='first')



    df['Policy_Excess'] = df['Voluntary_Excess']+ df['Standard_Excess'] + df['Non_Standard_Excess']
    # df['Policy_Excess'] = df['Policy_Excess'].astype(str)
    # df['Policy_Excess'] = df['Policy_Excess'].str.lstrip('0')
    # df['Policy_Excess'] = df['Policy_Excess'].str.rstrip('0')

    df['Risk_Address'] = df['Unit_Number'].fillna('') + ',' + df['Building_Number'].fillna('') + ',' + df['Street_Name'].fillna('') + ',' + df['Town'].fillna('') + ',' + df['County'].fillna('')
    df['Risk_Address'] = df['Risk_Address'].str.lstrip(',')
    df['Risk_Address'] = df['Risk_Address'].str.rstrip(',') 

    df['Proposer'] = df['Proposer'].apply(lambda x: None if x == 'Unspecified' else x)

    df['PolicyAddOn'] = df['PolicyAddOn'].astype(str)
    df['PolicyAddOns'] = df.groupby('ProductCode')['PolicyAddOn'].transform(lambda x: ','.join(x))


    df['Contents_AD'] = df['PolicyAddOns'].apply(
        lambda x: 'Yes' if 'Buildings Accidental Damage'  in x or 'Contents Accidental Damage' in x
        else 'No' if 'Buildings Accidental Damage' not in x and 'Contents Accidental Damage' not  in x
    else ' '
    )
    
    df['Buildings_AD'] = df['PolicyAddOns'].apply(
        lambda x: 'Yes' if 'Buildings Accidental Damage'  in x or 'Contents Accidental Damage' in x
        else 'No' if 'Buildings Accidental Damage' not in x and 'Contents Accidental Damage' not  in x
        else ' '
    )

    df['count'] = df.groupby('ProductCode')['ProductCode'].transform('count')
    
    colsdrop = ['Voluntary_Excess','Non_Standard_Excess','Standard_Excess','ProductCode','First_Name', 'Last_Name', 'Last_Name', 'Is_Sale', 'EndDate', 'ProductStatus',  'PolicyAddOn','PolicyAddOns','count',
    'Unit_Number', 'Building_Number', 'Street_Name', 'Town', 'County'
    
    ]
    dffin = df.drop(colsdrop, axis=1)

    dffin = dffin.drop_duplicates(subset=['Eircode'], keep='last') 
 
    return dffin, df
colList = ['Number', 'CoverDate',	'Building_Sum_Insured',	'Buildings_AD',	'Contents_Sum_Insured',	'Contents_AD',	'Policy_Excess','YearsClaimFree',
    'ClaimType1',	'ClaimDate1',	'ClaimAmount1',	'ClaimSettled1',	'ClaimRelatesToProperty1',
    'ClaimType2',	'ClaimDate2',	'ClaimAmount2',	'ClaimSettled2',	'ClaimRelatesToProperty2',
    'Neighbourhood_Watch',	'Smoke_Detectors',	'Alarm',	'Locks',	'Risk_Address',	'Eircode',	'County',
    'Customer_Date_Of_Birth',	'Occupation',	'Employment_Status',	'Dwelling_Type',	'Year_Built',	'RoofStandard',	'NonStandardRoof (%)',	'Occupancy_Type','Proposer',
    'Number_Paying_Guests',	'No._of_Bedrooms',	'No._of_Bathrooms',	'Heating Type',	'Unspecified_Risks_Sum_Insured',	'Specified_Items_Cash',	
    'Specified_Items_Other',	'Specified_Items_Bicycles',	'Specified_Items_Hearing Aids',	'Specified_Items_Mobile Phones',	'Specified_Items_Laptops',	
    'Specified_Items_Photographic',	'Specified_Items_Glasses Contacts',	'Specified_Items_Jewellery']    

# dfrenPath = pd.read_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\allianzren1.xlsx')
# dfnbPath = pd.read_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\allianznb1.xlsx')

dfrenPath = r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\allianzren1.xlsx'
dfnbPath = r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\allianznb1.xlsx'

dfren, dfanalren = removeDuplicates(dfrenPath)
dfnb, dfanalnb = (removeDuplicates(dfnbPath))

dffull = dfren.append(dfnb, ignore_index=True)
dffull = dffull.drop_duplicates(subset=['Eircode'], keep='last') 
dffull.insert(0, 'Number', range(1, 1 + len(dffull)))
dffull.columns = colList
dffull.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\Allianz _AA_Household Rater.xlsx', index = False)

dfanalysis = dfanalren.append(dfanalnb, ignore_index=True)
dfanalysis.to_excel(r'C:\Users\adamszeq\Desktop\Clones\AdHoc-Data-Requests\Data\Allianz_AA_Household Rater_Analysis.xlsx', index = False)
