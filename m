Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6513C9832E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EAE481103;
	Fri, 25 Sep 2026 23:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rsON32CzLenq; Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AF33C81104
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380689;
	b=GNynTErs7sd2L2NMVRV9EYDlW67c6zxWK8o5tKpisPIKIXVNTEWgsK+kFUVEJiDDKtey
	 bYxJbnPpzCI8X8uabXcGhXtd1BXLWGoJKoxfHpy40HaZ7plgpgzlYMFUulAk4E3y1bmdl
	 PLasRuwZN+VQZgvXFJ8M8639rDy7R1B6ll7ipV5lRSQepOHexCptafPZCNdW+iTYdSiSw
	 7ELhet8HiG94GGWro+9amJCOtIUlVoKn0fIt4P1HwQu/IJdT+TyI+h1bHvvLtxHnQeU44
	 w3C/pWpAvIs2c08rquDWJDlHCOHri3VS6b3lHxqfPLFa6HrY1QRF0QzuLToAfxTlffQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380689;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aSoOjZIXvg3TKhmc/NFWC+ETNTqGaLlCG8qONQfcWqQ=;
	b=KP0zN+BgJTHkcp9cyPGiNQeQLCvPes5zvTD7/+9Hi0py7kEehCdUuqMN4Zm3zxpZPzzX
	 EGLQS2uQjR0SGMfb+h3HEYr1OHFjmllvEB+4YCHzpH9QHXhc4ndCtl9yu5hksaGMmXDjE
	 aupe0EHbTFb18mMwDGqI00UzxwYubDWaWMdtoMhCDuvxbIPcM0uU4WcYJ+BOmgXAN78Mi
	 uZAJkNft3+iPYhnTmOyX2LwySF7gTKlZLIiLFAADS6nmVtDmlBsAFJ/G5IK/OFX9yijz8
	 CcBPoFvHDy5UzDzxxthUEytkmlgif+Zc828wYCJGYUkzne9b/mOwiKtID5ag4qWKjbg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380689;
	bh=aSoOjZIXvg3TKhmc/NFWC+ETNTqGaLlCG8qONQfcWqQ=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ea9w8HB14hw7/UZv8/xkcJ5Y/3v2kBt6zA59StjuUog6CVkybeESfLZjjqEvaLQFg
	 gHoFqiy97pwa9+NlU239DufUhhlqKOertgh0K8d7LGL5VAZRA8iTyDmEvI4m8/mJSD
	 Skjir9m7PKL/UCT8v3EG8/UTsORqJtrlv0ur+uj0YWjeYd9Cld2xWbG2VfuuwKZ7e3
	 X8NfMFITnCE/dD7pjeJ3vLKXnl66xJkKbMIj4+EOM62E8ZMbr//wOQ8uT9uYToZYNE
	 7RbLc5k/yijKsr/3cg/PqM0VHK8XkI1LSImONnwxHDQ0jnmeXs/CSvv2vTPPAj+jfL
	 SK1czsXC/W0VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF33C81104;
	Fri, 25 Sep 2026 23:58:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 99A59355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8B80C40B6D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSlu5qL7tziU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5B60040B46
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380684;
 b=Lv6vR4AWut/Iuh/TUMWIB1F/pOV5cCpHMlRDG52767uk64KbFxD/sEFvxfzY4fBSC647
 J5vmRTzJdHYTRNxyo/iPK8EJk9IuB1tG5lnO/Jfa5QN5SrGAd2uL68W4Cq+HLe752xnXm
 KA8v2bBkTO102r/Q1LJxbjy6l28MC759OVoy6WdblU13Cy7jwrC0F3BUpgnTIlaF0nSKq
 BRcixVXgj9pjrMFcTDkMuogV287LilmJ3gUdJ6wb6d0X2tzRqAXO5JZEn6C0fpmvU4rfJ
 O3lbNK/RvIvIUVQxh57mAIngKZH1A3mwFQcuN6H7RpppIuvYNlft1UbAzjkv0hTmrLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380684;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aSoOjZIXvg3TKhmc/NFWC+ETNTqGaLlCG8qONQfcWqQ=;
 b=KvC1j1XhVXn8PCNSj+e0gnFaKKjRXmS2f5SFgVBa9igTZ9bKYeA/8gJBau+KEIe8hwo5
 4kbchU2pVDGW3Ap/LOcLK/1ZLeYaau3jocEqvsW96RysJeRm5i9TJxtfBbN32Ug6GJDGB
 VE7DbX+RBucza79/1wydfvcWm2kVxJUgsgzMBqfNgURgBamo+WunHPwxd4zdOXaFoTG+u
 1LQo27AQimdDlbLoa0AeZ0o4Nzo3zt6SjkH3QpPZSU6mF0YMyrzf3HR4ohFJkiEZeiVkI
 wIpHHfEbi/meiAm3GEBK1Vg1mscJj9NXnfGr6l/jFGwy5AJq/JFfBbtkIsE2CAIlexA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RvB90wTT; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=RvB90wTT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5B60040B46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380684; x=1821916684;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=wxIkgrWMKmdiZynVui/VQyCMhAdno0fMcugGeoM7aww=;
 b=RvB90wTT91AaY9KDZgYHweSkyuNhTtcLh9KyyPJbpkbIRJTwt8y9g0O9
 ek8iFwyi+srsvJzeKoLngsCQt4Fr6X/OjNnjkKUWDDrLzJxhwNOI33z9d
 SaHUm4mxPk9G4TwnXOQn5/zo0phLB7AKVhuKQZtKqnNUZdb9UTCEhFnu1
 BU4JiEum/YVlW78b0N1g80qOQDj+wmQh9g2488HRwWa18pxY2eZCSt8ml
 N5Vb/u2ZGgIMVBD1zRTSq8SEhjL9MCUlhzsTFxaoXgdvo3K1EfHadWu0T
 Iiq7ALgym5JQddPdLfRonSBISCrvvWc9Sbz/1FhESc3ih83Hsh0F1LDGF w==;
