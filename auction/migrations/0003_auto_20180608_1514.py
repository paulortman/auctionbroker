# Generated by Django 2.0.4 on 2018-06-08 15:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auction', '0002_auto_20180424_2004'),
    ]

    operations = [
        migrations.AlterField(
            model_name='patron',
            name='buyer_num',
            field=models.CharField(db_index=True, max_length=8, unique=True, verbose_name='Patron Number'),
        ),
    ]
