describe "base" do
  it "should define the id method" do
    Post.new.should.respond_to :id
  end
  
  it "should set new_record to true when calling new" do
    Post.new.should.be.new_record
  end
  
  it "should set attributes when given a hash in new" do
    post = Post.new(:text => 'hello')
    post.text.should == 'hello'
  end
  
  describe "instantiate" do
    it "should raise an exception if no ID is given" do
      lambda { Shape.instantiate({}) }.should.raise(ArgumentError)
    end
    
    it "should instantiate concrete type if given in json" do
      shape = Shape.instantiate(:id => 1, :type => 'Rectangle')
      shape.should.is_a Rectangle
    end
    
    it "should instantiate base type if concrete type does not exist" do
      shape = Shape.instantiate(:id => 2, :type => 'FuzzyCircle')
      shape.should.is_a Shape
    end
    
    it "should instantiate base type if no type given in json" do
      shape = Shape.instantiate(:id => 3)
      shape.should.is_a Shape
      shape.should.not.is_a Rectangle
    end
    
    it "should set new_record to false" do
      shape = Shape.instantiate(:id => 4)
      shape.should.not.be.new_record
    end
    
    it "should remember instance" do
      Shape.recall(5).should.be.nil
      shape = Shape.instantiate(:id => 5)
      Shape.recall(5).should.not.be.nil
    end
    
    it "should update existing instance" do
      shape1 = Shape.instantiate(:id => 6, :contents => 'nothing')
      shape2 = Shape.instantiate(:id => 6, :contents => 'something')
      shape1.should.be.identical_to shape2
      shape1.contents.should == 'something'
    end
  end
  
  describe "subclasses" do
    it "should keep track of subclasses" do
      MotionResource::Base.subclasses.should.include(Shape)
      Shape.subclasses.should.include(Rectangle)
      MotionResource::Base.subclasses.should.not.include(Rectangle)
    end
  end
end
