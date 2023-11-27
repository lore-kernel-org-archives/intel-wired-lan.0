Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23803C0755A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Nov 2023 16:56:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF514405C4;
	Mon, 27 Nov 2023 16:55:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF514405C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701104159;
	bh=3BzPXECLKPhjiP5xZSt9Rlhn0mPQz6AfWMvcFpgfTd8=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vRqfDusWX436WkVZCAN/akvq8ZySemAQXfatQ8cyQImLwRMXgslvHc0CMzoQ0kWDG
	 nxv7EHqFw+76fqCRyLpOwK7ZZ8sEkkKgTy/bTBBPBrvrkhJKh54Ahi3irkS1k98hEG
	 pRh+tHJYxwF+A/BffHULyypza6ekHoIJMC1VIzZdnCySuM9E2N49jWoZCZHEGW+Loz
	 92SrY6Zr5w+L014kAtUE3YmVID8Bt+Vj4vAz6mFNxT5wdXAkKICFAw2yMXfdAKgxyF
	 GuoYNNjWQto1zw0ck9WFh4XUnLqAi4g7ikHyC9wXk5ppGVJ3o2F6JS158ciNrCyhPQ
	 3sEaUYa8RAXpQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCUq1y0hkoDJ; Mon, 27 Nov 2023 16:55:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAD5F405C7;
	Mon, 27 Nov 2023 16:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CAD5F405C7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id C59D81BF405
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 16:55:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98A2D40528
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 16:55:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98A2D40528
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVMTkzLvrWw1 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Nov 2023 16:55:55 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1A7744014E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Nov 2023 16:55:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A7744014E
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E8CB56136C;
 Mon, 27 Nov 2023 16:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34DBC433CA;
 Mon, 27 Nov 2023 16:55:52 +0000 (UTC)
Date: Mon, 27 Nov 2023 08:55:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>, Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <20231127085552.396f9375@kernel.org>
In-Reply-To: <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
 <20231120205614.46350-2-ahmed.zaki@intel.com>
 <20231121152906.2dd5f487@kernel.org>
 <4945c089-3817-47b2-9a02-2532995d3a46@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1701104153;
 bh=z8KCkkZNLqEq+EoG4f1wJkwaMH1lYNHFYV6XyQ+Y8LY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ApaAD5lmJaaOwDNmhqKgvGY1DEd0Ta8O46rH9L9dM4TmWKob8VQU9/x6KvoLB58nY
 oWVPsrBHAw91L66h5i7JWdvBhC8rnAA1dgU4AK25IuzIEEAC52DdIURCACc7IFDeTd
 H+hh4iOD5KIJtwtKSmO7VZ9OiaW98JtC03jXSfiQk2Sar5O8YuhznNTNVhTvtrly9F
 iukymwGCI6hMhf6P9vaBSb4mEvXh957GZX2NZscQixT8wBio47kB5wkQmden2dMxmQ
 gqjEDOFHKdU00wjYwy38Cb+Jnxg8VG4j/2mPfugCr2Bm6lTEDhBc+Yc2BMDtNTIcpD
 u7AI9jciuTBvA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ApaAD5lm
Subject: Re: [Intel-wired-lan] [PATCH net-next v6 1/7] net: ethtool: pass
 ethtool_rxfh to get/set_rxfh ethtool ops
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
Cc: mkubecek@suse.cz, andrew@lunn.ch, willemdebruijn.kernel@gmail.com,
 corbet@lwn.net, netdev@vger.kernel.org, gal@nvidia.com,
 linux-doc@vger.kernel.org, jesse.brandeburg@intel.com,
 Igor Bagnucki <igor.bagnucki@intel.com>, edumazet@google.com,
 anthony.l.nguyen@intel.com, horms@kernel.org, vladimir.oltean@nxp.com,
 Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 27 Nov 2023 07:14:51 -0700 Ahmed Zaki wrote:
> >   - First simplify the code by always providing a pointer to all params
> >     (indir, key and func); the fact that some of them may be NULL seems
> >     like a weird historic thing or a premature optimization.
> >     It will simplify the drivers if all pointers are always present.
> >     You don't have to remove the if () checks in the existing drivers.
> > 
> >   - Then make the functions take a dev pointer, and a pointer to a
> >     single struct wrapping all arguments. The set_* should also take
> >     an extack.  
> 
> Can we skip the "extack" part for this series? There is no 
> "ETHTOOL_MSG_RSS_SET" netlink message, which is needed for user-space to 
> get the ACK and adding all the netlink stuff seems a bit out of scope.

Fair point, yes, that's fine.

BTW, Ed, this series will conflict with your RSS context rework.
Not sure if it is on your radar.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
