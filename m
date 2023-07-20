Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7A6EB64DA
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Jul 2023 12:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED4EE8121D;
	Thu, 20 Jul 2023 12:21:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED4EE8121D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689855715;
	bh=lzb9xgHW7a1zVVlYJ6SXBfsA6rtZcLiLrgubF56FOec=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=RQowydDqjBb7o0HL7jpRhEfpZbAF6iInIrO/gHlg6JqY8kRKWsCyMDGhKRU4Wc3ug
	 XwQMeKP8iO9s8Z6BCQRRDCsuSRGC6QF3rxygva7j0gBMRAWdUhI2pLLDjf7GwjZtJW
	 B9IkOtYdBHSVZHQ6AWCMrcPC2Di6ba861Vkrqecs//GQRWbBxRwii33Zk+5PEwggvZ
	 itaV2BQc+uXcIAvn04CNhzlERvTjQx//l9gPwN/fVdP5zzavurdZxtdGPRyR93xC9/
	 Y+RdE+/uVb/5pUgIc9AafIU5eMZ7HCFNgYyzrKt3fuLE2Or/1skWdfjtgHgrmC94pw
	 WT7pwC8GOZHBQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vcWWWdlqqei8; Thu, 20 Jul 2023 12:21:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFB9981F7D;
	Thu, 20 Jul 2023 12:21:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DFB9981F7D
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 059B31BF36E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Jul 2023 12:21:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 618E6417AF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Jul 2023 12:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 618E6417AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SFQ8QRZVFq8S for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Jul 2023 12:21:46 +0000 (UTC)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E29D41B98
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Jul 2023 12:21:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E29D41B98
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="366742990"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; d="scan'208";a="366742990"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2023 05:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="718368016"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; d="scan'208";a="718368016"
Received: from mmichali-devpc.igk.intel.com ([10.211.235.239])
 by orsmga007.jf.intel.com with ESMTP; 20 Jul 2023 05:14:20 -0700
From: Michal Michalik <michal.michalik@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 20 Jul 2023 14:13:56 +0200
Message-Id: <20230720121357.26739-3-michal.michalik@intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20230720121357.26739-1-michal.michalik@intel.com>
References: <20230720121357.26739-1-michal.michalik@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689855706; x=1721391706;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references;
 bh=Bvz7a9ISuLKyUY7GHVUMsJVxpxijKWoAn6sAxRT4Z98=;
 b=YvIYS3oUZQ/4+lPtyu1FC5nmYZFigX/kDDM7HnjimxkZcWUuIP/M6q2J
 iUizcHPN6V+C0i4wm3htgkaHkb2XMRGAdCdTyyl9/NkfbBdOKP5ps7pxv
 Ems7nvAL7Abkw7nJ0ZpboKmxXZY24OG6RIqOc3R7d4TEY8Zwe95dUI6A9
 NBiM4lJJRaCNyFWnocNPkUEqaQDR2i7lOJH48mus5Yx4Vp6TTe15/twfi
 V98ar8MZCu8OIEoNNi4/BvLcDGMKI4slOLAyjAU+k3rpJOm0vGeX0JpMy
 2958d/eSmOdhJ+H9ZaDjFcIo8qJiWitmQpJiysBeo0NUNLBVcuFSfns6l
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=YvIYS3oU
Subject: [Intel-wired-lan] [PATCH net-next v1 2/3] ice: Use PTP auxbus for
 all PHYs restart in E822
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
Cc: karol.kolacinski@intel.com, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The E822 (and other devices based on the same PHY) is having issue while
setting the PHC timer - the PHY timers are drifting from the PHC. After
such a set all PHYs need to be restarted and resynchronised - do it
using auxiliary bus.

Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Michal Michalik <michal.michalik@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9a2cd038..7fced6e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1491,6 +1491,24 @@ static void ice_ptp_reset_phy_timestamping(struct ice_pf *pf)
 }
 
 /**
+ * ice_ptp_restart_all_phy - Restart all PHYs to recalibrate timestamping
+ * @pf: Board private structure
+ */
+static void ice_ptp_restart_all_phy(struct ice_pf *pf)
+{
+	struct list_head *entry;
+
+	list_for_each(entry, &pf->ptp.ports_owner.ports) {
+		struct ice_ptp_port *port = list_entry(entry,
+						       struct ice_ptp_port,
+						       list_member);
+
+		if (port->link_up)
+			ice_ptp_port_phy_restart(port);
+	}
+}
+
+/**
  * ice_ptp_adjfine - Adjust clock increment rate
  * @info: the driver's PTP info structure
  * @scaled_ppm: Parts per million with 16-bit fractional field
@@ -1927,9 +1945,9 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	/* Reenable periodic outputs */
 	ice_ptp_enable_all_clkout(pf);
 
-	/* Recalibrate and re-enable timestamp block */
-	if (pf->ptp.port.link_up)
-		ice_ptp_port_phy_restart(&pf->ptp.port);
+	/* Recalibrate and re-enable timestamp blocks for E822/E823 */
+	if (!ice_is_e810(hw))
+		ice_ptp_restart_all_phy(pf);
 exit:
 	if (err) {
 		dev_err(ice_pf_to_dev(pf), "PTP failed to set time %d\n", err);
-- 
2.9.5

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
