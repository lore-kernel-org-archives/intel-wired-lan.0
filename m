Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2B4CA9EC1
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C10A608B4;
	Fri,  9 Oct 2026 20:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eOIrx_INVor5; Fri,  9 Oct 2026 20:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 20D2F608C4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576774;
	b=k2OUAWcM7iIu/3uuA3q0WhTc0xY1ikmOeIeycX7unqMJrmy2p9pmkappm5FxSZuqe28J
	 Vk0mfxJwsVFEZRQuvOCzYjCVgxENhs4b4i8ZPTGG/BwxZe7QBmwPXRvWIdXY8lKyXOW9P
	 MPgJPcydAkTQm25LFIycfcGj2kJQJamMxdCYKTzylsdrxsiBNlz7OnAuOw6KjODUWFS4q
	 cMAlDiwakOcaF0sfQR0YE8a3VdAEbTYBsRKg5g19u3/eogA3Ieme9dKs0pDQQh3+sc2CW
	 +fxrIb2+FQxNmFhjFUbZZtjGnOho3a1Qagruv2DA5BHP9jCPEhPnfHmsGzeWsTGu0gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576774;
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
	bh=Nfy9BikunKyhlHNjeMa8AN0Mw8BrdOoLEgwSrMDvKo4=;
	b=SKJgcpzsB9sfJM5/D+nYCQbku5d75NCdExB8HhcNPKAUnu+UgMgZ2yJYRzQkh7Umtdi5
	 5VTN7g3Pyyrak7yGqDiTp5fwt1NXHcTBKwYVM352BG5akl+I7yx60S51k7cwefHzRIpRG
	 poZA1vWPR7l8UQz+e1RjrNHQcX4xzCPYI1ietk6sfi2/KRYhg52bkP7798kwNb1ZES2JX
	 cjZSUUPIKneptrGrOOiiaQILPrybFtyvbbUilUjdJNO2C/A3VnM6wwkw6ZFmJQJuO4yT0
	 dtvnYkpqHtqWgd8CiXogDuP0geyG6WVzWUpiT/zc/IqfrXf+STy9bav+W/FpWj17k/Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576774;
	bh=Nfy9BikunKyhlHNjeMa8AN0Mw8BrdOoLEgwSrMDvKo4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UnRd16yG7IVPMguhpe1X8uAr3yoYbYLRggtLuj2tk+FyASJpt3jP/StJSNtI9cmUa
	 u3g7HaJBPDC9w42dcM7dkA7410IKFbv2MHbYydAxIhwL1/F/9eA4PHN+TPo4Q/gCX6
	 IWHIo4FULbIBJHF1cp9ioHHJGIY9eraBzzW+sW69np/Okhtltxq0deOaWNdkDcroYZ
	 tGRNqY6zTQyc40dOc8ATqBQfy77NMCQCt6uecIWBXxVm1TLP357I+wR1gqt37K55p2
	 y1BMDw4khYoQ4oxJtUG3cXTao3M5n2JizXwIv8V9IDygG8/73LqszVCruFNGr/pCE9
	 yfk6Rad7tEFiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20D2F608C4;
	Fri,  9 Oct 2026 20:12:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 279B594E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0DF4F40080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVtlKMdaulYT for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B7600401EA
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576766;
 b=idRNMAHpD5njwBz9JQ3MYW5iLxwXLoZxwOWeYvqyjklUB1MGRqFXCiOpmm14ibuNHZP0
 I63wLMlMYS2qrLGffzLEF14tEWzkctCJH5cq6iM2WEk3vEnu+rkEQEiVUh0KYJbDdR0Ji
 +p8Lx83Hb/ULMjdi92Zjbv2+gC1yH+PI0klBwtLz6kbfyHDA2kOq4gKkLsEnM7AkY0rOx
 JsbSlHuOstBfHylfvCIeFubf1XUkC07/FDdi+u/8qmu6j46wmj+KipOV2d9wmLtFnf41r
 jqEu89Moh2QarJieHZXEz+R3OqwvU5wNvS33Gfmx4rvaFSOa3uOfYH8vgn5p4aGlUuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576766;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Nfy9BikunKyhlHNjeMa8AN0Mw8BrdOoLEgwSrMDvKo4=;
 b=Q47GawsCwzPA9YB4TfEsWqbXmUf1frACQstf45Jeadb/2g3zyY7TJ4pK8ZgHVW+4DDm5
 sjAkvbNwQ+UJXt6VcB7fCVkWsYqGXGLffTY/coQQu8jMygN0lSWNXOJc2HVT8y9+S4l05
 4leOYGnEhgyt/sVLXGg3+YnOvz4kaDlflhUWtSYc4obbrcwWMYbuW5jBSXVnZxVre2GeW
 Uh0IQEGgIPIZAktd15KsnC9yugo1TTDZ/Bu+AdTwsJhzyZ+LYkcQPFnSasI9AKw/6MpPC
 LUO2JPWktag81J4/gT8mDfJ/Cebi8pZuINmC1V1LMFpfgVgLQsDf6Orq2Q9lgQ8Z0lA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=a+ofbDZ7; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a+ofbDZ7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7600401EA
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576767; x=1823112767;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=eWQEDgyL9g4niX+4mmiQS9xqvriv4GtFMCv2umG5Fso=;
 b=a+ofbDZ75q9DKh1EGYRbeeskHD4E6zr/7YvpC7GcrCvqq2JMMKDO9hNl
 PE+DQQk8RZUQmYnMfV59S3dVTwqWXxMAoNZ57uqwBPJMWfyy31zq+CMJ+
 acIXwbs1Ees51BXaCFiEDw4P6temxMiVk2e/SDLdnJyNGrpVVW8/Q2CEO
 lpd6RrC5Czvw69HtYbtHkVhGcDwGYrzDl1H2y3Lhuta3evVkZzv02gBVC
 zPq/Navssn8WVu845VvDDiPzvtFzgkdLBer32fIVKk3F4CSGeQ5iS/3ms
 vLsjC5VS69B/Wc2IqPteBYUUo6as/kcPDZFeePnuz+Y+mguf6vAdi+aGa A==;
