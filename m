Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D4DC07545
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Oct 2023 12:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CABE64362F;
	Wed, 25 Oct 2023 12:16:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CABE64362F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1698236211;
	bh=3si3W16ZRZP6YEbdmQopdn8Meq6jZO8dKNMXxYShCAo=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=phT3+CGhvF1lOQdHw8qvdUjd06kRpfBqNMuEqVYNyc3i4jZJ7vKQtgKV046uZ4o+3
	 YkBvweBW0BDY6ZVqqF6kdDu8nvlEGOkkQklVzkCMxOhDiOZ3UP2HRfxIQO30ef/dyQ
	 HQBHFtMA2+9THOkDhlN9Hc7vnub3g44w70PwSjofSBVXc8V8NqMWuVSe1L6Hfo6dhH
	 mZaZ1hD+AX2VzE2+64/FUcNnRphbo0/IjZw6y7lE/uSvi0rF4qVhO6Z/eaiW/GhAsW
	 17xyvWPDri8noJBilWWx39epYYuiXfJvm0p8ZriExxXjUMd7IQDKai44Y4p1prg/TB
	 5AvYdX84MRVMg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I_9LSMOk4nSL; Wed, 25 Oct 2023 12:16:51 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA61543309;
	Wed, 25 Oct 2023 12:16:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA61543309
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 2AEB91BF48B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 12:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 044E984CD1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 12:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 044E984CD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MADJFO8wlUIP for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Oct 2023 12:16:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B44284988
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Oct 2023 12:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B44284988
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="418414356"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; d="scan'208";a="418414356"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2023 05:16:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="824627935"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; d="scan'208";a="824627935"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2023 05:16:11 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 25 Oct 2023 14:13:28 +0200
Message-Id: <20231025121330.216300-9-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025121330.216300-1-karol.kolacinski@intel.com>
References: <20231025121330.216300-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698236173; x=1729772173;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pHodra5qvkf5TU15nDHtcCG3qKXX4KLnq3R6Q/jjhfU=;
 b=Z1YHHc0fczfOqDDSvxethFRvfptQIiKEQhjmthS1lOzsarpZyJQN5y8H
 RG6oy3z/XNP+rdjX88xbb/ZugK+jyqGo9faF8Y1KTeBERHAV6FGJk2Mcj
 NuMhdh6SsKsJsKv51krrdl3Mm8FaME2dhegSOTAwi8HY8kLu3E4hK0RYc
 8k724kagq9AzgSzNDdnuef5ZeTyLs7fgzjuGL8pMxN+P5LOg2gfSyhYlP
 AORf2cMazlTkZ93hfrb7gzq5Q1u9XbQrQ1MzWa2hF6wEB7wh48lsnH85y
 4okZQrjxFRBRWm5VT3as4vQxr37S0rvisjv9EN80WUy9FUPTmFHXuthFx
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Z1YHHc0f
Subject: [Intel-wired-lan] [PATCH iwl-next 08/10] ice: modify tstamp_config
 only during TS mode set
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
Cc: Jacob Keller <jacob.e.keller@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>, anthony.l.nguyen@intel.com,
 jesse.brandeburg@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The driver stores the current Tx and Rx timestamping configuration in
pf->ptp.tstamp_config. This structure is supposed to represent the
currently requested configuration from userspace that we've applied to
the device.

The values of this structure are modified within the low level
ice_set_tx_tstamp() and ice_set_rx_tstamp() functions. These functions
*are* called by ice_ptp_set_timestamp_mode. However, they are also
called during the driver reset and rebuild flow. Because of this, the
driver overwrites user configuration during reset, preventing itself
from being able to properly restore the configuration after a reset.

Instead, stop modifying this saved configuration state outside of
ice_ptp_set_timestamp_mode. Instead, set the values directly within this
function. This avoids losing the configuration data.

A following change will refactor the rebuild flow to properly restore
the configuration after a PF reset.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 321b127bfbc1..e203cf775b76 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -282,8 +282,6 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 {
 	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
 		ice_ptp_cfg_tx_interrupt(pf, on);
-
-	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 }
 
 /**
@@ -306,9 +304,6 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
 			continue;
 		vsi->rx_rings[i]->ptp_rx = on;
 	}
-
-	pf->ptp.tstamp_config.rx_filter = on ? HWTSTAMP_FILTER_ALL :
-					       HWTSTAMP_FILTER_NONE;
 }
 
 /**
@@ -2029,9 +2024,11 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		ice_set_tx_tstamp(pf, false);
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_OFF;
 		break;
 	case HWTSTAMP_TX_ON:
 		ice_set_tx_tstamp(pf, true);
+		pf->ptp.tstamp_config.tx_type = HWTSTAMP_TX_ON;
 		break;
 	default:
 		return -ERANGE;
@@ -2040,6 +2037,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ice_set_rx_tstamp(pf, false);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
@@ -2056,6 +2054,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	case HWTSTAMP_FILTER_NTP_ALL:
 	case HWTSTAMP_FILTER_ALL:
 		ice_set_rx_tstamp(pf, true);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
-- 
2.40.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
