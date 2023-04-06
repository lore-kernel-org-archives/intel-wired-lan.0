Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D24C76196
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Apr 2023 21:36:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A257B844B2;
	Thu,  6 Apr 2023 21:36:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A257B844B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1680816962;
	bh=ATjdcuAdVsdg2NORVm8tJUykmXe0RUR7f9FXqV/Z014=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ug2kgOnGpIbYJv3v6UfOnHH/6CNV72uzjCt1mgkdUVptKiMwmV4eL7Vtn9QI6VifJ
	 AHqMPmEurHgZyNPGIyXcGq9HnRpbGVkgwLkBNmowAe7nt88QTmAxIN888k4GVzMMM6
	 c1JZeHt8Mbz4TmxBUU15cWolFyZZeQ/9ir7gGQQUin5ZnpxFef22DJf+m9O3xcbC5C
	 0yZ+NePqeC3JzxvmHOGSZ059wCgGY5IKlBbNn0ymbCrnt+ZcKrIqn6pyZ676+YwufD
	 KIE02jUT6ANPBL3KId0712OudTgss7i1P/j+2dVOKwZwnWbss7SHFVnpvnHJKBFBzG
	 36cpbEavdpUqA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NEF7eOuKAWUy; Thu,  6 Apr 2023 21:36:01 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 653B2844B0;
	Thu,  6 Apr 2023 21:36:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 653B2844B0
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 397211BF354
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Apr 2023 21:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D0FF41E8D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Apr 2023 21:35:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0D0FF41E8D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1TcjXWg-YoUM for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Apr 2023 21:35:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A17F841F5C
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A17F841F5C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Apr 2023 21:35:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="322496103"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; d="scan'208";a="322496103"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 14:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="756476380"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; d="scan'208";a="756476380"
Received: from unisar-mobl.ger.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.252.43.240])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2023 14:35:41 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  6 Apr 2023 15:35:27 -0600
Message-Id: <20230406213528.266368-2-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230406213528.266368-1-ahmed.zaki@intel.com>
References: <20230406213528.266368-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680816950; x=1712352950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gp6AjAHGamGarn02eW476WEd7OjhsSBeZJ1Xtm9ljEc=;
 b=m45LQGFCSFfs0y/sJPXbd6JrFyh9Z1rAyf6nDsfeUcgXdpB6gPtb7zTM
 F4x81Hwa/unkh88J33UcG//Fp/TCAJ5co1ofoUM9+XT+dydfLIU0U8bEY
 suSkpxnJUaWsWy1EFGMNPKEN29VgUub+mIBnrJSKsT+ONWAozxHoa8+ok
 B04TdiNGDegFHGFhnlFilaatlsbI+m1r5JSFztZ4iRAkYbIWwy+GvKrS9
 0as9k55TCDt+tnz+y/FwAn5CZtd7J0uHNJ+wqcRpqI70kxwdVPGBNAd81
 OMePLLGChrTT+TFrexssOALCO02V25fCeI+pEZAclEcv8Qt9s+2G0fsoh
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=m45LQGFC
Subject: [Intel-wired-lan] [PATCH net v2 1/2] iavf: refactor VLAN filter
 states
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The VLAN filter states are currently being saved as individual bits.
This is error prone as multiple bits might be mistakenly set.

Fix by replacing the bits with a single state enum. Also, add an
"ACTIVE" state for filters that are accepted by the PF.

Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h        | 15 +++++----
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 ++---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 31 +++++++++----------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 2cdce251472c..baf6dd8dc93d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -157,15 +157,18 @@ struct iavf_vlan {
 	u16 tpid;
 };
 
+enum iavf_vlan_state_t {
+	IAVF_VLAN_INVALID,
+	IAVF_VLAN_ADD,		/* filter needs to be added */
+	IAVF_VLAN_IS_NEW,	/* filter is new, wait for PF answer */
+	IAVF_VLAN_ACTIVE,	/* filter is accepted by PF */
+	IAVF_VLAN_REMOVE,	/* filter needs to be removed */
+};
+
 struct iavf_vlan_filter {
 	struct list_head list;
 	struct iavf_vlan vlan;
-	struct {
-		u8 is_new_vlan:1;	/* filter is new, wait for PF answer */
-		u8 remove:1;		/* filter needs to be removed */
-		u8 add:1;		/* filter needs to be added */
-		u8 padding:5;
-	};
+	enum iavf_vlan_state_t state;
 };
 
 #define IAVF_MAX_TRAFFIC_CLASS	4
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 095201e83c9d..fe9798e4b4ac 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -791,7 +791,7 @@ iavf_vlan_filter *iavf_add_vlan(struct iavf_adapter *adapter,
 		f->vlan = vlan;
 
 		list_add_tail(&f->list, &adapter->vlan_filter_list);
-		f->add = true;
+		f->state = IAVF_VLAN_ADD;
 		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
 	}
 
@@ -813,7 +813,7 @@ static void iavf_del_vlan(struct iavf_adapter *adapter, struct iavf_vlan vlan)
 
 	f = iavf_find_vlan(adapter, vlan);
 	if (f) {
-		f->remove = true;
+		f->state = IAVF_VLAN_REMOVE;
 		adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
 	}
 
