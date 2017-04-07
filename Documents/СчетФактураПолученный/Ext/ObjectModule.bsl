﻿////////////////////////////////////////////////////////////////////////////////
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
//	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//   	
//	ТекДок   = ТекущийДокумент();
//	РегКнига = Регистр.КнигаПокупок;
//	
//	ВыбратьСтроки();
//	Пока ПолучитьСтроку() = 1 Цикл
//		РегКнига.КредДокумент	= ?(СФНаАванс = 1,?(ДокОснование.Выбран() = 1, ДокОснование, ТекДок),ТекДок);
//		Если (СФНаАванс = 1) И (ОтражатьВсеСуммыКакАванс = 1) Тогда
//			РегКнига.ВидДолга		= глВД.Аванс;
//        Иначе
//			РегКнига.ВидДолга		= ВидДолга;
//			
//		КонецЕсли;
//		
//		РегКнига.СтавкаНДС		= СтавкаНДС;
//			
//		РегКнига.СуммаРуб       = Сумма;
//		РегКнига.СуммаНДС       = СуммаНДС;
//		РегКнига.СуммаНП        = 0;
//			
//		РегКнига.КодОперации 	= глКО.Прочее;
//		РегКнига.ДокументОплаты = "";
//			
//		РегКнига.ДвижениеРасходВыполнить();
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
//	Валюта    = глРубли;
//	Курс      = 1;
//    Кратность = 1;
//	
//	Если ДокОснование.Выбран() = 1 Тогда
//		Фирма  = ДокОснование.Фирма; // перезапишем реквизит.    
//		ВидОсн = ДокОснование.Вид();
//		Если глЕстьРеквизитШапки("Валюта",ВидОсн) = 1 Тогда
//		    Валюта    = ДокОснование.Валюта;    
//			Курс 	  = ДокОснование.Курс;
//			Кратность = ДокОснование.Кратность;
//		КонецЕсли;
//	КонецЕсли;
//	
//	// Проверка заполненности обязательных реквизитов.
//	Если глВсеРеквизитыДокументаЗаполнены(Контекст,
//		"Фирма,Контрагент,Договор")=0 Тогда 
//		Возврат;
//	КонецЕсли;     
//	
//	ПозицияГП  = Последовательность.КнигаПокупок.ПолучитьПозицию();
//	ПозицияДок = ПолучитьПозицию();
//	Последовательность.КнигаПокупок.Установить(?(ПозицияГП<ПозицияДок,ПозицияГП,ПозицияДок));
//	
//	Если ДокОснование.Проведен()=0 Тогда
//		глНеПроводить(Контекст, "Документ - основание не проведен!");
//		Возврат;
//	КонецЕсли;
//
//	// Если НДС был проведен документом оприходования, ничего не делаем
//	Если (ДокОснование.Выбран() = 0) ИЛИ (СФНаАванс = 1) Тогда
//		
//		// Проведение по регистрам оперативного учета.	
//		Если (ПустоеЗначение(ВидыДвижений) = 1) ИЛИ (Найти(ВидыДвижений, "Регистр") <> 0) Тогда
//			ПроведениеПоРегистрам();
//			
//			Если СтатусВозврата() = 0 Тогда
//				Возврат;
//			КонецЕсли;
//		КонецЕсли;
//	КонецЕсли;
//	
//	глПриПроведении(Контекст, ВидыДвижений);
//	
КонецПроцедуры //ОбработкаПроведения()

Процедура ПередЗаписью(Отказ, Режим)
	Сумма_Итог = ТабличнаяЧасть1.Итог("Сумма");
	СуммаНДС_Итог = ТабличнаяЧасть1.Итог("СуммаНДС");
	СуммаБезНДС_Итог = ТабличнаяЧасть1.Итог("СуммаБезНДС");
КонецПроцедуры
//
//////////////////////////////////////////////////////////////////////////////////
//// ОПЕРАТОРЫ ОСНОВНОЙ ПРОГРАММЫ
