Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1B3C54EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Jan 2023 06:21:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35DEB416E5;
	Fri, 13 Jan 2023 06:21:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35DEB416E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1673590880;
	bh=a8ePNdj/lxYaIaKhQsr4s0WtZY/kB0cXV5anfFT7/6Y=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XRpHBVzPFdsu01sQkRtn/jgo1CBDH68jWFdKMTJ730A+4w+243F8fZJRmuL3ynz5W
	 TtJmtdeP9C9fHauk3lUstoIqYzAtCOiqX2ejdcxhmm6bkvntXRR6i1aGUajayoOQdp
	 PV4g6Dj0PkHPwU1nC+lK1lfixnSQumMQCx2yVtles2y08HiVOqEtbZ59RpnhV6k8Or
	 m6WWOag1+xnpmqksz+vSV9U/CEf8JEy8M88cmV126FhZ0Xaw5oP4/S4dDAFCMwdx3C
	 1OznVPfec1RwGDWA/vSu0jdL3BbCv1R2z+Fe0Rlv19inGYnEQdytWEp4HU3fUlLNx4
	 K00U7j02NO7Fw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGHiJ_yTSLux; Fri, 13 Jan 2023 06:21:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id E245F417B9;
	Fri, 13 Jan 2023 06:21:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E245F417B9
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id D178C1BF83B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 06:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A95AB60F35
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 06:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A95AB60F35
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fqi6RLWfRwLL for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Jan 2023 06:21:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE63660F1C
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE63660F1C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Jan 2023 06:21:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="321624032"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; d="scan'208";a="321624032"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2023 22:21:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="986881407"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; d="scan'208";a="986881407"
Received: from wasp.igk.intel.com ([10.102.20.192])
 by fmsmga005.fm.intel.com with ESMTP; 12 Jan 2023 22:21:09 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Fri, 13 Jan 2023 07:05:19 +0100
Message-Id: <20230113060519.194217-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673590876; x=1705126876;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RoAfhN9z2YmemrLntCyV3keOPUJqieA9r91HpOuKtjo=;
 b=QtWjqYbo4DpVhASML3sZXSdofBVqQ/piJdcyUJ0eo/J07VO/E0QrrAmO
 0A38qWmrvzezIQRPO35j/91dgbtGlJC5GfQLfHs3tP1tB2A+rr1XxPV4r
 BEZKQqn8q99mVwYF0R25K9md3ktTJtSKkpb3G+XmmU2d7JqKcVTOpXOAd
 6Og4YU4bsSc5dYPjHbWeiEcPJgEIxN5U4/JBTwQPBePK5667sFRtXZLxX
 rcEHE37DWGiVfZojkdqYn5AqK6/NAnGiC4w2W8r4tnvuLVKZeOuVSgr/F
 pzNB5V5iEC+T++9E9tu877PIU08tb5H7NPVeX7wUc58ewGzDdPguKSIEe
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=QtWjqYbo
Subject: [Intel-wired-lan] [PATCH net v2] ice: double lock on adev_mutex
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

Call trace:
ice_set_channel() --> mutex_lock(adev_mutex)
ice_vsi_recfg_qs()
ice_pf_dcb_recfg()
ice_send_event_to_aux() --> another mutex_lock(adev_mutex)

This call trace is reached when user try to change queues amount using
ethtool:
$ ethtool -L enp24s0f0np0 tx 64 rx 32

Avoid double lock by unlocking after checking if RDMA is active.

Fixes: a49a2713f00e ("ice: Prevent set_channel from changing queues while RDMA active")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Dave Ertman <david.m.ertman@intel.com>
---
v1 --> v2:
 * As mutex_unlock happens before other error handling there is no need
 to have ret variable, remove it

To be squash with:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20221219181803.1060129-1-david.m.ertman@intel.com/
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 263d59929602..936f0e0c553d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3662,7 +3662,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	u32 curr_combined;
-	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
 	if (ice_is_safe_mode(pf)) {
@@ -3729,23 +3728,20 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	mutex_lock(&pf->adev_mutex);
 	if (pf->adev && pf->adev->dev.driver) {
 		netdev_err(dev, "Cannot change channels when RDMA is active\n");
-		ret = -EINVAL;
-		goto adev_unlock;
+		mutex_unlock(&pf->adev_mutex);
+		return -EINVAL;
 	}
+	mutex_unlock(&pf->adev_mutex);
 
 	ice_vsi_recfg_qs(vsi, new_rx, new_tx);
 
-	if (!netif_is_rxfh_configured(dev)) {
-		ret = ice_vsi_set_dflt_rss_lut(vsi, new_rx);
-		goto adev_unlock;
-	}
+	if (!netif_is_rxfh_configured(dev))
+		return ice_vsi_set_dflt_rss_lut(vsi, new_rx);
 
 	/* Update rss_size due to change in Rx queues */
 	vsi->rss_size = ice_get_valid_rss_size(&pf->hw, new_rx);
 
-adev_unlock:
-	mutex_unlock(&pf->adev_mutex);
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.36.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
