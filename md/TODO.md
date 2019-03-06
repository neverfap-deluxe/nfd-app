{{< hr2 TODO

{{< hr3 3rd party

- comments plugin

{{< hr2 app build

- Create shortcodes for <hr/> with class. 
- Create similar practices on practices page.
- create categories/tags
- Get logo images
- Figure out twitter https://twitter.com/
- Practices to show 
- Figure out meta-titles
- Sort out image meta. 
- Breadcrumbs
- Put reddit link on homepage once subreddit is created.

https://forestry.io/blog/build-a-json-api-with-hugo/

{{< hr2 Types of categories

Email Templates

https://mjml.io/try-it-live/templates/recast



- popular

- Context
- Practice
- Introduction
- Figure out how to make it look fancy in google

Marketing - 
- Create Quora
- Create Reddit
- Offer free coaching to prominent users doing NoFap
- Offer free coaching to people attempting to overcome porn addictino.
- Figure out head component for login/register pages.


NoFap Emergency


{{< hr2 DESIGN

Wow, I never knew it before I designed the website, but css-tricks seems to have adopted a similar colour scheme. I could definitely learn a few things from it.
https://css-tricks.com/archives/


Privacy and Disclaimer files

Google Search Console
Netlify stuff

{{ range .Pages.ByDate }}
{{ range (.Pages.ByParam "author.last_name") }}

{{ range first 3 (where .Site.Pages "Params.tags" "Review") }}
{{ .Render "featured" }}
{{ end }}

{{ range .Site.Pages }}
{{ if in .Params.tags "mytag" }}
{{ .Title }}
{{ end }}
{{ end }}

{{ range first 1 .Site.Taxonomies.categories.sport }}

      <h2><a href="{{ .Page.Permalink }}">{{ .Page.Title }}</a></h2>
      <p>
        {{ .Page.Summary }}
      </p>

{{ end }}

<ul>
  {{ range .Site.Taxonomies.tags.CHANGEIT }}
    <li><a href="{{ .Page.URL }}">{{ .Page.Title }}</a></li>
  {{ end }}
</ul>

{{ range where .Data.Pages.ByDate "Section" "articles }}
{{ if in .Params.tags "home" }}
<li class="blog-tile">
{{ partial "blog-tile.html" . .Section }}
</li> <!-- /.blog-title -->
{{ end }}
{{ end }}





<!-- 
  <meta name="author" content="{{ .Site.Author.name }}" />
  <meta property="og:url" content="{{ .Permalink }}" />
  <link rel="canonical" href="{{ .Permalink }}" />

  {{ partial "seo" . }}
  {{- if .IsHome -}}
  <title>{{ .Site.Title }}</title>
  <meta property="og:title" content="{{ .Site.Title }}" />
  <meta property="og:type" content="website" />
  <meta name="description" content="{{ .Site.Params.description }}" />
  {{- else -}}
  <title>{{ .Title }} - {{ .Site.Title }}</title>
  <meta property="og:title" content="{{ .Title }} - {{ .Site.Title }}" />
  <meta property="og:type" content="article" />
  <meta name="description" content="{{ default .Summary .Description }}" />
  {{- end }}

  <link rel="stylesheet" href="{{ "css/index.css" | relURL }}">
  <link href="{{ "index.xml" | relURL }}" rel="alternate" type="application/rss+xml" title="{{ .Site.Title }}">
-->
  <!-- quicklink require -->

  <!-- Twitter Card -->
  <!-- <meta name="twitter:card" content="summary" />
  <meta name="twitter:description" content="{{ if .IsHome }}{{ .Site.Params.description }}{{ else }}{{ .Description }}{{ end }}" />
  <meta name="twitter:title" content="{{ .Title }}{{ if .IsHome }} - {{ .Site.Params.Tagline }}{{ else }} - {{ .Site.Title }}{{ end }}" />
  <meta name="twitter:site" content="{{ .Site.Params.twitter }}" />
  <meta name="twitter:creator" content="{{ .Site.Params.twitter }}" /> -->
  <!-- OG data -->
  <!-- <meta property="og:locale" content="en_US" />
  <meta property="og:type" content="{{ if .IsPage }}article{{ else }}website{{ end }}" />
  <meta content="{{ .Title }}{{ if .IsHome }} - {{ .Site.Params.Tagline }}{{ else }} - {{ .Site.Title }}{{ end }}" property="og:title">
  <meta content="{{ if .IsHome }}{{ .Site.Params.description }}{{ else }}{{ .Description }}{{ end }}" property="og:description">
  <meta property="og:url" content="{{ .Permalink }}" />
  <meta property="og:site_name" content="{{ .Site.Title }}" />
  {{ range .Params.categories }}<meta property="article:section" content="{{ . }}" />{{ end }}
  {{ if isset .Params "date" }}<meta property="article:published_time" content="{{ time .Date }}" />{{ end }} -->



    <!-- {{ if in .Params.tags "popular" }} -->
