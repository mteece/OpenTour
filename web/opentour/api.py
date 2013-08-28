# myapp/api.py
from tastypie.resources import ModelResource
from locations.models import Tour

class TourResource(ModelResource):
    class Meta:
        queryset = Tour.objects.all()
        resource_name = 'tour'