Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ACD8FF886F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 28 Apr 2026 06:23:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5149608EE;
	Tue, 28 Apr 2026 06:23:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NyhdEti9vxQB; Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C438F60B39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1777357393;
	bh=OReuzWgNWFz8vzPs8P9VBGZHCUhTmpbF8qEpRLvzCbw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V8e8G66iFldQklKMW/EWdI6eTwnKu6gxUXua6eQaHVDVil+hpaHgfhJ+Sqx/LiLB0
	 EteQzDd21X2Y28eiCA4T8qHztDFBTE1fbcNrBvH50e2Ly8CUcVQ8NJtwwfVujExUfW
	 L6h+kO6E8Nnq2bZtcobAr0af8BQsMh0m9OAhzPlCY2a2ru2erqYVgpqIBMVF7RAu64
	 4RZDKtr9vSN4Mot3dgg6tPWKSVNAeWn2FbhkgBsKI321pHBYXW6qM0JOeLZgj8IiNx
	 ku9p4nj7jFbXDv1mAje+GvWhkRO/OP2gw9HCRpltg/RYH61RLTlowHDvQqi1Y04G6L
	 8qTmaW4ZPCrvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C438F60B39;
	Tue, 28 Apr 2026 06:23:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AB6741B8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 06:23:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9001240A4C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 06:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVxg--9u0Egr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 28 Apr 2026 06:23:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.15;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 444D040A4A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 444D040A4A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 444D040A4A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 28 Apr 2026 06:23:09 +0000 (UTC)
X-CSE-ConnectionGUID: UclgXrgRTdWfb8OfBE3HdQ==
X-CSE-MsgGUID: hyngqUq6R/abzHxm60/VjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78366111"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="78366111"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 23:23:01 -0700
X-CSE-ConnectionGUID: zt+B+SUwR1SA2xq6YIiuSg==
X-CSE-MsgGUID: Znre4iORQC60RyxHeo5/1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="232986846"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 23:22:59 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, khai.wen.tan@intel.com,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Date: Tue, 28 Apr 2026 14:00:06 +0800
Message-ID: <20260428060009.311393-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777357390; x=1808893390;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=G5klac0z2QVk9ee66GRUdGMtTliec7PBh21kBi9IFyI=;
 b=VixOC+kpMPu47Ahbj9iDU4qiod2jrXuKswEywhdzHrTg6vlSqKiHzLlN
 bD1uBZoaQllxRB6icAZmIR586djEDdSPhA93sfavoTkpN3NYSOUfXrxf/
 L8QZs6E3oTFdVL7Rf8saWbilwGXu4z6gUwV7Zx8MrjvfFfTSx42ZPtvxW
 HZ+nN83jf015ds/7ITAxlci+mM9f8RHpXvqYRcFx7luehbbypH+9eDbGc
 86zWcjwUrSHgA5KmkEtBqI/GGtZzUmKMVA2XZf+LhuSivmDZDilJzqZ26
 BOj+nXifkf3nBkIAWQNaHT20FdHKtXsMUfQDPWCrUbVuKmOjEZXlw55M6
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=VixOC+kp
Subject: [Intel-wired-lan] [PATCH iwl-next v4 0/3] igc: add support for
 forcing link speed without autonegotiation
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

From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

This series adds support for forcing 10/100 Mb/s link speed via ethtool
when autonegotiation is disabled on the igc driver.

Changes in v4:
- Validate that autoneg is AUTONEG_ENABLE or AUTONEG_DISABLE early
  in igc_ethtool_set_link_ksettings() to avoid passing unexpected
  values to igc_handle_autoneg_disabled(). (Simon Horman)

Changes in v3:
- Modify condition from "if (duplex == DUPLEX_HALF)" to
  "if (duplex != DUPLEX_FULL)". (Simon Horman)

Changes in v2:
- When forcing half-duplex, set hw->fc.requested_mode = igc_fc_none,
  since half-duplex cannot support flow control per IEEE 802.3.
  (Simon Horman)
- Split the original single patch into three patches for clarity:
  patches 1 and 2 are preparatory cleanups; patch 3 carries the
  functional change.

v3 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260422155701.7420-1-khai.wen.tan@linux.intel.com/

v2 at:
https://patchwork.kernel.org/project/netdevbpf/patch/20260416015520.6090-4-khai.wen.tan@linux.intel.com/

v1 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/

Faizal Rahim (3):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: add support for forcing link speed without autonegotiation

 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 209 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  16 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 257 insertions(+), 90 deletions(-)

--
2.43.0

