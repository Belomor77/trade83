﻿////////////////////////////////////////////////////////////////////////////////
// ПЕРЕМЕННЫЕ МОДУЛЯ
//
////////////////////////////////////////////////////////////////////////////////
// ПРОЦЕДУРЫ И ФУНКЦИИ МОДУЛЯ
//
//******************************************************************************
// ОпределитьСтавкуНДС(Сумма, СуммаНДС)
//
// Параметры:
//  Сумма    - Сумма с НДС
//  СуммаНДС - Сумма НДС
//
// Возвращаемое значение:
//  Предполагаемую ставку НДС
//
// Описание:
//  По сумме с НДС и НДС определяет ставку
//
Функция ОпределитьСтавкуНДС(Сумма, СуммаНДС)
//
//	Если СуммаНДС = 0 Тогда
//		Возврат  Перечисление.СтавкиНДС.БезНДС;
//	КонецЕсли;
//	
//	Если Сумма <= СуммаНДС Тогда
//		Сообщить("Невозможно определить ставку НДС! Необходимо сделать коррекцию вручную. Сумма с НДС = " + Сумма + " ; НДС = " + СуммаНДС);
//		Возврат  Перечисление.СтавкиНДС.БезНДС;
//	КонецЕсли;
//	
//	ДоляНДС = СуммаНДС/(Сумма - СуммаНДС);
//	
//	Если ДоляНДС < 0.05 Тогда
//		Возврат Перечисление.СтавкиНДС.БезНДС;
//	ИначеЕсли  ДоляНДС < 0.14 Тогда
//		Возврат Перечисление.СтавкиНДС.НДС10;
//	ИначеЕсли ДоляНДС < 0.19  Тогда
//		Возврат Перечисление.СтавкиНДС.НДС18;
//	ИначеЕсли ДоляНДС < 0.25   Тогда
//		Возврат Перечисление.СтавкиНДС.НДС20;
//	Иначе
//    	Возврат  Перечисление.СтавкиНДС.БезНДС;
//		Сообщить("Невозможно определить ставку НДС! Необходимо сделать коррекцию вручную. Сумма с НДС = " + Сумма + " ; НДС = " + СуммаНДС);
//	КонецЕсли;
Возврат "";//	
КонецФункции
 
//******************************************************************************
// ПроведениеПоРегистрам(ВидыДвижений)
//
// Параметры:
//  ВидыДвижений - строка с видами движений (параметр проведения)
//
// Возвращаемое значение:
//  Нет.
//
// Описание:
//  Проведение по регистрам оперативного учета.
//
Процедура ПроведениеПоРегистрам(ВидыДвижений)
                                   
	Перем Запрос, ТекстЗапроса;
	Перем Рег;
	Перем ДатаНач, ПериодПо, ТекДок;
	Перем Таб;   
	Перем ТаблИтогов;
