﻿////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// СкорректироватьДвиженияПартийПоАвансам()
//
// Параметры:
//  Нет.
//
// Возвращаемое значение:
//  Нет.
//
// Описание:
//  Определяет сумму документа по взаиморасчетам с учетом авансов
//  и корректирует суммы в регистре партий пропорционально
//  сумме документа по табличной части
//
Процедура СкорректироватьДвиженияПартийПоАвансам()
//
//	ОбщаяСуммаДокумента = глПересчет(глОбщаяСуммаДокумента(Контекст), Валюта, Курс, глРубли, 1, Кратность, 1);
//    ОбщаяСуммаПоУчету = 0;
//	
//	РегистрВзаиморасчетов = СоздатьОбъект("Регистр.Поставщики");
//	Если РегистрВзаиморасчетов.ВыбратьДвиженияДокумента(ТекущийДокумент()) = 1 Тогда
//		Пока РегистрВзаиморасчетов.ПолучитьДвижение() = 1 Цикл
//			Если РегистрВзаиморасчетов.КодОперации <> глКО.ТаможенныеПлатежи Тогда
//				Если РегистрВзаиморасчетов.Приход = 1 Тогда
//    	        	 ОбщаяСуммаПоУчету = ОбщаяСуммаПоУчету - РегистрВзаиморасчетов.ОценкаРуб;
//				Иначе
//    	        	 ОбщаяСуммаПоУчету = ОбщаяСуммаПоУчету + РегистрВзаиморасчетов.ОценкаРуб;
//				КонецЕсли;
//			КонецЕсли;
//		КонецЦикла;
//	КонецЕсли;
//
//	Если ОбщаяСуммаПоУчету <> 0 Тогда
//		// если документ не отражается по книгам покупок/продаж, корректировать не надо
//		ТаблицаКорректировкиПартий = глСоздатьТаблицуКорректировкиПартий();
//		
//		глЗаполнитьТаблицуПоДвижениямРегистраПартий(ТаблицаКорректировкиПартий, Контекст);
//		глСкорректироватьСуммыПартий(ТаблицаКорректировкиПартий, ОбщаяСуммаДокумента, ОбщаяСуммаПоУчету, ДатаДок);
//	
//		глЗаписатьДвиженияРегистраПартийПоТаблице(ТаблицаКорректировкиПартий, Контекст);
//	
//	КонецЕсли;
//
КонецПроцедуры // СкорректироватьДвиженияПартийПоАвансам()

//******************************************************************************
// ПроизвестиРаспределение(ТаблицаДокумента)
//
// Параметры:
//  ТаблицаДокумента - подготовленная таблица документа
//
// Возвращаемое значение:
//  0 - если произошла ошибка - надо НеПроводить документ. 1 - если ОК.
//
// Описание:
//  Производит движения по партиям товаров, распределяя суммы доп. расходв
//	по номенклатурным позициям, оприходованным документом поставки.
//
Функция ПроизвестиРаспределение(ТаблицаДокумента)
	Перем РегПартии;
