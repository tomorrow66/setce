class Category
  include DataMapper::Resource
  
  property  :id,          Serial
  property  :name,        String  
  property 	:url,	      String, required: false
  property  :description, String, required: false, length: 1200
  property  :thumb,       String, required: false  

  
  has n, :subcategories
end

class Subcategory
  include DataMapper::Resource
  
  property  :id,          Serial
  property  :name,        String  
  property 	:url,	      String,  required: false
  property  :description, String,  required: false, length: 1200
  property 	:position, 	  Integer, required: false
  property	:tree, 		  String,  required: false

  has n, :assets

  belongs_to :category
end

class Asset
  include DataMapper::Resource
  
  property  :id,          Serial
  property  :name,        String, required: false
  property  :thumb,       String, required: false 
  property 	:url,	      	String, required: false, length: 250
  property  :download,    String, required: false
  property  :preview,     String, required: false  
  
  belongs_to :subcategory
end