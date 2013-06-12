import datetime

from django.contrib.auth.models import User
from django.db import models


class Waypoint(models.Model):
    name = models.CharField(max_length=500)
    slug = models.SlugField()
    longitude = models.FloatField()
    latitude = models.FloatField()
    description = models.TextField(blank=True)
    user = models.ForeignKey(User, related_name="waypoints")
    created = models.DateTimeField(default=datetime.datetime.now)
    updated = models.DateTimeField(default=datetime.datetime.now)
    
    def __unicode__(self):
        return self.name


class Tour(models.Model):
    name = models.CharField(max_length=500)
    slug = models.SlugField()
    user = models.ForeignKey(User, related_name="tours")
    stops = models.ManyToManyField(Waypoint)
    created = models.DateTimeField(default=datetime.datetime.now)

    def __unicode__(self):
        return self.name


class WaypointNote(models.Model):
    waypoint = models.ForeignKey(Waypoint, related_name="notes")
    content = models.TextField()
    user = models.ForeignKey(User, related_name="notes")
    created = models.DateTimeField(default=datetime.datetime.now)

    def __unicode__(self):
        return "%s: %s" % (self.waypoint, self.content[:50])
