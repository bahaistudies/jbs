{**
 * templates/frontend/pages/issue.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display a landing page for a single issue. It will show the table of contents
 *  (toc) or a cover image, with a click through to the toc.
 *
 * @uses $issue Issue The issue
 * @uses $issueIdentification string Label for this issue, consisting of one or
 *       more of the volume, number, year and title, depending on settings
 * @uses $issueGalleys array Galleys for the entire issue
 *}
{include file="frontend/components/header.tpl" pageTitleTranslated=$issueIdentification}

<div class="container page-issue">

	{* Display a message if no current issue exists *}
	{if !$issue}
		<div class="page-header page-issue-header">
			{include file="frontend/components/notification.tpl" messageKey="current.noCurrentIssueDesc"}
		</div>

	{* Display an issue with the Table of Contents *}
	{else}
		<div class="page-header page-issue-header">

		{* Indicate if this is only a preview *}
		{if !$issue->getPublished()}
			{include file="frontend/components/notification.tpl" messageKey="editor.issues.preview"}
		{/if}

			<h1>{$issue->getIssueSeries()|escape}</h1>
			<div class="page-issue-date">
				{translate key="plugins.themes.healthSciences.currentIssuePublished" date=$issue->getDatePublished()|date_format:$dateFormatLong}
			</div>

			{* PUb IDs (eg - DOI) *}
			{foreach from=$pubIdPlugins item=pubIdPlugin}
				{assign var=pubId value=$issue->getStoredPubId($pubIdPlugin->getPubIdType())}
				{if $pubId}
					{assign var="doiUrl" value=$pubIdPlugin->getResolvingURL($currentJournal->getId(), $pubId)|escape}
					{if $doiUrl}
						{capture assign="pubId"}
							<a href="{$doiUrl}">
								{$doiUrl}
							</a>
						{/capture}
					{/if}
					<div class="page-issue-doi">
						{if $pubIdPlugin->getPubIdType() == 'doi'}
							{$pubId}
						{else}
							{translate key="plugins.themes.healthSciences.issuePubId" pubIdType=$pubIdPlugin->getPubIdDisplayType()|escape pubId=$pubId}
						{/if}
					</div>
				{/if}
			{/foreach}
		</div>

		<div class="row justify-content-center page-issue-details">
			{if $issueGalleys || $issue->hasDescription() || $issue->getLocalizedTitle()}
				<div class="col-lg-9">
					<div class="page-issue-description-wrapper">
						{if $issue->hasDescription() || $issue->getLocalizedTitle()}
							<div class="page-issue-description">
								<div class="h2">
									{if $issue->getLocalizedTitle()}
										{$issue->getLocalizedTitle()}
									{else}
										{translate key="plugins.themes.healthSciences.issueDescription"}
									{/if}
								</div>
								{$issue->getLocalizedDescription()|strip_unsafe_html}
							</div>
						{/if}
						{if $issueGalleys}
							<div class="page-issue-galleys">
								<div class="h3">
									{translate key="issue.fullIssue"}
								</div>
								{foreach from=$issueGalleys item=galley}
									{include file="frontend/objects/galley_link.tpl" parent=$issue purchaseFee=$currentJournal->getSetting('purchaseIssueFee') purchaseCurrency=$currentJournal->getSetting('currency')}
								{/foreach}
							</div>
						{/if}
					</div>
				</div>
			{/if}
				<div class="col-lg-3">
			{if $issue->getLocalizedCoverImageUrl()}
					<a href="{url op="view" page="issue" path=$issue->getBestIssueId()}">
						<img class="img-fluid page-issue-cover" src="{$issue->getLocalizedCoverImageUrl()|escape}"{if $issue->getLocalizedCoverImageAltText() != ''} alt="{$issue->getLocalizedCoverImageAltText()|escape}"{/if}>
					</a>
            {else}
                    <a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">
                        <img
                            class="img-fluid"
                            src="{$cdn}/public/images/blank-cover.png?w=400&h=600&mark64=aHR0cHM6Ly9hYnMuaW1naXgubmV0L3B1YmxpYy9pbWFnZXMvamJzLXdoaXRlLnBuZw&mark-align=middle%2Ccenter&mark-w=0.80&mark-y=106&txt={if $issue->getIssueSeries()}{$issue->getIssueSeries()}{/if}&txt-font=PTSerif-Regular&txt-color=fff&txt-align=middle%2Ccenter&txt-size=22&txt-clip=ellipsis&auto=format&exp=-10&hue=132&bg=00395B&blend64=aHR0cHM6Ly9hYnMuaW1naXgubmV0L3B1YmxpYy9pbWFnZXMvZmxvdXJpc2gucG5nP2ludmVydD10cnVlJnJvdD0xODA&blend-align=bottom%2Ccenter&blend-w=0.30&blend-mode=normal&blend-y=203"
                            alt="{$issue->getLocalizedCoverImageAltText()|escape|default:'Default issue cover, since no cover was available.'}"
                        >
                    </a>
			{/if}
				</div>
		</div><!-- .row -->

		<div class="row{if !$issue->getLocalizedDescription() || !$issue->getLocalizedCoverImageUrl()} issue-wrapper{/if}">
			<div class="col-12 col-lg-9">
				{include file="frontend/objects/issue_toc.tpl" sectionHeading="h2"}
			</div>
		</div>
	{/if}
</div>

{include file="frontend/components/footer.tpl"}
