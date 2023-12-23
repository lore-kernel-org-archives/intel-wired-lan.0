Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDE8C46CD4
	for <intel-wired-lan@archiver.kernel.org>; Sat, 23 Dec 2023 02:59:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BC2E42D28;
	Sat, 23 Dec 2023 02:59:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0BC2E42D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1703300344;
	bh=DmUzE9DJ/xKv2JWq3n5Zaq6G4ywA7v9PzeZ0RIvFEdw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mRorde4brdcy5BwV/ctGoUMt4Vg8+RlIXWklg3r4Zs0zm6V/LoNJ6g5DSPV0TlVOa
	 tY5vIKppfEx221tsu0jbrax3+TC3oHtBxUx5FOI7TeSfib/PhtR+heyXQ0lRUsCIRP
	 8l4WGNonvfSljVzu3bLfhFI54DrWrZZdmwgPRCojdfYS9b1RreuZyl8NOuvZSVCsHS
	 T6a3DpMRQP0pWaHjPa3NLJD7OFocoIIOV8wA1dXPnWhfvqlKFnodDClcWjodge8g+c
	 enN0299iyG9qyqFvo9aNwWH5XzqZF/KY4THUArFlQ/Czco3Cfx1w3nSxsgu6lQRn42
	 z2ch7vDIEQHMA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JeNZ5As3374u; Sat, 23 Dec 2023 02:59:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E494A42D2C;
	Sat, 23 Dec 2023 02:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E494A42D2C
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 522BF1BF3EC
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:58:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2A57B60A9B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:58:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2A57B60A9B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpRIabtrjkzA for <intel-wired-lan@lists.osuosl.org>;
 Sat, 23 Dec 2023 02:58:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07BC360AFB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 23 Dec 2023 02:58:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 07BC360AFB
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="386610859"
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; d="scan'208";a="386610859"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2023 18:58:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,298,1695711600"; d="scan'208";a="25537489"
Received: from newjersey.igk.intel.com ([10.102.20.203])
 by orviesa001.jf.intel.com with ESMTP; 22 Dec 2023 18:58:43 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Date: Sat, 23 Dec 2023 03:55:31 +0100
Message-ID: <20231223025554.2316836-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
References: <20231223025554.2316836-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703300327; x=1734836327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mr6Snaw/+lFcIGo7rqhsa9beABjxqH7MK8K28PCFbjs=;
 b=eIJLuynRJuSXXl80iZKnYssF7VPs6j1EGAT2P4kSP89R4xmhyGjbGrbv
 djBqbJX+tZb49Yg+ZNfiPpbk7Cr7roVloc9z+6tQHPldL79TSaahBbGcU
 WHWD6hvoumx1Sr+5268GmTv1f5qjETi/gtPa8kJj87dVzn07B16VNOsMd
 rt/qsKy9PQLIc4J1zmwRLDz0fKbg69NhTVM74bzi7Ki+EVZ7kSOJKORZY
 P3iEA7laEp0vk9mBRB1nUlKll6AqrWCXK68YTiPVOvW0ZmzT6o5NlvfJ9
 ECmLu1Lvyaam9RmrdoEhHqmcF97oMrWl/Cb4jBTYmypMc/q2D8Ka2iQDW
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=eIJLuynR
Subject: [Intel-wired-lan] [PATCH RFC net-next 11/34] xdp: allow attaching
 already registered memory model to xdp_rxq_info
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
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Michal Kubiak <michal.kubiak@intel.com>, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

One may need to register memory model separately from xdp_rxq_info. One
simple example may be XDP test run code, but in general, it might be
useful when memory model registering is managed by one layer and then
XDP RxQ info by a different one.
Allow such scenarios by adding a simple helper which "attaches" an
already registered memory model to the desired xdp_rxq_info. As this is
mostly needed for Page Pool, add a special function to do that for a
&page_pool pointer.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/net/xdp.h  | 14 ++++++++++++++
 net/bpf/test_run.c |  4 ++--
 net/core/xdp.c     | 12 ++++++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 197808df1ee1..909c0bc50517 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -356,6 +356,20 @@ void xdp_rxq_info_unreg_mem_model(struct xdp_rxq_info *xdp_rxq);
 int xdp_reg_mem_model(struct xdp_mem_info *mem,
 		      enum xdp_mem_type type, void *allocator);
 void xdp_unreg_mem_model(struct xdp_mem_info *mem);
+void xdp_rxq_info_attach_page_pool(struct xdp_rxq_info *xdp_rxq,
+				   const struct page_pool *pool);
+
+static inline void
+xdp_rxq_info_attach_mem_model(struct xdp_rxq_info *xdp_rxq,
+			      const struct xdp_mem_info *mem)
+{
+	xdp_rxq->mem = *mem;
+}
+
+static inline void xdp_rxq_info_detach_mem_model(struct xdp_rxq_info *xdp_rxq)
+{
+	xdp_rxq->mem = (struct xdp_mem_info){ };
+}
 
 /* Drivers not supporting XDP metadata can use this helper, which
  * rejects any room expansion for metadata as a result.
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index dfd919374017..b612b28ebeac 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -194,8 +194,7 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 	 * xdp_mem_info pointing to our page_pool
 	 */
 	xdp_rxq_info_reg(&xdp->rxq, orig_ctx->rxq->dev, 0, 0);
-	xdp->rxq.mem.type = MEM_TYPE_PAGE_POOL;
-	xdp->rxq.mem.id = pp->xdp_mem_id;
+	xdp_rxq_info_attach_page_pool(&xdp->rxq, xdp->pp);
 	xdp->dev = orig_ctx->rxq->dev;
 	xdp->orig_ctx = orig_ctx;
 
@@ -212,6 +211,7 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 
 static void xdp_test_run_teardown(struct xdp_test_data *xdp)
 {
+	xdp_rxq_info_detach_mem_model(&xdp->rxq);
 	xdp_unreg_mem_model(&xdp->mem);
 	page_pool_destroy(xdp->pp);
 	kfree(xdp->frames);
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 4869c1c2d8f3..03ebdb21ea62 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -368,6 +368,18 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 
 EXPORT_SYMBOL_GPL(xdp_rxq_info_reg_mem_model);
 
+void xdp_rxq_info_attach_page_pool(struct xdp_rxq_info *xdp_rxq,
+				   const struct page_pool *pool)
+{
+	struct xdp_mem_info mem = {
+		.type	= MEM_TYPE_PAGE_POOL,
+		.id	= pool->xdp_mem_id,
+	};
+
+	xdp_rxq_info_attach_mem_model(xdp_rxq, &mem);
+}
+EXPORT_SYMBOL_GPL(xdp_rxq_info_attach_page_pool);
+
 /* XDP RX runs under NAPI protection, and in different delivery error
  * scenarios (e.g. queue full), it is possible to return the xdp_frame
  * while still leveraging this protection.  The @napi_direct boolean
-- 
2.43.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
