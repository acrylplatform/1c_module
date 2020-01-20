////////////////////////////////////////////////////////////////////////////////////
//Модуль - Wallet Клиент Сервер
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

Функция Зашифровать(КлючеваяФраза, ИсходнаяСтрока) Экспорт
	
	КодированноеСлово = "" ;
	
	КолВо=СтрДлина(ИсходнаяСтрока);
	
	Ключ=СОКРЛП(КлючеваяФраза);
	
	Пока СтрДлина(Ключ) < КолВо Цикл
		
		Ключ = Ключ +СОКРЛП(КлючеваяФраза);
		
	КонецЦикла;
	
	Для Индекс=1 По КолВо Цикл
		
		Символ=Сред(ИсходнаяСтрока,Индекс,1);
		
        КлючС = Сред(Ключ,Индекс,1);
		
		КодС=КодСимвола(Символ)+КодСимвола(КлючС); 
		
		КодС24=Код1024(Цел(КодС/47))+Код1024(КодС-47*Цел(КодС/47));
		
		КодированноеСлово=КодированноеСлово+КодС24;
		
	КонецЦикла;

	Возврат КодированноеСлово;
	
КонецФункции

Функция Расшировать(КлючеваяФраза, КодированноеСлово) Экспорт
	
	ИсходнаяСтрока="";
	
	КолВо=Цел(СтрДлина(КодированноеСлово)/2);
	
	Ключ = СОКРЛП(КлючеваяФраза);
	
	Пока СтрДлина(Ключ) < КолВо Цикл
		
		Ключ = Ключ + СОКРЛП(КлючеваяФраза);
		
	КонецЦикла;

	Для Индекс=1 По КолВо Цикл
		
      	СС=Сред(КодированноеСлово, Индекс * 2 - 1, 2); 
		
		КлючС = Сред(Ключ, Индекс, 1);
		
		КодС24 = Код2410(СС) - КодСимвола(КлючС);
		
	    ИсходнаяСтрока = ИсходнаяСтрока + Символ(КодС24);
        
	КонецЦикла;

	Возврат ИсходнаяСтрока;
	
КонецФункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////
#Область СлужебныеПроцедурыИФункции

Функция Код1024(Код)
	
    Стр24="";
	
	Для КодС=13 По 61 Цикл 
		
		Стр24=Стр24+Символ(КодС);
		
	КонецЦикла;
	
	С24=Сред(Стр24, Код + 1, 1);
	
	Возврат С24;
	
Конецфункции

функция Код2410(С2)
	
    Стр24="";
	
	Для КодС = 13 По 61 Цикл 
		
		Стр24=Стр24+Символ(КодС); 
		
	КонецЦикла;
	
	Код = (Найти(Стр24, лев(С2, 1)) - 1) * 47 + Найти(Стр24, Прав(С2, 1)) - 1;
	
	Возврат Код;
	
конецфункции

#КонецОбласти
////////////////////////////////////////////////////////////////////////////////////
 
 