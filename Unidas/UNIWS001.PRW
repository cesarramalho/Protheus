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
	WSDATA	TRANSACTION	As string
	WSDATA   VETOR			as array of string
	
	WSMETHOD INCLUIR 		DESCRIPTION 'INCLUSAO'  
	WSMETHOD VALIDACAO	DESCRIPTION 'USO INTERNO'
	WSMETHOD VALIDAITEM	DESCRIPTION 'USO INTERNO'
	
	
ENDWSSERVICE

//=========================================================================

WSSTRUCT aCabecVenda      
	WSDATA C5_NUM			as String OPTIONAL 	//CODIGO
	WSDATA C5_IDPEDID		as	String OPTIONAL 	//CODIGO DA Loja
	WSDATA C5_CLIENTE		as String OPTIONAL 	//Cliente
	WSDATA C5_LOJA			as String OPTIONAL 	//Loja
	WSDATA C5_CONDPAG		as String OPTIONAL 	//Cond Pag  
	WSDATA C5_EMISSAO		as date	 OPTIONAL 	//Data da venda 
	WSDATA C5_FRETE		as float  OPTIONAL 	//Valor Frete
	WSDATA C5_TRANSP		as string OPTIONAL 	//Codigo da Transportadora
	WSDATA C5_TIPOPAG		as string OPTIONAL 	//Cartao,Boleto, Saldo	 
	WSDATA C5_ESTENTR		as string OPTIONAL 	//Estado Entrega da mercadoria 
	WSDATA C5_TOTAL		as float	 OPTIONAL 	//Total de valores da nota	
	WSDATA C5_DESCONT		as float	 OPTIONAL 	//desconto Total de valores da nota
	WSDATA C5_PESOL		as float	 OPTIONAL 	//Peso total do pedido
	WSDATA C5_TID			as string OPTIONAL 	//Transacao ID - Apenas para cielo
	WSDATA C5_MENNOTA		as string OPTIONAL 	//Mensagem para Nota fiscal

ENDWSSTRUCT

//------------------------------------------------------------------------

WSSTRUCT aItens    
	WSDATA C6_PRODUTO	as String OPTIONAL //Codigo Produto
	WSDATA C6_QTDVEN	as integer OPTIONAL //Quantidade
	WSDATA C6_PRCVEN	as float OPTIONAL //Pre็o de Venda real
	WSDATA C6_PRUNIT	as float OPTIONAL //Pre็o Unitario Tabela  
	WSDATA C6_VALOR	as float OPTIONAL //Valor Total 
	WSDATA C6_VALDESC	as float OPTIONAL //Valor Total 	
ENDWSSTRUCT

//------------------------------------------------------------------------

WSSTRUCT aRetorno
	WSDATA IDZZB 	  		as String OPTIONAL
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
ฑฑบPrograma  ณUNIWS001  บAutor  ณ Cesar Ramalho 	  บ Data ณ  16/07/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณWebService de integracao com o LOCAVIA							  บฑฑ
ฑฑบ          ณ  Acao: de acordo com a acao usada o sistema cadastra no bd บฑฑ
ฑฑบ          ณ  faz os logs e retorna de acordo com a tabela 		        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
WSMETHOD INCLUIR WSRECEIVE PEDIDO,TOKEN,TRANSACTION WSSEND RETORNO WSSERVICE UNIWS001

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


CONOUT('WebService Pedido de Venda')

If !U_AUTENTIC(::TOKEN)
	SetSoapFaut('Erro: Autentica็ใo',"Entre em contato com a TI")
	Return .F.
EndIf

//Log de Integracoes WebServices
cCod:= U_Z7F0001(,'002',cWS,'',,,::TRANSACTION)
If cCod == "F"
	SetSoapFaut('Erro: Transa็ใo',"Entre em contato com a TI")
	Return .F.
EndIf

SC5->(dbSetOrder(6))
If SC5->(dbSeek(Alltrim(::PEDIDO:CABEC:C5_IDPEDID)))
	::RETORNO := WSClassNew("aRetorno")
	::RETORNO:IDZZB 			:= cOk
	::RETORNO:OCORRENCIA		:= "Registro jแ foi finalizado anteriormente"
		
	U_Z7F0001(cCod, ,cWS, ::RETORNO:OCORRENCIA, '1')
	RETURN .T.
EndIf

