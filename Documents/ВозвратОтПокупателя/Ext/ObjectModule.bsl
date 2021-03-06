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
//	ИначеЕсли СтатусПартии	= глСП.Т_ВРознице Тогда
//		Возврат глВД.ДолгЗаТовары;
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
//		глСообщениеПроведения("Неизвестный статус партии: "+СтатусПартии, ТекущийДокумент());
//	КонецЕсли;	
Возврат "";//	
КонецФункции // ВидДолгаПоСтатусу()

//******************************************************************************
// ПеремещениеИзРозницы(ТаблицаДокумента, ТаблСписПартий)
//
// Параметры: 
//  ТаблицаДокумента     - подготовленная таблица документа
//	ТаблСписПартий - партии, списанные по документу 
//
// Возвращаемое значение:
//  Нет
//
// Описание:
// Перемещает из розницы ТМЦ, проданные в розницу и возвращаемые на оптовый склад
//
Процедура ПеремещениеИзРозницы(ТаблицаДокумента, ТаблСписПартий, СписокПараметров)
//	
//	ТаблСписПартий.ВыбратьСтроки();
//	Пока  ТаблСписПартий.ПолучитьСтроку()=1 Цикл
//		Если ТаблСписПартий.СтатусПартии = Перечисление.СтатусыПартии.Т_ВРознице Тогда
//			//измерения
//			Регистр.ПартииНаличие. Фирма 			= Фирма;
//			Регистр.ПартииНаличие. МОЛ				= Склад.МОЛ;
//			Регистр.ПартииНаличие. Номенклатура		= ТаблСписПартий.Номенклатура;     
//			Регистр.ПартииНаличие. СтатусПартии	    = ТаблСписПартий.СтатусПартии;
//			Регистр.ПартииНаличие. КодОперации	    = глКО.ВозвратИзРозницы;  
//			Регистр.ПартииНаличие. Партия			= ТаблСписПартий.Партия;
//			Регистр.ПартииНаличие. ДатаПартии		= ТаблСписПартий.ДатаПартии;
//			
//			// Для определения продажной цены надо получить строку документа
//			ПолучитьСтрокуПоНомеру(ТаблСписПартий.НомерСтрокиДокумента);
//			Регистр.ПартииНаличие. ЦенаПрод			= ТаблСписПартий.ЦенаПрод;
//			
//			// ресурсы
//			Регистр.ПартииНаличие. Количество		= ТаблСписПартий.Количество;
//			Регистр.ПартииНаличие. СуммаУпр			= ТаблСписПартий.СуммаУпр;
//			Регистр.ПартииНаличие. СуммаРуб			= ТаблСписПартий.СуммаРуб;
//			Регистр.ПартииНаличие. СуммаБезНДС		= ТаблСписПартий.СуммаБезНДС;
//			// реквизиты                                          
//			
//			// Передаем из розницы по полной сумме без учета скидки
//			Регистр.ПартииНаличие.ПродСтоимость = ТаблСписПартий.СуммаПродРуб + ТаблСписПартий.СкидкаРуб;
//			
//			Регистр.ПартииНаличие.ПривязыватьСтроку(ТаблСписПартий.НомерСтрокиДокумента);
//			
//			Регистр.ПартииНаличие.Выручка = ТаблСписПартий.СуммаПродРуб - ТаблСписПартий.НДСПрод - ТаблСписПартий.НППрод;
//			
//			Регистр.ПартииНаличие.ДвижениеРасходВыполнить();
//			
//			// Оприходуем партию возврата
//			Регистр.ПартииНаличие. СтатусПартии	= Перечисление.СтатусыПартии.Т_Купленный; 
//			
//			Регистр.ПартииНаличие.ПродСтоимость = ТаблСписПартий.СуммаПродРуб;
//			Регистр.ПартииНаличие.ЦенаПрод	    = 0;
//			
//			Регистр.ПартииНаличие.Выручка = 0;
//			
//			Регистр.ПартииНаличие.ДвижениеПриходВыполнить();   
//		КонецЕсли;	                                                 
//	КонецЦикла;
//	
//	// оприходование
//	СписокПараметров.Установить("Склад", Склад);
//	СписокПараметров.Установить("Фирма", Фирма);
//	
КонецПроцедуры // ПеремещениеИзРозницы()
    

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
//	ТаблСписПартий=СоздатьОбъект("ТаблицаЗначений");
//	ТаблицаУслуг = СоздатьОбъект("ТаблицаЗначений");  
//	
//	Если глЕстьРеквизитШапки("ФлагСвертки", ДокОснование.Вид())=1 Тогда
//		Если ДокОснование.ФлагСвертки = 1 Тогда	
//			КурсРубля = глКурсДляВалюты(глРубли, ДатаДок);
//			КратРубля = глКратностьДляВалюты(глРубли, ДатаДок);
//			
//			ВыбратьСтроки();
//			Пока ПолучитьСтроку()=1 Цикл
//				Если (ПустоеЗначение(ВидСтатус) = 1) Тогда
//					НазначитьТип("ВидСтатус", "Перечисление.ВидыТМЦ");                           
//					ВидСтатус     = Перечисление.ВидыТМЦ.Товар;
//				КонецЕсли;
//				
//				Если (Номенклатура.ВидНоменклатуры <> Перечисление.ВидыНоменклатуры.Услуга)
//				и    (Номенклатура.ВидНоменклатуры <> Перечисление.ВидыНоменклатуры.Работа)
//				и    (Себестоимость = 0)
//				Тогда
//					
//					Себестоимость = глПересчет(Сумма 
//					                           - ?(СуммаВклНДС = 1,СуммаНДС,0)
//											   - ?(СуммаВклНП  = 1,СуммаНП, 0),
//											   Валюта, Курс,
//											   глРубли,КурсРубля,Кратность,КратРубля);
//		            СебестоимостьЦена = ?(Количество = 0, 0, Себестоимость/Количество);
//					СебестоимостьНДС  = глПересчет(СуммаНДС,
//											   Валюта, Курс,
//											   глРубли,КурсРубля,Кратность,КратРубля);
//	
//				КонецЕсли;
//				// Т.К. основания нет, если не выбрана конкретная партия, надо создать новую по возврату
//				Если ПустоеЗначение(Партия) = 1 Тогда
//				    
//					Если ПустоеЗначение(Номенклатура) = 1 Тогда
//				        СтатусВозврата(0);
//						Сообщить("В строке "  + НомерСтроки + " не выбрана номеклатура");
//						Возврат;
//					КонецЕсли;
//					
//					СпрПартии = СоздатьОбъект("Справочник.Партии");
//					СпрПартии.ИспользоватьВладельца(Номенклатура);
//					СпрПартии.Новый();
//					СпрПартии.Записать();           
//					Партия = СпрПартии.ТекущийЭлемент();	
//				КонецЕсли;                                 
//			КонецЦикла;
//		КонецЕсли;
//	КонецЕсли;
//
//	ТаблицаТМЦ   = глПодготовитьТаблицуДокумента(Контекст,1,ТаблицаУслуг);
//	
//	СписокПараметров=СоздатьОбъект("СписокЗначений");
//	
//	СписокПараметров.ДобавитьЗначение(ТекущийДокумент(),"ТекДок");
//	СписокПараметров.ДобавитьЗначение(Склад,		"Склад");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"Фирма");
//	СписокПараметров.ДобавитьЗначение(Фирма,		"ФирмаДляОстатковТМЦ");
//	СписокПараметров.ДобавитьЗначение(Контрагент,	"Контрагент");
//	СписокПараметров.ДобавитьЗначение(Договор,		"Договор");
//	СписокПараметров.ДобавитьЗначение(1,			"ЗнакДвижения");
//	
//	СписокПараметров.ДобавитьЗначение(КодОперации,	"КодОперации");
//	
//	ВремРегистры = СоздатьОбъект("Регистры");
//	Если КодОперации = Перечисление.КодыОпераций.ВозвратОтРеализатора Тогда
//		ВремПартииОтданные = ВремРегистры.ПартииОтданные;
//		глФильтрПартийТМЦ(Контекст,ТаблицаТМЦ, СписокПараметров, ВремПартииОтданные);
//	Иначе
//		ВремПокупатели = ВремРегистры.Покупатели;
//		глФильтрДолгов(Контекст, Договор, СписокПараметров, ВремПокупатели);
//	КонецЕсли;                        
//	
//	Если ИтогиАктуальны() = 0 Тогда   
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;
//	
//	глПриходОстатковТМЦ	(Контекст,ТаблицаТМЦ,СписокПараметров);
//	
//	Если (КодОперации=Перечисление.КодыОпераций.ВозвратОтПокупателя)
//	 или (КодОперации=Перечисление.КодыОпераций.ВозвратОтПокупателяЕНВД) Тогда
//		
//		глОприходованиеПартийТМЦВозврат(Контекст,ТаблицаТМЦ,СписокПараметров,ТаблСписПартий,ТаблСписПартийКом);
//		
//		// Если мы возвращаем товар, проданный в рознице не на розничный склад, то его нужно вернуть из розницы
//		Если Склад.РозничныйСклад = 0 Тогда
//			ПеремещениеИзРозницы(ТаблицаТМЦ,ТаблСписПартий, СписокПараметров);
//		КонецЕсли; 
//
//		// обороты продаж - в минус
//		ТаблСписПартий.ВыбратьСтроки();
//		Пока ТаблСписПартий.ПолучитьСтроку()=1 Цикл
//			глДвижениеОборотовПродаж(Контекст,
//									Фирма,
//									Контрагент,
//									ТаблСписПартий.Партия.Поставщик,
//									ТаблСписПартий.Номенклатура,
//									-ТаблСписПартий.Количество,
//									-ТаблСписПартий.СуммаУпр,
//									-ТаблСписПартий.СуммаПродУпр);
//		КонецЦикла;
//		
//		ТаблСписПартий.Свернуть("СтатусПартии,СтавкаНП,СтавкаНДС,ДоговорКомитента","СуммаПрод,СуммаПродУпр,СуммаПродРуб,НДСПрод,НППрод,СуммаБезНДС");
//		ТаблСписПартий.НоваяКолонка("КредДокумент");
//		ТаблСписПартий.НоваяКолонка("ВидДолга");
//		ТаблСписПартий.НоваяКолонка("Сумма");
//		ТаблСписПартий.НоваяКолонка("СуммаУпр");
//		ТаблСписПартий.НоваяКолонка("СуммаРуб");
//		ТаблСписПартий.НоваяКолонка("СуммаНДС");
//		ТаблСписПартий.НоваяКолонка("СуммаНП");
//		ТаблСписПартий.НоваяКолонка("Себестоимость");
//		ТаблСписПартий.НоваяКолонка("ОблагаетсяНП");
//		
//		ТаблСписПартий.ВыбратьСтроки();
//		Пока ТаблСписПартий.ПолучитьСтроку()=1 Цикл
//			ТаблСписПартий.КредДокумент = ТекущийДокумент();
//			ТаблСписПартий.ВидДолга		= ВидДолгаПоСтатусу(ТаблСписПартий.СтатусПартии);
//			ТаблСписПартий.Себестоимость= ТаблСписПартий.СуммаБезНДС;
//			ТаблСписПартий.СуммаНДС		= ТаблСписПартий.НДСПрод;
//			ТаблСписПартий.СуммаНП		= ТаблСписПартий.НППрод;
//			ТаблСписПартий.Сумма		= ТаблСписПартий.СуммаПрод;
//			ТаблСписПартий.СуммаУпр		= ТаблСписПартий.СуммаПродУпр;
//			ТаблСписПартий.СуммаРуб		= ТаблСписПартий.СуммаПродРуб;
//			ТаблСписПартий.ОблагаетсяНП = УчитыватьНП;
//		КонецЦикла;                                                                       
//		                                                            
//		СписокПараметров.Установить("ЗнакДвижения", - 1); // идет уменьшение долга
//		глДвижениеДолгов(Контекст, Договор, ТаблСписПартий,СписокПараметров,ВремПокупатели);
//		                              
//		// запомним, что мы вернули принятые на комиссию товары...
//		ТаблСписПартийКом.ВыбратьСтроки();
//		Пока ТаблСписПартийКом.ПолучитьСтроку()=1 Цикл                    
//			Регистр.РеализованныйТовар.Фирма 			= ТаблСписПартийКом.Фирма;
//			Регистр.РеализованныйТовар.Договор 			= ТаблСписПартийКом.Партия.ДоговорПоставщика;
//			Регистр.РеализованныйТовар.Номенклатура 	= ТаблСписПартийКом.Номенклатура;
//			Регистр.РеализованныйТовар.Партия 			= ТаблСписПартийКом.Партия;
//			Регистр.РеализованныйТовар.ДокПродажи		= ТекущийДокумент();
//			Регистр.РеализованныйТовар.Количество 		= - ТаблСписПартийКом.Количество;
//			Регистр.РеализованныйТовар.ПродСтоимость 	= - (ТаблСписПартийКом.СуммаПродРуб - ТаблСписПартийКом.НППрод);
//			Регистр.РеализованныйТовар.ДвижениеПриходВыполнить();
//		КонецЦикла;      
//		
//		// реализация услуг   
//		глДвижениеПартийУслуг(Контекст, ТаблицаУслуг, СписокПараметров, 1);
//		
//		// сначала уменьшим обороты продаж по услугам и работам
//		ТаблицаУслуг.ВыбратьСтроки();
//		Пока ТаблицаУслуг.ПолучитьСтроку()=1 Цикл
//			глДвижениеОборотовПродаж(Контекст,
//									Фирма,
//									Контрагент,
//									"",
//									ТаблицаУслуг.Номенклатура,
//									-ТаблицаУслуг.Количество,
//									0,
//									-ТаблицаУслуг.СуммаУпр);
//		КонецЦикла;
//		
//		// теперь задолженность покупателя за отпущенные услуги или работы
//		СписокПараметров.Установить("ЗнакДвижения",-1); // уменьшился долг клиента
//		
//		ТаблицаУслуг.Свернуть("Вид,СтавкаНДС,СтавкаНП","Сумма,СуммаУпр,СуммаРуб,СуммаНДС,СуммаНП");
//		
//		ТаблицаУслуг.НоваяКолонка("КредДокумент");
//		ТаблицаУслуг.НоваяКолонка("ВидДолга");
//		ТаблицаУслуг.НоваяКолонка("Себестоимость");
//		ТаблицаУслуг.НоваяКолонка("ДоговорКомитента");
//		ТаблицаУслуг.НоваяКолонка("ОблагаетсяНП");
//	
//		ТаблицаУслуг.ВыбратьСтроки();
//		Пока ТаблицаУслуг.ПолучитьСтроку()=1 Цикл
//		
//			ТаблицаУслуг.КредДокумент 	= ТекущийДокумент();
//
//			Если ТаблицаУслуг.Вид = Перечисление.ВидыНоменклатуры.Услуга Тогда
//				ТаблицаУслуг.ВидДолга		= глВД.ДолгЗаУслуги;
//			Иначе
//				ТаблицаУслуг.ВидДолга		= глВД.ДолгЗаРаботы;
//			КонецЕсли;
//
//			ТаблицаУслуг.Себестоимость	= 0;
//			ТаблицаУслуг.ОблагаетсяНП 	= УчитыватьНП;
//		
//		КонецЦикла;                                                                       
//	    глДвижениеДолгов(Контекст, Договор, ТаблицаУслуг, СписокПараметров, ВремПокупатели);
//		
//	Иначе // отданные на реализацию возвращаем
//		глСписаниеПартийТМЦ(Контекст,ТаблицаТМЦ,СписокПараметров,ВремПартииОтданные, ТаблСписПартий);
//		    
//		ТаблСписПартий.ВыбратьСТроки();
//		Пока  ТаблСписПартий.ПолучитьСтроку()=1 Цикл
//			Регистр.ПартииНаличие.ПривязыватьСтроку(ТаблСписПартий.НомерСтрокиДокумента);
//
//			//измерения
//			Регистр.ПартииНаличие. Фирма 			= Фирма;
//			Регистр.ПартииНаличие. МОЛ				= Склад.МОЛ;
//			Регистр.ПартииНаличие. Номенклатура		= ТаблСписПартий.Номенклатура;
//			Регистр.ПартииНаличие. СтатусПартии		= ТаблСписПартий.СтатусПартии;
//
//			МетодРасчетаСебестоимости = Фирма.ЮрЛицо.МетодРасчетаСебестоимости.Получить(ДатаДок);   
//
//			Если (МетодРасчетаСебестоимости <> Перечисление.МетодыРасчетаСебестоимости.FIFO)
//			   и (МетодРасчетаСебестоимости <> Перечисление.МетодыРасчетаСебестоимости.LIFO) Тогда 
//				Регистр.ПартииНаличие.Партия  		= ПолучитьПустоеЗначение("Справочник.Партии");
//				Регистр.ПартииНаличие.ДатаПартии	= "";
//			Иначе
//				Регистр.ПартииНаличие.Партия		= ТаблСписПартий.Партия;
//				Регистр.ПартииНаличие.ДатаПартии	= ДатаДок;
//			КонецЕсли;
//
//			// ресурсы
//			Регистр.ПартииНаличие. Количество		= ТаблСписПартий.Количество;
//			Регистр.ПартииНаличие. СуммаУпр			= ТаблСписПартий.СуммаУпр;
//			Регистр.ПартииНаличие. СуммаРуб			= ТаблСписПартий.СуммаРуб;
//			Регистр.ПартииНаличие. СуммаБезНДС		= ТаблСписПартий.СуммаБезНДС;
//
//			// реквизиты
//			Регистр.ПартииНаличие. КодОперации		= глКО.ВозвратОтРеализатора;
//			
//			Регистр.ПартииНаличие.ДвижениеПриходВыполнить();
//		КонецЦикла;
//		
//		// проверим, а не указал ли услуги или работы - их отдавать на релизацию нельзя
//		ТаблицаУслуг.ВыбратьСтроки();
//		Если ТаблицаУслуг.ПолучитьСтроку()= 1 Тогда
//			глНеПроводить(Контекст,"Услуги возвращать от комиссионера невозможно! ("+ТаблицаУслуг.Номенклатура+")");
//			Возврат;
//		КонецЕсли;
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
//	Если ДокОснование.Выбран() = 1 Тогда
//		Если ДокОснование.ФлагСвертки = 1 Тогда
//			Возврат;
//		КонецЕсли;
//	КонецЕсли;
//	
//	// Проверка заполненности обязательных реквизитов.
//	Если глВсеРеквизитыДокументаЗаполнены(Контекст,
//		"Фирма,Склад,Валюта,Контрагент,Договор")=0 Тогда
//		Возврат;
//	КонецЕсли;  
//	    
//	// проверка: на основании реализационного документа нельзя  вводить
//	// документ купли - продажи и наоборот
//	Если ДокОснование.Выбран() = 1 Тогда                        
//		НельзяВводить = 0;
//		Если ДокОснование.Вид() = "Реализация"	Тогда
//			Если (   (ДокОснование.КодОперации = глКО.ПередачаНаРеализацию)
//			      и  (( КодОперации  = глКО.ВозвратОтПокупателя) или ( КодОперации  = глКО.ВозвратОтПокупателяЕНВД) ))
//			или  (   (ДокОснование.КодОперации = глКО.Продажа)
//			      и  (КодОперации  = глКО.ВозвратОтРеализатора))
//			Тогда     
//				НельзяВводить = 1;
//			КонецЕсли;  
//		ИначеЕсли КодОперации  = глКО.ВозвратОтРеализатора Тогда // остались только нереализационные основания
//			НельзяВводить = 1;
//		КонецЕсли;
//		Если НельзяВводить = 1 Тогда
//			глНеПроводить(Контекст,"На основании документа """+глНазваниеДокументаВЖурнале(ДокОснование)+"""
//			|нельзя вводить """ + глНазваниеДокументаВЖурнале(Контекст) + """!");
//			Возврат;
//		КонецЕсли;  
//	КонецЕсли;
//	
//	// Облагаться ЕНВД может только возврат на розничный склад
//	Если ОблагаетсяЕНВД = 1 Тогда
//		Если КодОперации  <> глКО.ВозвратОтПокупателяЕНВД Тогда
//			глНеПроводить(Контекст,"Код операции не соответствует флагу учета ЕНВД!"); 
//			Возврат;
//	    КонецЕсли;
//	КонецЕсли;
//	
//	// Проверка на достаточное количество отгруженных товаров по док основанию с учетом других возвратов
//    Если ДокОснование.Выбран() = 1 Тогда
//		
//		ТаблицаТоваров = СоздатьОбъект("ТаблицаЗначений");
//		ВыгрузитьТабличнуюЧасть(ТаблицаТоваров, "Номенклатура, Количество, Коэффициент");
//	
//		ТаблицаТоваров.ВыбратьСтроки();
//	
//		Пока ТаблицаТоваров.ПолучитьСтроку() = 1 Цикл
//			ТаблицаТоваров.Количество = ТаблицаТоваров.Количество * ТаблицаТоваров.Коэффициент;
//		КонецЦикла;
//
//		ТаблицаТоваров.Свернуть("Номенклатура", "Количество");
//        Возвраты = СоздатьОбъект("Документ");
//		
//		Если Возвраты.ВыбратьПодчиненныеДокументы(ДокОснование.ДатаДок, ДатаДок, ДокОснование) = 1 Тогда
//			Пока Возвраты.ПолучитьДокумент() = 1 Цикл
//				Если Возвраты.Вид() = "ВозвратОтПокупателя" Тогда
//					Если (Возвраты.Проведен() = 1) И (Возвраты.ТекущийДокумент() <> ТекущийДокумент()) Тогда
//						Если Возвраты.ВыбратьСтроки() = 1 Тогда
//							Пока Возвраты.ПолучитьСтроку() = 1 Цикл
//								СтрокаТовара = 0;
//								КолонкаТовара = 1;
//								Если ТаблицаТоваров.НайтиЗначение(Возвраты.Номенклатура, СтрокаТовара, КолонкаТовара) = 1 Тогда
//									ТаблицаТоваров.УстановитьЗначение(СтрокаТовара, 2, ТаблицаТоваров.ПолучитьЗначение(СтрокаТовара,2) + Возвраты.Количество * Возвраты.Коэффициент);
//								КонецЕсли;
//							КонецЦикла;
//						КонецЕсли;
//					КонецЕсли;
//				КонецЕсли;
//			КонецЦикла;
//		КонецЕсли;
//    
//		ТаблицаОснования = СоздатьОбъект("ТаблицаЗначений");
//		
//		ДокОснование.ВыгрузитьТабличнуюЧасть(ТаблицаОснования, "Номенклатура, Количество, Коэффициент");
//	 	
//		ТаблицаОснования.ВыбратьСтроки();
//	
//		Пока ТаблицаОснования.ПолучитьСтроку() = 1 Цикл
//			ТаблицаОснования.Количество = ТаблицаОснования.Количество * ТаблицаОснования.Коэффициент;
//		КонецЦикла;
//		
//		ТаблицаОснования.Свернуть("Номенклатура", "Количество");
//	
//		ТаблицаТоваров.ВыбратьСтроки();
//		Пока ТаблицаТоваров.ПолучитьСтроку() = 1 Цикл
//			
//			СтрокаОснования = 0;
//
//			Если ТаблицаОснования.НайтиЗначение(ТаблицаТоваров.Номенклатура, СтрокаОснования, 1) = 1 Тогда
//				Если ТаблицаТоваров.Количество > ТаблицаОснования.ПолучитьЗначение(СтрокаОснования,2) Тогда
//					Сообщение = "По " + ДокОснование + " возвращено больше, чем отпущено " + ТаблицаТоваров.Номенклатура;
//					глСообщениеПроведения(Сообщение , ТекущийДокумент(), 1,,1);
//					
//				КонецЕсли;
//		
//			Иначе
//				Сообщение = "По " + ДокОснование + " не отпускалось " + ТаблицаТоваров.Номенклатура;
//				глСообщениеПроведения(Сообщение , ТекущийДокумент(), 1,,1);
//				
//			КонецЕсли;
//			
//		КонецЦикла;
//		
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
