#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) CGPoint lastPoint;
@property (assign, nonatomic) CGFloat red;
@property (assign, nonatomic) CGFloat green;
@property (assign, nonatomic) CGFloat blue;
@property (assign, nonatomic) CGFloat brushSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Начальные настройки
    self.red = 1.0;   // Красный по умолчанию
    self.green = 0.0;
    self.blue = 0.0;
    self.brushSize = 5.0;  // Средняя толщина
    
    // Установка начальных значений слайдеров
    self.redSlider.value = 1.0;
    self.greenSlider.value = 0.0;
    self.blueSlider.value = 0.0;
    
    // Выбор толщины по умолчанию (индекс 2 = 6pt)
    self.sizeControl.selectedSegmentIndex = 2;
}

#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self.canvas];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.canvas];
    
    // Начинаем рисование в контексте
    UIGraphicsBeginImageContext(self.canvas.frame.size);
    [self.canvas.image drawInRect:CGRectMake(0, 0, self.canvas.frame.size.width, self.canvas.frame.size.height)];
    
    // Получаем контекст и настраиваем параметры кисти
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.brushSize);
    CGContextSetRGBStrokeColor(context, self.red, self.green, self.blue, 1.0);
    
    // Рисуем линию от lastPoint до currentPoint
    CGContextMoveToPoint(context, self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextStrokePath(context);
    
    // Сохраняем результат
    self.canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Обновляем lastPoint для непрерывной линии
    self.lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // Опционально: можно сохранить рисунок
}

#pragma mark - Actions

- (IBAction)redChanged:(UISlider *)sender {
    self.red = sender.value;
}

- (IBAction)greenChanged:(UISlider *)sender {
    self.green = sender.value;
}

- (IBAction)blueChanged:(UISlider *)sender {
    self.blue = sender.value;
}

- (IBAction)sizeChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.brushSize = 2.0;
            break;
        case 1:
            self.brushSize = 4.0;
            break;
        case 2:
            self.brushSize = 6.0;
            break;
        case 3:
            self.brushSize = 8.0;
            break;
        case 4:
            self.brushSize = 10.0;
            break;
        default:
            self.brushSize = 6.0;
            break;
    }
}

- (IBAction)clearCanvas:(UIButton *)sender {
    self.canvas.image = nil;
}

@end
