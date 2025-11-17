#每周一零点定时清理docker log日志
chmod +x /usr/local/docker/scheduled_cleanup.sh
( crontab -l 2>/dev/null; echo "0 0 * * 1 /usr/local/docker/clear_docker_log.sh" ) | crontab -



