# Generated by Django 3.1.7 on 2021-04-11 12:12

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0014_customer_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderplaced',
            name='profile',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='app.profile'),
        ),
    ]
