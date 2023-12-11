Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6524FC4167B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 Dec 2023 16:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2473440345;
	Mon, 11 Dec 2023 16:42:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2473440345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702312958;
	bh=pC9Zk3v86xxmfIMnhDckz/H/2pRfWWWwdSRYR6UxtC8=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=7UbInhSob9uWPxoO880DUUXxeOvJBPq19oA1pwWmxL+2NKaA0JKIP7NDcH4zhfZLz
	 TyFXD/x+biAm83J0qKbnXIusRWOmWUTCWfW0RTW4wzz2FbvBSevpiUnp/E5KNyaTZ2
	 dlUXAAKCc+JV+zg0D7VYILwE0c+8n+sojbb6/BVpK57BuL9uPi84x5sBLRZjQvZhuu
	 oqB7u/wgRbtOgGyLTGQEdzrW0YZBgYgyQKKz5zR3cH85NSOApTTekEqcS5CjXr/pzh
	 WPC9gji+4lWeccAl3dQMzjzRn/M7t/BsAC8qIMIaPW88m8WpyhtjK0zVTIcIUenxlb
	 s+6cQKddsYU+w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FSlngcfi_1Et; Mon, 11 Dec 2023 16:42:36 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2583F41743;
	Mon, 11 Dec 2023 16:42:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2583F41743
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 772B91BF5A2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 04:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F74A8218F
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 04:52:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F74A8218F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6UeR1x-44gmD for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 Dec 2023 04:52:14 +0000 (UTC)
Received: from mail1.merlins.org (magic.merlins.org [209.81.13.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8C078210A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 Dec 2023 04:52:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8C078210A
Received: from c-76-132-34-178.hsd1.ca.comcast.net ([76.132.34.178]:58984
 helo=sauron.svh.merlins.org) by mail1.merlins.org with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim
 4.94.2 #2)
 id 1rCYGv-0004Vc-9r by authid <merlins.org> with srv_auth_plain;
 Sun, 10 Dec 2023 20:52:01 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
 (envelope-from <marc@merlins.org>)
 id 1rCYGu-000roj-Sl; Sun, 10 Dec 2023 20:52:00 -0800
Date: Sun, 10 Dec 2023 20:52:00 -0800
From: Marc MERLIN <marc@merlins.org>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20231211045200.GC24475@merlins.org>
References: <20231206113934.8d7819857574.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <20231206084448.53b48c49@kernel.org>
 <e6f227ee701e1ee37e8f568b1310d240a2b8935a.camel@sipsolutions.net>
 <a44865f5-3a07-d60a-c333-59c012bfa2fb@intel.com>
 <20231207094021.1419b5d0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231207094021.1419b5d0@kernel.org>
X-Sysadmin: BOFH
X-URL: http://marc.merlins.org/
X-SA-Exim-Connect-IP: 76.132.34.178
X-SA-Exim-Mail-From: marc@merlins.org
X-Mailman-Approved-At: Mon, 11 Dec 2023 16:42:26 +0000
Subject: Re: [Intel-wired-lan] [PATCH net v3] net: ethtool: do runtime PM
 outside RTNL
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
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Dec 07, 2023 at 09:40:21AM -0800, Jakub Kicinski wrote:
> On Thu, 7 Dec 2023 11:16:10 +0100 Przemek Kitszel wrote:
> > I have let know our igc TL, architect, and anybody that could be
> > interested via cc: IWL. And I'm happy that this could be done at
> > relaxed pace thanks to Johannes
> 
> I think you may be expecting us to take Johannes's patch.
> It's still on the table, but to make things clear -
> upstream we prefer to wait for the "real fix", so if we agree
> that fixing igb/igc is a better way (as Heiner pointed out on previous
> version PM functions are called by the stack under rtnl elsewhere too,
> just not while device is open) - we'll wait for that. Especially
> that I'm 80% I complained about the PM in those drivers in
> the past and nobody seemed to care. It's a constant source of rtnl
> deadlocks.

For whatever it's worth, I want to be clear that all stock kernels
are 100% unusable on lenovo P17gen2 because of this deadlock and that
without the temporary patch, my laptop would be usuable.
It was also a risk of data loss due to repeated deadlocks and unclean
shutdowns.

I cannot say what the correct fix is, but I am definitely hoping you
will accept some solution for the next stable kernel.

Thank you
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
