# Generated by Django 3.1.7 on 2021-04-13 15:38

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0020_auto_20210413_2103'),
    ]

    operations = [
        migrations.AddField(
            model_name='product',
            name='images',
            field=models.ImageField(null=True, upload_to='productimg/images'),
        ),
    ]
