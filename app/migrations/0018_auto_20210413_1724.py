# Generated by Django 3.1.7 on 2021-04-13 11:39

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0017_productimage'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='product',
            name='return_policy',
        ),
        migrations.RemoveField(
            model_name='product',
            name='warranty',
        ),
    ]
