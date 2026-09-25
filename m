Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80CA1C98324
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107EE40B2B;
	Fri, 25 Sep 2026 13:27:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y0VfyuPxFVIH; Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 55AF140B9D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790342821;
	b=RHsYiaiIyuWWEHhz7/D9NkXYP/nbcc0H60NkND2sUIzzUmFhBhJo21+8Igwqg75bWYJS
	 2CsjAFW3OcZvK2YPc4v6KA//Qlq21prM3bwnbGrK24EzKlXEroi0EhNg+1Bjtyj9mXJ7h
	 XDFQFGB+1BYOG2QauYsYCgpOuz6wgMtpce6NffJUbSgNW6cU2q/qj1qnxCDajHvgiZFAA
	 xoVvaj7kEo53Xlkp8yZhx1cGZAjlAuAW09lKxG9S6+36W3RyFUVw74ivG0j5fZ2SGbC9X
	 JyW9kAnjH8K90rQju20No/KQ7SFV6JGPp8NTG1c/aRbb4KlwXo9WEsXxnOZbNPeqARA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790342821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g5laovo3OdZ/Bv/tl4G6jg5yvBYrXvpnn01xyqRo4a0=;
	b=WwksY7yLrH5LDDcWOqGkxL19d8A90j/qVibYC9a0Kcz11D1+Moss9Aia3saagDev3TqK
	 w9vV6fioRadFU24fTKyWKLjxuC+UkUg1eAkbVkcZbrL5dbYezA9R1QHkfxbcSRufDVnPO
	 iaogjh4uVI21kRvqXL5y2c9Xe+AvZ0j1OYxtEAQfHyrk3+4ttxwUYHM9PPDOZGd7z5MLO
	 1P6Ng/fiAoxTq/b6iRqRe/dVZ2mwKbcMwAIj58G31yMSrEqPCsRsIf1azmpKBRcN2M5Ps
	 jOI2IrpZjFEeQ2kFYrcF9Oa4TL9DO733HFpwIMvoS6bqRTjEICbPtKhdbQU8beq/vgg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L5ZNuheo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790342821;
	bh=g5laovo3OdZ/Bv/tl4G6jg5yvBYrXvpnn01xyqRo4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=C+5TxzYAhW0YbbJTzPObpIBBTD7NoYc6rPq6jhXyDDUsR5r0FCHLUeuVKAz9PBCMB
	 wSlZbRpfm+jsgohJKBzm6KZrtFNrDCy7dS8gCEg7xzTV6oCt/+H/gZitpPhhWm0eGD
	 ZqVfEvUxUAL6FF2OX6haA7/AtK3zsh+oU/VQXFBS6oLQkqefbNUv8vo6CtUOxUcOlo
	 F6A/XTrpzaHJNvqTNGGkeg3pv1VhAXKg2FYoHuSD9c2WjyVNrA8tX9vCWrxQcinGk3
	 JtT2Pzak6CivzCGeVS9U03TY0juCbica2Pg3N4XNWm4wRabp63Qu3oTYFRo5HlPRZ6
	 Y8LSjRCU3CUaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55AF140B9D;
	Fri, 25 Sep 2026 13:27:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 19B9B32F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 000B240B2B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9TQAyLJjEmCE for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 13:26:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 11AEA40B9B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790342818;
 b=Oz+iTDUhLZOoD1g+EvS2m4p4qKy4Ac7Oe8YTGnneSrWpOhqJsHPJT0NsLoAC+5ZO6NGn
 hWT8prer1WNgDG7eJKXT45fTXt+2O8yJSFTc/MbtOTCIOth/OldOlzkdPjsK++t0xqU1j
 chKAeX2odN/wdGpnQsy2EMN5LgTKMSyg2Jf8Iy0jQ2aKyzN+Iq+MGu8mhaAv9Q+FmbZcb
 Dcsvw4oD7asQ0ceTg+UwM9u0aVcF3Ev7LDcOb/NzZ0MMMVuQHPxg0ZTEr5piqqXM4OJq/
 tuskPjdxcP2w0WDaLFepwlvtg733nouYD4JZbcLgbOQVMjSWWJw50yRRXvqovLry1Dg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790342818;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=g5laovo3OdZ/Bv/tl4G6jg5yvBYrXvpnn01xyqRo4a0=;
 b=M+UGjDR+mmk2aDtgj+h7hmTLm8Vt0uUB5pNaD2YPwxPvqLnIFvWNE4mm9mzaTVbuHS0C
 h3XtGeFN485XKIZEEQJCJrSvLquqqDdHyA2bymrgo4bfmOBIiQFzut5Kgl4+Qws3YDBMy
 C/pQ2m/TsaXYC1Tr6ROA9apFDFeCHe0G/hC8WQ/9LVNImNND6md7nC00lkUS1r9OT+s6Y
 J5lRgPZpy1+X5qfIdsTpbw3Rg76MCDm1gvHg5GLqylRxl1tVQLjy3tr/V4Izk5qCTBkNW
 WtzfnAx2EEWStTxrzjAoqH8AV/6Rdwu+uhAhTzPYUgKiF4mlEkbaY3xFEMa8UuLQsww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L5ZNuheo; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=L5ZNuheo
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11AEA40B9B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 13:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790342819; x=1821878819;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x2wwEbPVie6CMsrf1xJi1pIqXQS+S3mYG3w++bGGjHU=;
 b=L5ZNuheoHSosuIhlG+LFs+fjSZYZdbOaCbs9wQpwa7inwhB9IKQqBNd1
 KFfgFLbBp9iHXq7uFlO62MIP/jv0Qg9t3gJ7loao4QBqPeWUYgTtbOql5
 OjsUj6F++2PKV2JXYaUFTeSBmNenXtZSFWAKxu/Uc+LQUd7QZgDl9YcST
 c+QYn05x1IBADU3yaHK7I1lt+frCqpS5MvZ/UBRdPzEHsmajfs5AsPV1S
 L7G5WKqgHJfDCNF5pDN620ERIRWdS8PubW7dDIi0hlJRCZBVFulIM+XPz
 njHBKbf17Ei8uHYdNg/WaWmXt9vLW+tmtLfF6h5g86mqUD5/mAOF4rMks A==;
