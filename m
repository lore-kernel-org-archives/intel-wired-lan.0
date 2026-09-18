Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6806FC982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43ED360DF1;
	Fri, 18 Sep 2026 13:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VBF1ojFEoSn4; Fri, 18 Sep 2026 13:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 69A0D60E18
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738401;
	b=ce/0X8SqI0nukb4m9DeoePYZnf7HPsgkx7/+Bz8mQwmhXlbxBjnLYv/e8XAXTgpPDy/m
	 33oOnhgSobyVayxZyaAjSlPQsMariARpoeG6tdBY9ZRi4zmZKG5PJesyvTgiJsNBfji+b
	 tMaXtCVnXhKXaIheTqeYV/zktPsYtHE/eadd4FyKMnYfe88BBVbSXI/3xlf+geoXgOYcz
	 fLHc+xZwrfGXmnYPIZ+7I6UzJSFdSL3DZaDolU9TERR6E0AvtdKmoVWtt4LLFUQ24445X
	 /cpYWn2bKGHUt6MUwoRKiJ1vP4XYx+jl6FBLfMBmRq25XkdLjPnnHv3UCDWCer+v2IQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738401;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A1zD04wAXjMKZ5TsfZ9qOPTFrSauOwtlWC4/VMdQOM0=;
	b=K+da8hXCninfpQ+Tu0GBPyduTcnE+EF2hIYe7VggUg/xKiK1edURk3e1fRoVYdxHuGKD
	 UUReQFKDr+V6GuxmgFsqj8sGGMKkj74cBFyPHHUadeBHapDrO8BZLMIRI0yChOcvF//pN
	 kabUbX43Oo7NPZoVcKxFjBtQkyltlcG/n5RLnz3/p+y/ZrQPoXgIf7O5rQ3bbXb8PHPT+
	 rrFd/9dwjna557/BMKqKaAy3fhjygoXC9JWchr/q5eSyYD81Xz8NrlDOjb0bnV25JWVZ8
	 EOCaDTGiRlix7c/cTT6SyrX3QY46x1bUenD8ws2UzBQOI5SUWxsCOgut9yvOmZXxqOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JRjJLDsa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738401;
	bh=A1zD04wAXjMKZ5TsfZ9qOPTFrSauOwtlWC4/VMdQOM0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NArEAo+eETtVx/Kb9GJx2NIRIJFMg9P4d3SB0Y75oEYFuHMZG6ObgwJy955zafJZI
	 YpMx/FTvsUWi7LZSraH1ysmRp036KDg7qCC8+VULLVlSGsQXJI8dgDUsLi0YeuvPWI
	 QOWr0TMa1kf4K7S4zmjJw96A0cVmyfAtpFvpU2v9GrWcUPCtI+47YdUAkTfVMzN0iO
	 HEi9h6nDiE5LDskxW+rfkfGQGE9t4vixkhNM8nOFkifbPLXpSzElxGjS/HtRsmIv87
	 ZvmLk8uLxZd1YsblvwjqgSf4/AspusrzX/0IF6RWnCT/Pmm3Bn61zQtoB6/wyDloQe
	 w4Ukztp0ahcoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 69A0D60E18;
	Fri, 18 Sep 2026 13:33:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4E42279
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB0C260E18
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I3-YBdc8W7PA for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:33:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0D82860E09
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738399;
 b=DTLzSTUcTxM2gtrXshnx236YQea4f/AnKpMrsQ0n6V7084TOTyEI1FVPt8EN6QvmnjSM
 mdia19lTsBe0xNg/5PqIyaJxNS7ipo1m/8Hv0uC9wEKUn1DuVrqNioImOKhFOoI9LMwz/
 7YINUo1x1Pgzp5xglZF2vhzsMqTLOIibagtHp/1QP/07YJ3aTOta/tQYzPB10P4lDrA/D
 rnE2OCKWTmFk4jjuLYFu+oIOoQzTRKmj3Nr9db/2vyFbQpcWCsyBHIGLxKe1tfzAD775C
 2pHrEfC46ya8LGo2HRgsQOPX97QR+oBdR7larHJhOgBUT2TMjgMm8D0LX3VXJ/QbB4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738399;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=A1zD04wAXjMKZ5TsfZ9qOPTFrSauOwtlWC4/VMdQOM0=;
 b=gY0yq51sSVU1Gsy3JmxaQ23beMiy7VgXApjtCFMlqQjdo/GGq2oa5u4h/sR3O28jhouF
 6F8U2kUBlqj1CkoTMF4wnL2fvIUBP64tdphz7AMDbmdCVgdCMTcYpXGbwhbWcfl7LucLx
 BnTGAoi/puQ035BuAbhu0tS2YF+YfRqkuJRDiRmEtuAm+FCKNPWlAn0qTwrQcqzsWnIkV
 SHtVXJORIl/PKCedBekdeEINMqiR/fHVHGCK841cKwDbGvWe5Xha4xGyzN4ULmgC5kaPd
 2RSwO+VYmtdI++93To0baDuWjemRzrLbHaayVbe6ypBvddAGYJaa9gIauVLfQpFKnXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JRjJLDsa; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JRjJLDsa
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D82860E09
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738399; x=1821274399;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YZW4VC7D0xXPbuKScthZKOX7ucUwQmE9L3p/jFA459Q=;
 b=JRjJLDsaaSauD1Q1IqLfoYnfSFUgB7iNbynD09omQRdPBxmyFwqOFKqY
 SyYEXMeBW01f6/x2Tpw+fOpUWm2ekSDBVba9p+/kmO3CeXGSu75kbrCqq
 /Wfs2ls0MEZU5zduPjMEIRY2y2fqFxfH88Tx0V9hRjIqoMkTwXB0cAa+h
 6pXE2kbPkLN3WBN2B/d61zjYETiTBy0skY+ZPrvlhFv37LgiyHHZ+cFNP
 WYFfJ2fkMhF+97UU6zzxEXrZTGewJcfCoRnagGFcux7n717aoOVpVWDqM
 9a/qlwB9gTt6mbK+aZo4vwuOJbflgpNmP84HCLuaVot+KpQGIYI/di7hZ Q==;
