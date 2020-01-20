///////////////////////////////////////////////////////////////////////////////////
//Модуль - Ключевые фарзы Клиент Сервер
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

Функция ПолучитьКлючевуюФразу() Экспорт
	
	СисИнфо = Новый СистемнаяИнформация;	
	
	Версия = Crypt_Blake2b.blake2b(Crypt_StringBytes.СтрокуВБайты(СисИнфо.ВерсияПриложения, "raw"), , 32);	
	Результат = Crypt_Blake2b.blake2b(Версия.out, , 64);
	
	Возврат Crypt_StringBytes.БайтыВСтроку(Результат.out, "raw");
	
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////
