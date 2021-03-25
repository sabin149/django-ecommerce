from django.urls import path
from . import views
from .views import *
from django.conf import settings
from django.conf.urls.static import static
from .forms import LoginForm, UserPasswordChangeForm, UserPasswordResetForm, UserSetPasswordForm
from django.contrib.auth import views as auth_views

urlpatterns = [
 path('', views.HomeView.as_view(), name='home'),  
 path("all-products/",AllProductsView.as_view(), name="all-products"),
 path('product/<slug:slug>/',ProductDetailView.as_view(), name='productdetail'),
 path('add-to-cart/', views.add_to_cart, name='add-to-cart'),
 path('cart/', views.show_cart, name='showcart'),
 path('pluscart/', views.plus_cart, name='pluscart'),
 path('registration/', views.CustomerRegistrationView.as_view(),
         name='customerregistration'),
 path('accounts/login/', auth_views.LoginView.as_view(template_name='app/login.html',authentication_form=LoginForm), name='login'),
 path('profile/', views.ProfileView.as_view(), name='profile'),
 path('address/',views.address, name='address'),
 path('passwordchange/', auth_views.PasswordChangeView.as_view(
        template_name='app/passwordchange.html', form_class=UserPasswordChangeForm, success_url='/passwordchangedone/'), name='passwordchange'),
path('passwordchangedone/', auth_views.PasswordChangeView.as_view(
        template_name='app/passwordchangedone.html'), name='passwordchangedone'),
path('password-reset/', auth_views.PasswordResetView.as_view(template_name='app/password_reset.html',
                                                                 form_class=UserPasswordResetForm), name='password_reset'),
path('password-reset/done/', auth_views.PasswordResetDoneView.as_view(
        template_name='app/password_reset_done.html'), name='password_reset_done'),
path('password-reset-confirm/<uidb64>/<token>/', auth_views.PasswordResetConfirmView.as_view(
        template_name='app/password_reset_confirm.html', form_class=UserSetPasswordForm), name='password_reset_confirm'),
path('password-reset-complete/', auth_views.PasswordResetCompleteView.as_view(
        template_name='app/password_reset_complete.html'), name='password_reset_complete'),
path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'),


         
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

 