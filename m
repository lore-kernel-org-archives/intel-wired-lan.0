Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED62C88E4A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 11 Sep 2026 11:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 898FA605E7;
	Fri, 11 Sep 2026 11:39:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApuuZ-Z-F7XE; Fri, 11 Sep 2026 11:39:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DD0A46068A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789126748;
	b=aXDjfTB0k0GzGzYiuhapfcWKePfLVsqsgjMg+p6MV351WrZSpWeD5/XzbCa//XufRKMe
	 5Hh4r7iEuF9l/TmYeUsGeHmeqbr/rAuCuFqxRHTai5S+iCWKDA6LVCKb7rOgh2x8Ru7Em
	 6jViS2aNx0xncQzOj81xBJVsA6lFgk/AEavnSRDpum/Hb9pwUNCIL9b+UbdOhhIypPySd
	 fxx88yMshyJiMrDWaA1iE0/CRaUfb1BS8TxHZ+D8BpMhlGfkdd/DdolcC2AziSmRZ7hVg
	 LWcKedfpl7GM/dSLMBcFrw/2rlGEQ96S+vpKUNyyU0aTJd5N9u2zdZoSEOAZFdGC4Ew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789126748;
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
	bh=96Swt1QFQ1+bYIggWuKQL9H906SJHsHdKWs0o3CmBs8=;
	b=a/RkPdZPhwM9g9Px8WbpNWdat1YsfikYodFZNi28pEIIIPEA5lz9qxDbZZ1264HPBgn5
	 00m5g7HwNW+9OpraIjHVw/J4cYUUietswFM8u/7fchFJ9EgnR2pDkSuyA4iY/WZ4Oq7WA
	 2yrjezT2BdIVkLzBLAlgkGNIEdr9gRZdDomPgMCc3uqWXyG3cz1n1HZxdIgwHb9HGx8ov
	 fvadnFYgY7X/dghCa7UDnrpgsFxjnO6GuY6MeSj7cZWyXMr5XVxw+flzYZXQyuEbnPKUt
	 3x7bAwtuYtASng0yL2qurQWKgr/AmE8pa0xmYTAJ827jLbQs/jDcPtbxLZTJS0O7L+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fI3pl5BA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789126747;
	bh=96Swt1QFQ1+bYIggWuKQL9H906SJHsHdKWs0o3CmBs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vDDRQM6xZLI7JPlNENk/qUZ3A73BB+q0V75ZKgef2ctuzheGL+gysMgczATPWIVdI
	 aGEI5NymcOOiQlpUN7I6c3O8GGe7HP1//5gYlRVYmOCVZpv5b86cZrW2GuF9UfkFXN
	 wU6zVEpDIEYP2DojjIS0ld16YWgKIpQmFJB06sTfou3scvtq15WcNtkX6yZixqWD3w
	 mkd6WhdELaiJnt1dDiGs+Gpww6VZOKfZC90QlNJA+o6x/CPgy4/xEWCMI/S28gp6Q/
	 V71puxTGOLNBrBaShB1Gb4hrFmBx3u4iCbd4uVuU3DxsuIgx1Kfa54eaF4uM/VUEic
	 LEdVoT/I0flpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD0A46068A;
	Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 24CCD29B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B037606DB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZUplOOR4ibB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 11 Sep 2026 11:39:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 37D03605E7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789126746;
 b=EeX1JAFe2Ff2DCoNj+fMwxmgV9WtgBferYM5GjMgwBB4SXlsLna3GU5sPvnHNf3WF5Sy
 CNsaH05k7kk69Wh2/IMb6L68GLq3oHUkr6Fhw4lfhW0HANZtsn29yCy/jPvPWTlHBwhiq
 9RfX15Iptsnu9K/WBS+aECu2BBAeERVtw5QVliylfyfsoQsQ9y1odLgh10+1uxIThSHbE
 u2f/39CtckCeB95GksPlcp9asBMsKq1gH9UA2onJQZe/h+3wEY5i+zFfAstLxTGKZhrUi
 EXFZu9eFGGdIdAchD7mnVZy4ToK9gPkBBEjPee5fRlCOYhg0prE3Dtf9BOyB3AZZlIw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789126746;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=96Swt1QFQ1+bYIggWuKQL9H906SJHsHdKWs0o3CmBs8=;
 b=YEkH/rAfch8ET/v+CJbhk0dSpiWORd/V5dSWzB+R15cXSZatX2hEC8AjWK5josld6Mjh
 +SqFBbsMTcX5R2PFDf5yyM2VI04huTv3ZS9ITdCUimlGng1V311DdUQaTbgrJO3vbE3gN
 8s9zcynLFZ9JaeXxJBHZR0iCe79JbYsOTWoUoM/WKREK0ocBCHQ0yXqRC07IpAc2yk3xT
 gYyydKfrN01cmdMz4rgxh9sx/G22MDg27yXcqIRDsw60jNduADQdpDPd5J1x0locYs9yN
 mKQ/hPDbzaEI7ocW/euLL/FkPx1vfna3/PGPoNN5Yk0l5wOA0ocSzT0SZvdYAzEh1VA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fI3pl5BA; 
 arc=none smtp.remote-ip=198.175.65.9
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fI3pl5BA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 37D03605E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 11 Sep 2026 11:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789126746; x=1820662746;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LLYLDHjuwzMvTr1/Stiz0Wwsjai3Yls5PntYg9C1QHE=;
 b=fI3pl5BAvWVFo3LeE4eCkRrXlCDdykEK6qi6UTvs9ggTAC/w/uUG1SPg
 OHknUca3VvjuA3pgmor4VZOLqrHNULgo0s/6YNLqHG0/m3lKQqhg0HBW7
 RCxqe7wo2ImReL/kQu0uu0m8m2Y70a2+8E5PqGT6aGooN2VOmV2CcGQXl
 52LuIAlj8TaygdttDolWtmDVNI+kGKEcRrgIfDlcNZQGd46Kvp8Y+jnW1
 13N1NEOSpJ0labUIXHxennWVeE46EortKPToRM4p6TJpJbiBpgb7tnsxs
 EP6fSd/zkZmeQ9wdutBtEKmvOhmhW+WcLfmooamKkh6FjsDAHJ1xTjJAT Q==;
