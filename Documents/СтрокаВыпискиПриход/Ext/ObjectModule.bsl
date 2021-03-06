﻿Перем РабочийКО;

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// ОбработкаПроведенияПоБанку(ВремБанк)
//
// Параметры:
//  Нет
//
// Возвращаемое значение:
//  Нет
//
// Описание:
//  Здесь описывается процедура.
//
Процедура ОбработкаПроведенияПоБанку()
//	
//	Регистр.Банк.Фирма			= Фирма;
//	Регистр.Банк.БанковскийСчет	= БанковскийСчет;
//	
//	СуммаУпр = глПересчет(Сумма,Валюта,Курс,глДоллары,ДатаДок,Кратность);
//	СуммаРуб = глПересчет(Сумма,Валюта,Курс,глРубли,ДатаДок,Кратность);
//
//	Регистр.Банк.СуммаВал = Сумма;
//	Регистр.Банк.СуммаУпр = СуммаУпр;
//	Регистр.Банк.СуммаРуб = СуммаРуб;
//		
//	Регистр.Банк.КодОперации = РабочийКО;
//	Регистр.Банк.ДвижениеДенежныхСредств = ДвижениеДенежныхСредств;
//	
//	Регистр.Банк.ДвижениеПриходВыполнить();
//	
КонецПроцедуры // ОбработкаПроведенияПоБанку()

//******************************************************************************
Процедура ОбработкаПроведенияПоВзаиморасчетам()
	
	Перем ТаблицаДолгов;
	Перем ВремРегистры;
	Перем ВремВзаиморасчеты;
//		
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(РабочийКО,	"КодОперации");
//	                   
//	ВремРегистры = СоздатьОбъект("Регистры");
//	СписокПараметров.ДобавитьЗначение(-1, "ЗнакДвижения"); // уменьшение долга клиента
//	
//	Если (КодОперации=глКО.ОплатаОтПокупателя)
//	 или (КодОперации=глКО.РозничнаяВыручка) 
//	 или (КодОперации=глКО.РозничнаяВыручкаЕНВД)
//	 или (КодОперации=глКО.РозничнаяВыручкаЗаПринятые) 
//	 или (КодОперации=глКО.РозничнаяВыручкаЗаПринятыеЕНВД) Тогда
//		ВремВзаиморасчеты=ВремРегистры.Покупатели;
//		
//	ИначеЕсли КодОперации=глКО.ВозвратОплатыОтПоставщика Тогда                               
//		ВремВзаиморасчеты=ВремРегистры.Поставщики;
//		
//	КонецЕсли;
//		
//	глФильтрДолгов(Контекст, Договор, СписокПараметров, ВремВзаиморасчеты);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	
//	ТаблДолгов = СоздатьОбъект("ТаблицаЗначений");
//
//	ТаблДолгов.НоваяКолонка("КредДокумент");
//	ТаблДолгов.НоваяКолонка("ВидДолга");
//	ТаблДолгов.НоваяКолонка("СтавкаНДС");
//	ТаблДолгов.НоваяКолонка("СтавкаНП");
//	ТаблДолгов.НоваяКолонка("Сумма");
//	ТаблДолгов.НоваяКолонка("СуммаУпр");
//	ТаблДолгов.НоваяКолонка("СуммаРуб");
//	ТаблДолгов.НоваяКолонка("СуммаНДС");
//	ТаблДолгов.НоваяКолонка("СуммаНП");
//	ТаблДолгов.НоваяКолонка("Себестоимость");
//	ТаблДолгов.НоваяКолонка("ОблагаетсяНП");        
//	ТаблДолгов.НоваяКолонка("ДоговорКомитента");
//	    
//	КурсДоллара	= глКурсДляВалюты(глДоллары,ДатаДок);
//	КратДоллара = глКратностьДляВалюты(глДоллары,ДатаДок);
//	КурсРубля	= глКурсДляВалюты(глРубли,ДатаДок);
//	КратРубля   = глКратностьДляВалюты(глРубли,ДатаДок);
//	
//	ТаблДолгов.НоваяСтрока();
//	
//	ТаблДолгов.КредДокумент = ТекущийДокумент();    
//	Если (КодОперации = глКО.РозничнаяВыручка)
//	 или (КодОперации = глКО.РозничнаяВыручкаЕНВД) 
//	 или (КодОперации = глКО.РозничнаяВыручкаЗаПринятые)
//	 или (КодОперации = глКО.РозничнаяВыручкаЗаПринятыеЕНВД) Тогда
//		ТаблДолгов.ВидДолга 	= глВД.РозничнаяВыручка;  
//	Иначе
//		ТаблДолгов.ВидДолга 	= ?(Валюта= глРубли, глВД.Аванс, глВД.АвансВал);  
//	КонецЕсли;
//		
//	// суммы
//    ВалютаВзаим	= Договор.ВалютаВзаиморасчетов;
//		
//	ТаблДолгов.СуммаУпр = ?(ВалютаВзаим=глДоллары,СуммаВзаиморасчетов,глПересчет(Сумма,Валюта,Курс,глДоллары,КурсДоллара,Кратность,КратДоллара));
//	ТаблДолгов.СуммаРуб = ?(ВалютаВзаим=глРубли	 ,СуммаВзаиморасчетов,глПересчет(Сумма,Валюта,Курс,глРубли,КурсРубля,Кратность,КратРубля));
//	ТаблДолгов.Сумма 	= СуммаВзаиморасчетов;
//		           
//	ТаблДолгов.СуммаНДС = 0;
//	ТаблДолгов.СуммаНП 	= 0;
//	ТаблДолгов.СтавкаНДС= ПолучитьПустоеЗначение(Перечисление.СтавкиНДС);
//	ТаблДолгов.СтавкаНП = ПолучитьПустоеЗначение("Справочник.СтавкиНП");
//		
//	ТаблДолгов.Себестоимость = 0;
//	ТаблДолгов.ОблагаетсяНП = ОблагаетсяНП;
//	    
//	глДвижениеДолгов(Контекст, Договор,ТаблДолгов,СписокПараметров,ВремВзаиморасчеты);
//	
//	ОбработкаПроведенияПоБанку();
//
КонецПроцедуры    

