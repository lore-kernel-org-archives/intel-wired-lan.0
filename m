Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB56C4332F
	for <intel-wired-lan@archiver.kernel.org>; Tue,  1 Nov 2022 22:53:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C0B9C400EF;
	Tue,  1 Nov 2022 22:53:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C0B9C400EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667343193;
	bh=fr/WNvkF8oJpuyQKlaC0sDbVenLAQ8i4so9wdTx0QGQ=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ZYPagm5cOC/0VYlB99afr4lFQ3JyR+8Pk6sqHrcyRTkQGXn5b4eqtr6YFkkx//m3/
	 8MUmFxI47wr3OL91bWZR1phSEfReewYGVmje0shkCEVPlwB9mQlktY7BZxdeiNpq5m
	 xPV+H0gs/8HPbzv4w33FC+Q7TDBS/TvEduuXEw4fMFdCajnTgVd4DPFR8tc22WN7dC
	 8ckgbFQqxv3iBnilQgmDgjWEI0vpFwvpqijfJ5pi6PAzYCV4W/tBFW96zLgr8nf7Vv
	 YDXfOSlyAd8u9cf17Y+DYt4ivb6FIgHg5fZKa9eSqE24dZbaep6yfKMfMYwVJkg7/f
	 eQOIHghz77nXA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kVtkIpBeUBpT; Tue,  1 Nov 2022 22:53:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 82BBE4064D;
	Tue,  1 Nov 2022 22:53:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82BBE4064D
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 98D041BF3E8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Nov 2022 22:53:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 78F7F4074E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Nov 2022 22:53:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78F7F4074E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qIiX7z5dGV6s for <intel-wired-lan@lists.osuosl.org>;
 Tue,  1 Nov 2022 22:53:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E2B4408A8
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E2B4408A8
 for <intel-wired-lan@lists.osuosl.org>; Tue,  1 Nov 2022 22:53:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="371348102"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; d="scan'208";a="371348102"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2022 15:53:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="723324011"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; d="scan'208";a="723324011"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.7])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2022 15:53:08 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Date: Tue,  1 Nov 2022 15:52:25 -0700
Message-Id: <20221101225240.421525-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.38.0.83.gd420dda05763
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667343190; x=1698879190;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+ZX/VeLVtzJr+CNbsz6xv1sTqIBYIku+4ORSXewTuVY=;
 b=Cs+iYiCsbbBSjJ0Mabhcxwitw2AX8ecpaagkXk2qT1pT+L3wIJ65CzUZ
 BT1qF3N6q14tS1v5hXWmxu6Mvu5MPT5aqTjhl6HNpVBN4s/iTbI/Qa4L2
 6G5ow7qhMbkzG30idRZbRBWW0iamQycgaI527FUKGGm//L+9AZJ0PdrOz
 KN1UAbVR8vQvSQyEBDGq7koxXilHd5pQ78CXUVKzuUSOeMMx7GH7YRte5
 l/G7+5c757gHljrUrWjVm5IvkCWoLAlQZ+oJri5YPt+KJuKxaDfIHqCyE
 Vu60EnfZ1KD/gG0Wt/KRYR2AaUY1aDdBj5Rgrn+s0s/k659MDQ9ZvMF/x
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Cs+iYiCs
Subject: [Intel-wired-lan] [PATCH net-next 00/15] ice: improve Tx timestamp
 corner cases
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

This series of patches primarily consists of changes to fix some corner
cases that can cause Tx timestamp failures. The issues were discovered and
reported by Siddaraju DH and primarily affect E822 hardware, though this
series also includes some improvements that affect E810 hardware as well.

The primary issue is regarding the way that E822 determines when to generate
timestamp interrupts. If the driver reads timestamp indexes which do not
have a valid timestamp, the E822 interrupt tracking logic can get stuck.
This is due to the way that E822 hardware tracks timestamp index reads
internally. I was previously unaware of this behavior as it is significantly
different in E810 hardware.

Most of the fixes target refactors to ensure that the ice driver does not
read timestamp indexes which are not valid on E822 hardware. This is done by
using the Tx timestamp ready bitmap register from the PHY. This register
indicates what timestamp indexes have outstanding timestamps waiting to be
captured.

Care must be taken in all cases where we read the timestamp registers, and
thus all flows which might have read these registers are refactored. The
ice_ptp_tx_tstamp function is modified to consolidate as much of the logic
relating to these registers as possible. It now handles discarding stale
timestamps which are old or which occurred after a PHC time update. This
replaces previously standalone thread functions like the periodic work
function and the ice_ptp_flush_tx_tracker function.

In addition, some minor cleanups noticed while writing these refactors are
included.

The remaining patches refactor the E822 implementation to remove the
"bypass" mode for timestamps. The E822 hardware has the ability to provide a
more precise timestamp by making use of measurements of the precise way that
packets flow through the hardware pipeline. These measurements are known as
"Vernier" calibration. The "bypass" mode disables many of these measurements
in favor of a faster start up time for Tx and Rx timestamping. Instead, once
these measurements were captured, the driver tries to reconfigure the PHY to
enable the vernier calibrations.

Unfortunately this recalibration does not work. Testing indicates that the
PHY simply remains in bypass mode without the increased timestamp precision.
Remove the attempt at recalibration and always use vernier mode. This has
one disadvantage that Tx and Rx timestamps cannot begin until after at least
one packet of that type goes through the hardware pipeline. Because of this,
further refactor the driver to separate Tx and Rx vernier calibration.
Complete the Tx and Rx independently, enabling the appropriate type of
timestamp as soon as the relevant packet has traversed the hardware
pipeline. This was reported by Milena Olech.

Note that although these might be considered "bug fixes", the required
changes in order to appropriately resolve these issues is large. Thus it
does not feel suitable to send this series to net.

Jacob Keller (11):
  ice: fix misuse of "link err" with "link status"
  ice: always call ice_ptp_link_change and make it void
  ice: handle discarding old Tx requests in ice_ptp_tx_tstamp
  ice: check Tx timestamp memory register for ready timestamps
  ice: protect init and calibrating fields with spinlock
  ice: return true if Tx tracker is uninitialized
  ice: disable Tx timestamps while link is down
  ice: cleanup allocations in ice_ptp_alloc_tx_tracker
  ice: handle flushing stale Tx timestamps in ice_ptp_tx_tstamp
  ice: only check set bits in ice_ptp_flush_tx_tracker
  ice: reschedule ice_ptp_wait_for_offset_valid during reset

Karol Kolacinski (1):
  ice: Reset TS memory for all quads

Milena Olech (1):
  ice: Remove the E822 vernier "bypass" logic

Sergey Temerkhanov (1):
  ice: Use more generic names for ice_ptp_tx fields

Siddaraju DH (1):
  ice: make Tx and Rx vernier offset calibration independent

 drivers/net/ethernet/intel/ice/ice_main.c   |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 576 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_ptp.h    |  29 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 336 ++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |   8 +-
 5 files changed, 484 insertions(+), 474 deletions(-)


base-commit: 1516071e3b9d1f2ba59eabaa4ef49e077c5348d2
-- 
2.38.0.83.gd420dda05763

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
