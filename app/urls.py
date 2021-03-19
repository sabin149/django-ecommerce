from django.urls import path
from . import views
from .views import *
from django.conf import settings
from django.conf.urls.static import static
from .forms import LoginForm
from django.contrib.auth import views as auth_views

urlpatterns = [
 path('', views.HomeView.as_view(), name='home'),  
 path("all-products/",AllProductsView.as_view(), name="all-products"),
 path('product/<slug:slug>/',ProductDetailView.as_view(), name='productdetail'),
 path('registration/', views.CustomerRegistrationView.as_view(),
         name='customerregistration'),
 path('accounts/login/', auth_views.LoginView.as_view(template_name='app/login.html',authentication_form=LoginForm), name='login'),
 path('profile/', views.ProfileView.as_view(), name='profile'),

         
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

 