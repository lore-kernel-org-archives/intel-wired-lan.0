Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324D2CA9EBB
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 20:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0067F4080A;
	Fri,  9 Oct 2026 20:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5huwBdRA9Il4; Fri,  9 Oct 2026 20:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E9314094C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791576773;
	b=kAJEl7xD51aw2gsESc6Ek72ThNLaCwbZFM/r2Ix17pKIUlXSTgev0JX62AXrr+54AtMk
	 rJAvggoffQwN7cWJjnBv0Ss/OGNNkDx4TpFyVgwMEyj3hZSyZMJ0/GvLy9zWX4POAeV+0
	 1rvCaSBsOb10KuM0aEmcLhruydeRNA//SqMnOMGinWv8c8PTjy3sTR1VccCARIFL6OQ8p
	 DW8fXo6sHL7Iz3QU8aV4TsGlK4NtIMZHWrjLNHgAUF3YZOQuiyE8o6sqBWLGPIYD1tc/u
	 z6/2YDMd1o0nKWdLm3m+glp4glLurIVvaAOKVwWbZUwH0G+A6/8uzxLj49U/RysXKbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791576773;
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
	bh=S7dAfuqpDLH0C5nS5Kn0uLxWumVT0o+MYNOL2zYPtas=;
	b=tZ0MqrIXWGTn6fWw2sc7ijiYMR+OszFHjqtAMN3XNCi+6ZA1e54Fhmn3p6z+DI3wBMs2
	 uCUycVx+blgNpfTC1frJKanjyWCCXcdbC2ZkcxlH6az9B1BhkcRDH9GnUF1Xs78n3l1KE
	 sEWoRVHcsd6wTGPY0+5lyjEwztdjZDpRfNb/0aX4WzJAcBF3n/fPFZCKPXbtSs8NcOzaa
	 aFlQy5ZG/V2IAi0AGt35xHORadyuyrVSqGmBc1PvPBmpN65txl8n1E48XE4dTPYRxBBbz
	 OSakZgcHFOhmzp6ZCy5MIYSLL2iSM/lIw8mjpKT+A4A0dDPn8CbvLaCesfd5k7zhbiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791576773;
	bh=S7dAfuqpDLH0C5nS5Kn0uLxWumVT0o+MYNOL2zYPtas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UwSOK9JRSbq98h+j38BMi34gKHMjq2HHYlHIZblKzbMNeMvknDjuArLppuJFqpdLV
	 L7KDmooWhc3ZfeKLCjvfo+z3UF8fLnsoSddJrsABhGDr641byWEpWuBliG71cGIaHL
	 YohW7N+YMaWFVYR6M5/3PpA8KHOV7fBu1+BJFVBNoOnTKDK6yl5NdCIFWhOv1AjWJa
	 CS2Qojo2xsByZhcsu2xysDlslBksHkx9/aOfMcX09RaiacehsvHVG1TT8ND40gPZEi
	 afEbt3nfKwpgEBsXxLQKByDSNFdy8fPyPxKGpqHRQHPjXYsAJbh2i+rgtj5sUF6jvZ
	 aLQovykohJ4JA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E9314094C;
	Fri,  9 Oct 2026 20:12:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 24ACF3B4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22C7640194
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mph0H46zl09J for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 20:12:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0063F4018C
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576766;
 b=WPNeX3jdafWfFHTq2Ex80bki7HWBYZBjPa6HCDPq0OhowWm5pCfwA7Wd6btoldk+5VlD
 MTBHLUkGT6IijtiuMo3SVu/m5PhjXbAbCkiulBFSJcn+2IGPxSBDEv7s+AxWp/HkFmH5Q
 lAFcl3bYVgCGeBqIQ5aIJvRhRnU/suI/eUc9bR0dDzD+e7SrB2CwGp55A1uZBKdGy8ffA
 zx1WP2iUwwpvS0bUSI+29Rrx8VZ9NZSh80fB7b+Djd6s+CvAuI5OcEvm5RhKYDEZ7pHwL
 uze63k5eE6NL8iGLTe1zp06ASy1eHew7BsVuZ/JJlW+UCYQ7Yw6ez9Du3vPBq0fxZoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576766;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=S7dAfuqpDLH0C5nS5Kn0uLxWumVT0o+MYNOL2zYPtas=;
 b=CQTxZakgIXwGMF8C5cN475HAVsaHos6bAWKw/WcpZWoePlO7860erOAeWg/8NG8PVgJM
 KkkXNJdM0ItBuZJjKGTERaGcM0xldGmFZdX+Qvgpi/t4GA1ahoZA7DbufN7oIOM+XDFLH
 oTsusxWSasBEUeqq4zCtdYWbCUhGwAIMN9OzRzqtMq1sEELtZqpVCsNLkq8CqGB6Bi4aR
 B5KdYpC8m7CrP5seDB4YV4MwLBv9ubMc5I/fuS7g8uslt+LZRs6G7LsGeuCVatBzQ58/1
 LKyF5VFGHeMA9pt6I5sFGDaUL4E6iRiBABI3LL2JWCLB26SWu1S2E2iaLxxyqudwrlQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=GYjchTKv; 
 arc=none smtp.remote-ip=198.175.65.14
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GYjchTKv
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0063F4018C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791576766; x=1823112766;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Fs/ZOQuZhtqBzV0uuA8pTwNlxXgzjWxCQa3kDSkrv3k=;
 b=GYjchTKvN+hqmQAaasnSxTc5fYOhrCV33E8WAOv92NIodl2rxFayjFA3
 QDbMVVBP4gpgiUFmtYRqoJGJpw0RjNmu8m7pa1aO04Pitq9HU3ZOMkfQ4
 VkJL0gmUG/XNXCvwEeueLusFKWRBfQTfS7attsO1wbowC9h5vGrsetD8x
 gb2G9+QvgFC1Nbfze10s1+/XF00qaMYEqsi+LP52m6Rpz9TjG8aAQwYIw
 8RZ/QGSCvekFzvdsRxzbzNsyFqaTXqK6uweOCeAdvoAYiWApFdJ/bcdbk
 N7LENKbyEC6DZ06wYN1LV//pQUG0hP0aum7GSi1nzfDnCTrDSL6koZAoi g==;
