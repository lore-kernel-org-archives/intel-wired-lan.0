Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94FBC77B73
	for <intel-wired-lan@archiver.kernel.org>; Sat, 27 May 2023 03:54:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 588EA6F590;
	Sat, 27 May 2023 03:54:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 588EA6F590
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685159658;
	bh=hJmHLvjjk8y9LdGFmCySl5FgUsVL6Wi4cJmYkACSs2s=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oHtIw4iTLCPemcVq0UisNRbvru6Ce5ricndMlhEt+pgnJl4sIzGhf58L1GPn1KB3y
	 mxAxUXzcNWsD0ZVjQ6YZKsAPuv1iTJ9Eebs3IqSgmuEiL1Pr7TTZSiQQH+1ZhxY3Ce
	 54aPKTZsOD96do8K/cZYjvzMZv9Dg5jhRiIxSOQueUlc4JSN0WPcKQe2PBbv+uizBZ
	 bHa3OMnBl5Q5bPUkc0QwpwYSJYq8cSXgfQOQJTTmgoJ9f2XX0azMKuwECcAWomEoQu
	 LiRsNWlyjM0e6md+fq3BFC/DCPf07PvlqTD6HxVRX3nmsmzg1vCsXeaLFnaCkLK2BL
	 kzEQJnhMOjMbA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqQSWNvFSCxL; Sat, 27 May 2023 03:54:17 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C35961199;
	Sat, 27 May 2023 03:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C35961199
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 1949D1BF373
 for <intel-wired-lan@lists.osuosl.org>; Sat, 27 May 2023 03:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E44BC429CB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 27 May 2023 03:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E44BC429CB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id juhLcxUgUeOw for <intel-wired-lan@lists.osuosl.org>;
 Sat, 27 May 2023 03:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ABAEE429CA
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ABAEE429CA
 for <intel-wired-lan@lists.osuosl.org>; Sat, 27 May 2023 03:54:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4D0AE6120F;
 Sat, 27 May 2023 03:54:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1899AC433EF;
 Sat, 27 May 2023 03:54:11 +0000 (UTC)
Date: Fri, 26 May 2023 20:54:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Message-ID: <20230526205410.3f849071@kernel.org>
In-Reply-To: <20230525125746.553874-7-aleksander.lobakin@intel.com>
References: <20230525125746.553874-1-aleksander.lobakin@intel.com>
 <20230525125746.553874-7-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1685159651;
 bh=4VBv7cj0/3RmXKILqJxI8XT4lU0273xO3MquSuWGEwk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CyhrMX609RlDwkP1Ry9yaWcXvsO6Z/j8CnJT02pDXPXqBuEwqrAzgwokVRLvlGzLE
 MhWQt633AyUyd37gALmn3Wy9bUXEqt7Me7dHABGZqxveHlritOulBu58dHzNmbA85j
 09F5hm/8hG4J/jqTRpchwln0XD1QT8/DlDFPaVjAL6mzKThf/rOdvGBwY73AsbZZCb
 0jbeBhIeRJwzSQWYTj2mIHUpRgosRlqStxfhmyGAmqHQ+jbBtZYrzGcsaaPK4+rJ3n
 ibxPUB/gVAjV+dTTHk0H2Lx3HO1A9376maxeUN8FBnBRLVXUNPnXjFwu2H9czjeWU3
 tYvV+k1pGhWfQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CyhrMX60
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 06/12] net: skbuff: don't
 include <net/page_pool.h> into <linux/skbuff.h>
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, 25 May 2023 14:57:40 +0200 Alexander Lobakin wrote:
> Currently, touching <net/page_pool.h> triggers a rebuild of more than
> a half of the kernel. That's because it's included in <linux/skbuff.h>.
> 
> In 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling"),
> Matteo included it to be able to call a couple functions defined there.
> Then, in 57f05bc2ab24 ("page_pool: keep pp info as long as page pool
> owns the page") one of the calls was removed, so only one left.
> It's call to page_pool_return_skb_page() in napi_frag_unref(). The
> function is external and doesn't have any dependencies. Having include
> of very niche page_pool.h only for that looks like an overkill.
> Instead, move the declaration of that function to skbuff.h itself, with
> a small comment that it's a special guest and should not be touched.
> Now, after a few include fixes in the drivers, touching page_pool.h
> only triggers rebuilding of the drivers using it and a couple core
> networking files.

drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c

came in the meantime, and did not bother including page_pool.h.
-- 
pw-bot: cr
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
