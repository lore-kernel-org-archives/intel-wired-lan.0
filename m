Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81B3EE14DC
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Sep 2023 10:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D16360A7B;
	Thu,  7 Sep 2023 10:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D16360A7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694080885;
	bh=sAs8TCLA4UWxotOk+HxtZB/UExusgEQQtqun91PVzkw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Sq9dE/2mVx+4Zslm0TPAxKKBq6HfHawSJm/TI3NRqTkGFQGN7D6z1AAF6zngobOB0
	 s/dEMOCmUtvTxl0V5ci98hx2hSjHdzSV4HV0W59KRhoZnvwwadmjJNr1cksjjEfy25
	 VfKsZFFvoSIArRVy4VIQEQxm5k7KMq+bEJXli16NNRueZKLbdqk+fNP6usNz+EHCi5
	 K9lQGiVckMO9/DT+6uqtPbvNM0wngAz8xO8ZI1rpHXY7qyCJnXiYDdmaci2fLGTK4a
	 whbx6GHonocyq3trKV465nQxib7r1KviM7E65KrJQ4pn9N8w4L8hPujeFeagr996AR
	 s2htoe7zNwaRg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pU_bv3V36LyW; Thu,  7 Sep 2023 10:01:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2452560BF7;
	Thu,  7 Sep 2023 10:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2452560BF7
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 4570C1BF403
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 10:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2964B41C01
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 10:01:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2964B41C01
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NMFdJArqXB21 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Sep 2023 10:01:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBF7E41BE6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 10:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBF7E41BE6
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="374704808"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; d="scan'208";a="374704808"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2023 03:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="807482295"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; d="scan'208";a="807482295"
Received: from gklab-018-208.igk.intel.com ([10.102.18.208])
 by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2023 03:01:17 -0700
From: Kamil Maziarz <kamil.maziarz@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  7 Sep 2023 12:00:49 +0200
Message-Id: <20230907100049.138959-1-kamil.maziarz@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694080879; x=1725616879;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=S4klRiSyzx4DzFMCkpFxZXDbD/nuR00roO8l6e5iVGQ=;
 b=HVQgkcA6AM5JlqpBJP6P4PlY0XoL+oeSRIzke1zF2Tk+mb+rvw41eltn
 gbjtEz5uRKXzkdEeVSH4oI3hfHG5zdVxbDTom5/ZKSEV6MY9bhUoUJGB4
 qFOKbZHFczjYwvhGJgdg0HfcVllbyMpPDR2OTsoK2Mq82XqZ25hFbpXn2
 dUD5qOOTM79eCQJXj8eFDB3bWnq7kl7HmFqKbzw+pnREBeI7iApKwvHPV
 biwoUNS4YwtGtjTzKUc0uRFaETVFRFymuHwhIE1H8Qspox9A4M8fKNA4V
 QJW47hKrpNSwhFQmJbNTrLsTybtY/DTxaGRAXBTCkhZGTQEm1H8EXobbg
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HVQgkcA6
Subject: [Intel-wired-lan] [PATCH iwl-next v1] i40e: Refactor parameters
 name in i40e_print_input_set
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
Cc: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>,
 Kamil Maziarz <kamil.maziarz@intel.com>,
 Antoni Czarnecki <antonix.czarnecki@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Grzegorz Szczurek <grzegorzx.szczurek@intel.com

Change function parameter old/new in i40e_print_input_set.
This change improves readability.

Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
Co-developed-by: Antoni Czarnecki <antonix.czarnecki@intel.com>
Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 35 ++++++++++---------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index bd1321bf7e26..c86ad944b59d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4190,49 +4190,50 @@ static u64 i40e_pit_index_to_mask(int pit_index)
 /**
  * i40e_print_input_set - Show changes between two input sets
  * @vsi: the vsi being configured
- * @old: the old input set
- * @new: the new input set
+ * @old_input: the old input set
+ * @new_input: the new input set
  *
  * Print the difference between old and new input sets by showing which series
  * of words are toggled on or off. Only displays the bits we actually support
  * changing.
  **/
-static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old, u64 new)
+static void i40e_print_input_set(struct i40e_vsi *vsi,
+				 u64 old_input, u64 new_input)
 {
 	struct i40e_pf *pf = vsi->back;
 	bool old_value, new_value;
 	int i;
 
-	old_value = !!(old & I40E_L3_SRC_MASK);
-	new_value = !!(new & I40E_L3_SRC_MASK);
+	old_value = !!(old_input & I40E_L3_SRC_MASK);
+	new_value = !!(new_input & I40E_L3_SRC_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L3 source address: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_L3_DST_MASK);
-	new_value = !!(new & I40E_L3_DST_MASK);
+	old_value = !!(old_input & I40E_L3_DST_MASK);
+	new_value = !!(new_input & I40E_L3_DST_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L3 destination address: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_L4_SRC_MASK);
-	new_value = !!(new & I40E_L4_SRC_MASK);
+	old_value = !!(old_input & I40E_L4_SRC_MASK);
+	new_value = !!(new_input & I40E_L4_SRC_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L4 source port: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_L4_DST_MASK);
-	new_value = !!(new & I40E_L4_DST_MASK);
+	old_value = !!(old_input & I40E_L4_DST_MASK);
+	new_value = !!(new_input & I40E_L4_DST_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "L4 destination port: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
 			   new_value ? "ON" : "OFF");
 
-	old_value = !!(old & I40E_VERIFY_TAG_MASK);
-	new_value = !!(new & I40E_VERIFY_TAG_MASK);
+	old_value = !!(old_input & I40E_VERIFY_TAG_MASK);
+	new_value = !!(new_input & I40E_VERIFY_TAG_MASK);
 	if (old_value != new_value)
 		netif_info(pf, drv, vsi->netdev, "SCTP verification tag: %s -> %s\n",
 			   old_value ? "ON" : "OFF",
@@ -4242,8 +4243,8 @@ static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old, u64 new)
 	for (i = 0; i < I40E_FLEX_INDEX_ENTRIES; i++) {
 		u64 flex_mask = i40e_pit_index_to_mask(i);
 
-		old_value = !!(old & flex_mask);
-		new_value = !!(new & flex_mask);
+		old_value = !!(old_input & flex_mask);
+		new_value = !!(new_input & flex_mask);
 		if (old_value != new_value)
 			netif_info(pf, drv, vsi->netdev, "FLEX index %d: %s -> %s\n",
 				   i,
@@ -4252,9 +4253,9 @@ static void i40e_print_input_set(struct i40e_vsi *vsi, u64 old, u64 new)
 	}
 
 	netif_info(pf, drv, vsi->netdev, "  Current input set: %0llx\n",
-		   old);
+		   old_input);
 	netif_info(pf, drv, vsi->netdev, "Requested input set: %0llx\n",
-		   new);
+		   new_input);
 }
 
 /**
-- 
2.39.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
