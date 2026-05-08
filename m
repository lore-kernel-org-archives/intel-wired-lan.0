Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDFCD3427
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 03:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE53741453;
	Fri,  8 May 2026 03:12:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JFPBzV5ujAwB; Fri,  8 May 2026 03:12:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 70D3E4144B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778209952;
	bh=egTsxxbjWn8zGicnnWKNrK8Zm/PI2q3+DJgwsDjNA8c=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u/cZyG80FiBoSJQljvSEGsinfm4f78oPt/YUpNXxcdQL0SzlHXIoGkIzaTFn6+Bm8
	 7TFUlrKw0EFoEWzgvSBWhGNbUvtvWJT5xcs6cClboibLhRs+LqBhsm3XqCE0EhonAH
	 OuSnMsnmNXgl+n5V3OGHCXpKSUsBNYf1O1mKoeI6PDf6/K3JpDus8Cu/aWtxKKwFKB
	 PLI5tCuinsmw1LFAXeLpHpnY8NZlQtxlSxlcIix0AY3wYbQnwC5iACFLUlYC2OjLug
	 6U2voZo79ubbM6HgMyhtz7qYsCAddP64050T5oiQAMdU8+aejCeU1ezWez7mnyO022
	 FNb+4Y5gVzsLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70D3E4144B;
	Fri,  8 May 2026 03:12:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 36A9A272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C7FD409B5
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WH_IuqgPGNJE for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 03:12:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.17;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 03B8D4030E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 03B8D4030E
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03B8D4030E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 03:12:29 +0000 (UTC)
X-CSE-ConnectionGUID: XebH2Ii7SiyUPhjiE3JnFw==
X-CSE-MsgGUID: LWxIzmZDTmmnb9XYBybXRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027479"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="79027479"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 20:12:29 -0700
X-CSE-ConnectionGUID: BmjWfNWDQcWypu3CAzhaYw==
X-CSE-MsgGUID: 2RtA3QfuQIi8gEegXE6y+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="241623170"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa005.fm.intel.com with ESMTP; 07 May 2026 20:12:28 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Date: Fri,  8 May 2026 05:12:18 +0200
Message-ID: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778209950; x=1809745950;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5syTiBGIJkTfSWeQklIrIr7jq5li2r8OQfmkyePbRFQ=;
 b=jbix+BuYZv4aM0MREo3SfUXbY3eAeS3Ql1nfBg4E2Ht1PyY3oXIwpnR4
 c9/ghvpaWFXDIfjNCay2HLn0IxRIKs19GQdd5qR6yShaqEiQs7WcW3txt
 XZuRn7I3H6kGVBGOYGxNB6NgdNwyBjPcgjaoli9wjK/mNeBveW933OXYl
 6RzSLVHXCjGQ8ryRiDnLdUWPQOnxGayCx0/bw9pDnDAxFG7lRVw5pQE72
 XVYziPl1CyA5p/FvfGB/IwmTJLAbr8zf/kd1iY2GjQMm9lar1Yx55yx7E
 uja08yvrhmgbXboSbzbaq50immzRe8jV3a4FXGvTNMHPPe8IcoQGPfMtx
 A==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=jbix+BuY
Subject: [Intel-wired-lan] [PATCH iwl-next 0/8] ixgbe: small cleanups and
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

Eight independent cleanups and improvements for the ixgbe driver,
grouped by theme:

Naming / type hygiene (patches 1-2):
  Patch 1 renames ixgbe_q_vector::numa_node to ::node.  The field name
  shadows the struct device numa_node accessor, causing a sparse warning.
  The rename aligns with other Intel drivers (ice, igc).

  Patch 2 changes local error-code variables from u32 to int in six
  functions across ixgbe_main.c, ixgbe_phy.c and ixgbe_x550.c.  Storing
  a signed errno in an unsigned type works by accident for truthiness
  checks but breaks exact comparisons and proper propagation.

Bug fix (patch 3):
  Patch 3 rejects duplicate FDIR perfect-filter rules before programming
  hardware.  The same 5-tuple with a different sw_idx would silently
  consume a second scarce FDIR slot and confuse rule deletion.
  Returns -EEXIST to userspace on duplicate rather than -EINVAL.

Performance (patch 4):
  Patch 4 replaces the busy-wait udelay(1000) in the SECRX_RDY poll
  loop with usleep_range(10, 20) and raises the iteration count from
  40 to 4000.  Because usleep_range(min, max) is guaranteed to sleep
  at least 'min' us, 4000 * 10 us preserves the original 40 ms
  minimum-wait-before-timeout; worst-case grows to ~80 ms (acceptable
  since SECRX_RDY failing to assert is non-fatal and only logged).
  Typical stall on fast hardware drops from up to ~1 ms per iteration
  to ~10-20 us.

Code quality (patches 5-8):
  Patch 5 replaces ktime_to_ns(ktime_get_real()) with the direct
  ktime_get_real_ns() helper.

  Patch 6 factors the three-line autoneg-restart sequence duplicated in
  ixgbe_setup_phy_link_generic() and ixgbe_setup_phy_link_tnx() into a
  static helper ixgbe_restart_auto_neg().  The helper checks the return
  value of read_reg() and returns early on error to avoid writing
  uninitialized data to the PHY register.

  Patches 7-8 improve the adaptive-ITR algorithm in two steps:
    7/8: Limit ITR decrease in latency mode to at most
         IXGBE_ITR_ADAPTIVE_MIN_INC (2 us) per step so that ACK-driven
         workloads do not overdrive interrupt rate.  Uses max_t() to
         ensure the clamp never drives ITR below the algorithm's own
         computation.
    8/8: Add IXGBE_ITR_ADAPTIVE_MASK_USECS (= IXGBE_ITR_ADAPTIVE_LATENCY
         - 1) to replace the open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY
         mask in ixgbe_set_itr() with the cleaner AND form.

Aleksandr Loktionov (1):
  ixgbe: use int instead of u32 for error code variables

Alexander Duyck (2):
  ixgbe: limit ITR decrease in latency mode to prevent ACK overdrive
  ixgbe: add IXGBE_ITR_ADAPTIVE_MASK_USECS constant

Jacob Keller (2):
  ixgbe: rename numa_node to node in struct ixgbe_q_vector
  ixgbe: use ktime_get_real_ns() in ixgbe_ptp_reset()

Jakub Chylkowski (1):
  ixgbe: extract ixgbe_restart_auto_neg() to avoid code duplication

Maciej Rabeda (1):
  ixgbe: increase SECRX_RDY polling frequency in
    ixgbe_disable_rx_buff_generic

Piotr Skajewski (1):
  ixgbe: prevent adding duplicate FDIR perfect filter rules

 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |  5 +--
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 27 +++++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 19 ++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 42 +++++++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 12 +++---
 8 files changed, 77 insertions(+), 35 deletions(-)

-- 
2.52.0

