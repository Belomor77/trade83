﻿Перем РабочийКО;

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
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
	
	Перем ВремРегистры;
	Перем ВремПодотчетныеЛица;
	Перем ТаблицаДокумента;
//   	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//	
//	Если Валюта = глРубли Тогда
//		РабочийКО = глКО.АвансовыйОтчет;
//	Иначе
//		РабочийКО = глКО.АвансовыйОтчетВал;
//	КонецЕсли;
//	
//	ТаблицаДокумента=глПодготовитьТаблицуДокумента(Контекст);
//	                  
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(РабочийКО,	"КодОперации");
//    
//	// подготовка к расчету итогов
//	ВремРегистры 		= СоздатьОбъект("Регистры");
//	ВремПодотчетныеЛица = ВремРегистры.ПодотчетныеЛица;
//	
//	// установка фильтров, флагов временного расчета у регистров
//	глФильтрПодотчетников(Контекст, ФизЛицо, Валюта, СписокПараметров, ВремПодотчетныеЛица);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	
//	КурсДоллара	= глКурсДляВалюты(глДоллары,ДатаДок);
//	КратДоллара = глКратностьДляВалюты(глДоллары,ДатаДок);
//	КурсРубля	= глКурсДляВалюты(глРубли,ДатаДок);
//	КратРубля   = глКратностьДляВалюты(глРубли,ДатаДок);
//    	
//	СписокПараметров.Установить("ЗнакДвижения",-1);//уменьшение долга подотчетника
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку() = 1 Цикл
//		ПривязыватьСтроку(ТаблицаДокумента.НомерСтрокиДокумента);
//		глОбработкаПроведенияПоПодотчетнику(Контекст,ФизЛицо,Валюта,
//				ТаблицаДокумента.Сумма,
//				ТаблицаДокумента.СуммаУпр,
//				ТаблицаДокумента.СуммаРуб,
//				СписокПараметров,ВремПодотчетныеЛица);
//	КонецЦикла;
//                                
//	// отразим закупленные ценности по книге покупок
//	// (только если НДС <> 0)
//	//ТаблицаДокумента.Свернуть("СтавкаНДС","СуммаРуб, СуммаНДС, СуммаНП");
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку()=1 Цикл
//		Если ПустоеЗначение(ТаблицаДокумента.СтавкаНДС) = 0 Тогда
//			Регистр.КнигаПокупок.ПривязыватьСтроку(ТаблицаДокумента.НомерСтрокиДокумента);   
//			
//			Регистр.КнигаПокупок.КредДокумент	= ТекущийДокумент();
//			Регистр.КнигаПокупок.ВидДолга		= глВД.ДолгЗаУслуги;
//			Регистр.КнигаПокупок.СтавкаНДС		= ТаблицаДокумента.СтавкаНДС;   
//			
//			Регистр.КнигаПокупок.СуммаРуб       = ТаблицаДокумента.СуммаРуб;
//			Регистр.КнигаПокупок.СуммаНДС       = ТаблицаДокумента.СуммаНДС;
//			Регистр.КнигаПокупок.СуммаНП        = ТаблицаДокумента.СуммаНП;
//			
//			Регистр.КнигаПокупок.КодОперации	= РабочийКО;
//			
//			Регистр.КнигаПокупок.ДвижениеРасходВыполнить();
//		КонецЕсли;
//		
//	КонецЦикла;                                                                       
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
	СуммаНДС_Итог = ТабличнаяЧасть1.Итог("СуммаНДС");
	СуммаНП_Итог = ТабличнаяЧасть1.Итог("СуммаНП");
КонецПроцедуры
//
//////////////////////////////////////////////////////////////////////////////////
//// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
