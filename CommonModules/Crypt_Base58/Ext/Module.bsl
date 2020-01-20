///////////////////////////////////////////////////////////////////////////////////
//Модуль - Base58 Клиент Сервер
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

#Область ПрограммныйИнтерфейс

// Функция - Base58 encode
//
// Параметры:
//  Буфер - Массив - Массив байт, Результат функции base58 decode
// 
// Возвращаемое значение:
// Строка - Результат кодирование байт в строку
//
Функция base58_encode(Знач Буфер) Экспорт
	
	Если ТипЗнч(Буфер) <> ТипЗнч(Новый Массив) Тогда 
		
		Возврат "";
		
	КонецЕсли;
	
	Если Буфер.Количество() = 0 Тогда 
		
		Возврат "";
		
	КонецЕсли;
	
	Числа = Новый Массив;
	Числа.Добавить(0);
	
	сч = 0;
	
	Пока сч < Буфер.Количество() Цикл 
		
		счч = 0;
		
		Пока счч < Числа.Количество() Цикл
			
			Числа[счч] = ПобитовыйСдвигВлево(Числа[счч], 8);
			
			счч = счч + 1;
			
		КонецЦикла;
		
		Числа[0] = Числа[0] + Буфер[сч];
		
		carry = 0;
		
		к = 0;
		
		Пока к < Числа.Количество() Цикл 
			
			Числа[к] = Числа[к] + carry;
			
			Если Числа[к] % 58 = 0 Тогда 
				
				carry = ПобитовоеИли(Числа[к] / 58, 0);
				
			Иначе
				
				carry = Числа[к] / 58;
				carry = Число(Лев(carry, СтрНайти(carry, ",") - 1));
				
				Если ЗначениеЗаполнено(carry) тогда
					
					carry = Число(carry);
					
				Иначе
					
					carry = 0;
					
				КонецЕсли;
				
			КонецЕсли;
						
			Числа[к] = Числа[к] % 58;
			
			к = к + 1;
			                    					
		КонецЦикла;
		
		Пока carry <> 0 Цикл 
			
			Числа.Добавить(carry % 58);
			
			Если carry % 58 = 0 Тогда 
			
				carry = ПобитовоеИли((carry / 58), 0);
						
			Иначе
				
				carry = carry / 58;
				carry = Число(Лев(carry, СтрНайти(carry, ",") - 1));
				
				Если ЗначениеЗаполнено(carry) тогда
					
					carry = Число(carry);
					
				Иначе
					
					carry = 0;
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЦикла;
			
		
		сч = сч + 1;
		
	КонецЦикла;
	
	сч = 0;
	
	Пока (Буфер[сч] = "0" И сч < Буфер.Количество() - 1) Цикл
		
		Числа.Добавить(0);		
		
		сч = сч + 1;
		
	КонецЦикла;
	
	ALPHABET = Crypt_ОбщегоНазначенияКлиентСевер.ПолучитьСтруктуруALPHABET();
	
	Результат = "";
	
	Для Каждого Индекс из Crypt_ОбщегоНазначенияКлиентСевер.РазвернутьМассив(Числа) Цикл 
		
		Результат = Результат + ALPHABET.Массив[Индекс];
		
	КонецЦикла;
	
	
	Возврат Результат;
	
КонецФункции

// Функция - Base58 decode
//
// Параметры:
//  тСтр - Строка - Строка 
// 
// Возвращаемое значение:
// Массив - данные в Base58 
//
Функция base58_decode(Знач тСтр) Экспорт
	
	ALPHABET = Crypt_ОбщегоНазначенияКлиентСевер.ПолучитьСтруктуруALPHABET();
	
	Если Не ЗначениеЗаполнено(тСтр) Тогда 
		
		Возврат Новый Массив; 
		
	КонецЕсли;
	
	Байты = Новый Массив;
	Байты.Добавить(0);
	
	Для сч = 1 По СтрДлина(тСтр) Цикл
		
		с = Сред(тСтр, сч, 1);
		
		Если ALPHABET.Массив.Найти(с) = Неопределено Тогда
			
			ВызватьИсключение "There is no character " + с + " in the Base58 sequence!";
			
		КонецЕсли;
		
		счч = 0;
		
		Пока счч < Байты.Количество() Цикл  
			
			Байты[счч] = Байты[счч] * 58; 
			
			счч = счч + 1;
			
		КонецЦикла;
		
		Байты[0] = Байты[0] + (ALPHABET.Массив.Найти(с));
		
		carry = 0;
		
		счч = 0;
		
		Пока счч < Байты.Количество() Цикл  
			
			Байты[счч] = Байты[счч] + carry;
			
			carry = ПобитовыйСдвигВправо(Байты[счч], 8);
			
			Байты[счч] = ПобитовоеИ(Байты[счч], 255);
			
			счч = счч + 1;
			
		КонецЦикла;
		
		Пока carry <> 0 Цикл 
			
			Байты.Добавить(ПобитовоеИ(carry, 255));
			
			carry = ПобитовыйСдвигВправо(carry, 8);
			
		КонецЦикла;
				
	КонецЦикла;
	
	сч = 1;
	
	Пока (Сред(тСтр, сч, 1) = "1" и сч < Байты.Количество()) Цикл 
		
		Байты.Добавить(0);	
		
	КонецЦикла;
	
	
	Возврат Crypt_ОбщегоНазначенияКлиентСевер.РазвернутьМассив(Байты);
	
КонецФункции

#КонецОбласти