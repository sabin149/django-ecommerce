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
    path("admin-product/list", views.AdminProductListView.as_view(),
         name="adminproductlist"),
    path("admin-all-orders/", views.AdminOrderListView,
         name="adminorderlist"),
    path("admin-product/add/", views.AdminProductCreateView.as_view(),
         name="adminproductcreate"),

    path("admin-category/list", views.AdminCategoryListView.as_view(),
         name="admincategorylist"),

    path("admin-category/add/", views.AdminCategoryCreateView.as_view(),
         name="admincategorycreate"),

    path("admin-order/<int:pk>/", views.AdminOrderDetailView.as_view(),
         name="adminorderdetail"),
    path("admin-order-<int:pk>-change/",
         views.AdminOrderStatuChangeView.as_view(), name="adminorderstatuschange"),
    path("admin-pendingorder/", views.AdminHomeView.as_view(), name="adminpendingorder"),
    
]