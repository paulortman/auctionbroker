# Generated by Django 2.2.1 on 2019-05-21 13:53

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('auction', '0006_auto_20180922_0356'),
    ]

    operations = [
        migrations.AlterField(
            model_name='patron',
            name='phone1',
            field=models.CharField(blank=True, max_length=30),
        ),
    ]