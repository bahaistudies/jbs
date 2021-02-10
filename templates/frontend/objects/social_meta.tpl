{**
 * templates/frontend/objects/social_meta.tpl
 *
 * Copyright (c) 2021 Ben Altair, Association for Baha'i Studies, https://bahaistudies.ca/
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Prepares open graph and twitter social tags for the header for SEO and sharing.
 *
 *}
{* Assigning a global variable for image CDN base URL *}
{assign var="cdn" value="https://abs.imgix.net" scope="root"}
    {* Open Graph / Twitter Tags *}
{if $article}
    <meta property="og:type" content="article"/>
{else}
    <meta property="og:type" content="website"/>
{/if}
{if $article}
{foreach from=$pubIdPlugins item=pubIdPlugin}
{if $pubIdPlugin->getPubIdType() != 'doi'}
    {continue}
{/if}
{assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
{if $pubId}
    {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
<meta property="og:url" content="{$doiUrl}"/>
{else}
    <meta property="og:url" content="{$currentUrl}"/>
{/if}
{/foreach}
{else}
    <meta property="og:url" content="{$currentUrl}"/>
{/if}
{if $article}
{assign var=articleTitle value=$article->getLocalizedTitle()|strip_unsafe_html}
    <meta property="og:title" content="{$articleTitle}"/>
    <meta name="title" content="{$articleTitle}"/>
{else}
{assign var=siteTitle value=$pageTitleTranslated|strip_tags}
    <meta property="og:title" content="{$siteTitle}"/>
    <meta name="title" content="{$siteTitle}"/>
{/if}
    <meta property="og:site_name" content="{if $currentJournal}{$currentJournal->getLocalizedPageHeaderTitle()|strip_tags:false|escape|strip}{else}{$pageTitleTranslated}{/if}"/>
{if $article}
    <meta property="og:description" content="{$article->getAuthorString()|escape}, published in The Journal of Bahá’í Studies"/>
{else}
    <meta property="og:description" content="A peer-reviewed academic journal by the Association for Bahá’í Studies."/>
{/if}
{if $article or $issue}
{if $issue->getLocalizedCoverImageUrl()}
    <meta property="og:image" content="{$cdn}/public/images/desk.jpg?mark={$issue->getLocalizedCoverImageUrl()|escape}&mark-w=360&mark-x=315&mark-y=323&mark-rot=23&crop=left&h=900&w=900&fit=crop"/>
    <meta property="og:image:secure_url" content="{$cdn}/public/images/desk.jpg?mark={$issue->getLocalizedCoverImageUrl()|escape}&mark-w=360&mark-x=315&mark-y=323&mark-rot=23&crop=left&h=900&w=900&fit=crop"/>
    <meta property="twitter:image" content="{$cdn}/public/images/desk.jpg?mark={$issue->getLocalizedCoverImageUrl()|escape}&mark-w=360&mark-x=315&mark-y=323&mark-rot=23&crop=left&h=900&w=900&fit=crop"/>
{elseif $issue->getIssueSeries()}
{assign var=basicCover value="{$cdn}/public/images/blank-cover.png?w=400&h=600&mark64=aHR0cHM6Ly9hYnMuaW1naXgubmV0L3B1YmxpYy9pbWFnZXMvamJzLXdoaXRlLnBuZw&mark-align=middle%2Ccenter&mark-w=0.80&mark-y=106&txt={if $issue->getIssueSeries()}{$issue->getIssueSeries()}{/if}&txt-font=PTSerif-Regular&txt-color=fff&txt-align=middle%2Ccenter&txt-size=22&txt-clip=ellipsis&auto=format&exp=-10&hue=132&bg=00395B&blend64=aHR0cHM6Ly9hYnMuaW1naXgubmV0L3B1YmxpYy9pbWFnZXMvZmxvdXJpc2gucG5nP2ludmVydD10cnVlJnJvdD0xODA&blend-align=bottom%2Ccenter&blend-w=0.30&blend-mode=normal&blend-y=203"}
    <meta property="og:image" content="{$cdn}/public/images/desk.jpg?mark64={base64_encode($basicCover)}&mark-w=360&mark-x=315&mark-y=323&mark-rot=23&crop=left&h=900&w=900&fit=crop"/>
    <meta property="og:image:secure_url" content="{$cdn}/public/images/desk.jpg?mark64={base64_encode($basicCover)}&mark-w=360&mark-x=315&mark-y=323&mark-rot=23&crop=left&h=900&w=900&fit=crop"/>
    <meta property="twitter:image" content="{$cdn}/public/images/desk.jpg?mark64={base64_encode($basicCover)}&mark-w=360&mark-x=315&mark-y=323&mark-rot=23&crop=left&h=900&w=900&fit=crop"/>
{else}
    <meta property="og:image" content="{$cdn}/public/images/jbs-mockup.png?txt={$issue->getIssueSeries()|escape}&txt-align=middle%2C%20center&txt-font=PTSerif-Bold&txt-size=50&txt-color=white&txt-pad=100&w=900&h=900&fit=clip&txt-shad=42&txt-clip=ellipsis"/>
    <meta property="og:image:secure_url" content="{$cdn}/public/images/jbs-mockup.png?txt={$issue->getIssueSeries()|escape}&txt-align=middle%2C%20center&txt-font=PTSerif-Bold&txt-size=50&txt-color=white&txt-pad=100&w=900&h=900&fit=clip&txt-shad=42&txt-clip=ellipsis"/>
    <meta property="twitter:image" content="{$cdn}/public/images/jbs-mockup.png?txt={$issue->getIssueSeries()|escape}&txt-align=middle%2C%20center&txt-font=PTSerif-Bold&txt-size=50&txt-color=white&txt-pad=100&w=900&h=900&fit=clip&txt-shad=42&txt-clip=ellipsis"/>
{/if}
{else}
    <meta property="og:image" content="{$cdn}/public/images/jbs-mockup.png?h=900&w=900&fit=crop"/>
    <meta property="og:image:secure_url" content="{$cdn}/public/images/jbs-mockup.png?h=900&w=900&fit=crop"/>
    <meta property="twitter:image" content="{$cdn}/public/images/jbs-mockup.png?h=900&w=900&fit=crop"/>
{/if}
    <meta property="og:image:width" content="900"/>
    <meta property="og:image:height" content="900"/>
    <meta property="og:image:alt" content="The cover of this journal issue." />
{if $article}
{assign var=lastModifiedDate value=$article->getLastModified()|date_format:'%Y-%m-%d'}
{assign var=lastPublishedDate value=$article->getDatePublished()|date_format:'%Y-%m-%d'}
    <meta property="og:article:modified_time" content="{$lastModifiedDate}"/>
    <meta name="article-modified_time" property="article:modified_time" content="{$lastModifiedDate}">
    <meta name="publish_date" property="og:article:published_time" content="{$lastPublishedDate}"/>
    <meta name="article-published_time" property="article:published_time" content="{$lastPublishedDate}"/>
{elseif $article}
{assign var=lastPublishedDate value=$article->getDatePublished()|date_format:'%Y-%m-%d'}
    <meta name="publish_date" property="og:article:published_time" content="{$lastPublishedDate}"/>
    <meta name="article-published_time" property="article:published_time" content="{$lastPublishedDate}"/>
{/if}
{if $article}
    <meta property="og:article:section" content="{$section->getLocalizedTitle()|escape}"/>
{/if}
{if $article}
    {foreach from=$article->getAuthors() item=author  name=foo}
{assign var=authorName value=$author->getFullName()|escape}
<meta property="og:article:author" content="{$authorName}"/>
    <meta name="author" content="{$authorName}"/>
    {/foreach}
{/if}
<meta property="og:locale" content="{$primaryLocale}"/>
{if $languageToggleLocales && $languageToggleLocales|@count > 1}
{foreach from=$languageToggleLocales item="localeName" key="localeKey"}
{if $localeKey !== $currentLocale}
    <meta property="og:locale:alternate" content="{$localeKey}"/>
{/if}
{/foreach}
{/if}
{if !empty($keywords[$currentLocale])}
{foreach from=$keywords item=keyword}
{foreach name=keywords from=$keyword item=keywordItem}
    <meta property="og:article:tag" content="{$keywordItem|escape}"/>
{/foreach}
{/foreach}
    <meta name="keywords" content="{foreach from=$keywords item=keyword}{foreach name=keywords from=$keyword item=keywordItem}{$keywordItem|escape}{if not $smarty.foreach.keywords.last}, {/if}{/foreach}{/foreach}"/>
{/if}
    <meta property="twitter:card" content="summary"/>
    <meta property="twitter:url" content="{$currentUrl}"/>
    <meta property="twitter:site" content="@bahaistudies"/>
    <meta property="twitter:title" content="{$pageTitleTranslated|strip_tags}"/>
{if $article}
    <meta property="twitter:description" content="{$article->getAuthorString()|escape}, published in The Journal of Bahá’í Studies"/>
    <meta name="description" content="An article published in The Journal of Bahá’í Studies by {$article->getAuthorString()|escape}."/>
{else}
    <meta property="twitter:description" content="A peer-reviewed academic journal by the Association for Bahá’í Studies, connecting the teachings of the Bahá’í Faith to the needs of humanity."/>
    <meta name="description" content="A peer-reviewed academic journal by the Association for Bahá’í Studies, connecting the teachings of the Bahá’í Faith to the needs of humanity."/>
{/if}
    <meta property="twitter:image:alt" content="The cover of this journal issue." />