Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33ACDE99052
	for <intel-wired-lan@archiver.kernel.org>; Fri, 10 Apr 2026 07:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0F59F608A5;
	Fri, 10 Apr 2026 07:49:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvtI0GVwvLPy; Fri, 10 Apr 2026 07:49:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42F1060BA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775807382;
	bh=wR8mF8Vo9WS2sjFvImEHflAH3pOfpVXly17/86v+e34=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VFUAaLgTUEev9RloaHSCNzRtPnsH56W59mZfXcFYhKRiDrMk086l2aff0EVUu2YkF
	 TWev+LYloL2T4YaYXqbNj9TYFsdANoOD54rpr2oan8fXzm8IBrllaQnM23gURf3eEJ
	 cSG+MmgrFKZQlOrA10blLg8Bx6Stn1mTyyse9LpQIKGOlrT+przXufV5Z+dKtNf8yR
	 VjeN3IL5LhhrvhOfdzaOjqVVqD9A7f60jpCOom8UINx6EFLe9S9qTlQwTCxNdpH7zU
	 XtvztHGil8qj9S1XZYEb2ZtjHsH83vko2dVZ8RJp0niECJ8+asehD5G2AXNP8xwFgw
	 94CJGQH9c4DLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42F1060BA9;
	Fri, 10 Apr 2026 07:49:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F26731F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8A9681A81
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLFmEdFppoj3 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 10 Apr 2026 07:49:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D23CF816EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D23CF816EE
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D23CF816EE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 10 Apr 2026 07:49:39 +0000 (UTC)
X-CSE-ConnectionGUID: CO91tuIgR3W8EDIfvWGdAA==
X-CSE-MsgGUID: 6GOoOl1yR7KFnMmZUJczhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77007951"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="77007951"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 00:49:40 -0700
X-CSE-ConnectionGUID: ZbZsCUP1S1C+llfhrU/NsQ==
X-CSE-MsgGUID: SJArTDoyT1CCCo9FeWjQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="228941914"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa008.jf.intel.com with ESMTP; 10 Apr 2026 00:49:38 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 10 Apr 2026 09:49:21 +0200
Message-ID: <20260410074921.1254213-11-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775807380; x=1807343380;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PNmvSsiYs6voba6SHGZCYMS5ecS2d3YIYMk9i1Eb4ws=;
 b=GGinrlyOSsnNCPiawLo9aXbPPLCMZWFwkpi3GNtVF/7+QopaUwVMsyjm
 YakjuNG5JFjQ3BPwX8JFcaHAhYxjqz4GF0bNwB6K8k5nH3Dp0xCmVcNmB
 I0qkW53cQVDs2zC4B0A7Fnk+2hp87EuhSioos0hcY601dgmwx3HyXAI8u
 cpb829gMlky3YfW7Y6WCnbwNU/D0vx6RrD/A6Nbjl21AiNFrsEknVE1Vl
 t6eGwKaHe7MQlJA/s1JdJ+W690wsi76lLRo3hqfc/YGwppSipzg+BnEcZ
 lGMc6f38FhgU2xuCg9rQbFN7Jrd8AqG2awvom27Awr9qAV41IFuqKieWc
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GGinrlyO
Subject: [Intel-wired-lan] [PATCH iwl-next 10/10] ice: promote Tx FIFO drain
 timeout message from dev_dbg to dev_warn
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

The message emitted when the Tx FIFO fails to drain within the
timeout period is currently at dev_dbg level, making it invisible
unless debug logging is enabled. Promote it to dev_warn so that
users and administrators can detect Tx timestamp path issues
without enabling extra logging.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 801a6e66..841c999 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1108,9 +1108,9 @@ static int ice_ptp_check_tx_fifo(struct ice_ptp_port *port)
 		port->tx_fifo_busy_cnt, port->port_num);
 
 	if (port->tx_fifo_busy_cnt == ICE_PTP_FIFO_NUM_CHECKS) {
-		dev_dbg(ice_pf_to_dev(pf),
-			"Port %d Tx FIFO still not empty; resetting quad %d\n",
-			port->port_num, quad);
+		dev_warn(ice_pf_to_dev(pf),
+			 "Port %d Tx FIFO still not empty; resetting quad %d\n",
+			 port->port_num, quad);
 		ice_ptp_reset_ts_memory_quad_e82x(hw, quad);
 		port->tx_fifo_busy_cnt = FIFO_OK;
 		return 0;
-- 
2.52.0

