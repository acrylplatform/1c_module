///////////////////////////////////////////////////////////////////////////////////
// Модуль - Sha256 Сервер ВызовСервера
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

///////////////////////////////////////////////////////////////////////////////////
#Область Хеш

Функция Sha256(МассивБайт) Экспорт
	
	ХешБуфер = Новый БуферДвоичныхДанных(МассивБайт.Количество());
	
	сч = 0;
	
	Для Каждого Элемент Из МассивБайт Цикл 
		
		ХешБуфер.Установить(сч, Элемент);
		
		сч = сч + 1;
		
	КонецЦикла;

	
	Поток = Новый ПотокВПамяти(МассивБайт.Количество());
	
	Поток.Записать(ХешБуфер, 0, МассивБайт.Количество());
	
	Хеш = Новый ХешированиеДанных(ХешФункция.SHA256);
	Хеш.Добавить(Поток.ЗакрытьИПолучитьДвоичныеДанные());
	
	Результат = Новый БуферДвоичныхДанных(МассивБайт.Количество());
	
	Хеш.ХешСумма.ОткрытьПотокДляЧтения().Прочитать(Результат, 0, МассивБайт.Количество());
	
	МассивБайт = Новый Массив;
	
	Для Каждого Элемент Из Результат Цикл 
		
		МассивБайт.Добавить(Элемент);
		
	КонецЦикла;
	
	Возврат МассивБайт;
	
КонецФункции

#КонецОбласти
///////////////////////////////////////////////////////////////////////////////////

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////