Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDDEC61DB9
	for <intel-wired-lan@archiver.kernel.org>; Tue, 25 Aug 2026 22:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C9AA60729;
	Tue, 25 Aug 2026 22:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QvkNVpM6bwmg; Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787698508;
	bh=jMyRwtFB0U79o2N3+KvWBE2jJvPbAcbUK9Uvcn5Bimw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=e26g+cEf1q3iAKYU6bvaJWIH+igkr/Im1IvLNO62SJLO1+ZKnzYegdLUgItTH1ogM
	 pTL00UVUQdTGE5oCtNnUbE/bMJ3Vd0fQT8WhxW4679CKHmRbFBwjXT144DLBq1COUM
	 p2dlHPmKYVdaSmC4CvwgRcwfzZ8AVBXIiiQMAFBJip+pcnrscdCHRvi/6f5Dut0CLf
	 zhN8rI8ImFniSw7g51h1XO86WIjpvV/X5VTJO01mvx9BZyecSskBudsygB2jLQRWtu
	 qb72ewQAwPpfxXyKl36t2FIVCBLpu5FfLJDP517VawrcIZHXUd/QeA+AEMQtJbQhe8
	 7RxJQ0mSFgDpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D1136073E;
	Tue, 25 Aug 2026 22:55:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59606334
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FD3E406FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9plIb4eMOjau for <intel-wired-lan@lists.osuosl.org>;
 Tue, 25 Aug 2026 22:55:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IgT6ajAP
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7EF5406B3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 25 Aug 2026 22:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787698506; x=1819234506;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=50a6BKc2T+uRXcttwH/a1UGf/K05PlGLRxjS+0bkiOs=;
 b=IgT6ajAPw/7FLnXcff0D8e3eQNQflvU3U0fY8TNfXkblypULft8yakWt
 S274IWmqdm8FBkQLA4t+sLpPVRJBTX1ZLBP3v0nHLJh/rOy/tMPzlfVa6
 ithzMDKGUMYFOY+Ru271+8q/nfuN7xGAzpjo5azsS5F3zoe4Om+JdZOMZ
 sbZGyDjGtHMIJ21HM2PiGw6MnajXsvRLSzLmGKQpKxBLERZhYWlZSebz4
 8bHmpkfsqkNELSIZjBQdhWgFVlAgBwxG4JgpwD/FujW3LszVfwqwkHJyZ
 ABMWMxTNhaE6Y9DMuFHKC+Dv8kJdUXFyaDl4S9m2rwJrhMZVBoAVjqkPV Q==;
X-CSE-ConnectionGUID: gzkVjciJSWOgHyaZD4SycQ==
X-CSE-MsgGUID: +XC60AMTQ92VtstEimSsww==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="87120412"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="87120412"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:05 -0700
X-CSE-ConnectionGUID: BF8UC2lkRmqDu2Hd+prZuQ==
X-CSE-MsgGUID: HLDFnR/jS6iwnuaT9L+qzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; d="scan'208";a="264789644"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 15:55:04 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net v2 00/14] ice: E82x: timestamp processing logic fixes
Date: Tue, 25 Aug 2026 15:53:24 -0700
Message-Id: <20260825-jk-e825c-minimized-fixes-v2-0-8223f95d26e3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOzQ6CMBCEX8Xs2TVtFSmefA/DAdpVFqGYFvGH8
 O4WOHuczHwzM0IgzxTgtBnB08CBOxeF2m7AVIW7EbKNGpRQR6FlhvUdSavEYMuOW/6SxSu/KaB
 OkqywloxMFUT84WkxIn0BfjXoqId8NcKzrMn0c/EcrTj0nf8sJwa5AOuekv/3BokCMyvSvaTyo
 BN9ZtdTszNdC/k0TT9E3TC+2wAAAA==
X-Change-ID: 20260819-jk-e825c-minimized-fixes-8559addec172
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: netdev@vger.kernel.org, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>, 
 alexander.nowlin@intel.com, kevin.bross@intel.com, ranjit.cavatur@intel.com, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>
