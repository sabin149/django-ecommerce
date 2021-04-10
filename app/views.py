from django.utils.decorators import method_decorator
from .auth import unauthenticated_user, user_only
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login
from django.views.generic import TemplateView, View
from django.http.response import HttpResponseRedirect
from .forms import CustomerRegistrationForm, CustomerAddressForm, LoginForm, ProfileForm
from django.contrib import messages
from .models import Category_choices, OrderPlaced, Product, Customer, Cart, Profile
from django.shortcuts import redirect, render
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
 
class HomeView(TemplateView):
    def get(self,request):
        totalitem = 0
        if request.user.is_authenticated:
            totalitem = len(Cart.objects.filter(user=request.user))
        all_products = Product.objects.all().order_by("-id")
        paginator = Paginator(all_products, 8)
        page_number = self.request.GET.get('page')
        product_list = paginator.get_page(page_number)
        template_name = "app/home.html"
        context={'product_list':product_list,'totalitem':totalitem}
        return render(request,template_name,context)


class AllProductsView(TemplateView):
    def get(self,request):
        totalitem = 0
        if self.request.user.is_authenticated:
            totalitem = len(Cart.objects.filter(user=request.user))
        template_name = "app/allproducts.html"
        allcategories=Category_choices.objects.all()
        context={'allcategories':allcategories,'totalitem':totalitem}
        return render(request,template_name,context)


class ProductDetailView(TemplateView):
    def get(self, request, **kwargs):
        url_slug = kwargs['slug'] 
        product = Product.objects.get(slug=url_slug)
        item_already_in_cart = False
        totalitem = 0
        if self.request.user.is_authenticated:
            totalitem = len(Cart.objects.filter(user=request.user))
            item_already_in_cart = Cart.objects.filter(
                Q(product=product.id) & Q(user=request.user)).exists()
        return render(request, 'app/productdetail.html', {'product': product, 'item_already_in_cart': item_already_in_cart, 'totalitem': totalitem})
    

class SearchView(TemplateView):
    def get(self,request):
        totalitem = 0
        if request.user.is_authenticated:
            totalitem = len(Cart.objects.filter(user=request.user))
        kw = self.request.GET.get("keyword")
        results = Product.objects.filter(
            Q(title__icontains=kw) | Q(description__icontains=kw) | Q(brand__icontains=kw))
        template_name = "app/search.html"
        context={'results':results,'totalitem':totalitem}
        return render(request,template_name,context)


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


@unauthenticated_user
def CustomerRegistrationView(request):
    if request.method == 'POST':
        form = CustomerRegistrationForm(request.POST)
        if form.is_valid():
            form.save()
            messages.add_message(request, messages.SUCCESS, 'User Registered Successfully')
            return redirect('/login')
        else:
            messages.add_message(request, messages.ERROR, 'Please provide correct details')
            return render(request, "app/customerregistration.html", {'form': form})
    return render(request, 'app/customerregistration.html', {'form': CustomerRegistrationForm, 'active': 'btn-primary'})

@login_required
@user_only
def user_profile(request):
    totalitem = 0
    if request.user.is_authenticated:
        totalitem = len(Cart.objects.filter(user=request.user))
    profile = request.user.profile
    form = ProfileForm(instance=profile)
    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            messages.success(
                request, 'Account Update Successful for ' + str(request.user))
            return redirect('/userprofile')
    context = {'form': form,'totalitem':totalitem}
    return render(request, 'app/user_profile.html', context)




@login_required
def shippingaddress(request):
    totalitem = 0
    if request.user.is_authenticated:
        totalitem = len(Cart.objects.filter(user=request.user))
    if request.method == 'POST':
        fm = CustomerAddressForm(request.POST)
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
            fm = CustomerAddressForm()
    else:
        fm = CustomerAddressForm()

    stud = Customer.objects.filter(user=request.user)
    context={'form': fm, 'stu': stud,'totalitem':totalitem}
    return render(request, 'app/shippingaddress.html',context)

@login_required
def delete_address(request,id):
    if request.method=='POST':
        pi=Customer.objects.get(pk=id)
        pi.delete()
        return HttpResponseRedirect('/shippingaddress')

@method_decorator(login_required,name='dispatch')
class update_address(View):
    def get(self, request, id):
        pi = Customer.objects.get(pk=id)
        fm = CustomerAddressForm(instance=pi)
        return render(request, 'app/updateaddress.html', {'form': fm})
        
    def post(self, request, id):
        pi = Customer.objects.get(pk=id)
        fm = CustomerAddressForm(request.POST, instance=pi)
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


