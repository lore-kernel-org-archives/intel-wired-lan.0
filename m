Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2350D2AB0E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Oct 2024 09:51:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ECB960621;
	Tue, 29 Oct 2024 09:51:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7u7Q3-CYk7X; Tue, 29 Oct 2024 09:51:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB17760630
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1730195500;
	bh=dPj7icozTLRkgVYhh+m/5oCUyMO1KIjqehUqPHlcZgw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=7b+L99W1LQrNdRrowzLsgcBOUIiCcgKMptx//BV23704CYG+zVDvxJVzq2thB+gBm
	 BfyGgYgTfb8yhXf20JY3rxWum9qVERA+6J6ER7SKW/atigtemM9axFqEaRSvksQaRz
	 v6Me2fyqfz/q+Ek5+cy6K9ZI9/M+I9/26u96qjpO/1IInhD5t3mDotViiKIp2kt0ct
	 2iu2eEahSnbBZpok7QpTlU8AYzw12/xCeG5/P/PGFUxysj4A6AyMPDKcUAKy1Khk5F
	 VdWaammRpBif7QL9H4VzWYlGuCNLmpbm0KylQgDH368XcMHaO6BOGk4ZR5MIBdBjAU
	 7BVehYRX2qALg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB17760630;
	Tue, 29 Oct 2024 09:51:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BBDCAEE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Oct 2024 09:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C20E405A1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Oct 2024 09:51:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26ZnexPx_TGU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Oct 2024 09:51:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=wojciech.drewek@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2B456405D6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B456405D6
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B456405D6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Oct 2024 09:51:37 +0000 (UTC)
X-CSE-ConnectionGUID: 2hEaumuISkOdzgfF3Oh9XA==
X-CSE-MsgGUID: NCZU0PrGRym//tV3Pn2pdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33523477"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="33523477"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2024 02:51:38 -0700
X-CSE-ConnectionGUID: 1WE0v/03TCW7uxcINi9mow==
X-CSE-MsgGUID: j62VbXldQsuDHASkKtEdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; d="scan'208";a="87036796"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orviesa004.jf.intel.com with ESMTP; 29 Oct 2024 02:51:36 -0700
Received: from os-delivery.igk.intel.com (unknown [10.123.220.34])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id A824C27BC4;
 Tue, 29 Oct 2024 09:51:35 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Tue, 29 Oct 2024 10:42:59 +0100
Message-Id: <20241029094259.77738-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730195499; x=1761731499;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LWcVgKbdjdNQE5gW0KATWpKMbLMhrYuych0y7SeJhe8=;
 b=h9/0VNeT4zbc0cuRd4GZ/0wQrbVafE5DfQZ2JJIvNYuLF20UBmb/rD0u
 8RjYlvbZDwvLebnv4SvnznpOfBYUj3OL9dXTWbm6JoHMPFLigHMwViIM/
 wzz5XspjZZ2NXnnBEH96nnHFPRmmTZriNCTx/96+gsukLHDOr1dACdWOF
 fg0C+Ytqr+BAOo3grAbWjX7vjAJt0dMVY/NsunmlQ2HTOVxLtKgjDdtWO
 YN7K8EkscMDarLsSA2CJDRQ9NivTH6F4mEYn/wse6L+ZroC9hgT1ua7l9
 DnL6kH8tQsq9AD0uWBKPhgDykMBF/EfRKSV8MugeExDw5PBXVD1CCuGbO
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=h9/0VNeT
Subject: [Intel-wired-lan] [PATCH net-next] ice: Fix NULL pointer
 dereference in switchdev
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

Commit ("virtchnl: support queue rate limit and quanta size
configuration") introduced new virtchnl ops:
- get_qos_caps
- cfg_q_bw
- cfg_q_quanta

New ops were added to ice_virtchnl_dflt_ops but not to the
ice_virtchnl_repr_ops. Because of that, if we get one of those
messages in switchdev mode we end up with NULL pointer dereference:

[ 1199.794701] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1199.794804] Workqueue: ice ice_service_task [ice]
[ 1199.794878] RIP: 0010:0x0
[ 1199.795027] Call Trace:
[ 1199.795033]  <TASK>
[ 1199.795039]  ? __die+0x20/0x70
[ 1199.795051]  ? page_fault_oops+0x140/0x520
[ 1199.795064]  ? exc_page_fault+0x7e/0x270
[ 1199.795074]  ? asm_exc_page_fault+0x22/0x30
[ 1199.795086]  ice_vc_process_vf_msg+0x6e5/0xd30 [ice]
[ 1199.795165]  __ice_clean_ctrlq+0x734/0x9d0 [ice]
[ 1199.795207]  ice_service_task+0xccf/0x12b0 [ice]
[ 1199.795248]  process_one_work+0x21a/0x620
[ 1199.795260]  worker_thread+0x18d/0x330
[ 1199.795269]  ? __pfx_worker_thread+0x10/0x10
[ 1199.795279]  kthread+0xec/0x120
[ 1199.795288]  ? __pfx_kthread+0x10/0x10
[ 1199.795296]  ret_from_fork+0x2d/0x50
[ 1199.795305]  ? __pfx_kthread+0x10/0x10
[ 1199.795312]  ret_from_fork_asm+0x1a/0x30
[ 1199.795323]  </TASK>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index f445e33b2028..ff4ad788d96a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -4128,6 +4128,9 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.get_qos_caps = ice_vc_get_qos_caps,
 	.cfg_q_bw = ice_vc_cfg_q_bw,
 	.cfg_q_quanta = ice_vc_cfg_q_quanta,
+	/* If you add a new op here please make sure to add it to
+	 * ice_virtchnl_repr_ops as well.
+	 */
 };
 
 /**
@@ -4258,6 +4261,9 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.dis_vlan_stripping_v2_msg = ice_vc_dis_vlan_stripping_v2_msg,
 	.ena_vlan_insertion_v2_msg = ice_vc_ena_vlan_insertion_v2_msg,
 	.dis_vlan_insertion_v2_msg = ice_vc_dis_vlan_insertion_v2_msg,
+	.get_qos_caps = ice_vc_get_qos_caps,
+	.cfg_q_bw = ice_vc_cfg_q_bw,
+	.cfg_q_quanta = ice_vc_cfg_q_quanta,
 };
 
 /**
-- 
2.39.3

