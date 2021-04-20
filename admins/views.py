from app.forms import CustomerRegistrationForm
from django.http.response import HttpResponseRedirect
from app.models import Product, Category_choices, OrderPlaced, Profile, STATUS_CHOICES
from admins.forms import CategoryForm, ProductForm
from app.auth import admin_only
from .models import *
from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.utils.decorators import method_decorator
from django.views.generic import ListView, CreateView, DetailView, View, TemplateView
from django.urls import reverse_lazy


@admin_only
@login_required
def admin_dashboard(request):
    users = User.objects.all()
    user_count = users.filter(is_staff=0).count()
    admin_count = users.filter(is_staff=1).count()
    product_count = Product.objects.all().filter().count()
    category_count = Category_choices.objects.all().filter().count()
    order_count = OrderPlaced.objects.all().filter().count()
    order_pending_count = OrderPlaced.objects.filter(status="Accepted").count()
    context = {

        'user_count': user_count,
        'admin_count': admin_count,
        'product_count': product_count,
        'category_count': category_count,
        'order_count': order_count,
        'order_pending_count': order_pending_count,
    }
    return render(request, 'admins/admin-dashboard.html', context)


@admin_only
@login_required
def get_user(request):
    users_all = User.objects.all()
    users = users_all.filter(is_staff=0)
    context = {
        'users': users,
    }
    return render(request, 'admins/showUser.html', context)


@admin_only
@login_required
def get_admin(request):
    admins_all = User.objects.all()
    admins = admins_all.filter(is_staff=1)
    context = {
        'admins': admins,
    }
    return render(request, 'admins/showAdmin.html', context)


@admin_only
@login_required
def update_user_to_admin(request, user_id):
    user = User.objects.get(id=user_id)
    user.is_staff = True
    user.save()
    messages.add_message(request, messages.SUCCESS,
                         'User has been updated to Admin')
    return redirect('/admin-dashboard')


@admin_only
@login_required
def register_user_admin(request):
    if request.method == 'POST':
        form = CustomerRegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            Profile.objects.create(user=user, username=user.username)
            return redirect('/admin-dashboard/show-user')

        else:
            messages.add_message(request, messages.ERROR,
                                 'Please provide correct details')
            return render(request, "admins/register-user-admin.html", {'form': form})
    context = {
        'form': CustomerRegistrationForm
    }
    return render(request, 'admins/register-user-admin.html', context)


@admin_only
@login_required
def delete_user(request, id):
    if request.method == 'POST':
        pi = User.objects.get(pk=id)
        pi.delete()
        return HttpResponseRedirect('/admin-dashboard/show-user')


@admin_only
@login_required
def AdminProductListView(request):
    template_name = "admins/adminproductlist.html"
    allproducts = Product.objects.all().order_by("-id")
    context = {
        'allproducts': allproducts
    }
    return render(request, template_name, context)


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class AdminProductCreateView(CreateView):
    template_name = "admins/adminproductcreate.html"
    form_class = ProductForm
    success_url = reverse_lazy("adminproductlist")

    def form_valid(self, form):
        form.save()
        return super().form_valid(form)


@admin_only
@login_required
def delete_product(request, id):
    if request.method == 'POST':
        pi = Product.objects.get(pk=id)
        pi.delete()
        return HttpResponseRedirect('/admin-dashboard/admin-product/list')


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class update_product(View):
    def get(self, request, id):
        pi = Product.objects.get(pk=id)
        fm = ProductForm(instance=pi)
        return render(request, 'admins/adminupdateproduct.html', {'form': fm})

    def post(self, request, id):
        pi = Product.objects.get(pk=id)
        fm = ProductForm(request.POST, instance=pi)
        if fm.is_valid():
            fm.save()
        return HttpResponseRedirect('/admin-dashboard/admin-product/list')


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class AdminCategoryListView(ListView):
    template_name = "admins/admincategorylist.html"
    queryset = Category_choices.objects.all().order_by("-id")
    context_object_name = "allcategory"


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class AdminCategoryCreateView(CreateView):
    template_name = "admins/admincategorycreate.html"
    form_class = CategoryForm
    success_url = reverse_lazy("admincategorylist")

    def form_valid(self, form):
        form.save()
        return super().form_valid(form)


@admin_only
@login_required
def delete_category(request, id):
    if request.method == 'POST':
        pi = Category_choices.objects.get(pk=id)
        pi.delete()
        return HttpResponseRedirect('/admin-dashboard/admin-category/list')


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class update_category(View):
    def get(self, request, id):
        pi = Category_choices.objects.get(pk=id)
        fm = CategoryForm(instance=pi)
        return render(request, 'admins/adminupdatecategory.html', {'form': fm})

    def post(self, request, id):
        pi = Category_choices.objects.get(pk=id)
        fm = CategoryForm(request.POST, instance=pi)
        if fm.is_valid():
            fm.save()
        return HttpResponseRedirect('/admin-dashboard/admin-category/list')


@admin_only
@login_required
def AdminOrderListView(request):
    template_name = "admins/adminorderlist.html"
    allorders = OrderPlaced.objects.all().order_by("-id")
    context = {
        'allorders': allorders,
    }
    return render(request, template_name, context)


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class AdminOrderDetailView(DetailView):
    template_name = "admins/adminorderdetail.html"
    model = OrderPlaced
    context_object_name = "ord_obj"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["allstatus"] = STATUS_CHOICES
        return con

@admin_only
@login_required
def delete_order(request, id):
    if request.method == 'POST':
        pi = OrderPlaced.objects.get(pk=id)
        pi.delete()
        return HttpResponseRedirect('/admin-dashboard/admin-all-orders')


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class AdminOrderStatuChangeView(View):
    def post(self, request, *args, **kwargs):
        order_id = self.kwargs["pk"]
        order_obj = OrderPlaced.objects.get(id=order_id)

        new_status = request.POST.get("status")
        order_obj.status = new_status
        order_obj.save()
        return redirect(reverse_lazy("adminorderdetail", kwargs={"pk": order_id}))


@method_decorator(login_required, name='dispatch')
@method_decorator(admin_only, name='dispatch')
class AdminHomeView(TemplateView):
    template_name = "admins/adminpendingorder.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["pendingorders"] = OrderPlaced.objects.filter(
            status="Accepted").order_by("-id")
        return context
