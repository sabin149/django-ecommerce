from .forms import CustomerRegistrationForm, CustomerProfileForm
from django.contrib import messages
from .models import Category_choices, Product, Customer, Cart
from django.shortcuts import redirect, render
from django.views.generic import TemplateView
from django.core.paginator import Paginator
from django.views import View
from django.db.models import Q
from django.http import JsonResponse



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


class CustomerRegistrationView(View):
    def get(self, request):
        form = CustomerRegistrationForm()
        return render(request, 'app/customerregistration.html', {'form': form})

    def post(self, request):
        form = CustomerRegistrationForm(request.POST)
        if form.is_valid():
            messages.success(
                request, 'Congratulations!! Registered Successfully')
            form.save()
        return render(request, 'app/customerregistration.html', {'form': form, 'active': 'btn-primary'})

class ProfileView(View):
    def get(self, request):  
        form = CustomerProfileForm()
        return render(request, 'app/profile.html', {'form': form, 'active': 'btn-success'})

    def post(self, request):
        
        form = CustomerProfileForm(request.POST)
        if form.is_valid():
            usr = request.user
            name = form.cleaned_data['name']
            address = form.cleaned_data['address']
            city = form.cleaned_data['city']
            provinice = form.cleaned_data['provinice']
            zipcode = form.cleaned_data['zipcode']
            reg = Customer(user=usr, name=name, address=address,
                           city=city, provinice=provinice, zipcode=zipcode)
            reg.save()
            messages.success(
                request, 'Congratulations!! Profile Updated Successfully')
        return render(request, 'app/profile.html', {'form': form, 'active': 'btn-success'})

def address(request):
    add = Customer.objects.filter(user=request.user)
    return render(request, 'app/address.html', {'add': add, 'active': 'btn-success'})

def add_to_cart(request):
    user = request.user
    product_id = request.GET.get('prod_id')
    product = Product.objects.get(id=product_id)
    Cart(user=user, product=product).save()
    return redirect('/cart')

def show_cart(request):
        user = request.user
        cart = Cart.objects.filter(user=user)
        amount = 0.0
        cart_product = [p for p in Cart.objects.all() if p.user == user]
        if cart_product:
            for p in cart_product:
                tempamount = (p.quantity * p.product.selling_price)
                amount += tempamount
                totalamount = amount 
            return render(request, 'app/addtocart.html', {'carts': cart, 'totalamount': totalamount, 'amount': amount})

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

def minus_cart(request):
    if request.method == 'GET':
        prod_id = request.GET['prod_id']
        c = Cart.objects.get(Q(product=prod_id) & Q(user=request.user))
        if c.quantity>1:
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


    
        





