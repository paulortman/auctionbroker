# Generated by Django 2.0.4 on 2018-04-24 20:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auction', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='fee',
            name='description',
            field=models.CharField(max_length=100),
        ),
    ]