X-CSE-ConnectionGUID: 5XVwSJ/pRlSR+oqTY2Pesw==
X-CSE-MsgGUID: WGykk0jfQYSDsvVui4g+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212801"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212801"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
X-CSE-ConnectionGUID: upI6WWwIT76XbVWLhQD8Mg==
X-CSE-MsgGUID: LzknCTYcRmSsETzjlDFY7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731098"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:01 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net v3 00/15] ice: E82x: timestamp processing logic fixes
Date: Fri, 25 Sep 2026 16:56:32 -0700
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOTQ6CMBCFr0Jm7ZhaAoor72FY0DLgKLSkU1Bju
 LsIJ3D58v6+DwgFJoFz8oFAEwt7t4h0l4C9Va4l5HrRoJXOVXE44v2BdNKZxcg9Saz6AYfgLYm
 wa7HzLVts+EWCEuyIjVEmU3Wa0kHBMjoEWt1l8wr87NBRhHIzZDR3svF394veWKIP7xVt0mtho
 9D6X4pJo0LKMpMXulaUmwu7SN3e+h7KeZ6/wVQqHAcBAAA=
X-Change-ID: 20260917-jk-e825c-timestamp-processing-logic-fixes-srcu-fb0b50d33e10
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Petr Oros <poros@redhat.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=20429;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=wxIkgrWMKmdiZynVui/VQyCMhAdno0fMcugGeoM7aww=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXMWaHtNF/u84fC808lyacOw5jpr63+oGVyVYeqsr3
 07Y4rm0o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIl4zWf4wzuHWe5fkWb4hNYT
 vP5XvSas3VMhc5lR7kri2ud/JNJmHmf4xfRpxezs7eJ5f+xXXv32TfF6XtKBlQK3zL0tGuc+FAh
 ewwEA
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

Jake Keller says:

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
   bit in the timestamp index are not cleared. This window where this
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

First, the PTP reset flow is fixed to stop tearing down the Tx tracker
during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
permanently after such a reset. The fix also ensures that all teardown
paths properly release the tracker. This issue was found by Sashiko during
review of a previous version of this series. 

Next, the locking around the PTP ports list in the adapter structure is
converted to use RCU primitives and a spinlock, resolving a couple of
reports from Petr about places where the original list was accessed without
lock protection. Note that an older version of this fix used an xarray
instead of the list. The xarray has more overhead and results in an
increase of ~25 microseconds to the average latency for processing Tx
timestamps. The list is simpler and avoids this overhead.

Next, the PHY restart locking is fixed to avoid an issue with a concurrent
execution of ice_ptp_restart_all_phy() and a link change on a given port.
Additionally, the PHY port locks are merged into a single per-adapter lock
to reduce locking complexity.

