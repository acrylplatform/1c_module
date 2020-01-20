///////////////////////////////////////////////////////////////////////////////////
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

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Этап2(Команда)
	
	Элементы.грЭтап1.Видимость = Ложь;
	
	Элементы.грЭтап2.Видимость = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура НазадЭтап1(Команда)
	
	Элементы.грЭтап1.Видимость = Истина;
	
	Элементы.грЭтап2.Видимость = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура Этап3(Команда)
	
	Элементы.грЭтап2.Видимость = Ложь;
	
	Элементы.грЭтап3.Видимость = Истина;

КонецПроцедуры

&НаКлиенте
Процедура НазадЭтап2(Команда)
	
	Элементы.грЭтап2.Видимость = Истина;
	
	Элементы.грЭтап3.Видимость = Ложь;

	
КонецПроцедуры

&НаКлиенте
Процедура Конец(Команда)
	
	ЭтаФорма.Закрыть();
	
КонецПроцедуры

#КонецОбласти