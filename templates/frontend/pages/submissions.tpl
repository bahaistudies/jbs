{**
 * templates/frontend/pages/submissions.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the page to view the editorial team.
 *
 * @uses $currentContext Journal|Press The current journal or press
 * @uses $submissionChecklist array List of requirements for submissions
 *}
{include file="frontend/components/header.tpl" pageTitle="about.submissions"}

<style>
@font-face {
  font-family: 'fa';
  src: url('../../public/font/fa.eot?48052187');
  src: url('../../public/font/fa.eot?48052187#iefix') format('embedded-opentype'),
       url('../../public/font/fa.woff2?48052187') format('woff2'),
       url('../../public/font/fa.woff?48052187') format('woff'),
       url('../../public/font/fa.ttf?48052187') format('truetype'),
       url('../../public/font/fa.svg?48052187#fa') format('svg');
  font-weight: normal;
  font-style: normal;
}
 
 [class^="fa-"]:before, [class*=" fa-"]:before {
  font-family: "fa";
  font-style: normal;
  font-weight: normal;
  speak: never;
 
  display: inline-block;
  text-decoration: inherit;
  width: 1em;
  margin-right: .2em;
  text-align: center;
  /* opacity: .8; */
 
  /* For safety - reset parent styles, that can break glyph codes*/
  font-variant: normal;
  text-transform: none;
 
  /* fix buttons height, for twitter bootstrap */
  line-height: 1em;
 
  /* Animation center compensation - margins should be symmetric */
  /* remove if not needed */
  margin-left: .2em;
 
  /* you can be more comfortable with increased icons size */
  /* font-size: 120%; */
 
  /* Font smoothing. That was taken from TWBS */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
 
  /* Uncomment for 3D effect */
  /* text-shadow: 1px 1px 1px rgba(127, 127, 127, 0.3); */
}
 
.fa-ok-circled:before { content: '\e800'; } /* '' */
.fa-check-circle:before { content: '\e801'; } /* '' */
</style>
<div class="container page-submissions">
	<div class="row page-header justify-content-md-center">
		<div class="col-md-8">
			<h1>{translate key="about.submissions"}</h1>
		</div>
	</div>
	<div class="row justify-content-md-center">
		<div class="col-md-8">
			<div class="page-content">

				{* Login/register prompt *}
				{if $isUserLoggedIn}
					{capture assign="newSubmission"}<a href="{url page="submission" op="wizard"}">{translate key="about.onlineSubmissions.newSubmission"}</a>{/capture}
					{capture assign="viewSubmissions"}<a href="{url page="submissions"}">{translate key="about.onlineSubmissions.viewSubmissions"}</a>{/capture}
					<div class="alert alert-primary">
						{translate key="about.onlineSubmissions.submissionActions" newSubmission=$newSubmission viewSubmissions=$viewSubmissions}
					</div>
				{else}
					{capture assign="login"}<a href="{url page="login"}">{translate key="about.onlineSubmissions.login"}</a>{/capture}
					{capture assign="register"}<a href="{url page="user" op="register"}">{translate key="about.onlineSubmissions.register"}</a>{/capture}
					<div class="alert alert-primary">
						{translate key="about.onlineSubmissions.registrationRequired" login=$login register=$register}
					</div>
				{/if}

				{if $submissionChecklist}
					<div class="submissions-checklist">
						<h2>
							{translate key="about.submissionPreparationChecklist"}
							{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.submissionPreparationChecklist"}
						</h2>
						{translate key="about.submissionPreparationChecklist.description"}
						<ul>
							{foreach from=$submissionChecklist item=checklistItem}
								<li>
                                    <span class="fa fa-check-circle" aria-hidden="true"></span>
									{$checklistItem.content}
								</li>
							{/foreach}
						</ul>
					</div>
				{/if}

				{if $currentContext->getLocalizedSetting('authorGuidelines')}
					<div class="submissions-author-guidelines">
						<h2>
							{translate key="about.authorGuidelines"}
							{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.authorGuidelines"}
						</h2>
						{$currentContext->getLocalizedSetting('authorGuidelines')}
					</div>
				{/if}

				{if $currentContext->getLocalizedSetting('copyrightNotice')}
					<div class="submissions-copyright-notice">
						<h2>
							{translate key="about.copyrightNotice"}
							{include file="frontend/components/editLink.tpl" page="management" op="settings" path="distribution" anchor="permissions" sectionTitleKey="about.copyrightNotice"}
						</h2>
						{$currentContext->getLocalizedSetting('copyrightNotice')}
					</div>
				{/if}

				{if $currentContext->getLocalizedSetting('privacyStatement')}
					<div class="submissions-privacy-statement">
						<h2>
							{translate key="about.privacyStatement"}
							{include file="frontend/components/editLink.tpl" page="management" op="settings" path="publication" anchor="submissionStage" sectionTitleKey="about.privacyStatement"}
						</h2>
						{$currentContext->getLocalizedSetting('privacyStatement')}
					</div>
				{/if}
			</div>
		</div>
	</div>
</div>

{include file="frontend/components/footer.tpl"}