//	                    
//	// Удаление движений по регистрам.
//	Для Номер = 1 По Метаданные.Регистр() Цикл
//		ОчиститьДвижения("Регистр."+Метаданные.Регистр(Номер).Идентификатор);
//	КонецЦикла;
//    
//	ТаблИтогов= СоздатьОбъект("ТаблицаЗначений");
//	ТаблИтогов.НоваяКолонка("Поставщик");
//	ТаблИтогов.НоваяКолонка("НДС19","Число","19","2");
//	ТаблИтогов.НоваяКолонка("НДС68","Число","19","2");
//	                                 
//	ДатаНач = НачМесяца(ДатаДок);
//	ТекДок  = ТекущийДокумент();
//	
//	// определение периода построения запросов
//	Если ИтогиАктуальны() = 1 Тогда
//		ПериодПо = "";
//	Иначе
//		ПериодПо = "по ТекДок";
//	КонецЕсли;                   
//	
//	//Создание объекта типа Запрос
//	Запрос = СоздатьОбъект("Запрос");
//	ТекстЗапроса = 
//	"//{{ЗАПРОС(НДСРозницы)
//	|Период с ДатаНач "+ПериодПо+";
//	|ФирмаПартии  = Регистр.ПартииНаличие.Фирма;
//	|ПрихДокумент = Регистр.ПартииНаличие.Партия.ПриходныйДокумент;
//	|Поставщик    = Регистр.ПартииНаличие.Партия.Поставщик;
//	|Партия       = Регистр.ПартииНаличие.Партия;
//	|СтатусПартии = Регистр.ПартииНаличие.СтатусПартии;
//	|СуммаРуб 	  = Регистр.ПартииНаличие.СуммаРуб;
//	|СуммаБезНДС  = Регистр.ПартииНаличие.СуммаБезНДС;
//	|КодОперации  = Регистр.ПартииНаличие.КодОперации;
//	|Функция      СуммаРубРасход     = Расход(СуммаРуб)    когда (КодОперации  =  глКО.РозничнаяПродажаЕНВД);
//	|Функция      СуммаБезНДСРасход  = Расход(СуммаБезНДС) когда (КодОперации  =  глКО.РозничнаяПродажаЕНВД);
//	|Функция      СуммаРубВозврат    = Приход(СуммаРуб)    когда (КодОперации  =  глКО.ВозвратОтПокупателяЕНВД);
//	|Функция      СуммаБезНДСВозврат = Приход(СуммаБезНДС) когда (КодОперации  =  глКО.ВозвратОтПокупателяЕНВД);
//	|Группировка Поставщик без Групп;
//	|Группировка ПрихДокумент;
//	|Группировка Партия;
//	|Условие (ФирмаПартии  =  Фирма);
//    |Условие ((КодОперации  =  глКО.РозничнаяПродажаЕНВД) или (КодОперации  =  глКО.ВозвратОтПокупателяЕНВД));
//	|Условие (СтатусПартии <> глСП.Т_Принятый);
//	|"//}}ЗАПРОС
//	;
//
//	// Если ошибка в запросе, то выход из процедуры
//	Если Запрос.Выполнить(ТекстЗапроса) = 0 Тогда
//		Возврат;
//	КонецЕсли;
//    
//	ТаблицаИтогов = СоздатьОбъект("ТаблицаЗначений");
//	
//	ВремРегистры    = СоздатьОбъект("Регистры");
//	РегКнигаПокупок = ВремРегистры.КнигаПокупок;
//	
//	Если ИтогиАктуальны()=0 Тогда
//		РегКнигаПокупок.ВременныйРасчет();
//		ВремРегистры.Актуальность(1);
//		ВремРегистры.РассчитатьРегистрыНа(ТекущийДокумент());
//	КонецЕсли;     
//	                     
//	Если ФормироватьОтчет = 1 Тогда
//	    Таб = СоздатьОбъект("Таблица");
//		Таб.ИсходнаяТаблица ("ОтчетПоЗакрытиюМесяца");
//		ПечСебест 	= Запрос.СуммаБезНДСРасход - Запрос.СуммаБезНДСВозврат;
//		ПечНДС 		= Запрос.СуммаРубРасход - Запрос.СуммаРубВозврат - Запрос.СуммаБезНДСРасход + Запрос.СуммаБезНДСВозврат;
//		Таб.ВывестиСекцию("Шапка");		                                                    	
//
//		ПечСебест 	= Запрос.СуммаБезНДСРасход - Запрос.СуммаБезНДСВозврат;
//		ПечНДС 		= Запрос.СуммаРубРасход - Запрос.СуммаРубВозврат - Запрос.СуммаБезНДСРасход + Запрос.СуммаБезНДСВозврат;
//		
//		ТекстКодаОперации = Строка(глКО.РозничнаяПродажаЕНВД);
//		Таб.ВывестиСекцию("Операция");
//	КонецЕсли;
//	
//	Пока Запрос.Группировка("Поставщик")=1 Цикл	
//		Пока Запрос.Группировка("ПрихДокумент")=1 Цикл 
//			ПрихДокумент = Запрос.ПрихДокумент;
//			Если ПустоеЗначение(ПрихДокумент) = 1 Тогда
//				глСообщениеПроведения("При определении суммы НДС для распределения обнаружены записи без указания приходного документа!
//				|Распреджеление НДС по ним необходимо сделать вручную!", ТекущийДокумент(), 1,,1);
//				Продолжить;
//			КонецЕсли;
//            
//			Пока Запрос.Группировка("Партия")=1 Цикл 
//			
//				// столько НДС надо списать
//				ОстатокСписанияНДС = Запрос.СуммаРубРасход - Запрос.СуммаРубВозврат - Запрос.СуммаБезНДСРасход + Запрос.СуммаБезНДСВозврат;
//				ОстатокСписанияРуб = Запрос.СуммаРубРасход - Запрос.СуммаРубВозврат;
//			
//				Если ПрихДокумент.ВыбратьСтроки() = 1 Тогда
//					Пока ПрихДокумент.ПолучитьСтроку() = 1 Цикл
//		                
//						Если Метаданные.Документ(ПрихДокумент.Вид()).РеквизитШапки("СтавкаНДС").Выбран() = 1 Тогда
//							СтавкаНДС = ПрихДокумент.СтавкаНДС;
//						
//						ИначеЕсли Метаданные.Документ(ПрихДокумент.Вид()).РеквизитТабличнойЧасти("СтавкаНДС").Выбран() = 1 Тогда
//							СтавкаНДС = ПрихДокумент.СтавкаНДС;
//						
//						Иначе
//							СтавкаНДС = Перечисление.СтавкиНДС.БезНДС;
//						КонецЕсли;
//							
//						ТИКнигаПокупок = СоздатьОбъект("ТаблицаЗначений");
//						РегКнигаПокупок.УстановитьЗначениеФильтра("КредДокумент",Запрос.ПрихДокумент);
//						РегКнигаПокупок.УстановитьЗначениеФильтра("СтавкаНДС",СтавкаНДС);
//						РегКнигаПокупок.ВыгрузитьИтоги(ТИКнигаПокупок,1,1);
//						
//						ТаблИтогов.НоваяСтрока();
//						ТаблИтогов.Поставщик = Запрос.Поставщик;
//		                ВсегоСписаноНДС = 0;
//						
//						ТИКнигаПокупок.ВыбратьСтроки();
//						Пока ТИКнигаПокупок.ПолучитьСтроку() = 1 Цикл
//							
//							// это сколько на 19 счете
//							МожноСписать   = - ТИКнигаПокупок.СуммаНДС; //(регистр кредитовый, знак (-))
//							
//							СпишемСуммаНДС = Окр(Макс(0,Мин(МожноСписать,ОстатокСписанияНДС)),2,1);
//							СпишемСуммаРуб = ?(МожноСписать = 0,0,- ТИКнигаПокупок.СуммаРуб * СпишемСуммаНДС / МожноСписать);
//							СпишемСуммаНП  = ?(МожноСписать = 0,0,- ТИКнигаПокупок.СуммаНП  * СпишемСуммаНДС / МожноСписать);
//							
//							Если СпишемСуммаНДС > 0 Тогда
//								Регистр.КнигаПокупок.КредДокумент = ТИКнигаПокупок.КредДокумент;
//								Регистр.КнигаПокупок.СтавкаНДС    = ТИКнигаПокупок.СтавкаНДС   ;
//								Регистр.КнигаПокупок.ВидДолга     = ТИКнигаПокупок.ВидДолга    ;
//								
//								Регистр.КнигаПокупок.СуммаРуб = - СпишемСуммаРуб;
//								Регистр.КнигаПокупок.СуммаНДС = - СпишемСуммаНДС;
//								Регистр.КнигаПокупок.СуммаНП  = - СпишемСуммаНП;
//								
//								Регистр.КнигаПокупок.КодОперации = глКО.Прочее;
//								
//								Регистр.КнигаПокупок.ДвижениеРасходВыполнить(); // без отражения в книге покупок
//								
//								ОстатокСписанияНДС = ОстатокСписанияНДС - СпишемСуммаНДС;
//								ОстатокСписанияРуб = ОстатокСписанияРуб - СпишемСуммаРуб;
//								
//								ВсегоСписаноНДС = ВсегоСписаноНДС + СпишемСуммаНДС;
//							КонецЕсли;
//						КонецЦикла;   // по видам долга
//						
//						ТаблИтогов.НДС19 	 = ВсегоСписаноНДС;
//						ТаблИтогов.НДС68 	 = 0;
//		
//					КонецЦикла; // по строкам документа
//				КонецЕсли;
//				
//				// то, что не распределилось - спишем с 68 счета, сделаем фиктивное движение
//				Если (ОстатокСписанияНДС + ОстатокСписанияРуб) <> 0 Тогда   
//			
//					ТаблИтогов.НоваяСтрока();
//					ТаблИтогов.Поставщик = Запрос.Поставщик;
//					ТаблИтогов.НДС19 	 = 0;
//					ТаблИтогов.НДС68 	 = ОстатокСписанияНДС;
//			
//					Если ДатаДок < глДатаПостановления283 Тогда
//						
//						Регистр.КнигаПокупок.КредДокумент = ТекущийДокумент();
//						Регистр.КнигаПокупок.СтавкаНДС    = ОпределитьСтавкуНДС(ОстатокСписанияРуб, ОстатокСписанияНДС);
//						Регистр.КнигаПокупок.ВидДолга     = глВД.Прочее; // не важно, т.е. не знаем
//						
//						Регистр.КнигаПокупок.СуммаНДС     = - ОстатокСписанияНДС;  
//						Регистр.КнигаПокупок.СуммаРуб	 =  - ОстатокСписанияРуб;
//						Регистр.КнигаПокупок.СуммаНП 	 = 0;
//						
//						// определим код операции
//						Регистр.КнигаПокупок.КодОперации	= глКО.Прочее;
//						
//						Регистр.КнигаПокупок.ДвижениеРасходВыполнить();
//						// спишем сразу же, чтобы в остатках не было изменений
//						Регистр.КнигаПокупок.ДвижениеПриходВыполнить();
//					
//					Иначе
//						
//						Регистр.КнигаПродаж.КредДокумент = ТекущийДокумент();
//						Регистр.КнигаПродаж.СтавкаНДС	 = ОпределитьСтавкуНДС(ОстатокСписанияРуб, ОстатокСписанияНДС);
//						Регистр.КнигаПродаж.ВидДолга     = глВД.Прочее; // не важно, т.е. не знаем
//						
//						Регистр.КнигаПродаж.СуммаНДС     = ОстатокСписанияНДС;  
//						Регистр.КнигаПродаж.СуммаРуб	 = ОстатокСписанияРуб;
//						Регистр.КнигаПродаж.СуммаНП 	 = 0;
//						
//						// определим код операции
//						Регистр.КнигаПродаж.КодОперации	= глКО.Прочее;
//						
//						Регистр.КнигаПродаж.ДвижениеРасходВыполнить();
//						// спишем сразу же, чтобы в остатках не было изменений
//						Регистр.КнигаПродаж.ДвижениеПриходВыполнить();
//					                                                        
//					КонецЕсли;
//				
//				КонецЕсли;    
//				
//			КонецЦикла; // по партиям документа
//		КонецЦикла; // по приходным документам
//	КонецЦикла; // по поставщикам 
//
//	Если ФормироватьОтчет = 1 Тогда                      
//		
//		ТаблИтогов.Свернуть("Поставщик","НДС19,НДС68");
//		                              
//		Ном=0;
//		Таб.ВывестиСекцию("ШапкаНДС");
//		ТаблИтогов.ВыбратьСтроки();
//		Пока ТаблИтогов.ПолучитьСтроку()=1 Цикл
//			Если (ТаблИтогов.НДС19 <> 0)
//			 или (ТаблИтогов.НДС68 <> 0) Тогда
//				Ном = Ном + 1;
//				ТекстПоставщика = ?(ПустоеЗначение(ТаблИтогов.Поставщик)=1,"<Не известен>",ТаблИтогов.Поставщик);
//			    Таб.ВывестиСекцию("СтрокаНДС");
//			КонецЕсли;
//		КонецЦикла;                    
//		
//		Таб.ВывестиСекцию("ИтогНДС");
//		
//		Таб.ТолькоПросмотр(1);
//		Таб.Опции(0,0,0,0, "ЗакрытиеМесяца", "ЗакрытиеМесяца");
//		Таб.Показать("Отчет о проведении документа "+ТекущийДокумент());    
//		
//		ФормироватьОтчет = 0; // обнуляем флаг.
//	КонецЕсли;
//	    
КонецПроцедуры  // ПроведениеПоРегистрам()