Next, the ice_ptp_request_ts() function is updated to sequence the marking
of the in_use bitmap in order to work properly with the lockless reader in
the IRQ thread. This issue was reported by Sashiko during review of a
previous version of this series.

Next, Arkadiusz and Jake modify the driver to stop pretending that the link
has changed at administrative ice_down() and ice_up(). This removes
"virtual" PTP link changes that occurred on several flows including MTU
change, Eswitch setup, and others. Now, the driver only triggers a PTP PHY
timer reinitialization when the physical PHY link has changed instead of
during many other actions.

Next, come two fixes for E822 hardware that were originally posted as part
of Przemyslaw Korba's work [1]. The E822-only "vernier" offset validation
work task is properly canceled during device reset, and new timestamp
requests are kept disabled until the validation task completes.

Next, the driver is modified to stop clearing the PHY_REG_TX_OFFSET_READY
bit. This bits only purpose is to tell hardware to mark any captured
timestamps as invalid. Since this also disables the necessary side effects
on read it is problematic to have cleared. According to hardware engineers,
keeping it enabled should not have any other side effects. Instead, the
tx.calibrating field is used to disable new timestamps from software in a
similar manner to the older E822 devices.

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

Next, the ice_ptp_process_tx_tstamp() function is modified to verify
that hardware actually cleared the ready bitmap. This ensures that we do
not report false timestamps near a link down event.

Finally, Maciek adds a needed PHY recalibration for E825-C after large system
time adjustments. Without recalibration, PHY timestamps do not properly
converge to the new time, resulting in inaccurate timestamp readings.

Link: [1] https://lore.kernel.org/intel-wired-lan/20260720120151.2675206-1-przemyslaw.korba@intel.com/
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes since v2:
- Drop the timeout on waiting for kref drain. The synchronize_srcu() makes
  it moot, and its only purpose is for a case that won't happen without
  programming errors like a reference leak.
- Check for errors on init_srcu_struct() when initializing.
- Hold the ps_lock in ice_ptp_link_change() earlier, as it is safe to
  acquire around the dplls.lock, which simplifies the reasoning for the
  given patch as well as following patches in the series.
- Re-order ice_ptp_init_port() in ice_ptp_init() to happen prior to
  ice_ptp_setup_pf() so that the Tx timestamp tracker is already
  initialized before the PTP port is inserted into the list. Ensure that we
  also tear the tracker down only after the port has been removed from the
  list.
- Re-order the patch that adresses PTP link changes to be before E822
  fixes, since AI pointed out that one of the issues was addressed by the
  link change re-ordering.
- Revert back to kthread_cancel_delayed_work_sync() instead of
  kthread_flush_work() since the latter doesn't safely handle a delayed
  work task.
- Fix the ordering of the parameters in the warning in
  ice_clear_ptp_tstamp_eth56g().
- Add a note about the E810 hardware skipping the
  ice_ptp_maybe_trigger_tx_interrupt(). The hardware doesn't have the same
  ready bitmap issues as E822 and E825. There is a possible gap because
  nothing will re-arm and sweep the tracker if all 64 slots are filled.
  However, there is a pre-existing issue on E810 where triggering a new
  timestamp interrupt could cause issues with outstanding low latency
  requests. I can't fix that in this series, and plan to address it as a
  followup.
- Check tx->init in ice_ptp_mark_tx_tracker_stale.
- Call ice_ptp_mark_tx_tracker_stale when stopping the PHY timer for E825,
  preventing existing outstanding timestamps from being reported with a bad
  offset.
- Update the dev_err on failure in ice_ptp_port_phy_restart() to better
  reflect the magnitude of the problem, and indicate a link toggle may help
  recover.
- Update some comments and kernel doc messages for clarity.
- Skip maybe_trigger_tx_interrupt for the E810 low latency interrupt path
  only, not for the older legacy paths.
- Re-order patches so that the Tx tracker fix comes first before the PTP
  port SRCU changes. This should avoid some spurious reports from Sashiko
  about ordering guarantees which are fixed by that change.
- Link to v2: https://patch.msgid.link/20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com

Changes since v1:
- Convert to sleepable RCU instead of the convoluted and likely broken
  dropping of RCU readlock critical sections.
- Update the messaging to be clear this does not solve the ctrl_pf access
  issues.
