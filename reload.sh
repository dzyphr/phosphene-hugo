#hugo -t gokarna --buildDrafts -D && sudo systemctl restart nginx

#hugo -t gokarna --buildDrafts -F && service nginx restart
#hugo -t gokarna -D -F --cleanDestinationDir --gc && service nginx restart
hugo -t gokarna -D -F --cleanDestinationDir --gc
