# The-shopping-cart

## NumberModel 模型对象类

## ViewController 视图控制类

   // 找到cell对应model,很重要
   
    NumberModel * model = self.numberArray[self.btn.tag - 100];
    
    model.isSelected = !model.isSelected;
    
    for (NumberModel * m in self.numberArray)
    {
    
        if (m.isSelected == YES) {
          
        }
    }
    
    model.isEdit = !model.isEdit;
    
    for (NumberModel * m in self.numberArray)
    {
    
        if (m.isEdit == YES) {
          
        }
    }
    
    if (self.numberModel.isEdit == YES) {
    
        [self.editBtn setTitle:@"Finish" forState:UIControlStateNormal];
                self.ViewCell.topLab.hidden = YES;
                self.ViewCell.topView.hidden = NO;
                
    }else{
    
        [self.editBtn setTitle:@"Edit" forState:UIControlStateNormal];
        self.ViewCell.topLab.hidden = NO;
        self.ViewCell.topView.hidden = YES;
        
    }
    
    if (self.numberModel.isSelected == YES) {
    
        [self.btn setBackgroundImage:[UIImage imageNamed:@"choose_on"] forState:UIControlStateNormal];
        [self.ViewCell.btn setBackgroundImage:[UIImage imageNamed:@"choose_on"] forState:UIControlStateNormal];
        
    }else{
    
        [self.btn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
        [self.ViewCell.btn setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateNormal];
        
    }
// 再刷新指定的cell
