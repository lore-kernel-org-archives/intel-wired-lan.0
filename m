Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0E1CD5BB1
	for <intel-wired-lan@archiver.kernel.org>; Mon, 25 May 2026 14:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9256583DB1;
	Mon, 25 May 2026 14:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YbdnVgaaLHsk; Mon, 25 May 2026 14:31:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D314883D9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779719465;
	bh=4+QbGEhEsquEoKxIhD2AqcM08oL+NVhQbtrM0BhEX14=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qiKTiQBE2W3jFCAGi2COvJioMeSzLiDiJe5XZmELFQ8842HVxFJ9c6ZoFOCP/OYQ6
	 HXgKPm+qCHK2KFzNZt0akdvDS7xyvJplWHG3RVnSvzZDX6j9lNwkHPDbAMcSUKwv+h
	 O8tVtWf4ZGIMGwfg7c/5txuuAcmjJ6iXRmO32+rRaVVvAftJwfu5IYV1H8m09w7S2p
	 TZggWBkI6BNpWxIVkgwuqwL89jL7GtGMptpzELB766K44wYXI7IsZRWFyfzEJXmvru
	 DxzRvwIUkafcPJPRTMkbsoTjE4XpOiAsRzAgubkqzqoRBZFDb5oKLi+mvecAjk5GPZ
	 AsBIYS83YWoSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D314883D9D;
	Mon, 25 May 2026 14:31:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BE117265
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 14:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B085F83DB1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 14:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9rxARHRmpaQS for <intel-wired-lan@lists.osuosl.org>;
 Mon, 25 May 2026 14:31:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.18;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C658283506
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C658283506
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C658283506
 for <intel-wired-lan@lists.osuosl.org>; Mon, 25 May 2026 14:31:03 +0000 (UTC)
X-CSE-ConnectionGUID: UFHDQyZhRFGUFLs3baZtRQ==
X-CSE-MsgGUID: Hrhz1W4mQ/SDjiCfMBL/Kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80596721"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="80596721"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:31:02 -0700
X-CSE-ConnectionGUID: nvL+cXkzQMGhns8v9KSxZA==
X-CSE-MsgGUID: kZITJZNgR8CBwnc+tBgYew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; d="scan'208";a="237189227"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by fmviesa006.fm.intel.com with ESMTP; 25 May 2026 07:31:01 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Date: Mon, 25 May 2026 14:30:57 +0000
Message-ID: <20260525143100.2758251-1-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779719464; x=1811255464;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WMTE157dD8g+v5naxxaBeOIvwYVp6WNe8lrymqYZFTI=;
 b=FtsTyMLv1qEN10RfUBe2lUg8Tx+rZ/rRV0iqIgGy2kkagN5NbhvteeRV
 IvCZYb+tVGsN2DAbPnWkGFPJrPCK7Kp5FXk+n+9uCpZH7q9wmV2m24dLQ
 iA3Kff/R07fGgTQcHtGUDCTsqqQhYLVu0KdgeF6bjuO3JouTmGapmSOZT
 b8sZik9VtvB21zm7S5v1wfItXMbuB6faXzkvz+gJw5yomqpPibV9D5nDl
 99sWm+s6ebQIn+TJJ2pCQoDkuiavwgHg2ZKFsgSA+GxmFINdOcUTKhzPs
 Zph9QSHJ+Pr5SzDTDNNJThq+gEMIIBrjabP1fGvQsdPuV/T5wDuhfpbdJ
 Q==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FtsTyMLv
Subject: [Intel-wired-lan] [RESEND PATCH iwl-net v2 0/3] Rework ctrl_pf
 pointer usage in struct ice_adapter
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Rework usage of the control PF pointer in struct ice_adapter, so that
it is always has a consistent state, since it is global for an adapter.
Utilize RCU for reading the pointer value and atomic operations for
changing it. Zero out the ctrl_pf pointer when the control PF is removed.

Previous version:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260504/054842.html

v1->v2: Rebase onto the latest dev-queue branch:
        297c032796ab ("igc: add support for forcing link speed without autonegotiation")

Sergey Temerkhanov (3):
  ice: Convert ctrl_pf pointer in struct ice_adapter to RCU
  ice: Zero out the PTP control PF pointer at ice_adapter cleanup
  ice: Cache struct ice_hw pointer for split register reads

 drivers/net/ethernet/intel/ice/ice.h         | 10 ++-
 drivers/net/ethernet/intel/ice/ice_adapter.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 66 +++++++++++++++++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 26 ++++++--
 4 files changed, 89 insertions(+), 15 deletions(-)

-- 
2.53.0