X-Mailer: b4 0.17-dev-c276d
X-Developer-Signature: v=1; a=openpgp-sha256; l=9440;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=50a6BKc2T+uRXcttwH/a1UGf/K05PlGLRxjS+0bkiOs=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw+WZ3oBTmX7GKP272X0pCfbbrR+Oxdpm9OLEL6lrXfJ
 G8k5X3uKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCLqLgz/U6N+z/xSsTU+uMqM
 4VfdjUTxedEMjUfYnvXGfnsYXq1uz/C//NCjHYG/stYslV+x5L/Ooe+PV3pJefc9lihapLHLqkO
 VAQA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
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

This series contains several related fixes for the ice driver PTP logic
relating to timestamp handling and device (re)initialization.

Of particular note is some changes around the handling of timestamps that
are requested near device state changes such as administrative up/down
cycles and link change events.

The E825 device logic in the PHY has an internal counter which is used as
part of the "threshold" logic which determines when the device will trigger
an interrupt signal from a given PHY port to the MAC. This internal counter
requires some precise handling to ensure that the internal device state
remains in sync with software expectations. Otherwise, the device can be
finagled into a state where the PHY stops producing new timestamp interrupt
notifications to the MAC indefinitely. This in turn degrades the timestamp
processing latency and results in application failures for common
timestamping applications such as ptp4l.

There are four major categories of problem resolved by this series:

 * Timestamp requests made while the PHY_REG_TX_OFFSET_READY bit is cleared
   will increment the internal counter, but leave their valid bit set to 0.
   Upon read, the counter is not decremented. This leads to a desync of the
   counter and blocks the PHY interrupt.

 * Software logic for tracking timestamps incorrectly cleared in-use bits
   without waiting for completion in certain cases. If the timestamp *does*
   later complete, it leaves an "orphaned" ready bit which is not
   tracked by software. This results in the internal counter becoming
   desynced if that index is re-used.

 * The PHY timestamp memory region lacks pull-down zero-initialization at
   power on, resulting in uninitialized random data in the memory region.
   If software reads these values, an entry with its valid bit set to 1 can
   trigger a counter decrement and cause an underflow which results in the
   counter becoming desynced.

 * Timestamp request which complete near the beginning of the PHY losing
   link can become "stuck" such that the hardware logic triggered by a
   timestamp read does not activate. The memory status bit and the valid
   bit in the the timestamp index are not cleared. This window where this
   may occur begins *before* the firmware notifies the driver of link loss.
   When this occurs, the driver may accidentally re-use a stale timestamp,
   and the IRQ re-trigger logic triggers a repeated IRQ "storm" that can
   consume significant excess CPU time.

The series' primary focus is towards preventing driver flows that can
trigger the above sequences. It is based on work from Przemyslaw Korba which
was previously posted at [1]. During that series development, Petr from
RedHat reported the 3rd issue mentioned above. While attempting to root
cause that issue, several other issues were uncovered and those fixes have
also been included in this series.

First, the locking around the PTP ports list in the adapter structure is
converted to use RCU primitives and a spinlock, resolving a couple of
reports from Petr about places where the original list was accessed without
lock protection. Note that an older version of this fix used an xarray
instead of the list. The xarray has more overhead and results in an
increase of ~25 microseconds to the average latency for processing Tx
timestamps. The list is simpler and avoids this overhead.

Next, the PTP reset flow is fixed to stop tearing down the Tx tracker
during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
permanently after such a reset. This issue was found by Sashiko during
review of a previous version of this series.

Next, the ice_ptp_request_ts() function is updated to sequence the marking
of the in_use bitmap in order to work properly with the lockless reader in
the IRQ thread. This issue was reported by Sashiko during review of a
previous version of this series.

Next, come two fixes for E822 hardware that were originally posted as part
of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
work task is properly canceled during device reset, and new timestamp
requests are kept disabled until the validation task completes.

