Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D79CA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FBE06067C;
	Fri,  9 Oct 2026 20:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvHYjmWjdq5v; Fri,  9 Oct 2026 20:12:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0E078606F8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576768;
	b=OZJMeZhmu5CS2TtL+AL/gdCpnqh022Bjuz9ZgnSbfhyJAA/w+UHSvMomPZQoWLFYyOOg
	 Afxf2jkHqDaoAOyL+98jw5AWPRDYs41xDpCNuxs/RO6a26XJWxPZ+yIgFIWu/L7tUdXx2
	 Dg26JABIA91FHhWIjT45rp5uprgx2J/hhRY90CBB+EuqrAcrhNXi2njom6/wJyHALAQ3Z
	 uQYu9Sr4jae1zon0FPvftFGyL3izyyzF1zdSm05XKcDurVsClSDG89fXqBTsqGlYyxF9Y
	 kfHFoX4NxrlaRgRG+JkGs5Ql9F6pWrS9IbGB8zhVVjmI61Bim5Lg7YLr5rw1wJ7nK7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576768;
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
	bh=BZmlyY6CQN1SEIf0a4ED6cBMvh5ARZGXtXRg2vYJMr0=;
	b=i4KT/BMgLUMylrAdzCcgRXGCQO2hI7gnnPLUJKVffJbizD4MbyoXm8aSQdad9UPe3A1F
	 WuLQ82vM+1Lb+x4EAeIBtMEoTjNmDOkf6/QmiJTlkm9nDJimvxHH+K0zwJUSy+aUjGJMy
	 oCVdPYFOgvSbObfa6vpeezB+m+pGzbzEmTc04jMCplVd14j5uRQBrXpgxCvhL3jLfTdfq
	 KLObY2gLWIZCoBBp+Y5VW13Z4BOW8nMlAN0KDPg6k9+rC2JALlx/kVR38uZFAU5wiK4dx
	 jTEUq7YSSahrNasWSdXu/iJxuq6KjoNbIMLyKqPskhPo3eYCl5VIkYj5QZhXPIN71sQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576768;
	bh=BZmlyY6CQN1SEIf0a4ED6cBMvh5ARZGXtXRg2vYJMr0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fV7fCKgYoJG+SLkBEoAXuIOFZJ2URJ9vhOyNwZU7o9d1hGTgj6G/XmS0Sac5GdZST
	 +Jmc3i+9fB9ItaC35N+dsMEipAk0+DzZrFHQWtNuU7BEgqmpBxa4KhxggSdfWyGGMw
	 l2WrxdGYSxsK9sz9i6EeiajDIHqAhvhUObjrEUO7I2TlIBJtZlQYMvdvbHoao7N2VT
	 gTNXsZEC2FBd4ugcJdUhkSjI22NyrE8Mt13kN9V+wrfoXE2ZVr20twuBBYI9lpQAqG
	 x7X3nqR2SjSM2BO0c714TrsJjG1wKeD1SlSNR0kb/paNSwY7FhLf+Da9gqXmjM5mpZ
	 EokY5w9UyaWGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E078606F8;
	Fri,  9 Oct 2026 20:12:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B2863B4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E529B4039B
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JXNXOp12OhUz for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A1AD740080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576765;
 b=DZv7FV00WeBfiZwbcQ/SgGx8Ixb0vfl8tWpN3lQd+aEbsUZukfIxw54vaFnVkqfU3+Eh
 NYo4axP3rGQTy7Xg/3YgNNdsMVllsOHIjwXIggwAD38woH2A4B+dHuOW2KDFdLpZ8sRH5
 yPGS/y/+3HY4/RIfjp6o+Ke1cp1I4s0k8UBclAuB/OH9CURhWgbqhUf7caNA9lYhbg936
 +uEsCd3i8YLps5jcg8dFq/7PHd8XN7htHxbfGUulDK20Vk1u2QYhvPhoSp1R6HgRIDK1V
 tWlvX0r64sba5tjKZpE4CbcOtKW8TDsrwWouiic+TM04i+4UmN60zoXqfL6yQh6MRRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576765;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=BZmlyY6CQN1SEIf0a4ED6cBMvh5ARZGXtXRg2vYJMr0=;
 b=gHhTKWvYjkP7zXZoRD+7LS84XoWenGyn7XFMJP9tbF6JiJ7iTwcKFNS4PZPF5MeLbSj/
 RPo7/fN2/9+/3v9PGlAw7/0CNBgVcs3Y2AtSuNynSgyUiAkNUwl7UoE5QLeTCb5QYPPd9
 G7GkEVA4ec/JZC8OzzuBGZ30K6lZR8bDucl6vnQxRirzHMoFIvRnwghAzH7vGDAd5QEGG
 +k3GnoYk5xQMvzCyOIz/aJqag39HUk4LdNba267bDzBXEpLW0ilngy6QBs+In0IMzo+KW
 K9UTePtIU2d4YM3ZX528EXXOSpGUGM2YdOOa/xWIpY1pMgfhsIuexNtUFiTHObdiT2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=bChkHrqC; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=bChkHrqC
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1AD740080
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576766; x=1823112766;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=UsAyUXUO/xd67HaU9Po65amv3BDwUR3EzzKnv3mWqqg=;
 b=bChkHrqCUqwDss/hGkNZAHScWamWFIVUQDtSubLeACd/xYKgsZQU6q1w
 CGZKMH1GTdMWkVIjQrBIuR94b1XmdoRoJWD+1t/sMY/zfMgHP6j5+HTTF
 gONJ5/I1fBD58otn7CM768AAS9wNkr14ZWZaxLfVyfNWAxCp+4qp5iE19
 jDrhUS6zvrxVDzBka6u7aSGBh/Eto6LYiuuUKlEewxxL4H56uxfcBAk9P
 ilP/hpSYaiSMVfM9l8gCSoi0DGuW0YqP9uJCGYYZng+N2iZr5Jdu4+5+n
 Kb5OyyoK+gPjsPI6mw2Sx1NBR4GbesBDKfzRPVZhFSrnqZJTzPzAvJfwl w==;