- Update the comments regarding the teardown and 15 second timeout to
  better reflect the intention.
- Drop the patch that reverted marking timestamps as stale during an
  adjustment. It may be safe for some smaller atomic adjustments, however
  possible issues were reported for larger adjustments by multiple models.
  Since we do not have many reports of missing timestamps, just keep the
  logic as-is.
- Add a new patch to correct serialization of the PHY port restarts to
  avoid a potential re-ordering of the link_up status causing the port to
  be left in a disabled state if a race occurs near a link up transition.
- Fix the PTP teardown during a failed reset to avoid leaking the Tx
  timestamp tracker and other PTP state.
- Add smp_rmb() to the lockless in_use reads in
  ice_ptp_process_tx_tstamp() ensuring that weak ordered architectures do
  not re-order the start time in the event of a race with a new timestamp
  request.
- Update the patch which drops the E825 clearing of PHY_REG_TX_OFFSET_READY
  with a software gate of new timestamp requests via the tx.cablibrating
  field, so that new requests will be rejected until the PHY has been
  initialized.
- Update the fixes tag for one of the E822 fixes to better reflect the
  actual kernel that introduced the problem.
- Update several commit messages and comments for clarity and accuracy as
  suggested by Sashiko during review.
- Since the E822 offset validation work already checks and reschedules when
  the driver is resetting, replace the kthread_cancel_delayed_work_sync
  with kthread_flush_work() to ensure that it sees an updated state. This
  avoids some complex changes that would otherwise be required to be
  certain that a reset with a concurrent link change wouldn't result in the
  offset task being canceled indefinitely.
- Use READ_ONCE/WRITE_ONCE when checking the link_up field of the PTP
  state.
- Treat failure to read a timestamp during the E825 sweep before a soft
  reset as non-fatal with a warning. In practice, if a read is skipped we
  still should not have a problem unless other code incorrectly reads the
  index without checking the PHY ready bitmap first. To avoid log spam if
  the device is truly inaccessible, the total read failure count is
  summarized in one message per port.
- Remove the unused soft_reset parameter from one of the E825 functions.
- Fix the watchdog re-trigger of the timestamp interrupt to work for
  devices which manage their own interrupt, instead of only on the clock
  owner.
- Fix the accounting for timed out timestamps in the unlikely case that a
  timestamp will timeout but suddenly have its ready bitmap bit stuck high.
  Now, the timeout counter is only incremented once the timestamp is
  actually dropped.
- Update commit message and comments to better reflect current
  understanding of the PHY soft reset behavior including its (non)impact on
  configuration registers.
- Switched to read_poll_timeout for the tracker drain logic to get better
  timing behavior.
- Skip the tracker drain on E810 with a has_ready_bitmap flag check.

Possible outstanding issues not addressed:
- ctrl_pf serialization and access is not handled by this series. Another
  developer has been investigating this and is still undergoing feedback.
  Perhaps the solution could piggyback on the port reference count, but we
  do not yet have a complete solution.
- Recent reports of missing PTP semaphore locking on certain flows are
  being investigated by another engineer and will be handled as a follow
  up.
- The low latency timestamp interface for E810 appears to possibly have
  some gaps and potential to override an in-flight timestamp request. This
  will be investigated as part of a separate follow-up series.

AI reports that may still remain:
- Sashiko pointed out some ideas about flushing the tracker when we restart
  the PHY port for E825, which I have not opted to implement in this
  series. It still needs investigation and I am currently thinking that it
  is best if we always keep timestamp indexes locked by software until we
  wait that 2 seconds. There are just so many ways this can race and go
  wrong :\ Relatedly, Sashiko also pointed out some potential races with
  flushing the trackers, which I will investigate but do not think should
  hold this series up.
- Sashiko pointed out that the behavior of restarting the PHY ports
  post-reset may be somewhat problematic. This needs investigation and I do
  not yet have a solution. In particular, we can't just let each port do
  its own restart because we need to be sure that the clock owner has
  finished setting the time, but we also cannot necessarily just let the
  clock owner handle it either because the clock owner cannot reliably know
  the link state of the other ports. This is being investigated as well,
  but I would prefer to not hold this already large series up for this.
