# Задание 3. Анимации на Swift

**Вариант 32**  
**Выполнила:** Мещенко Валерия, 2 курс 10 группа

## Реализованные анимации

### Сценарий 1: Наложение эффектов (concatenating)

swift
let move = CGAffineTransform(translationX: 0, y: -40)
let rotate = CGAffineTransform(rotationAngle: .pi / 4)
let combined = move.concatenating(rotate)
