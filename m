Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C271073CB4
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 13:12:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1CC540EE7;
	Wed,  8 Apr 2026 13:12:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XVs-uLvg9qC; Wed,  8 Apr 2026 13:12:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2F60340EC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775653942;
	bh=965ivX3ruq3mNfDwovhEX4tCZQ9C8OdGvYMdrkq3s9w=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=COUxdM7uTOQEtNmHoIV9fo621koxy6pPB0SHNSR0H1fZYuuhB+VIdLyxWJaDc0wfF
	 ELG9r7jEl3tHyR6JZB/ZUWvWd+T57xypd7r9cYt+NBcwiSdt6ujKAH5NEMQx8R68/u
	 PaapApcsgixsXo/E5DHMMrk8yqmx5u+kkkQFLen04BHD6FYllDCiiZTcQgf/1Knj/B
	 bz6KVYk2sF0LmNTYwgmdi1gOdbCCZ8004aBsHl+SoOA/cKX7V5u90sfkoKWBQmbOyC
	 Tv9qt8c1yOc8C6VZ+hihHP9R3b7eXR6o0I6uaQhywQpFbBhAE70GJ9C0OEuOaWL0e5
	 WqqTyzt2oDTXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F60340EC1;
	Wed,  8 Apr 2026 13:12:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id BAF0E1F6
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AD2D240EC1
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eu_5C5rsm5ii for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 13:12:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9A1B840E98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A1B840E98
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9A1B840E98
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 13:12:19 +0000 (UTC)
X-CSE-ConnectionGUID: tFHHvAFnS9+a6CH6fOE1VQ==
X-CSE-MsgGUID: WOsbIXf0R6mkkP4gspvgwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087254"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="102087254"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 06:12:19 -0700
X-CSE-ConnectionGUID: x2+7OnqDQAqqhJSJD2OAIQ==
X-CSE-MsgGUID: OzxT01VaRrql0uo/QazW1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="228715050"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:18 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Wed,  8 Apr 2026 15:12:08 +0200
Message-ID: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775653940; x=1807189940;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ntpjB1EZtCslNyS93hZX36BdvkZc2KDqWWKQnlUrZQk=;
 b=Tl1htdcaGJBqoQnVOC0fynfZjakxZ0xzPub+UpAtEbgNLP+FvtML5/4y
 4crNs4tvZrki2+8I4OYICGYjZSUjHxVEdL84UaBR/prdPuAOO/PrPTIPy
 P8Tx2SWlbBUbX6YcSeZsSZOszy7W5Hims01noxAya6ChqbdpUXpBuDqT6
 iM00snCAaOmZUmFfGVOnW0W1zUnPNr6QezyJhDKeEsfM5Dgwt/ZLWJ2hd
 9zwI85nOuOP6pYxcBl+54ITmaswUkCtAn2XZ6kWHFqEhQJXc1C6a8KanM
 3qgSi0ORNbRRBG5ZmXfh7jd5kSOBZRwBiX69qpcAXB0/VF6aaAUpwnFfR
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Tl1htdca
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/8] ixgbe: nits and
 improvements
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

Eight cleanups and improvements for the ixgbe driver.

Patches 1-4 split the adaptive-ITR algorithm improvements into
independently reviewable pieces as requested by Simon Horman.  Each
patch is self-contained and can be reviewed and reverted independently:
  1. Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 to prevent RX
     starvation at minimum bulk-mode rates.
  2. Add ixgbe_container_is_rx() helper and refine the RX-specific
     latency algorithm (thresholds, no-packet handling, mode tracking).
  3. Limit ITR decrease in latency mode to at most 2 us per update so
     ACK workloads do not overdrive moderation.
  4. Add IXGBE_ITR_ADAPTIVE_MASK_USECS constant to replace the
     open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY complement in ixgbe_set_itr.

Patch 5 removes ixgbe_ping_all_vfs() from both ixgbe_watchdog_link_is_up()
and ixgbe_watchdog_link_is_down().  The original submission only removed
the call from the link-up path; this version also removes it from the
link-down path, which carries the same race window against VF mailbox
initialization.

Patch 6 replaces ktime_to_ns(ktime_get_real()) with ktime_get_real_ns().

Patch 7 restructures ixgbe_fcoe_ddp_setup() so that dma_pool_alloc()
is called outside the get_cpu()/put_cpu() preemption-disabled section,
enabling GFP_KERNEL instead of GFP_ATOMIC.  The prior submission left
the allocation inside the preempt-off block (GFP_KERNEL can sleep under
direct reclaim, which triggers a BUG() with preemption disabled).

Patch 8 fixes six local variables declared as u32 that are used to
store signed kernel error codes.  Reviewed by Simon Horman.

Changes in v2:
 - 1-4/8: Split monolithic ITR cleanup into four independent patches
          as requested by Simon Horman.
 - 5/8:   Extend fix to also remove ixgbe_ping_all_vfs() from
          ixgbe_watchdog_link_is_down() to cover the identical race.
 - 6/8:   No code change; add [N/M] numbering.
 - 7/8:   Move dma_pool_alloc() outside get_cpu()/put_cpu() so
          GFP_KERNEL is used safely without sleeping under preempt-off.
 - 8/8:   Add Reviewed-by: Simon Horman; no code change.

---

Alexander Duyck (4):
  ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to prevent RX starvation
  ixgbe: add ixgbe_container_is_rx() helper and refine RX adaptive ITR
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

Aleksandr Loktionov (2):
  ixgbe: remove ixgbe_ping_all_vfs() from link state change handlers
  ixgbe: use GFP_KERNEL in ixgbe_fcoe_ddp_setup()

Jacob Keller (1):
  ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()

Aleksandr Loktionov (1):
  ixgbe: use int instead of u32 for error code variables

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 50 +++++++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 97 ++++++++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |  6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 +--
 6 files changed, 113 insertions(+), 59 deletions(-)
-- 
2.52.0
