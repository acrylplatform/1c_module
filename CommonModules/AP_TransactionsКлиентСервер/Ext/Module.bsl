///////////////////////////////////////////////////////////////////////////////////
//Модуль - Transactions Клиент Сервер
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
///////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
#Область СлужебныеПроцедурыИФункции

///////////////////////////////////////////////////////////////////////////////////
#Область ОберткаОбщихФункций

Функция floor(Знач Число)
	
	Возврат Crypt_ОбщегоНазначенияКлиентСевер.Округлить(Число);
	
КонецФункции

#КонецОбласти
///////////////////////////////////////////////////////////////////////////////////

Функция ПолучитьТипЗначения(Значение)
	
	Если ТипЗнч(Значение) = Тип("Строка") Тогда 
		
		Возврат "string";
		
	ИначеЕсли ТипЗнч(Значение) = Тип("Число") Тогда
		
		Возврат "boolean";
		
	ИначеЕсли ТипЗнч(Значение) = Тип("Булево") Тогда
		
		Возврат "integer";
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

Процедура transfer(Получатель, Сумма, ПубличныйКлючОтправителя, ПриватныйКлюч, 
										АдресРезультата = Неопределено, TestNet = Ложь) Экспорт
	
	ТелоТранзакции = Новый Структура;
	
	ТелоТранзакции.Вставить("type", 4);
	ТелоТранзакции.Вставить("version", 2);
	ТелоТранзакции.Вставить("senderPublicKey", ПубличныйКлючОтправителя);
	ТелоТранзакции.Вставить("assetId", Неопределено);
	ТелоТранзакции.Вставить("feeAssetId", Неопределено);
	ТелоТранзакции.Вставить("timestamp", Crypt_ОбщегоНазначенияКлиентСевер.ПолучитьTimestamp());	
	ТелоТранзакции.Вставить("amount", Сумма * 100000000);
	ТелоТранзакции.Вставить("fee", 0.001 * 100000000);	
	ТелоТранзакции.Вставить("recipient", Получатель);
	ТелоТранзакции.Вставить("attachment", ""); 
	
	bytes = Неопределено;	
	AP_SerializerКлиентСервер.Серилизация(ТелоТранзакции, , bytes);
	
	мПриватныйКлюч = Crypt_Base58.base58_decode(ПриватныйКлюч);	
	Сигнатура = Crypt_Base58.base58_encode(Crypt_Axlsign.sign(мПриватныйКлюч, bytes.objBytes));
	
	proofs = Новый Массив;
	proofs.Добавить(Сигнатура);
	
	ТелоТранзакции.Вставить("proofs", proofs);
	
	Если TestNet Тогда
		
		ApiUrl = "nodestestnet.acrylplatform.com";
		
	Иначе
		
		ApiUrl = "nodes.acrylplatform.com";
		
	КонецЕсли;
	
	HTTPСоедение = AP_HTTPКлиентСервер.ПолучитьHTTPСоеденение(ApiUrl, Истина);
	Результат = AP_HTTPКлиентСервер.ВызватьHTTPМетод("POST", HTTPСоедение, "/transactions/broadcast", ТелоТранзакции);
	
	ПоместитьВоВременноеХранилище(Результат, АдресРезультата);
	
КонецПроцедуры

Процедура data(Данные, ПубличныйКлючОтправителя, ПриватныйКлюч, 
								АдресРезультата = Неопределено, TestNet = Ложь) Экспорт 
	
	Если ТипЗнч(Данные) <> Тип("Структура") Тогда 
		
		ВызватьИсключение "Не верный тип поля данные. Данные могут быть толькой Структурой.";
	
	КонецЕсли;
	
	ТелоТранзакции = Новый Структура;
	
	ТелоТранзакции.Вставить("type", 12);
	ТелоТранзакции.Вставить("version", 1);
	ТелоТранзакции.Вставить("senderPublicKey", ПубличныйКлючОтправителя);
	ТелоТранзакции.Вставить("data", Данные); 
	ТелоТранзакции.Вставить("timestamp", Crypt_ОбщегоНазначенияКлиентСевер.ПолучитьTimestamp());
	
	bytes = Неопределено;
	
	AP_SerializerКлиентСервер.Серилизация(ТелоТранзакции, , bytes);
	
	fee = floor(1 + (bytes.objBytes.Количество() + 8 - 1) / 1024) * 1000000;
	
	ТелоТранзакции.Вставить("fee", fee);
		
	bytes = Неопределено;	
	AP_SerializerКлиентСервер.Серилизация(ТелоТранзакции, , bytes);
	
	мПриватныйКлюч = Crypt_Base58.base58_decode(ПриватныйКлюч);
	Сигнатура = Crypt_Base58.base58_encode(Crypt_Axlsign.sign(мПриватныйКлюч, bytes.objBytes));
	
	proofs = Новый Массив;
	proofs.Добавить(Сигнатура);
	
	ТелоТранзакции.Вставить("proofs", proofs);
	
	ДанныеТранзакции = Новый Массив;
	
	Для Каждого КлючЗначение Из ТелоТранзакции.data Цикл 
		
		ТекущиеДанные = Новый Структура;
		
		ТекущиеДанные.Вставить("type", ПолучитьТипЗначения(КлючЗначение.Значение));
		ТекущиеДанные.Вставить("key", КлючЗначение.Ключ);
		ТекущиеДанные.Вставить("value", КлючЗначение.Значение);
		
		ДанныеТранзакции.Добавить(ТекущиеДанные);
		
	КонецЦикла;
	
	ТелоТранзакции.data = ДанныеТранзакции;
	
	Если TestNet Тогда
		
		ApiUrl = "nodestestnet.acrylplatform.com";
		
	Иначе
		
		ApiUrl = "nodes.acrylplatform.com";
		
	КонецЕсли;
	
	HTTPСоедение = AP_HTTPКлиентСервер.ПолучитьHTTPСоеденение(ApiUrl, Истина);
	Результат = AP_HTTPКлиентСервер.ВызватьHTTPМетод("POST", HTTPСоедение, "/transactions/broadcast", ТелоТранзакции);
	
	ПоместитьВоВременноеХранилище(Результат, АдресРезультата);

КонецПроцедуры

#КонецОбласти
///////////////////////////////////////////////////////////////////////////////////