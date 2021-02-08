{**
 * templates/frontend/objects/schema_json_ld.tpl
 *
 * Copyright (c) 2019 Ronny Bölter
 *
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Writes a schema.org jsonld string to the header. Should be reworked as a plugin and in a more elegant way.
 * TODO Rework as plugin!
 *
 * Found from forum post and adapted from Github here:
 * https://github.com/leibniz-psychology/psychopen-theme/blob/main/templates/frontend/objects/schema_json_ld.tpl
 *
 *}
{assign var="indexURI" value="{url page="index" }"}
{assign var=indexURI value=$indexURI|explode:"/index.php"}
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@graph": [
                {
                    "@type" : "Organization",
                    "@id": "https://journal.bahaistudies.ca/",
                    "name": "The Journal of Bahá’í Studies",
                    "logo": {
                        "@type": "ImageObject",
                        "name": "JBSLogo",
                        "url": "https://abs.imgix.net/public/images/jbs-black.png"
                    },
                    "url": "https://journal.bahaistudies.ca/",
                    "sameAs": [
                        "https://twitter.com/bahaistudies",
                        "https://vimeo.com/bahaistudies",
                        "https://www.facebook.com/bahaistudies/",
                        "https://www.instagram.com/bahaistudies/"
                    ],
                    "memberOf" : {
                        "@type" : "Organization",
                        "@id": "https://bahaistudies.ca/",
                        "url": "https://bahaistudies.ca/",
                        "name": "Association for Bahá’í Studies",
                        "logo": {
                            "@type": "ImageObject",
                            "name": "ABSLogo",
                            "url": "https://abs.imgix.net/public/images/abs-black.png?"
                        },
                        "address":{
                            "@type" : "PostalAddress",
                            "addressCountry": "Canada",
                            "addressLocality": "Ottawa",
                            "addressRegion": "Ontario",
                            "postalCode": "K1N 7K4",
                            "streetAddress": "34 Copernicus Street"
                        },
                        "email" : "abs-na@bahaistudies.ca",
                        "telephone": "+1 613-233-1903"
                    }
                }{if $requestedPage=='index' || $requestedPage==''},
                    {

                        "@type" : "WebSite",
                        "@id": "{$indexURI[0]}",
                        "url": "{$indexURI[0]}",
                        "name": "{if $currentJournal}{$currentJournal->getLocalizedPageHeaderTitle()|strip_tags:false|escape|strip}{else}{$pageTitleTranslated}{/if}",
                        {if $journalDescription}
                          "description": "{$journalDescription|strip_tags:false|escape|strip}",
                        {/if}
                        "potentialAction" : {
                            "@type" : "SearchAction",
                            "target" : "{url page="search"}?query={ldelim}srch_str{rdelim}",
                            "query-input": "required name=srch_str"
                        },
                        "accessMode": ["textual", "visual"],
                        "accessModeSufficient": ["textual", "visual"],
                        "accessibilityAPI": "ARIA",
                        "issn": [{if $printIssn}"{$printIssn}"{/if}{if $printIssn && $onlineIssn}, {/if}{if $onlineIssn}"{$onlineIssn}"{/if}
                        ],
                        "image": {
                        "https://abs.imgix.net/public/icons/jbs-mockup.png"
                       },
                        "license": "https://creativecommons.org/licenses/by-nc-sa/4.0/",
                        "copyrightHolder" :{
                            "@type" : "Organization",
                            "@id": "https://bahaistudies.ca/"
                        },
                        "publisher": {
                            "@type" : "Organization",
                            "@id": "https://journal.bahaistudies.ca/"
                        }
                    }
                {/if}{if $issue && $currentJournal && $requestedPage!='index' && $requestedPage!=''},
                    {assign var="thumb" value=$currentJournal->getLocalizedSetting('journalThumbnail')}
                    {
                        "@id": "{url page="issue" op="view" path=$issue->getId()}",
                        "@type": "PublicationIssue",
                        "issueNumber": "{$issue->getNumber()}",
                        "datePublished": "{$issue->getDatePublished()|date_format:"%Y-%m-%d"}",
                        "name" : "{$issue->getLocalizedTitle()|strip_tags:false|escape|strip}",
                        {if $issueCover}
                            "image": "{$issueCover|escape}",
                        {elseif $issueThumb}
                            "image": "{$publicFilesDir}/{$issueThumb}",
                        {/if}
                        {if $publishedArticles}
                            "hasPart":[
                                {foreach name=sections from=$publishedArticles item=section name=foo}
                                    {foreach from=$section.articles item=article name=bar}
                                        {
                                            "@type": "ScholarlyArticle",
                                            "headline" : "{$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip|truncate:110}",
                                            "name" : "{$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip}",
                                            "mainEntityOfPage": {
                                                "@type": "WebPage",
                                                "url": "{url page="article" op="view" path=$article->getId()}",
                                                "@id": "{url page="article" op="view" path=$article->getId()}",
                                                "name": "{$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip|truncate:110}"
                                            },
                                            "image": {
                                            "https://abs.imgix.net/public/icons/jbs-mockup.png"
                                           },
                                            {*"@id": "{url page="article" op="view" path=$article->getId()}",*}
                                            "url": "{url page="article" op="view" path=$article->getId()}",
                                                {if $article->getLocalizedCoverImage()}
                                                    "image": "{$article->getLocalizedCoverImageUrl()|escape}",
                                                {elseif $issueCover}
                                                    "image": "{$issueCover|escape}",
                                                {elseif $issueThumb}
                                                    "image": "{$publicFilesDir}/{$issueThumb}",
                                                {elseif $thumb}
                                                    "image": "{$publicFilesDir}/{$thumb.uploadName|escape:"url"}",
                                                {/if}
                                                {if $article->getAuthors()}
                                                    "author": [
                                                        {foreach from=$article->getAuthors() item=author  name=foo}
                                                            {
                                                                "@type": "Person",
                                                                {if $author->getLocalizedAffiliation()}
                                                                    "affiliation": "{$author->getLocalizedAffiliation()|strip_tags:false|escape|strip}",
                                                                {/if}
                                                                {if $author->getOrcid()}
                                                                    "sameAs": "{$author->getOrcid()|escape}",
                                                                {/if}
                                                                "name" : "{$author->getFullName()|strip_tags:false|escape|strip}"
                                                            }{if not $smarty.foreach.foo.last},{/if}
                                                        {/foreach}
                                                    ],
                                                {/if}
                                            "pagination": "{$article->getPages()|escape}",
                                            {if $article->getDatePublished()}
                                              "datePublished": "{$article->getDatePublished()|date_format:"%Y-%m-%d"}",
                                            {/if}
                                            {if $article->getLastModified()}
                                                "dateModified": "{$article->getLastModified()|date_format:"%Y-%m-%d"}",
                                            {elseif $article->getDatePublished()}
                                                "dateModified": "{$article->getDatePublished()|date_format:"%Y-%m-%d"}",
                                            {/if}
                                                "publisher": {
                                                    "@type" : "Organization",
                                                    "@id": "https://journal.bahaistudies.ca/",
                                                    "url": "https://journal.bahaistudies.ca/"
                                                }
                                        }{if not ($smarty.foreach.foo.last && $smarty.foreach.bar.last)},{/if}
                                    {/foreach}
                                {/foreach}
                            ],
                        {/if}
                        "isPartOf": {
                            "@type": [
                                "PublicationVolume",
                                "Periodical"
                            ],
                            "name": "{$currentJournal->getLocalizedPageHeaderTitle()|strip_tags:false|escape|strip}",
                            "issn": [
                                {if $printIssn}"{$printIssn}",{/if}
                                {if $onlineIssn}"{$onlineIssn}"{/if}
                            ],
                            "volumeNumber" : "{$issue->getVolume()}",
                            "datePublished" : "{$issue->getYear()}",
                            "publisher": {
                                "@type" : "Organization",
                                "@id": "https://journal.bahaistudies.ca/",
                                "url": "https://journal.bahaistudies.ca/"
                            }
                        }
                    }{if $article && not $publishedArticles},
                        {foreach from=$pubIdPlugins item=pubIdPlugin}
        {if $pubIdPlugin->getPubIdType() == 'doi'}
        {if $issue->getPublished()}
        {assign var=pubId value=$article->getStoredPubId($pubIdPlugin->getPubIdType())}
        {else}
        {assign var=pubId value=$pubIdPlugin->getPubId($article)}{* Preview pubId *}
        {/if}
        {/if}
        {/foreach}
        {if $pubId}
        {assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
        {/if}
                        {
                                "@type": "WebPage",
                                "@id": "{url page="article" op="view" path=$article->getId()}",
                                "url": "{url page="article" op="view" path=$article->getId()}",
                                "name": "{$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip}",
                                "description": "{$article->getLocalizedAbstract()|strip_tags:false|escape|strip}",
                                "breadcrumb": "Archives > Volume {$issue->getVolume()}({$issue->getNumber()}) > {$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip|truncate:110}",
                                "speakable":
                                 {
                                  "@type": "SpeakableSpecification",
                                  "xpath": [
                                    "/html/head/title",
                                    "/html/head/meta[@name='description']/@content"
                                    ]
                                  },
                                "isPartOf": {
                                    "@type" : "Website",
                                    "@id": "{$indexURI[0]}",
                                    "url": "{$indexURI[0]}",
                                    "name": "{if $currentJournal}{$currentJournal->getLocalizedPageHeaderTitle()|strip_tags:false|escape|strip}{else}{$pageTitleTranslated}{/if}"
                                },
                                "mainEntity": {
                            "@type": "ScholarlyArticle",
                            {*"@id": "{url page="article" op="view" path=$article->getId()}",*}
                            "mainEntityOfPage": "{url page="article" op="view" path=$article->getId()}",
                            "image":
{if $issue->getLocalizedCoverImageUrl()}
                            "{$issue->getLocalizedCoverImageUrl()|escape}"
{elseif $issue->getIssueSeries()}
                            "https://abs.imgix.net/public/images/blank-cover.png?w=400&h=600&mark64=aHR0cHM6Ly9hYnMuaW1naXgubmV0L3B1YmxpYy9pbWFnZXMvamJzLXdoaXRlLnBuZw&mark-align=middle%2Ccenter&mark-w=0.80&mark-y=106&txt={$issue->getIssueSeries()}&txt-font=PTSerif-Regular&txt-color=fff&txt-align=middle%2Ccenter&txt-size=22&txt-clip=ellipsis&auto=format&exp=-10&hue=132&bg=00395B&blend64=aHR0cHM6Ly9hYnMuaW1naXgubmV0L3B1YmxpYy9pbWFnZXMvZmxvdXJpc2gucG5nP2ludmVydD10cnVlJnJvdD0xODA&blend-align=bottom%2Ccenter&blend-w=0.30&blend-mode=normal&blend-y=203"
{else}
                            "https://abs.imgix.net/public/icons/jbs-mockup.png"
{/if}
                           ,
                            "isPartOf":
                                {
                                    "@type": "PublicationIssue",
                                    "@id": "{url page="issue" op="view" path=$issue->getId()}",
                                    "url": "{url page="issue" op="view" path=$issue->getId()}",
                                    "name" : "{$issue->getLocalizedTitle()|strip_tags:false|escape|strip}",
                                    "issueNumber": "{$issue->getNumber()}",
                                    "datePublished": "{$issue->getDatePublished()|date_format:"%Y-%m-%d"}"
                                },
                            "headline" : "{$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip|truncate:110}",
                            "name" : "{$article->getLocalizedTitle($article->getLocale())|strip_tags:false|escape|strip}",
                             {if $article->getLocalizedSubtitle($article->getLocale())}
                                "alternativeHeadline":"{$article->getLocalizedSubtitle($article->getLocale())|strip_tags:false|escape|strip|truncate:110}",
                            {/if}
        {if $article->getLocalizedCoverImage()}
                                "image": "{$article->getLocalizedCoverImageUrl()|escape}",
                            {elseif $issueCover}
                                "image": "{$issueCover|escape}",
                            {elseif $issueThumb}
                                "image": "{$publicFilesDir}/{$issueThumb}",
                            {/if}
                            "description": "{$article->getLocalizedAbstract()|strip_tags:false|escape|strip}",
                            {if $doiUrl}
                                "sameAs": "{$doiUrl}",
                            {/if}
        {if $section && $section->getLocalizedTitle()}
                                "articleSection" : "{$section->getLocalizedTitle()|escape}",
                            {/if}
        {if $article->getDatePublished()}
                                "datePublished": "{$article->getDatePublished()|date_format:"%Y-%m-%d"}",
                            {/if}
        {if $article->getLastModified()}
                                "dateModified": "{$article->getLastModified()|date_format:"%Y-%m-%d"}",
                            {elseif $article->getDatePublished()}
                                "dateModified": "{$article->getDatePublished()|date_format:"%Y-%m-%d"}",
                            {/if}
                            "url" : "{url page="article" op="view" path=$article->getId()}",
                            "pagination": "{$article->getPages()|escape}",
                            "publisher": {
                                "@type" : "Organization",
                                "@id": "https://journal.bahaistudies.ca/",
                                "url": "https://journal.bahaistudies.ca/"
                            },
                            {if $article->getGalleys()}
        {assign var="galleysTotalView" value=0}
        {foreach from=$article->getGalleys() item=galley name=galleyList}
        {assign var="galleysTotalView" value=$galleysTotalView+$galley->getViews()}
        {/foreach}
                                "interactionStatistic": {
                                    "@type": "InteractionCounter",
                                    "userInteractionCount": "{$galleysTotalView}"
                                },
                            {/if}
        {if $article->getAuthors()}
                                "author": [
                                    {foreach from=$article->getAuthors() item=author  name=foo}
                                        {
                                            "@type": "Person",
                                            {if $author->getLocalizedAffiliation()}
                                                "affiliation": "{$author->getLocalizedAffiliation()|strip_tags:false|escape|strip}",
                                            {/if}
        {if $author->getOrcid()}
                                                "sameAs": "{$author->getOrcid()|escape}",
                                            {/if}
                                            "name" : "{$author->getFullName()|escape}"
                                        }{if not $smarty.foreach.foo.last},{/if}
        {/foreach}
                                ],
                            {/if}
                            "isAccessibleForFree": "true",
                            "inLanguage": "{$article->getLocale()}"
                        }
                         }
                    {/if}
        {/if}
            ]
        }
    </script>
    {if $announcements}
        {assign var="thumb" value=$currentJournal->getLocalizedSetting('journalThumbnail')}
        <script type="application/ld+json">
            {
                "@context": "http://schema.org",
                "@graph": [
                    {foreach name=announcements from=$announcements item=announcement name=foo}
                        {
                            "@type": "NewsArticle",
                            "headline": "{$announcement->getLocalizedTitle()|strip_tags:false|escape|strip}",
                            "datePublished": "{$announcement->getDatePosted()|date_format:"%Y-%m-%d"}",
                            "dateModified": "{$announcement->getDatePosted()|date_format:"%Y-%m-%d"}",
                            "url": "{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}",
                            {if $thumb}
                                "image": "{$publicFilesDir}/{$thumb.uploadName|escape:"url"}",
                            {/if}
                            "mainEntityOfPage": {
                                "@type": "WebPage",
                                "@id": "{url router=$smarty.const.ROUTE_PAGE page="announcement" op="view" path=$announcement->getId()}"
                            },
                            {if $announcement->getLocalizedDescription()}
                                "articleBody": "{$announcement->getLocalizedDescription()|strip_tags:false|escape|strip}",
                            {else}
                                "articleBody": "{$announcement->getLocalizedDescriptionShort()|strip_tags:false|escape|strip}",
                            {/if}
                            "author": "{$currentJournal->getLocalizedPageHeaderTitle()|strip_tags:false|escape|strip}",
                            "publisher": {
                                "@type" : "Organization",
                                "@id": "https://journal.bahaistudies.ca/",
                                "url": "https://journal.bahaistudies.ca/"
                            }
                        }{if not $smarty.foreach.foo.last},{/if}
            {/foreach}
                ]
            }
        </script>
    {/if}