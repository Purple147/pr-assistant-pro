PR Assistant — PRO Edition

نسخهٔ Pro شامل همهٔ امکانات Standard به‌علاوه:

اسکریپت نصب اتوماتیک (extras/install.sh)

سیستمd unit برای سرویس

healthcheck و playbook نصب (Ansible)

داشبورد پایه برای مشاهده history و reports (POC)

7 روز پشتیبانی و نصب رایگان یک‌بار

تحویل

فایل ZIP کامل برای فروش، یا نصب مستقیم روی VPS مشتری

قرارداد نصب کوتاه (docs/contract_template.txt) همراه محصول

نصب (آسان)

SSH به سرور مشتری

اجرا:

sudo bash extras/install.sh


سرویس را فعال کن:

sudo systemctl enable pr-assistant
sudo systemctl start pr-assistant

پیکربندی و امنیت

متغیرها در .env ذخیره می‌شوند — حتماً مقادیر API keys را پر کنید.

sessionها و data باید با permission مناسب ذخیره شوند (chmod 600).

License

Proprietary — تماس برای شرایط enterprise.

پشتیبانی

7 روز پشتیبانی شامل رفع باگ و نصب اولیه. پشتیبانی بلندمدت با قرارداد جدا.