If !::VALIDACAO()
   cError	:= ::VETOR[1]
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
	aadd(aCabec,{"C5_IDPEDID" 	,::PEDIDO:CABEC:C5_IDPEDID	,Nil})
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
	aadd(aCabec,{"C5_NATUREZ"	,  cNatureza					,Nil})
	aadd(aCabec,{"C5_PESOL"		,::PEDIDO:CABEC:C5_PESOL	,Nil})
	aadd(aCabec,{"C5_PBRUTO"	,::PEDIDO:CABEC:C5_PESOL	,Nil})
	aadd(aCabec,{"C5_ESPECI1"	,	"CX"							,Nil})
	aadd(aCabec,{"C5_VOLUME1"	,	1								,Nil})
	aadd(aCabec,{"C5_TPFRETE"	,  'C'							,Nil})
	aadd(aCabec,{"C5_TID"		,::PEDIDO:CABEC:C5_TID		,Nil})
	aadd(aCabec,{"C5_MENNOTA"	,::PEDIDO:CABEC:C5_MENNOTA	,Nil})
	
	For i:=1 to len(::PEDIDO:ITENS)
		nIndiceItem := i
		cTes:= u_GetTes(alltrim(::PEDIDO:CABEC:C5_ESTENTR),alltrim(::PEDIDO:ITENS[i]:C6_PRODUTO))
		If !::VALIDAITEM()
		   ::RETORNO:IDZZB 			:= ::VETOR[1]
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
		::RETORNO:IDZZB 			:= cError
		::RETORNO:OCORRENCIA := cSaida
		U_Z7F0001(cCod, ,cWS, cSaida, '2')
		SetSoapFaut('Erro: ',cSaida)
	Else                            
		ConfirmSX8()
		::RETORNO:IDZZB 			:= cOk
		::RETORNO:OCORRENCIA		:= U_GetOcorr(::RETORNO:IDZZB)
		
		U_Z7F0001(cCod, ,cWS, ::RETORNO:OCORRENCIA, '1')
		U_GeraHist("Faturamento","SC5",::PEDIDO:CABEC:C5_CLIENTE,::PEDIDO:CABEC:C5_NUM+" - Pedido de Venda",;
		"Pedido de venda "+::PEDIDO:CABEC:C5_NUM+ " incluido com sucesso",.F.)
	EndIf
Else
	::RETORNO:IDZZB 			:= cError
	::RETORNO:OCORRENCIA		:= U_GetOcorr(::RETORNO:IDZZB)+" "+cInfo
	U_Z7F0001(cCod, ,cWS,::RETORNO:OCORRENCIA, '2')
EndIf

End Transaction
CONOUT('Finaliza็ใo Pedido de venda!')

Return !lMsErroAuto

//_________### Validacoes ### ___________

WSMETHOD VALIDACAO WSRECEIVE PEDIDO WSSEND VETOR WSSERVICE UNIWS001

local lContinua:= .T.
::VETOR := {,}   

//Validacao de campos

If lContinua .and. len(alltrim(::PEDIDO:CABEC:C5_TRANSP))<1
	lContinua:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Transportadora em branco"
EndIf

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

If lContinua .and. len(alltrim(::PEDIDO:CABEC:C5_CONDPAG))<1
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Forma de Pagamento em branco"
EndIf

If lContinua .and. len(alltrim(::PEDIDO:CABEC:C5_IDPEDID))<1
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Numero do Pedido LOCAVIA em branco"
EndIf                            

If lContinua .and. ::PEDIDO:CABEC:C5_PESOL<0
	lContinua	:= .F.
	::VETOR[1]	:= '303'
	::VETOR[2]	:= " Peso"
EndIf                           

//Tipo de Pagamento
If lContinua .and. Empty((::PEDIDO:CABEC:C5_TIPOPAG))
	::VETOR[1]	:= '303'
	::VETOR[2]	:= "  -  A Natureza do pagamento deve ser Dinheiro,Cartao ou Saldo"
	lContinua	:= .F.
EndIf

//Estado de Entrega
If lContinua .and. Empty((::PEDIDO:CABEC:C5_ESTENTR))
	::VETOR[1]	:= '303'
	::VETOR[2]	:= "  -  Estado Entrega Vazio"
	lContinua	:= .F.
EndIf

//Total
If lContinua .and. Empty((str(::PEDIDO:CABEC:C5_TOTAL)))
	::VETOR[1]	:= '303'
	::VETOR[2]	:= "  -  Total zerado"
	lContinua	:= .F.
EndIf

//Validacoes  
SA1->(dbSetOrder(1))
SE4->(DbSetOrder(1))
SA4->(DbSetOrder(1))

//Transportadora
if	lContinua .and. (!SA4->(dbSeek(xFilial("SA4")+::PEDIDO:CABEC:C5_TRANSP)))
	If alltrim(::PEDIDO:CABEC:C5_TRANSP)== 'CD'
		::PEDIDO:CABEC:C5_TRANSP:= ''
		::PEDIDO:CABEC:C5_MENNOTA:= 'Retirada no Centro de Distribui็ใo'
	Else
		::VETOR[1]	:= '301'
		::VETOR[2]	:= " - Transportadora nใo existe"
		lContinua	:= .F.
	EndIf
EndIf

//Cliente
if	lContinua .and. !SA1->(dbSeek(xFilial('SA1')+alltrim(::PEDIDO:CABEC:C5_CLIENTE)+alltrim(::PEDIDO:CABEC:C5_LOJA)))
	::VETOR[1]	:= '301'
	::VETOR[2]	:= " - Cliente nใo existe"
	lContinua	:= .F.