X-CSE-ConnectionGUID: H1zQzeGtTwOngP/81r/92w==
X-CSE-MsgGUID: 43NX6/8pQHGQn63NGhHMzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="112359890"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="112359890"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2026 04:39:05 -0700
X-CSE-ConnectionGUID: Lnnl8T9vRIKRqZ4gNhaNOQ==
X-CSE-MsgGUID: iRxC1Hs6TW2Huj+SrRFf5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; d="scan'208";a="270135845"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa006.jf.intel.com with ESMTP; 11 Sep 2026 04:39:02 -0700
Received: from pkitszel-desk.intel.com (unknown [10.245.244.110])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id CF1AE2877B;
 Fri, 11 Sep 2026 12:39:00 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, horms@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net v3 1/5] ice: extract __ice_vsi_free_stats()
Date: Fri, 11 Sep 2026 13:26:16 +0200
Message-ID: <20260911113848.44086-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
References: <20260911113848.44086-1-przemyslaw.kitszel@intel.com>
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

No functional change intended. Just preparation to have easier time
reading subsequent commits.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_lib.c | 52 ++++++++++++++----------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f72bb1aa4067..cf1b0ba8dc29 100644
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
index 8cdc4fda89e9..cd78c5c69a30 100644
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
 
@@ -3048,6 +3056,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->tx_ring_stats = tx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->tx_ring_stats_len = req_txq;
 
 	if (req_rxq < prev_rxq) {
 		for (i = req_rxq; i < prev_rxq; i++) {
@@ -3067,6 +3076,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		vsi_stat->rx_ring_stats = rx_ring_stats;
 		return -ENOMEM;
 	}
+	vsi_stat->rx_ring_stats_len = req_rxq;
 
 	return 0;
 }
-- 
2.51.1

