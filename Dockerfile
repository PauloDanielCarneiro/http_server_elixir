FROM elixir:1.8.2-otp-22-alpine

ARG MIX_ENV=dev
ARG PS1="(http-server) \w \\$ "

ENV PS1=${PS1}
ENV MIX_ENV=${MIX_ENV}

WORKDIR /srv/app

COPY . .

RUN mix deps.get
RUN mix escript.build

CMD ["./http_server", "app/myapp.exs" ,"--port", "65535"]