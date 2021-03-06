﻿//******************************************************************************
// ФильтрБанка(ВремБанк)
//
// Параметры:
//  ВремБанк
//
// Возвращаемое значение:
//  Нет
//
// Описание:
//  Установка фильтра по регистру Банк.
//
Процедура ФильтрБанка(ВремБанк)
//	
//	ВремБанк.УстановитьЗначениеФильтра("Фирма",			Фирма,			1);
//	ВремБанк.УстановитьЗначениеФильтра("БанковскийСчет",БанковскийСчет,	1);
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремБанк.ВременныйРасчет(1);
//	КонецЕсли;
//	
КонецПроцедуры // ФильтрБанка()

//******************************************************************************
// ПроведениеПоБанку()
//
// Параметры:
//  Нет
//
// Возвращаемое значение:
//  Нет
//
// Вызывается из формул элементов диалога:
//
// Описание:
//  Обработка проведения при перемещении денег по банковскому счету.
//
Процедура ПроведениеПоБанку()
//	
//	ВремРегистры 	= СоздатьОбъект("Регистры");
//	
//	ВремБанк 		= ВремРегистры.Банк;
//	ФильтрБанка(ВремБанк);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//		
//	Регистр.Банк.Фирма			= Фирма;
//	Регистр.Банк.БанковскийСчет	= БанковскийСчет;  
//	Регистр.Банк.ДвижениеДенежныхСредств = ""; // не важно
//	
//	ОстатокВал = ВремБанк.Остаток(Фирма,БанковскийСчет,"СуммаВал"); 
//	ОстатокУпр = ВремБанк.Остаток(Фирма,БанковскийСчет,"СуммаУпр"); 
//	ОстатокРуб = ВремБанк.Остаток(Фирма,БанковскийСчет,"СуммаРуб"); 
//    
//	Если ОстатокВал<Сумма Тогда
//		глНеПроводить(Контекст, "На расчетном счете "+БанковскийСчет+" за фирмой "+Фирма+
//		" числится меньше средств, чем указано к перемещению!"+РазделительСтрок+
//		"   Остаток на счете:     "+ОстатокВал+" "+Валюта+РазделительСтрок+
//		"   Указано к перемещению:"+Сумма     +" "+Валюта);
//		Возврат;
//	КонецЕсли;
//	
//	ПогаситьВал = Мин(ОстатокВал,Сумма);
//	ПогаситьУпр = Окр(ОстатокУпр*ПогаситьВал/ОстатокВал,2,1);
//	ПогаситьРуб = Окр(ОстатокРуб*ПогаситьВал/ОстатокВал,2,1);
//
//	Регистр.Банк.СуммаВал = ПогаситьВал;
//	Регистр.Банк.СуммаУпр = ПогаситьУпр;
//	Регистр.Банк.СуммаРуб = ПогаситьРуб;
//		
//	Регистр.Банк.КодОперации = глКО.Перемещение;
//	// спишем средства
//	Регистр.Банк.ДвижениеРасходВыполнить();
//	// и сразу зачислим на счет по другой фирме
//	Регистр.Банк.Фирма = ФирмаПолучатель;
//	Регистр.Банк.ДвижениеПриходВыполнить();
//
КонецПроцедуры // ПроведениеПоБанку()

//******************************************************************************
// ПроведениеПоРегистрам()
//
// Параметры:
//  Нет.
//
// Возвращаемое значение:
//  Нет.
//
// Описание:
//  Проведение по регистрам оперативного учета.
//
Процедура ПроведениеПоРегистрам()
//	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//   	
//	ВалютаСчета = ?(ПустоеЗначение(БанковскийСчет.ВалютаСчета)=1,глРубли,БанковскийСчет.ВалютаСчета);
//	Если ВалютаСчета <> Валюта Тогда
//		глНеПроводить(Контекст,"Валюта документа не совпадает с валютой банковского счета!");
//		Возврат;
//	КонецЕсли;	 
//	ПроведениеПоБанку();
//	
КонецПроцедуры

//******************************************************************************
// Предопределенная процедура.
//
Процедура ОбработкаПроведения(Отказ, Режим)
//	    
//	СписокОбязРеквизитов = "Фирма,ФирмаПолучатель,Валюта,Сумма,БанковскийСчет";
//	
//	// Проверка заполненности обязательных реквизитов.
//	Если глВсеРеквизитыДокументаЗаполнены(Контекст,СписокОбязРеквизитов)=0 Тогда
//		Возврат;
//	КонецЕсли;
//   	   
//   	Если (Фирма.ЮрЛицо <> ФирмаПолучатель.ЮрЛицо)
//	Тогда     
//		глНеПроводить(Контекст,"Нельзя перемещать деньги между фирмами,
//		                       |имеющими различные юридические лица!");
//		Возврат;
//	КонецЕсли;
//
//	// Проведение по регистрам оперативного учета.	
//	Если (ПустоеЗначение(ВидыДвижений) = 1) ИЛИ (Найти(ВидыДвижений, "Регистр") <> 0) Тогда
//		ПроведениеПоРегистрам();
//		
//		Если СтатусВозврата() = 0 Тогда
//			Возврат;
//		КонецЕсли;
//	КонецЕсли;
//	
//	глПриПроведении(Контекст, ВидыДвижений);
//	
КонецПроцедуры //ОбработкаПроведения()
//
//////////////////////////////////////////////////////////////////////////////////
//// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
////
