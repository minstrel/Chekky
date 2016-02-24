FROM rails:onbuild
RUN gem install bundler
RUN RAILS_ENV=production bundle exec rake assets:precompile
ENV RAILS_ENV production
CMD export SECRET_KEY_BASE=`rake secret` \
  && rake db:create db:migrate RAILS_ENV=production \
  && rails server -b 0.0.0.0
