var _0x272d=['Donnez\x20le\x20nombre\x20d\x27erreurs','<option>Codage\x20de\x20Hamming</option>','value','Le\x20code\x20corrigé\x20est\x20:\x20','substring','getElementById','random','msgCorrige','choixAlgo','split','<span>0</span>','</span><br/>','<br/>Il\x20n\x27y\x20a\x20aucune\x20erreur\x20détectée.\x20<br/>\x20Le\x20message\x20reçu\x20est\x20','<input\x20type=\x22button\x22\x20value=\x22codage\x22\x20onclick=\x22codage();\x22/>','<input\x20type=\x22number\x22\x20id=\x22dimension\x22\x20value=\x2210\x22\x20/>','1438532qtOSGd','<br>','<input\x20type=\x22button\x22\x20value=\x22générer\x22\x20onclick=\x22genererCode();\x22/>','<br/>Une\x20erreur\x20a\x20été\x20détectée.','</select>','codegenere','selectedIndex','toFixed','dimension','<label\x20for=\x22dimension\x22>Dimension\x20:\x20</label>','Le\x20code\x20reçu\x20est\x20','msgCode','<span>1</span>','810tFtwyQ','1915DtaEOm','innerHTML','Le\x20bit\x20de\x20redondance\x20à\x20la\x20position\x20','01111110','Le\x20message\x20envoyé\x20est\x20:\x20','1LfCVtn','Le\x20message\x20reçu\x20est\x20:\x20','<form>','<div><h4>Côté\x20émetteur</h4>','Dimension\x20:','Liste\x20des\x20trames\x20reçues\x20:\x20<ul>','<option>Contrôle\x20de\x20parité</option>','dimensionMsg','<p\x20id=\x22msgCode\x22></p>','</div></form>','Une\x20erreur\x20est\x20détectée\x20à\x20la\x20position\x20','<p\x20id=\x22msgCorrige\x22></p>','dimensionX','327433CCKqvM','Erreur\x20sur\x20la\x20ligne\x20','<br>\x20<input\x20type=\x22button\x22\x20value=\x22générer\x22\x20onclick=\x22HDLCsend();\x22/>','<input\x20type=\x22number\x22\x20id=\x22dimensionX\x22\x20value=\x228\x22\x20/>','<br>\x20<input\x20type=\x22text\x22\x20id=\x22trame2\x22\x20value=\x220100011111000110101\x22\x20/>','<br/>','<p\x20id=\x22msgTransmis\x22></p>','</span>','join','1ZSSXxS','<br>\x20<input\x20type=\x22text\x22\x20id=\x22trame3\x22\x20value=\x22010001111110101\x22/>','body','<li>','685924jjdzwE','Trames\x20à\x20envoyer\x20:\x20<br>\x20<input\x20type=\x22text\x22\x20id=\x22trame1\x22\x20value=\x220100011000110101\x22\x20/>','msgTransmis','<span>1</span','Il\x20n\x27y\x20a\x20aucune\x20erreur\x20détectée.<br/>','Le\x20message\x20à\x20transmettre\x20est\x20:\x20','<br/>Dimension=','9qIWpuV','Le\x20message\x20codé\x20est\x20:\x20','Erreur\x20sur\x20la\x20colonne\x20','dimensionY','<span>','<h4>Côté\x20récepteur</h4>','length','24052LEAZUa','trame1','<p\x20id=\x22codegenere\x22></p>','5421806PVKnTE','1643617XIGxqV','<br/>Rendement=','floor','charAt','<option>Choix\x20de\x20l\x27algorithme</option>','checked','<option>Délimitation\x20des\x20trames</option>','<span>0</span','</ul>'];var _0x3182=function(_0x58f420,_0x4dbed8){_0x58f420=_0x58f420-0x161;var _0x272d64=_0x272d[_0x58f420];return _0x272d64;};var _0x4bbe39=_0x3182;(function(_0x353067,_0x25ea66){var _0x3571cf=_0x3182;while(!![]){try{var _0x29c2eb=parseInt(_0x3571cf(0x183))*-parseInt(_0x3571cf(0x17c))+-parseInt(_0x3571cf(0x168))+parseInt(_0x3571cf(0x175))+-parseInt(_0x3571cf(0x1ac))*parseInt(_0x3571cf(0x1ad))+-parseInt(_0x3571cf(0x171))*parseInt(_0x3571cf(0x187))+parseInt(_0x3571cf(0x19f))*-parseInt(_0x3571cf(0x1b2))+parseInt(_0x3571cf(0x186));if(_0x29c2eb===_0x25ea66)break;else _0x353067['push'](_0x353067['shift']());}catch(_0x26203b){_0x353067['push'](_0x353067['shift']());}}}(_0x272d,0xe32e2));var msg,msgCode,msgRecu,msgCorrige;msg=_0x4bbe39(0x1b4),msg+='<select\x20id=\x22choixAlgo\x22\x20onchange=\x22choix();\x22>',msg+=_0x4bbe39(0x18b),msg+=_0x4bbe39(0x161),msg+='<option>LRC</option>',msg+=_0x4bbe39(0x191),msg+=_0x4bbe39(0x18d),msg+=_0x4bbe39(0x1a3),msg+=_0x4bbe39(0x1b5),msg+='<p\x20id=\x22dimensionMsg\x22></p>',msg+=_0x4bbe39(0x185),msg+=_0x4bbe39(0x163),msg+=_0x4bbe39(0x181),msg+=_0x4bbe39(0x16e),msg+=_0x4bbe39(0x166),msg+=_0x4bbe39(0x164),document[_0x4bbe39(0x173)][_0x4bbe39(0x1ae)]=msg;function getRandomInt(_0x118145){var _0x5d1f32=_0x4bbe39;return Math[_0x5d1f32(0x189)](Math[_0x5d1f32(0x196)]()*Math['floor'](_0x118145));}function choix(){var _0xb75d9e=_0x4bbe39,_0x54ca5e=document[_0xb75d9e(0x195)](_0xb75d9e(0x198))['selectedIndex'];if(_0x54ca5e==0x1){var _0x5d7a01=_0xb75d9e(0x1a8);_0x5d7a01+=_0xb75d9e(0x19e),_0x5d7a01+=_0xb75d9e(0x1a1),document[_0xb75d9e(0x195)](_0xb75d9e(0x162))[_0xb75d9e(0x1ae)]=_0x5d7a01;}else{if(_0x54ca5e==0x2){var _0x5d7a01=_0xb75d9e(0x1b6);_0x5d7a01+=_0xb75d9e(0x16b),_0x5d7a01+='<input\x20type=\x22number\x22\x20id=\x22dimensionY\x22\x20value=\x226\x22\x20/>',_0x5d7a01+=_0xb75d9e(0x1a1),document['getElementById'](_0xb75d9e(0x162))[_0xb75d9e(0x1ae)]=_0x5d7a01;}else{if(_0x54ca5e==0x3){var _0x5d7a01='<label\x20for=\x22dimension\x22>Dimension\x20:\x20</label>';_0x5d7a01+=_0xb75d9e(0x19e),_0x5d7a01+='<input\x20type=\x22button\x22\x20value=\x22générer\x22\x20onclick=\x22genererCode();\x22/>',document[_0xb75d9e(0x195)](_0xb75d9e(0x162))[_0xb75d9e(0x1ae)]=_0x5d7a01;}else{if(_0x54ca5e==0x4){var _0x5d7a01=_0xb75d9e(0x176);_0x5d7a01+=_0xb75d9e(0x16c),_0x5d7a01+=_0xb75d9e(0x172),_0x5d7a01+='<br>\x20<input\x20type=\x22checkbox\x22\x20id=\x22bt\x22\x20checked/>\x20avec\x20bits\x20de\x20transparence',_0x5d7a01+=_0xb75d9e(0x16a),document[_0xb75d9e(0x195)]('dimensionMsg')[_0xb75d9e(0x1ae)]=_0x5d7a01;}}}}document[_0xb75d9e(0x195)](_0xb75d9e(0x1a4))[_0xb75d9e(0x1ae)]='',document[_0xb75d9e(0x195)]('msgCode')[_0xb75d9e(0x1ae)]='',document[_0xb75d9e(0x195)](_0xb75d9e(0x177))['innerHTML']='',document[_0xb75d9e(0x195)]('msgCorrige')[_0xb75d9e(0x1ae)]='';}function genererCode(){var _0x551775=_0x4bbe39,_0x5d449b=document['getElementById']('choixAlgo')[_0x551775(0x1a5)],_0x466c3b;if(_0x5d449b==0x1||_0x5d449b==0x3)_0x466c3b=document[_0x551775(0x195)](_0x551775(0x1a7))[_0x551775(0x192)];else _0x5d449b==0x2&&(_0x466c3b=document[_0x551775(0x195)](_0x551775(0x167))['value']*document['getElementById'](_0x551775(0x17f))[_0x551775(0x192)]);msg='';for(var _0x192b38=0x0;_0x192b38<_0x466c3b;_0x192b38++)msg+=getRandomInt(0x2)==0x0?'0':'1';document[_0x551775(0x195)](_0x551775(0x1a4))[_0x551775(0x1ae)]=_0x551775(0x17a)+msg+_0x551775(0x19d);}function HDLCsend(){var _0x419b48=_0x4bbe39,_0x3cf220=document[_0x419b48(0x195)](_0x419b48(0x184))[_0x419b48(0x192)],_0x2ea4da=document[_0x419b48(0x195)]('trame2')['value'],_0x320b09=document[_0x419b48(0x195)]('trame3')[_0x419b48(0x192)],_0x3317ae=document[_0x419b48(0x195)]('bt')[_0x419b48(0x18c)];_0x3317ae&&(_0x3cf220=ajouterBitTransparence(_0x3cf220),_0x2ea4da=ajouterBitTransparence(_0x2ea4da),_0x320b09=ajouterBitTransparence(_0x320b09));var _0x57fe7b=_0x419b48(0x1b0);msg=_0x57fe7b+_0x3cf220+_0x57fe7b+_0x2ea4da+_0x57fe7b+_0x320b09+_0x57fe7b,document[_0x419b48(0x195)](_0x419b48(0x1a4))[_0x419b48(0x1ae)]=_0x419b48(0x1b1)+msg;var _0x11170f,_0x5415e2=0x8,_0x40b523,_0x4c9d7b=_0x419b48(0x1b7);for(_0x11170f=0x8;_0x11170f<msg[_0x419b48(0x182)];_0x11170f++){_0x40b523=msg[_0x419b48(0x194)](_0x11170f,_0x11170f+0x8),_0x40b523==_0x57fe7b&&(_0x3cf220=msg[_0x419b48(0x194)](_0x5415e2,_0x11170f),_0x11170f=_0x11170f+0x8,_0x5415e2=_0x11170f,_0x3317ae&&(_0x3cf220=supprimerBitTransparence(_0x3cf220)),_0x4c9d7b+=_0x419b48(0x174)+_0x3cf220+'</li>');}document[_0x419b48(0x195)](_0x419b48(0x177))['innerHTML']=_0x4c9d7b+_0x419b48(0x18f);}function ajouterBitTransparence(_0xe3d7c8){var _0xb17e6e=_0x4bbe39,_0x3f8e11,_0x3120a0,_0x2b9246=0x0,_0x2a6150='';for(_0x3f8e11=0x0;_0x3f8e11<_0xe3d7c8[_0xb17e6e(0x182)];_0x3f8e11++){_0x3120a0=_0xe3d7c8[_0xb17e6e(0x18a)](_0x3f8e11),_0x2a6150+=_0x3120a0,_0x2b9246=_0x3120a0=='1'?_0x2b9246+0x1:0x0;if(_0x2b9246==0x5)_0x2a6150+='0';}return _0x2a6150;}function supprimerBitTransparence(_0x45d255){var _0x2ed6db=_0x4bbe39,_0x15f73c,_0x20ad24,_0x514cff=0x0,_0x37a20a='';for(_0x15f73c=0x0;_0x15f73c<_0x45d255[_0x2ed6db(0x182)];_0x15f73c++){_0x20ad24=_0x45d255[_0x2ed6db(0x18a)](_0x15f73c),_0x514cff==0x5&&_0x20ad24=='0'?_0x514cff=0x0:(_0x37a20a+=_0x20ad24,_0x514cff=_0x20ad24=='1'?_0x514cff+0x1:0x0);}return _0x37a20a;}function longueurHamming(_0x2dddf7){var _0x55d6c3=_0x4bbe39,_0xd82922=0x0;for(var _0xc00d92=0x0;_0xc00d92<_0x2dddf7[_0x55d6c3(0x182)];_0xc00d92++){if(_0x2dddf7[_0xc00d92]=='1')_0xd82922++;}return _0xd82922;}function ch2int(_0x2b9f9a){return _0x2b9f9a=='0'?0x0:0x1;}function codage(){var _0xf18d4e=_0x4bbe39,_0x5b4e7c,_0x5d6dbb,_0x2d5762,_0x15fa4c=document[_0xf18d4e(0x195)](_0xf18d4e(0x198))[_0xf18d4e(0x1a5)];if(_0x15fa4c==0x1){var _0x22bc10=longueurHamming(msg);_0x5b4e7c=document[_0xf18d4e(0x195)]('dimension')[_0xf18d4e(0x192)],_0x5d6dbb=parseInt(_0x5b4e7c)+0x1,_0x2d5762=(_0x5b4e7c/_0x5d6dbb)[_0xf18d4e(0x1a6)](0x2),_0x22bc10%0x2==0x0?(msgCode=msg+'0',document[_0xf18d4e(0x195)](_0xf18d4e(0x1aa))[_0xf18d4e(0x1ae)]=_0xf18d4e(0x17d)+msg+_0xf18d4e(0x18e)):(msgCode=msg+'1',document[_0xf18d4e(0x195)]('msgCode')[_0xf18d4e(0x1ae)]=_0xf18d4e(0x17d)+msg+_0xf18d4e(0x178));}else{if(_0x15fa4c==0x2){var _0x14de75=parseInt(document['getElementById'](_0xf18d4e(0x167))[_0xf18d4e(0x192)]),_0x2f3137=parseInt(document[_0xf18d4e(0x195)](_0xf18d4e(0x17f))[_0xf18d4e(0x192)]),_0x5b4e7c=_0x14de75*_0x2f3137,_0x5d6dbb=(_0x14de75+0x1)*(_0x2f3137+0x1);_0x2d5762=(_0x5b4e7c/_0x5d6dbb)[_0xf18d4e(0x1a6)](0x2);var _0x28cc96,_0x5a27c2,_0x3ae4d3,_0x47b937=0x0,_0x49f310='';msgCode='';for(_0x5a27c2=0x0;_0x5a27c2<_0x2f3137;_0x5a27c2++){_0x3ae4d3=0x0;for(_0x28cc96=0x0;_0x28cc96<_0x14de75;_0x28cc96++)_0x3ae4d3+=ch2int(msg[_0xf18d4e(0x18a)](_0x5a27c2*_0x14de75+_0x28cc96));_0x49f310+=msg[_0xf18d4e(0x194)](_0x5a27c2*_0x14de75,(_0x5a27c2+0x1)*_0x14de75),_0x49f310+=_0xf18d4e(0x180)+(_0x3ae4d3%0x2==0x0?'0':'1')+_0xf18d4e(0x19b),msgCode+=msg[_0xf18d4e(0x194)](_0x5a27c2*_0x14de75,(_0x5a27c2+0x1)*_0x14de75)+(_0x3ae4d3%0x2==0x0?'0':'1');}for(_0x28cc96=0x0;_0x28cc96<_0x14de75;_0x28cc96++){_0x3ae4d3=0x0;for(_0x5a27c2=0x0;_0x5a27c2<_0x2f3137;_0x5a27c2++)_0x3ae4d3+=ch2int(msg[_0xf18d4e(0x18a)](_0x5a27c2*_0x14de75+_0x28cc96));_0x49f310+=_0xf18d4e(0x180)+(_0x3ae4d3%0x2==0x0?'0':'1')+_0xf18d4e(0x16f),msgCode+=_0x3ae4d3%0x2==0x0?'0':'1',_0x47b937+=_0x3ae4d3%0x2;}_0x49f310+=_0xf18d4e(0x180)+(_0x47b937%0x2==0x0?'0':'1')+_0xf18d4e(0x19b),msgCode+=_0x47b937%0x2==0x0?'0':'1',document[_0xf18d4e(0x195)](_0xf18d4e(0x1aa))['innerHTML']=_0x49f310,document[_0xf18d4e(0x195)](_0xf18d4e(0x1aa))['innerHTML']+='Le\x20message\x20codé\x20est\x20:\x20'+msgCode;}else _0x15fa4c==0x3&&(_0x5b4e7c=document[_0xf18d4e(0x195)](_0xf18d4e(0x1a7))[_0xf18d4e(0x192)],_0x5d6dbb=codageHamming(_0x5b4e7c),_0x2d5762=(_0x5b4e7c/_0x5d6dbb)[_0xf18d4e(0x1a6)](0x2),document['getElementById'](_0xf18d4e(0x1aa))[_0xf18d4e(0x1ae)]+=_0xf18d4e(0x17d)+msgCode,msgCode=msgCode[_0xf18d4e(0x199)](_0xf18d4e(0x180))['join'](''),msgCode=msgCode[_0xf18d4e(0x199)](_0xf18d4e(0x16f))[_0xf18d4e(0x170)](''));}document[_0xf18d4e(0x195)](_0xf18d4e(0x1aa))[_0xf18d4e(0x1ae)]+=_0xf18d4e(0x17b)+_0x5b4e7c+'<br/>Longueur='+_0x5d6dbb+_0xf18d4e(0x188)+_0x2d5762+_0xf18d4e(0x16d),document['getElementById'](_0xf18d4e(0x1aa))['innerHTML']+='<input\x20type=\x22button\x22\x20value=\x22transmettre\x22\x20onclick=\x22transmettre();\x22/>';}function codageHamming(_0x467bde){var _0x13eb20=_0x4bbe39,_0x4410f8=0x3,_0x589ba1=0x2,_0xea96e0=0x4,_0x4de9ad,_0x5bb2a2,_0x512b6d,_0x476c26='00';for(_0x5bb2a2=0x0;_0x5bb2a2<_0x467bde;_0x5bb2a2++){_0x4410f8==_0xea96e0&&(_0x476c26+='0',_0xea96e0*=0x2,_0x589ba1++,_0x4410f8++),_0x476c26+=msg[_0x13eb20(0x18a)](_0x5bb2a2),_0x4410f8++;}_0x589ba1=0x0,_0xea96e0=0x1,msgCode='';for(_0x5bb2a2=0x1;_0x5bb2a2<_0x4410f8;_0x5bb2a2++){if(_0x5bb2a2==_0xea96e0){_0x4de9ad=0x0;for(_0x512b6d=0x1;_0x512b6d<_0x4410f8;_0x512b6d++){decompositionPuiss2(_0x512b6d,_0x589ba1)==0x1&&(_0x4de9ad+=ch2int(_0x476c26[_0x13eb20(0x18a)](_0x512b6d-0x1)));}msgCode+=_0x4de9ad%0x2==0x1?_0x13eb20(0x1ab):_0x13eb20(0x19a),_0xea96e0*=0x2,_0x589ba1++;}else msgCode+=_0x476c26['charAt'](_0x5bb2a2-0x1);}return _0x4410f8-0x1;}function decompositionPuiss2(_0x1778e0,_0x4f84d6){var _0x440e0e=_0x4bbe39,_0xc9243b,_0x302707=_0x1778e0;for(_0xc9243b=0x0;_0xc9243b<_0x4f84d6;_0xc9243b++)_0x302707=Math[_0x440e0e(0x189)](_0x302707/0x2);return _0x302707%0x2;}function correction(_0x345aa8){var _0x1172be=_0x4bbe39;msgCorrige=msgRecu[_0x1172be(0x194)](0x0,_0x345aa8),msgCorrige+=msgRecu['charAt'](_0x345aa8)=='0'?'1':'0',msgCorrige+=msgRecu[_0x1172be(0x194)](_0x345aa8+0x1,msgRecu[_0x1172be(0x182)]);}function genererErreur(_0x5d83b6){var _0xee503a=_0x4bbe39,_0x2649bf=msgRecu['substring'](0x0,_0x5d83b6);_0x2649bf+=msgRecu[_0xee503a(0x18a)](_0x5d83b6)=='0'?'1':'0',_0x2649bf+=msgRecu[_0xee503a(0x194)](_0x5d83b6+0x1,msgRecu['length']),msgRecu=_0x2649bf;}function msgFinalLRC(_0x528b11,_0xbbbce7,_0x5bc95e){var _0x359717=_0x4bbe39,_0x7c0dce='';for(var _0x7ad635=0x0;_0x7ad635<_0x5bc95e;_0x7ad635++){_0x7c0dce+=_0x528b11[_0x359717(0x194)](_0x7ad635*(_0xbbbce7+0x1),_0x7ad635*(_0xbbbce7+0x1)+_0xbbbce7);}return _0x7c0dce;}function transmettre(){var _0x422b5d=_0x4bbe39,_0x207339=parseInt(prompt(_0x422b5d(0x190))),_0x1ba2a3;msgRecu=msgCode;for(var _0x2efc96=0x0;_0x2efc96<_0x207339;_0x2efc96++){_0x1ba2a3=getRandomInt(msgCode[_0x422b5d(0x182)]),genererErreur(_0x1ba2a3);}document[_0x422b5d(0x195)]('msgTransmis')[_0x422b5d(0x1ae)]=_0x422b5d(0x1a9)+msgRecu;var _0x159fef=document[_0x422b5d(0x195)](_0x422b5d(0x198))['selectedIndex'],_0x386a5a='';if(_0x159fef==0x1){var _0x1eb3f4=longueurHamming(msgRecu);_0x386a5a+='<br/>Le\x20code\x20reçu\x20a\x20une\x20longueur\x20de\x20Hamming\x20de\x20'+_0x1eb3f4,_0x1eb3f4%0x2==0x0?_0x386a5a+=_0x422b5d(0x19c)+msgRecu['substring'](0x0,msgRecu[_0x422b5d(0x182)]-0x1):_0x386a5a+=_0x422b5d(0x1a2);}else{if(_0x159fef==0x2){var _0x395158=parseInt(document[_0x422b5d(0x195)](_0x422b5d(0x167))[_0x422b5d(0x192)]),_0x152a5c=parseInt(document['getElementById'](_0x422b5d(0x17f))[_0x422b5d(0x192)]),_0xa1743b,_0x15872a,_0x5e53c2='',_0x217a8e=-0x2,_0x2ac7be=-0x2;for(y=0x0;y<_0x152a5c+0x1;y++){_0xa1743b=msgRecu[_0x422b5d(0x194)](y*(_0x395158+0x1),(y+0x1)*(_0x395158+0x1)),_0x386a5a+=_0xa1743b+'<br>',ham=longueurHamming(_0xa1743b),ham%0x2==0x1&&(_0x5e53c2+=_0x422b5d(0x169)+(y+0x1)+_0x422b5d(0x16d),_0x217a8e=_0x217a8e==-0x2?y:-0x1);}_0x386a5a+=_0x5e53c2;for(x=0x0;x<_0x395158+0x1;x++){_0x15872a=0x0;for(y=0x0;y<_0x152a5c+0x1;y++)_0x15872a+=ch2int(msgRecu['charAt'](y*(_0x395158+0x1)+x));_0x15872a%0x2==0x1&&(_0x386a5a+=_0x422b5d(0x17e)+(x+0x1)+'<br/>',_0x2ac7be=_0x2ac7be==-0x2?x:-0x1);}if(_0x217a8e==-0x2&&_0x2ac7be==-0x2)_0x386a5a+=_0x422b5d(0x179),_0x386a5a+=_0x422b5d(0x1b3)+msgFinalLRC(msgRecu,_0x395158,_0x152a5c);else _0x217a8e>=0x0&&_0x2ac7be>=0x0?(_0x386a5a+='Il\x20y\x20a\x20une\x20erreur\x20détectée.<br>',correction(_0x217a8e*(_0x395158+0x1)+_0x2ac7be),_0x386a5a+=_0x422b5d(0x193)+msgCorrige+_0x422b5d(0x16d),_0x386a5a+='Le\x20message\x20reçu\x20est\x20:\x20'+msgFinalLRC(msgCorrige,_0x395158,_0x152a5c)):_0x386a5a+='Une\x20erreur\x20est\x20détectée\x20mais\x20ne\x20peut\x20pas\x20être\x20corrigée.';}else{if(_0x159fef==0x3){var _0x4cac49=msgRecu['length'],_0x7fa9e4=0x0,_0xb671e6=0x1,_0x23e797,_0x2efc96,_0x168bb2,_0x4cbcbb=0x0;for(_0x23e797=0x1;_0x23e797<_0x4cac49;_0x23e797*=0x2){_0x168bb2=0x0;for(_0x2efc96=0x1;_0x2efc96<=_0x4cac49;_0x2efc96++){decompositionPuiss2(_0x2efc96,_0x7fa9e4)==0x1&&(_0x168bb2+=ch2int(msgRecu[_0x422b5d(0x18a)](_0x2efc96-0x1)));}_0x168bb2%0x2==0x1&&(_0x386a5a+=_0x422b5d(0x1af)+_0xb671e6+'\x20ne\x20donne\x20pas\x20une\x20parité\x20paire<br>',_0x4cbcbb+=_0xb671e6),_0x7fa9e4++,_0xb671e6*=0x2;}_0x4cbcbb!=0x0&&(_0x386a5a+=_0x422b5d(0x165)+_0x4cbcbb+_0x422b5d(0x1a0),correction(_0x4cbcbb));var _0x29a3b7='';_0x2efc96=0x2;for(_0x23e797=0x4;_0x23e797<_0x4cac49;_0x23e797*=0x2){_0x29a3b7+=msgRecu[_0x422b5d(0x194)](_0x2efc96,_0x23e797-0x1),_0x2efc96=_0x23e797;}_0x29a3b7+=msgRecu['substring'](_0x2efc96,_0x4cac49),_0x386a5a+=_0x422b5d(0x193)+msgRecu+_0x422b5d(0x1a0),_0x386a5a+=_0x422b5d(0x1b3)+_0x29a3b7;}}}document[_0x422b5d(0x195)](_0x422b5d(0x197))[_0x422b5d(0x1ae)]=_0x386a5a;}