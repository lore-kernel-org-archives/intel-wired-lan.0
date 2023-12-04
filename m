Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E5C4167B
	for <intel-wired-lan@archiver.kernel.org>; Mon,  4 Dec 2023 21:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8C484174F;
	Mon,  4 Dec 2023 21:18:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B8C484174F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701724682;
	bh=tl3IRjEd/AAksLPC+/p18AtdBb414Lybg5WimSnxYCQ=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=6Dulbx9blqsLrS5UOKFPxJRCpV1lTbfnsXuV/my+Z4uwA9cSePmDwwTO24BsiHbGD
	 VLd1UJsMHrg7RTaiuFaI0HgVnDINbSFPmfxHad+4+RWCNFjSTIRsMHos8dKsiZ/fBY
	 ICPksKcOqoXVaoE5//YWCQRGGcLkQq/Jk7wt0eCtN1uAKFwMq1V+7Nvbc4gc+dI7xp
	 Ep9H2tbVCm9azTS5GV7ZKCC/SM67I8rDEB70nmrcfJE9b9HJs24PtDwyW4ZT/fj0wN
	 rszgp/F4SRxeHbs6m/vom6JcCLGvQiCpQxsUR+IybwIKU9widBpkKiJZrTw3jirWMt
	 IS3T/WvLqMIFQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sqjhSMKshqU4; Mon,  4 Dec 2023 21:18:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8181641763;
	Mon,  4 Dec 2023 21:18:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8181641763
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9CF6D1BF30E
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Dec 2023 21:17:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7465C821A0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Dec 2023 21:17:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7465C821A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WG1l38vW74Ck for <intel-wired-lan@lists.osuosl.org>;
 Mon,  4 Dec 2023 21:17:58 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 89FE48219D
 for <intel-wired-lan@lists.osuosl.org>; Mon,  4 Dec 2023 21:17:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89FE48219D
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97) (envelope-from <johannes@sipsolutions.net>)
 id 1rAGK7-0000000FGSR-0u4f; Mon, 04 Dec 2023 22:17:51 +0100
Message-ID: <95265243715c2f7cbb5ef94083d64e1a17d8ee04.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 04 Dec 2023 22:17:50 +0100
In-Reply-To: <20231204131615.26b57722@kernel.org>
References: <20231202171326.GB24486@merlins.org>
 <20231204004003.GB29484@merlins.org> <20231204073515.GA9208@merlins.org>
 <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
 <20231204131615.26b57722@kernel.org>
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=QT7k7kPIr5wnFnF5J7GwSeJplbrxHWX0xcDBoBtByho=; 
 t=1701724678; x=1702934278; b=p9xwP31C99DrouXXDXuGcs/Aky1oNnBH0OjLFTN1PFwaisS
 s/7IaXV/xT+/gAZLBRiLph6GOBqbQx+r0/NgAYrbyLo0pmmSTlg8T+DqRLXtqNJ609o5cHHoI181l
 WLvMa/cWHXcW4Q3hn1AckHd35DoENc1YU/+Bb4eblXS+YX82dzKM0Z/9LL9aoicSMmK7mw4EOFrnW
 VrLO87dPlf9bOw9OCEc12x7AzSchsbAFWM6VKt/h1HatiDey2T2ITTtU/ILK6XBLgSv9LLjJY6oDX
 /AXjBdU0JPGF0t77dlFgjjGjgQEtMj444YQ6U5AYUylS2USUrv2ogC5vJP3cMwOg==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net
 header.a=rsa-sha256 header.s=mail header.b=p9xwP31C
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

On Mon, 2023-12-04 at 13:16 -0800, Jakub Kicinski wrote:
> > > > [  363.945511]  __mutex_lock.constprop.0+0x18b/0x291
> > > > 
> > > > [  363.945531]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c9599226acd0eeb7de577b7]  
> > 
> > this is trying to acquire the RTNL, by looking at the code
> > 
> > > > [  363.945566]  __rpm_callback+0x7a/0xe7
> > > > [  363.945578]  rpm_callback+0x35/0x64
> > > > [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > > [  363.945592]  rpm_resume+0x342/0x44a
> > > > [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> > > > [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> > > > [  363.945624]  dev_ethtool+0x15a/0x24e7  
> > 
> > but this already holds it
> > 
> > So looks like bug in the 'igc' driver wrt. runtime PM locking.
> > 

So actually maybe it shouldn't be a bug there, I posted this:

https://patchwork.kernel.org/project/netdevbpf/patch/20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid/

but I don't know this driver at all, and ethtool not that well ...

johannes
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
