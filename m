Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF67EB64DA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 19 Jul 2023 12:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F42E41773;
	Wed, 19 Jul 2023 12:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F42E41773
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689768891;
	bh=BAipBknjKAE+PpJHBju+WLVmRck0B2g2UJLFHgUeTDA=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=h5YU0eEZrHBnBqn2Sm+OrEqQMwAEzETapAkZbbOYLT3n0dBFeoDxR/TOjxJwy99wP
	 fGZG4arv2acIWZviqkDD/CkGI+F0eqSkdz+kN2siseeM9NLE+KKQKNllbN5BSn2JxG
	 snBxzg1vcmk1r8Qz+MHzYPHywDaTpri3Iw8I9zO9E5XEnDiIRQhkce+j9L00SdkIYn
	 Neqn3fmtiZQNqqd/tOtqQTVhxLrfZZn3Gx1rzvmjTadQ0W8G4tivZPX3NuLiJqmO5U
	 hx5fwyiUX7cDBbm85kyaHxrxcFFEBkH442IDaJBQ0emnXjDfI2cJrbnkTTZFXYQzhA
	 u4oWIU3FkAKiQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ulS4pvDQz6t3; Wed, 19 Jul 2023 12:14:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAB3E4177A;
	Wed, 19 Jul 2023 12:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAB3E4177A
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2859E1BF39D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Jul 2023 12:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EB42D8142C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Jul 2023 12:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB42D8142C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Eu9C-Q1kn1rI for <intel-wired-lan@lists.osuosl.org>;
 Wed, 19 Jul 2023 12:14:46 +0000 (UTC)
X-Greylist: delayed 1492 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 19 Jul 2023 12:14:45 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFDE78140B
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFDE78140B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 19 Jul 2023 12:14:45 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1qM5gT-0002S1-7g; Wed, 19 Jul 2023 13:49:33 +0200
Message-ID: <444d8158-cc58-761d-a878-91e5d4d28b71@leemhuis.info>
Date: Wed, 19 Jul 2023 13:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 Krystian Pradzynski <krystian.pradzynski@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 hq.dev+kernel@msdfc.xyz
References: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
X-bounce-key: webpack.hosteurope.de; regressions@leemhuis.info; 1689768886;
 8eb7f522; 
X-HE-SMSGID: 1qM5gT-0002S1-7g
Subject: Re: [Intel-wired-lan] Fwd: Unexplainable packet drop starting at
 v6.4
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Cc: Linux Networking <netdev@vger.kernel.org>,
 Linux Intel Ethernet Drivers <intel-wired-lan@lists.osuosl.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Regressions <regressions@lists.linux.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 18.07.23 02:51, Bagas Sanjaya wrote:
> 
> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
>> After I updated to 6.4 through Archlinux kernel update, suddenly I noticed random packet losses on my routers like nodes. I have these networking relevant config on my nodes
>>
>> 1. Using archlinux
>> 2. Network config through systemd-networkd
>> 3. Using bird2 for BGP routing, but not relevant to this bug.
>> 4. Using nftables for traffic control, but seems not relevant to this bug. 
>> 5. Not using fail2ban like dymanic filtering tools, at least at L3/L4 level
>>
>> After I ruled out systemd-networkd, nftables related issues. I tracked down issues to kernel.
> [...]
> See Bugzilla for the full thread.
> 
> Thorsten: The reporter had a bad bisect (some bad commits were marked as good
> instead), hence SoB chain for culprit (unrelated) ipvu commit is in To:
> list. I also asked the reporter (also in To:) to provide dmesg and request
> rerunning bisection, but he doesn't currently have a reliable reproducer.
> Is it the best I can do?

When a bisection apparently went sideways it's best to not bother the
culprit's developers with it, they most likely will just be annoyed by
it (and then they might become annoyed by regression tracking, which we
need to avoid).

I'd have forwarded this to the network folks, but in a style along the
lines of "FYI, in case somebody has a idea or has heard about something
similar and thus can help; if not, no worries, reporter is repeating the
bisection".

> Anyway, I'm adding this regression to be tracked in regzbot:
> 
> #regzbot introduced: a3efabee5878b8 https://bugzilla.kernel.org/show_bug.cgi?id=217678
> #regzbot title: packet drop on Intel X710-T4L due to ipvu boot fix
>
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217678

Side note for the record: Stephen also forwarded this. And let me also
clear the commit you specified, as it sounds it's unlikely to be causing
this.

#regzbot introduced: v6.3..v6.4
#regzbot monitor:
https://lore.kernel.org/all/20230717115352.79aecc71@hermes.local/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
