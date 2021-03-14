#!/usr/bin/env python
# coding: utf-8

# In[1]:


import getpass
import pandas as pd
import mysql.connector


# In[ ]:


data = pd.read_csv('https://s3-sa-east-1.amazonaws.com/ckan.saude.gov.br/SRAG/2021/INFLUD21-08-03-2021.csv', sep=';', index_col=False)


# In[ ]:


pword=getpass.getpass()


# In[ ]:


cnx = mysql.connector.connect(user='root', password=pword,
                              host='127.0.0.1',
                              database='srag')
cursor = cnx.cursor()


# In[ ]:


query = ("SELECT * from srag.tab_total")


# In[ ]:


df_opr= pd.read_sql(query, cnx)


# In[ ]:


df_opr


# In[ ]:


for i in data.columns:
    print(i)


# In[ ]:


#CARGA TABELA OCUPACAÇÃO
ocupa = data[['ID_PAIS', 'CO_PAIS']]
ocupa2 = ocupa.reset_index(drop=True)
df_ocupa = ocupa2.drop_duplicates()
df_ocupa=df_ocupa.reset_index(drop=True)
for row in df_ocupa.itertuples():
    sql = "INSERT INTO pais (codPais, descricao) VALUES (%s, %s)"
    val = (int(row.CO_PAIS), str(row.ID_PAIS))
    cursor.execute(sql, val)
cnx.commit()
df_opr= pd.read_sql("SELECT * from pais", cnx)
df_opr


# In[ ]:


#CARGA TABELA PESSOA
pessoa = data[['CS_SEXO', 'CS_GESTANT','CS_RACA', 'CS_ESCOL_N', 'PAC_COCBO', 'CO_MUN_RES']]
df_pessoa = pessoa.astype(object).where(pd.notnull(pessoa), None)

for row in df_pessoa.itertuples():
    print(type(row.Index))
    sql = "INSERT INTO Pessoa (idCpf, sexo, gestante, raca, escolaridade, ocupacao, municipio_residencia) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    val = ((row.Index), (row.CS_SEXO), (row.CS_GESTANT), (row.CS_RACA), (row.CS_ESCOL_N), (row.PAC_COCBO), (row.CO_MUN_RES))
    cursor.execute(sql, val)
cnx.commit()


# In[ ]:


# pessoa.head()
df_pes= pd.read_sql("SELECT * from Pessoa", cnx)
df_pes.head()


# In[ ]:




