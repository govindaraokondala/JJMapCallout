//
//  CustomCalloutViewController.m
//  CustomCallout
//
//  Created by Jacob Jennings on 9/8/11.
//
//  This is my solution to the SO question "MKAnnotationView - Lock custom annotation view to pin on location updates":
//  http://stackoverflow.com/questions/6392931/mkannotationview-lock-custom-annotation-view-to-pin-on-location-updates
//
//  CalloutAnnotationView based on the work at: 
//  http://blog.asolutions.com/2010/09/building-custom-map-annotation-callouts-part-1/
//  
//  The Example* classes represent things you will probably change in your own project to fit your needs.  Consider CalloutAnnotationView abstract - it must be subclassed (here it's subclass is ExampleCalloutView), and linked with a xib connecting the IBOutlet for contentView.  The callout should resize to fit whatever view you supply as contentView.  

#import "CustomCalloutViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <MapKit/MapKit.h>
#import "CustomCalloutProtocols.h"
#import "ExampleCalloutView.h"

@implementation CustomCalloutViewController
@synthesize locationAnnotation, mapView, animationSwitch;

- (void)dealloc
{
    [animationSwitch release];
    [locationAnnotation release];
    [mapView release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.locationAnnotation = [[ExampleLocationAnnotation alloc] initWithLat:38.7f lon:-90.7f];
    [self.mapView addAnnotation:self.locationAnnotation];
    self.locationAnnotation.mapView = self.mapView;
    
    [self.mapView setRegion:MKCoordinateRegionMake(self.locationAnnotation.coordinate, MKCoordinateSpanMake(0.03, 0.03)) animated:YES];       
    
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)aMapView didSelectAnnotationView:(MKAnnotationView *)view {
    if([view conformsToProtocol:@protocol(CustomAnnotationViewProtocol)]) {
        [((NSObject<CustomAnnotationViewProtocol>*)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)aMapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if([view conformsToProtocol:@protocol(CustomAnnotationViewProtocol)]) {
        [((NSObject<CustomAnnotationViewProtocol>*)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if([annotation conformsToProtocol:@protocol(CustomAnnotationProtocol)]) {
        return [((NSObject<CustomAnnotationProtocol>*)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views) {
        
        if (![aV isKindOfClass:[ExampleCalloutView class]]) {
            CGRect endFrame = aV.frame;
            
            aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y-230.0, aV.frame.size.width, aV.frame.size.height);
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.45];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [aV setFrame:endFrame];
            [UIView commitAnimations];
        }
    }
}

- (IBAction)upTapped:(id)sender;
{
    if(self.animationSwitch.on) {
        [UIView animateWithDuration:0.1 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude + 0.001, self.locationAnnotation.coordinate.longitude)]; 
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else { 
        [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude + 0.001, self.locationAnnotation.coordinate.longitude)];
    }
}

- (IBAction)rightTapped:(id)sender;
{
    if(self.animationSwitch.on) {
        [UIView animateWithDuration:0.1 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude, self.locationAnnotation.coordinate.longitude + 0.001)]; 
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {     
        [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude, self.locationAnnotation.coordinate.longitude + 0.001)];   
    }
}

- (IBAction)downTapped:(id)sender;
{
    if(self.animationSwitch.on) {
        [UIView animateWithDuration:0.1 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude - 0.001, self.locationAnnotation.coordinate.longitude)]; 
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {     
        [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude - 0.001, self.locationAnnotation.coordinate.longitude)];    
    }
}

- (IBAction)leftTapped:(id)sender;
{
    if(self.animationSwitch.on) {
        [UIView animateWithDuration:0.1 
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseInOut 
                         animations:^{
                             [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude, self.locationAnnotation.coordinate.longitude - 0.001)]; 
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {     
        [self.locationAnnotation setCoordinate:CLLocationCoordinate2DMake(self.locationAnnotation.coordinate.latitude, self.locationAnnotation.coordinate.longitude - 0.001)];    
    }
}


@end
