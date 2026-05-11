Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC69CD484A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 14:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE7138137D;
	Mon, 11 May 2026 14:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D2alwtqXKv6t; Mon, 11 May 2026 14:07:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7752814C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778508462;
	bh=Iqttwhom+JmYRJxxYtp6HS+wZ+diq/V/HcCw9GotZKA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yuaEGN6pB/flYpo0QioNUn1xZ6UJG27qS4xIhUSTUpCdVgVxComz9PqHPHTluIILM
	 Xj4PrqDcS/KkdtbDfUGy4lFtidVNuOACk9BxkD+aahyroKo6OLTpWQbaFFErFs4LFL
	 VFT1950xfWhhGPYogEuuPQC6oTcWMm0ZMXPTvrtZt9YqpbpCrEE5wJ/+cJuVoRzaOW
	 htTZrbWKcmBv8utEaxeJD18wujgZwjAMgSjCbS4SsQN3wlvaHnQvFlbBl5HvV5SSaf
	 rLxVicyYjYEHqFXcuZU4exXvtR3XsRnKOjK35k9xzZSH3nbTiqosmT58bQMjqhgve/
	 MSHMy6M4JY/4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7752814C1;
	Mon, 11 May 2026 14:07:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36929272
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 14:07:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DDD69416BA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 14:07:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LKRFN8--irfx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 14:07:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=marcin.szycik@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DE3E5416C0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE3E5416C0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE3E5416C0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 14:07:38 +0000 (UTC)
X-CSE-ConnectionGUID: W/VDw+mlSCuqwCy+uQFakQ==
X-CSE-MsgGUID: w3S3Q6ISRXO416ttyNAtlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83265228"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="83265228"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 07:07:38 -0700
X-CSE-ConnectionGUID: VGk2W6EcRlmvf7PcELwVQw==
X-CSE-MsgGUID: v9QGHKJgQLK3nOCmeIaTKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="237685834"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa007.jf.intel.com with ESMTP; 11 May 2026 07:07:36 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id ACBE62FC47;
 Mon, 11 May 2026 15:07:35 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, sandeep.penigalapati@intel.com, ananth.s@intel.com,
 alexander.duyck@gmail.com, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Mon, 11 May 2026 15:07:08 +0200
Message-ID: <20260511130710.38801-10-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
References: <20260511130710.38801-1-marcin.szycik@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778508458; x=1810044458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sITYQjZ0WIGE3ESLmkp3SutNMCglo4JI24ljeE+NWH0=;
 b=WWtm7xvPkH9moGG2D03iwQG5EiaARhtrrIW6uQPG0vGpJCR7NDXMkJoy
 YefQay1OGKMH+1lZmWB+POKa+EzU7qAOL8nzSOgyb/M9y5a+n1k/NgouW
 LV3Th0PLDNRzOQw+NORSdEh8xHDpUO8j9tdykR4Z0KsJr6BPW78B9Lnbz
 6gYgnzUJ5UABrrMfupk74aDvfZqQuSzVQoX/0FlYifUglMynMX5RSrYOK
 SMe6JynDshMGheBoHTXv7GZcUG+/a+lnYNugxMPy0UjhncITmai3SPCsb
 l8bkZf+xHpqCHbpt3+W0TbhphuKJk23xBm4efuyI8CVSEvA4q/zuph4sg
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WWtm7xvP
Subject: [Intel-wired-lan] [PATCH iwl-next v3 09/10] ice: re-introduce
 ice_dealloc_flow_entry() helper
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

It was removed in commit ad667d626825 ("ice: remove null checks before
devm_kfree() calls"). Now it's useful again.

Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v3:
* ice_flow_acl_add_scen_entry_sync(), ice_flow_add_entry(): call
  ice_flow_acl_free_act_cntr() in unroll
v2:
* Add this patch
---
 drivers/net/ethernet/intel/ice/ice_flow.c | 61 +++++++++++++++--------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index df82cb36a58b..d3e8e7d1ec89 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -1589,6 +1589,23 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
 	return NULL;
 }
 
+/**
+ * ice_dealloc_flow_entry - Deallocate flow entry memory
+ * @hw: pointer to the HW struct
+ * @entry: flow entry to be removed
+ */
+static void
+ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
+{
+	if (!entry)
+		return;
+
+	kfree(entry->entry);
+	kfree(entry->range_buf);
+	kfree(entry->acts);
+	devm_kfree(ice_hw_to_dev(hw), entry);
+}
+
 /**
  * ice_flow_get_hw_prof - return the HW profile for a specific profile ID handle
  * @hw: pointer to the HW struct
@@ -1759,11 +1776,7 @@ static int ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block blk,
 	}
 
 	list_del(&entry->l_entry);
-
-	kfree(entry->entry);
-	kfree(entry->range_buf);
-	kfree(entry->acts);
-	devm_kfree(ice_hw_to_dev(hw), entry);
+	ice_dealloc_flow_entry(hw, entry);
 
 	return 0;
 }
@@ -2877,6 +2890,9 @@ static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
 			/* For the action memory info, update the SW's copy of
 			 * exist entry with e's action memory info
 			 */
+			if (exist->acts_cnt && exist->acts)
+				ice_flow_acl_free_act_cntr(hw, exist->acts,
+							   exist->acts_cnt);
 			kfree(exist->acts);
 			exist->acts = kzalloc_objs(*exist->acts, e->acts_cnt);
 			if (!exist->acts) {
@@ -2906,13 +2922,13 @@ static int ice_flow_acl_add_scen_entry_sync(struct ice_hw *hw,
 				goto out;
 		}
 
-		/* As we don't add the new entry to our SW DB, deallocate its
-		 * memories, and return the exist entry to the caller
+		/* As we don't add the new entry to our SW DB, free its HW
+		 * counter resources and deallocate its memory, then return
+		 * the exist entry to the caller
 		 */
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
+		if (e->acts_cnt && e->acts)
+			ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
+		ice_dealloc_flow_entry(hw, e);
 		*entry = exist;
 	}
 out:
@@ -2993,7 +3009,7 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 
 	mutex_unlock(&hw->fl_profs_locks[blk]);
 	if (status)
-		goto out;
+		goto dealloc_entry;
 
 	e->id = entry_id;
 	e->vsi_handle = vsi_handle;
@@ -3009,15 +3025,15 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 		status = ice_flow_acl_frmt_entry(hw, prof, e, (u8 *)data, acts,
 						 acts_cnt);
 		if (status)
-			goto out;
+			goto dealloc_entry;
 
 		status = ice_flow_acl_add_scen_entry(hw, prof, &e);
 		if (status)
-			goto out;
+			goto free_cntrs;
 		break;
 	default:
 		status = -EOPNOTSUPP;
-		goto out;
+		goto dealloc_entry;
 	}
 
 	if (blk != ICE_BLK_ACL) {
@@ -3029,13 +3045,14 @@ int ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
 
 	*entry_h = ICE_FLOW_ENTRY_HNDL(e);
 
-out:
-	if (status && e) {
-		kfree(e->entry);
-		kfree(e->range_buf);
-		kfree(e->acts);
-		devm_kfree(ice_hw_to_dev(hw), e);
-	}
+	return 0;
+
+free_cntrs:
+	if (blk == ICE_BLK_ACL && e->acts_cnt && e->acts)
+		ice_flow_acl_free_act_cntr(hw, e->acts, e->acts_cnt);
+dealloc_entry:
+	if (e)
+		ice_dealloc_flow_entry(hw, e);
 
 	return status;
 }
-- 
2.49.0

