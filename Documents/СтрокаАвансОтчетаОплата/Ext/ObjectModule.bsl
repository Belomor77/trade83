﻿Перем РабочийКО;

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// ФильтрПоставщиков()
//
// Параметры:
//  ВремВзаиморасчеты - регистр "Поставщики"
//
// Возвращаемое значение:
//  Нет
//
// Описание:
// Установка фильтра на регистр "Взаиморасчеты поставщиков" для 
//	временного расчета.
//
Процедура ФильтрПоставщиков(ВремВзаиморасчеты)
//	                                                               
//	ВремВзаиморасчеты.УстановитьЗначениеФильтра("Фирма",	Фирма,	1);
//	
//	Если ИтогиАктуальны()=0 Тогда  
//		СписокДоговоров 	= СоздатьОбъект("СписокЗначений");
//		
//		ВыгрузитьТабличнуюЧасть(СписокДоговоров,	"Договор");
//		
//		ВремВзаиморасчеты.УстановитьЗначениеФильтра("Договор",	 СписокДоговоров,2);
//		
//		ВремВзаиморасчеты.ВременныйРасчет();
//	КонецЕсли;
//	
КонецПроцедуры // ФильтрПоставщиков()

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
	
	Перем ТаблицаДолгов;
	Перем ВремРегистры;
	Перем ВремВзаиморасчеты, ВремПодотчетныеЛица;
//   	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//   	
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(РабочийКО,	"КодОперации");
//    
//	// подготовка к расчету итогов
//	ВремРегистры 		= СоздатьОбъект("Регистры");
//	ВремВзаиморасчеты	= ВремРегистры.Поставщики;
//	ВремПодотчетныеЛица = ВремРегистры.ПодотчетныеЛица;
//	// установка фильтров, флагов временного расчета у регистров
//	глФильтрПодотчетников(Контекст, ФизЛицо, Валюта, СписокПараметров, ВремПодотчетныеЛица);
//	ФильтрПоставщиков(ВремВзаиморасчеты);
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
//	ТаблДолгов.НоваяКолонка("Сумма");
//	ТаблДолгов.НоваяКолонка("СуммаУпр");
//	ТаблДолгов.НоваяКолонка("СуммаРуб");
//	ТаблДолгов.НоваяКолонка("СуммаНДС");
//	ТаблДолгов.НоваяКолонка("СуммаНП");
//	ТаблДолгов.НоваяКолонка("СтавкаНДС");
//	
//	КурсДоллара	= глКурсДляВалюты(глДоллары,ДатаДок);
//	КратДоллара = глКратностьДляВалюты(глДоллары,ДатаДок);
//	КурсРубля	= глКурсДляВалюты(глРубли,ДатаДок);
//	КратРубля   = глКратностьДляВалюты(глРубли,ДатаДок);
//	
//	ВыбратьСтроки();
//	Пока ПолучитьСтроку()=1 Цикл
//		
//		глФильтрДолгов(Контекст, Договор, СписокПараметров, ВремВзаиморасчеты);
//		
//		ТаблДолгов.УдалитьСтроки();
//		ТаблДолгов.НоваяСтрока();
//		
//		ТаблДолгов.КредДокумент = ТекущийДокумент();
//		ТаблДолгов.ВидДолга	 	= глВД.Аванс;		
//		
//		// суммы
//		ВалютаВзаим			= Договор.ВалютаВзаиморасчетов;
//		
//		ТаблДолгов.СуммаУпр = ?(ВалютаВзаим=глДоллары,СуммаВзаиморасчетов,глПересчет(Сумма,Валюта,Курс,глДоллары,КурсДоллара,Кратность,КратДоллара));
//		ТаблДолгов.СуммаРуб = ?(ВалютаВзаим=глРубли	 ,СуммаВзаиморасчетов,глПересчет(Сумма,Валюта,Курс,глРубли,КурсРубля,Кратность,КратРубля));
//		ТаблДолгов.Сумма 	= СуммаВзаиморасчетов;
//		
//		ТаблДолгов.СуммаНДС = 0;
//		ТаблДолгов.СуммаНП 	= 0;
//		
//		ТаблДолгов.СтавкаНДС= ПолучитьПустоеЗначение(Перечисление.СтавкиНДС);
//		
//		СписокПараметров.Установить("ЗнакДвижения",1); // увеличение долга клиента
//		глДвижениеДолгов(Контекст, Договор, ТаблДолгов, СписокПараметров, ВремВзаиморасчеты);
//	КонецЦикла;                       
//	
//	СписокПараметров.Установить("ЗнакДвижения",-1);//уменьшение долга подотчетника
//	глОбработкаПроведенияПоПодотчетнику(Контекст,ФизЛицо,Валюта,
//			Итог("Сумма"),
//			глПересчет(Итог("Сумма"),Валюта,Курс,глДоллары,КурсДоллара,Кратность,КратДоллара),
//			глПересчет(Итог("Сумма"),Валюта,Курс,глРубли,КурсРубля,Кратность,КратРубля),
//			СписокПараметров,ВремПодотчетныеЛица);
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
//		"Фирма,Валюта,ФизЛицо")=0 Тогда
//		Возврат;
//	КонецЕсли;
//	
//	Если Валюта = глРубли Тогда
//		РабочийКО = глКО.АвансовыйОтчет;
//	Иначе
//		РабочийКО = глКО.АвансовыйОтчетВал;
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

Процедура ПередЗаписью(Отказ, Режим)
	Сумма_Итог = ТабличнаяЧасть1.Итог("Сумма");
КонецПроцедуры
//
//////////////////////////////////////////////////////////////////////////////////
//// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
