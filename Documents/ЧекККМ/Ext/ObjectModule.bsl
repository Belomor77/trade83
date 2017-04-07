﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// СписаниеОстатковТМЦ(ТаблНоменклатуры)
//
// Параметры:
//  ТаблНоменклатуры - таблица номенклатуры (должна содержать колонки 
//                     1) "Номенклатура"
//                     2) "Количество"
//                     3) "СуммаРуб"  (для розничного склада)
//                     4) "СкидкаРуб" (для розничного склада)
//
// Возвращаемое значение:
//  Нет
//
// Описание:
//  Проведение списания остатков ТМЦ со склада по регистру "ОстаткиТМЦ"
// без контроля остатков.
//
Процедура СписаниеОстатковТМЦ(ТаблНоменклатуры)
//	
//	РегОстатки = Регистр.ОстаткиТМЦ;
//	
//	ТаблНоменклатуры.ВыбратьСтроки();
//	Пока ТаблНоменклатуры.ПолучитьСтроку()=1 Цикл                        
//		
//		ТекНоменклатура = ТаблНоменклатуры.Номенклатура;
//		
//		Если (ТекНоменклатура.ВидНоменклатуры 	= Перечисление.ВидыНоменклатуры.Услуга)
//		 или (ТекНоменклатура.ВидНоменклатуры 	= Перечисление.ВидыНоменклатуры.Работа)
//		 или (ТаблНоменклатуры.Количество 	= 0) Тогда
//			Продолжить;
//		КонецЕсли;     
//		
//		// Измерения
//		РегОстатки.Фирма			= Фирма;
//		РегОстатки.Склад			= Склад;
//		РегОстатки.Номенклатура		= ТекНоменклатура;
//		
//		// Ресурсы
//		РегОстатки.Количество		= ТаблНоменклатуры.Количество;
//		РегОстатки.ЦенаПрод 		= ТаблНоменклатуры.ЦенаПрод;
//		
//		// Реквизиты
//		РегОстатки.Внутреннее		= 0;
//		
//		РегОстатки.ДвижениеРасходВыполнить();
//		
//	КонецЦикла;
//	
КонецПроцедуры // СписаниеОстатковТМЦ()

//******************************************************************************
// ПроведениеПоРегистрам(ПараметрПроведения)
//
// Параметры:
//  ПараметрПроведения - строка - может принимать значение "НеКонтролироватьОстаткиТМЦ"
//
// Возвращаемое значение:
//  Нет.
//
// Описание:
//  Проведение по регистрам оперативного учета. В случае если ПараметрПроведения
// равен "НеКонтролироватьОстаткиТМЦ" документ проводится без контроля
// отрицательных остатков ТМЦ.
//
Процедура ПроведениеПоРегистрам(ПараметрПроведения)
	
	Перем ВремРегистры;
	Перем ВремОстаткиТМЦ, ВремРезервыТМЦ;                           
	Перем КодОперации;
	Перем ФирмаДляОстатковТМЦ;
