# Generated by Django 3.1.7 on 2021-04-13 17:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0024_productimage'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='productimage',
            name='product',
        ),
        migrations.AlterField(
            model_name='product',
            name='images',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='app.productimage'),
        ),
    ]
