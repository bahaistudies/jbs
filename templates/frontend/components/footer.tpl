{**
 * templates/frontend/components/footer.tpl
 *
 * Copyright (c) 2014-2016 Simon Fraser University
 * Copyright (c) 2003-2016 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Common site frontend footer.
 *}
<footer class="site-footer">
    <div class="container site-footer-sidebar" role="complementary"
        aria-label="{translate|escape key="common.navigation.sidebar"}">
        <div class="row">
            {call_hook name="Templates::Common::Sidebar"}
        </div>
    </div>
    <div class="container site-footer-content">
        <div class="row">
            {if $pageFooter}
                <div class="col-md site-footer-content align-self-center">
                    {$pageFooter}
                </div>
            {/if}

            <div class="col-md col-md-2 align-self-center text-right">
                <a href="{url page="about" op="aboutThisPublishingSystem"}">
                    <img class="footer-brand-image" alt="{translate key="about.aboutThisPublishingSystem"}"
                        src="{$baseUrl}/{$brandImage}">
                </a>
            </div>
        </div>
    </div>
</footer><!-- pkp_structure_footer_wrapper -->

{* Load author biography modals if they exist *}
{if !empty($smarty.capture.authorBiographyModals|trim)}
    {$smarty.capture.authorBiographyModals}
{/if}

{* Login modal *}
<div id="loginModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                {include file="frontend/components/loginForm.tpl" formType = "loginModal"}
            </div>
        </div>
    </div>
</div>

{load_script context="frontend" scripts=$scripts}
<link
    href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400;1,700&family=Lora:wght@500&display=swap"
    rel="stylesheet">
<script src="//instant.page/5.1.0" type="module"
    integrity="sha384-by67kQnR+pyfy8yWP4kPO12fHKRLHZPfEsiSXR8u2IKcTdxD805MGUXBzVPnkLHw"></script>
{call_hook name="Templates::Common::Footer::PageFooter"}
</body>

</html>