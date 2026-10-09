Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5545FCA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23042608C2;
	Fri,  9 Oct 2026 20:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WJPkktz1DgPI; Fri,  9 Oct 2026 20:12:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5BFCC608B4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576771;
	b=kKNQC8PnELVz5+9mROriT+noy1OG0Q1wDIFQZ+d7vyTww0a8sX/nuAtRxPyntSVLWgMk
	 OlqEGdop5yiUHJ+qj1lM6rq6KboqGRxuSz2PGr7p4JYCvS15Y2CRtL4jYBbUWH25vp1ZR
	 VmzQ7JukLmo0SjmzHK6ts+1aYrllt3pYjb70Qdn/IFokuK2FvuHeUEWom0eyNKftTMgAq
	 U/TiJhZbTWvbGjHOR7iSAln9mqsGGY/CTevuW6Vr2CJX4zgf6fqfPaJxQBBerLtTIG2Ou
	 FiQEejG/bIC5Hg54OWhTCh1+6ZaPSEuRBueMadYsixklfmLDoHM3EMdFZTeybzFo38A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576771;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fKDoYJUc0gaHVjrqf9xqrXUY6nHzkQKn427mQXFJjg8=;
	b=WoG0xObrH+WvRW3NjZYX2SisEl/4yGBcjbYbTYlnkMpsPjy2wweyOP607JqWA7b0yS6l
	 6SUv1vPuooACBzBeUM0UENqrTrZ2B1iwf1YPU9la+nmbdcyo0UrdgDkTS8eLdBhX58zhz
	 pt9oRj9NpU/l+9v/9iXwmePtn74L48MUcLrk2mIfDZyyQEuxY3eDs11234Nir1wrCN5k3
	 BZVXenNetSbeA5RynCPld0ioQhdNyP4Cll3jrk7qwwkpzAig2phwKmcmAXs0HvdB7r2Ws
	 lXYzgwYOMydW0lYk/FvUn4Cm3l1a0AW+iK0xMuZOXiDyFT3UFpT47Ejyj6QQxsHamKA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576771;
	bh=fKDoYJUc0gaHVjrqf9xqrXUY6nHzkQKn427mQXFJjg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ErzCVuvAFkzxR0pkLQBzVBEEP3JQtgoSDNmIkKMZ/8pSaM2RIa9UkBYvR9ysGup5/
	 mlb5+UJXXmVaLG+KQu8yQw8vf+iE8MBjkBTQh/TWH/wV6EKL1wSh2P3UhhxuqaWc8+
	 MjFvDiicgTzc1c5lGODOqEgdbGkUldGxjfteUA42NTmtA+oOcgippSNrILJPWbJ37W
	 HqJk280H+TRtk5cFq000EXhR1T4Qd0YWyJeEw03SlBXydz8ET0x9Juenr58FeD4wUL
	 7x00Vn4jLdAIoW2vi0+kDtTVwpx+1B7mVYGzOoMRES94euvLMsWvERsr2iM+Mzo8/l
	 I6M6y5O82wAgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BFCC608B4;
	Fri,  9 Oct 2026 20:12:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id AB776380
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D3DD80FFF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NWKanxzwiCIw for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA5C580FB1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576766;
 b=EvJzPObkK18Sz/qGNyClLTxSj4Db2CbZUrqXXAKuKyswuSkL88s1MtqUopimLfqqPNH+
 /z5IzemW+DhGPoxHXZGRtxP2+VBUhRpzGlMdHrLnpY4z8wuzzSX4utvYiY25M5QmLg9mc
 H1fXvX8xbDstfPA5tL31XjkB950BQmfjyMouf6H6elaiCIFs9xsRQmSqTIGNeU7zsSXYR
 7euay+gIsVaZj4kBmlcTqUXqySQh9eo/YQ1kfpq9ANsxvg+QPbk50AG/1MbfFagvWeMOl
 G+GFAQSiYHY2WTRx0K5wicHWAf1Nko5WlAQLSgIZvXlyEhDuEl/Jq3joBrWoNcfMz8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576766;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=fKDoYJUc0gaHVjrqf9xqrXUY6nHzkQKn427mQXFJjg8=;
 b=HdNA0SwL2KDRml5hN29XvPVqIpDJQYoZhfPgF4zfluqu+AjDq0u8bWMug+9qLrvZcs/y
 2dnd3Fk75zDTd3O7FzYzYdoyztoWaVWOXF3lXC+F9yjjgm8auQXSZqauLNa0bjtnimW1N
 oeCm5ZhtFV7RFC9z9vCqf3go0CJcrJ+92rUxQeMP/QAcOJU/dYEmA98amqKmbKYQBIq7v
 En4yuRrr7OSj4ZD2k0MCNThOWxS66Kg5DAGZ4zdUKXOx74VBraYWc7pi3VabVHu3ZT6el
 UcOBDjwp7XNCvIViK40Gr1guy5SS5iLF7fdsEUv6O+s2+L19N39fR9kY7WTvtiTT0EA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YV5eDH3S; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YV5eDH3S
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA5C580FB1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576767; x=1823112767;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=QjuOEwIAPZcwDQXH5mr8WuaAk1m9JdNhy8Rpix13KRE=;
 b=YV5eDH3SDhiwKFDhRSS2xRpkDQ+AbzBNhqQBLyOe+/JPKERlt0BCjauo
 t4q7Ja5yQXHhkaLsVKcvYpfNW3wqe2+OTybr7+VKQbjdM/JyHC5MRmWj6
 15INZmft1uPRIyfhyZCk3llDbCvk7bAbbeIrqrE9ZG1SvuTPmwybZ/xK7
 bd3HSEOyFqmWI3v12/7ZGuP3TJH5iTJwoQhKGDQb4zf351YC90ZjWliO9
 sRIHS6QQsfROnUn8vO5QGCOf/r+onTrQDs0nPzTYH8xxP8qN4a3KBYBcm
 9v2hadHrbHNC1AijnVABPdVJ7rdb8SX6CMTIgmau7C1RcoMrlD9+ZaJcx g==;
