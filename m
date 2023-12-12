Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9AC4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 Dec 2023 09:31:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8ACAC614CC;
	Tue, 12 Dec 2023 09:31:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ACAC614CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702373491;
	bh=45easfGT0BGsKAG8vFgPBowjCQUFJfbKCDFTsoOIAyw=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=hw4EzXaqAS2SyFtmBZN7oD3ii3e3gY22/zMjJO5s/vMgV0kLB0fnzlwEZx/FOlPbn
	 9eGnMrwnEljptMhHHFs+O9hCDqM2mYSVV38pxnXob6O4UjEklnDSrK+tLrAedAktc5
	 DBpeutJZMf/6Dxbs6WJSaPop4W6gvleWDDe0wq1yNE+tPw8GO9coW92+AhetASfyXK
	 eF8v5JgI8q+kc/dU2SSHUXZ+6NGm04F7wxByP0nBmj2I/hivkcYELQSa12G3JiaJAB
	 C+p6jpCu/5SF10crIUtFvJsx3ExJlUR/TsrDi5CtVOyYp5OQeZbJWVrVE5eUj7X51g
	 ZyHmMxQhzgF2Q==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1PIm7AY-62dd; Tue, 12 Dec 2023 09:31:30 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9ECB0614B2;
	Tue, 12 Dec 2023 09:31:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ECB0614B2
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id BBC161BF28D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 09:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 919FB82564
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 09:31:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 919FB82564
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Te1nkd_bl001 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 Dec 2023 09:31:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4F51827BB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 Dec 2023 09:31:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4F51827BB
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374284920"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; d="scan'208";a="374284920"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2023 01:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="749645546"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; d="scan'208";a="749645546"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 01:31:18 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 153E533EA3;
 Tue, 12 Dec 2023 09:31:17 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 12 Dec 2023 10:29:01 +0100
Message-ID: <20231212092903.446491-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702373484; x=1733909484;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pjVxK9NlNyYS/SGjXdIPXAjSQ6EE+9PYePXN+hhqSxc=;
 b=B9CSQl4P26mv8IFIUOio5F/8scm//B3XXrIX0THtMIwUO6tOQRZZ2esM
 MnopSy273xM7pMD9mfywxR/h+GyQH0R7NQaC0jwvAI1IQcy1Z+zsaGPN4
 10lJtKzydLKHgMlSbGrjHP08BgokzyrZIp28toVRyt+halYak+NVhZAcr
 /QM5hX2Pj130AGzBTiEccMjpGyMjf59elm8KGpIGMorTWxFEkpyIByZ++
 MOtKovsgwgffMJ05QMyqxhOz66tspa11yxnoRb+OOifPNWZwWsKInIVo4
 HVkOBO+FNih2FPcZZyW0YOqWs1kBOFJHPg6grNrlRkLr95pMmPrpiSYau
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=B9CSQl4P
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: Fix PF with enabled XDP
 going no-carrier after reset
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
Cc: Larysa Zaremba <larysa.zaremba@intel.com>, netdev@vger.kernel.org,
 jesse.brandeburg@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
functions") has refactored a bunch of code involved in PFR. In this
process, TC queue number adjustment for XDP was lost. Bring it back.

Lack of such adjustment causes interface to go into no-carrier after a
reset, if XDP program is attached, with the following message:

ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
ice 0000:b1:00.0: PF VSI rebuild failed: -22
ice 0000:b1:00.0: Rebuild failed, unload and reload driver

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 626577c7d5b2..2b6ac37ae0b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2376,6 +2376,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 		} else {
 			max_txqs[i] = vsi->alloc_txq;
 		}
+
+		if (vsi->type == ICE_VSI_PF)
+			max_txqs[i] += vsi->num_xdp_txq;
 	}
 
 	dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