//	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//   	
//    ТаблицаУслуг 	    = СоздатьОбъект("ТаблицаЗначений");
//	ТаблицаТМЦ   	    = глПодготовитьТаблицуДокумента(Контекст,1,ТаблицаУслуг);
//	
//	КодОперации 	    = глКО.РозничнаяПродажа;
//	
//    ФирмаДляОстатковТМЦ = глФирмаДляОстатковТМЦ(Фирма);
//	СписокПараметров    = СоздатьОбъект("СписокЗначений");
//	
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),	"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Склад,				"Склад");
//	СписокПараметров.ДобавитьЗначение(Фирма,				"Фирма");
//	СписокПараметров.ДобавитьЗначение(ФирмаДляОстатковТМЦ,  "ФирмаДляОстатковТМЦ");
//	СписокПараметров.ДобавитьЗначение(КодОперации,			"КодОперации");
//	                                          
//	Если ВидОперации = Перечисление.ВидыОперацийЧекККМ.Чек Тогда // продажа
//		
//		Если ПараметрПроведения = "НеКонтролироватьОстаткиТМЦ" Тогда
//			СписаниеОстатковТМЦ(ТаблицаТМЦ);
//		Иначе	
//			ВремРегистры 	= СоздатьОбъект("Регистры");
//			ВремОстаткиТМЦ  = ВремРегистры.ОстаткиТМЦ;
//			ВремРезервыТМЦ  = ВремРегистры.РезервыТМЦ;
//			
//			глФильтрОстатковТМЦ(Контекст,ТаблицаТМЦ,СписокПараметров,ВремОстаткиТМЦ,ВремРезервыТМЦ);
//			
//			Если ИтогиАктуальны()=0 Тогда
//				ВремРегистры.Актуальность(1);
//				ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//			КонецЕсли;
//			
//			// остатки ТМЦ
//			Если глСписаниеОстатковТМЦ	(Контекст,ТаблицаТМЦ,СписокПараметров, ВремОстаткиТМЦ, ВремРезервыТМЦ)=0 Тогда
//				Возврат;
//			КонецЕсли;                                                         
//		КонецЕсли;
//		
//	Иначе // чек на возврат
//    	глПриходОстатковТМЦ	    (Контекст,ТаблицаТМЦ,СписокПараметров);
//	КонецЕсли;
//	
//	// оприходуем деньги в кассу
//	Регистр.Касса.Фирма			= Фирма;
//	Регистр.Касса.Касса 		= Касса;
//	Регистр.Касса.Валюта 		= Валюта;
//		
//	Регистр.Касса.СуммаВал 		= Итог("Сумма");
//	Регистр.Касса.СуммаУпр 		= глПересчет(Итог("Сумма"),Валюта,Курс,глДоллары,ДатаДок,Кратность);
//	Регистр.Касса.СуммаРуб 		= глПересчет(Итог("Сумма"),Валюта,Курс,глРубли,  ДатаДок,Кратность);
//		
//	Регистр.Касса.КодОперации 	= КодОперации;
//		
//	Если ВидОперации = Перечисление.ВидыОперацийЧекККМ.Чек Тогда // продажа
//		Регистр.Касса.ДвижениеПриходВыполнить();
//	Иначе     
//		Регистр.Касса.ДвижениеРасходВыполнить();
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
//	// ПараметрПроведения может принимать значение "НеКонтролироватьОстаткиТМЦ"
//	// (например из обработки On_ams.ert - обработки обслуживания ККМ АМС-100Ф,
//	//  подключенной в режиме On-Line). В этом случае при проведении текущего
//	// документа не выподняется контроль отрицательных остатков ТМЦ.
//	
//	// Проверка заполненности обязательных реквизитов.
//   	Если глВсеРеквизитыДокументаЗаполнены(Контекст,
//		"Фирма,Склад,Валюта,Касса")=0 Тогда 
//		Возврат;
//	КонецЕсли;              
//
//	НеобходимаяСумма = 0;
//	
//	СуществуютНезаполенныеСтроки = 0;
//	ВыбратьСтроки();
//	Пока ПолучитьСтроку() = 1 Цикл
//		НеобходимаяСумма = НеобходимаяСумма + Сумма;
//	    Если ПустоеЗначение(Номенклатура) = 1 Тогда
//	        Сообщить("В строке " + НомерСтроки + " не выбрана номенклатура!","i");
//			СуществуютНезаполенныеСтроки = 1;
//	    КонецЕсли;
//	КонецЦикла;
//	
//	Если СуществуютНезаполенныеСтроки = 1 Тогда
//	    СтатусВозврата(0);
//		Возврат;
//	КонецЕсли;
//	
//	// Проведение по регистрам оперативного учета.	
//	Если (ПустоеЗначение(ПараметрПроведения) = 1) или
//	     (Найти(ПараметрПроведения, "Регистр") <> 0) или
//		 (ПараметрПроведения = "НеКонтролироватьОстаткиТМЦ") Тогда
//		ПроведениеПоРегистрам(ПараметрПроведения);
//		
//		Если СтатусВозврата() = 0 Тогда
//			Возврат;
//		КонецЕсли;
//	КонецЕсли;
//	
//	глПриПроведении(Контекст, ПараметрПроведения);
//	
// 	Если Касса.РежимККМ = Перечисление.РежимыККМ.ФР Тогда
// 		Если глФРВкл = 0 Тогда
// 			глНеПроводить(Контекст, "ККМ в режиме фискального регистратора не подключена!");    
// 		ИначеЕсли Получено < НеобходимаяСумма Тогда
// 			глНеПроводить(Контекст, "Полученной суммы недостаточно для оплаты!");    
// 		ИначеЕсли глФРДляПриемаНаличныхОтЮрЛиц = 1 Тогда
// 			глНеПроводить(Контекст, "ККМ в режиме фискального регистратора предназначена для приема наличных платежей от юр. лиц!");    
// 		КонецЕсли;
// 	КонецЕсли;
//	
КонецПроцедуры //ОбработкаПроведения()

Процедура ПередЗаписью(Отказ, Режим)
	Сумма_Итог = ТабличнаяЧасть1.Итог("Сумма");
КонецПроцедуры
//
//////////////////////////////////////////////////////////////////////////////////
//// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
