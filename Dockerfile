FROM ruby:3.2.2 AS builder

COPY . /app
WORKDIR /app
RUN bundle

FROM ruby:3.2.2-slim

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /app
RUN rm -f /app/db/db* || true
WORKDIR /app

RUN /usr/sbin/useradd app -d /app
RUN chown -R app:app /app
USER app
RUN bundle exec rake db:create db:migrate

CMD ["bundle", "exec", "agent"]
