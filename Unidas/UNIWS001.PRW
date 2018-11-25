#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'APWEBSRV.CH'
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUNIWS001  บAutor  ณ Cesar Ramalho 	  บ Data ณ  23/11/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService de integracao com o LOCAVIA  						  บฑฑ
ฑฑบ          ณ Inclusao de pedidos de venda                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
WSSERVICE UNIWS001 DESCRIPTION '<b>UNIDAS - PEDIDO DE VENDA</b>'
	WSDATA 	PEDIDO  		as aPedido
	WSDATA 	RETORNO 		as	aRetorno 	
	WSDATA	TOKEN			As string  
	WSDATA	IDLOCAVIA	As string  
	WSDATA   VETOR			as array of string
	
	WSMETHOD INCLUIR 		DESCRIPTION 'INCLUSAO DE UM PEDIDO'  
	WSMETHOD EXCLUIR 		DESCRIPTION 'EXCLUSAO DO PEDIDO DE VENDA, DOCUMENTO DE SAIDA, TITULOS A PAGAR'  
	WSMETHOD VALIDACAO	DESCRIPTION 'USO INTERNO'
	WSMETHOD VALIDAITEM	DESCRIPTION 'USO INTERNO'
ENDWSSERVICE

//=========================================================================
WSSTRUCT aCabecVenda      
	WSDATA C5_NUM			as String OPTIONAL 	//CODIGO
	WSDATA C5_IDLOCAV		as String OPTIONAL 	//Localvia FK
	WSDATA C5_CLIENTE		as String OPTIONAL 	//Cliente
	WSDATA C5_LOJA			as String OPTIONAL 	//Loja
	WSDATA C5_EMISSAO		as date	 OPTIONAL 	//Data da venda	
ENDWSSTRUCT
//------------------------------------------------------------------------
WSSTRUCT aItens    
	WSDATA C6_PRODUTO	as String OPTIONAL  //Codigo Produto
	WSDATA C6_QTDVEN	as integer OPTIONAL //Quantidade
	WSDATA C6_PRCVEN	as float OPTIONAL   //Pre็o de Venda real
// WSDATA C6_PRUNIT	as float OPTIONAL   //Pre็o Unitario Tabela  
// WSDATA C6_VALOR	as float OPTIONAL   //Valor Total
	WSDATA C6_LOCAL	as float OPTIONAL   // Armazem 	
	WSDATA C6_TES		as float OPTIONAL 
// WSDATA C6_CHASSI	as float OPTIONAL 
//	WSDATA C6_PLACA	as float OPTIONAL 
ENDWSSTRUCT
//------------------------------------------------------------------------
WSSTRUCT aRetorno
	WSDATA CODIGO 	  		as String OPTIONAL
	WSDATA OCORRENCIA		as String OPTIONAL 	
ENDWSSTRUCT
//------------------------------------------------------------------------
WSSTRUCT aPedido
	WSDATA 	CABEC   		as aCabecVenda
	WSDATA 	ITENS 		as array of aItens	
ENDWSSTRUCT
//------------------------------------------------------------------------

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUNIWS001  บAutor  ณ Cesar Ramalho 	  บ Data ณ  24/11/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService de integracao com o LOCAVIA | INCLUSAO  			  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
WSMETHOD INCLUIR WSRECEIVE PEDIDO,TOKEN WSSEND RETORNO WSSERVICE UNIWS001

local cCod			:= ''
local	aCabec 		:= {}
local	aLinha 		:= {}
local cInfo			:= ""
local i				:= 0
local nEstAtual	:= 0  

Local cWS			:= 'UNIWS001'
Local cOK			:= '200'
Local cError		:= '400'
Local lContinua	:= .T.  

Private nIndiceItem := 1
Private aItens 		:= {}
Private lMsErroAuto	:= .F.

::RETORNO := WSClassNew("aRetorno")  
::RETORNO:CODIGO 			:= cOK
::RETORNO:OCORRENCIA		:= "Mock Inclusao do pedido"

Return .t.
			
CONOUT('WebService Pedido de Venda')

If !AUTENTICWS(::TOKEN)
	SetSoapFaut('Erro: Autentica็ใo',"Entre em contato com a TI")
	Return .F.
EndIf

If !::VALIDACAO()
   cError	:= '400'
	cInfo		:= ::VETOR[2]
	lContinua:= .F.
EndIf		

::PEDIDO:CABEC:C5_NUM:= getSx8Num("SC5","C5_NUM")        
CONOUT("Codigo Pedido Protheus - "+::PEDIDO:CABEC:C5_NUM)

Begin Transaction