////////////////////////////////////////////////////////////////////////////////
// ПРЕДОПРЕДЕЛЕННЫЕ ПРОЦЕДУРЫ
//
//******************************************************************************
// Предопределенная процедура.
//
Процедура ОбработкаПроведения(Отказ, Режим)
//	
//	Если ЮрЛицо.МетодРасчетаСебестоимости.Получить(ДатаДок) = Перечисление.МетодыРасчетаСебестоимости.ПоСреднему Тогда    
//		    глНеПроводить(Контекст,"Для юр. лица " + ЮрЛицо + "установлен метод расчета себестоимости ""По средней"".
//			|При расчете себестоимости по средней распределение НДС необходимо делать вручную!
//			|Проведение документа отменено!");
//			Возврат;
//	КонецЕсли;
//
//	// Проверка заполненности обязательных реквизитов.
//	Если глВсеРеквизитыДокументаЗаполнены(Контекст,"Фирма")=0 Тогда
//		Возврат;
//	КонецЕсли;  
//	
//	// проверим, не был ли уже проведен документ за этот месяц по этой же фирме
//	ДокЗМ = СоздатьОбъект("Документ."+Вид());
//	ДокЗМ.ВыбратьДокументы(НачМесяца(ДатаДок),КонМесяца(ДатаДок));
//	Пока ДокЗМ.ПолучитьДокумент()=1 Цикл
//	    Если (ДокЗМ.ТекущийДокумент()<>ТекущийДокумент())  
//		и	 (ДокЗМ.Проведен()=1) 
//		и	 (ДокЗМ.Фирма = Фирма) 
//		Тогда    
//		    глНеПроводить(Контекст,"За " + Формат(ДатаДок, "Д ММММГГГГ")+
//			"по фирме """+Фирма.Наименование+
//			""" закрытие месяца уже проведено ("+ДокЗМ.ТекущийДокумент()+")!");
//			Возврат;
//		КонецЕсли;
//	КонецЦикла;       
//	                     
//	// Проведение по регистрам оперативного учета.	
//	Если (ПустоеЗначение(ВидыДвижений) = 1) ИЛИ (Найти(ВидыДвижений, "Регистр") <> 0) Тогда
//		ПроведениеПоРегистрам(ВидыДвижений);
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
////
