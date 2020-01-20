////////////////////////////////////////////////////////////////////////////////////
//	AdressKeySeed - Клиент Сервер
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

Функция ПолучитьПубличныйКлюч(SeedOrPrivatKey) Экспорт
	
	Возврат ПолучитьПаруКлючей(SeedOrPrivatKey).ПубличныйКлюч;
	
КонецФункции

Функция ПолучитьПриватныйКлюч(Seed) Экспорт
	
	Возврат ПолучитьПаруКлючей(Seed).ПриватныйКлюч;
	
КонецФункции

Функция ПолучитьПаруКлючей(Seed, СтроковоеПредставление = Истина)  Экспорт
	
	МассивБайт = Crypt_Utf8.СтрокаВUtf8МассивБайт(Seed);
	
	СтруктураКлючей = СоздатьСидХэш(МассивБайт);
	
	ПараКлючей = Новый Структура;
	
	Если СтроковоеПредставление Тогда 
	
		ПараКлючей.Вставить("ПубличныйКлюч", Crypt_Base58.base58_encode(СтруктураКлючей.pk.pk));
		ПараКлючей.Вставить("ПриватныйКлюч", Crypt_Base58.base58_encode(СтруктураКлючей.sk.sk));
		
	Иначе
		
		ПараКлючей.Вставить("ПубличныйКлюч", СтруктураКлючей.pk.pk);
		ПараКлючей.Вставить("ПриватныйКлюч", СтруктураКлючей.sk.sk);
	
	КонецЕсли;	
	
	Возврат ПараКлючей;
	
КонецФункции

Функция ПолучитьАдрес(publicKeyBytes, chainId = Неопределено, СтроковоеПредставление = Истина) Экспорт
	
	Если chainId = Неопределено Тогда 
		
		chainId = Crypt_Interface.MAIN_NET_CHAIN_ID();
		
	КонецЕсли;
	
	prefix = Новый Массив;
	
	prefix.Добавить(1);
	
	prefix.Добавить(?(ТипЗнч(chainId) = " ", Символ(Сред(chainId, 1, 1)), chainId));
	
	publicKeyHashPart = Crypt_ОбщегоНазначенияКлиентСевер.ОбрезатьМассив(
		Crypt_Sha3.KeccakUpdate(Crypt_Blake2b.blake2b(publicKeyBytes), "out").array_t.array, 0, 20);
		
	сМассивов = Новый Структура;
	сМассивов.Вставить("а", prefix);
	сМассивов.Вставить("б", publicKeyHashPart);
		
	rawAddress = Crypt_ОбщегоНазначенияКлиентСевер.СложитьМассивы(сМассивов, Ложь);	
	
	addressHash = Crypt_ОбщегоНазначенияКлиентСевер.ОбрезатьМассив(
		Crypt_Sha3.KeccakUpdate(Crypt_Blake2b.blake2b(rawAddress), "out").array_t.array, 0, 4);
		
	сМассивов = Новый Структура;
	сМассивов.Вставить("а", rawAddress);
	сМассивов.Вставить("б", addressHash);
	
	Результат = Crypt_ОбщегоНазначенияКлиентСевер.СложитьМассивы(сМассивов, Ложь);

	Если СтроковоеПредставление Тогда 
		
		Результат = Crypt_Base58.base58_encode(Результат);
		
	КонецЕсли;
		
	Возврат Результат;
	
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
#Область СлужебныеПроцедурыИФункции

Функция СоздатьСидХэш(смБайт, Нонс = Неопределено)
	
	мНонс = Новый Массив(4);
	мНонс[0] = 0;
	мНонс[1] = 0;
	мНонс[2] = 0;
	мНонс[3] = 0;
	
	Если Нонс <> Неопределено тогда
		
		Если Нонс > 0 Тогда
			
		// разобраться с nonce adress-key-seed.js : 22	
			
		КонецЕсли;
		
	КонецЕсли;
	
	МассивыКОбъеденению = Новый Структура;
	МассивыКОбъеденению.Вставить("мНонс", мНонс);
	МассивыКОбъеденению.Вставить("смБайт", смБайт);
	
	мСидНонс = Crypt_ОбщегоНазначенияКлиентСевер.СложитьМассивы(МассивыКОбъеденению, Ложь);
	
	this = Crypt_Sha3.KeccakUpdate(Crypt_Blake2b.blake2b(мСидНонс), "out");
	
	СидХэш = Crypt_Sha256ВызовСервера.Sha256(this.array_t.array);
	
	Возврат Crypt_Axlsign.generateKeyPair(this.array_t, "array");
			
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////
 