X-CSE-ConnectionGUID: ZV2SEKm+S8CMJXz4AliZ9g==
X-CSE-MsgGUID: FgfVZQ+FRY+TkBUsoZw4wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261910"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261910"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:45 -0700
X-CSE-ConnectionGUID: SbqEJGXgSqiQ6lVa5Y6faQ==
X-CSE-MsgGUID: vxb/acj4TgWcgw0HDL9Dcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189800"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 09 Oct 2026 13:11:19 -0700
Subject: [PATCH iwl-next v2 3/6] ice: extract aggregator allocation out of
 ice_sched_cfg_agg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-3-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=8319;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QjuOEwIAPZcwDQXH5mr8WuaAk1m9JdNhy8Rpix13KRE=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXlvtJzjzWH+rLt8j9M4hu2NhHu/229ZPr8/7//Luj
 +1BpTP5OkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjI6nsMf/jmfyoybdJSO39u
 W/WUY8KHDwZEp53bU3XMdu3L//XibjMZGdYvC3aIkZrLnfHGvSBv3aSN1prqZjzZKbz66Y3VNxs
 XcAIA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

The ice_sched_cfg_agg() function currently takes an aggregator id and type.
It performs a lookup of the aggregator info structure by ID. If the lookup
fails, it then tries to allocate a new structure at that ID.

The only caller that currently takes advantage of the allocation behavior
is ice_cfg_agg(). The other callers are part of a replay loop which iterate
the set of nodes and thus always have a valid node at the given ID.

A future refactor is going to change how aggregator nodes get allocated and
better integrating logic from outside ice_sched.c

As a first step, refactor the allocation to a separate function,
ice_alloc_agg_info(). To prepare for the following changes, this function
takes both a minimum and maximum range and uses xa_alloc() to allow
selecting the ID from the xarray.

Refactor ice_sched_cfg_agg() to take a pointer to the agg_info. Move the
allocation out to ice_cfg_agg(). All other callers of ice_sched_cfg_agg()
now just pass their agg_info pointer instead of agg_info->agg_id,
simplifying the behavior and removing error paths that are effectively dead
code.