EndIf

//Condicao de pagamento
If lContinua .and. !SE4->(DbSeek(xFilial("SE4")+::PEDIDO:CABEC:C5_CONDPAG))
	::VETOR[1]	:= '301'
	::VETOR[2]	:= " - Forma de pagamento nใo existe"
	lContinua	:= .F.
EndIf

//Mesmo estado (cadastro de cliente e pedido de venda)
if	lContinua .and. (alltrim(SA1->A1_EST) <> alltrim(::PEDIDO:CABEC:C5_ESTENTR))
	::VETOR[1]	:= '499'
	::VETOR[2]	:= " - Estado do cadastro de Cliente diferente do informado"
	lContinua	:= .F.
EndIf

//Pedido de venda
SC5->(dbSetOrder(6))
If lContinua .and. SC5->(dbSeek(Alltrim(::PEDIDO:CABEC:C5_IDPEDID)))
	::VETOR[1]	:= '300'
	::VETOR[2]	:= " - SC5 ->Venda jแ existe"
	lContinua	:= .F.
EndIf

//Nใo permitir desconto
If lContinua .and.  ::PEDIDO:CABEC:C5_DESCONT>0
	::VETOR[1]	:= '313'
	::VETOR[2]	:= "  -  Valor deve ser Zero"
	lContinua	:= .F.
EndIf

Return lContinua

//+++++++++++++++++++++++++++====================================================++++++++++++++++++

WSMETHOD VALIDAITEM WSRECEIVE PEDIDO WSSEND VETOR WSSERVICE UNIWS001
Local bAscan 		:= { |vet| (alltrim(vet[2])== alltrim(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO))}
Local nPos 
                    
local lContinua:= .T.
::VETOR := {,}   

If Len(::PEDIDO:ITENS) <1             
	::VETOR[1]	:= "311"
	::VETOR[2]	:= U_GetOcorr(::RETORNO:IDZZB)+" - Pedido sem Itens" 
	lContinua:= .F.
EndIf                

SB1->(DbSetOrder(1))
If !SB1->(DbSeek(xFilial("SB1")+Alltrim(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO)))
	::VETOR[1]	:= "301"
	::VETOR[2]	:= U_GetOcorr(::RETORNO:IDZZB)+" - Insira um produto vแlido."
	lContinua:= .F.
EndIf

//Certificando totalizadores
If lContinua .and. (::PEDIDO:ITENS[nIndiceItem]:C6_QTDVEN * ::PEDIDO:ITENS[nIndiceItem]:C6_PRCVEN <> ::PEDIDO:ITENS[nIndiceItem]:C6_VALOR	;
	.or. ::PEDIDO:ITENS[nIndiceItem]:C6_QTDVEN * ::PEDIDO:ITENS[nIndiceItem]:C6_PRUNIT <> ::PEDIDO:ITENS[nIndiceItem]:C6_VALOR + ::PEDIDO:ITENS[nIndiceItem]:C6_VALDESC)
	::VETOR[1]	:= "311"
	::VETOR[2]	:= U_GetOcorr(::RETORNO:IDZZB)+" - Totalizadores de Itens"  
	lContinua:= .F.
EndIf

//Verificacao de Estoque
dbSelectArea("SB2")                
If SB2->(dbSeek(xFilial("SB2")+ Padr(alltrim(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO),Len(SB2->B2_COD)," ")+ "01"))
	nEstAtual := SaldoSb2()
else
	nEstAtual := 0
EndIf

If lContinua .and. (::PEDIDO:ITENS[nIndiceItem]:C6_QTDVEN > nEstAtual)
  	::VETOR[1]	:= "310"
	::VETOR[2]	:= U_GetOcorr(::RETORNO:IDZZB)+" Estoque Atual->"+Str(nEstAtual)+" |  Produto->" +str(len(::PEDIDO:ITENS[nIndiceItem]:C6_PRODUTO))+" | "+;
	U_GetOcorr(::RETORNO:IDZZB)+" - Saldo de Estoque Insuficiente"
	lContinua:= .F.
EndIf

nPos := aScan( aItens , bAscan )
IF lContinua .and. ( nPos > 0 )     
	::VETOR[1]	:= "300"
	::VETOR[2]	:= U_GetOcorr(::RETORNO:IDZZB)+" - 2 itens com mesmo produto"
	lContinua:= .F.
EndIf 

Return lContinua  

//_____________________________________________

Static Function GetNatureza(cTipo)
Local cNat := ''

If cTipo == 'B'
	cNat:= 'DINHEIRO'
ElseIf cTipo == 'C'
	cNat:= 'CARTAO'
ElseIf cTipo == 'S'
	cNat:= 'SALDO'   
EndIf

Return cNat