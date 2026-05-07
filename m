Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC583CD3436
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 03:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CAC5414C4;
	Fri,  8 May 2026 03:48:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a9nSG8e862XQ; Fri,  8 May 2026 03:48:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C75D1414C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778212119;
	bh=Y+Iovo2BX1YOXbf5FlyaNUyEjV/bQI08Zym9OXJLDEQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LPX25j5UX3LF1sziYvSfalXZgThX4y7as3K1pyVLh1KVUIKeXR/nbBHjdVRdv8Kl6
	 +ytu9RRm5/cStigfQESpFnY6f3d1iajYxKaHW/h+7IX5rKU974mZgHZHLM9MAq4nS4
	 r16psAUsvaVImoeuJOwnDKr2UGL/cPuM4YbaB9zOHNmJZQ9WJ2qEwmBw2xtj9BwMHL
	 1xYiywjFvW81LMJzF/UOnXEEST9M07HmuMoQ3fRqF3YMb0XjmmmBXAUHXM/JhtMnQZ
	 kcrT/yNz0WJv5ZDAU5EounvzpP6j1yYKLxiRipfbH2iX3iP1qV1xe+6zpUiesl5oz5
	 x1XjhZNxljh9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C75D1414C5;
	Fri,  8 May 2026 03:48:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 94ACE272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 86824414C5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c-Jp6ZCAoVQC for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 03:48:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=khai.wen.tan@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 40833414C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40833414C4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40833414C4
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:48:36 +0000 (UTC)
X-CSE-ConnectionGUID: Q6OG2VXpTLK6ybVA/jJAlw==
X-CSE-MsgGUID: 9re3Cxg8RoasWN+7jTCR3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90278833"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="90278833"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 20:48:36 -0700
X-CSE-ConnectionGUID: 3/Z9CBXmTRSYCygsnAIrvw==
X-CSE-MsgGUID: JiV19TWjR6mRUIHunpGUFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="236767290"
Received: from unknown (HELO localhost.png.intel.com) ([10.107.255.61])
 by orviesa009.jf.intel.com with ESMTP; 07 May 2026 20:48:32 -0700
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
 hong.aun.looi@intel.com, hector.blanco.alcaine@intel.com,
 khai.wen.tan@intel.com, Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Date: Fri,  8 May 2026 05:47:02 +0800
Message-ID: <20260507214706.309984-1-khai.wen.tan@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778212118; x=1809748118;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9sJ6IMJ5LymCVMvZk1BOFaSeUfznGdj4PM9e7IORzXI=;
 b=HJI5z7TWXTK8jsKOK7V41Qop/bJ4aPW5ylK77CU4rFQbfNSRbYg7aJfS
 BTEuhhPtMuaab86dmiQa6osb3+ynIQatQ7mNeHNPrWMbd+dIrpnkDteGt
 nrXCk3NxanY00GATLNp9Uj9msSZ0tkqaVoSv7xasjeIHFBEYickOflBzg
 UB7JpUaA5U9gk/UAErNpYDETQfjvXpfzTlp35ciiz3R3AOLHnb1M/0ax6
 siEfIh4w9UMRIWoOmbyBEVlW2eTp396e/PBnNwKzOSPpuwFo+4fWYH+k9
 OiiuRIVMDTE450bNlTSmUH0fkKyQwm6i9HcC3NKepNIz/Qk9Cw1k8OQnL
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HJI5z7TW
Subject: [Intel-wired-lan] [PATCH iwl-next v5 0/4] igc: add support for
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

Changes in v5:
- add removal justification to include copper context in commit
  description for igc: remove unused autoneg_failed field (Paul)
- check that cmd->base.duplex is either DUPLEX_HALF or DUPLEX_FULL
  in igc_ethtool_set_link_ksettings() (Simon)
- dynamically override hw->fc.current_mode to igc_fc_none during
  link configuration instead of mutating requested_mode (Simon)

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

v4 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260428060009.311393-1-khai.wen.tan@linux.intel.com/

v3 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20260422155701.7420-1-khai.wen.tan@linux.intel.com/

v2 at:
https://patchwork.kernel.org/project/netdevbpf/patch/20260416015520.6090-4-khai.wen.tan@linux.intel.com/

v1 at:
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20260409072747.217836-1-khai.wen.tan@linux.intel.com/

Faizal Rahim (4):
  igc: remove unused autoneg_failed field
  igc: move autoneg-enabled settings into igc_handle_autoneg_enabled()
  igc: replace goto out with direct returns in
    igc_config_fc_after_link_up()
  igc: add support for forcing link speed without autonegotiation

 drivers/net/ethernet/intel/igc/igc_base.c    |  35 +++-
 drivers/net/ethernet/intel/igc/igc_defines.h |   9 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 210 +++++++++++++------
 drivers/net/ethernet/intel/igc/igc_hw.h      |  10 +-
 drivers/net/ethernet/intel/igc/igc_mac.c     |  35 ++--
 drivers/net/ethernet/intel/igc/igc_main.c    |   2 +-
 drivers/net/ethernet/intel/igc/igc_phy.c     |  65 +++++-
 drivers/net/ethernet/intel/igc/igc_phy.h     |   1 +
 8 files changed, 268 insertions(+), 99 deletions(-)

--
2.43.0