X-CSE-ConnectionGUID: 4GGHeTgcTYmQCqagzWswQQ==
X-CSE-MsgGUID: XUpolM+qR+Oq/A46+Jh4UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261908"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261908"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:45 -0700
X-CSE-ConnectionGUID: N6eF9boWQEaxK2Od1Vcv+Q==
X-CSE-MsgGUID: MRlBsjcTT1WcHewwhfNfiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189793"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 09 Oct 2026 13:11:17 -0700
Subject: [PATCH iwl-next v2 1/6] ice: convert hw->agg_list from linked list
 to xarray
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-1-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=9107;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=UsAyUXUO/xd67HaU9Po65amv3BDwUR3EzzKnv3mWqqg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXls13l96mdLd/mruL4uIC2sime85ZveFnHnP7nnDv
 u9mT7lKRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABN5/4CR4U2Xh0sndyDPFV9J
 Wcmt/JxK4idCpHxl9qocrrAKT2bjYPjN8t8qsHTD5VM8066/u/V+26Y/944tbbgx9Ud500fdvge
 nGQE=
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

The scheduler code saves information about the aggregator nodes in a linked
list in the hw->agg_list structure. This choice of data structure is not
ideal. Indeed, several places in the code iterate the list searching to see
if a given ID is present.

Convert the linked list into an xarray. Where possible, simplify aggregator
info lookup to use xa_load instead of iterating over all the entries.