- Sashiko has complained about potential for missing link event triggers
  since we no longer call ice_ptp_link_change() at ice_up_complete(). This
  seems to be a theoretical problem which I don't have a good solution for.
  The attempts to fix this in previous versions has consistently still led
  to complaints from Sashiko. We need to investigate what mechanism would
  robustly ensure that any link transition or failure to program the PHY is
  not missed and can be restored. However, I would prefer not to delay this
  series while we try to figure that out.
- Sashiko suggested clearing the PHY soft reset device state if the
  function exits early. I opted not to change this flow as it was the
  suggested flow from hardware engineers, and the chance of failure in this
  flow is low and likely already implies a more catastrophic failure (i.e.
  failure to access the sideband queue).
- Some models love to point out places where we bail out on failure to
  access the PHY and leave various flags or state in a disabled way, such
  as not clearing the calibrating flag or leaving the PHY with its soft
  reset bit set. I did not make an attempt to fix these. It is very
  unexpected to be unable to access the PHY, and we're more or less
  treating such failures as catastrophic.
- Sashiko complains about possible ways that ice_ptp_process_tx_tstamps()
  could fail and exit early that would cause problems, either keeping an
  SKB held in memory and essentially leaked for longer than expected, or if
  we fail to clear the in_use bits and could keep re-triggering the IRQ.
  These are highly unexpected errors which are pre-existing issues that may
  be tricky to address, and I haven't attempted to resolve them here.

For those interested, here is a summary of the latency numbers for Tx
timestamps on my setup for comparison throughout the series. In all cases,
the ptp4l test used a profile with a sync rate of 16/second and the
"torture" test additionally operated a second thread on another port
operating a burst of 32 concurrent timestamp requests every 10
milliseconds, all operating on E825 hardware, with a 3minute capture time
for each test.

1. Before this series

  ptp4l only
  Mean: 298.67 microseconds, stddev: 28.60

  ptp4l + torture
  Mean: 637.02 microseconds, stddev: 351.59

2. After SRCU rework

  ptp4l only
  Mean: 314.10 microseconds, stddev: 32.99

  ptp4l + torture
  Mean: 622.68 microseconds, stddev: 343.57

3. Everything up to keeping Tx timestamps tracked until completion

  ptp4l only
  Mean: 317.43 microseconds, stddev: 34.51

  ptp4l + torture
  Mean: 622.31 microseconds, stddev: 339.26

4. After rechecking the HW ready bitmap

  ptp4l only
  Mean: 184.98 microseconds, stddev: 53.79

  ptp4l + torture
  Mean: 719.71 microseconds, stdev: 321.195

5. After the full series

  ptp4l only
  Mean: 195.92 microseconds, stddev: 25.28

  ptp4l + torture
  Mean: 717.77 microseconds, stddev: 321.58

The run-to-run variance here is somewhat high, but its clear that
timestamping across multiple ports under heavy load has a significant
latency cost. This is to be expected due to the nature of serializing the
timestamps to a single IRQ. In the usual cases with a lower timestamp load
and especially if ports do not have active timestamp requests, the series
has a decent reduction in timestamp latency. The use of Sleepable RCU does
seem to have a minor latency cost but it is overshadowed by the improvement
to elide checking when there are no requests in software.

Hopefully this version will pass testing and AI review @_@

---
Arkadiusz Kubalewski (1):
      ice: call PTP link change only from link events

Jacob Keller (9):
      ice: fix removal of PTP timestamp tracker during reset
      ice: use reference counting and SRCU for PTP port access
      ice: fix PHY port restart serialization
      ice: set in_use only after preparing Tx timestamp index
      ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
      ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
      ice: E825: perform a soft reset when starting the PHY timer
      ice: skip reading Tx ready bitmap on ports with no timestamps
      ice: don't clear in_use until HW clears ready bitmap

Karol Kolacinski (2):
      ice: E822: keep Tx timestamps disabled during offset calibration
      ice: E822: cancel offset verification work during reset preparation

Maciek Machnikowski (1):
      ice: Recalibrate PHY after settime64 on E825-C

Petr Oros (2):
      ice: wait for in-flight Tx timestamps before flushing the tracker
      ice: keep Tx timestamp slots tracked until completion or timeout

 drivers/net/ethernet/intel/ice/ice_adapter.h |  20 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  20 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 504 +++++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 137 ++++----
 7 files changed, 479 insertions(+), 232 deletions(-)
---
base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
change-id: 20260917-jk-e825c-timestamp-processing-logic-fixes-srcu-fb0b50d33e10

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

