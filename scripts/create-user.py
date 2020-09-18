#!/usr/bin/env python
from django.contrib.auth.models import User

user=User.objects.create_user('username', password='userpassword')
user.is_superuser=False
user.is_staff=True
user.save()
