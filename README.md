# Domain Landing System

Simple landing page for any domain. Point DNS records to DLS, optionally add TXT records and instanly have a clean domain landing page.

## Usage

- Using docker compose

```
$ docker-compose up -d
```

## DNS setup

- Add TXT records for setting title and subtitle of page. if no txt records are set the default value is the request host header for the title and blank subtitle


```
Type: TXT Name:@ Value: dls_title=Title For page

Type: TXT Name:@ Value: dls_subtitle=The sub title
```

- Adding a countdown to the page. Use date in format: 2019-01-01T00:00:00Z. Depending on where you want the countdown to show place the value {{Countdown}} as the text for the title or subtitle

```
TYPE: TXT Name:@ Value: dls_countdown=2019-01-01T00:00:00Z

Type: TXT Name:@ Value: dls_title={{Countdown}}

Type: TXT Name:@ Value: dls_subtitle=COUNTDOWN TO GO LIVE
```