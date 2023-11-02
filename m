Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242A2C4167D
	for <intel-wired-lan@archiver.kernel.org>; Thu,  2 Nov 2023 15:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B2B9A81FB3;
	Thu,  2 Nov 2023 15:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B2B9A81FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698940578;
	bh=d7/rjVDBdGyhkeVYb9WqeE4bhTXjigNnsOrRnnGIHq0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=8i/aee+FDJ4g6R7IGVlq62jLioWf3m7BDF8yZG2rq1CLEDLfPqURldHxzaR6Qee0r
	 3Ywfe8e4GaB1lYCBiKsTqqjHiTogvihNCBmRG70ombSQoWrPVMU42gxVit7sLs799G
	 70bSJGuyVafWfXukqaLqJ7FhS2TnGQSn/pbyQdVOP48ca7c+FG+CSv510Lia0NOILx
	 CaJuJrG4QpIHFiHtara21/gsPmsPeiXS+3Al1efiboaoF+/ItGFRCVCrmF/r2IOYCY
	 jKX3Y+2tSla1mzAYWWxPu0PUPJJyyjsufF4ng9m1IcJE2z8Oe0B2NLiIs2jH0gAKNw
	 ahXITLDP7BfVg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7fYEtXLiuzTb; Thu,  2 Nov 2023 15:56:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96CD781FD6;
	Thu,  2 Nov 2023 15:56:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96CD781FD6
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 293E81BF20D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Nov 2023 15:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 003756106A
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Nov 2023 15:56:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 003756106A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BqLbxlbmcXmK for <intel-wired-lan@lists.osuosl.org>;
 Thu,  2 Nov 2023 15:56:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE3B170708
 for <intel-wired-lan@lists.osuosl.org>; Thu,  2 Nov 2023 15:56:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE3B170708
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="388559552"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; d="scan'208";a="388559552"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 08:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="796278345"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; d="scan'208";a="796278345"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by orsmga001.jf.intel.com with ESMTP; 02 Nov 2023 08:55:41 -0700
Received: from baltimore.igk.intel.com (baltimore.igk.intel.com [10.102.21.1])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 106FF122E3;
 Thu,  2 Nov 2023 15:55:40 +0000 (GMT)
From: Pawel Chmielewski <pawel.chmielewski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu,  2 Nov 2023 16:51:49 +0100
Message-Id: <20231102155149.2574209-1-pawel.chmielewski@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698940568; x=1730476568;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/HOS4o57OIc05Uh+PE17GQ53W44y+VwquMnvqen8CPw=;
 b=cgroF5RluwYo7s1GBIjUw2oidNHAWLP8gdbV428MKByq7d5BFk78QbR+
 kCuCVDLA0tXyeXwbIK9Zw94iD+/yZZiDGZTcPNk5lDOc7mJonm2dTmGCv
 M+jgWrA2r4JRK5xGgzn9VE9A2M3N+KRGmD6ku63fxI0P8OmjM/1aeKR2I
 T/0GOi8/gm0M7UD4AYND3DdCBLLKSLwoRA/BRH6isDmz7gXrNKh6zJy9F
 27XQgdW3qDvMemV9/+XfaDXFEi/2fTXfBT5BgQLs+i5JPEaKqhj+GUtgt
 puKZaD51TpoThiQrEXz/de6iqXRLCMv0dHlvHAhjRsEk4n8ss/ECBr7So
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=cgroF5Rl
Subject: [Intel-wired-lan] [PATCH iwl-next v2] ice: Reset VF on Tx MDD event
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, lukasz.czapnik@intel.com,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Liang-Min Wang <liang-min.wang@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Liang-Min Wang <liang-min.wang@intel.com>

In cases when VF sends malformed packets that are classified as malicious,
sometimes it causes Tx queue to freeze. This frozen queue can be stuck
for several minutes being unusable. This behavior can be reproduced with
DPDK application, testpmd.

When Malicious Driver Detection event occurs, perform graceful VF reset
to quickly bring VF back to operational state. Add a log message to
notify about the cause of the reset.

Signed-off-by: Liang-Min Wang <liang-min.wang@intel.com>
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
Changelog
v1->v2:
Reverted unneeded formatting change, fixed commit message, fixed a log
message with a correct event name.
---

 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3c9419b05a2a..ee9752af6397 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1839,6 +1839,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_TCLAN detected on VF %d\n",
 					 vf->vf_id);
+			dev_info(dev,
+				 "PF-to-VF reset on VF %d due to Tx MDD TX_TCLAN event\n",
+				 vf->vf_id);
+			ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 		}
 
 		reg = rd32(hw, VP_MDET_TX_TDPU(vf->vf_id));
@@ -1849,6 +1853,10 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 			if (netif_msg_tx_err(pf))
 				dev_info(dev, "Malicious Driver Detection event TX_TDPU detected on VF %d\n",
 					 vf->vf_id);
+			dev_info(dev,
+				 "PF-to-VF reset on VF %d due to Tx MDD TX_TDPU event\n",
+				 vf->vf_id);
+			ice_reset_vf(vf, ICE_VF_RESET_NOTIFY);
 		}
 
 		reg = rd32(hw, VP_MDET_RX(vf->vf_id));
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
