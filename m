Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB96E81DE2
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Oct 2023 11:20:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F074E4093D;
	Fri,  6 Oct 2023 11:20:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F074E4093D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696591247;
	bh=zeLHQJMVGZfxIHQQWg4vAAabkQFD//+XmDyswH5iCc0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=omzQ7kW6548aBMK30qrkCESzTO4zUqEA/ZID6YNyCOt/OpEBTL/KQOyxmxrgw8SbP
	 H9rL2CDhP5IbUIpibVovub9qFVJoJMsiY9mfdz9iAhQohi9n2ta4TDqNEYh/R5ODZp
	 pyKT6DNLv/ud9vpZF7CmZIL5CoF0SMgkfEvtTjbnnb5HVlsg6Ezzd8FzWUi6Zmhw34
	 zOdxx+Hf3+WXa7P9UOa9oVqST7Y+ZG6dC/sje9R2nzS9JsRWKdnT/KEHOgqgxGc52G
	 R3ID/hiaJDRQI7SmTg+SmxyFuiTozSeibjzArsYb4SBkg4CrgiVSKYB4penvMucU0f
	 kwFdvaIFB4gvQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNbfBXyf4tZ2; Fri,  6 Oct 2023 11:20:46 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA29B40941;
	Fri,  6 Oct 2023 11:20:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA29B40941
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 82A281BF4E3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 11:20:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5B16041582
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 11:20:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B16041582
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ICttktJ8SyFk for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Oct 2023 11:20:42 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 285E540474
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Oct 2023 11:20:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 285E540474
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 059F4CE2737;
 Fri,  6 Oct 2023 11:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EC9C43391;
 Fri,  6 Oct 2023 11:20:37 +0000 (UTC)
Date: Fri, 6 Oct 2023 13:20:34 +0200
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <ZR/tginYKa7Zcwug@kernel.org>
References: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1696591239;
 bh=kFxs3hCHi5I7QGQEivRopqVOmOAgS/9t+tGmtdBttGc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mCcUDI1sjfPB1CvknDDtG1tn84Y2URFKyd53KY8zku88U5DB3EpJUDU3bB0SYda5X
 R8kuI8ImDqWCZLYUwRdoNXSu48nYi2cUNyMUFB0iVNiEm2Dnh9WQUs1Q0ZxzijHWUi
 ldakbVs5lCckneaPw05pgx0pSmhRyJxOmh2DPS5BpG+6tgLo78DJp6wVUipVrWGkmD
 pQOSI8PdCeSfO03ABwPZoAoF7jSRsWH3WgSG1bB3OgAd0nPJAEpOKgwQUOuEhrX4AQ
 tWI7HMTjThoTtNScL8bvsXILW3dx195PD515nL244Ev8QV80MWcYzPy5drLO61/sau
 TsqFRUGLKqPPg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=mCcUDI1s
Subject: Re: [Intel-wired-lan] [PATCH net-next 1/2] igb: Fix an end of loop
 test
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
Cc: intel-wired-lan@lists.osuosl.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 kernel-janitors@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Oct 05, 2023 at 04:57:21PM +0300, Dan Carpenter wrote:
> When we exit a list_for_each_entry() without hitting a break statement,
> the list iterator isn't NULL, it just point to an offset off the
> list_head.  In that situation, it wouldn't be too surprising for
> entry->free to be true and we end up corrupting memory.
> 
> The way to test for these is to just set a flag.
> 
> Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
