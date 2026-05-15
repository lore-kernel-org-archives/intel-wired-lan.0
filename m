Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8F7CD4F48
	for <intel-wired-lan@archiver.kernel.org>; Fri, 15 May 2026 19:04:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31670616CC;
	Fri, 15 May 2026 19:04:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQhxCh-A1qAH; Fri, 15 May 2026 19:04:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A6FF1616CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778871866;
	bh=/m6WWzlcLK2jIquH1fBIuBKUUcfgnJ5EDwGzGSrPaig=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=22t2oLdwLoQT4dYmGDKBcAIUw6j5EU7qu6jlOQulRUDgWGlFQZEm/ifDMvcOB9r0j
	 UNDiyhE492C4qxv41EoexmiBGdzNYnjTNn9o4KPEQPx5UHv9VUsEJzV765LNG6fobv
	 bSFdRQUno8e6QiLUO0iOKxrScEZQyuypTkfb5leKmqnBi8NejMAUJE6xH8LCkMdw/r
	 KGH/7r8p4oFrTYTjeGV1NM9bLlO2F1QUHH4AhXHyNeXqytExFEGPg4OvttWax9iJqY
	 CWaDMtiNhCgEc38CAA6/Tmy1uhQjQK/HN2cIqD+W/1etXHLe5XyB/eeLxFWrMjhacm
	 7VuyJR4/vCIRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A6FF1616CD;
	Fri, 15 May 2026 19:04:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50371282
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4215440FD2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MUfc_NPtZwmF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 15 May 2026 19:04:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.21;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 20CA040FB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 20CA040FB9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20CA040FB9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 15 May 2026 19:04:23 +0000 (UTC)
X-CSE-ConnectionGUID: Od+UwpOrR6OvyFRmgOsecQ==
X-CSE-MsgGUID: rVgHAnfqRAK+JYaM7/4rtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="79725700"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="79725700"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2026 12:04:23 -0700
X-CSE-ConnectionGUID: d4OS39XeSxqoHdEyxEEMXw==
X-CSE-MsgGUID: PcxD+8NdThW0Cy+MYQ+MJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; d="scan'208";a="238895629"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa009.jf.intel.com with ESMTP; 15 May 2026 12:04:21 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri, 15 May 2026 21:04:15 +0200
Message-ID: <20260515090000.5112345-3-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
References: <20260515090000.5112345-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778871863; x=1810407863;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=09YivHPBajfDVmwpC8AfPK2sWbUMOJPh9A9V77KLDyE=;
 b=TyJSC6BUd0UtA5DHHnKylOu1vrK5i5W+Nu24lA8NJTltKsMBVb+8iIzg
 lLBIEBM3lfuCn97Sm+u0fmWQOYpMXIDcffxbJlsDx/vpXQkCqPq+92QAu
 JOLDTb6MlEStvdUuj5s+SUbpaByv1i2LIxnwEGBpxpLaPq7vLWEqBIIo6
 KsSuh3wlpaJUxpip1Fefvd3bNu3oS0ucYc/GI46Iu/W1I+R0udRCUoDJK
 9briGNzY3PuNczNEwg+rJTVudxpdpMbl+SeNnH008qq26KuQH8OvYKab5
 b821yfiabFT3xww2VJB1hULE+2AA7WXyBnCCytgGajrMDMk6mlO7ywuTL
 g==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TyJSC6BU
Subject: [Intel-wired-lan] [PATCH iwl-net v5 2/4] ixgbe: fix cls_u32 nexthdr
 path returning success when no entry installed
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

ixgbe_configure_clsu32() returns 0 (success) after the nexthdr loop
even when ixgbe_clsu32_build_input() fails for every candidate entry
and no jump-table slot is actually programmed.  Callers that test the
return value would then falsely believe the filter was installed.

The variable 'err' already tracks the last ixgbe_clsu32_build_input()
return value; if the loop completes with a successful break, err is 0.
If all attempts failed, err holds the last failure code.  Change the
unconditional 'return 0' to 'return err' so errors are propagated
correctly.

Fixes: 1cdaaf5405ba ("ixgbe: Match on multiple headers for cls_u32 offloads")
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2 -> v3:
 - Add Reviewed-by: Simon Horman; no code change.

v1 -> v2:
 - Add Fixes: tag; reroute from iwl-next to iwl-net (false-success
   return is a user-visible correctness bug, not a cleanup).

 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 210c7b9..6e7f8a9 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -10311,7 +10311,7 @@ static int ixgbe_configure_clsu32(struct ixgbe_adapter *adapter,
 			kfree(jump);
 			}
 		}
-		return 0;
+		return err;
 	}
 
 	input = kzalloc_obj(*input);
-- 
2.52.0
