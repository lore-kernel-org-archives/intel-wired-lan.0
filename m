Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8449C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Nov 2023 13:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A31540C1C;
	Tue,  7 Nov 2023 13:52:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A31540C1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1699365169;
	bh=5l7nOw+M4psFnelIbV/InA9LumIJlFmYzREeEW1CMWY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=BcKD37kI+lh7xV1PXvd3wZz0p98nIe7mAH527F1ctf62qW1NHkLvcOXIMGqVr7+Tk
	 z+JB9/0gk65L01rIL5Jod1E4+fnvtzVU0ZZR8PMiM1glvJNoiCzZDo7BxqRytIuo6O
	 LOYcCs7OQghaDCK8iRVm6RVwnLYCuXLO8ChurYRfwXUB6fwgJgqlrXmKy2+juP/nmA
	 DPvl0uFfnpy3P0RNOFF7aCVsIDSADVIDGSWWogcHH2i3JQbNB002a97m/6swbwmzvt
	 TfCioOM9qXw0y7SUY4Ag4lVsqVzo+bktzs04sZ/feaL7ZH+oYheXjbI1grZTvO3GaI
	 XwsdUH3CTRVww==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9AslO4TRV3i7; Tue,  7 Nov 2023 13:52:48 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id EAB1C41468;
	Tue,  7 Nov 2023 13:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EAB1C41468
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 4FA451BF319
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Nov 2023 13:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22DB941468
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Nov 2023 13:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22DB941468
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EY7bxR79E_Fn for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Nov 2023 13:52:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 191B240C1C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Nov 2023 13:52:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 191B240C1C
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="8160086"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; 
   d="scan'208";a="8160086"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 05:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="712570090"
X-IronPort-AV: E=Sophos;i="6.03,283,1694761200"; d="scan'208";a="712570090"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga003.jf.intel.com with ESMTP; 07 Nov 2023 05:52:42 -0800
Received: from giewont.igk.intel.com (giewont.igk.intel.com [10.211.8.15])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 385921258E;
 Tue,  7 Nov 2023 13:52:39 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  7 Nov 2023 14:51:38 +0100
Message-Id: <20231107135138.10692-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699365165; x=1730901165;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=O7mugTy0WMD+sPBXu0JncizMt0uI+MNJ0XrfSzj4VFg=;
 b=X40FUekzGaO1l/N2VOJaMIURG/1vRg1oAH/hKg0YXCk/w6fM1r3CG/Tj
 dTEiz5zJ6Z3lMl88XQ0cE72FZ83Kk0aBaD/4w3f7wQY52Bi31PnYOfzrX
 KU5PxLrJEeqSDYtZv5chzDIHCwZg+XgVA9p6pb0b2J5lEsTqAW0XvJL4s
 eWJEYMAZXzpSQNYe2Q+PQDr51kdTl2qyUooV5j5F+BW7AMDSIOQ4DYKm8
 +uKlugIYzmzw4KUQJWvixkq3Mb+ue2CmbqauJZKth5vtejpBNGK8X1tez
 /b425yEvCteCC89lGL/+D0D4jQb+X5rMBBczgBklg23o0DX4t262UBi2Q
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=X40FUekz
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Restore fix disabling RX
 VLAN filtering
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
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Fix setting dis_rx_filtering depending on whether port vlan is being
turned on or off. This was originally fixed in commit c793f8ea15e3 ("ice:
Fix disabling Rx VLAN filtering with port VLAN enabled"), but while
refactoring ice_vf_vsi_init_vlan_ops(), the fix has been lost. Restore the
fix along with the original comment from that change.

Also delete duplicate lines in ice_port_vlan_on().

Fixes: 2946204b3fa8 ("ice: implement bridge port vlan")
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
index d7b10dc67f03..80dc4bcdd3a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_vsi_vlan_ops.c
@@ -32,7 +32,6 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
 		/* setup outer VLAN ops */
 		vlan_ops->set_port_vlan = ice_vsi_set_outer_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_outer_port_vlan;
 
 		/* setup inner VLAN ops */
 		vlan_ops = &vsi->inner_vlan_ops;
@@ -47,8 +46,13 @@ static void ice_port_vlan_on(struct ice_vsi *vsi)
 
 		vlan_ops->set_port_vlan = ice_vsi_set_inner_port_vlan;
 		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
-		vlan_ops->clear_port_vlan = ice_vsi_clear_inner_port_vlan;
 	}
+
+	/* all Rx traffic should be in the domain of the assigned port VLAN,
+	 * so prevent disabling Rx VLAN filtering
+	 */
+	vlan_ops->dis_rx_filtering = noop_vlan;
+
 	vlan_ops->ena_rx_filtering = ice_vsi_ena_rx_vlan_filtering;
 }
 
@@ -77,6 +81,8 @@ static void ice_port_vlan_off(struct ice_vsi *vsi)
 		vlan_ops->del_vlan = ice_vsi_del_vlan;
 	}
 
+	vlan_ops->dis_rx_filtering = ice_vsi_dis_rx_vlan_filtering;
+
 	if (!test_bit(ICE_FLAG_VF_VLAN_PRUNING, pf->flags))
 		vlan_ops->ena_rx_filtering = noop_vlan;
 	else
@@ -141,7 +147,6 @@ void ice_vf_vsi_init_vlan_ops(struct ice_vsi *vsi)
 		&vsi->outer_vlan_ops : &vsi->inner_vlan_ops;
 
 	vlan_ops->add_vlan = ice_vsi_add_vlan;
-	vlan_ops->dis_rx_filtering = ice_vsi_dis_rx_vlan_filtering;
 	vlan_ops->ena_tx_filtering = ice_vsi_ena_tx_vlan_filtering;
 	vlan_ops->dis_tx_filtering = ice_vsi_dis_tx_vlan_filtering;
 }
-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
