#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// IBOutlets - связи с интерфейсом
@property (weak, nonatomic) IBOutlet UIImageView *canvas;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sizeControl;

// Действия (Actions)
- (IBAction)redChanged:(id)sender;
- (IBAction)greenChanged:(id)sender;
- (IBAction)blueChanged:(id)sender;
- (IBAction)sizeChanged:(id)sender;
- (IBAction)clearCanvas:(id)sender;

@end