//******************************************************************************
// ОбработкаПроведенияПрочее()
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
//  Обработка проведения по банку прочее.
//
Процедура ОбработкаПроведенияПрочее()
//	
//	
//	ОбработкаПроведенияПоБанку();
//	
КонецПроцедуры // ОбработкаПроведенияПрочее()

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
//	
//	Если КодОперации <> глКО.Прочее Тогда
//		ОбработкаПроведенияПоВзаиморасчетам(); 
//		
//	Иначе
//		ОбработкаПроведенияПрочее();
//		
//	КонецЕсли;       
//
КонецПроцедуры // ПроведениеПоРегистрам()

////////////////////////////////////////////////////////////////////////////////
// ПРЕДОПРЕДЕЛЕННЫЕ ПРОЦЕДУРЫ
//
//******************************************************************************
// Предопределенная процедура.
//
Процедура ОбработкаПроведения(Отказ, Режим)
//	    
//	СписокОбязРеквизитов = "Фирма,БанковскийСчет,Валюта,КодОперации,Сумма";
//	Если (КодОперации <> глКО.Прочее) Тогда
//		СписокОбязРеквизитов = СписокОбязРеквизитов + ",Контрагент,Договор";
//	КонецЕсли;
//	
//	// Проверка заполненности обязательных реквизитов.
//	Если глВсеРеквизитыДокументаЗаполнены(Контекст,СписокОбязРеквизитов)=0 Тогда
//		Возврат;
//	КонецЕсли;
//   	
//	Если Валюта <> глРубли Тогда
//		РабочийКО = глКО.ЗначениеПоИдентификатору(""+КодОперации.Идентификатор()+"Вал");
//	Иначе
//		РабочийКО = КодОперации;
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
