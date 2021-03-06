<#--
Copyright (c) 2012, Cornell University
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimer in the documentation
      and/or other materials provided with the distribution.
    * Neither the name of Cornell University nor the names of its contributors
      may be used to endorse or promote products derived from this software
      without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-->

</div> <!-- #wrapper-content -->

<footer role="contentinfo">
    <p class="copyright">
        <#if copyright??>
            <small>&copy;${copyright.year?c}
            Regents of the University of Colorado
             | <a class="terms" href="${urls.termsOfUse}" title="terms of use">Terms of Use</a></small> | 
        </#if>
        Powered by <a class="powered-by-vivo" href="http://vivoweb.org" target="_blank" title="powered by VIVO"><strong>VIVO</strong></a>
        <#if user.hasRevisionInfoAccess>
             | Version <a href="${version.moreInfoUrl}" title="version">${version.label}</a>
        </#if>
	        <br/> Data updated last 11/7/2013 4:00 AM
	        <br/> University of Colorado Boulder / CU Boulder
                <br/> Fundamental data on national and international awards provided by Academic Analytics.
    </p>
    
    <nav role="navigation">
        <ul id="footer-nav" role="list">
          <#if user.loggedIn>
             <li role="listitem"><img class="middle" src="${urls.images}/userIcon.png" alt="user icon" />${user.loginName}</li>
             <li role="listitem"><a href="${urls.logout}">Log out</a></li>
          	 <#if user.hasSiteAdminAccess>
             	<li role="listitem"><a href="${urls.siteAdmin}">Site Admin</a></li>
          	 </#if>
             <li role="listitem"><a href="${urls.index}">Index</a></li>
          <#else>
             <#-- <li role="listitem"><a title="log in to manage this site" href="${urls.login}">Log in</a></li> -->
            <li role="listitem"><a href="${urls.about}" title="about">About</a></li>
            <#if urls.contact??>
                <#-- <li role="listitem"><a href="${urls.contact}" title="contact us">Contact Us</a></li> -->
            </#if> 
          </#if>
        </ul>
    </nav>
</footer>

<#include "scripts.ftl">
