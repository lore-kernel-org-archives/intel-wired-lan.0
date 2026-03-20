Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A8FB5EA9
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 05:05:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74C3B617A0;
	Fri, 20 Mar 2026 05:05:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lDnT0sm66I0P; Fri, 20 Mar 2026 05:05:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A71536179C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1773983123;
	bh=DSOCarzACI+L58dFuOEfbNUGtKVfpwwe4yaL/vAWwfQ=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CNLIPK/UQH8f+KR/XMXIy/T+ob7qLOJj9pEgygl23v4PRNONW5XfIXL+Bvhgwahp5
	 52RwGE3aJNp7FX6QnWXLLI+YeXZSlF4y8KX1N2rl/7WsOCPy4K2LlIsMBkPlz0e3nO
	 lW2d7mnhWnmaN1qO8Hzue/yseRg/0Gz2/69wyagY8wjpD/TKpLzVUp4Mr/5MACwLAT
	 cJ9ydjLAObFK98OZhIiUgHoLqlX3O/UdsxtJB53OAwt0SVyQT/A4ZWxpbAUbNqoorX
	 PRGlK38iz8O5Av9NuY2ZX9BkKGxi+7RUB26NtKE4K3ePv9N0eWC+uTNbSYCqmrVXQQ
	 rlSq4+LHvWV6w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A71536179C;
	Fri, 20 Mar 2026 05:05:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 71ABE25C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5729641398
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6acu3oSwJp-e for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 05:05:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A225C40176
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A225C40176
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A225C40176
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 05:05:21 +0000 (UTC)
X-CSE-ConnectionGUID: 07U0xjOQT1izDAqdBXNDDw==
X-CSE-MsgGUID: aYR8TDPoSJijmrY/B38kUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="100522668"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="100522668"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 22:05:21 -0700
X-CSE-ConnectionGUID: lZ2lxThgT8Sme5q3KiCt4g==
X-CSE-MsgGUID: fwe+DApRSd24oV7xODS/LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="227307229"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa003.jf.intel.com with ESMTP; 19 Mar 2026 22:05:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
 Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Date: Fri, 20 Mar 2026 06:05:18 +0100
Message-ID: <20260320050518.422303-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773983122; x=1805519122;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DgrE2MwUT9sntQ/qvQ7JgAgAPRBneIx6aGJnv3XM8Pw=;
 b=Kv8L7uoUq+leR77epQkKYNMCNt78sH/AH3uBGlDF30JxnC3NcZ4DTUtE
 do6bPbi+jsrRBfFnhrDMYuTCEbzC8EEoihYbl90qeRTpBG1gEkKF0kHvh
 fGujYFm7tziqLRz435hBNKP7Fq4bu30wjzOvVg6ivJQ19CBsH/dF5WPfy
 A6m+aMUWELQz9VrMvpWCCfAnp+PEtaK7Vbfwp3wOkKMkemjX7qaKCIYr2
 xhDIt6hKQnXPXgG6ftbuicF14dRXYz/k/cPx0DZuo6KpSFCtv78tfoll7
 gdI+e5iDG3EWeyspQBbRALeqtMFmy5IrK7G/mRFwAq+DZzNrz2JuPClwg
 Q==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Kv8L7uoU
Subject: [Intel-wired-lan] [PATCH] ice: add missing reset of the mac header
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

From: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>

By default skb->mac_header is not set, so reset prevents access to an
invalid pointer.

Call skb_reset_mac_header() before accessing the mac header from skb.

Signed-off-by: Katarzyna Wieczerzycka <katarzyna.wieczerzycka@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index a2cd4cf..374b17f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2211,6 +2211,8 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_tx_ring *tx_ring)
 		goto out_drop;
 
 	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
+	if (likely(!skb_mac_header_was_set(skb)))
+		skb_reset_mac_header(skb);
 	eth = (struct ethhdr *)skb_mac_header(skb);
 
 	if ((ice_is_switchdev_running(vsi->back) ||
-- 
2.52.0

