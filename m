Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E65D2ECF7
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Jan 2026 14:02:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36DD385BDF;
	Tue, 20 Jan 2026 14:02:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OP3Ke079qzyQ; Tue, 20 Jan 2026 14:02:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABDBA85BE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768917749;
	bh=m3QIVegm+dxTUHMu5wMzPTaIPFzcAJEUpVxfy7ozwqQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=1Ycs1tWLBSiICFFDzBI8hHn3DUkU72AeJxGuVWCtFHYLSBzKdIbd+gqFJgOEWU8xY
	 KOEHTDzIg7ufmSXLV9ueyxpZwEkJwU0FJpzmcrCaq7xN9iSS01imOlRxhDGH1M8J8U
	 IyPw21LJaHc2tEWd1W0BTqjxjLY746JaduKFkk44Owm/lsDYUOculbTG2CmeHk12J2
	 X/mAO3vAY1KSLp1YW+6W/FYncO7V8NFHaeKBGjcwS5EMCI8GdDDENk15YVuL8NsN7G
	 GxsJn+YwbRca/kCBXFdgCokSSuEdDk1hexmSpY8cKg2GC97IKEe7ACYcyImv0kCh7O
	 rvsP3nRiVQbGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABDBA85BE9;
	Tue, 20 Jan 2026 14:02:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B2012A8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 14:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F48B4F112
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 14:02:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iuc9O2ktoFyW for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Jan 2026 14:02:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=jedrzej.jagielski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8DEE74F103
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8DEE74F103
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8DEE74F103
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jan 2026 14:02:27 +0000 (UTC)
X-CSE-ConnectionGUID: oMjMNLjgQ2ip/pwA+4uN4Q==
X-CSE-MsgGUID: LXYZReEKRMivWW5eCH6aGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="72711744"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="72711744"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jan 2026 06:02:26 -0800
X-CSE-ConnectionGUID: bDuEciD1TKCzSk9x3qaB1w==
X-CSE-MsgGUID: To4a+SLBQZKvwv5/erzmmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; d="scan'208";a="210978884"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
 by fmviesa004.fm.intel.com with ESMTP; 20 Jan 2026 06:02:25 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Date: Tue, 20 Jan 2026 14:44:28 +0100
Message-Id: <20260120134434.1931602-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768917747; x=1800453747;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9IsVLdapNNbc/4CpLd1Dzy6K3wU47Fpio5/3FQinHeU=;
 b=V7J2eA/Rc1G3A/QtGAlEC9tZKEUM72dqqwn+cG+ICqmcYJupVyN8mRvr
 HG0AYcJGejr11Ympt1PIC93eoFfRC55fuf4K0YALLh/HNm6MQADlxdGw1
 u0peh2/JuIMRPRKdSL+JAkSM0RNL5x6Df3om7qW/beGVFVaXCYYVHui6U
 jrCdINytj/SKZAFZrL0VTv7d04ffNvHE3P9UaMy032i2bSaWFBUIcUvTP
 hvzVzurZwbRH/tH5yppbOj8YO5x0by4G51awwbl1rrkX14UJybCGAEOLY
 SydIB5eWHS5qsK1ravRfnqH9dPfePdKy/KyUIdlS+wxsY8HQy66Y2BVNb
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=V7J2eA/R
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/6] ixgbe: enable EEE for
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
anytime link conditions aren't met. Still cannot configure LPI timers
and EEE advertised speeds.

Jedrzej Jagielski (6):
  ixgbe: E610: add discovering EEE capability
  ixgbe: E610: use new version of 0x601 ACI command buffer
  ixgbe: E610: update EEE supported speeds
  ixgbe: E610: update ACI command structs with EEE fields
  ixgbe: move EEE config validation out of ixgbe_set_eee()
  ixgbe: E610: add EEE support

 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |  73 +++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 244 ++++++++++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  30 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   1 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  38 ++-
 include/linux/intel/libie/adminq.h            |   1 +
 7 files changed, 325 insertions(+), 63 deletions(-)

---
v2: get rid of eee state refactoring patch; rebase series to the recent
    dev-q branch
---
2.31.1