//	
//	РегПартии = СоздатьОбъект("Регистр.ПартииНаличие");
//	
//	ТаблицаПартий = СоздатьОбъект("ТаблицаЗначений");
//	ТаблицаПартий.НоваяКолонка("Фирма");
//	ТаблицаПартий.НоваяКолонка("МОЛ");
//	ТаблицаПартий.НоваяКолонка("Номенклатура");
//	ТаблицаПартий.НоваяКолонка("СтатусПартии");
//	ТаблицаПартий.НоваяКолонка("Партия");
//	ТаблицаПартий.НоваяКолонка("ДатаПартии");
//	ТаблицаПартий.НоваяКолонка("СуммаУпр");
//	ТаблицаПартий.НоваяКолонка("СуммаРуб");
//	ТаблицаПартий.НоваяКолонка("СуммаБезНДС");
//	ТаблицаПартий.НоваяКолонка("ЦенаПрод");
//	
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку()=1 Цикл
//		
//		ТаблицаПартий.УдалитьСтроки();
//		
//		Если ТаблицаДокумента.ДокументПоставки.Выбран()=0 Тогда
//			глНеПроводить(Контекст,"В строке №"+ТаблицаДокумента.НомерСтроки+" не указан документ поставки!");
//			Возврат 0;
//		КонецЕсли;
//		Если ТаблицаДокумента.ДокументПоставки.Проведен()=0 Тогда
//			глНеПроводить(Контекст,"В строке №"+ТаблицаДокумента.НомерСтроки+" указан непроведенный документ поставки!");
//			Возврат 0;
//		КонецЕсли;
//		Если (ТаблицаДокумента.ДокументПоставки.Фирма<>Фирма) Тогда
//			глНеПроводить(Контекст,"В строке №"+ТаблицаДокумента.НомерСтроки+" указан документ, относящийся к другой фирме!");
//			Возврат 0;
//		КонецЕсли;
//		Если (ТаблицаДокумента.ДокументПоставки.Вид() = "ПоступлениеТМЦ") или (ТаблицаДокумента.ДокументПоставки.Вид() = "ПоступлениеТМЦРозница") Тогда
//			Если (ТаблицаДокумента.ДокументПоставки.КодОперации = глКО.ПриемНаРеализацию) 
//			 или (ТаблицаДокумента.ДокументПоставки.КодОперации = глКО.ПриемНаРеализациюРозница) Тогда
//				глНеПроводить(Контекст,"В строке №"+ТаблицаДокумента.НомерСтроки+" указан документ приема на реализацию! 
//				| Дополнительные расходы по приему на реализацию производить нельзя!");
//				Возврат 0;
//			КонецЕсли;
//		КонецЕсли;
//	    
//		ОстСуммаУпр = ТаблицаДокумента.СуммаУпр;
//		ОстСуммаРуб = ТаблицаДокумента.СуммаРуб;
//		ОстСуммаБезНДС = ТаблицаДокумента.СуммаРуб - ТаблицаДокумента.СуммаНДС;
//		
//		РегПартии.ВыбратьДвиженияДокумента(ТаблицаДокумента.ДокументПоставки);
//		Пока РегПартии.ПолучитьДвижение()=1 Цикл
//			Если РегПартии.Приход=1 Тогда
//				ТаблицаПартий.НоваяСтрока();
//				ТаблицаПартий.Фирма			= РегПартии.Фирма;
//				ТаблицаПартий.МОЛ 			= РегПартии.МОЛ;
//				ТаблицаПартий.Номенклатура 	= РегПартии.Номенклатура;
//				ТаблицаПартий.СтатусПартии 	= РегПартии.СтатусПартии;
//				ТаблицаПартий.Партия 		= РегПартии.Партия;
//				ТаблицаПартий.ДатаПартии 	= РегПартии.ДатаПартии;
//				ТаблицаПартий.СуммаУпр 		= РегПартии.СуммаУпр; 
//				ТаблицаПартий.СуммаРуб 		= РегПартии.СуммаРуб;
//				ТаблицаПартий.СуммаБезНДС 	= РегПартии.СуммаБезНДС;
//				ТаблицаПартий.ЦенаПрод	 	= РегПартии.ЦенаПрод;
//			КонецЕсли;
//		КонецЦикла;
//		
//		КоэффРуб = ?(ТаблицаПартий.Итог("СуммаРуб")=0,0,ТаблицаДокумента.СуммаРуб/ТаблицаПартий.Итог("СуммаРуб"));
//		КоэффУпр = ?(ТаблицаПартий.Итог("СуммаУпр")=0,0,ТаблицаДокумента.СуммаУпр/ТаблицаПартий.Итог("СуммаУпр"));
//		КоэффНДС = ?(ТаблицаПартий.Итог("СуммаБезНДС")=0,0,(ТаблицаДокумента.СуммаРуб - ТаблицаДокумента.СуммаНДС)/ТаблицаПартий.Итог("СуммаРуб"));
//		                       
//		Сч = 0;                
//		КолПартий = ТаблицаПартий.КоличествоСтрок();
//		
//		ТаблицаПартий.ВыбратьСтроки();
//		Пока ТаблицаПартий.ПолучитьСтроку()=1 Цикл
//			Сч=Сч+1;
//			Регистр.ПартииНаличие.Фирма 		= ТаблицаПартий.Фирма;
//			Регистр.ПартииНаличие.МОЛ 			= ТаблицаПартий.МОЛ;
//			Регистр.ПартииНаличие.Номенклатура 	= ТаблицаПартий.Номенклатура;
//			Регистр.ПартииНаличие.СтатусПартии 	= ТаблицаПартий.СтатусПартии;
//			Регистр.ПартииНаличие.Партия 		= ТаблицаПартий.Партия;
//			Регистр.ПартииНаличие.ДатаПартии 	= ТаблицаПартий.ДатаПартии;
//			Регистр.ПартииНаличие.ЦенаПрод 		= ТаблицаПартий.ЦенаПрод;
//			Если Сч = КолПартий Тогда
//				Регистр.ПартииНаличие.СуммаУпр 		= ОстСуммаУпр; 
//				Регистр.ПартииНаличие.СуммаРуб 		= ОстСуммаРуб;
//				Регистр.ПартииНаличие.СуммаБезНДС 	= ОстСуммаБезНДС;
//			Иначе     
//				Регистр.ПартииНаличие.СуммаУпр 		= ТаблицаПартий.СуммаУпр	* КоэффУпр; 
//				Регистр.ПартииНаличие.СуммаРуб 		= ТаблицаПартий.СуммаРуб	* КоэффРуб;
//				Регистр.ПартииНаличие.СуммаБезНДС 	= ТаблицаПартий.СуммаРуб	* КоэффНДС;
//			КонецЕсли;
//			
//			// Если мы приходуем доп. расходы по поступлению материалов, то они всегда проводятся как
//			// дополнительные расходы, которые в налоговом учете относятся на себестоимость.
//			// Если мы приходуем товары, то это либо косвенные, либо транспортные расходы (в зависимости
//			// от выбранного вида операции)
//			Если (Лев(ТаблицаПартий.СтатусПартии.Идентификатор(), 2) = "М_")
//			   и (ВидОперации <> Перечисление.КодыОпераций.ДополнительныеРасходыВнереализационные) Тогда
//				Регистр.ПартииНаличие.КодОперации	= Перечисление.КодыОпераций.ДополнительныеРасходы;
//			ИначеЕсли ВидОперации = Перечисление.КодыОпераций.ДополнительныеРасходы Тогда
//				Регистр.ПартииНаличие.КодОперации	= Перечисление.КодыОпераций.ДополнительныеРасходыКосвенные;
//			Иначе
//				Регистр.ПартииНаличие.КодОперации	= ВидОперации; // Транспортные или внереализационные
//			КонецЕсли;
//			
//			Регистр.ПартииНаличие.ДвижениеПриходВыполнить();
//			
//			ОстСуммаУпр 	= ОстСуммаУпр 	- Окр(Регистр.ПартииНаличие.СуммаУпр,2,1);
//			ОстСуммаРуб 	= ОстСуммаРуб 	- Окр(Регистр.ПартииНаличие.СуммаРуб,2,1);
//			ОстСуммаБезНДС 	= ОстСуммаБезНДС- Окр(Регистр.ПартииНаличие.СуммаБезНДС,2,1);
//		КонецЦикла;
//		
//	КонецЦикла;
//	                 
//	Возврат 1;
Возврат "";//	
КонецФункции // ПроизвестиРаспределение()
		
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
	Перем ВремПоставщики;
	Перем ТаблицаДокумента;
