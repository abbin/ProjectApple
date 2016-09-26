//
//  PACollectionTableViewCell.m
//  ProjectApple
//
//  Created by Abbin Varghese on 26/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "PACollectionTableViewCell.h"
#import "PAImageViewCollectionViewCell.h"

@interface PACollectionTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *cellCollectionView;

@end

@implementation PACollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.cellCollectionView registerNib:[UINib nibWithNibName:@"PAImageViewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"PAImageViewCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PAImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PAImageViewCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

@end