X-CSE-ConnectionGUID: ydCmCleOT3q83tqcyZOWDQ==
X-CSE-MsgGUID: Uwrixo2JTj67y99rEACTtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840874"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840874"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:33:19 -0700
X-CSE-ConnectionGUID: qCJn+m0bSw+MD/cNqhIA0Q==
X-CSE-MsgGUID: InrMOP8sTmOlL2tm9Q63/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717941"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:17 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 0/4] ixgbe: adaptive ITR tuning for RX starvation
 and latency workloads
Date: Fri, 18 Sep 2026 15:33:12 +0200
Message-ID: <20260918133317.4169815-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is v2 of the ixgbe adaptive ITR tuning patchset for iwl-next.

v2 changes:
 - No code changes. Resending to pick up Reviewed-by: Simon Horman
   on patches 1 and 2 (patches 3 and 4 already carried it).

This series tunes the adaptive interrupt-throttle-rate (ITR) algorithm
in ixgbe_update_itr():

- Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us so the minimum
  bulk-mode interrupt rate is high enough to avoid descriptor ring
  starvation under sustained full-line-rate RX traffic.

- Add an ixgbe_container_is_rx() helper and refine the RX-specific
  latency-detection thresholds for finer-grained control over
  low-rate RX latency workloads without affecting TX.

- Limit how far a single ITR update can lower the interrupt rate while
  in latency mode, so a low-packet-rate ACK-only workload cannot drive
  the moderation down too aggressively in one step.

- Add an IXGBE_ITR_ADAPTIVE_MASK_USECS constant to replace an
  open-coded complement expression with an explicit named mask.

A fifth patch from the same original batch, removing a redundant
ixgbe_ping_all_vfs() call from the link watchdog handlers, addresses an
unrelated VF mailbox race rather than ITR/RX-starvation behavior and is
sent separately so this series stays focused on one topic.

Alexander Duyck (4):
  ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
  ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 80 +++++++++++--------
 2 files changed, 49 insertions(+), 34 deletions(-)

-- 
2.52.0

