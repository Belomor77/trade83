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
	
	Перем ТаблИтогов;
//	
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//	
//	Фирма      = ДокОснование.Фирма; // перезапишем реквизит.
//	Контрагент = ДокОснование.Контрагент; // перезапишем реквизит.
//	Договор    = ДокОснование.Договор; // перезапишем реквизит.
//	
//	Если (ДокОснование.Вид() =  "СчетФактураВыданный") Тогда
//		// формировать запись будем на основании основания СФ
//		Если ДокОснование.ДокОснование.Выбран() = 1 Тогда
//			ДокОсн	= ДокОснование.ДокОснование; // СФ выписана на основании
//		Иначе                                   
//			ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//		КонецЕсли;
//		
//		Если ЗаписьДополнительногоЛиста = 0 Тогда 
//			
//			ВремРегистры = СоздатьОбъект("Регистры");
//			ВремКнигаПродаж = ВремРегистры.КнигаПродаж;
//			ВремКнигаПродаж.УстановитьЗначениеФильтра("КредДокумент",ДокОсн,1);
//			
//			// при необходимости делаем временный расчет итогов
//			Если ИтогиАктуальны() = 0 Тогда
//				ВремКнигаПродаж.ВременныйРасчет();
//				ВремРегистры.Актуальность(1);
//				ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//			КонецЕсли;   
//			
//		КонецЕсли; 
//		
//		ЭтоПогашениеАванса = ДокОснование.СФНаАванс; // Основание - СФ на аванс. Других оснований, кроме СчетФактураВыданный быть не должно.
//	
//	ИначеЕсли (ДокОснование.Вид() =  "КорректировочныйСчетФактура") Тогда
//		
//		Если СводныйСчетФактура = 0 Тогда
//						
//			Если ДокОснование.ДокОснование.Выбран() = 1 Тогда
//				ДокОснСчФ	= ДокОснование.ДокОснование; // СФ выписана на основании
//				Если ДокОснСчФ.ДокОснование.Выбран() = 1 Тогда
//					ДокОсн	= ДокОснСчФ.ДокОснование; // СФ выписана на основании
//				Иначе                                   
//					ДокОсн	= ДокОснСчФ; // "свободная СФ", без документа - основания
//				КонецЕсли;
//			Иначе                                   
//				ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//			КонецЕсли; 
//			
//		Иначе
//		   			
//			ДокОсн = "";
//			
//		КонецЕсли;	
//		
//	ИначеЕсли (ДокОснование.Вид() =  "КорректировочныйСчетФактураПолученный") Тогда
//		Если ДокОснование.ДокОснование.Выбран() = 1 Тогда
//			ДокОснСчФ	= ДокОснование.ДокОснование; // СФ выписана на основании
//			Если ДокОснСчФ.ДокОснование.Выбран() = 1 Тогда
//				ДокОсн	= ДокОснСчФ.ДокОснование; // СФ выписана на основании
//			Иначе                                   
//				ДокОсн	= ДокОснСчФ; // "свободная СФ", без документа - основания
//			КонецЕсли;
//		Иначе                                   
//			ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//		КонецЕсли; 	
//		
//	ИначеЕсли (ДокОснование.Вид() =  "ИсправлениеСчетаФактуры") Тогда
//		
//        Если СводныйСчетФактура = 0 Тогда
//			
//			Если ДокОснование.ДокОснование.Выбран() = 1 Тогда
//				
//				ДокОснСФНач = ДокОснование.ДокОснование;
//				
//				ДокОснСФ = ДокОснСФНач;
//				
//				Пока (ДокОснСФ.Вид() <> "СчетФактураВыданный") и (ДокОснСФ.Вид() <> "СчетФактураПолученный") Цикл
//					Если ДокОснСФ.ДокОснование.Выбран() = 0 Тогда
//						ДокОснСФ = ДокОснСФНач;
//						Прервать;
//					Иначе
//						ДокОснСФ = ДокОснСФ.ДокОснование;
//					КонецЕсли;
//				КонецЦикла;	
//				
//				
//				Если ДокОснСФ.ДокОснование.Выбран() = 1 Тогда
//					ДокОсн	= ДокОснСФ.ДокОснование; // СФ выписана на основании
//				Иначе                                   
//					ДокОсн	= ДокОснСФ; // "свободная СФ", без документа - основания
//				КонецЕсли;
//			Иначе                                   
//				ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//			КонецЕсли;
//
//		Иначе
//		   			
//			ДокОсн = "";
//			
//		КонецЕсли;	
//
//	
//	ИначеЕсли (ДокОснование.Вид() =  "ИсправлениеСчетаФактурыПолученного") Тогда
//				
//		Если ДокОснование.ДокОснование.Выбран() = 1 Тогда
//			
//			ДокОснСФНач = ДокОснование.ДокОснование;
//			
//			ДокОснСФ = ДокОснСФНач;
//			
//			Пока (ДокОснСФ.Вид() <> "СчетФактураВыданный") и (ДокОснСФ.Вид() <> "СчетФактураПолученный") Цикл
//			   	Если ДокОснСФ.ДокОснование.Выбран() = 0 Тогда
//					ДокОснСФ = ДокОснСФНач;
//					Прервать;
//				Иначе
//					ДокОснСФ = ДокОснСФ.ДокОснование;
//				КонецЕсли;
//			КонецЦикла;	
//			
//			
//			Если ДокОснСФ.ДокОснование.Выбран() = 1 Тогда
//				ДокОсн	= ДокОснСФ.ДокОснование; // СФ выписана на основании
//			Иначе                                   
//				ДокОсн	= ДокОснСФ; // "свободная СФ", без документа - основания
//			КонецЕсли;
//		Иначе                                   
//			ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//		КонецЕсли;
//			
//		
//	КонецЕсли;
//                                  
//	ТекДок   = ТекущийДокумент();  
//	РегКнига = Регистр.КнигаПродаж;
//	
//	
//	ВыбратьСтроки();
//	Пока ПолучитьСтроку() = 1 Цикл                                      
//		
//		Если (ДокОснование.Вид() =  "СчетФактураВыданный") Тогда
//			
//			Если ЗаписьДополнительногоЛиста = 0 Тогда 
//				
//				ОстПогСуммаРуб = Сумма;
//				ОстПогСуммаНДС = СуммаНДС;
//				ОстПогСуммаНП  = СуммаНП;
//				
//				ВремКнигаПродаж.УстановитьЗначениеФильтра("СтавкаНДС",СтавкаНДС,1);
//				ВремКнигаПродаж.ВыгрузитьИтоги(ТаблИтогов,1,1);
//				
//				ТаблИтогов.ВыбратьСтроки();
//				Пока (ТаблИтогов.ПолучитьСтроку() = 1) 
//				и ((ОстПогСуммаРуб <> 0) 
//				или (ОстПогСуммаНДС <> 0)
//				или (ОстПогСуммаНП  <> 0)
//				) 
//				Цикл
//					
//					Если ЭтоПогашениеАванса = 0 Тогда // В случае погашения аванса суммы отрицательные
//						
//						ПогашСуммаРуб = Мин(ТаблИтогов.СуммаРуб,ОстПогСуммаРуб);
//						ПогашСуммаНДС = Мин(ТаблИтогов.СуммаНДС,ОстПогСуммаНДС);
//						ПогашСуммаНП  = Мин(ТаблИтогов.СуммаНП ,ОстПогСуммаНП );
//					Иначе
//						ПогашСуммаРуб = Макс(ТаблИтогов.СуммаРуб,ОстПогСуммаРуб);
//						ПогашСуммаНДС = Макс(ТаблИтогов.СуммаНДС,ОстПогСуммаНДС);
//						ПогашСуммаНП  = Макс(ТаблИтогов.СуммаНП ,ОстПогСуммаНП );
//					КонецЕсли;
//					
//					РегКнига.КредДокумент	= ТаблИтогов.КредДокумент;
//					РегКнига.ВидДолга		= ТаблИтогов.ВидДолга;
//					РегКнига.СтавкаНДС		= ТаблИтогов.СтавкаНДС;
//					
//				    РегКнига.СуммаРуб = ПогашСуммаРуб;
//					РегКнига.СуммаНДС = ПогашСуммаНДС;
//					РегКнига.СуммаНП  = ПогашСуммаНП;
//													
//					РегКнига.КодОперации 	= глКО.Прочее;
//					РегКнига.ДокументОплаты = ТекДок;
//					
//					РегКнига.ЗаписьДополнительногоЛиста = ЗаписьДополнительногоЛиста;
//					
//					РегКнига.КорректируемыйПериод       = КорректируемыйПериод;
//					
//					РегКнига.ДвижениеРасходВыполнить();
//					
//					ОстПогСуммаРуб = ОстПогСуммаРуб - ПогашСуммаРуб;
//					ОстПогСуммаНДС = ОстПогСуммаНДС - ПогашСуммаНДС;
//					ОстПогСуммаНП  = ОстПогСуммаНП  - ПогашСуммаНП ;
//				КонецЦикла;	                   
//				
//				Если (ОстПогСуммаРуб > 0) Тогда
//					глНеПроводить(Контекст, "По ставке НДС "+ СтавкаНДС +" указано к погашению
//					| на "+глФРМ(ОстПогСуммаРуб)+" "+глРубли.Наименование+" больше, чем осталось
//					| погасить по счету - фактуре!");
//					Возврат;
//				КонецЕсли;
//				Если (ОстПогСуммаНДС > 0) Тогда
//					глНеПроводить(Контекст, "По ставке НДС "+ СтавкаНДС +" указано к погашению
//					| на "+глФРМ(ОстПогСуммаНДС)+" "+глРубли.Наименование+" больше НДС, чем осталось
//					| погасить по счету - фактуре!");
//					Возврат;
//				КонецЕсли;
//				Если (ОстПогСуммаНП > 0) Тогда
//					глНеПроводить(Контекст, "По ставке НДС "+ СтавкаНДС +" указано к погашению
//					| на "+глФРМ(ОстПогСуммаНП)+" "+глРубли.Наименование+" больше НП, чем осталось
//					| погасить по счету - фактуре!");
//					Возврат;
//				КонецЕсли; 
//			Иначе   
//				
//				РегКнига.КредДокумент	= ДокОсн;
//				РегКнига.ВидДолга		= ВидДолга;
//				РегКнига.СтавкаНДС		= СтавкаНДС;
//				
//				РегКнига.СуммаРуб = Сумма;
//				РегКнига.СуммаНДС = СуммаНДС;
//				РегКнига.СуммаНП  = СуммаНП;
//											
//				РегКнига.КодОперации 	= глКО.Прочее;
//				РегКнига.ДокументОплаты = ТекДок;
//				
//				Если (ЗаписьДополнительногоЛиста = 1) И (РегКнига.СуммаРуб < 0) Тогда
//					РегКнига.ЗаписьДополнительногоЛиста = 2;                         
//				Иначе
//					РегКнига.ЗаписьДополнительногоЛиста = ЗаписьДополнительногоЛиста;
//				КонецЕсли;	
//				
//				РегКнига.КорректируемыйПериод       = КорректируемыйПериод;
//				
//				РегКнига.ДвижениеПриходВыполнить(); 
//				РегКнига.ДвижениеРасходВыполнить(); 
//				
//			КонецЕсли;
//			
//		ИначеЕсли (ДокОснование.Вид() =  "КорректировочныйСчетФактура") Тогда
//			
//			Если СводныйСчетФактура = 1  Тогда
//			    
//				Если СчетФактураОснование.Выбран() = 1 Тогда
//					ДокОснСчФ	= СчетФактураОснование; // СФ выписана на основании
//					Если ДокОснСчФ.ДокОснование.Выбран() = 1 Тогда
//						ДокОсн	= ДокОснСчФ.ДокОснование; // СФ выписана на основании
//					Иначе                                   
//						ДокОсн	= ДокОснСчФ; // "свободная СФ", без документа - основания
//					КонецЕсли;
//				Иначе                                   
//					ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//				КонецЕсли; 
//		
//			КонецЕсли;
//			
//			РегКнига.КредДокумент	= ДокОсн;
//			РегКнига.ВидДолга		= ВидДолга;
//			РегКнига.СтавкаНДС		= СтавкаНДС;
//			
//			РегКнига.СуммаРуб = Сумма;
//			РегКнига.СуммаНДС = СуммаНДС;
//			РегКнига.СуммаНП  = СуммаНП;
//					
//			РегКнига.КодОперации 	= глКО.Прочее;
//			РегКнига.ДокументОплаты = ТекДок;
//			
//			РегКнига.ЗаписьДополнительногоЛиста = ЗаписьДополнительногоЛиста;
//			РегКнига.КорректируемыйПериод       = КорректируемыйПериод;
//			
//			РегКнига.ДвижениеПриходВыполнить(); 
//			РегКнига.ДвижениеРасходВыполнить();
//			
//		ИначеЕсли (ДокОснование.Вид() =  "КорректировочныйСчетФактураПолученный") Тогда
//			
//			РегКнига.КредДокумент	= ДокОсн;
//			РегКнига.ВидДолга		= ВидДолга;
//			РегКнига.СтавкаНДС		= СтавкаНДС;
//			
//			РегКнига.СуммаРуб = Сумма;
//			РегКнига.СуммаНДС = СуммаНДС;
//			РегКнига.СуммаНП  = СуммаНП;
//					
//			РегКнига.КодОперации 	= глКО.Прочее;
//			РегКнига.ДокументОплаты = ТекДок;
//			
//			РегКнига.ЗаписьДополнительногоЛиста = ЗаписьДополнительногоЛиста;
//			РегКнига.КорректируемыйПериод       = КорректируемыйПериод;
//			
//			РегКнига.ДвижениеПриходВыполнить(); 
//			РегКнига.ДвижениеРасходВыполнить();	
//		
//		ИначеЕсли (ДокОснование.Вид() =  "ИсправлениеСчетаФактуры") Тогда
//			
//			Если СводныйСчетФактура = 1  Тогда
//				
//				Если СчетФактураОснование.Выбран() = 1 Тогда
//					
//					ДокОснСФНач = СчетФактураОснование;
//					
//					ДокОснСФ = ДокОснСФНач;
//					
//					Пока (ДокОснСФ.Вид() <> "СчетФактураВыданный") и (ДокОснСФ.Вид() <> "СчетФактураПолученный") Цикл
//						Если ДокОснСФ.ДокОснование.Выбран() = 0 Тогда
//							ДокОснСФ = ДокОснСФНач;
//							Прервать;
//						Иначе
//							ДокОснСФ = ДокОснСФ.ДокОснование;
//						КонецЕсли;
//					КонецЦикла;	
//					
//					
//					Если ДокОснСФ.ДокОснование.Выбран() = 1 Тогда
//						ДокОсн	= ДокОснСФ.ДокОснование; // СФ выписана на основании
//					Иначе                                   
//						ДокОсн	= ДокОснСФ; // "свободная СФ", без документа - основания
//					КонецЕсли;
//				Иначе                                   
//					ДокОсн	= ДокОснование; // "свободная СФ", без документа - основания
//				КонецЕсли;
//				
//			КонецЕсли;
//			
//			РегКнига.КредДокумент	= ДокОсн;
//			РегКнига.ВидДолга		= ВидДолга;
//			РегКнига.СтавкаНДС		= СтавкаНДС;
//			
//			РегКнига.СуммаРуб = Сумма;
//			РегКнига.СуммаНДС = СуммаНДС;
//			РегКнига.СуммаНП  = СуммаНП;
//					
//			РегКнига.КодОперации 	= глКО.Прочее;
//			РегКнига.ДокументОплаты = ТекДок;
//			
//			Если ЗаписьДополнительногоЛиста = 1 Тогда
//				РегКнига.ЗаписьДополнительногоЛиста = 2;                         
//			Иначе
//				РегКнига.ЗаписьДополнительногоЛиста = ЗаписьДополнительногоЛиста;
//			КонецЕсли;	
//			
//			РегКнига.КорректируемыйПериод       = КорректируемыйПериод;
//			
//			Если ЗаписьДополнительногоЛиста = 0 Тогда
//				РегКнига.ДвижениеПриходВыполнить(); 
//			КонецЕсли;	
//				
//			РегКнига.ДвижениеРасходВыполнить(); 
//		
//		ИначеЕсли (ДокОснование.Вид() =  "ИсправлениеСчетаФактурыПолученного")Тогда
//			
//		
//			РегКнига.КредДокумент	= ДокОсн;
//			РегКнига.ВидДолга		= ВидДолга;
//			РегКнига.СтавкаНДС		= СтавкаНДС;
//			
//			РегКнига.СуммаРуб = Сумма;
//			РегКнига.СуммаНДС = СуммаНДС;
//			РегКнига.СуммаНП  = СуммаНП;
//					
//			РегКнига.КодОперации 	= глКО.Прочее;
//			РегКнига.ДокументОплаты = ТекДок;
//			
//			Если ЗаписьДополнительногоЛиста = 1 Тогда
//				РегКнига.ЗаписьДополнительногоЛиста = 2;                         
//			Иначе
//				РегКнига.ЗаписьДополнительногоЛиста = ЗаписьДополнительногоЛиста;
//			КонецЕсли;	
//			
//			РегКнига.КорректируемыйПериод       = КорректируемыйПериод;
//			
//			Если ЗаписьДополнительногоЛиста = 0 Тогда
//				РегКнига.ДвижениеПриходВыполнить(); 
//			КонецЕсли;	
//				
//			РегКнига.ДвижениеРасходВыполнить(); 
//				
//			
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
//		"Фирма,ДокОснование")=0 Тогда 
//		Возврат;
//	КонецЕсли;    
//	
//	Если (ДокОснование.Вид() =  "СчетФактураВыданный") Тогда
//		
//		Если ДокОснование.Проведен()=0 Тогда
//			
//			// Если счет-фактура не проведен, но введен на основании "свернутого"
//			// документа, то запись на основании этого счета фактуры надо проводить
//			МожноПроводить = 0;
//			Если ДокОснование.ДокОснование.Выбран() = 1 Тогда
//				Если глЕстьРеквизитШапки("ФлагСвертки", ДокОснование.ДокОснование.Вид()) = 1 Тогда 
//					МожноПроводить = ДокОснование.ДокОснование.ФлагСвертки;
//				КонецЕсли; 
//			Иначе
//				МожноПроводить = ДокОснование.ФлагСвертки;
//			КонецЕсли;
//			
//			Если МожноПроводить = 0 Тогда
//				глНеПроводить(Контекст, "Документ - основание не проведен!");
//				Возврат;
//			КонецЕсли;                                                           
//		КонецЕсли;                                                               
//		
//		Если (ДокОснование.СФНаАванс = 1) и (ДатаДок > глДатаИзмененияПорядкаВычетаНДССАвансов) И (ЗаписьДополнительногоЛиста = 0) Тогда
//			глНеПроводить(Контекст, "Записи книги продаж нельзя вводить на основании счетов-фактур на аванс, 
//			|после даты вступления в силу Постановленя Правительства РФ №575");
//		КонецЕсли;
//		
//		ПоквартальныйУчет = Фирма.ЮрЛицо.УчитыватьНДСПоквартально.Получить(ДатаДок);
//		
//		Если ПоквартальныйУчет = 0 Тогда
//			Если НачМесяца(ДатаДок) = НачМесяца(ДокОснование.ДатаДок) Тогда
//				ВТомЖеПериоде = 1;
//			Иначе
//				ВТомЖеПериоде = 0;
//			КонецЕсли;
//			
//		Иначе
//			Если НачКвартала(ДатаДок) = НачКвартала(ДокОснование.ДатаДок) Тогда
//				ВТомЖеПериоде = 1;
//			Иначе
//				ВТомЖеПериоде = 0;
//			КонецЕсли;
//			
//		КонецЕсли;
//		
//		Если (ДокОснование.АвтоКнигаПродаж = 1) И (ЗаписьДополнительногоЛиста = 0) И (ВТомЖеПериоде = 1) Тогда
//			глНеПроводить(Контекст, "По выбранному счету - фактуре установлен
//			|автоматический режим формирования книги продаж!");
//			Возврат;
//		КонецЕсли;
//				
//	КонецЕсли;
//	                                             
//	Если (ЗаписьДополнительногоЛиста = 1) И (ПустоеЗначение(КорректируемыйПериод) = 1) Тогда
//		глНеПроводить(Контекст, "Не задан корректируемый период записи доп. листа книги продаж!");
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
КонецПроцедуры
