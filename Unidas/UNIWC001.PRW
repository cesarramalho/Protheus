#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://localhost/UNIWS001.apw?WSDL
Gerado em        11/25/18 01:39:11
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _TIRRMQJ ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSUNIWS001
------------------------------------------------------------------------------- */

WSCLIENT WSUNIWS001

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD EXCLUIR
	WSMETHOD INCLUIR
	WSMETHOD VALIDACAO
	WSMETHOD VALIDAITEM

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cIDLOCAVIA                AS string
	WSDATA   cTOKEN                    AS string
	WSDATA   oWSEXCLUIRRESULT          AS UNIWS001_ARETORNO
	WSDATA   oWSPEDIDO                 AS UNIWS001_APEDIDO
	WSDATA   oWSINCLUIRRESULT          AS UNIWS001_ARETORNO
	WSDATA   oWSVALIDACAORESULT        AS UNIWS001_ARRAYOFSTRING
	WSDATA   oWSVALIDAITEMRESULT       AS UNIWS001_ARRAYOFSTRING

	// Estruturas mantidas por compatibilidade - NÃO USAR
	WSDATA   oWSAPEDIDO                AS UNIWS001_APEDIDO

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSUNIWS001
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.131227A-20180727 NG] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSUNIWS001
	::oWSEXCLUIRRESULT   := UNIWS001_ARETORNO():New()
	::oWSPEDIDO          := UNIWS001_APEDIDO():New()
	::oWSINCLUIRRESULT   := UNIWS001_ARETORNO():New()
	::oWSVALIDACAORESULT := UNIWS001_ARRAYOFSTRING():New()
	::oWSVALIDAITEMRESULT := UNIWS001_ARRAYOFSTRING():New()

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSAPEDIDO         := ::oWSPEDIDO
Return

WSMETHOD RESET WSCLIENT WSUNIWS001
	::cIDLOCAVIA         := NIL 
	::cTOKEN             := NIL 
	::oWSEXCLUIRRESULT   := NIL 
	::oWSPEDIDO          := NIL 
	::oWSINCLUIRRESULT   := NIL 
	::oWSVALIDACAORESULT := NIL 
	::oWSVALIDAITEMRESULT := NIL 

	// Estruturas mantidas por compatibilidade - NÃO USAR
	::oWSAPEDIDO         := NIL
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSUNIWS001
Local oClone := WSUNIWS001():New()
	oClone:_URL          := ::_URL 
	oClone:cIDLOCAVIA    := ::cIDLOCAVIA
	oClone:cTOKEN        := ::cTOKEN
	oClone:oWSEXCLUIRRESULT :=  IIF(::oWSEXCLUIRRESULT = NIL , NIL ,::oWSEXCLUIRRESULT:Clone() )
	oClone:oWSPEDIDO     :=  IIF(::oWSPEDIDO = NIL , NIL ,::oWSPEDIDO:Clone() )
	oClone:oWSINCLUIRRESULT :=  IIF(::oWSINCLUIRRESULT = NIL , NIL ,::oWSINCLUIRRESULT:Clone() )
	oClone:oWSVALIDACAORESULT :=  IIF(::oWSVALIDACAORESULT = NIL , NIL ,::oWSVALIDACAORESULT:Clone() )
	oClone:oWSVALIDAITEMRESULT :=  IIF(::oWSVALIDAITEMRESULT = NIL , NIL ,::oWSVALIDAITEMRESULT:Clone() )

	// Estruturas mantidas por compatibilidade - NÃO USAR
	oClone:oWSAPEDIDO    := oClone:oWSPEDIDO
Return oClone

// WSDL Method EXCLUIR of Service WSUNIWS001

