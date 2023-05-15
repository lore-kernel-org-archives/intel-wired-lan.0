Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB75C7EE22
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 May 2023 15:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7536F41D2B;
	Mon, 15 May 2023 15:00:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7536F41D2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1684162849;
	bh=nX3Ayt1vHM0CPH/Pzq35iM7lytxZWTNaoszD2mUDX8o=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8QQUQgB1hkNi/rGfEIkm12NDmgv1hQ0QN8+uR+UaI4thw45Ymza1ID8ilJiOUeGAo
	 KCmQhpRJIhXGRL5I4moEb1PVsUh3cEc4cyBWHVbJK8b02NBPUyD/xMp4oHXvvVSkvB
	 Xn9v7wE96nsbG04DvEXu/6ZAPZEWAITN0n1bjJJn4W90ofof51aw91IEBRbxWzv/Ve
	 ucPcVOASqAoz4lTWsWfYon2gnYA71PaFLsgo2P4uLl38PYEHhPW5X7SP6xKyqDHlzI
	 Hr5sKvi55cb5D6BMgWkEMn9c0B5RMNhBXVPNOTeJxBvOAEAt+4lWcc17vpc5RMckdF
	 1PbbwwL8Kerbw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IYfsgjcEC3NL; Mon, 15 May 2023 15:00:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E63941D61;
	Mon, 15 May 2023 15:00:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E63941D61
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id B371E1BF575
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 May 2023 15:00:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97D0961567
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 May 2023 15:00:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97D0961567
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMYcXxjJYxP3 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 May 2023 15:00:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 406BB61571
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 406BB61571
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 May 2023 15:00:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="335763924"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; d="scan'208";a="335763924"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 08:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="1030929719"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; d="scan'208";a="1030929719"
Received: from pgardocx-hp-z6-g4-workstation.igk.intel.com (HELO
 pgardocx-mobl1.igk.intel.com) ([10.237.95.41])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 08:00:35 -0700
From: Piotr Gardocki <piotrx.gardocki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 15 May 2023 17:00:15 +0200
Message-Id: <20230515150015.239205-3-piotrx.gardocki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515150015.239205-1-piotrx.gardocki@intel.com>
References: <20230515150015.239205-1-piotrx.gardocki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684162839; x=1715698839;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vjx105bVa8qjgueWU8OMg2SW3yxv5VDylMRWmyoWSMM=;
 b=E0rp/+iNIQwbDAqT6ppIQd/PrLy+TfhRUDo2ZvzXZ29Pab0g3hBb3N8F
 eL7GEk0JQksrmwtTcUStGRh7RQu5bTBgbRz4FYkJazSVfReqwKFXq6UVa
 EvlV3WHPC1NJpgMfdGol7UZM+6w/39zZfBy5zmjNVggnmwX4WcUVeIY3g
 RnhH570G9J1lxNqFh5nyFWhWXFmPVkpF/2EOXkWbjBJfk/BUHtcDKAARj
 AYFZi3OMK5Z2IZuwD9GuUig/9GtuznotGV97mmkLSmZ+ZBoGVK8HWuTPC
 rdRq+Jo3nGdWZ5MMCzHM86yayM+at6z+ekuRSTi7DvDHt3kagIXuCEpyB
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=E0rp/+iN
Subject: [Intel-wired-lan] [PATCH iwl-next 2/2] iavf: fix err handling for
 MAC replace
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
Cc: przemyslaw.kitszel@intel.com
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
+	/* Always send the request to add if changing primary MAC
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
