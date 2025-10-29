from django.urls import path
from . import views

urlpatterns = [
    path('', views.index),
    path('register/', views.register, name='register'),
    path('login/', views.login_view, name='login'),
    path('home/', views.home, name='home'),
    path('logout/', views.logout_view, name='logout'),
]
