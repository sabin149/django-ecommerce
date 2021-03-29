from .auth import unauthenticated_user, user_only,admin_only
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login
from django.views.generic import ListView, CreateView, DetailView, TemplateView
from django.http.response import HttpResponseRedirect
from .forms import CustomerRegistrationForm, CustomerProfileForm, LoginForm, ProductForm, ProfileForm
from django.contrib import messages
from .models import Category_choices, OrderPlaced, Product, Customer, Cart, Profile, STATUS_CHOICES
from django.shortcuts import redirect, render
from django.views.generic import TemplateView
from django.core.paginator import Paginator
from django.views import View
from django.db.models import Q
from django.urls import reverse_lazy
from django.http import JsonResponse
from django.utils.decorators import method_decorator


class HomeView(TemplateView):
    template_name = "app/home.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        all_products = Product.objects.all().order_by("-id")
        paginator = Paginator(all_products, 8)
        page_number = self.request.GET.get('page')
        product_list = paginator.get_page(page_number)
        context['product_list'] = product_list
        return context


class ProductDetailView(TemplateView):
    template_name = "app/productdetail.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        url_slug = self.kwargs['slug']
        product = Product.objects.get(slug=url_slug)
        context['product'] = product
        return context


class AllProductsView(TemplateView):
    template_name = "app/allproducts.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['allcategories'] = Category_choices.objects.all()
        return context


class SearchView(TemplateView):
    template_name = "app/search.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        kw = self.request.GET.get("keyword")
        results = Product.objects.filter(
            Q(title__icontains=kw) | Q(description__icontains=kw) | Q(brand__icontains=kw))
        context["results"] = results
        return context


@unauthenticated_user
def login_user(request):
    if request.user.is_authenticated:
        return render(request, 'app/home.html')
    else:
        if request.method == 'POST':
            form = LoginForm(request.POST)
            if form.is_valid():
                data = form.cleaned_data
                user = authenticate(request, username=data['username'],
                                    password=data['password'])
                if user is not None:
                    if not user.is_staff:
                        login(request, user)
                        
                        return redirect('home')
                    elif user.is_staff:
                        login(request, user)
                        return redirect('/admin-dashboard')
                else:
                    messages.add_message(request, messages.ERROR,
                                         'Username or Password is Invalid')
                    return render(request, 'app/login.html', {'form': form})
    form = LoginForm()
    context = {
        'form': LoginForm
    }
    return render(request, 'app/login.html', context)


class CustomerRegistrationView(View):
    def get(self, request):
        form = CustomerRegistrationForm()
        return render(request, 'app/customerregistration.html', {'form': form})

    def post(self, request):
        form = CustomerRegistrationForm(request.POST)
        if form.is_valid():
            messages.success(
                request, 'Congratulations!! Registered Successfully')
            user = form.save()
            Profile.objects.create(user=user, username=user.username)
        return render(request, 'app/customerregistration.html', {'form': form, 'active': 'btn-primary'})


@user_only
@login_required
def user_profile(request):
    profile = request.user.profile
    form = ProfileForm(instance=profile)
    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            messages.success(
                request, 'Account Update Successful for ' + str(request.user))
            return redirect('/userprofile')
    context = {'form': form}
    return render(request, 'app/user_profile.html', context)


@login_required
def shippingaddress(request):
    if request.method == 'POST':
        fm = CustomerProfileForm(request.POST)
        if fm.is_valid():
            usr = request.user
            name = fm.cleaned_data['name']
            address = fm.cleaned_data['address']
            city = fm.cleaned_data['city']
            province = fm.cleaned_data['province']
            zipcode = fm.cleaned_data['zipcode']

            reg = Customer(user=usr, name=name, address=address,
                           city=city, province=province, zipcode=zipcode)
            reg.save()
            fm = CustomerProfileForm()
    else:
        fm = CustomerProfileForm()
    stud = Customer.objects.all()
    return render(request, 'app/shippingaddress.html', {'form': fm, 'stu': stud})


@login_required
def delete_address(request, id):
    if request.method == 'POST':
        pi = Customer.objects.get(pk=id)
        pi.delete()
        return HttpResponseRedirect('/shippingaddress')


@login_required
class update_address(View):
    def get(self, request, id):
        pi = Customer.objects.get(pk=id)
        fm = CustomerProfileForm(instance=pi)
        return render(request, 'app/updateaddress.html', {'form': fm})

    def post(self, request, id):
        pi = Customer.objects.get(pk=id)
        fm = CustomerProfileForm(request.POST, instance=pi)
        if fm.is_valid():
            fm.save()
        return HttpResponseRedirect('/shippingaddress')