If lContinua
	::RETORNO := WSClassNew("aRetorno")
	ConOut("Inicio: "+Time())
	
	cNatureza := GetNatureza(::PEDIDO:CABEC:C5_TIPOPAG)
	
	aadd(aCabec,{"C5_NUM"   	,::PEDIDO:CABEC:C5_NUM		,Nil})
	aadd(aCabec,{"C5_IDLOCAV" 	,::PEDIDO:CABEC:C5_IDLOCAV	,Nil})
	aadd(aCabec,{"C5_CLIENTE"	,::PEDIDO:CABEC:C5_CLIENTE	,Nil})
	aadd(aCabec,{"C5_LOJACLI"	,'01'								,Nil})
	aadd(aCabec,{"C5_CLIENT"	,::PEDIDO:CABEC:C5_CLIENTE	,Nil})
	aadd(aCabec,{"C5_LOJAENT"	,::PEDIDO:CABEC:C5_LOJA		,Nil})
	aadd(aCabec,{"C5_FRETE"		,::PEDIDO:CABEC:C5_FRETE	,Nil})
	aadd(aCabec,{"C5_EMISSAO"	,::PEDIDO:CABEC:C5_EMISSAO	,Nil})
	aadd(aCabec,{"C5_CONDPAG"	,::PEDIDO:CABEC:C5_CONDPAG	,Nil})
	aadd(aCabec,{"C5_TRANSP"	,::PEDIDO:CABEC:C5_TRANSP	,Nil})
	aadd(aCabec,{"C5_TIPOPAG"	,::PEDIDO:CABEC:C5_TIPOPAG	,Nil})
	aadd(aCabec,{"C5_ESTENTR"	,::PEDIDO:CABEC:C5_ESTENTR	,Nil})
	aadd(aCabec,{"C5_DESCONT"	,::PEDIDO:CABEC:C5_DESCONT	,Nil})
	aadd(aCabec,{"C5_TOTAL"		,::PEDIDO:CABEC:C5_TOTAL	,Nil})
	//aadd(aCabec,{"C5_NATUREZ"	,  cNatureza					,Nil})
	//aadd(aCabec,{"C5_PESOL"		,::PEDIDO:CABEC:C5_PESOL	,Nil})
	//aadd(aCabec,{"C5_PBRUTO"	,::PEDIDO:CABEC:C5_PESOL	,Nil})
	//aadd(aCabec,{"C5_ESPECI1"	,	"CX"							,Nil})
	//aadd(aCabec,{"C5_VOLUME1"	,	1								,Nil})
	//aadd(aCabec,{"C5_TPFRETE"	,  'C'							,Nil})
	//aadd(aCabec,{"C5_TID"		,::PEDIDO:CABEC:C5_TID		,Nil})
	//aadd(aCabec,{"C5_MENNOTA"	,::PEDIDO:CABEC:C5_MENNOTA	,Nil})
	
	For i:=1 to len(::PEDIDO:ITENS)
		nIndiceItem := i
		cTes:= u_GetTes(alltrim(::PEDIDO:CABEC:C5_ESTENTR),alltrim(::PEDIDO:ITENS[i]:C6_PRODUTO))
		If !::VALIDAITEM()
		   ::RETORNO:CODIGO 			:= ::VETOR[1]
			::RETORNO:OCORRENCIA		:= ::VETOR[2]
			U_Z7F0001(cCod, ,cWS,::RETORNO:OCORRENCIA, '2')
			SetSoapFaut('Erro: ',::RETORNO:OCORRENCIA)
			Return .F.
		EndIf		
		
		aLinha := {}
		aadd(aLinha,{"C6_ITEM"			,StrZero(i,2)						,Nil})
		aadd(aLinha,{"C6_PRODUTO"		,::PEDIDO:ITENS[i]:C6_PRODUTO,Nil})
		aadd(aLinha,{"C6_QTDVEN"		,::PEDIDO:ITENS[i]:C6_QTDVEN	,Nil})
		aadd(aLinha,{"C6_QTDLIB"		,::PEDIDO:ITENS[i]:C6_QTDVEN	,Nil})
		aadd(aLinha,{"C6_PRUNIT"		,::PEDIDO:ITENS[i]:C6_PRUNIT	,Nil})
		aadd(aLinha,{"C6_PRCVEN"		,::PEDIDO:ITENS[i]:C6_PRCVEN	,Nil})
		aadd(aLinha,{"C6_VALDESC"		,::PEDIDO:ITENS[i]:C6_VALDESC	,Nil})
		aadd(aLinha,{"C6_VALOR"			,::PEDIDO:ITENS[i]:C6_VALOR	,Nil})
		aadd(aLinha,{"C6_TES"			,cTes									,Nil})
		aadd(aItens,aLinha)
		
	Next i

	MSExecAuto({|x,y,z|Mata410(x,y,z)},aCabec,aItens,3)

	If lMsErroAuto   
		RollbackSX8()      
		DisarmTransaction()
		cSaida :=  MostraErro('\','mostraerro.txt')
		::RETORNO:CODIGO 			:= cError
		::RETORNO:OCORRENCIA := cSaida
		U_Z7F0001(cCod, ,cWS, cSaida, '2')
		SetSoapFaut('Erro: ',cSaida)
	Else                            
		ConfirmSX8()
		::RETORNO:CODIGO 			:= cOk
		::RETORNO:OCORRENCIA		:= U_GetOcorr(::RETORNO:CODIGO)
		
		U_Z7F0001(cCod, ,cWS, ::RETORNO:OCORRENCIA, '1')
		U_GeraHist("Faturamento","SC5",::PEDIDO:CABEC:C5_CLIENTE,::PEDIDO:CABEC:C5_NUM+" - Pedido de Venda",;
		"Pedido de venda "+::PEDIDO:CABEC:C5_NUM+ " incluido com sucesso",.F.)
	EndIf
Else
	::RETORNO:CODIGO 			:= cError
	::RETORNO:OCORRENCIA		:= ::RETORNO:CODIGO+" "+cInfo
EndIf

End Transaction
CONOUT('Finaliza็ใo Pedido de venda!')

Return !lMsErroAuto        

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณUNIWS001  บAutor  ณ Cesar Ramalho 	  บ Data ณ  25/11/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService de integracao com o LOCAVIA | Exclusao  			  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
WSMETHOD EXCLUIR WSRECEIVE IDLOCAVIA,TOKEN WSSEND RETORNO WSSERVICE UNIWS001   
::RETORNO := WSClassNew("aRetorno")  
::RETORNO:CODIGO 			:= '400'
::RETORNO:OCORRENCIA		:= "Mock Erro na exclusao do pedido"
Return .T.

//_________### Validacoes ### ___________

WSMETHOD VALIDACAO WSRECEIVE PEDIDO WSSEND VETOR WSSERVICE UNIWS001

local lContinua:= .T.
::VETOR := {,}   

//Validacao de campos em branco
If lContinua .and. len(alltrim(::PEDIDO:CABEC:C5_CLIENTE))<1
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Codigo do cliente em branco"
EndIf

If lContinua .and. len(alltrim(::PEDIDO:CABEC:C5_LOJA))<1
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Loja do cliente em branco"
EndIf

If lContinua .and. len(alltrim(::PEDIDO:CABEC:C5_IDLOCAV))<1
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Numero do Pedido LOCAVIA em branco"
EndIf                                                    

//Total
If lContinua .and. Empty((str(::PEDIDO:CABEC:C5_TOTAL)))
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= "  -  Total do pedido em branco"
EndIf

//Validacoes de dados
SA1->(dbSetOrder(1))
//Cliente
if	lContinua .and. !SA1->(dbSeek(xFilial('SA1')+alltrim(::PEDIDO:CABEC:C5_CLIENTE)+alltrim(::PEDIDO:CABEC:C5_LOJA)))
	::VETOR[1]	:= '301'
	::VETOR[2]	:= " - Cliente nใo existe"
	lContinua	:= .F.
EndIf

//Pedido de venda
SC5->(dbSetOrder(6))
If lContinua .and. SC5->(dbSeek(Alltrim(::PEDIDO:CABEC:C5_IDLOCAV)))
	::VETOR[1]	:= '300'
	::VETOR[2]	:= " - SC5 ->Pedido jแ foi cadastrado anteriormente"
	lContinua	:= .F.
EndIf

Return lContinua

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

WSMETHOD VALIDAITEM WSRECEIVE PEDIDO WSSEND VETOR WSSERVICE UNIWS001
                    
local lContinua:= .T.
::VETOR := {,}   

If Len(::PEDIDO:ITENS) <1             
	::VETOR[1]	:= "400"
	::VETOR[2]	:= " - Pedido sem Itens" 
	lContinua:= .F.
EndIf                

SB1->(DbSetOrder(1))
If !SB1->(DbSeek(xFilial("SB1")+Alltrim(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO)))
	::VETOR[1]	:= "400"
	::VETOR[2]	:= " - Insira um produto vแlido."
	lContinua:= .F.
EndIf

//Certificando totalizadores
If lContinua .and. (::PEDIDO:ITENS[nIndiceItem]:C6_QTDVEN * ::PEDIDO:ITENS[nIndiceItem]:C6_PRCVEN <> ::PEDIDO:ITENS[nIndiceItem]:C6_VALOR	)
	::VETOR[1]	:= "400"
	::VETOR[2]	:= " - Erro no totalizador do Item"  
	lContinua:= .F.
EndIf

//Verificacao de Estoque
dbSelectArea("SB2")                
If SB2->(dbSeek(xFilial("SB2")+ Padr(alltrim(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO),Len(SB2->B2_COD)," ")+ alltrim(::PEDIDO:ITENS[nIndiceItem]:C6_LOCAL)))
	nEstAtual := SaldoSb2()
else
	nEstAtual := 0
EndIf

If lContinua .and. (::PEDIDO:ITENS[nIndiceItem]:C6_QTDVEN > nEstAtual)
  	::VETOR[1]	:= "400"
	::VETOR[2]	:= " Estoque Atual->"+Str(nEstAtual)+" |  Produto->" +str(len(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO))+" | "+;
	" - Saldo de Estoque Insuficiente"
	lContinua:= .F.
EndIf

Return lContinua  