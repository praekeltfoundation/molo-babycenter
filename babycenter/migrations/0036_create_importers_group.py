# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations


def create_import_group(apps, schema_editor):
    from molo.core.models import Main
    main = Main.objects.all().first()

    if main:
        Group = apps.get_model('auth.Group')
        Group.objects.create(name='Universal Core Importers')


class Migration(migrations.Migration):

    dependencies = [
        ('babycenter', '0001_initial'),
    ]

    operations = [
        migrations.RunPython(create_import_group),
    ]
