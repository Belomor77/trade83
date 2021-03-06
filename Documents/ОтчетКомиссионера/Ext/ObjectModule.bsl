﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// ВидДолгаПоСтатусу(СтатусПартии)
//
// Параметры:
//  СтатусПартии - значение перечисления статуса партии
//
// Возвращаемое значение:
//  Значение перечисления видов долга.
//
// Описание:
//  Возвращает вид долга, соответствующий статусу партии.
//
Функция ВидДолгаПоСтатусу(СтатусПартии)
//		
//	Если (СтатусПартии	= глСП.Т_Купленный) или
//		 (СтатусПартии	= глСП.Т_Тара) Тогда
//		Возврат глВД.ДолгЗаТовары;
//		
//	ИначеЕсли СтатусПартии	= глСП.Т_Принятый Тогда
//		Возврат глВД.ДолгЗаТоварыПринятые;
//		
//	ИначеЕсли СтатусПартии	= глСП.Продукция Тогда
//		Возврат глВД.ДолгЗаПродукцию;
//		
//	ИначеЕсли СтатусПартии	= глСП.Полуфабрикат Тогда
//		Возврат глВД.ДолгЗаПолуфабрикаты;
//
//	ИначеЕсли Лев(СтатусПартии.Идентификатор(),2)	= "М_" Тогда
//		Возврат глВД.ДолгЗаМатериалы;
//		
//	Иначе
//		глСообщениеПроведения("Неизвестный статус партии: "+СтатусПартии, ТекущийДокумент(),,,1);
//	КонецЕсли;	
Возврат "";//	
КонецФункции // ВидДолгаПоСтатусу()

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
	
	Перем ТаблСписПартий, ТаблСписПартийКом;
	Перем ВремРегистры;
	Перем ВремПартииОтданные, ВремПокупатели;