Next, Arkadiusz modifies the driver to stop pretending that the link has
gone down during ice_down(). This removes "virtual" PTP link changes that
occurred on several flows including MTU change, Eswitch setup, and others.
Now, the driver only triggers a PTP PHY timer reinitialization when the
physical PHY link has changed instead of during many other actions.

Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
bit. This bits only purpose is to tell hardware to mark any captured
timestamps as invalid. Since this also disables the necessary side effects
on read it is problematic to have cleared. According to hardware engineers,
keeping it enabled should not have any other side effects.

Next, the driver is modified to clear the PHY_REG_TX_MEMORY_STATUS by
reading each index *prior* to the PHY soft reset. This ensures that any
stale or invalid data left in the memory array is cleared, followed by the
counter being reset via the PHY soft reset procedure.

Next, the E825 timer start procedure is modified to first include a soft
reset. This ensures that upon link up the device is reconfigured from a
known-good state with its internal counter reset and everything cleared.

Next, Petr modifies the ice_ptp_flush_tx_tracker() function to wait a little
bit for any outstanding timestamps before flushing.

Next, Petr modifies the ice_ptp_process_tx_tstamp() function to avoid
releasing any index from software unless either a) it is actually completed
by hardware or b) it is timed out waiting for a full two seconds. This
closes the final gap from the second issue mentioned above. Instead of
immediately releasing the index, the software now waits until hardware has
completed it or the driver has waited long enough to be sufficiently sure
that no such timestamp will be done.

Next, the driver is modified to no longer mark timestamps as "stale" during
a clock adjust event. This avoids marking timestamps as stale unnecessarily.

Finally, the ice_ptp_process_tx_tstamp() function is modified to verify
that hardware actually cleared the ready bitmap. This ensures that we do
not report false timestamps near a link down event.

Link: [1] https://lore.kernel.org/intel-wired-lan/20260720120151.2675206-1-przemyslaw.korba@intel.com/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Two new fixes based on feedback from Sashiko review, including a reset
  issue surfaced by a CORE or GLOBAL reset, as well as a subtle issue with
  sequencing of the in_use bitmap.
- Fix the sequencing of kref_put when iterating the port list.
- Add kref_get/kref_put on ice_ptp_link_change to ensure that a link change
  happening concurrently with a teardown won't trigger use-after-free
  accesses.
- Avoid re-enabling Tx timestamps for E822 devices when the
  ice_start_phy_timer_e82x() function fails.
- Always trigger a link state refresh in ice_rebuild() instead of only
  conditionally, ensuring that after a reset the device is always
  reconfigured appropriately.
- Return the error if ice_clear_ptp_tstamp_eth56g() fails to read the PHY
  register, instead of silently ignoring it.
- Mark timestamps stale if we fail to read the ice_get_phy_tx_tstamp_ready
  bitmap, in addition to if the bitmap fails to clear.
- Check the return value of ice_check_phy_tx_tstamp_ready() to avoid
  triggering an IRQ if we fail to access the PHY.
- Link to v1: https://patch.msgid.link/20260821-jk-e825c-minimized-fixes-v1-0-9d0731eb4858@intel.com

---
Arkadiusz Kubalewski (1):
      ice: call PTP link change only from link events

Jacob Keller (9):
      ice: use reference counting and RCU for PTP port access
      ice: fix removal of PTP timestamp tracker during reset
      ice: set in_use only after preparing Tx timestamp index
      ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
      ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
      ice: E825: perform a soft reset when starting the PHY timer
      ice: remove unnecessary discarding of timestamps after clock adjust
      ice: skip reading Tx ready bitmap on ports with no timestamps
      ice: don't clear in_use until HW clears ready bitmap

Karol Kolacinski (2):
      ice: E822: keep Tx timestamps disabled during offset calibration
      ice: E822: cancel offset verification work during reset preparation

Petr Oros (2):
      ice: wait for in-flight Tx timestamps before flushing the tracker
      ice: keep Tx timestamp slots tracked until completion or timeout

 drivers/net/ethernet/intel/ice/ice_adapter.h |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  12 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |   7 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 363 ++++++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 104 ++++----
 6 files changed, 328 insertions(+), 176 deletions(-)
---
base-commit: dc4b95b8fee95113587e93ca116356032d271371
change-id: 20260819-jk-e825c-minimized-fixes-8559addec172

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

