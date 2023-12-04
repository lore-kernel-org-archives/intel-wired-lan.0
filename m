Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE5C4167B
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Dec 2023 21:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5B4FE41763;
	Mon,  4 Dec 2023 21:16:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B4FE41763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701724586;
	bh=HNkr2R4j+D0YobqkSvrH05DgxWJFsDiJoo72Abp97oA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=G3EqMSf8ZIIAWDS4T52EpSb5nf7tcIVi3C5CeQFL911RiMfx6739wmPWDQV3WogAI
	 H6Y+vKci6pyWuvs0HqEWxx1At174ZL+VfGxRCvCc9bvePkkAFEVckoZo/fgCaTOCKs
	 /U2rvn3ILsBQcuPXcESgzWQsoPF+PsBXw6rDV6+0+ts0fgivzJwQiIYJcjH/t9wsjT
	 c2PvtMJjPwKsJZ1vPNoypGNjQtoA2QZNFnxfpmYjaFXhkHdLJj4CznlSzZ0ug1bLeA
	 /vd8rW3/OF1X89GlSfJ1IZVt1wl6MHvPP3tZ2tWMyYYR0s95d2KwwMSVMBhlXP/Fr4
	 Yu5iJesN6218Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUW__tUqquAC; Mon,  4 Dec 2023 21:16:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14CE241769;
	Mon,  4 Dec 2023 21:16:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14CE241769
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 32E331BF30E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Dec 2023 21:16:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05CB482197
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Dec 2023 21:16:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05CB482197
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8-dn6ESxoFQ for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Dec 2023 21:16:20 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 07F84818EC
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Dec 2023 21:16:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07F84818EC
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 14BF2B8121D;
 Mon,  4 Dec 2023 21:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B67C433C8;
 Mon,  4 Dec 2023 21:16:16 +0000 (UTC)
Date: Mon, 4 Dec 2023 13:16:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20231204131615.26b57722@kernel.org>
In-Reply-To: <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
References: <20231202171326.GB24486@merlins.org>
 <20231204004003.GB29484@merlins.org>
 <20231204073515.GA9208@merlins.org>
 <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701724576;
 bh=2iD8vt6eNm0XmwO6zdz79g9BRAd6Cvlx6ThzdonFSAI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GQCt6M601eJY4Nnaz4H8Um9YD8LcC+BhL95rxh+WB9jRneB4AiVcAxsuG29q+65Jg
 G49tfFPUGRjA47FN2yJYhoX5aCQS90IeMlWvYwgs6QgGUERMYYrZdVIQAOKO5UKL25
 Vm57s5/IRbWOUQwueBvoLJYZ5S88aomGHu8R9HJbhrnuRCP6SDP9HF/NREBzkjTJR7
 aoz4nb2Z80HkvfMPTh8f//kqLKxZaq7acIsnMh28BxU6ebPzhZUmoMsVqDrs1EDRbz
 v8kuHxmibuoWpusFUiv0PInA3IPlunxIneyFCNjmqThjhEUsVccdrWH6m7qAgGZ8YY
 Nsl+00Zc4s8uA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GQCt6M60
Subject: Re: [Intel-wired-lan] Thinkpad P17 keep hanging in ipv6_addrconf
 addrconf_verify_work / netlink in 6.4 and 6.6
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
Cc: netdev@vger.kernel.org, Marc MERLIN <marc@merlins.org>,
 linux-wireless@vger.kernel.org, ilw@linux.intel.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

CC: Intel Wired

https://lore.kernel.org/all/20231204004003.GB29484@merlins.org/

On Mon, 04 Dec 2023 11:57:44 +0100 Johannes Berg wrote:
> On Sun, 2023-12-03 at 23:35 -0800, Marc MERLIN wrote:
> > So, I thought that maybe my custom built kernel had options that somehow
> > made P17 unhappy, and went to a stock debian kernel.
> > It's not really looking better with that kernel unfortunately :-/
> > 
> > Still seems unhappy with networking, first wireless and then ethtool.
> > Adding wireless lists to Cc just in case  
> 
> Well clearly something is not unlocking the RTNL, but digging through
> the below I only found places that want to acquire the RTNL and wait
> forever on it (including wireless), but none that actually got stuck
> while having it acquired already.
> 
> 
> Actually ... no that's wrong.
> 
> I can:
> 
> > > [  363.945427] INFO: task powertop:6279 blocked for more than 120 seconds.
> > > [  363.945446]       Tainted: G     U             6.6.3-amd64-preempt-sysrq-20220227 #4
> > > [  363.945452] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [  363.945456] task:powertop        state:D stack:0     pid:6279  ppid:6267   flags:0x00004002
> > > [  363.945468] Call Trace:
> > > [  363.945473]  <TASK>
> > > [  363.945481]  __schedule+0xba0/0xc05
> > > [  363.945497]  schedule+0x95/0xce
> > > [  363.945504]  schedule_preempt_disabled+0x15/0x22
> > > [  363.945511]  __mutex_lock.constprop.0+0x18b/0x291
> > > [  363.945520]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > [  363.945531]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c9599226acd0eeb7de577b7]  
> 
> this is trying to acquire the RTNL, by looking at the code
> 
> > > [  363.945566]  __rpm_callback+0x7a/0xe7
> > > [  363.945578]  rpm_callback+0x35/0x64
> > > [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > [  363.945592]  rpm_resume+0x342/0x44a
> > > [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> > > [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> > > [  363.945624]  dev_ethtool+0x15a/0x24e7  
> 
> but this already holds it
> 
> So looks like bug in the 'igc' driver wrt. runtime PM locking.
> 
> johannes
> 
> 

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
