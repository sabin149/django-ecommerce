from django.contrib import admin
from .models import (Customer,Category_choices,Product)



# Register your models here.


@ admin.register(Customer)
class CustomerModelAdmin(admin.ModelAdmin):
    list_display=['id','user','name','address','city','zipcode','provinice','joined_on']

@ admin.register(Category_choices)
class Category_choicesModelAdmin(admin.ModelAdmin):
    list_display=['id','title','slug']

@ admin.register(Product)
class ProductModelAdmin(admin.ModelAdmin):
    list_display=['id','title','slug','marked_price','selling_price','description','warranty','return_policy','brand','category','product_image']

