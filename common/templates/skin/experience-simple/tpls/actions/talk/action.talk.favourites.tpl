 {* Тема оформления Experience v.1.0  для Alto CMS      *}
 {* @licence     CC Attribution-ShareAlike  http://site.creatime.org/experience/*}

{extends file="_index.tpl"}

{block name="layout_vars"}
    {$menu="topics"}
{/block}

{block name="layout_content"}

    {include file='menus/menu.talk.tpl'}

    {if $aTalks}
<div class="panel panel-default panel-table flat">
    <div class="panel-body">

        <table class="table table-talk">
            <thead>
            <tr>
                <script>
                    $(function(){
                        $('#ch-controls').on('ifChecked', function(e) {
                            $('.form_talks_checkbox').iCheck('check');
                        }).on('ifUnchecked', function(e) {
                            $('.form_talks_checkbox').iCheck('uncheck');
                        })
                    })
                </script>
                <th class="cell-checkbox text-left"><input type="checkbox" name="" id="ch-controls" class="input-checkbox"
                                                           onclick="

                                                     ls.tools.checkAll('form_talks_checkbox', this, true);">
                </th>
                <th class="cell-recipients">
                    {$aLang.talk_inbox_target}
                </th>

                <th class="cell-title">
                    {$aLang.talk_inbox_title}
                </th>
                <th class="table-talk-count"></th>
                <th class="cell-date ta-r">
                    {$aLang.talk_inbox_date}
                </th>
            </tr>
            </thead>

            <tbody>
            {foreach $aTalks as $oTalk}
                {$oTalkUserAuthor=$oTalk->getTalkUser()}
                <tr {if $oTalkUserAuthor->getCommentCountNew() OR !$oTalkUserAuthor->getDateLast()}class="new-talk"{/if}>
                    <td class="cell-checkbox">
                        <input type="checkbox" name="talk_select[{$oTalk->getId()}]" class="form_talks_checkbox input-checkbox"/>
                    </td>
                    <td class="table-talk-addressee text-muted">
                        {strip}
                            {$aTalkUserOther=[]}
                            {foreach $oTalk->getTalkUsers() as $oTalkUser}
                                {if $oTalkUser->getUserId()!=E::UserId()}
                                    {$aTalkUserOther[]=$oTalkUser}
                                {/if}
                            {/foreach}
                            {foreach $aTalkUserOther as $oTalkUser}
                                {$oUser=$oTalkUser->getUser()}
                                {if !$oTalkUser@first},{if !$oTalkUser@last}<br/>{/if} {/if}
                                <span data-alto-role="popover"
                                      data-api="user/{$oUser->getId()}/info"
                                      data-api-param-tpl="default"
                                      data-trigger="hover"
                                      data-placement="right"
                                      data-animation="true"
                                      data-cache="true"
                                      class="nowrap">
                                        <img src="{$oUser->getAvatarUrl(32)}" alt="{$oUser->getDisplayName()}"/>&nbsp;
                                    <a href="{$oUser->getProfileUrl()}" class="userlogo link link-dual link-lead link-clear mal0 {if $oTalkUser->getUserActive()!=$TALK_USER_ACTIVE}inactive{/if}">{$oUser->getDisplayName()}</a>
                                    </span>
                            {/foreach}
                        {/strip}
                    </td>

                    <td class="table-talk-content" {if !$oTalk->getCountComment()}colspan="2"{/if}>
                        <div>
                            {strip}
                                <a href="{router page='talk'}read/{$oTalk->getId()}/" class="js-title-talk link link-lead link-clear"
                                   title="{$oTalk->getTextLast()|strip_tags|truncate:100:'...'|escape:'html'}">
                                    {if E::UserId()==$oTalk->getUserIdLast()}
                                        <span class="text-success small"><i class="fa fa-sign-in"></i></span>
                                    {else}
                                        <span class="text-danger small"><i class="fa fa-sign-out"></i></span>
                                    {/if}
                                    &nbsp;

                                    {if $oTalkUserAuthor->getCommentCountNew() OR !$oTalkUserAuthor->getDateLast()}
                                        <strong>{$oTalk->getTitle()|escape:'html'}</strong>drther hertherth rehr
                                    {else}
                                        {$oTalk->getTitle()|escape:'html'}
                                    {/if}
                                </a>
                            {/strip}
                        </div>
                    </td>
                    {if $oTalk->getCountComment()}
                        <td class="table-talk-count">

                                <span class="text text-muted small">({$oTalk->getCountComment()}{if $oTalkUserAuthor->getCommentCountNew()}
                                    <span class="text text-info small">+{$oTalkUserAuthor->getCommentCountNew()}</span>{/if})</span>

                        </td>
                    {/if}
                    <td class="cell-date tac text small">
                        <div class="date-block">
                            <span class="date">{$oTalk->getDate()|date_format:'d.m.y'}</span>
                            <span class="time">{$oTalk->getDate()|date_format:'H:i'}</span>
                        </div>
                    </td>
                </tr>
            {/foreach}
            </tbody>
        </table>
    </div>
</div>
    {else}
        <div class="bg-warning">{$aLang.talk_favourite_empty}</div>
    {/if}

    {include file='commons/common.pagination.tpl' aPaging=$aPaging}

{/block}
