Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD663EE4996
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Aug 2023 12:41:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8859660A91;
	Tue, 22 Aug 2023 12:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8859660A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692708094;
	bh=sLZJYsFm0qTvDRtpuLncgQDHTtbmxUOKO0L6vHH6W4Q=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GVnCtuYQCjY0Bs8TO0aTH2EOYknU8B5JWWDkjylWgXWmsg0+mgxGLuXNfC4lSdKZf
	 oQKqaJ9Y89eskQ6Qmd7NZBDWMpK1n2T9tV2bPpVJC2R1EuI62lXAyEtl3ffKBdOYsx
	 lusQPqm2jSLl+4sVnuXeSp3m4UCOrkHgApGFeV6o/SPrjWF1ZQdv1w4GAr7jZNyHiR
	 zEY1q7eHiGMVyjMvIOybxzmzCE9cMvsyCVpdKhgqCZsR1hbVadtaALXYSKpr/HOWTH
	 WU2Hqm+5xROeHDGcSyP7VIs6XDoZEJ4OAs7OoR+62XU3DZEAXS0mk3yCWc02j2gDmI
	 jibPiTnP381bw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BWR6Rlez3olx; Tue, 22 Aug 2023 12:41:33 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8480B611B7;
	Tue, 22 Aug 2023 12:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8480B611B7
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 80EE31BF296
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 12:41:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 66A83611F3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 12:41:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66A83611F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TGvGEEm_r4Xc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Aug 2023 12:41:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 947AE611E4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Aug 2023 12:41:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 947AE611E4
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="376604636"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; d="scan'208";a="376604636"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 05:41:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="771342962"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; d="scan'208";a="771342962"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by orsmga001.jf.intel.com with ESMTP; 22 Aug 2023 05:41:11 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 22 Aug 2023 14:40:42 +0200
Message-Id: <20230822124044.301654-8-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822124044.301654-1-karol.kolacinski@intel.com>
References: <20230822124044.301654-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692708073; x=1724244073;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bYKUU/xj0QxXFQ63kzSKlbFuP+Ql4C41o4hOcu7twBo=;
 b=MAJrhH5wy8Rse0F3ebxH/C+tGcFKLqmJpqpF/dYqLaiGabPraN1aPA48
 pr3lURWwP95xyQep9Ckk8f0foT2l920kDJwxfCV+VP1Z6xA/I5g66E739
 ifq6tQuj/Brh/I12KzQXozuBNwyYBDJH9enCCmPXlAKgNQQTbGxJbNtpd
 Z+lGuOybuTPsVSEybHBv5UKCdrC7y3W5MAbRCYfL1YiDNUoGxHnpK49ck
 C2IAtJivZSGYL2Kr+9RRX9F0SJsbKV1/lVawJTtQzR+T3m6zNJO7Juj7t
 vqocXyErQwXWojbf8pHkC2nG35hpD/crjd83K13vGjJHjOZfY6OPh20na
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MAJrhH5w
Subject: [Intel-wired-lan] [PATCH v3 iwl-next 7/9] ice: modify tstamp_config
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com
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
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 120d47356830..dac77bff4d20 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -307,8 +307,6 @@ static void ice_set_tx_tstamp(struct ice_pf *pf, bool on)
 {
 	if (pf->ptp.tx_interrupt_mode == ICE_PTP_TX_INTERRUPT_SELF)
 		ice_ptp_cfg_tx_interrupt(pf, on);
-
-	pf->ptp.tstamp_config.tx_type = on ? HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
 }
 
 /**
@@ -331,9 +329,6 @@ static void ice_set_rx_tstamp(struct ice_pf *pf, bool on)
 			continue;
 		vsi->rx_rings[i]->ptp_rx = on;
 	}
-
-	pf->ptp.tstamp_config.rx_filter = on ? HWTSTAMP_FILTER_ALL :
-					       HWTSTAMP_FILTER_NONE;
 }
 
 /**
@@ -2054,9 +2049,11 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
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
@@ -2065,6 +2062,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	switch (config->rx_filter) {
 	case HWTSTAMP_FILTER_NONE:
 		ice_set_rx_tstamp(pf, false);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_NONE;
 		break;
 	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
@@ -2081,6 +2079,7 @@ ice_ptp_set_timestamp_mode(struct ice_pf *pf, struct hwtstamp_config *config)
 	case HWTSTAMP_FILTER_NTP_ALL:
 	case HWTSTAMP_FILTER_ALL:
 		ice_set_rx_tstamp(pf, true);
+		pf->ptp.tstamp_config.rx_filter = HWTSTAMP_FILTER_ALL;
 		break;
 	default:
 		return -ERANGE;
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
