Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5383FF885A
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 07:48:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B312835A6;
	Tue, 28 Apr 2026 07:48:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ewXtaIcdU2WR; Tue, 28 Apr 2026 07:48:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB1F181DF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777362524;
	bh=jZwj4tX/oev43hW6mlw83gckHgi/VwfgkmUGlAjEjyk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5l9Sw2ZrFBMfqpGhTF/uKnCI10ONo5UJ4TKAy4iR4yCyFabhpSjp6VYFy+GPatB4L
	 9uYlt8+ozI21dF+K+b8I6yRGRVhzN3D2tgRoj9n4f9c2kDmD95xTd5GCsPUitXEKdc
	 kjTR/TfMqgprhTKol1yzvYqEtoA/DTaWSX9MH4H9jljD+tW+wX4f1uuCxufGusVJ8L
	 U1tdaBI6kIN5TY3ll2I+E9Xi8NZlUQLygkkhouOeBg+WwjHCVHtsp4YJY263XnH7Dx
	 c+6a+cpk+HSKXU+EgTeClpslea0ZETbq0vS7C00419kTgXyKIW/cWZ8GfXb0LPdn28
	 UqP0Ix9A/930Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB1F181DF6;
	Tue, 28 Apr 2026 07:48:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2DDD1B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4DEB835A3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eXPpyrlZg8JU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 07:48:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=michal.swiatkowski@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E754E80984
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E754E80984
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E754E80984
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 07:48:41 +0000 (UTC)
X-CSE-ConnectionGUID: JEJwj2pgSJO5beip3bt+ew==
X-CSE-MsgGUID: rAHcBGM/T8ONTCYwoQ9r9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82114977"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="82114977"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 00:48:41 -0700
X-CSE-ConnectionGUID: oZxoNrDDT2KD76jnox+vpA==
X-CSE-MsgGUID: RZOxA7l0Sb+HUeBPeYePMQ==
X-ExtLoop1: 1
Received: from os-delivery.igk.intel.com ([10.102.21.165])
 by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2026 00:48:39 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jramaseu@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, aleksandr.loktionov@intel.com,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Tue, 28 Apr 2026 09:06:46 +0200
Message-ID: <20260428070647.777141-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
References: <20260428070647.777141-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777362522; x=1808898522;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=89VxZuTuAfq1TCEMT31Kq1wu5QB4YSBR1QkGpSsfP4Y=;
 b=ZLqvc++FnAsxpdsJBpfD2Y7dtlR9tMDhJblSsLzeiBCpSRJ6PqOWnuKo
 MSG6+GIM9J9QCO98pbjvtwO6Lb3qERF33AY5RGaiorsp6GxUpLF3yMs3p
 Yx2hZ27tjDlWAjuJhWuYwir+IoSlDQFc/QLh44+MxPY1TqMgPn57OU1Uh
 6a9nxkpPpDshqA/W7sJKKmStZ+wpbUHeK0DTLLTjDOaVdEy6PYBCoUyUM
 XZ6z+h4BvZi4J5wy7ofZ7eI92ejK3TprzjohnWvEWDqg3AUk0rLpCwshB
 M1s7hgHBZTI48qVHnk8+7OxWMBitECasFwA9eqbBgBRJaMJgOEiIyr7cD
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ZLqvc++F
Subject: [Intel-wired-lan] [PATCH iwl-net v1 1/2] ice: always do GCS if
 hardware supports it
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

There is no need to check for NETIF_HW_CSUM. If the code reach
calculating checksum it means that correct checksum flags are set,
because kernel is checking that when setting ip->summed.

Instead of netdev feature flag use Tx ring flag to check if the hardware
can use special descriptor for checksum calculating.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++++
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 837b71b7b2b7..033fabc22f58 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1415,6 +1415,10 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG2, ring->flags);
 		else
 			set_bit(ICE_TX_RING_FLAGS_VLAN_L2TAG1, ring->flags);
+
+		if (ice_is_feature_supported(pf, ICE_F_GCS))
+			set_bit(ICE_TX_RING_FLAGS_GCS, ring->flags);
+
 		WRITE_ONCE(vsi->tx_rings[i], ring);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4ca1a0602307..25b19a5d817e 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1743,7 +1743,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 	l3_len = l4.hdr - ip.hdr;
 	offset |= (l3_len / 4) << ICE_TX_DESC_LEN_IPLEN_S;
 
-	if ((tx_ring->netdev->features & NETIF_F_HW_CSUM) &&
+	if (test_bit(ICE_TX_RING_FLAGS_GCS, tx_ring->flags) &&
 	    !(first->tx_flags & ICE_TX_FLAGS_TSO) &&
 	    !skb_csum_is_sctp(skb)) {
 		/* Set GCS */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5e517f219379..15dbd5100912 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -217,6 +217,7 @@ enum ice_tx_ring_flags {
 	ICE_TX_RING_FLAGS_VLAN_L2TAG1,
 	ICE_TX_RING_FLAGS_VLAN_L2TAG2,
 	ICE_TX_RING_FLAGS_TXTIME,
+	ICE_TX_RING_FLAGS_GCS,
 	ICE_TX_RING_FLAGS_NBITS,
 };
 
-- 
2.49.0