Switching to xarray data structure better matches the existing usage
pattern. In addition, it prepares the code to allow removal of the
ice_agg_node wrapping structure used by ice_vsi, which will be completed in
following changes.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.h  |  1 -
 drivers/net/ethernet/intel/ice/ice_type.h   |  2 +-
 drivers/net/ethernet/intel/ice/ice_common.c |  4 +-
 drivers/net/ethernet/intel/ice/ice_sched.c  | 58 ++++++++++++-----------------
 4 files changed, 27 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index 7b668083be07..f2a619fcab8b 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -67,7 +67,6 @@ struct ice_sched_agg_vsi_info {
 
 struct ice_sched_agg_info {
 	struct list_head agg_vsi_list;
-	struct list_head list_entry;
 	DECLARE_BITMAP(tc_bitmap, ICE_MAX_TRAFFIC_CLASS);
 	u32 agg_id;
 	enum ice_agg_type agg_type;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index b8bdd7e8c768..83f7e809cfc4 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -928,7 +928,7 @@ struct ice_hw {
 	u8 max_cgds;
 	u8 sw_entry_point_layer;
 	u16 max_children[ICE_AQC_TOPO_MAX_LEVEL_NUM];
-	struct list_head agg_list;	/* lists all aggregator */
+	struct xarray agg_nodes; /* array of aggregator nodes */
 	struct xarray sched_node_ids;
 
 	struct ice_vsi_ctx *vsi_ctx[ICE_MAX_VSI];
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index feccd2b0f889..16f20b0feb02 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1052,6 +1052,7 @@ int ice_init_hw(struct ice_hw *hw)
 	hw->evb_veb = true;
 
 	xa_init_flags(&hw->sched_node_ids, XA_FLAGS_ALLOC);
+	xa_init(&hw->agg_nodes);
 
 	/* Query the allocated resources for Tx scheduler */
 	status = ice_sched_query_res_alloc(hw);
@@ -1091,7 +1092,6 @@ int ice_init_hw(struct ice_hw *hw)
 		status = -EIO;
 		goto err_unroll_sched;
 	}
-	INIT_LIST_HEAD(&hw->agg_list);
 	/* Initialize max burst size */
 	if (!hw->max_burst_size)
 		ice_cfg_rl_burst_size(hw, ICE_SCHED_DFLT_BURST_SIZE);
@@ -1147,6 +1147,7 @@ int ice_init_hw(struct ice_hw *hw)
 	ice_sched_cleanup_all(hw);
 err_unroll_xarray:
 	xa_destroy(&hw->sched_node_ids);
+	xa_destroy(&hw->agg_nodes);
 err_unroll_alloc:
 	devm_kfree(ice_hw_to_dev(hw), hw->port_info);
 err_unroll_cqinit:
@@ -1189,6 +1190,7 @@ void ice_deinit_hw(struct ice_hw *hw)
 	ice_clear_all_vsi_ctx(hw);
 
 	xa_destroy(&hw->sched_node_ids);
+	xa_destroy(&hw->agg_nodes);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index ffa18d86729a..bcfc9db69e17 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -813,9 +813,9 @@ static void ice_sched_clear_rl_prof(struct ice_port_info *pi)
 void ice_sched_clear_agg(struct ice_hw *hw)
 {
 	struct ice_sched_agg_info *agg_info;
-	struct ice_sched_agg_info *atmp;
+	unsigned long index;
 
-	list_for_each_entry_safe(agg_info, atmp, &hw->agg_list, list_entry) {
+	xa_for_each(&hw->agg_nodes, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 		struct ice_sched_agg_vsi_info *vtmp;
 
@@ -824,7 +824,7 @@ void ice_sched_clear_agg(struct ice_hw *hw)
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(hw), agg_vsi_info);
 		}
-		list_del(&agg_info->list_entry);
+		xa_erase(&hw->agg_nodes, index);
 		devm_kfree(ice_hw_to_dev(hw), agg_info);
 	}
 }
@@ -2060,10 +2060,9 @@ ice_sched_cfg_vsi(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 maxqs,
 static void ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 {
 	struct ice_sched_agg_info *agg_info;
-	struct ice_sched_agg_info *atmp;
+	unsigned long index;
 
-	list_for_each_entry_safe(agg_info, atmp, &pi->hw->agg_list,
-				 list_entry) {
+	xa_for_each(&pi->hw->agg_nodes, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 		struct ice_sched_agg_vsi_info *vtmp;
 
@@ -2226,26 +2225,6 @@ int ice_rm_vsi_rdma_cfg(struct ice_port_info *pi, u16 vsi_handle)
 	return ice_sched_rm_vsi_cfg(pi, vsi_handle, ICE_SCHED_NODE_OWNER_RDMA);
 }
 
-/**
- * ice_get_agg_info - get the aggregator ID
- * @hw: pointer to the hardware structure
- * @agg_id: aggregator ID
- *
- * This function validates aggregator ID. The function returns info if
- * aggregator ID is present in list otherwise it returns null.
- */
-static struct ice_sched_agg_info *
-ice_get_agg_info(struct ice_hw *hw, u32 agg_id)
-{
-	struct ice_sched_agg_info *agg_info;
-
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry)
-		if (agg_info->agg_id == agg_id)
-			return agg_info;
-
-	return NULL;
-}
-
 /**
  * ice_sched_get_free_vsi_parent - Find a free parent node in aggregator subtree
  * @hw: pointer to the HW struct
@@ -2619,7 +2598,7 @@ ice_save_agg_tc_bitmap(struct ice_port_info *pi, u32 agg_id,
 {
 	struct ice_sched_agg_info *agg_info;
 
-	agg_info = ice_get_agg_info(pi->hw, agg_id);
+	agg_info = xa_load(&pi->hw->agg_nodes, agg_id);
 	if (!agg_info)
 		return -EINVAL;
 	bitmap_copy(agg_info->replay_tc_bitmap, tc_bitmap,
@@ -2735,7 +2714,7 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 	int status = 0;
 	u8 tc;
 
-	agg_info = ice_get_agg_info(hw, agg_id);
+	agg_info = xa_load(&hw->agg_nodes, agg_id);
 	if (!agg_info) {
 		/* Create new entry for new aggregator ID */
 		agg_info = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*agg_info),
@@ -2750,8 +2729,13 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 		/* Initialize the aggregator VSI list head */
 		INIT_LIST_HEAD(&agg_info->agg_vsi_list);
 
-		/* Add new entry in aggregator list */
-		list_add(&agg_info->list_entry, &hw->agg_list);
+		/* Add new entry in aggregator array */
+		status = xa_insert(&hw->agg_nodes, agg_id, agg_info,
+				   GFP_KERNEL);
+		if (status) {
+			devm_kfree(ice_hw_to_dev(hw), agg_info);
+			return status;
+		}
 	}
 	/* Create aggregator node(s) for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
@@ -2836,8 +2820,9 @@ static struct ice_sched_agg_info *
 ice_get_vsi_agg_info(struct ice_hw *hw, u16 vsi_handle)
 {
 	struct ice_sched_agg_info *agg_info;
+	unsigned long index;
 
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry) {
+	xa_for_each(&hw->agg_nodes, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 
 		agg_vsi_info = ice_get_agg_vsi_info(agg_info, vsi_handle);
@@ -2864,7 +2849,7 @@ ice_save_agg_vsi_tc_bitmap(struct ice_port_info *pi, u32 agg_id, u16 vsi_handle,
 	struct ice_sched_agg_vsi_info *agg_vsi_info;
 	struct ice_sched_agg_info *agg_info;
 
-	agg_info = ice_get_agg_info(pi->hw, agg_id);
+	agg_info = xa_load(&pi->hw->agg_nodes, agg_id);
 	if (!agg_info)
 		return -EINVAL;
 	/* check if entry already exist */
@@ -2899,7 +2884,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 
 	if (!ice_is_vsi_valid(pi->hw, vsi_handle))
 		return -EINVAL;
-	agg_info = ice_get_agg_info(hw, agg_id);
+	agg_info = xa_load(&hw->agg_nodes, agg_id);
 	if (!agg_info)
 		return -EINVAL;
 	/* If the VSI is already part of another aggregator then update
@@ -4314,9 +4299,10 @@ void ice_sched_replay_agg(struct ice_hw *hw)
 {
 	struct ice_port_info *pi = hw->port_info;
 	struct ice_sched_agg_info *agg_info;
+	unsigned long index;
 
 	mutex_lock(&pi->sched_lock);
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry)
+	xa_for_each(&hw->agg_nodes, index, agg_info) {
 		/* replay aggregator (re-create aggregator node) */
 		if (!bitmap_equal(agg_info->tc_bitmap, agg_info->replay_tc_bitmap,
 				  ICE_MAX_TRAFFIC_CLASS)) {
@@ -4339,6 +4325,7 @@ void ice_sched_replay_agg(struct ice_hw *hw)
 				continue;
 			}
 		}
+	}
 	mutex_unlock(&pi->sched_lock);
 }
 
@@ -4353,9 +4340,10 @@ void ice_sched_replay_agg_vsi_preinit(struct ice_hw *hw)
 {
 	struct ice_port_info *pi = hw->port_info;
 	struct ice_sched_agg_info *agg_info;
+	unsigned long index;
 
 	mutex_lock(&pi->sched_lock);
-	list_for_each_entry(agg_info, &hw->agg_list, list_entry) {
+	xa_for_each(&hw->agg_nodes, index, agg_info) {
 		struct ice_sched_agg_vsi_info *agg_vsi_info;
 
 		agg_info->tc_bitmap[0] = 0;

-- 
2.56.0.rc0.395.gd1f3524e15dc

