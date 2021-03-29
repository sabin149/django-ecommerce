from django.urls import path
from django.contrib.auth import views as auth_views

from .import views

urlpatterns=[
    
    path('',views.admin_dashboard,name='dashboard'),
    path('logout/', auth_views.LogoutView.as_view(next_page='login'), name='logout'),
    path('show-user',views.get_user),
    path('show-admin',views.get_admin),
    path('update-user-to-admin/<int:user_id>',views.update_user_to_admin),
    path('register-user',views.register_user_admin),
    
]