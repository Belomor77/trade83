﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************

Процедура ОбработкаПроведенияПоВзаиморасчетам()
	
	Перем ТаблицаДолгов;
	Перем ВремРегистры;
	Перем ВремВзаиморасчеты;
	Перем КодОперации;
//	
//	КодОперации = глКО.Прочее;
//		
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(КодОперации,	"КодОперации");
//	                   
//	ВремРегистры = СоздатьОбъект("Регистры"); 
//	Если Сумма<0 Тогда
//		СписокПараметров.ДобавитьЗначение(-1, "ЗнакДвижения"); // уменьшение долга клиента
//	Иначе     
//		СписокПараметров.ДобавитьЗначение(1, "ЗнакДвижения"); // увеличение долга клиента
//	КонецЕсли;
//	               
//	Если ВидОперации = Перечисление.ВидыОперацийКоррДолга.Покупатель Тогда
//		ВремВзаиморасчеты=ВремРегистры.Покупатели;
//	Иначе     
//		ВремВзаиморасчеты=ВремРегистры.Поставщики;
//	КонецЕсли;
//		
//	глФильтрДолгов(Контекст, Договор, СписокПараметров, ВремВзаиморасчеты);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	
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
//	
//	ТаблДолгов.ВидДолга 	= глВД.Аванс;    
//		
//	// суммы
//    ВалютаВзаим	= Договор.ВалютаВзаиморасчетов;
//		                                          
//	ЗнакСуммы  	= ?(Сумма<0,-1,1);
//	ТаблДолгов.СуммаУпр = ЗнакСуммы*?(ВалютаВзаим=глДоллары	,СуммаВзаиморасчетов,глПересчет(Сумма,Валюта,Курс,глДоллары,КурсДоллара,Кратность,КратДоллара));
//	ТаблДолгов.СуммаРуб = ЗнакСуммы*?(ВалютаВзаим=глРубли	,СуммаВзаиморасчетов,глПересчет(Сумма,Валюта,Курс,глРубли,	КурсРубля,  Кратность,КратРубля));
//	ТаблДолгов.Сумма 	= ЗнакСуммы*СуммаВзаиморасчетов;
//		           
//	Если ВидОперации = Перечисление.ВидыОперацийКоррДолга.Поставщик Тогда
//		ТекущийДолг = ВремВзаиморасчеты.СводныйОстаток(Фирма,Договор,,,"СуммаВал");
//		Если (ЗнакСуммы < 0) И (ТаблДолгов.Сумма > ТекущийДолг) Тогда
//		    глНеПроводить(Контекст, "Сумма корректировки превышает долг поставщика перед фирмой!");
//			Возврат;
//		КонецЕсли;
//	КонецЕсли;
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
КонецПроцедуры  // ОбработкаПроведенияПоВзаиморасчетам()

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
//	ОбработкаПроведенияПоВзаиморасчетам(); 
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
//	// Проверка заполненности обязательных реквизитов.
//	Если глВсеРеквизитыДокументаЗаполнены(Контекст,
//		"Фирма,Валюта,Контрагент,Договор,ВидОперации")=0 Тогда
//		Возврат;
//	КонецЕсли;
//   	    
//	Если Сумма  = 0 Тогда
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