//	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//   	
//	ТаблицаДокумента=глПодготовитьТаблицуДокумента(Контекст);
//
//	ФирмаДляОстатковТМЦ = глФирмаДляОстатковТМЦ(Фирма);
//	
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(Контрагент,	"Контрагент");
//	СписокПараметров.ДобавитьЗначение(Договор,		"Договор");
//	СписокПараметров.ДобавитьЗначение(ФирмаДляОстатковТМЦ,"ФирмаДляОстатковТМЦ");
//	
//	СписокПараметров.ДобавитьЗначение(глКО.ОтчетРеализатора,"КодОперации");	
//	                                      
//	ВремРегистры = СоздатьОбъект("Регистры");
//	
//	ВремПартииОтданные = ВремРегистры.ПартииОтданные;
//	глФильтрПартийТМЦ(Контекст,ТаблицаДокумента, СписокПараметров, ВремПартииОтданные);
//	
//	ВремПокупатели = ВремРегистры.Покупатели;
//	глФильтрДолгов(Контекст, Договор, СписокПараметров, ВремПокупатели);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	
//	глСписаниеПартийТМЦ(Контекст,ТаблицаДокумента,СписокПараметров,ВремПартииОтданные,ТаблСписПартий,ТаблСписПартийКом);
//	                            
//	// пропишем обороты продаж
//	ТаблСписПартий.ВыбратьСтроки();
//	Пока ТаблСписПартий.ПолучитьСтроку()=1 Цикл
//		глДвижениеОборотовПродаж(Контекст,
//								Фирма,
//								Контрагент,
//								ТаблСписПартий.Партия.Поставщик,
//								ТаблСписПартий.Номенклатура,
//								ТаблСписПартий.Количество,
//								ТаблСписПартий.СуммаУпр,
//								ТаблСписПартий.СуммаПродУпр);
//	КонецЦикла;
//		
//		
//	ТаблСписПартий.Свернуть("СтатусПартии,СтавкаНП,СтавкаНДС,ДоговорКомитента","СуммаПрод,СуммаПродУпр,СуммаПродРуб,НДСПрод,НППрод,СуммаБезНДС");
//	ТаблСписПартий.НоваяКолонка("КредДокумент");
//	ТаблСписПартий.НоваяКолонка("ВидДолга");
//	ТаблСписПартий.НоваяКолонка("Сумма");
//	ТаблСписПартий.НоваяКолонка("СуммаУпр");
//	ТаблСписПартий.НоваяКолонка("СуммаРуб");
//	ТаблСписПартий.НоваяКолонка("СуммаНДС");
//	ТаблСписПартий.НоваяКолонка("СуммаНП");
//	ТаблСписПартий.НоваяКолонка("Себестоимость");
//	ТаблСписПартий.НоваяКолонка("ОблагаетсяНП");
//	
//	ТаблСписПартий.ВыбратьСтроки();
//	Пока ТаблСписПартий.ПолучитьСтроку()=1 Цикл
//		ТаблСписПартий.КредДокумент = ТекущийДокумент();
//		ТаблСписПартий.ВидДолга		= ВидДолгаПоСтатусу(ТаблСписПартий.СтатусПартии);
//		ТаблСписПартий.Себестоимость= ТаблСписПартий.СуммаБезНДС;
//		ТаблСписПартий.СуммаНДС		= ТаблСписПартий.НДСПрод;
//		ТаблСписПартий.СуммаНП		= ТаблСписПартий.НППрод;
//		ТаблСписПартий.Сумма		= ТаблСписПартий.СуммаПрод;
//		ТаблСписПартий.СуммаУпр		= ТаблСписПартий.СуммаПродУпр;
//		ТаблСписПартий.СуммаРуб		= ТаблСписПартий.СуммаПродРуб;
//		ТаблСписПартий.ОблагаетсяНП = 0;
//	КонецЦикла;                                                                       
//	
//	СписокПараметров.Установить("ЗнакДвижения", 1); // идет увеличение долга
//	глДвижениеДолгов(Контекст,Договор,ТаблСписПартий,СписокПараметров,ВремПокупатели);
//	
//	// запомним, что мы продали принятые на комиссию товары...
//	ТаблСписПартийКом.ВыбратьСтроки();
//	Пока ТаблСписПартийКом.ПолучитьСтроку()=1 Цикл                    
//		Регистр.РеализованныйТовар.Фирма			= ТаблСписПартийКом.Фирма;
//		Регистр.РеализованныйТовар.Договор 			= ТаблСписПартийКом.Партия.ДоговорПоставщика;
//		Регистр.РеализованныйТовар.Номенклатура 	= ТаблСписПартийКом.Номенклатура;
//		Регистр.РеализованныйТовар.Партия 			= ТаблСписПартийКом.Партия;
//		Регистр.РеализованныйТовар.ДокПродажи		= ТекущийДокумент();
//		Регистр.РеализованныйТовар.Количество 		= ТаблСписПартийКом.Количество;
//		Регистр.РеализованныйТовар.ПродСтоимость 	= ТаблСписПартийКом.СуммаПродРуб - ТаблСписПартийКом.НППрод;
//		Регистр.РеализованныйТовар.ДвижениеПриходВыполнить();
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
//		"Фирма,Валюта,Контрагент,Договор")=0 Тогда
//		Возврат;
//	КонецЕсли;
//	
//	// Проверка Номенклатуры
//	ВыбратьСтроки();
//	
//	Пока ПолучитьСтроку() = 1 Цикл
//		
//		Если Номенклатура.ВидНоменклатуры = Перечисление.ВидыНоменклатуры.Услуга Тогда
//			глСообщениеПроведения("В " + НомерСтроки + " строке табличной части указана услуга! Услуги указывать нельзя!", ТекущийДокумент(),,,1);
//			
//		ИначеЕсли Номенклатура.ВидНоменклатуры = Перечисление.ВидыНоменклатуры.Работа Тогда
//			глСообщениеПроведения("В " + НомерСтроки + " строке табличной части указана работа! Работы указывать нельзя!", ТекущийДокумент(),,,1);
//			
//		КонецЕсли;
//	КонецЦикла;
//	
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
КонецПроцедуры
//
//////////////////////////////////////////////////////////////////////////////////
//// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
