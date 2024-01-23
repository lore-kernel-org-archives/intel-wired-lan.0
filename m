Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C386C47258
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 10:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA30541731;
	Tue, 23 Jan 2024 10:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA30541731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706007117;
	bh=7T9wC/dd7badYbInobeWf7OhZjqwCpqaE3iEATAYtBY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=jV9DC0pDvJYV/zrO8HSd0gFmAjYt2aGKVK1dQBc6mfonUfFa8buOshsnkqtjYpiGK
	 eF9XVPdr0vtfZnoddBGra4lk8P1ZetDcoYPs6MKBKSSnJAuZFG9lpCCLyZRMc7Ie94
	 TduNfxo8Oj7lm1awNMrGEgkaYOXj5FVC12TQ4KGEl4HxuhXNbKbK9Ff7MQSudGxXV5
	 Iih1+U+FeduYFptB2tnX6XE6sncGwzlD4zx2Js9uk6u5GL8coXhBEefa6lF3ioxGzV
	 nKSKbisAswoDo6cEuwLpkFUJUz+jVHUpX1zQseGAPOrG8HnRB943GylalhA40uUUD6
	 VO06UYh8YPAvg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hxLLv8_c0bK0; Tue, 23 Jan 2024 10:51:57 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AD774174B;
	Tue, 23 Jan 2024 10:51:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2AD774174B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 09F011BF299
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 10:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E25358238F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 10:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E25358238F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yICX9uHQ85tX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 10:51:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A572382382
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 10:51:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A572382382
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8877575"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8877575"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2024 02:51:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; d="scan'208";a="34365363"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
 by orviesa001.jf.intel.com with ESMTP; 23 Jan 2024 02:51:51 -0800
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 23 Jan 2024 11:51:24 +0100
Message-Id: <20240123105131.2842935-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706007114; x=1737543114;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QVDzK7qu8Dn9oJm3knKewxlwsWJntp4EWgC54cySeok=;
 b=ah28DddtmbBkAIKFT+6+3EUKgxUaLGf739diXaBh/IFEBIGnO46/IE37
 QMbmKy+NB2OPP6UxiC9WpxT3kzG8ALo2MPDZ3j4ifQ8fIfP4Dd1MxnKz8
 NxF0rp18P2RerqKOjqhbiGB+SN2iv4wXpefOPf3W4l3dDLpiqIIGS6s0M
 glwuPJr31f4x2NUK6t7kxmz3+vD+k5DxSWkCpmBQn2llCnMp4n+R2VXuv
 PZbh55JhsJj5teISYQrnHKQm8JTZg1irMyguFLvNUHiF5qj2Fi1EzgeNy
 nVXDN3Si0sRgH/yoTxVm8ZnBFG5xMrifDAUb1Qjv+yMoG/wca8b1/Q/mx
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ah28Dddt
Subject: [Intel-wired-lan] [PATCH v7 iwl-next 0/7] ice: fix timestamping in
 reset process
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

PTP reset process has multiple places where timestamping can end up in
an incorrect state.

This series introduces a proper state machine for PTP and refactors
a large part of the code to ensure that timestamping does not break.

Jacob Keller (6):
  ice: pass reset type to PTP reset functions
  ice: rename verify_cached to has_ready_bitmap
  ice: don't check has_ready_bitmap in E810 functions
  ice: rename ice_ptp_tx_cfg_intr
  ice: factor out ice_ptp_rebuild_owner()
  ice: stop destroying and reinitalizing Tx tracker during reset

Karol Kolacinski (1):
  ice: introduce PTP state machine

V4 -> V6: patch 'ice: rename verify_cached to has_ready_bitmap' split into 2
V4 -> V5: rebased the series
V2 -> V3: rebased the series and fixed Tx timestamps missing
V1 -> V2: rebased the series and dropped already merged patches

 drivers/net/ethernet/intel/ice/ice.h         |   1 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 229 +++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  34 ++-
 5 files changed, 164 insertions(+), 106 deletions(-)


base-commit: c8c06ff7ca5d9fc593fd634e3c3ff78a7e2bc5fe
-- 
2.40.1

