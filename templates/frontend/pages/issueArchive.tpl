{**
 * templates/frontend/pages/issueArchive.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a list of recent issues.
 *
 * @uses $issues Array Collection of issues to display
 * @uses $prevPage int The previous page number
 * @uses $nextPage int The next page number
 * @uses $showingStart int The number of the first item on this page
 * @uses $showingEnd int The number of the last item on this page
 * @uses $total int Count of all published monographs
 *}
{capture assign="pageTitle"}
    {if $prevPage}
        {translate key="archive.archivesPageNumber" pageNumber=$prevPage+1}
    {else}
        {translate key="archive.archives"}
    {/if}
{/capture}
{include file="frontend/components/header.tpl" pageTitleTranslated=$pageTitle}

<header class="page-header page-archives-header">
    <h1>{$pageTitle}</h1>
    <a class="btn btn-primary mobile" href="/online/search/" aria-hidden="true">Search Articles</a>
</header>

<section class="container page-archives" role="list">

    {if empty($issues)} {* No issues have been published *}
        <div class="page-header page-issue-header">
            {include file="frontend/components/notification.tpl" messageKey="current.noCurrentIssueDesc"}
        </div>

    {else} {* List issues *}
        {foreach from=$issues item="issue" key="i"}
            {include file="frontend/objects/issue_summary.tpl" heading="h2" role="listitem"}
        {/foreach}
    {/if}
</section>

{if $issues}
    <div class="container">
        {* Pagination *}
        {capture assign="prevUrl"}
            {if $prevPage > 1}
                {url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$prevPage}
            {elseif $prevPage === 1}
                {url router=$smarty.const.ROUTE_PAGE page="issue" op="archive"}
            {/if}
        {/capture}
        {capture assign="nextUrl"}
            {if $nextPage}
                {url router=$smarty.const.ROUTE_PAGE page="issue" op="archive" path=$nextPage}
            {/if}
        {/capture}
        {include
    			file="frontend/components/pagination.tpl"
    			prevUrl=$prevUrl|trim
    			nextUrl=$nextUrl|trim
    			showingStart=$showingStart
    			showingEnd=$showingEnd
    			total=$total
    		}
    </div>
{/if}

{include file="frontend/components/footer.tpl"}