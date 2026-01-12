Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3492C9EC94
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Jan 2026 14:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84E6F84ED4;
	Mon, 12 Jan 2026 14:18:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GaUsqWDgRF1i; Mon, 12 Jan 2026 14:18:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE67084EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768227519;
	bh=Ls+7iv5ETZtuRzjeq8m/w891u3U8+gWOuWqfAV73G0o=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=4ihjj8L8pbfrt9T9tK3F9bDHBgsT5C84G8rYvWYElTIQ2RS0MDJz6xniyUmW1b/sT
	 f6I1Qpr/6MdAjaPw+XxUgXjEBgeGa2Khbj6rBBra3KRGlZiN6xhyu4HlOs4hWD33YD
	 IGqwWBDo+cupb/0PK25HvH1LkETUz+0vieILxp/CdOQj5lfnejk+kkgTMHIB0/fQDG
	 ZiT7Oa2UGif5tIpVymZZ9acCDzsqPqj2Wx4hL9MDEF9Pt+mp21jtGX/AuYlKBcxMId
	 ZqfCIS9tIgM36i1OAgh2Te4uyPmPssiyOkNG8I/2kLvARR3UNExMJjm0S48aew3cUA
	 fpNzreZ6c/rvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BE67084EBA;
	Mon, 12 Jan 2026 14:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E36118D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jan 2026 14:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1414C6F4F3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jan 2026 14:18:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0xcXcX0JpPn for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Jan 2026 14:18:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5777A6F4F2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5777A6F4F2
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5777A6F4F2
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Jan 2026 14:18:37 +0000 (UTC)
X-CSE-ConnectionGUID: hBudZquKRkOojJRh4P+snw==
X-CSE-MsgGUID: NcBf63IWS6irP92krjp0Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="73352278"
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; d="scan'208";a="73352278"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 06:18:37 -0800
X-CSE-ConnectionGUID: rVOT95v5QEeVCqlu981b5Q==
X-CSE-MsgGUID: cMpwmWyVTiOvqeTm28QMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,221,1763452800"; d="scan'208";a="227355621"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by fmviesa002.fm.intel.com with ESMTP; 12 Jan 2026 06:18:36 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Mon, 12 Jan 2026 15:01:01 +0100
Message-Id: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768227517; x=1799763517;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=vPeDa8uyWuQnIXSJZ4FwePDJ5JKSHDvAEnccORld0bc=;
 b=Z6FNS0i9B2L3MUNcb3sn4S2UYKUr8MpuGFh1Vo/+9bxYWmVob01WItFT
 In+QR+9oaJfN8TI74p25Db1jlAajK3WECaW8PPZs46DCBrZHQHkth5gPT
 roUpyxheJaCrOLSgXzJaXtYyIhGwd9yqhDRYrGZxe1EYMO/tQTlUDUIPL
 zJF3rKBJz1FqhLhkUnSx9/hlAOsdK34nhIaXYRCKANjEHZcP9UbCIMEYC
 I2y0WwppIIDK3hmG2b2jcaQnIIclrjwBOy3RB79NibXyxvkbKDAVG5XwG
 ZsXEAuO47bwLNMo6b2O0QWT8RaIsFBaqpibKYEEp87PeUF8hnKY9PIGY+
 A==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Z6FNS0i9
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/7] ixgbe: enable EEE for
 E610 devices
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

Align SW structs with latest FW changes related to EEE enablement.
Address compatibility issues caused by the buffer size changes.
Implement ethtool callbacks which can be used to enable/disable EEE, but
generally the feature itself is enabled by default. What's important it
works only for link speeds > 1Gb/s, so even if enabled, it gets down
anytime link conditions aren't met. Once met again the feature gets
restored. Still cannot configure LPI timers and EEE advertised speeds.

Jedrzej Jagielski (7):
  ixgbe: E610: add discovering EEE capability
  ixgbe: E610: use new version of 0x601 ACI command buffer
  ixgbe: E610: update EEE supported speeds
  ixgbe: E610: update ACI command structs with EEE fields
  ixgbe: move EEE config validation out of ixgbe_set_eee()
  ixgbe: replace EEE enable flag with state enum
  ixgbe: E610: add EEE support

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  13 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  77 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 250 +++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  42 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   1 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  38 ++-
 include/linux/net/intel/libie/adminq.h        |   1 +
 8 files changed, 358 insertions(+), 65 deletions(-)


base-commit: 8fccf912252d8d61064058caf4d6e1085c5ac309
-- 
2.31.1

