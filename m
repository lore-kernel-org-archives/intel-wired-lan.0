Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF7FC77B75
	for <intel-wired-lan@archiver.kernel.org>; Fri, 19 May 2023 15:00:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BA4E42589;
	Fri, 19 May 2023 15:00:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6BA4E42589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684508455;
	bh=dLbct2j7Afa6MSVqCezmtca1S+r/vI0OeIBHyEqpcRE=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=leWvYmL96jdDubBhoiYNb3FJpFOVhVcFAQYNmxK3/rW8AYRQmCT7mQA/TPWy/N/xN
	 L+6NR+QYSbVrOdrxSZrBE8Qf0vEFZBI3+2mBXWpMg1BYORdyWLxxwVZCrC1O4BEEfF
	 OqeP8F/QXYvzc93s5zeYe0HHe4rDBFyKbGBxHgPxQ1dQRov573Hh9LjVJu80f31ZKq
	 sKSrMulf5ygpW52toDvSqBNLmZIutvxnCeDm6X1APlWE2WQwGD67vtNTEI7ed0BmiR
	 VOBCVpsSgVnPD5jcsRauo1qONmlX2Ydg9cfQfVtvsh80Dvy/q8LtBwT6g7Sig+oa3X
	 MKxDSlru2Br0Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 88NgQyIEDruw; Fri, 19 May 2023 15:00:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 229894257F;
	Fri, 19 May 2023 15:00:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 229894257F
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id EB1DE1BF3A1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 May 2023 15:00:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C437C611DF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 May 2023 15:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C437C611DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Og1baHjn1Hw for <intel-wired-lan@lists.osuosl.org>;
 Fri, 19 May 2023 15:00:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14DAD60BEE
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 14DAD60BEE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 19 May 2023 15:00:46 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="418087157"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; d="scan'208";a="418087157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 08:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="792397454"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; d="scan'208";a="792397454"
Received: from pgardocx-hp-z6-g4-workstation.igk.intel.com (HELO
 pgardocx-mobl1.igk.intel.com) ([10.237.95.41])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 08:00:43 -0700
From: Piotr Gardocki <piotrx.gardocki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 19 May 2023 17:00:29 +0200
Message-Id: <20230519150029.370332-3-piotrx.gardocki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519150029.370332-1-piotrx.gardocki@intel.com>
References: <20230519150029.370332-1-piotrx.gardocki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684508446; x=1716044446;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HIMpICse2VNHuIzBD341lOC4xDdBwBXXE7eCBN8WofQ=;
 b=e10x95ugG2k3mJItvpoN8XQwS7OADvObTofihjBI79/yyarr6J3a/8kv
 MdPBmSK5jWafkDlaL3yV5cml6uFlA2lUgZI+LqRiWH+sYDoNHLKS2PiNM
 HlVTdJJYMrcDGz6GRqyyQdHosrRZ1Zi85w3e22rt79CEGNEgv5IpVC1ma
 alfhdD1Sv4Yq6SN3xjDpwJAa0te6UOaq4kALTOtL6rVxA880/qLBeZ6PD
 xz9r9HJbTvdX59JDAVoslncxea1Zn+b9u/G+D5e1xNQqsDYrbuCrahSXb
 LqbLm3B8Hsxm+SMZa70Jo4w92FE5H0LydmBcXibfilRW11a2FjT5zAQW/
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e10x95ug
Subject: [Intel-wired-lan] [PATCH iwl-next v4 2/2] iavf: fix err handling
 for MAC replace
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
Cc: przemyslaw.kitszel@intel.com, pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Defer removal of current primary MAC until a replacement is successfully added.
Previous implementation would left filter list with no primary MAC.
This was found while reading the code.

The patch takes advantage of the fact that there can only be a single primary
MAC filter at any time.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 42 ++++++++++-----------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 888d063478a1..68aa680f7fec 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1007,40 +1007,36 @@ int iavf_replace_primary_mac(struct iavf_adapter *adapter,
 			     const u8 *new_mac)
 {
 	struct iavf_hw *hw = &adapter->hw;
-	struct iavf_mac_filter *f;
+	struct iavf_mac_filter *new_f;
+	struct iavf_mac_filter *old_f;
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
-	list_for_each_entry(f, &adapter->mac_filter_list, list) {
-		f->is_primary = false;
+	new_f = iavf_add_filter(adapter, new_mac);
+	if (!new_f) {
+		spin_unlock_bh(&adapter->mac_vlan_list_lock);
+		return -ENOMEM;
 	}
 
-	f = iavf_find_filter(adapter, hw->mac.addr);
-	if (f) {
-		f->remove = true;
+	old_f = iavf_find_filter(adapter, hw->mac.addr);
+	if (old_f) {
+		old_f->is_primary = false;
+		old_f->remove = true;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_MAC_FILTER;
 	}
-
-	f = iavf_add_filter(adapter, new_mac);
-
-	if (f) {
-		/* Always send the request to add if changing primary MAC
-		 * even if filter is already present on the list
-		 */
-		f->is_primary = true;
-		f->add = true;
-		adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
-		ether_addr_copy(hw->mac.addr, new_mac);
-	}
+	/* Always send the request to add if changing primary MAC,
+	 * even if filter is already present on the list
+	 */
+	new_f->is_primary = true;
+	new_f->add = true;
+	adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
+	ether_addr_copy(hw->mac.addr, new_mac);
 
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
 
 	/* schedule the watchdog task to immediately process the request */
-	if (f) {
-		mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
-		return 0;
-	}
-	return -ENOMEM;
+	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
+	return 0;
 }
 
 /**
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
