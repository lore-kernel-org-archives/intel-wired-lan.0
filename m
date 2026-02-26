Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A09CFCE096
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Feb 2026 14:40:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CD7A961614;
	Thu, 26 Feb 2026 14:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y_qYKzm_oWiy; Thu, 26 Feb 2026 14:40:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 085666160C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772116846;
	bh=qARHnqKk21MZqDhxGiWzpYM25hqDkzr2N+z5D2rSXqI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JFDvmZUGKcCz8F+ZLbcZ1kSHNMepoTwjgTlNVIc7ucv4BtBR4mx9u6QNS4za1irq0
	 e6c9+/ht4svfnxQpp0JYcnFPt5p1TTToSkjIygD9ZHmUyA4HGZwARZP0jpib4Jv4XS
	 DnPnLGhOXu7FEMWsvwJ8iss3EMWu1OgiYmjUGXNfh6Sm77URX549ZHSZGf0lgCMzq9
	 JW7P4mzrGdLO8uGm2yB9giN6QN1uv3ksNCNhIuUEY2MVuyWNfYeqxF2IGxsiP/yCug
	 FcIjWdAjtGovCC88nVfX/OZp+eNo3GCPk3mpKPmd3rQ8UHVJ56i32UHYuxkSqEln0A
	 VzqmFq6koeFSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 085666160C;
	Thu, 26 Feb 2026 14:40:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA1A623D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 14:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9022C84623
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 14:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oIq2R1naUeZA for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Feb 2026 14:40:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 84C958446D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84C958446D
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 84C958446D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Feb 2026 14:40:43 +0000 (UTC)
X-CSE-ConnectionGUID: hksXHY5DRkyf9zA/TYYqXw==
X-CSE-MsgGUID: MVNMQJleS+iab+XNGTs+Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="76784557"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="76784557"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 06:40:44 -0800
X-CSE-ConnectionGUID: ZaJK5DoUShOYUYGVGRiTcg==
X-CSE-MsgGUID: jJiAsCLvQJmxDV65pFYD5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; d="scan'208";a="254353841"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 26 Feb 2026 06:40:42 -0800
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com
Date: Thu, 26 Feb 2026 15:40:37 +0100
Message-ID: <20260226144037.400815-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
References: <20260226144037.400815-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772116844; x=1803652844;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=LFsIqutAzBuS+JuknBp9P19J4pCJ4Mbz6dWagWkuRNI=;
 b=VTrTdvqjx7jEYGTw6egCNGL8+JhazNKWVJzANydTfW02L8OVoXJXEDcU
 uLhP18NzxtYr1+SBpDD+p9VVKUHBzJxZRz+uP4lMb18T0rLn1JP/Xi2H8
 o5om1RJZnCBvifnTC8XgEuxl+T5ePisto7KaY/CqgrNy905Nb9cp0XleP
 vFSW2EcpR/9Ktp1yGRBajEGtCZ/fQ3yK6zSYxylL/ggyWt4zdv3lslW0R
 OJ9dGFmRNrRcOUz6cE3bbSrg0GYj1j0N7ctQqW1gY7UB38N3zF5td91F0
 lGcRBuRe7EeDcBZZBIW43wFYE5u6to9Q4RvQZpOnmOHWSp5WbbjeQ/k8x
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=VTrTdvqj
Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/2] ice: implement symmetric
 RSS hash configuration
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

The driver advertises symmetric RSS support via supported_input_xfrm
but ice_set_rxfh() always programmed plain Toeplitz regardless of the
requested input_xfrm, making it impossible to actually enable symmetric
hashing.

Fix ice_set_rxfh() to honour rxfh->input_xfrm: program symmetric
Toeplitz (ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ) when RXH_XFRM_SYM_XOR
is requested, revert to plain Toeplitz when the transform is cleared,
and skip the hardware write when the function has not changed.

Make ice_set_rss_vsi_ctx() non-static and export it so ice_set_rxfh()
can reprogram the VSI context directly.  Change it to preserve
vsi->rss_hfunc across VSI reinitialisation instead of always resetting
to plain Toeplitz, which would silently undo any previously configured
symmetric hash function.

