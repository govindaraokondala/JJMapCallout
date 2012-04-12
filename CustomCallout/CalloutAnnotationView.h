//  This is my solution to the SO question "MKAnnotationView - Lock custom annotation view to pin on location updates":
//  http://stackoverflow.com/questions/6392931/mkannotationview-lock-custom-annotation-view-to-pin-on-location-updates
//
//  CalloutAnnotationView based on the work at: 
//  http://blog.asolutions.com/2010/09/building-custom-map-annotation-callouts-part-1/
//  
//  The Example* classes represent things you will probably change in your own project to fit your needs.  Consider CalloutAnnotationView abstract - it must be subclassed (here it's subclass is ExampleCalloutView), and linked with a xib connecting the IBOutlet for contentView.  The callout should resize to fit whatever view you supply as contentView.  


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CustomCalloutProtocols.h"

@interface CalloutAnnotationView : MKAnnotationView 
<CustomAnnotationViewProtocol>
{
	MKAnnotationView *_parentAnnotationView;
	MKMapView *_mapView;
	CGRect _endFrame;
	UIView *_contentView;
	CGFloat _yShadowOffset;
	CGPoint _offsetFromParent;
	CGFloat _contentHeight;
}

@property (nonatomic, retain) MKAnnotationView *parentAnnotationView;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIView *contentView;

- (void)animateIn;
- (void)animateInStepTwo;
- (void)animateInStepThree;
- (void)setAnnotationAndAdjustMap:(id <MKAnnotation>)annotation;
- (id)initWithAnnotation:(id<MKAnnotation>)annotation;

@end
