///////////////////////////////////////////////////////////////////////////////////
//Модуль - StringBytes Клиент Сервер
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
#Область ПрограммныйИнтерфейс

// Функция - Байты в строку
//
// Параметры:
//  bytes	 - Массив - Массив байт
//  encoding - Строка - Формат кодирования
// 
// Возвращаемое значение:
// Строка - Строка полученая алгоритмом кодирования по массиву байт
//
Функция БайтыВСтроку(bytes, encoding) Экспорт 
	
	Если encoding = "utf8" Тогда 
		
		Возврат Crypt_Utf8.МассивБайтВUtf8Строку(bytes);
		
	ИначеЕсли encoding = "raw" Тогда 
		
		Результат = "";
		
		Для Каждого Байт из bytes Цикл
			
			Результат = Результат + Символ(Байт);	
			
		КонецЦикла;	
		
		Возврат Результат;
		
	Иначе
		
		ВызватьИсключение "Unsupported encoding " + encoding;
		
	КонецЕсли;
		
КонецФункции

// Функция - Строку в байты
//
// Параметры:
//  str		 - Строка - Строка для кодирования
//  encoding - Строка - Формат кодирования
// 
// Возвращаемое значение:
// Массив  - массив байт по исходной строке
//
Функция СтрокуВБайты(str, encoding) Экспорт 
	
	Если encoding = "utf8" Тогда 
		
		Возврат Crypt_Utf8.СтрокаВUtf8МассивБайт(str);
		
	ИначеЕсли encoding = "raw" Тогда 
		
		Результат = Новый Массив;
		
		Для сч = 1 По СтрДлина(str) Цикл		
			
			Результат.Добавить(КодСимвола(str, сч));
			
		КонецЦикла;	
		
		Возврат Результат;
		
	Иначе
		
		ВызватьИсключение "Unsupported encoding " + encoding;
		
	КонецЕсли;
		
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////
 