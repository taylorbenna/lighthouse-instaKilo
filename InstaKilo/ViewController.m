//
//  ViewController.m
//  InstaKilo
//
//  Created by Taylor Benna on 2016-05-18.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewCell.h"
#import "SectionReusableView.h"
#import "ImageObject.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSMutableArray *images;
@property (nonatomic) NSArray *sortedImages;
@property (nonatomic) NSString *currentGrouping;
@property (weak, nonatomic) IBOutlet UICollectionView *theCollectionView;
@property (nonatomic) NSArray *allGroups;
@property (nonatomic) NSArray *allLocations;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [[NSMutableArray alloc] init];
    
    ImageObject *img1 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"big_eyed_cat.jpg"]
                                                   section:@"Cats"
                                                  location:@"Unknown"];
    
    ImageObject *img2 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"cat_eating.jpg"]
                                                   section:@"Cats"
                                                  location:@"Unknown"];
    
    ImageObject *img3 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"cat_lap.jpg"]
                                                   section:@"Cats"
                                                  location:@"Coquitlam"];
    
    ImageObject *img4 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"kitten_stripper.jpg"]
                                                   section:@"Cats"
                                                  location:@"Unknown"];
    
    ImageObject *img5 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"morty.jpg"]
                                                   section:@"Other"
                                                  location:@"Unknown"];
    
    ImageObject *img6 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"penguin.jpg"]
                                                   section:@"Other"
                                                  location:@"Unknown"];
    
    ImageObject *img7 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"shannon_falls.jpg"]
                                                   section:@"Selfies"
                                                  location:@"Squamish"];
    
    ImageObject *img8 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"tangled.jpg"]
                                                   section:@"Other"
                                                  location:@"Unknown"];
    
    ImageObject *img9 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"text_screen.jpg"]
                                                   section:@"Other"
                                                  location:@"Coquitlam"];
    
    ImageObject *img10 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"time.jpg"]
                                                    section:@"Other"
                                                   location:@"Unknown"];
    
    ImageObject *img11 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"deer.jpg"]
                                                    section:@"Cats"
                                                   location:@"Outside"];
    
    ImageObject *img12 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"gamer_pup.jpg"]
                                                    section:@"Dogs"
                                                   location:@"Unknown"];
    
    ImageObject *img13 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"puppy_couch.jpg"]
                                                    section:@"Dogs"
                                                   location:@"Unknown"];
    
    ImageObject *img14 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"chubby_puppy.jpg"]
                                                    section:@"Dogs"
                                                   location:@"Unknown"];
    
    ImageObject *img15 = [[ImageObject alloc] initWithImage:[UIImage imageNamed:@"alien.jpg"]
                                                    section:@"Selfies"
                                                   location:@"Coquitlam"];
    
    [self.images addObjectsFromArray: @[img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12,img13,img14,img15]];
    
    self.allGroups = [[NSArray alloc] init];
    self.allLocations = [[NSArray alloc] init];
    [self seperateGroups];
    [self seperateLocations];
    
    self.sortedImages = [[NSArray alloc] init];
    self.sortedImages = [self seperateSectionsFrom:self.images];
    self.currentGrouping = @"Group";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger num;
    for (int i = 0; i < self.sortedImages.count; i++) {
        if(section == i) {
            num = [self.sortedImages[i] count];
            break;
        }
    }
    return num;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sortedImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    ImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
//    ImageObject *currentObject = self.images[indexPath.item];
//    cell.imageView.image = currentObject.image;
//    return cell;
    
    ImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    ImageObject *currentObject = self.sortedImages[indexPath.section][indexPath.row];
    cell.imageView.image = currentObject.image;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds];
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.shadowPath = shadowPath.CGPath;
    
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SectionReusableView *sec = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    if ([self.currentGrouping isEqualToString:@"Group"]) {
        for (int i = 0; i < self.allGroups.count; i++) {
            if (indexPath.section == i) {
                sec.titleLabel.text = [NSString stringWithFormat:@"%@", self.allGroups[i]];
                break;
            }
        }
    } else {
        for (int i = 0; i < self.allLocations.count; i++) {
            if (indexPath.section == i) {
                sec.titleLabel.text = [NSString stringWithFormat:@"%@",self.allLocations[i]];
                break;
            }
        }
    }
   
    return sec;
}

-(NSArray *)seperateSectionsFrom:(NSMutableArray*)array{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.allGroups.count; i++) {
        [newArray addObject:[NSMutableArray new]];
    }
    for (ImageObject *image in self.images) {
        for (int i = 0; i < self.allGroups.count; i++) {
            if ([image.section isEqual:self.allGroups[i]]) {
                [newArray[i] addObject:image];
                break;
            }
        }
        
    }
    return [NSArray arrayWithArray:newArray];
}

-(NSArray *)seperateLocationsFrom:(NSMutableArray*)array{
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.allLocations.count; i++) {
        [newArray addObject:[NSMutableArray new]];
    }
    for (ImageObject *image in self.images) {
        for (int i = 0; i < self.allGroups.count; i++) {
            if ([image.location isEqual:self.allLocations[i]]) {
                [newArray[i] addObject:image];
                break;
            }
        }
    }
    return [NSArray arrayWithArray:newArray];
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.currentGrouping = @"Group";
        self.sortedImages = [self seperateSectionsFrom:self.images];
    } else {
        self.currentGrouping = @"Location";
        self.sortedImages = [self seperateLocationsFrom:self.images];
    }
    
    [self.theCollectionView reloadData];
    
}

-(void) seperateGroups {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (ImageObject *image in self.images) {
        [set addObject:image.section];
    }
    self.allGroups = [NSArray arrayWithArray:[set allObjects]];
}

-(void) seperateLocations {
    NSMutableSet *set = [[NSMutableSet alloc] init];
    for (ImageObject *image in self.images) {
        [set addObject:image.location];
    }
    self.allLocations = [NSArray arrayWithArray:[set allObjects]];
}

@end
