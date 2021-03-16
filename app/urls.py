from django.urls import path
from . import views
from .views import *
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
 path('', views.HomeView.as_view(), name='home'),  
 path("all-products/",AllProductsView.as_view(), name="all-products"),
 path('product/<slug:slug>/',ProductDetailView.as_view(), name='productdetail'),
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

 