X-CSE-ConnectionGUID: Af0Zzto8QfeT78+8iLCl4A==
X-CSE-MsgGUID: HgREiKhHTEaWxQLSIc37qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261912"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261912"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:45 -0700
X-CSE-ConnectionGUID: fM5Ppz6+QQCDbSZwnVCdKA==
X-CSE-MsgGUID: e4I9s/91RBux9SGY0y4fwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189807"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 09 Oct 2026 13:11:21 -0700
Subject: [PATCH iwl-next v2 5/6] ice: remove ice_agg_node wrapper structure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-5-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=17475;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=eWQEDgyL9g4niX+4mmiQS9xqvriv4GtFMCv2umG5Fso=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXtsEL/yZom/3o1nmRtfi5lOWbmuVuYS5rqqnb3nlE
 j9zrVVFRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABOpecnwT/VYy8r7kpP1mVrn
 PQjLm7T+jf6UTIbSapF1mV7PT357v5SRoen/eqUcZ6VwswCnh+UL7LYt+sfE86fMvXul9YxlDHK
 iHAA=
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

The ice_set_agg_vsi() function has bespoke logic for identifying a suitable
aggregator node to use for a VSI. The main goal of the function is to
ensure that various types of VSIs do not share aggregator nodes. It uses
fixed size arrays of struct ice_agg_node in the PF structure to keep track
of which aggregator nodes are currently used.

The scheduler code already keeps track of almost all of this information
via the ice_sched_agg_info structures. It doesn't make sense to store
similar information in two places. Indeed, this leaves open the
possibility that the two have conflicting data.

