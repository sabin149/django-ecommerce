from django.db import models
from django.contrib.auth.models import User
# Create your models here.


PROVINICE_CHOICES = (
    ('Province No. 1', 'Province No. 1'),
    ('Province No. 2', 'Province No. 2'),
    ('Bagmati Province', 'Bagmati Province'),
    ('Gandaki Province', 'Gandaki Province'),
    ('Lumbini Province','Lumbini Province'),
    ('Karnali Province','Karnali Province'),
    ('Sudurpashchim Province','Sudurpashchim Province')
)

class Customer(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=200)
    address = models.CharField(max_length=200)
    city = models.CharField(max_length=200)
    provinice = models.CharField(choices=PROVINICE_CHOICES, max_length=50)
    zipcode = models.IntegerField()
    joined_on = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return str(self.id)


class Category_choices(models.Model):
    title = models.CharField(max_length=200)
    slug = models.SlugField(unique=True)

    def __str__(self):
        return self.title


class Product(models.Model):
    title = models.CharField(max_length=200)
    slug = models.SlugField(unique=True)
    marked_price = models.FloatField()
    selling_price = models.FloatField()
    description = models.TextField()
    warranty = models.CharField(max_length=300, null=True, blank=True)
    return_policy = models.CharField(max_length=300, null=True, blank=True)
    brand = models.CharField(max_length=100)
    category = models.ForeignKey(Category_choices,on_delete=models.CASCADE)
    product_image = models.ImageField(upload_to='productimg')

    def __str__(self):
        return str(self.id)