@@ -1296,11 +1296,11 @@ static void iavf_clear_mac_vlan_filters(struct iavf_adapter *adapter)
 	/* remove all VLAN filters */
 	list_for_each_entry_safe(vlf, vlftmp, &adapter->vlan_filter_list,
 				 list) {
-		if (vlf->add) {
+		if (vlf->state == IAVF_VLAN_ADD) {
 			list_del(&vlf->list);
 			kfree(vlf);
 		} else {
-			vlf->remove = true;
+			vlf->state = IAVF_VLAN_REMOVE;
 		}
 	}
 	spin_unlock_bh(&adapter->mac_vlan_list_lock);
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 4e17d006c52d..5047b4c83718 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -642,7 +642,7 @@ static void iavf_vlan_add_reject(struct iavf_adapter *adapter)
 
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-		if (f->is_new_vlan) {
+		if (f->state == IAVF_VLAN_IS_NEW) {
 			if (f->vlan.tpid == ETH_P_8021Q)
 				clear_bit(f->vlan.vid,
 					  adapter->vsi.active_cvlans);
@@ -679,7 +679,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 
 	list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-		if (f->add)
+		if (f->state == IAVF_VLAN_ADD)
 			count++;
 	}
 	if (!count || !VLAN_FILTERING_ALLOWED(adapter)) {
@@ -710,11 +710,10 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 		vvfl->vsi_id = adapter->vsi_res->vsi_id;
 		vvfl->num_elements = count;
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-			if (f->add) {
+			if (f->state == IAVF_VLAN_ADD) {
 				vvfl->vlan_id[i] = f->vlan.vid;
 				i++;
-				f->add = false;
-				f->is_new_vlan = true;
+				f->state = IAVF_VLAN_IS_NEW;
 				if (i == count)
 					break;
 			}
@@ -760,7 +759,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 		vvfl_v2->vport_id = adapter->vsi_res->vsi_id;
 		vvfl_v2->num_elements = count;
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-			if (f->add) {
+			if (f->state == IAVF_VLAN_ADD) {
 				struct virtchnl_vlan_supported_caps *filtering_support =
 					&adapter->vlan_v2_caps.filtering.filtering_support;
 				struct virtchnl_vlan *vlan;
@@ -778,8 +777,7 @@ void iavf_add_vlans(struct iavf_adapter *adapter)
 				vlan->tpid = f->vlan.tpid;
 
 				i++;
-				f->add = false;
-				f->is_new_vlan = true;
+				f->state = IAVF_VLAN_IS_NEW;
 			}
 		}
 
@@ -822,10 +820,11 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 		 * filters marked for removal to enable bailing out before
 		 * sending a virtchnl message
 		 */
-		if (f->remove && !VLAN_FILTERING_ALLOWED(adapter)) {
+		if (f->state == IAVF_VLAN_REMOVE &&
+		    !VLAN_FILTERING_ALLOWED(adapter)) {
 			list_del(&f->list);
 			kfree(f);
-		} else if (f->remove) {
+		} else if (f->state == IAVF_VLAN_REMOVE) {
 			count++;
 		}
 	}
@@ -857,7 +856,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 		vvfl->vsi_id = adapter->vsi_res->vsi_id;
 		vvfl->num_elements = count;
 		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-			if (f->remove) {
+			if (f->state == IAVF_VLAN_REMOVE) {
 				vvfl->vlan_id[i] = f->vlan.vid;
 				i++;
 				list_del(&f->list);
@@ -901,7 +900,7 @@ void iavf_del_vlans(struct iavf_adapter *adapter)
 		vvfl_v2->vport_id = adapter->vsi_res->vsi_id;
 		vvfl_v2->num_elements = count;
 		list_for_each_entry_safe(f, ftmp, &adapter->vlan_filter_list, list) {
-			if (f->remove) {
+			if (f->state == IAVF_VLAN_REMOVE) {
 				struct virtchnl_vlan_supported_caps *filtering_support =
 					&adapter->vlan_v2_caps.filtering.filtering_support;
 				struct virtchnl_vlan *vlan;
@@ -2192,7 +2191,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 				list_for_each_entry(vlf,
 						    &adapter->vlan_filter_list,
 						    list)
-					vlf->add = true;
+					vlf->state = IAVF_VLAN_ADD;
 
 				adapter->aq_required |=
 					IAVF_FLAG_AQ_ADD_VLAN_FILTER;
@@ -2260,7 +2259,7 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 				list_for_each_entry(vlf,
 						    &adapter->vlan_filter_list,
 						    list)
-					vlf->add = true;
+					vlf->state = IAVF_VLAN_ADD;
 
 				aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
 			}
@@ -2444,8 +2443,8 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
 
 		spin_lock_bh(&adapter->mac_vlan_list_lock);
 		list_for_each_entry(f, &adapter->vlan_filter_list, list) {
-			if (f->is_new_vlan) {
-				f->is_new_vlan = false;
+			if (f->state == IAVF_VLAN_IS_NEW) {
+				f->state = IAVF_VLAN_ACTIVE;
 				if (f->vlan.tpid == ETH_P_8021Q)
 					set_bit(f->vlan.vid,
 						adapter->vsi.active_cvlans);
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