@login_required
def checkout(request):
    totalitem = 0
    user = request.user
    add = Customer.objects.filter(user=user)
    cart_items = Cart.objects.filter(user=user)
    amount = 0.0
    if request.user.is_authenticated:
        totalitem = len(Cart.objects.filter(user=request.user))

    cart_product = [p for p in Cart.objects.all() if p.user == request.user]
    if cart_product:
        for p in cart_product:
            tempamount = (p.quantity * p.product.selling_price)
            amount += tempamount
        totalamount = amount
    return render(request, 'app/checkout.html', {'add': add, 'totalamount': totalamount, 'cart_items': cart_items, 'totalitem': totalitem})


@login_required
def orders(request):
    totalitem = 0
    if request.user.is_authenticated:
        totalitem = len(Cart.objects.filter(user=request.user))
    op = OrderPlaced.objects.filter(user=request.user)
    return render(request, 'app/orders.html', {'order_placed': op, 'totalitem': totalitem})


@login_required
def payment_done(request):
    user = request.user
    custid = request.GET.get('custid')
    customer = Customer.objects.get(id=custid)
    cart = Cart.objects.filter(user=user)
    for c in cart:
        OrderPlaced(user=user, customer=customer,
                    product=c.product, quantity=c.quantity).save()
        c.delete()
    return redirect("orders")


@login_required
def add_to_cart(request):
    user = request.user
    product_id = request.GET.get('prod_id')
    product = Product.objects.get(id=product_id)
    Cart(user=user, product=product).save()
    return redirect('/cart')


@login_required
def buy_now(request):
    return render(request, 'app/buynow.html')


@login_required
def show_cart(request):
    totalitem = 0
    if request.user.is_authenticated:
        totalitem = len(Cart.objects.filter(user=request.user))

        user = request.user
        cart = Cart.objects.filter(user=user)
        amount = 0.0
        cart_product = [p for p in Cart.objects.all() if p.user == user]
        if cart_product:
            for p in cart_product:
                tempamount = (p.quantity * p.product.selling_price)
                amount += tempamount
                totalamount = amount
            return render(request, 'app/addtocart.html', {'carts': cart, 'totalamount': totalamount, 'amount': amount, 'totalitem': totalitem})

        else:
            return render(request, 'app/emptycart.html')


@login_required
def plus_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        c.quantity += 1
        c.save()
        amount = 0.0
        shipping_amount = 70.0
        cart_product = [p for p in Cart.objects.all() if p.user ==
                        request.user]
        for p in cart_product:
            tempamount = (p.quantity * p.product.selling_price)
            amount += tempamount

        data = {

            'quantity': c.quantity,
            'amount': amount,
            'totalamount': amount + shipping_amount
        }

        return JsonResponse(data)


@login_required
def minus_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        if c.quantity > 1:
            c.quantity -= 1
        c.save()
        amount = 0.0
        shipping_amount = 70.0
        cart_product = [p for p in Cart.objects.all() if p.user ==
                        request.user]
        for p in cart_product:
            tempamount = (p.quantity * p.product.selling_price)
            amount += tempamount
        data = {

            'quantity': c.quantity,
            'amount': amount,
            'totalamount': amount + shipping_amount
        }
        return JsonResponse(data)


@login_required
def remove_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        c.delete()
        amount = 0.0
        shipping_amount = 70.0
        cart_product = [p for p in Cart.objects.all() if p.user ==
                        request.user]
        for p in cart_product:
            tempamount = (p.quantity * p.product.discounted_price)
            amount += tempamount
        data = {
            'amount': amount,
            'totalamount': amount + shipping_amount
        }
        return JsonResponse(data)


# Admins related

@method_decorator(admin_only , name='dispatch')
class AdminProductListView(ListView):
    template_name = "admins/adminproductlist.html"
    queryset = Product.objects.all().order_by("-id")
    context_object_name = "allproducts"

    


@method_decorator(admin_only , name='dispatch')
class AdminProductCreateView(CreateView):
    template_name = "admins/adminproductcreate.html"
    form_class = ProductForm
    success_url = reverse_lazy("adminproductlist")

    def form_valid(self, form):
        form.save()
        return super().form_valid(form)

# @login_required
@method_decorator(admin_only , name='dispatch')
class AdminOrderDetailView(DetailView):
    template_name = "admins/adminorderdetail.html"
    model = OrderPlaced
    context_object_name = "ord_obj"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["allstatus"] = STATUS_CHOICES
        return context

# @login_required
@method_decorator(admin_only , name='dispatch')
class AdminOrderListView(ListView):
    template_name = "admins/adminorderlist.html"
    queryset = OrderPlaced.objects.all().order_by("-id")
    context_object_name = "allorders"

# @login_required
@method_decorator(admin_only , name='dispatch') 
class AdminOrderStatuChangeView(View):
    def post(self, request,*args, **kwargs):
        order_id = self.kwargs["pk"]
        order_obj = OrderPlaced.objects.get(id=order_id)

        new_status = request.POST.get("status")
        print(new_status)
        order_obj.status = new_status
        order_obj.save()
        return redirect(reverse_lazy("adminorderdetail", kwargs={"pk": order_id}))