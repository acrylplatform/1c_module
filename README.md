# 1С Module

[Подробное описание на Infostart](https://infostart.ru/public/1179411/)

Модуль интеграция 1С и блокчейн платформы "Acryl Platform" без использования внешних компонент. Под катом реализация механизмов Base58, Blake2b, Keccak, Curv25519 (the elliptic curve Diffie–Hellman) в подсистеме "Crypt", примеры генерации ключей, адресов, подписи транзакций, запись данных в блокчейн, чтение и восстановление данных из блокчейн. Код открыть. Лицензия MIT.

# Подсистема "Crypt"

Расширение предназначено для работы с блокчейном Acryl Platform. Методы расширения позволяют генерировать адреса, публичные и приватные ключи из секретной фразы, а так же подписать и проверять подпись сообщений / транзакций.

## Реализованные механизмы в подсистеме "Crypt":

 - [x] Base58
 - [x] Blake2b
 - [x] Keccak
 - [x] curv25519 (the elliptic curve Diffie–Hellman)

Все перечисленные реализации работоспособны как на сервере так и на клиенте.

## Демо работы с подсистемой Crypt:
Формирование пары ключей: публичного и приватного ключа, а так же адреса.
    
	Seed = "uncle push human bus echo drastic garden joke sand warfare sentence fossil title color combine";
	
	ПараКлючей = Crypt_AdressKeySeed.ПолучитьПаруКлючей(Seed, Ложь);

	ПубличныйКлюч = Crypt_Base58.base58_encode(ПараКлючей.ПубличныйКлюч); // 4KxUVD9NtyRJjU3BCvPgJSttoJX7cb3DMdDTNucLN121

	ПриватныйКлюч = Crypt_Base58.base58_encode(ПараКлючей.ПриватныйКлюч); // 6zFSymZAoaua3gtJPbAUwM584tRETdKYdEG9BeEnZaGW

	ВашАдрес = Crypt_AdressKeySeed.ПолучитьАдрес(ПараКлючей.ПубличныйКлюч); // 3EHt9NerduyUBYP4qnf3FtnuNUeNfw22Lo9

Подпись сообщения и проверка подписи

    СтрокаКПодписи = "Демонстрация подписи данных";

    ДанныеКПодписи = Crypt_StringBytes.СтрокуВБайты(СтрокаКПодписи, "raw"); //
	
	Сигнатура = Crypt_Base58.base58_encode(Crypt_Axlsign.sign(ПараКлючей.ПриватныйКлюч, ДанныеКПодписи)); //Ati7aQy5Rty6Etc1LYCUrAWBS6JuZBfQXA45UpU5gkCwe9oRe1CxGM1LwgxAFXM83uYxnJuXw1YYarcRtssRfu3
	
    ДанныеКПодписи = Crypt_StringBytes.СтрокуВБайты(СтрокаКПодписи, "raw");
	
	мСигнатура = Crypt_Base58.base58_decode(Сигнатура);

	Верефикация = Crypt_Axlsign.verify(ПараКлючей.ПубличныйКлюч, ДанныеКПодписи, мСигнатура);
	
	Если Верефикация Тогда //Истина
		
		Сообщить("Проверка подписи пройдена успешно!");
		
	Иначе
		
		Сообщить("Проверка подписи данных не пройдена");
		
	КонецЕсли;


