Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC91ECA0FFA
	for <intel-wired-lan@archiver.kernel.org>; Tue,  5 Sep 2023 18:08:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9154D40245;
	Tue,  5 Sep 2023 18:08:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9154D40245
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693937338;
	bh=LmVMLN6jNt+BadUZYe4x3nUFBx96JjQW7V7jAADNVbA=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9ualBRY+OznmjcZCjAGiT+sPZONcPlNP+cBpoZkX0Ahp1LD5KPavz1ngEz8mUD//O
	 MFo/9gRCN5y/ZV/vKDEKLiYrFtp3aj6OagTkkZiUx67miAs/oxXy6KzHcAMzEmjqqh
	 LX+ckv4xJ6RSvzULPlXTH3B3LJ3Hjk4t836GgnIq+0126Qx2IO9G1jZFaYM9PnPdG6
	 b1CpLBdD0QnCrkOGosXhW7hy+Vq/ypPa9a6QXcje1kVG8vXRFncvursnGxqEH24D+V
	 6hBzMaDl3nvSm8i7bjViAEclemqbzAgvQae3j1VKkEoGmGJPcIFvE66wg9clUD03Yn
	 Br/C3LEGEUpYw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KCSSe29k_Z7a; Tue,  5 Sep 2023 18:08:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4665941886;
	Tue,  5 Sep 2023 18:08:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4665941886
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 157601BF318
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Sep 2023 18:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0AA9812A7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Sep 2023 18:08:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0AA9812A7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kkVU9yLyTopj for <intel-wired-lan@lists.osuosl.org>;
 Tue,  5 Sep 2023 18:08:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 94C888128D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  5 Sep 2023 18:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94C888128D
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375766545"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; d="scan'208";a="375766545"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 11:08:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806707347"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; d="scan'208";a="806707347"
Received: from nsnaveen-mobl.gar.corp.intel.com (HELO azaki-desk1.intel.com)
 ([10.252.34.119])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Sep 2023 11:08:46 -0700
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  5 Sep 2023 12:08:35 -0600
Message-Id: <20230905180837.3611383-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905180837.3611383-1-ahmed.zaki@intel.com>
References: <20230905180837.3611383-1-ahmed.zaki@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693937328; x=1725473328;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iKr+xE5/2U5HY6zZrcqfyy4GngTAuhfy1gLhkoXGx7E=;
 b=CuLL/ZI7rqJM3mMmYD8lTa2+U8/Jcov+VnfOn9g9o/X5+W6t3v10Fs31
 IPvS3gIxgnscWVotyRNZg3uj+YX7jIJr2dT0tR0LarfaAemqvPBrNCWf7
 hggo9xFxKBlfdoZryaMTNYSXnGdNRP21gZMDpVynDxDVG5NnmhKzgz/Oe
 rI4ZFvnsIwI84Cn03oQiLhxz11jXfH+aOnk7Umtp999QWyIBdw52om5sG
 1srNl6ZmjKlx8BjUIk8nZTvX01aYcxJlgzoqTGaarIdY6AqLPVgN8RuW7
 b090Tbm6cBdnGcSkzxqpa1mWFWLR9ms98S+OIrd2e3QjM45r5lH08W9iI
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=CuLL/ZI7
Subject: [Intel-wired-lan] [PATCH iwl-next v5 2/4] ice: Support FCS/CRC
 strip disable for VF
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
Cc: Haiyue Wang <haiyue.wang@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Haiyue Wang <haiyue.wang@intel.com>

To support CRC strip enable/disable functionality, VF needs the explicit
request VIRTCHNL_VF_OFFLOAD_CRC offload. Then according to crc_disable
flag of Rx queue configuration information to set up the queue context.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b03426ac932b..c0c3e524c523 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -486,6 +486,9 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_REQ_QUEUES)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_REQ_QUEUES;
 
+	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_CRC)
+		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_CRC;
+
 	if (vf->driver_caps & VIRTCHNL_VF_CAP_ADV_LINK_SPEED)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_ADV_LINK_SPEED;
 
@@ -1666,6 +1669,18 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			vsi->rx_rings[i]->dma = qpi->rxq.dma_ring_addr;
 			vsi->rx_rings[i]->count = qpi->rxq.ring_len;
 
+			if (qpi->rxq.crc_disable &&
+			    !(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_CRC)) {
+				goto error_param;
+			}
+
+			if (qpi->rxq.crc_disable)
+				vsi->rx_rings[q_idx]->flags |=
+					ICE_RX_FLAGS_CRC_STRIP_DIS;
+			else
+				vsi->rx_rings[q_idx]->flags &=
+					~ICE_RX_FLAGS_CRC_STRIP_DIS;
+
 			if (qpi->rxq.databuffer_size != 0 &&
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
-- 
2.34.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
