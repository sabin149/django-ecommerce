# Generated by Django 3.1.7 on 2021-04-13 12:40

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0018_auto_20210413_1724'),
    ]

    operations = [
        migrations.RenameField(
            model_name='productimage',
            old_name='image1',
            new_name='more_images',
        ),
        migrations.RemoveField(
            model_name='productimage',
            name='image2',
        ),
        migrations.RemoveField(
            model_name='productimage',
            name='image3',
        ),
    ]