FROM ruby:3.2.2 AS builder

COPY . /app
WORKDIR /app
RUN bundle

FROM ruby:3.2.2-slim

COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY . /app
WORKDIR /app

CMD ["bundle", "exec", "agent"]
