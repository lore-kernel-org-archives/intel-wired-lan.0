Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F6C0218A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jan 2025 10:38:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A471180F44;
	Mon, 27 Jan 2025 10:38:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bUZ_JR7dBmOp; Mon, 27 Jan 2025 10:38:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB31F80CDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1737974327;
	bh=/U1D/DXAcgzH0nK2qGw7i9xi+fZzBh10zBegjKQwO38=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RPwSyp3jcQVBL9Vs16RTAS/y1XhuRVgmhQF4WJmgTeyBrfvg+BI59k3r1cglCsSdF
	 lM703RCgEmVuHtI2BDjgbUnv76a/JAXemyayVouyi6I3D2puGb7GX0Wdn9Jk1wl11Z
	 cGPTRDAZtj1Wwfe7nFIuSxzMzX7MDzcWwi8ULJh2mcUmJCQ+RZ+xr1SyF5cpGPwDtv
	 CIDb0OjuwXnjpXxUmw1AgrzaCC25R+GamtACsZyjHLZ8pb+Q1+Tsa6R2dJl55WP2JQ
	 8Xr5Ut/evFnwuYY14Td0ocJTnVZA8kATjlMMDnft/qQyHeyu5G+I/13JGB4VjxSieU
	 76RgiFYzrCmhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB31F80CDE;
	Mon, 27 Jan 2025 10:38:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EF55AF7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jan 2025 10:38:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 764AD80CDE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jan 2025 10:38:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jr55TH4a0Mz6 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jan 2025 10:38:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C3B5880CC7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3B5880CC7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3B5880CC7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jan 2025 10:38:45 +0000 (UTC)
X-CSE-ConnectionGUID: Fivt//XpQXinFct3bQe8Jw==
X-CSE-MsgGUID: j9+SMMgRQnqKEW/r7h+uxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="48932148"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="48932148"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 02:38:45 -0800
X-CSE-ConnectionGUID: 9G6J6tHrTGeK+AY0/qiByg==
X-CSE-MsgGUID: z6KFdYhbSxaMvI580DNKgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145617408"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO
 vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
 by orviesa001.jf.intel.com with ESMTP; 27 Jan 2025 02:38:43 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org, yuehaibing@huawei.com,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Mon, 27 Jan 2025 11:38:36 +0100
Message-ID: <20250127103836.4742-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737974326; x=1769510326;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vP2LTKP+qu0xqj75CnvY4A/++gLHdUEBTltNI3EcilQ=;
 b=WJpAcIEhap6RZb6thziKT4KBaykLYf8pVpyuvswtIR3RuFy560Ej0GVS
 GukErptziRKdZVobx4uux3qc6jo2VwccwbjnxkH2s1F6KEcKDPzDQn9wp
 ALCFAOSSVagzlzjxT4BQKAaMnVi5pLnZJAgSbVWjPqpuXo28eB0eBPeQn
 gfGGjahmoWux9CqVn3NT8k1DtBFHPv5Mv0JYSdp0UauuXl+NGCrH7MHo+
 kyndyIhLcGz4GEgNap0eowH+k66oWohILN+SAuGaUTFylKQtJbYAn9pnn
 KAeb6LdDx8LL+uPABaMkgH2jWk8SKtMw1WfpoSKuIED7pQGxyFi2g00Uw
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WJpAcIEh
Subject: [Intel-wired-lan] [PATCH iwl-next v3] ixgbe: Fix possible skb NULL
 pointer dereference
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
encoding. Propagate this logic to the ixgbe_put_rx_buffer().

The commit also relaxed the skb NULL pointer check - caught by Smatch.
Restore this check.

Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20..467f812 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2105,7 +2105,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
-- 
v1 -> v2
  Provide extra details in commit message for motivation of this patch.
v2 -> v3
  Simplify the check condition

2.43.0