Suggested-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_sched.c  | 125 ++++++++++++++++------------
 2 files changed, 74 insertions(+), 53 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 16f20b0feb02..b0958a11b0c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1052,7 +1052,7 @@ int ice_init_hw(struct ice_hw *hw)
 	hw->evb_veb = true;
 
 	xa_init_flags(&hw->sched_node_ids, XA_FLAGS_ALLOC);
-	xa_init(&hw->agg_nodes);
+	xa_init_flags(&hw->agg_nodes, XA_FLAGS_ALLOC);
 
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 08d0f685f6c4..27971cb135fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2694,61 +2694,78 @@ ice_sched_add_agg_cfg(struct ice_port_info *pi, u32 agg_id, u8 tc)
 }
 
 /**
- * ice_sched_cfg_agg - configure aggregator node
- * @pi: port information structure
- * @agg_id: aggregator ID
- * @agg_type: aggregator type queue, VSI, or aggregator group
- * @tc_bitmap: bits TC bitmap
+ * ice_alloc_agg_info - Allocate aggregator info structure
+ * @hw: pointer to the HW structure
+ * @min_id: the minimum ID to allocate
+ * @max_id: the maximum ID to allocate
+ * @agg_type: the aggregator node type
  *
- * It registers a unique aggregator node into scheduler services. It
- * allows a user to register with a unique ID to track it's resources.
- * The aggregator type determines if this is a queue group, VSI group
- * or aggregator group. It then creates the aggregator node(s) for requested
- * TC(s) or removes an existing aggregator node including its configuration
- * if indicated via tc_bitmap. Call ice_rm_agg_cfg to release aggregator
- * resources and remove aggregator ID.
- * This function needs to be called with scheduler lock held.
+ * Allocates a new aggregator info structure with an ID between min_id and
+ * max_id, inserting it into the agg_nodes xarray. If an exact ID is required,
+ * use the same value for both min_id and max_id.
+ *
+ * Context: Must be called while holding the scheduler lock.
+ *
+ * Return: the allocated aggregator info structure pointer, or an ERR_PTR on
+ * failure.
  */
-static int
-ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
-		  enum ice_agg_type agg_type, unsigned long *tc_bitmap)
+static struct ice_sched_agg_info *
+ice_alloc_agg_info(struct ice_hw *hw, u32 min_id, u32 max_id,
+		   enum ice_agg_type agg_type)
 {
 	struct ice_sched_agg_info *agg_info;
-	struct ice_hw *hw = pi->hw;
-	int status = 0;
+	u32 agg_id;
+	int status;
+
+	/* Create new entry for new aggregator ID */
+	agg_info = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*agg_info),
+				GFP_KERNEL);
+	if (!agg_info)
+		return ERR_PTR(-ENOMEM);
+
+	agg_info->agg_type = agg_type;
+	agg_info->tc_bitmap[0] = 0;
+
+	/* Initialize the aggregator VSI list head */
+	INIT_LIST_HEAD(&agg_info->agg_vsi_list);
+	agg_info->num_vsis = 0;
+
+	status = xa_alloc(&hw->agg_nodes, &agg_id, agg_info,
+			  XA_LIMIT(min_id, max_id), GFP_KERNEL);
+	if (status) {
+		devm_kfree(ice_hw_to_dev(hw), agg_info);
+		return ERR_PTR(status);
+	}
+	agg_info->agg_id = agg_id;
+
+	return agg_info;
+}
+
+/**
+ * ice_sched_cfg_agg - configure aggregator node
+ * @pi: port information structure
+ * @agg_info: pointer to aggregator node to configure
+ * @tc_bitmap: bits TC bitmap
+ *
+ * Configure an aggregator node's traffic classes according to the provided
+ * tc_bitmap.
+ *
+ * Context: Must be called with scheduler lock held.
+ */
+static int ice_sched_cfg_agg(struct ice_port_info *pi,
+			     struct ice_sched_agg_info *agg_info,
+			     unsigned long *tc_bitmap)
+{
+	int status;
 	u8 tc;
 
-	agg_info = xa_load(&hw->agg_nodes, agg_id);
-	if (!agg_info) {
-		/* Create new entry for new aggregator ID */
-		agg_info = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*agg_info),
-					GFP_KERNEL);
-		if (!agg_info)
-			return -ENOMEM;
-
-		agg_info->agg_id = agg_id;
-		agg_info->agg_type = agg_type;
-		agg_info->tc_bitmap[0] = 0;
-
-		/* Initialize the aggregator VSI list head */
-		INIT_LIST_HEAD(&agg_info->agg_vsi_list);
-		agg_info->num_vsis = 0;
-
-		/* Add new entry in aggregator array */
-		status = xa_insert(&hw->agg_nodes, agg_id, agg_info,
-				   GFP_KERNEL);
-		if (status) {
-			devm_kfree(ice_hw_to_dev(hw), agg_info);
-			return status;
-		}
-	}
 	/* Create aggregator node(s) for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
 		if (!ice_is_tc_ena(*tc_bitmap, tc)) {
 			/* Delete aggregator cfg TC if it exists previously */
 			status = ice_rm_agg_cfg_tc(pi, agg_info, tc, false);
 			if (status)