X-CSE-ConnectionGUID: QDPWxyjLQxqj+SK3fwH+Fw==
X-CSE-MsgGUID: gmWgXDDNTP2Uy1WL2eKXdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="261909"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="261909"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:45 -0700
X-CSE-ConnectionGUID: 2L2NGBggTciqcZu5QisBmA==
X-CSE-MsgGUID: Bg3DH9mXT0mu1FaI6pnQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="2189797"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2026 13:12:44 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 09 Oct 2026 13:11:18 -0700
Subject: [PATCH iwl-next v2 2/6] ice: count number of VSIS in agg_vsi_list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-2-313964c25c7b@intel.com>
References: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
In-Reply-To: <20261009-jk-cleanup-vsi-aggregator-nodes-v2-0-313964c25c7b@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=3510;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Fs/ZOQuZhtqBzV0uuA8pTwNlxXgzjWxCQa3kDSkrv3k=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqyTXlvtbvrOuRW7edKHU2U/yq9tT+JWXbql6uymybzKr
 DdmnXtW21HKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBE0uYx/I96xvVoPzt7xwWx
 pkUXpNLsK7bIl5bGf6hbr3ustH3NvGxGhiueV2sfSdR593O7nkhPqb7I3d9i6LOY3f6JJteHL+H
 PWQE=
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

The ice_sched_agg_info structure maintains a list of VSIs associated with
the aggregator node. A following change is going to refactor logic from
ice_lib.c, and remove the ice_agg_node wrapper structure. Doing so will
require keeping track of how many VSIs are on a given aggregator node.

To simplify this tracking, add a member to the ice_sched_agg_info structure
which counts the number of VSIs using the node. Increment it when adding a
VSI to the list, and decrement when removing the VSI from the list. This
will avoid the need to iterate the agg_vsi_list to determine this
information.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.h | 1 +
 drivers/net/ethernet/intel/ice/ice_sched.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.h b/drivers/net/ethernet/intel/ice/ice_sched.h
index f2a619fcab8b..992aafc4369d 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.h
+++ b/drivers/net/ethernet/intel/ice/ice_sched.h
@@ -68,6 +68,7 @@ struct ice_sched_agg_vsi_info {
 struct ice_sched_agg_info {
 	struct list_head agg_vsi_list;
 	DECLARE_BITMAP(tc_bitmap, ICE_MAX_TRAFFIC_CLASS);
+	u32 num_vsis;
 	u32 agg_id;
 	enum ice_agg_type agg_type;
 	/* bw_t_info saves aggregator BW information */
diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index bcfc9db69e17..08d0f685f6c4 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -823,8 +823,10 @@ void ice_sched_clear_agg(struct ice_hw *hw)
 					 &agg_info->agg_vsi_list, list_entry) {
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(hw), agg_vsi_info);
+			agg_info->num_vsis--;
 		}
 		xa_erase(&hw->agg_nodes, index);
+		WARN_ON(agg_info->num_vsis > 0);
 		devm_kfree(ice_hw_to_dev(hw), agg_info);
 	}
 }
@@ -2072,6 +2074,7 @@ static void ice_sched_rm_agg_vsi_info(struct ice_port_info *pi, u16 vsi_handle)
 				list_del(&agg_vsi_info->list_entry);
 				devm_kfree(ice_hw_to_dev(pi->hw),
 					   agg_vsi_info);
+				agg_info->num_vsis--;
 				return;
 			}
 	}
@@ -2473,6 +2476,7 @@ ice_move_all_vsi_to_dflt_agg(struct ice_port_info *pi,
 		if (rm_vsi_info && !agg_vsi_info->tc_bitmap[0]) {
 			list_del(&agg_vsi_info->list_entry);
 			devm_kfree(ice_hw_to_dev(pi->hw), agg_vsi_info);
+			agg_info->num_vsis--;
 		}
 	}
 
@@ -2728,6 +2732,7 @@ ice_sched_cfg_agg(struct ice_port_info *pi, u32 agg_id,
 
 		/* Initialize the aggregator VSI list head */
 		INIT_LIST_HEAD(&agg_info->agg_vsi_list);
+		agg_info->num_vsis = 0;
 
 		/* Add new entry in aggregator array */
 		status = xa_insert(&hw->agg_nodes, agg_id, agg_info,
@@ -2915,6 +2920,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 		/* add VSI ID into the aggregator list */
 		agg_vsi_info->vsi_handle = vsi_handle;
 		list_add(&agg_vsi_info->list_entry, &agg_info->agg_vsi_list);
+		agg_info->num_vsis++;
 	}
 	/* Move VSI node to new aggregator node for requested TC(s) */
 	ice_for_each_traffic_class(tc) {
@@ -2933,6 +2939,7 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 	if (old_agg_vsi_info && !old_agg_vsi_info->tc_bitmap[0]) {
 		list_del(&old_agg_vsi_info->list_entry);
 		devm_kfree(ice_hw_to_dev(pi->hw), old_agg_vsi_info);
+		old_agg_info->num_vsis--;
 	}
 	return status;
 }

-- 
2.56.0.rc0.395.gd1f3524e15dc

