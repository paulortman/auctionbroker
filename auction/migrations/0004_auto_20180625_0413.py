# Generated by Django 2.0.4 on 2018-06-25 04:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auction', '0003_auto_20180608_1514'),
    ]

    operations = [
        migrations.AlterField(
            model_name='patron',
            name='buyer_num',
            field=models.CharField(blank=True, db_index=True, max_length=8, null=True, unique=True, verbose_name='Buyer Number'),
        ),
    ]
