////////////////////////////////////////////////////////////////////////////////////
//Модуль - Wallet Вызов Сервера
//
// MIT License Copyright (c) 2020 AcrylPlatform.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
// copies of the Software, and to permit persons to whom the Software 
// is furnished to do so, subject to the following conditions:
// The above copyright notice and this permission notice shall be 
// included in all copies or substantial portions of the Software.
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT 
// SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, 
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE 
// OR OTHER DEALINGS IN THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////////
 
////////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

Функция СоздатьКошелек(Seed, TestNet = Ложь) Экспорт 
	
	КлючеваяФраза = AP_КлючевыеФарзыКлиентСервер.ПолучитьКлючевуюФразу();
	
	мКлюч = Crypt_Blake2b.blake2b(КлючеваяФраза);
	
	Ключ = Crypt_StringBytes.БайтыВСтроку(мКлюч.out, "raw");
	
	strSeed = Crypt_StringBytes.БайтыВСтроку(Seed, "raw");
	
	outSeed = AP_WalletКлиентСервер.Расшировать(Ключ, strSeed);
	
	ПараКлючей = Crypt_AdressKeySeed.ПолучитьПаруКлючей(outSeed, Ложь);
	
	Если TestNet Тогда 
		
		ChainId = Crypt_Interface.TEST_NET_CHAIN_ID();
		
	Иначе
		
		ChainId = Crypt_Interface.MAIN_NET_CHAIN_ID();
		
	КонецЕсли;
	
	Адрес = Crypt_AdressKeySeed.ПолучитьАдрес(ПараКлючей.ПубличныйКлюч, ChainId);
	
	Wallet = Справочники.AP_AcrylWallet.НайтиПоНаименованию(Адрес, Истина);
	
	Если Wallet.Пустая() Тогда 
	
		Wallet = Справочники.AP_AcrylWallet.СоздатьЭлемент();
		
		Wallet.Наименование = Адрес;
		
		Wallet.ПриватныйКлюч = Crypt_Base58.base58_encode(ПараКлючей.ПриватныйКлюч);
		Wallet.ПубличныйКлюч = Crypt_Base58.base58_encode(ПараКлючей.ПубличныйКлюч);
		
		Wallet.TestNet = TestNet;
		
		Wallet.Записать();
		
	КонецЕсли;
	
	Возврат Wallet.Ссылка;
	
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////