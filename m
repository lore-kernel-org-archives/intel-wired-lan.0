Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A08C77B7E
	for <intel-wired-lan@archiver.kernel.org>; Thu, 25 May 2023 12:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E3066169A;
	Thu, 25 May 2023 12:59:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E3066169A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1685019554;
	bh=Qz0Bw6QytU2z9WgpKxAnXPILITFsMIoe9onwdMHfGmg=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=iS5dNbLd005+91em01/1qKuSTCLBFwq4KKrD+BYdjfL38i76RbWEAszVYKZur1M7S
	 MpDGeOrMwWRRB0P9yBJHFCXYK4YYOwnFNVT43dkxA7fRmnMlpBl4RPbbPEa/ROhBFQ
	 OHABlk3ZEZWzytq6QS+DnNWXapAefkjpvzzzmED8BtxTMRx3zP9wFUgG1z4VlWysU3
	 EoczujrMgpLoDzSi3DYj7n6azxCqMjMb0TuHCsPMDRaH9CeDZB/TmkCr0VSTU5RbWh
	 wisvlYAIIMd0a6+qnC4QoKUDHan8lJbHMvJJg90U4slicr0j20YV23SB04WkL5t//G
	 Br5gl9x/TzseQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D-XbS-Khwk5W; Thu, 25 May 2023 12:59:13 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id F284A6168F;
	Thu, 25 May 2023 12:59:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F284A6168F
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E1FEB1BF215
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 May 2023 12:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9CE541F2B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 May 2023 12:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9CE541F2B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jlbrBW3S7GBG for <intel-wired-lan@lists.osuosl.org>;
 Thu, 25 May 2023 12:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C01DD41B4E
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C01DD41B4E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 25 May 2023 12:59:01 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="351384422"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="351384422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 05:59:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="817075163"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; d="scan'208";a="817075163"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by fmsmga002.fm.intel.com with ESMTP; 25 May 2023 05:58:57 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Thu, 25 May 2023 14:57:41 +0200
Message-Id: <20230525125746.553874-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525125746.553874-1-aleksander.lobakin@intel.com>
References: <20230525125746.553874-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685019541; x=1716555541;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aN8/dkqLOjIgLkSbA6BlYEq32MiAHhADHMb8dVnvsEI=;
 b=bSOuWXIKWMlxv+/1+KoTe4685Pini0f4PY/vsXSjbdvmFly49BNeDvaa
 18mwkIA1QH9s8+SM1NlFvrU03NUAc2OFYX9p4cxVc1jo+j7bAhqI3i4Hw
 q/3Fli0yPeE4pF5YX31Vlil+Deam9kNLgqWO26fzTySr1s9rfe+x8xtHT
 OuL2VaeT+xlmibZYx2BqeNcXl75iFfEZJodET+EbFP1BBlOxzczPjdFE+
 Lw4PFk4aohBEPTCRNV7SusZnPbMKFPRGDjmp90CRUfa9B4JNURYsprmiR
 xjUcG1MRjLOVo/7TRcBlErPZ1zitTiA/1t8ZDSXTpq+RDiLeqNHd+DwU4
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bSOuWXIK
Subject: [Intel-wired-lan] [PATCH net-next v2 07/12] net: page_pool: avoid
 calling no-op externals when possible
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
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org,
 Christoph Hellwig <hch@lst.de>, Magnus Karlsson <magnus.karlsson@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
even when on DMA-coherent platforms (like x86) with no active IOMMU or
swiotlb, just for the call ladder.
Indeed, it's

page_pool_put_page()
  page_pool_put_defragged_page()                  <- external
    __page_pool_put_page()
      page_pool_dma_sync_for_device()             <- non-inline
        dma_sync_single_range_for_device()
          dma_sync_single_for_device()            <- external
            dma_direct_sync_single_for_device()
              dev_is_dma_coherent()               <- exit

For the inline functions, no guarantees the compiler won't uninline them
(they're clearly not one-liners and sometimes compilers uninline even
2 + 2). The first external call is necessary, but the rest 2+ are done
for nothing each time, plus a bunch of checks here and there.
Since Page Pool mappings are long-term and for one "device + addr" pair
dma_need_sync() will always return the same value (basically, whether it
belongs to an swiotlb pool), addresses can be tested once right after
they're obtained and the result can be reused until the page is unmapped.
Define new PP flag, which will mean "do DMA syncs for device, but only
when needed" and turn it on by default when the driver asks to sync
pages. When a page is mapped, check whether it needs syncs and if so,
replace that "sync when needed" back to "always do syncs" globally for
the whole pool (better safe than sorry). As long as a pool has no pages
requiring DMA syncs, this cuts off a good piece of calls and checks.
On my x86_64, this gives from 2% to 5% performance benefit with no
negative impact for cases when IOMMU is on and the shortcut can't be
used.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/page_pool.h |  3 +++
 net/core/page_pool.c    | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 821c75bba125..08e9571d2545 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -46,6 +46,9 @@
 					* device driver responsibility
 					*/
 #define PP_FLAG_PAGE_FRAG	BIT(2) /* for page frag feature */
+#define PP_FLAG_DMA_MAYBE_SYNC	BIT(3) /* Internal, should not be used in
+					* drivers
+					*/
 #define PP_FLAG_ALL		(PP_FLAG_DMA_MAP |\
 				 PP_FLAG_DMA_SYNC_DEV |\
 				 PP_FLAG_PAGE_FRAG)
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e212e9d7edcb..57f323dee6c4 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -175,6 +175,10 @@ static int page_pool_init(struct page_pool *pool,
 		/* pool->p.offset has to be set according to the address
 		 * offset used by the DMA engine to start copying rx data
 		 */
+
+		/* Try to avoid calling no-op syncs */
+		pool->p.flags |= PP_FLAG_DMA_MAYBE_SYNC;
+		pool->p.flags &= ~PP_FLAG_DMA_SYNC_DEV;
 	}
 
 	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
@@ -323,6 +327,12 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 
 	page_pool_set_dma_addr(page, dma);
 
+	if ((pool->p.flags & PP_FLAG_DMA_MAYBE_SYNC) &&
+	    dma_need_sync(pool->p.dev, dma)) {
+		pool->p.flags |= PP_FLAG_DMA_SYNC_DEV;
+		pool->p.flags &= ~PP_FLAG_DMA_MAYBE_SYNC;
+	}
+
 	if (pool->p.flags & PP_FLAG_DMA_SYNC_DEV)
 		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