X-CSE-ConnectionGUID: XUrPiTAjRFyuqNKhwlLrpw==
X-CSE-MsgGUID: h01lv6/bTA2QJVOaMKZr6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="107508257"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="107508257"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 06:26:58 -0700
X-CSE-ConnectionGUID: kt8f7c0mRNOUJqYFHMmuPg==
X-CSE-MsgGUID: cHXg2R/fQAGgV3VM1fr8tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="282414690"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa005.fm.intel.com with ESMTP; 25 Sep 2026 06:26:54 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.245.32])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 1DE9E2FC55;
 Fri, 25 Sep 2026 14:26:53 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v5 2/6] ice: extract __ice_vsi_free_stats()
Date: Fri, 25 Sep 2026 15:15:44 +0200
Message-ID: <20260925132636.123300-3-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
References: <20260925132636.123300-1-przemyslaw.kitszel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Record the length of each ring stats array in struct ice_vsi_stats, so
that freeing the array entries no longer needs the owning VSI. Keep the
new fields in sync in both places that size the arrays.

With that, the body of ice_vsi_free_stats() becomes independent of the
VSI and can be split out as __ice_vsi_free_stats(). The @free_entries
parameter is always true here; a later commit adds a caller that frees
only the array container, after its entries have been handed over to a
freshly allocated stats structure.

The free path now stops at the recorded length instead of the VSI queue
count, so it follows the real allocation rather than a number that can
disagree with it. Sizing still does not: "ice: rebuild ring stats arrays
instead of reallocating them in place" starts using the lengths to carry
entries over, and only "ice: size ring stats arrays from the final queue
count" makes them authoritative for the allocation path.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v5:
 - drop the "no functional change intended" claim, the bound of the free
   loop changes owner here (Clashiko)
 - state that the recorded lengths govern only the free path at this
   point in the series (Clashiko)