WSMETHOD EXCLUIR WSSEND cIDLOCAVIA,cTOKEN WSRECEIVE oWSEXCLUIRRESULT WSCLIENT WSUNIWS001
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<EXCLUIR xmlns="http://localhost/">'
cSoap += WSSoapValue("IDLOCAVIA", ::cIDLOCAVIA, cIDLOCAVIA , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("TOKEN", ::cTOKEN, cTOKEN , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</EXCLUIR>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost/EXCLUIR",; 
	"DOCUMENT","http://localhost/",,"1.031217",; 
	"http://localhost/UNIWS001.apw")

::Init()
::oWSEXCLUIRRESULT:SoapRecv( WSAdvValue( oXmlRet,"_EXCLUIRRESPONSE:_EXCLUIRRESULT","ARETORNO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method INCLUIR of Service WSUNIWS001

WSMETHOD INCLUIR WSSEND oWSPEDIDO,cTOKEN WSRECEIVE oWSINCLUIRRESULT WSCLIENT WSUNIWS001
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<INCLUIR xmlns="http://localhost/">'
cSoap += WSSoapValue("PEDIDO", ::oWSPEDIDO, oWSPEDIDO , "APEDIDO", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("TOKEN", ::cTOKEN, cTOKEN , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</INCLUIR>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost/INCLUIR",; 
	"DOCUMENT","http://localhost/",,"1.031217",; 
	"http://localhost/UNIWS001.apw")

::Init()
::oWSINCLUIRRESULT:SoapRecv( WSAdvValue( oXmlRet,"_INCLUIRRESPONSE:_INCLUIRRESULT","ARETORNO",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VALIDACAO of Service WSUNIWS001

WSMETHOD VALIDACAO WSSEND oWSPEDIDO WSRECEIVE oWSVALIDACAORESULT WSCLIENT WSUNIWS001
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VALIDACAO xmlns="http://localhost/">'
cSoap += WSSoapValue("PEDIDO", ::oWSPEDIDO, oWSPEDIDO , "APEDIDO", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</VALIDACAO>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost/VALIDACAO",; 
	"DOCUMENT","http://localhost/",,"1.031217",; 
	"http://localhost/UNIWS001.apw")

::Init()
::oWSVALIDACAORESULT:SoapRecv( WSAdvValue( oXmlRet,"_VALIDACAORESPONSE:_VALIDACAORESULT","ARRAYOFSTRING",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method VALIDAITEM of Service WSUNIWS001

WSMETHOD VALIDAITEM WSSEND oWSPEDIDO WSRECEIVE oWSVALIDAITEMRESULT WSCLIENT WSUNIWS001
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<VALIDAITEM xmlns="http://localhost/">'
cSoap += WSSoapValue("PEDIDO", ::oWSPEDIDO, oWSPEDIDO , "APEDIDO", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</VALIDAITEM>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://localhost/VALIDAITEM",; 
	"DOCUMENT","http://localhost/",,"1.031217",; 
	"http://localhost/UNIWS001.apw")

::Init()
::oWSVALIDAITEMRESULT:SoapRecv( WSAdvValue( oXmlRet,"_VALIDAITEMRESPONSE:_VALIDAITEMRESULT","ARRAYOFSTRING",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure ARETORNO

WSSTRUCT UNIWS001_ARETORNO
	WSDATA   cCODIGO                   AS string OPTIONAL
	WSDATA   cOCORRENCIA               AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UNIWS001_ARETORNO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT UNIWS001_ARETORNO
Return

WSMETHOD CLONE WSCLIENT UNIWS001_ARETORNO
	Local oClone := UNIWS001_ARETORNO():NEW()
	oClone:cCODIGO              := ::cCODIGO
	oClone:cOCORRENCIA          := ::cOCORRENCIA
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UNIWS001_ARETORNO
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::cCODIGO            :=  WSAdvValue( oResponse,"_CODIGO","string",NIL,NIL,NIL,"S",NIL,NIL) 
	::cOCORRENCIA        :=  WSAdvValue( oResponse,"_OCORRENCIA","string",NIL,NIL,NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure APEDIDO

WSSTRUCT UNIWS001_APEDIDO
	WSDATA   oWSCABEC                  AS UNIWS001_ACABECVENDA
	WSDATA   oWSITENS                  AS UNIWS001_ARRAYOFAITENS
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UNIWS001_APEDIDO
	::Init()
Return Self

WSMETHOD INIT WSCLIENT UNIWS001_APEDIDO
Return

WSMETHOD CLONE WSCLIENT UNIWS001_APEDIDO
	Local oClone := UNIWS001_APEDIDO():NEW()
	oClone:oWSCABEC             := IIF(::oWSCABEC = NIL , NIL , ::oWSCABEC:Clone() )
	oClone:oWSITENS             := IIF(::oWSITENS = NIL , NIL , ::oWSITENS:Clone() )
Return oClone

WSMETHOD SOAPSEND WSCLIENT UNIWS001_APEDIDO
	Local cSoap := ""
	cSoap += WSSoapValue("CABEC", ::oWSCABEC, ::oWSCABEC , "ACABECVENDA", .T. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("ITENS", ::oWSITENS, ::oWSITENS , "ARRAYOFAITENS", .T. , .F., 0 , NIL, .F.,.F.) 
Return cSoap

// WSDL Data Structure ARRAYOFSTRING

WSSTRUCT UNIWS001_ARRAYOFSTRING
	WSDATA   cSTRING                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UNIWS001_ARRAYOFSTRING
	::Init()
Return Self

WSMETHOD INIT WSCLIENT UNIWS001_ARRAYOFSTRING
	::cSTRING              := {} // Array Of  ""
Return

WSMETHOD CLONE WSCLIENT UNIWS001_ARRAYOFSTRING
	Local oClone := UNIWS001_ARRAYOFSTRING():NEW()
	oClone:cSTRING              := IIf(::cSTRING <> NIL , aClone(::cSTRING) , NIL )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT UNIWS001_ARRAYOFSTRING
	Local oNodes1 :=  WSAdvValue( oResponse,"_STRING","string",{},NIL,.T.,"S",NIL,"a") 
	::Init()
	If oResponse = NIL ; Return ; Endif 
	aEval(oNodes1 , { |x| aadd(::cSTRING ,  x:TEXT  ) } )
Return

// WSDL Data Structure ACABECVENDA

WSSTRUCT UNIWS001_ACABECVENDA
	WSDATA   cC5_CLIENTE               AS string OPTIONAL
	WSDATA   dC5_EMISSAO               AS date OPTIONAL
	WSDATA   cC5_IDLOCAV               AS string OPTIONAL
	WSDATA   cC5_LOJA                  AS string OPTIONAL
	WSDATA   cC5_NUM                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UNIWS001_ACABECVENDA
	::Init()
Return Self

WSMETHOD INIT WSCLIENT UNIWS001_ACABECVENDA
Return

WSMETHOD CLONE WSCLIENT UNIWS001_ACABECVENDA
	Local oClone := UNIWS001_ACABECVENDA():NEW()
	oClone:cC5_CLIENTE          := ::cC5_CLIENTE
	oClone:dC5_EMISSAO          := ::dC5_EMISSAO
	oClone:cC5_IDLOCAV          := ::cC5_IDLOCAV
	oClone:cC5_LOJA             := ::cC5_LOJA
	oClone:cC5_NUM              := ::cC5_NUM
Return oClone

WSMETHOD SOAPSEND WSCLIENT UNIWS001_ACABECVENDA
	Local cSoap := ""
	cSoap += WSSoapValue("C5_CLIENTE", ::cC5_CLIENTE, ::cC5_CLIENTE , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C5_EMISSAO", ::dC5_EMISSAO, ::dC5_EMISSAO , "date", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C5_IDLOCAV", ::cC5_IDLOCAV, ::cC5_IDLOCAV , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C5_LOJA", ::cC5_LOJA, ::cC5_LOJA , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C5_NUM", ::cC5_NUM, ::cC5_NUM , "string", .F. , .F., 0 , NIL, .F.,.F.) 
Return cSoap

// WSDL Data Structure ARRAYOFAITENS

WSSTRUCT UNIWS001_ARRAYOFAITENS
	WSDATA   oWSAITENS                 AS UNIWS001_AITENS OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UNIWS001_ARRAYOFAITENS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT UNIWS001_ARRAYOFAITENS
	::oWSAITENS            := {} // Array Of  UNIWS001_AITENS():New()
Return

WSMETHOD CLONE WSCLIENT UNIWS001_ARRAYOFAITENS
	Local oClone := UNIWS001_ARRAYOFAITENS():NEW()
	oClone:oWSAITENS := NIL
	If ::oWSAITENS <> NIL 
		oClone:oWSAITENS := {}
		aEval( ::oWSAITENS , { |x| aadd( oClone:oWSAITENS , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPSEND WSCLIENT UNIWS001_ARRAYOFAITENS
	Local cSoap := ""
	aEval( ::oWSAITENS , {|x| cSoap := cSoap  +  WSSoapValue("AITENS", x , x , "AITENS", .F. , .F., 0 , NIL, .F.,.F.)  } ) 
Return cSoap

// WSDL Data Structure AITENS

WSSTRUCT UNIWS001_AITENS
	WSDATA   nC6_LOCAL                 AS float OPTIONAL
	WSDATA   nC6_PRCVEN                AS float OPTIONAL
	WSDATA   cC6_PRODUTO               AS string OPTIONAL
	WSDATA   nC6_QTDVEN                AS integer OPTIONAL
	WSDATA   nC6_TES                   AS float OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT UNIWS001_AITENS
	::Init()
Return Self

WSMETHOD INIT WSCLIENT UNIWS001_AITENS
Return

WSMETHOD CLONE WSCLIENT UNIWS001_AITENS
	Local oClone := UNIWS001_AITENS():NEW()
	oClone:nC6_LOCAL            := ::nC6_LOCAL
	oClone:nC6_PRCVEN           := ::nC6_PRCVEN
	oClone:cC6_PRODUTO          := ::cC6_PRODUTO
	oClone:nC6_QTDVEN           := ::nC6_QTDVEN
	oClone:nC6_TES              := ::nC6_TES
Return oClone

WSMETHOD SOAPSEND WSCLIENT UNIWS001_AITENS
	Local cSoap := ""
	cSoap += WSSoapValue("C6_LOCAL", ::nC6_LOCAL, ::nC6_LOCAL , "float", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C6_PRCVEN", ::nC6_PRCVEN, ::nC6_PRCVEN , "float", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C6_PRODUTO", ::cC6_PRODUTO, ::cC6_PRODUTO , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C6_QTDVEN", ::nC6_QTDVEN, ::nC6_QTDVEN , "integer", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("C6_TES", ::nC6_TES, ::nC6_TES , "float", .F. , .F., 0 , NIL, .F.,.F.) 
Return cSoap


