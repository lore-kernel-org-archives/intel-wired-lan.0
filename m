Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05E2C4167B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Dec 2023 09:38:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 837A64353A;
	Wed,  6 Dec 2023 09:38:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 837A64353A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701855489;
	bh=lwbSE+TMmK0APoIFxj7rjQICPicx8zcYoDvn+K+Pk1Q=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=T+K1hDYh68Iz9ngr29TA32N0KvjS21hfYGfvaceE7pHm17/b0qT2cubR9QqH28EWb
	 sr/SpexM/DuOfshz2VPdcfwMPPtgVqkj64blO/4rw4UXTR+fylPaDvZry8AU71zLrb
	 vN/5msjN4uos4HmxmBiWaTz0gdd+Sq0DgbQLR9TiB71pTl5yalDWB4PjYT6UIlaTJm
	 6ssq0bbYfPy/OXkuJ2j1Lm4RX2PVvbqEDNWhV52Racvo8V0c/XRIe4v6xNAf307Qyf
	 vluQKgTrRZgLbKcmD3d/9TWScFZWPRXNIivgVoalkjYvgvABAdxVhpuKUVEw6szb5B
	 Q8GSX1s/dpdrA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1hN1IJ7SIj3m; Wed,  6 Dec 2023 09:38:08 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 317DA41A63;
	Wed,  6 Dec 2023 09:38:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 317DA41A63
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 0209E1BF83E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 09:38:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC89B408B1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 09:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC89B408B1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iYwzNBWYfIAM for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Dec 2023 09:38:06 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:242:246e::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1FA0408A0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 09:38:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C1FA0408A0
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97) (envelope-from <johannes@sipsolutions.net>)
 id 1rAoLt-0000000HY61-2IUs; Wed, 06 Dec 2023 10:37:57 +0100
Message-ID: <c1189a1982630f71dd106c3963e0fa71fa6c8a76.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, netdev@vger.kernel.org
Date: Wed, 06 Dec 2023 10:37:56 +0100
In-Reply-To: <3e7ae1f5-77e3-a561-2d6b-377026b1fd26@intel.com>
References: <20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
 <d0fc7d04-e3c9-47c0-487e-666cb2a4e3bc@intel.com>
 <709eff7500f2da223df9905ce49c026a881cb0e0.camel@sipsolutions.net>
 <3e7ae1f5-77e3-a561-2d6b-377026b1fd26@intel.com>
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=3fntxHKIyKjnSM6vuBVwyvUk6ZAEqyru8xw5RbWoPl0=; 
 t=1701855485; x=1703065085; b=apgR32lTHnLjVxgWB4HtDZLtA8wIIpmm0kwZ5+kzuI8Fh8U
 zZKIxMUaxliLwQYhCbJVIeS815sr2tUBNfUI6fzoGxoJlNPKllys8qoj/j0LJrC4h+3ZP3D+z+/aE
 M5vkJoVq+0CzM/l++SMnEuVX8glDOmuVZt6KrkxP0uP5efdps4wJKZjIaGtu6QEGiRrNOvzYSl/Zt
 GsZ0R0JAwbXGtRx2w1L2E00KHSJCPEHuWBCu9b3NG1Jf3pN/bYvYJtad1wnxqsT/2mm95BbgXNNTb
 1vrmC3nrxtXe3gd6P1vHu2z5nSck/6APyGIyfaBRhJxvCNnekRILxRyIzYRBKhxQ==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net
 header.a=rsa-sha256 header.s=mail header.b=apgR32lT
Subject: Re: [Intel-wired-lan] [RFC PATCH] net: ethtool: do runtime PM
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
Cc: Marc MERLIN <marc@merlins.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 2023-12-06 at 09:46 +0100, Przemek Kitszel wrote:
> 
> That sounds right too; one could argue if your fix is orthogonal to that
> or not. I would say that your fix makes core net code more robust
> against drivers from past millennia. :)
> igc folks are notified, no idea how much time it would take to propose
> a fix.

Maybe it should be on whoever added runtime pm to ethtool ;-)

Heiner, the igc driver was already doing this when you added
pm_runtime_get_sync() ops, was there a discussion at the time, or just
missed?

I really don't know any of this ...

> > Well, according to the checks, the patch really should use
> > netdev_get_by_name() and netdev_put()? But I don't know how to do that
> > on short-term stack thing ... maybe it doesn't have to?
> 
> Nice to have such checks :)
> You need some &netdevice_tracker, perhaps one added into struct net
> or other place that would allow to track it at ethtool level.

Yeah but that's dynamic? Seems weird to add something to allocations for
something released in the same function ...

> "short term stack thing" does not relieve us from good coding practices,
> but perhaps "you just replaced __dev_get_by_name() call by
> dev_get_by_name()" to fix a bug would ;) - with transition to tracked
> alloc as a next series to be promised :)

All I want is to know how ;)
but I guess I can try to find examples.

> anyway, I'm fresh here, and would love to know what others think about

Not me, but me too ;-)

johannes
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