---
 drivers/net/ethernet/intel/ice/ice.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 52 ++++++++++++++----------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index db3c7015c56c..fadfe94bf1c8 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -328,6 +328,8 @@ enum ice_vsi_state {
 struct ice_vsi_stats {
 	struct ice_ring_stats **tx_ring_stats;  /* Tx ring stats array */
 	struct ice_ring_stats **rx_ring_stats;  /* Rx ring stats array */
+	u16 tx_ring_stats_len;  /* Length of the Tx ring stats array */
+	u16 rx_ring_stats_len;  /* Length of the Rx ring stats array */
 };
 
 /* struct that defines a VSI, associated with a dev */
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 31af378aa0e7..1414127d32cd 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -330,42 +330,48 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
 	vsi->rxq_map = NULL;
 }
 
+/* free single stats memory */
+static void __ice_vsi_free_stats(struct ice_vsi_stats *vsi_stat, bool free_entries)
+{
+	if (!vsi_stat)
+		return;
+
+	if (free_entries) {
+		for (int i = 0; i < vsi_stat->tx_ring_stats_len; i++) {
+			if (vsi_stat->tx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
+			}
+		}
+		for (int i = 0; i < vsi_stat->rx_ring_stats_len; i++) {
+			if (vsi_stat->rx_ring_stats[i]) {
+				kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
+				WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
+			}
+		}
+	}
+
+	kfree(vsi_stat->tx_ring_stats);
+	kfree(vsi_stat->rx_ring_stats);
+	kfree(vsi_stat);
+}
+
 /**
  * ice_vsi_free_stats - Free the ring statistics structures
  * @vsi: VSI pointer
  */
 static void ice_vsi_free_stats(struct ice_vsi *vsi)
 {
 	struct ice_vsi_stats *vsi_stat;
 	struct ice_pf *pf = vsi->back;
-	int i;
 
 	if (vsi->type == ICE_VSI_CHNL)
 		return;
 	if (!pf->vsi_stats)
 		return;
 
 	vsi_stat = pf->vsi_stats[vsi->idx];
-	if (!vsi_stat)
-		return;
-
-	ice_for_each_alloc_txq(vsi, i) {
-		if (vsi_stat->tx_ring_stats[i]) {
-			kfree_rcu(vsi_stat->tx_ring_stats[i], rcu);
-			WRITE_ONCE(vsi_stat->tx_ring_stats[i], NULL);
-		}
-	}
-
-	ice_for_each_alloc_rxq(vsi, i) {
-		if (vsi_stat->rx_ring_stats[i]) {
-			kfree_rcu(vsi_stat->rx_ring_stats[i], rcu);
-			WRITE_ONCE(vsi_stat->rx_ring_stats[i], NULL);
-		}
-	}
-
-	kfree(vsi_stat->tx_ring_stats);
-	kfree(vsi_stat->rx_ring_stats);
-	kfree(vsi_stat);
+	__ice_vsi_free_stats(vsi_stat, true);
 	pf->vsi_stats[vsi->idx] = NULL;
 }
 
@@ -539,11 +545,13 @@ static int ice_vsi_alloc_stat_arrays(struct ice_vsi *vsi)
 		kzalloc_objs(*vsi_stat->tx_ring_stats, vsi->alloc_txq);
 	if (!vsi_stat->tx_ring_stats)
 		goto err_alloc_tx;
+	vsi_stat->tx_ring_stats_len = vsi->alloc_txq;
 
 	vsi_stat->rx_ring_stats =
 		kzalloc_objs(*vsi_stat->rx_ring_stats, vsi->alloc_rxq);
 	if (!vsi_stat->rx_ring_stats)
 		goto err_alloc_rx;
+	vsi_stat->rx_ring_stats_len = vsi->alloc_rxq;
 
 	pf->vsi_stats[vsi->idx] = vsi_stat;
 
@@ -3055,6 +3063,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->tx_ring_stats = tx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->tx_ring_stats_len = req_txq;
 
 	if (req_rxq < prev_rxq) {
 		for (i = req_rxq; i < prev_rxq; i++) {
@@ -3074,6 +3083,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->rx_ring_stats = rx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
-- 
2.51.1

