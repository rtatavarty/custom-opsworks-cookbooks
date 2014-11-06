node['c360-harvest']['programs'].each do |program|
  bash "reloading #{program}" do
    user "root"
    code <<-EOH
    pid = `supervisorctl -c /etc/supervisor/supervisord.conf pid #{program}`
    if [[ $pid != *[!0-9]* ]]; then
        kill -HUP $pid
    else
        echo "'$pid' is non-numeric value"
    fi
    EOH
  end
end

log "c360 app reloaded"
