Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F26C83F12
	for <intel-wired-lan@archiver.kernel.org>; Tue, 29 Aug 2023 10:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8B9660803;
	Tue, 29 Aug 2023 10:40:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B8B9660803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1693305658;
	bh=kqF1Gzm59elw9c32iUJC7f/rAJzI3DNbm3E2CZOKgnQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=5rRKNfyATY0btNeqAX0jD08Cixjnb5ykLf7dZN9CVRjgenTbKqrZncYciKUUs4h09
	 Q6wtDoGbAwgcyo7C3+Dqz66rdTJxfzZuFi6QDjV/inyBPWvL7xzSeHspi/YnoEYwdV
	 FVbZMY0nSv5DqXGeN9ju7aYE8fmbZ0o5nLD8AJ6DxFcsmiQex5NoeaWLbi9ziI//mg
	 lrjhH8WI9QesUIj7l5EurATJzSLsHLPukbxR7jWtKXU8iYRsQkuD5uvuMSkIFQ9VNF
	 NhWUBDxiuii0CNigqVEWsH2T2zDzJ+38gqcWO0RBxT3HIMVrcSmaGynSiXFWiWqAoc
	 ihLqjuBPk+XJA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eyXDLE1U0Uj0; Tue, 29 Aug 2023 10:40:58 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7A4160AE1;
	Tue, 29 Aug 2023 10:40:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7A4160AE1
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 805F61BF2CF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Aug 2023 10:40:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57AEA81501
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Aug 2023 10:40:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 57AEA81501
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lOtCnalX3kOz for <intel-wired-lan@lists.osuosl.org>;
 Tue, 29 Aug 2023 10:40:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B22EE81419
 for <intel-wired-lan@lists.osuosl.org>; Tue, 29 Aug 2023 10:40:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B22EE81419
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="461696869"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; d="scan'208";a="461696869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2023 03:40:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="853229745"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; d="scan'208";a="853229745"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 03:40:53 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 29 Aug 2023 12:40:30 +0200
Message-Id: <20230829104041.64131-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693305655; x=1724841655;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=38QVTwQDh3SArRq4J8AC4ydcMEE8h68Lcm9Uzet8GwQ=;
 b=TpaQql0f8RcVPh6KSr4g7MFus1+aQ73uTPafG9F5xl7eG9bWe8Iew+bA
 oknNZiAOaBWzRn/jstYDPth20JOW+2uux8pT29INQDiaez2ZTmB02Jex9
 HXN7MUH9z7ZV41oKxGmN+XMAYAXYPZrrMrnRXUkk2a5k2OOsuuzq65n3S
 YaRgr5TqRIvxKlNoz3GrKEJb2RYt8kW+KqAEYAiYxOJxVY40U25Yg2/HF
 1Jrdj5lA5N02rA2DZUbzagyC2F55k3cUshQvVxX9SjnC7tfq9iqYrJw1N
 gY278H0XHFVLx8XZLjyyGonzHnnR6132TUKgxynnvEyVBAWXSsNqU/wO9
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TpaQql0f
Subject: [Intel-wired-lan] [PATCH v4 iwl-next 00/11] ice: fix timestamping
 in reset process
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

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (10):
  ice: use ice_pf_src_tmr_owned where available
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: rename ice_ptp_configure_tx_tstamp
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: remove ptp_tx ring parameter flag
  ice: modify tstamp_config only during TS mode set
  ice: restore timestamp configuration after reset
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

---
V3 -> V4: Split patch ice: rename PTP functions and fields into 3
          separate patches
V2 -> V3: Adjusted commit authors and added base commit
V1 -> V2: Adjusted commit S-o-bs and messages

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 334 ++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  38 ++-
 drivers/net/ethernet/intel/ice/ice_txrx.c    |   3 -
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   1 -
 7 files changed, 247 insertions(+), 148 deletions(-)


base-commit: 938672aefaeb88c4e3b6d8bc04ff97900e0809dd
-- 
2.39.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
