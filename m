Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC7FCC02183
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Jan 2025 15:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48A15837D3;
	Fri, 17 Jan 2025 15:49:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QiYwm9FnzbGi; Fri, 17 Jan 2025 15:49:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90E6B836CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1737128990;
	bh=RxCyXJFuOGz/Z77qZgFMhvUKXwrs8YW0TzcyIen2IIQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xamZW3DCGM9OunsxBBnuh1QAu+NrajVwmeqklCwqW74/xECjvTGqho3AvLBvJ+QU2
	 BWCG12CWKWHTi5gz5FR+6Gyhl5hiaaI2BJntjoPKGjeV6Ppp0RIyfWLS8U7ZBqSc/g
	 NIW/wrDdPJdCVt0A3vpCbnJIChd5QZ7rvLPfUyc/biPbLU8ljuc04ZetsVemS8m/Ls
	 z/dvHH89myRXGXN/L4g1OArZ3/qNKJ3mDNoOpjTYtI3EhxDvXZHtS9n73hs557PBzt
	 dZE53Rf3+0P9+kOZEHn19aghmCQza6NY8UEmcAFuVm0u8t34IJR94wX7fbzlWqLaIm
	 uCTdml629X3Rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90E6B836CE;
	Fri, 17 Jan 2025 15:49:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 01C5EB89
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jan 2025 15:49:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D6D3C836CE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jan 2025 15:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Guq7dfdSH61B for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Jan 2025 15:49:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=piotr.kwapulinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2A2B380E20
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A2B380E20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A2B380E20
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Jan 2025 15:49:47 +0000 (UTC)
X-CSE-ConnectionGUID: DUnQDycCSFKNlC6xXDlrbA==
X-CSE-MsgGUID: s7X0axlARAeif0G3frNNMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11318"; a="48055138"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; d="scan'208";a="48055138"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2025 07:49:48 -0800
X-CSE-ConnectionGUID: 6vsFm0MGSISAu6IVpNSOeg==
X-CSE-MsgGUID: BlOmfEYzQmyKPg/KmioWAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; d="scan'208";a="106389208"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO
 vbox-pkwap.ger.corp.intel.com) ([10.246.2.76])
 by fmviesa010.fm.intel.com with ESMTP; 17 Jan 2025 07:49:45 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, dan.carpenter@linaro.org, yuehaibing@huawei.com,
 maciej.fijalkowski@intel.com, przemyslaw.kitszel@intel.com,
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Date: Fri, 17 Jan 2025 16:49:35 +0100
Message-ID: <20250117154935.9444-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737128989; x=1768664989;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=u9mqR5GFsnLVc3LLaI0YgiNR9Lw9j+cHWpZrt16d0EQ=;
 b=PIoBaieDs32DnWRxrgYUz+m8PEnph0hWD/cevl2zT45RUVskc0ftISmG
 aXdpgQadbR7rOV+6hSsqmOFsjj+SGxklqNrXPPBsy5i4LfDylDZ3qjnJR
 1zVGhA9Hj13QOrTNaU4RTRz7x1YCK9uSHH/Uxqqw9ZJPvX5XvxpDLmehX
 WZUarBDK4vYQdY/XjboFUca/5Y7sIzqFml7hrBsT3Rq2i6JuAAeRJe0Xe
 lRAuQxRH3ne/JHbk4Zp9dqkyPwxd3XCDwPjOX0qBDvzatK3aXrAqhM1QG
 iUakTh5U0yoODIEHfpkEG27vjcWRoa5tBggBeLJpU+oXtPziDs9mhNubz
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=PIoBaieD
Subject: [Intel-wired-lan] [PATCH iwl-next v2] ixgbe: Fix possible skb NULL
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20..c682c3d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2098,14 +2098,14 @@ static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
 
 static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 				struct ixgbe_rx_buffer *rx_buffer,
-				struct sk_buff *skb,
-				int rx_buffer_pgcnt)
+				struct sk_buff *skb, int rx_buffer_pgcnt,
+				int xdp_res)
 {
 	if (ixgbe_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && !xdp_res && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
@@ -2415,7 +2415,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			break;
 		}
 
-		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
+		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt,
+				    xdp_res);
 		cleaned_count++;
 
 		/* place incomplete frames back on ring for completion */
-- 
v1 -> v2
  Provide extra details in commit message for motivation of this patch.

2.43.0

