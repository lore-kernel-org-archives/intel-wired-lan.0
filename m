Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D83C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  4 Oct 2022 12:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 53C92400F2;
	Tue,  4 Oct 2022 12:15:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 53C92400F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664885758;
	bh=ladfmHCtKDha6yfv9TSPZmvqIi4hqIPHIjOCgR3sdH4=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=3ZFH4WCovYfu0HClYsPwIgr4kF251RWTQsDDA6DxwW3dE8rx1uROcov8eMGEHeVX4
	 Q8Ya7p+ZIGrkgTYMdKfYTEWxkQ7nvn/UmeO8n4tdQKPvTbe009qNSofou9NPkBBPHJ
	 hqcGalFKXz95HHZOPUlK3dK0UCVdKTPSWzP7shjLIugqd8TrCC83wLNSW+k3wthIr5
	 meoZlVssGZ01UXYomWapjjV+5AzpNwpyoG8jWrdasUGXvbqbQqhzeMiWdh/893yMSe
	 XPzrSntZD0JJ6USmuIw6MDtuYcY4VrXk88DoZ4s9MVbcDaIwZNr87jLNzB5InjFnw/
	 ozY16EzzrSVwQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fWv2X4Re-IbA; Tue,  4 Oct 2022 12:15:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 43B1640141;
	Tue,  4 Oct 2022 12:15:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43B1640141
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id E199D1BF846
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Oct 2022 12:15:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC588831F8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Oct 2022 12:15:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC588831F8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id malEwnM034ss for <intel-wired-lan@lists.osuosl.org>;
 Tue,  4 Oct 2022 12:15:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E86008308B
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E86008308B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  4 Oct 2022 12:15:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="301614510"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; d="scan'208";a="301614510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2022 05:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="712990677"
X-IronPort-AV: E=Sophos;i="5.93,157,1654585200"; d="scan'208";a="712990677"
Received: from amlin-018-068.igk.intel.com ([10.102.18.68])
 by FMSMGA003.fm.intel.com with ESMTP; 04 Oct 2022 05:15:52 -0700
From: Mateusz Palczewski <mateusz.palczewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  4 Oct 2022 08:14:11 -0400
Message-Id: <20221004121411.663310-1-mateusz.palczewski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664885754; x=1696421754;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=itnOH8ImCe3ENTphbSXmmxiONSbs5umgJgaT1sHPJpA=;
 b=B1cnRjN3u9ZH7j6UM4kisc79XSTnE42rix7+MEB4mqqF8pTPAYY2ujux
 WWzsUHqp8r8gsfFi19LyQb3cPhlgDLbL0Uk+P6wgza14zRF7o7FI7uPmV
 irAU8Nz70oYdhNJC86VBQXQtTFa5MultOFsWRF1daoSmce4BtRmfuO1ow
 amTfgjEAw0nL6EAjJh+XGccPWtpOXGktC4Y2Lya+cTzSOgRef6Nf/eVXa
 bVi/Ef4j8t8hUdaaGNtn4tfNvuLMQxeslOoF2CXKWSmNItdjKD87WJT4s
 u8da6P2ZQ8c7TF7qbqi9OCFqwiwx31oo4FPBX6IEMCKiY5ArFfuOxskWe
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=B1cnRjN3
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Fix flow-type by setting
 GL_HASH_INSET registers
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
Cc: Michal Jaron <michalx.jaron@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Slawomir Laba <slawomirx.laba@intel.com>

Fix setting bits for specific flow_type for GLQF_HASH_INSET register.
In previous version all of the bits were set only in hena register, while
in inset only one bit was set. In order for this working correctly on all
types of cards these bits needs to be set correctly for both hena and inset
registers.

Fixes: eb0dd6e4a3b3 ("i40e: Allow RSS Hash set with less than four parameters")
Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
Signed-off-by: Michal Jaron <michalx.jaron@intel.com>
Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
---
 v2: Fixed commit message, added Fixes tag and made some lines
longer for better readability
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 71 ++++++++++---------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0f2042f1597c..6f0d4160ff82 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3604,6 +3604,7 @@ static u64 i40e_get_rss_hash_bits(struct i40e_hw *hw,
 	return i_set;
 }
 
