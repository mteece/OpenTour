from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()
from opentour.api import TourResource

tour_resource = TourResource()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'opentour.views.home', name='home'),
    # url(r'^opentour/', include('opentour.foo.urls')),
    url(r'^admin/', include(admin.site.urls)),
    url(r'^api/', include(tour_resource.urls)),
)



