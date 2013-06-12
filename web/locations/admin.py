from django.contrib import admin

from .models import Waypoint, WaypointNote, Tour, WaypointPhoto

admin.site.register(Waypoint)
admin.site.register(WaypointNote)
admin.site.register(Tour)
admin.site.register(WaypointPhoto)