+#define FLOW_PCTYPES_SIZE 64
 /**
  * i40e_set_rss_hash_opt - Enable/Disable flow types for RSS hash
  * @pf: pointer to the physical function struct
@@ -3616,9 +3617,11 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 	struct i40e_hw *hw = &pf->hw;
 	u64 hena = (u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(0)) |
 		   ((u64)i40e_read_rx_ctl(hw, I40E_PFQF_HENA(1)) << 32);
-	u8 flow_pctype = 0;
+	DECLARE_BITMAP(flow_pctypes, FLOW_PCTYPES_SIZE);
 	u64 i_set, i_setc;
 
+	bitmap_zero(flow_pctypes, FLOW_PCTYPES_SIZE);
+
 	if (pf->flags & I40E_FLAG_MFP_ENABLED) {
 		dev_err(&pf->pdev->dev,
 			"Change of RSS hash input set is not supported when MFP mode is enabled\n");
@@ -3634,36 +3637,35 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 
 	switch (nfc->flow_type) {
 	case TCP_V4_FLOW:
-		flow_pctype = I40E_FILTER_PCTYPE_NONF_IPV4_TCP;
+		set_bit(I40E_FILTER_PCTYPE_NONF_IPV4_TCP, flow_pctypes);
 		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
-			hena |=
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK);
+			set_bit(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK,
+				flow_pctypes);
 		break;
 	case TCP_V6_FLOW:
-		flow_pctype = I40E_FILTER_PCTYPE_NONF_IPV6_TCP;
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
-			hena |=
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV4_TCP_SYN_NO_ACK);
+		set_bit(I40E_FILTER_PCTYPE_NONF_IPV6_TCP, flow_pctypes);
 		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
-			hena |=
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK);
+			set_bit(I40E_FILTER_PCTYPE_NONF_IPV6_TCP_SYN_NO_ACK,
+				flow_pctypes);
 		break;
 	case UDP_V4_FLOW:
-		flow_pctype = I40E_FILTER_PCTYPE_NONF_IPV4_UDP;
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
-			hena |=
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP) |
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP);
-
+		set_bit(I40E_FILTER_PCTYPE_NONF_IPV4_UDP, flow_pctypes);
+		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
+			set_bit(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV4_UDP,
+				flow_pctypes);
+			set_bit(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV4_UDP,
+				flow_pctypes);
+		}
 		hena |= BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV4);
 		break;
 	case UDP_V6_FLOW:
-		flow_pctype = I40E_FILTER_PCTYPE_NONF_IPV6_UDP;
-		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE)
-			hena |=
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP) |
-			  BIT_ULL(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP);
-
+		set_bit(I40E_FILTER_PCTYPE_NONF_IPV6_UDP, flow_pctypes);
+		if (pf->hw_features & I40E_HW_MULTIPLE_TCP_UDP_RSS_PCTYPE) {
+			set_bit(I40E_FILTER_PCTYPE_NONF_UNICAST_IPV6_UDP,
+				flow_pctypes);
+			set_bit(I40E_FILTER_PCTYPE_NONF_MULTICAST_IPV6_UDP,
+				flow_pctypes);
+		}
 		hena |= BIT_ULL(I40E_FILTER_PCTYPE_FRAG_IPV6);
 		break;
 	case AH_ESP_V4_FLOW:
@@ -3696,17 +3698,20 @@ static int i40e_set_rss_hash_opt(struct i40e_pf *pf, struct ethtool_rxnfc *nfc)
 		return -EINVAL;
 	}
 
-	if (flow_pctype) {
-		i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0,
-					       flow_pctype)) |
-			((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1,
-					       flow_pctype)) << 32);
-		i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
-		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_pctype),
-				  (u32)i_set);
-		i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_pctype),
-				  (u32)(i_set >> 32));
-		hena |= BIT_ULL(flow_pctype);
+	if (bitmap_weight(flow_pctypes, FLOW_PCTYPES_SIZE)) {
+		u8 flow_id;
+
+		for_each_set_bit(flow_id, flow_pctypes, FLOW_PCTYPES_SIZE) {
+			i_setc = (u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id)) |
+				 ((u64)i40e_read_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id)) << 32);
+			i_set = i40e_get_rss_hash_bits(&pf->hw, nfc, i_setc);
+
+			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(0, flow_id),
+					  (u32)i_set);
+			i40e_write_rx_ctl(hw, I40E_GLQF_HASH_INSET(1, flow_id),
+					  (u32)(i_set >> 32));
+			hena |= BIT_ULL(flow_id);
+		}
 	}
 
 	i40e_write_rx_ctl(hw, I40E_PFQF_HENA(0), (u32)hena);
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
