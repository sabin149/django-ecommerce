# Generated by Django 3.1.7 on 2021-04-14 06:58

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0030_auto_20210414_1232'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='product',
            name='imagels',
        ),
        migrations.RemoveField(
            model_name='product',
            name='imagers',
        ),
    ]