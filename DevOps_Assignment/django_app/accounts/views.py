from django.shortcuts import render, redirect
from .models import Login
from django.http import HttpResponse

def index(request):
    return redirect('login')

def register(request):
    if request.method == 'POST':
        u = request.POST.get('username')
        p = request.POST.get('password')
        if u and p:
            Login.objects.create(username=u, password=p)
            return HttpResponse('Registered')
    return render(request, 'register.html')

def login_view(request):
    if request.method == 'POST':
        u = request.POST.get('username')
        p = request.POST.get('password')
        try:
            obj = Login.objects.get(username=u, password=p)
            request.session['username'] = obj.username
            return redirect('home')
        except Login.DoesNotExist:
            return HttpResponse('Invalid', status=401)
    return render(request, 'login.html')

def home(request):
    username = request.session.get('username')
    if not username:
        return redirect('login')
    return HttpResponse(f'Hello {username} How are you')

def logout_view(request):
    request.session.flush()
    return redirect('login')