The recent change to refactor the aggregator info to an xarray allows
lookup via index. This enables reworking the logic in ice_set_agg_vsi() and
removal of the ice_agg_node wrapper structure.

Introduce ice_cfg_vsi_agg() and its related helper,
ice_find_available_agg(). The helper will search the range of requested IDs
and find one of the appropriate type with enough space. If no existing node
is found, then a new one will be created.

Then ice_cfg_vsi_agg() will move the VSI into that aggregator node, and
update the scheduler tree.

Neither ice_move_vsi_to_agg() nor ice_cfg_agg() made an attempt to cleanup
a previous node. The same is true for ice_cfg_vsi_agg() with one exception:
When ice_find_available_agg() allocates a new node, if scheduler tree setup
fails, the node is removed from the xarray. This matches the old logic
where the wrapper structure "valid" bit is not set unless the scheduler
succeeds. The next time that node is reused it would get reconfigured.
Removal from the xarray is safe and correct here since the code knows that
it was newly allocated and that no VSIs have yet been added to its list.

This is similar to the logic used before, but now integrated better into
the scheduler code. It also occurs all in a single critical section of the
scheduler lock, rather than being split between multiple lock/unlock
rounds.

Remove the ice_agg_node arrays and structure, and all of its related code
including the bespoke logic in ice_set_agg_vsi() as well as the associated
cleanup in ice_vsi_decfg() and ice_pf_dis_all_vsi(). The logic in
ice_pf_dis_all_vsi() is questionable anyways. Clearing the VSI count here
appears to have been intended for reconfiguring aggregator nodes after
reset. However, the ice_cfg_agg() is not called as part of a rebuild, but
only during initialization. The aggregator nodes are instead replayed via
ice_sched_replay_agg() and ice_sched_replay_vsi_agg(), which completely
ignored the wrapper structures.

Only the VF logic actually used the previously stored aggregator node data.
To handle this, store just the ID of the associated aggregator node. Update
the ice_vf_rebuild_aggregator_node_cfg() to use ice_cfg_vsi_agg() instead
of using ice_move_vsi_to_agg(). This way the node will be recreated
properly if its ever removed for any reason.

