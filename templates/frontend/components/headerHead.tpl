{**
 * templates/frontend/components/headerHead.tpl
 *
 * Copyright (c) 2014-2019 Simon Fraser University
 * Copyright (c) 2000-2019 John Willinsky
 * Copyright (c) 2019 Ronny Bölter, Leibniz Institute for Psychology Information (https://leibniz-psychology.org)
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Common site header <head> tag and contents.
 *}

<head>
<meta charset="{$defaultCharset|escape}"/>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
{if $requestedPage=='article' && $requestedOp=='view' && $article && $currentJournal}
    <link rel="canonical" href="{url page="article" op="view" path=$article->getBestArticleId($currentJournal)}"/>
{/if}
{strip}
    <title>{$pageTitleTranslated|strip_tags}{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()} | {$currentContext->getLocalizedName()}{/if}</title>
{/strip}
{load_header context="frontend"}
{load_stylesheet context="frontend"}
{* Include social metadata *}
{include file="frontend/objects/social_meta.tpl"}
{* Include JSON Schema.org metadata *}
{include file="frontend/objects/schema_json_ld.tpl"}
{* Twitter DO-NOT-TRACK enabled *}
<meta name="twitter:dnt" content="on"/>
{* Aplication Data *}
<link rel="apple-touch-icon" sizes="180x180" href="/public/icons/apple-touch-icon.png"/>
<link rel="icon" type="image/png" sizes="32x32" href="/public/icons/favicon-32x32.png"/>
<link rel="icon" type="image/png" sizes="16x16" href="/public/icons/favicon-16x16.png"/>
<link rel="manifest" href="/public/icons/site.webmanifest"/>
<link rel="mask-icon" href="/public/icons/safari-pinned-tab.svg" color="#803910"/>
<link rel="shortcut icon" href="/public/icons/favicon.ico"/>
<meta name="apple-mobile-web-app-title" content="Journal"/>
<meta name="application-name" content="Journal"/>
<meta name="msapplication-TileColor" content="#ffc40d"/>
<meta name="msapplication-config" content="/public/icons/browserconfig.xml"/>
<meta name="theme-color" content="#7d0505"/>
<link rel="preconnect" href="https://fonts.gstatic.com"/>
{* CDN Configuration *}
{* <meta property="ix:host" content="abs.imgix.net"/>
<script src="/public/lib/imgix.js"></script> *}
</head>
     