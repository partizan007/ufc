The user <a href="{$oUserTopic->getUserWebPath()}">{$oUserTopic->getLogin()}</a> has posted a new topic - <a href="{$oTopic->getUrl()}">{$oTopic->getTitle()|escape:'html'}</a><br> in the blog <b>«{$oBlog->getTitle()|escape:'html'}»</b>
														
<br><br>
Best regards, 
<br>
<a href="{Config::Get('path.root.url')}">{Config::Get('view.name')}</a>