This refactor drops the arrays in the ice_pf structure, reducing its size
by 1152 bytes, or ~5% of the structures size.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        |  23 ++----
 drivers/net/ethernet/intel/ice/ice_sched.h  |   5 ++
 drivers/net/ethernet/intel/ice/ice_lib.c    | 114 +++++-----------------------
 drivers/net/ethernet/intel/ice/ice_main.c   |   7 --
 drivers/net/ethernet/intel/ice/ice_sched.c  | 108 ++++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib.c |  22 +++---
 6 files changed, 146 insertions(+), 133 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 9e53dc3abb9a..e22188f0980a 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -447,10 +447,10 @@ struct ice_vsi {
 	u8 old_numtc;
 	u16 old_ena_tc;
 
-	/* setup back reference, to which aggregator node this VSI
-	 * corresponds to
+	/* ID of the aggregator node this VSI was configured with at setup, or
+	 * negative if it was not configured with an aggregator node.
 	 */
-	struct ice_agg_node *agg_node;
+	s64 agg_id;
 
 	struct_group_tagged(ice_vsi_cfg_params, params,
 		struct ice_port_info *port_info; /* back pointer to port_info */
@@ -539,12 +539,10 @@ struct ice_eswitch {
 	bool is_running;
 };
 
-struct ice_agg_node {
-	u32 agg_id;
-#define ICE_MAX_VSIS_IN_AGG_NODE	64
-	u32 num_vsis;
-	u8 valid;
-};
+#define ICE_PF_AGG_NODE_ID_START	1
+#define ICE_PF_AGG_NODE_ID_END		32
+#define ICE_VF_AGG_NODE_ID_START	65
+#define ICE_VF_AGG_NODE_ID_END		96
 
 struct ice_pf_msix {
 	u32 cur;
@@ -659,13 +657,6 @@ struct ice_pf {
 	struct xarray dyn_ports;
 	struct xarray sf_nums;
 
-#define ICE_INVALID_AGG_NODE_ID		0
-#define ICE_PF_AGG_NODE_ID_START	1
-#define ICE_MAX_PF_AGG_NODES		32
-	struct ice_agg_node pf_agg_node[ICE_MAX_PF_AGG_NODES];
-#define ICE_VF_AGG_NODE_ID_START	65
-#define ICE_MAX_VF_AGG_NODES		32
-	struct ice_agg_node vf_agg_node[ICE_MAX_VF_AGG_NODES];
 	struct ice_dplls dplls;
 	struct device *hwmon_dev;
 	struct ice_health health_reporters;
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 992aafc4369d..b9ea9174f3d9 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -65,6 +65,8 @@ struct ice_sched_agg_vsi_info {
 	DECLARE_BITMAP(replay_tc_bitmap, ICE_MAX_TRAFFIC_CLASS);
 };
 
+#define ICE_MAX_VSIS_IN_AGG_NODE	64
+
 struct ice_sched_agg_info {
 	struct list_head agg_vsi_list;
 	DECLARE_BITMAP(tc_bitmap, ICE_MAX_TRAFFIC_CLASS);
@@ -134,6 +136,9 @@ int ice_rm_vsi_lan_cfg(struct ice_port_info *pi, u16 vsi_handle);
 int ice_rm_vsi_rdma_cfg(struct ice_port_info *pi, u16 vsi_handle);
 
 /* Tx scheduler rate limiter functions */
+int ice_cfg_vsi_agg(struct ice_port_info *pi, u16 vsi_handle,
+		    u32 min_id, u32 max_id, u8 tc_bitmap,
+		    u32 *configured_id);
 int
 ice_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 	    enum ice_agg_type agg_type, u8 tc_bitmap);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0b0feb5b9919..0b7e95d984e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2236,44 +2236,28 @@ void ice_cfg_sw_rx_lldp(struct ice_pf *pf, bool enable)
 static void ice_set_agg_vsi(struct ice_vsi *vsi)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
-	struct ice_agg_node *agg_node_iter = NULL;
-	u32 agg_id = ICE_INVALID_AGG_NODE_ID;
-	struct ice_agg_node *agg_node = NULL;
-	int node_offset, max_agg_nodes = 0;
-	struct ice_port_info *port_info;
-	struct ice_pf *pf = vsi->back;
-	u32 agg_node_id_start = 0;
-	int status;
+	u32 min_id, max_id, agg_id;
+	int err;
+
+	vsi->agg_id = -1;
 
 	/* create (as needed) scheduler aggregator node and move VSI into
 	 * corresponding aggregator node
 	 * - PF aggregator node to contains VSIs of type _PF and _CTRL
 	 * - VF aggregator nodes will contain VF VSI
 	 */
-	port_info = pf->hw.port_info;
-	if (!port_info)
-		return;
-
 	switch (vsi->type) {
 	case ICE_VSI_CTRL:
 	case ICE_VSI_CHNL:
 	case ICE_VSI_LB:
 	case ICE_VSI_PF:
 	case ICE_VSI_SF:
-		max_agg_nodes = ICE_MAX_PF_AGG_NODES;
-		agg_node_id_start = ICE_PF_AGG_NODE_ID_START;
-		agg_node_iter = &pf->pf_agg_node[0];
+		min_id = ICE_PF_AGG_NODE_ID_START;
+		max_id = ICE_PF_AGG_NODE_ID_END;
 		break;
 	case ICE_VSI_VF:
-		/* user can create 'n' VFs on a given PF, but since max children
-		 * per aggregator node can be only 64. Following code handles
-		 * aggregator(s) for VF VSIs, either selects a agg_node which
-		 * was already created provided num_vsis < 64, otherwise
-		 * select next available node, which will be created
-		 */
-		max_agg_nodes = ICE_MAX_VF_AGG_NODES;
-		agg_node_id_start = ICE_VF_AGG_NODE_ID_START;
-		agg_node_iter = &pf->vf_agg_node[0];
+		min_id = ICE_VF_AGG_NODE_ID_START;
+		max_id = ICE_VF_AGG_NODE_ID_END;
 		break;
 	default:
 		/* other VSI type, handle later if needed */
@@ -2282,70 +2266,17 @@ static void ice_set_agg_vsi(struct ice_vsi *vsi)
 		return;
 	}
 
-	/* find the appropriate aggregator node */
-	for (node_offset = 0; node_offset < max_agg_nodes; node_offset++) {
-		/* see if we can find space in previously created
-		 * node if num_vsis < 64, otherwise skip
-		 */
-		if (agg_node_iter->num_vsis &&
-		    agg_node_iter->num_vsis == ICE_MAX_VSIS_IN_AGG_NODE) {
-			agg_node_iter++;
-			continue;
-		}
-
-		if (agg_node_iter->valid &&
-		    agg_node_iter->agg_id != ICE_INVALID_AGG_NODE_ID) {
-			agg_id = agg_node_iter->agg_id;
-			agg_node = agg_node_iter;
-			break;
-		}
-
-		/* find unclaimed agg_id */
-		if (agg_node_iter->agg_id == ICE_INVALID_AGG_NODE_ID) {
-			agg_id = node_offset + agg_node_id_start;
-			agg_node = agg_node_iter;
-			break;
-		}
-		/* move to next agg_node */
-		agg_node_iter++;
-	}
-
-	if (!agg_node)
-		return;
-
-	/* if selected aggregator node was not created, create it */
-	if (!agg_node->valid) {
-		status = ice_cfg_agg(port_info, agg_id, ICE_AGG_TYPE_AGG,
-				     (u8)vsi->tc_cfg.ena_tc);
-		if (status) {
-			dev_err(dev, "unable to create aggregator node with agg_id %u\n",
-				agg_id);
-			return;
-		}
-		/* aggregator node is created, store the needed info */
-		agg_node->valid = true;
-		agg_node->agg_id = agg_id;
-	}
-
-	/* move VSI to corresponding aggregator node */
-	status = ice_move_vsi_to_agg(port_info, agg_id, vsi->idx,
-				     (u8)vsi->tc_cfg.ena_tc);
-	if (status) {
-		dev_err(dev, "unable to move VSI idx %u into aggregator %u node",
-			vsi->idx, agg_id);
+	err = ice_cfg_vsi_agg(vsi->back->hw.port_info, vsi->idx, min_id,
+			      max_id, (u8)vsi->tc_cfg.ena_tc, &agg_id);
+	if (err) {
+		dev_err(dev, "Unable to associate VSI with an aggregator node, %pe\n",
+			ERR_PTR(err));
 		return;
 	}
 
-	/* keep active children count for aggregator node */
-	agg_node->num_vsis++;
-
-	/* cache the 'agg_id' in VSI, so that after reset - VSI will be moved
-	 * to aggregator node
-	 */
-	vsi->agg_node = agg_node;
-	dev_dbg(dev, "successfully moved VSI idx %u tc_bitmap 0x%x) into aggregator node %d which has num_vsis %u\n",
-		vsi->idx, vsi->tc_cfg.ena_tc, vsi->agg_node->agg_id,
-		vsi->agg_node->num_vsis);
+	vsi->agg_id = agg_id;
+	dev_dbg(dev, "successfully moved VSI idx %u tc_bitmap 0x%x into aggregator node %u\n",
+		vsi->idx, vsi->tc_cfg.ena_tc, agg_id);
 }
 
 static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
@@ -2602,16 +2533,6 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 	ice_vsi_free_q_vectors(vsi);
 	ice_vsi_put_qs(vsi);
 	ice_vsi_free_arrays(vsi);
-
-	/* SR-IOV determines needed MSIX resources all at once instead of per
-	 * VSI since when VFs are spawned we know how many VFs there are and how
-	 * many interrupts each VF needs. SR-IOV MSIX resources are also
-	 * cleared in the same manner.
-	 */
-
-	if (vsi->type == ICE_VSI_VF &&
-	    vsi->agg_node && vsi->agg_node->valid)
-		vsi->agg_node->num_vsis--;
 }
 
 /**
@@ -2664,8 +2585,7 @@ ice_vsi_setup(struct ice_pf *pf, struct ice_vsi_cfg_params *params)
 		ice_vsi_cfg_sw_lldp(vsi, true, true);
 	}
 
-	if (!vsi->agg_node)
-		ice_set_agg_vsi(vsi);
+	ice_set_agg_vsi(vsi);
 
 	return vsi;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 94c105193c7c..484f1062d320 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -578,18 +578,11 @@ static void ice_sync_fltr_subtask(struct ice_pf *pf)
  */
 static void ice_pf_dis_all_vsi(struct ice_pf *pf, bool locked)
 {
-	int node;
 	int v;
 
 	ice_for_each_vsi(pf, v)
 		if (pf->vsi[v])
 			ice_dis_vsi(pf->vsi[v], locked);
-
-	for (node = 0; node < ICE_MAX_PF_AGG_NODES; node++)
-		pf->pf_agg_node[node].num_vsis = 0;
-
-	for (node = 0; node < ICE_MAX_VF_AGG_NODES; node++)
-		pf->vf_agg_node[node].num_vsis = 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index b1c2901b23f1..f0b1924b0411 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -3082,6 +3082,114 @@ ice_move_vsi_to_agg(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
 	return status;
 }
 
+/**
+ * ice_find_available_agg - Find or create aggregator node
+ * @pi: port information structure
+ * @min_id: minimum aggregator node ID to use
+ * @max_id: maximum aggregator node ID to use
+ * @agg_type: The aggregator node type
+ * @tc_bitmap: TC bitmap for a newly created node
+ *
+ * Check the existing xarray of aggregator nodes. Find the first one between
+ * min_id and max_id which has fewer than ICE_MAX_VSIS_IN_AGG_NODE (64) VSIs
+ * in use. If there is no aggregator node that fits this criteria, create
+ * a new one between that range.
+ *
+ * Context: Must be called while holding the scheduler lock.
+ *
+ * Return: A pointer to the aggregator info structure, or an ERR_PTR on
+ * failure.
+ */
+static struct ice_sched_agg_info *
+ice_find_available_agg(struct ice_port_info *pi, u32 min_id, u32 max_id,
+		       enum ice_agg_type agg_type, unsigned long *tc_bitmap)
+{
+	struct ice_sched_agg_info *agg_info;
+	struct ice_hw *hw = pi->hw;
+	unsigned long agg_id;
+	int status;
+
+	xa_for_each_range(&hw->agg_nodes, agg_id, agg_info, min_id, max_id) {
+		if (agg_info->agg_type != agg_type)
+			continue;
+
+		if (agg_info->num_vsis < ICE_MAX_VSIS_IN_AGG_NODE)
+			return agg_info;
+	}
+
+	/* No aggregator node exists with space, so create a new one */
+	agg_info = ice_alloc_agg_info(hw, min_id, max_id, agg_type);
+	if (IS_ERR(agg_info))
+		return agg_info;
+
+	/* Configure the newly created aggregator node */
+	status = ice_sched_cfg_agg(pi, agg_info, tc_bitmap);
+	if (status) {
+		xa_erase(&hw->agg_nodes, agg_info->agg_id);
+		devm_kfree(ice_hw_to_dev(hw), agg_info);
+
+		return ERR_PTR(status);
+	}
+
+	/* Save the TC bitmap for this aggregator node */
+	ice_save_agg_tc_bitmap(agg_info, tc_bitmap);
+
+	return agg_info;
+}
+
+/**
+ * ice_cfg_vsi_agg - Configure a VSI to an aggregator node
+ * @pi: port information structure
+ * @vsi_handle: software VSI handle
+ * @min_id: the minimum aggregator node ID to associate with
+ * @max_id: the maximum aggregator node ID to associate with
+ * @tc_bitmap: TC bitmap of enabled TC(s)
+ * @configured_id: If non-NULL, contains the configured ID on return
+ *
+ * Locate a suitable aggregator node for this VSI, creating a new one if
+ * necessary. Configure the aggregator node if necessary, and move the VSI
+ * into it.
+ *
+ * Context: Acquires the scheduler lock.
+ *
+ * Return: zero on success, or a negative errno on failure.
+ */
+int ice_cfg_vsi_agg(struct ice_port_info *pi, u16 vsi_handle,
+		    u32 min_id, u32 max_id, u8 tc_bitmap,
+		    u32 *configured_id)
+{
+	struct ice_sched_agg_info *agg_info;
+	unsigned long bitmap = tc_bitmap;
+	int status;
+
+	mutex_lock(&pi->sched_lock);
+
+	/* Locate an aggregator node to use */
+	agg_info = ice_find_available_agg(pi, min_id, max_id, ICE_AGG_TYPE_AGG,
+					  &bitmap);
+	if (IS_ERR(agg_info)) {
+		status = PTR_ERR(agg_info);
+		goto out_unlock;
+	}
+
+	/* Associate the VSI with this aggregator node */
+	status = ice_sched_assoc_vsi_to_agg(pi, agg_info, vsi_handle, &bitmap);
+	if (status)
+		goto out_unlock;
+
+	/* Save the VSI handle to the aggregator TC bitmap */
+	status = ice_save_agg_vsi_tc_bitmap(agg_info, vsi_handle, &bitmap);
+	if (status)
+		goto out_unlock;
+
+	if (configured_id)
+		*configured_id = agg_info->agg_id;
+
+out_unlock:
+	mutex_unlock(&pi->sched_lock);
+	return status;
+}
+
 /**
  * ice_set_clear_cir_bw - set or clear CIR BW
  * @bw_t_info: bandwidth type information structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c56a35b8dd48..a67586f7db8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -471,24 +471,20 @@ static void ice_vf_rebuild_aggregator_node_cfg(struct ice_vsi *vsi)
 	struct device *dev;
 	int status;
 
-	if (!vsi->agg_node)
-		return;
-
 	dev = ice_pf_to_dev(pf);
-	if (vsi->agg_node->num_vsis == ICE_MAX_VSIS_IN_AGG_NODE) {
-		dev_dbg(dev,
-			"agg_id %u already has reached max_num_vsis %u\n",
-			vsi->agg_node->agg_id, vsi->agg_node->num_vsis);
+
+	if (vsi->agg_id < 0 || vsi->agg_id > U32_MAX) {
+		dev_dbg(dev, "VSI idx %u does not have a valid aggregator node ID stored\n",
+			vsi->idx);
 		return;
 	}
 
-	status = ice_move_vsi_to_agg(pf->hw.port_info, vsi->agg_node->agg_id,
-				     vsi->idx, vsi->tc_cfg.ena_tc);
+	status = ice_cfg_vsi_agg(pf->hw.port_info, vsi->idx,
+				 (u32)vsi->agg_id, (u32)vsi->agg_id,
+				 (u8)vsi->tc_cfg.ena_tc, NULL);
 	if (status)
-		dev_dbg(dev, "unable to move VSI idx %u into aggregator %u node",
-			vsi->idx, vsi->agg_node->agg_id);
-	else
-		vsi->agg_node->num_vsis++;
+		dev_dbg(dev, "unable to move VSI idx %u into aggregator node %lld\n",
+			vsi->idx, vsi->agg_id);
 }
 
 /**

-- 
2.56.0.rc0.395.gd1f3524e15dc

