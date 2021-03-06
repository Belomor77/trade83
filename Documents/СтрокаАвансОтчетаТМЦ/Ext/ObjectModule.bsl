﻿Перем РабочийКО;

////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// ВидДолгаПоТМЦ(пВидТМЦ)
//
// Параметры:
//  пВидТМЦ - Перечисление.ВидыТМЦ - вид отгруженного ТМЦ
//
// Возвращаемое значение:
//  Значение перечисления ВидыДолга, соотв. переданному виду ТМЦ
//
// Вызывается из формул элементов диалога:
//
// Описание:
//  По переданному значению вида ТМЦ возвращает соответствующий вид долга отгрузки.
//
Функция ВидДолгаПоТМЦ(пВидТМЦ)
//	
//	Если пВидТМЦ=Перечисление.ВидыТМЦ.Товар Тогда
//		Возврат глВД.ДолгЗаТовары;
//	ИначеЕсли пВидТМЦ=Перечисление.ВидыТМЦ.Материал Тогда
//		Возврат глВД.ДолгЗаМатериалы;
//	Иначе
//		глСообщениеПроведения("Неизвестный вид ТМЦ: "+пВидТМЦ, ТекущийДокумент(),,,1);
//	КонецЕсли;
Возврат "";//	
КонецФункции //ВидДолгаПоТМЦ()

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
//	СписокПараметров.ДобавитьЗначение(Склад,		"Склад");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(ПолучитьПустоеЗначение("Справочник.Контрагенты"),	"Контрагент");
//	СписокПараметров.ДобавитьЗначение(ПолучитьПустоеЗначение("Справочник.Договоры"),		"Договор");
//	
//	СписокПараметров.ДобавитьЗначение(РабочийКО,	"КодОперации");
//	
//	ВремРегистры 		= СоздатьОбъект("Регистры");
//	ВремПодотчетныеЛица = ВремРегистры.ПодотчетныеЛица;
//	глФильтрПодотчетников(Контекст, ФизЛицо, Валюта, СписокПараметров, ВремПодотчетныеЛица);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	
//	глПриходОстатковТМЦ  	(Контекст,ТаблицаДокумента,СписокПараметров);
//	глОприходованиеПартийТМЦ(Контекст,ТаблицаДокумента,СписокПараметров);
//	                                                  
//	ТаблицаДокумента.Свернуть("ВидТМЦ,СтавкаНДС","Сумма,СуммаУпр,СуммаРуб,СуммаНДС,СуммаНП");
//
//	СписокПараметров.ДобавитьЗначение(-1,		"ЗнакДвижения");// уменьшение долга подотчетника
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку()=1 Цикл
//		глОбработкаПроведенияПоПодотчетнику(Контекст,ФизЛицо,Валюта,
//			ТаблицаДокумента.Сумма,
//			ТаблицаДокумента.СуммаУпр,
//			ТаблицаДокумента.СуммаРуб,
//			СписокПараметров,ВремПодотчетныеЛица);
//	КонецЦикла;                                 
//
//	// отразим закупленные ценности по книге покупок
//	// (только если НДС <> 0)  
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку()=1 Цикл
//		Если ПустоеЗначение(ТаблицаДокумента.СтавкаНДС) = 0 Тогда
//			Регистр.КнигаПокупок.КредДокумент	= ТекущийДокумент();
//			Регистр.КнигаПокупок.ВидДолга		= ВидДолгаПоТМЦ(ТаблицаДокумента.ВидТМЦ);
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
//		"Фирма,Склад,Валюта,ФизЛицо")=0 Тогда
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