Fix ice_get_rxfh_fields() to report the hash fields actually programmed
in hardware.  When the hardware hashes on only one half of an L3 or L4
pair, complete the pair in the reported bitmap to satisfy the kernel's
symmetry validator.  For GTP flow types, report RXH_GTP_TEID honestly;
ethtool_rxfh_config_is_sym() now accepts TEID as an intrinsically
symmetric field (see preceding patch).

Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 40 ++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lib.c     |  7 ++--
 drivers/net/ethernet/intel/ice/ice_lib.h     |  1 +
 3 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c6bc29c..6ccfe36 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3008,14 +3008,17 @@ ice_set_rxfh_fields(struct net_device *netdev,
 	return 0;
 }
 
+#define ICE_RSS_L3_PAIR		(RXH_IP_SRC | RXH_IP_DST)
+#define ICE_RSS_L4_PAIR		(RXH_L4_B_0_1 | RXH_L4_B_2_3)
+
 static int
 ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
+	u64 l3, l4, hash_flds;
 	struct device *dev;
-	u64 hash_flds;
 	bool symm;
 	u32 hdrs;
 
@@ -3067,6 +3070,13 @@ ice_get_rxfh_fields(struct net_device *netdev, struct ethtool_rxfh_fields *nfc)
 	    hash_flds & ICE_FLOW_HASH_FLD_GTPU_DWN_TEID)
 		nfc->data |= (u64)RXH_GTP_TEID;
 
+	l3 = nfc->data & ICE_RSS_L3_PAIR;
+	l4 = nfc->data & ICE_RSS_L4_PAIR;
+	if (l3 && l3 != ICE_RSS_L3_PAIR)
+		nfc->data |= ICE_RSS_L3_PAIR;
+	if (l4 && l4 != ICE_RSS_L4_PAIR)
+		nfc->data |= ICE_RSS_L4_PAIR;
+
 	return 0;
 }
 
@@ -3667,7 +3677,6 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	     struct netlink_ext_ack *extack)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	u8 hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
 	struct device *dev;
@@ -3689,13 +3698,28 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 		return -EOPNOTSUPP;
 	}
 
-	/* Update the VSI's hash function */
-	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
-		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+	/* Handle RSS symmetric hash transformation */
+	if (rxfh->input_xfrm != RXH_XFRM_NO_CHANGE) {
+		u8 new_hfunc;
 
-	err = ice_set_rss_hfunc(vsi, hfunc);
-	if (err)
-		return err;
+		if (rxfh->input_xfrm == RXH_XFRM_SYM_XOR)
+			new_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
+		else if (!rxfh->input_xfrm)
+			new_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+		else
+			return -EOPNOTSUPP;
+
+		if (new_hfunc != vsi->rss_hfunc) {
+			err = ice_set_rss_hfunc(vsi, new_hfunc);
+			if (err) {
+				netdev_err(netdev, "Failed to set RSS hash function\n");
+				return err;
+			}
+			netdev_dbg(netdev, "RSS hash function: %sToeplitz\n",
+				   new_hfunc == ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ ?
+				    "Symmetric " : "");
+		}
+	}
 
 	if (rxfh->key) {
 		if (!vsi->rss_hkey_user) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index d921269..5b1934b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1155,7 +1155,7 @@ static void ice_set_fd_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
  * @ctxt: the VSI context being set
  * @vsi: the VSI being configured
  */
-static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
+void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 {
 	u8 lut_type, hash_type;
 	struct device *dev;
@@ -1181,8 +1181,9 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		return;
 	}
 
-	hash_type = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
-	vsi->rss_hfunc = hash_type;
+	if (!vsi->rss_hfunc)
+		vsi->rss_hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ;
+	hash_type = vsi->rss_hfunc;
 
 	ctxt->info.q_opt_rss =
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M, lut_type) |
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98..29ba335 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -46,6 +46,7 @@ void ice_vsi_delete(struct ice_vsi *vsi);
 int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 
 int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi);
+void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi);
 
 void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 
-- 
2.52.0