//	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//	
//	ТаблицаДокумента=глПодготовитьТаблицуДокумента(Контекст);
//	
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку()=1 Цикл
//		// произведем распределение стоимостей
//		
//		Если ПроизвестиРаспределение(ТаблицаДокумента)=0 Тогда
//			Возврат;
//		КонецЕсли;
//		
//	КонецЦикла;
//	                                  
//	// а теперь - по взаиморасчетам
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(- 1,			"ЗнакДвижения"); // уменьшился долг клиента
//	                              
//	СписокПараметров.ДобавитьЗначение(ВидОперации,"КодОперации");
//	    
//	ВремРегистры = СоздатьОбъект("Регистры");
//	
//	ВремПоставщики = ВремРегистры.Поставщики;
//	глФильтрДолгов(Контекст, Договор, СписокПараметров, ВремПоставщики);
//	
//	Если ИтогиАктуальны() = 0 Тогда
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	                
//	ТаблицаДокумента.Свернуть("СтавкаНДС","Сумма,СуммаУпр,СуммаРуб,СуммаНДС,СуммаНП");
//	ТаблицаДокумента.НоваяКолонка("КредДокумент");
//	ТаблицаДокумента.НоваяКолонка("ВидДолга");
//	
//	ТаблицаДокумента.ВыбратьСтроки();
//	Пока ТаблицаДокумента.ПолучитьСтроку()=1 Цикл
//		
//		ТаблицаДокумента.КредДокумент 	= ТекущийДокумент();
//		ТаблицаДокумента.ВидДолга		= глВД.ДолгЗаУслуги;
//		
//	КонецЦикла;                                                                       
//	
//	глДвижениеДолгов(Контекст,Договор,ТаблицаДокумента,СписокПараметров,ВремПоставщики);
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
//   	Если глВсеРеквизитыДокументаЗаполнены(Контекст,
//		"Фирма,Валюта,Контрагент,Договор")=0 Тогда
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
//	Если ДатаДок >= глДатаПоПриказу147 Тогда
//		СкорректироватьДвиженияПартийПоАвансам();
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
