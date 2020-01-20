////////////////////////////////////////////////////////////////////////////////////
// Interface - Клиент Сервер
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

Функция PUBLIC_KEY_LENGTH() Экспорт

    Возврат 32;

КонецФункции

Функция PRIVATE_KEY_LENGTH() Экспорт

    Возврат  32;

КонецФункции

Функция SIGNATURE_LENGTH() Экспорт

    Возврат  64;
   
КонецФункции

Функция ADDRESS_LENGTH() Экспорт

    Возврат 26;
    
КонецФункции

Функция MAIN_NET_CHAIN_ID() Экспорт

    Возврат 65; // A

КонецФункции

Функция TEST_NET_CHAIN_ID() Экспорт

    Возврат 75; // K
    
КонецФункции

Функция GetPrefixHash() Экспорт
	
	prefixHash_t = Crypt_ТипизированныеМассивы.Uint8Array("prefixHash");
	
	prefixHash = prefixHash_t.prefixHash;
	
	prefixHash.Добавить(23);
	prefixHash.Добавить(34);
	prefixHash.Добавить(188);
	prefixHash.Добавить(227);
	prefixHash.Добавить(22);
	prefixHash.Добавить(99);
	prefixHash.Добавить(100);
	prefixHash.Добавить(52);
	prefixHash.Добавить(183);
	prefixHash.Добавить(52);
	prefixHash.Добавить(97);
	prefixHash.Добавить(121);
	prefixHash.Добавить(205);
	prefixHash.Добавить(166);
	prefixHash.Добавить(229);
	prefixHash.Добавить(145);
	prefixHash.Добавить(141);
	prefixHash.Добавить(18);
	prefixHash.Добавить(101);
	prefixHash.Добавить(232);
	prefixHash.Добавить(117);
	prefixHash.Добавить(84);
	prefixHash.Добавить(141);
	prefixHash.Добавить(131);
	prefixHash.Добавить(147);
	prefixHash.Добавить(216);
	prefixHash.Добавить(151);
	prefixHash.Добавить(208);
	prefixHash.Добавить(232);
	prefixHash.Добавить(5);
	prefixHash.Добавить(100);
	prefixHash.Добавить(144);
	
	Возврат prefixHash_t;
	
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////