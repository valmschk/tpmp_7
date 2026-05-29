# Задание 1. Рисование на Objective-C

**Вариант 32**  
**Выполнила:** Мещенко Валерия, 2 курс 10 группа

## Реализовано
- Рисование линиями 5 размеров (2, 4, 6, 8, 10 pt)
- Выбор цвета через 3 RGB-слайдера
- Сглаживание линий (`kCGLineCapRound`)

## Основные файлы
- `ViewController.h` / `ViewController.m`
- `Main.storyboard`

## Ключевой код
Обработка касаний в `touchesMoved` с использованием `UIGraphicsBeginImageContext`
и `CGContextSetRGBStrokeColor`.
