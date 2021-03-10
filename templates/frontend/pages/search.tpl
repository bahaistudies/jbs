{**
 * templates/frontend/pages/search.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to search and view search results.
 *
 * @uses $query Value of the primary search query
 * @uses $authors Value of the authors search filter
 * @uses $dateFrom Value of the date from search filter (published after).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $dateTo Value of the date to search filter (published before).
 *  Value is a single string: YYYY-MM-DD HH:MM:SS
 * @uses $yearStart Earliest year that can be used in from/to filters
 * @uses $yearEnd Latest year that can be used in from/to filters
 *}
{include file="frontend/components/header.tpl" pageTitle="common.search"}

<div class="container page-search" data-instant-allow-query-string>
    <div class="page-header">
        <h1>
            {if $query}
                {translate key="plugins.themes.healthSciences.search.resultsFor" query=$query|escape}
            {elseif $authors}
                {translate key="plugins.themes.healthSciences.search.resultsFor" query=$authors|escape}
            {/if}
        </h1>
    </div>
    <div class="row justify-content-lg-center">
        <div class="search-col-filters">
            <div class="search-filters">

                {capture name="searchFormUrl"}{url op="search" escape=false}{/capture}
                {$smarty.capture.searchFormUrl|parse_url:$smarty.const.PHP_URL_QUERY|parse_str:$formUrlParameters}
                <form class="form-search" method="get" action="{$smarty.capture.searchFormUrl|strtok:"?"|escape}">
                    {foreach from=$formUrlParameters key=paramKey item=paramValue}
                        <input type="hidden" name="{$paramKey|escape}" value="{$paramValue|escape}" />
                    {/foreach}
                    <div class="form-group form-group-query">
                        <label for="query">
                            {translate key="common.searchQuery"}
                        </label>
                        <input type="text" class="form-control" id="query" name="query" value="{$query|escape}"
                            autofocus>
                    </div>
                    <div class="form-group form-group-buttons">
                        <button class="btn btn-primary" type="submit">{translate key="common.search"}</button>
                        <button class="btn" type="button" id="adv-toggle"
                            onclick="toggle_visibility('advanced');">{translate key="search.advancedFilters"}</button>
                        <script type="text/javascript">
                            function toggle_visibility(id) {
                                var advanced = document.getElementById(id);
                                var button = document.getElementById('adv-toggle');
                                if (advanced.style.display == 'grid') {
                                    advanced.style.display = 'none';
                                    button.classList.remove("enabled");
                                } else {
                                    advanced.style.display = 'grid';
                                    button.classList.add("enabled");
                                }
                            }
                        </script>
                    </div>
                    <div class="advanced-queries" id="advanced" style="display: none;">
                        <h2>{translate key="search.advancedFilters"}</h2>
                        <div class="form-group form-group-title">
                            <label for="title">
                                {translate key="search.title"}
                            </label>
                            <input type="text" class="form-control" id="title" name="title" value="{$title|escape}">
                        </div>
                        <div class="form-group form-group-authors">
                            <label for="authors">
                                {translate key="search.author"}
                            </label>
                            <input type="text" class="form-control" id="authors" name="authors"
                                value="{$authors|escape}">
                        </div>
                        <div class="form-group form-group-date-from">
                            <label for="dateFromYear">
                                {translate key="search.dateFrom"}
                            </label>
                            <div class="form-control-date">
                                {html_select_date class="form-control" prefix="dateFrom" time=$dateFrom start_year=$yearStart end_year=$yearEnd year_empty="Year" month_empty="Month" day_empty="Day" field_order="YMD"}
                            </div>
                        </div>
                        <div class="form-group form-group-date-to">
                            <label for="dateToYear">
                                {translate key="search.dateTo"}
                            </label>
                            <div class="form-control-date">
                                {html_select_date class="form-control" prefix="dateTo" time=$dateTo start_year=$yearStart end_year=$yearEnd year_empty="Year" month_empty="Month" day_empty="Day" field_order="YMD"}
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="search-col-results">
            <div class="search-results">
                {* No results found *}
            {if $results->wasEmpty()}
                {if $error}
                    <div class="alert alert-danger" role="alert">{$error|escape}</div>
                {elseif $searchFormUrl == ""}
                    <div class="alert alert-primary" role="alert">{translate key="search.blank"}</div>
                {else}
                    <div class="alert alert-primary" role="alert">{translate key="search.noResults"}</div>
                {/if}
            </div>

            {* Results and pagination *}
            {elseif $results}
                {iterate from=results item=result}
                {include file="frontend/objects/article_summary.tpl" article=$result.publishedSubmission journal=$result.journal showDatePublished=true hideGalleys=true}
                {/iterate}
            </div>
            <div class="pagination">
                {page_info iterator=$results}
                {page_links anchor="results" iterator=$results name="search" query=$query searchJournal=$searchJournal authors=$authors title=$title abstract=$abstract galleyFullText=$galleyFullText discipline=$discipline subject=$subject type=$type coverage=$coverage indexTerms=$indexTerms dateFromMonth=$dateFromMonth dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateToMonth=$dateToMonth dateToDay=$dateToDay dateToYear=$dateToYear orderBy=$orderBy orderDir=$orderDir}
            </div>
            {else}
            </div>
            {/if}
    </div>
</div>
</div>
{include file="frontend/objects/clickable_cards.tpl"}
{include file="frontend/components/footer.tpl"}