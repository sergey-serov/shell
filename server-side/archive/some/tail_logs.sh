echo '======================================================================================================================================================================================================'

echo '------------------------------------------------------------------------'
echo '/var/www/html/site_name/logs/nginx_deny.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/www/html/site_name/logs/nginx_deny.log | ccze -A
echo ''
echo '' > /var/www/html/site_name/logs/nginx_deny.log

echo '------------------------------------------------------------------------'
echo '/var/www/html/site_name/logs/nginx_error.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/www/html/site_name/logs/nginx_error.log | ccze -A
echo ''
echo '' > /var/www/html/site_name/logs/nginx_error.log

echo '------------------------------------------------------------------------'
echo '/var/www/html/site_name/logs/nginx_access.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/www/html/site_name/logs/nginx_access.log | ccze -A
echo ''
echo '' > /var/www/html/site_name/logs/nginx_access.log

echo '------------------------------------------------------------------------'
echo '/var/www/html/site_name/logs/apache_error.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/www/html/site_name/logs/apache_error.log | ccze -A
echo ''
echo '' > /var/www/html/site_name/logs/apache_error.log

echo '------------------------------------------------------------------------'
echo '/var/www/html/site_name/logs/apache_access.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/www/html/site_name/logs/apache_access.log | ccze -A
echo ''
echo '' > /var/www/html/site_name/logs/apache_access.log

echo '------------------------------------------------------------------------'
echo '/var/log/nginx/error.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/log/nginx/error.log | ccze -A
echo ''
echo '' > /var/log/nginx/error.log

echo '------------------------------------------------------------------------'
echo '/var/log/nginx/access.log:'
echo '------------------------------------------------------------------------'
#echo ''
tail /var/log/nginx/access.log | grep '1.2.3.4'
echo ''
echo '' > /var/log/nginx/access.log

echo '======================================================================================================================================================================================================'
