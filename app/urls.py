from django.urls import path
from . import views
from .views import *
from django.conf import settings
from django.conf.urls.static import static
from .forms import UserPasswordChangeForm, UserPasswordResetForm, UserSetPasswordForm
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('', views.HomeView.as_view(), name='home'),
    path('all-products/', views.AllProductsView.as_view(), name='all-products'),
    path('product/<slug:slug>/', ProductDetailView.as_view(), name='productdetail'),
    path('add-to-cart/', views.add_to_cart, name='add-to-cart'),
    path('buy/', views.buy_now, name='buy-now'),
    path('cart/', views.show_cart, name='showcart'),
    path('pluscart/', views.plus_cart, name='pluscart'),
    path('minuscart/', views.minus_cart, name='minuscart'),
    path('removecart/', views.remove_cart, name='removecart'),
    path('registration/', views.CustomerRegistrationView.as_view(),
         name='customerregistration'),
    path('login/', views.login_user, name='login'),
    path('userprofile/', views.user_profile, name='userprofile'),
    path('shippingaddress/', views.shippingaddress, name='shippingaddress'),
    path('deleteaddress/<int:id>/', views.delete_address, name='deleteaddress'),
    path('<int:id>/', views.update_address, name="updateaddress"),
    path('checkout/', views.checkout, name='checkout'),
    path('orders/', views.orders, name='orders'),
    path('paymentdone/', views.payment_done, name='paymentdone'),
    path("search/", views.SearchView.as_view(), name="search"),
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
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