-				break;
+				return status;
 			continue;
 		}
 
@@ -2757,15 +2774,15 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 			continue;
 
 		/* Create new aggregator node for TC */
-		status = ice_sched_add_agg_cfg(pi, agg_id, tc);
+		status = ice_sched_add_agg_cfg(pi, agg_info->agg_id, tc);
 		if (status)
-			break;
+			return status;
 
 		/* Save aggregator node's TC information */
 		set_bit(tc, agg_info->tc_bitmap);
 	}
 
-	return status;
+	return 0;
 }
 
 /**
@@ -2781,11 +2798,18 @@ int
 ice_cfg_agg(struct ice_port_info *pi, u32 agg_id, enum ice_agg_type agg_type,
 	    u8 tc_bitmap)
 {
+	struct ice_sched_agg_info *agg_info;
 	unsigned long bitmap = tc_bitmap;
+	struct ice_hw *hw = pi->hw;
 	int status;
 
 	mutex_lock(&pi->sched_lock);
-	status = ice_sched_cfg_agg(pi, agg_id, agg_type, &bitmap);
+	agg_info = xa_load(&hw->agg_nodes, agg_id);
+	if (!agg_info)
+		agg_info = ice_alloc_agg_info(hw, agg_id, agg_id, agg_type);
+	if (IS_ERR(agg_info))
+		return PTR_ERR(agg_info);
+	status = ice_sched_cfg_agg(pi, agg_info, &bitmap);
 	if (!status)
 		status = ice_save_agg_tc_bitmap(pi, agg_id, &bitmap);
 	mutex_unlock(&pi->sched_lock);
@@ -4321,9 +4345,7 @@ void ice_sched_replay_agg(struct ice_hw *hw)
 						    agg_info->replay_tc_bitmap,
 						    replay_bitmap);
 			status = ice_sched_cfg_agg(hw->port_info,
-						   agg_info->agg_id,
-						   ICE_AGG_TYPE_AGG,
-						   replay_bitmap);
+						   agg_info, replay_bitmap);
 			if (status) {
 				dev_info(ice_hw_to_dev(hw),
 					 "Replay agg id[%d] failed\n",
@@ -4390,8 +4412,7 @@ static int ice_sched_replay_vsi_agg(struct ice_hw *hw, u16 vsi_handle)
 	ice_sched_get_ena_tc_bitmap(pi, agg_info->replay_tc_bitmap,
 				    replay_bitmap);
 	/* Replay aggregator node associated to vsi_handle */
-	status = ice_sched_cfg_agg(hw->port_info, agg_info->agg_id,
-				   ICE_AGG_TYPE_AGG, replay_bitmap);
+	status = ice_sched_cfg_agg(hw->port_info, agg_info, replay_bitmap);
 	if (status)
 		return status;
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

