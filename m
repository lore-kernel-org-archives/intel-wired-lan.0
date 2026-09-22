Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD46C98307
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A315C6067D;
	Tue, 22 Sep 2026 18:08:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZ3yq1yowBcv; Tue, 22 Sep 2026 18:08:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1F78F6067F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100510;
	b=COcrw3ECiLIyHUoIqsoSh7cOCjFr7Pi5T1R6pMqU3yULutU+6JtEC3I3tJijXOv3oZSd
	 3JPMqlqq5amY7MmP2vV9PjqEUHDu7xw70dCAt+KKuXCLCxuJAa/jRv/qOPAVG8MsekHdf
	 VXWVp7Vv0Bq3YkE+eB/V7WYdSfan0qXyJwYRDeHEMAk1OrdU+9Gn5njebDhTwDDaYs5Vn
	 fFxmqzmW3X5z/iVrH+zvgiPdqD3fw5pcbf+MkDGgTie1CKPrgHrzQA3lTOikQKk00FXSn
	 V9Kdmor+wzQYhfFJ/4BuSFa2Uuf/Qk2jl/Nc2N4jvYIE4qY1nyzCZiqU0vVbhrg1V9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100510;
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
	bh=HswS1Onlf8I/kNam8F7JJ5GN3r2XhLM5r3ImBh7qnfg=;
	b=YNlSJbuODs8nQpi1Aj/WMy6U14kJi68rG9lorIDvQHUdjRKpjUJuijnSdyXLo8Rwb7e0
	 QAJPBP9tGOVWay3MML10iZMsJ5w78BuXP4rmw/rPZbbi9WB0yiaggWd4kG3ZNhMAx82Px
	 Va3Ikp91EZfjEjnnjC8WPtplzOYWfMU8DVb6MbBzm4hB+RY+eC6lww1iHkrsnC5LfIjJ0
	 XC4tOrEeWkQF1pqg7mcBg6hqD9g7mxiIt1t5fe9rp/Vo1bc5E8Y4JOf7VVMsmTR0cnZzf
	 leY4gUtZQbTSHzFxCMhE1z2JW+rsybtGuaMEklLs0L7aVV0W8VnQ4CvygLI5GtOtsAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100510;
	bh=HswS1Onlf8I/kNam8F7JJ5GN3r2XhLM5r3ImBh7qnfg=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8F4gM1KE5qQD1FLFDwFLhfDkvoMePr3UNWu5xY+gaK8qWf8xiV8sDVI1vkP+rYZY3
	 NMynhnidnJ+IrMgA1apJNYriR+8ODJtd7FdGQ4zR/76Iaep2JRCL5HoW5JUwY+FEt8
	 GNUQxqIa0OgzJL2zjtcYZLW+rmhyR4ootT6OyInc4SlXj6evpl8L/okicRZWmGBcgT
	 PV7tJCRA8ehf3BxMbH1KupLMhTu0g215ntm+1cmG+bswPCohmkpXTbECSfLhZSJhpD
	 BesIgQuCLGQgZ6IlatZRpdyNx+3e6jcHbAwAtn/gcT86z0agbj2wkze8lymcLoqwjh
	 8sYFEqRWHSVCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F78F6067F;
	Tue, 22 Sep 2026 18:08:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4767F3A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2E64940760
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4W0L7OtyrJyX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 74F3B406FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100505;
 b=KfryFTORiGiF2KZywk4+PALCzyDReP9qq6G9GnmLVRUUHvz/xWVtiZddYTcOSNymltfm
 1ZxBpIGmoauAk2PZAf6qFUq+1tHvRZYcONSDHlShM0MLRODC83lpLEAdMEBOO/pLb6KuI
 dUy1jiKV1uzb6lIBP20zkBy8d3LdFLxBIUIJLa13a3yWwy3/m91coSG63ui6tPIERBxi2
 KwdGnRDPwG27QeeJOnLxrmoe2O27ZMlX8suWwq/g1U9fFO5eHheTAz2eqmj4PtqoB07AC
 cI9ez6n8z1wiioCyqE0xGFpt6TJGIDGmv2FO/okbkvd6xbYhIn9i01C0Shx5LXIVVog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100505;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=HswS1Onlf8I/kNam8F7JJ5GN3r2XhLM5r3ImBh7qnfg=;
 b=Ey2EHrAmq4HuYojg+lMH08NiADfVB3+8gt9E77UO2lARLaJ8T5mFuUcPf5RjBYC35wQk
 hO/WYYhRDnsrUorByBp9e2Fh/GP+tW8IP4Z6WtvwVv42oLFQqnn3P1BkTWWBlfpc9Y+m6
 qTUcUXd+0g+C+msoh2iE/UEQUMdBQOt5MhaaLUsqRJZOvp5vZlKSUqgMgEbAx3kwSIQxR
 kdkPmQLAQGY/FOm+f8Dh9En78lClK4zcxFg78NovVc17+aG9+u8NgOkLDOI5/T+OvFwSA
 H7aYoOYt3U5Oj8jdSQNAu48hHmkR46Q9cpKj7HfiKOqh78YpvWS7LEf0jS2ImPIoCNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nsy2Q+4a; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=nsy2Q+4a
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 74F3B406FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100505; x=1821636505;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=FlTnsyl2fUj5brDNUl3Bfa+LJZTQo0YAHTitI2TsfcQ=;
 b=nsy2Q+4aPzTMQonIJiXwR/88oWK4rXIzcB65k4zfOMhU/2rZ1BnLa/PB
 kqV6aboNGb4g7zR1RfynJ7xJOiiozxGflJjrfCPeYsr4CZeUVzm+uu9U7
 QZKsXeEpwzPHRyd2RzgXlRVuSHZ6jgluWt/XpyNZ1+YBfdtcvtNZklM2B
 lPm1Ae+F9j0loRYfDo+1X3ySgvrSsisLz9wdVZBZwLHVI9zXqLtOODjv1
 OqEDCo73e76KNACIRr8oVsQzcE0C6w4q7Z1mCz4xSvSQP1bH5QpdMFeNR
 TN/QvlrC7K62YVzmvHlOsIgkEBlJOTj0fUkEu7wsMUUGmwPmrcdzvsmMU Q==;
X-CSE-ConnectionGUID: fNxUnx6cShiUroRhuj6AZQ==
X-CSE-MsgGUID: /DFN1lU2TBWpza4jGemcuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232021"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232021"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:22 -0700
X-CSE-ConnectionGUID: l534vM5BSFqKCjO/02ioOw==
X-CSE-MsgGUID: WlwZzwlwSNiia22IlyO0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315289"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:22 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-net v2 00/15] ice: E82x: timestamp processing logic fixes
Date: Tue, 22 Sep 2026 11:02:33 -0700
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNyw6CMBAAf4Xs2U1KCb5+xXCgZamL0DbdoiaEf
 7fqcTLJzAZCiUngWm2Q6MnCwRfQhwrsvfeOkIfCoJU+qkt9wumBdNatxcwLSe6XiDEFSyLsHc7
 BscWR3yQoya44GmVaNTQN1QpKNCb62dK8Ab9m9JSh+wtZzUQ2f3ew7x8e1TxQmwAAAA==
X-Change-ID: 20260917-jk-e825c-timestamp-processing-logic-fixes-srcu-fb0b50d33e10
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, Petr Oros <poros@redhat.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=16791;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=FlTnsyl2fUj5brDNUl3Bfa+LJZTQo0YAHTitI2TsfcQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNhwX3uEcxtWVLlOoFC5hJn1jxwMjtSblUvMMlmX3nI
 yVZG/50lLIwiHExyIopsig4hKy8bjwhTOuNsxzMHFYmkCEMXJwCMBEbU0aGQ6ZplfHeSZcu9V+x
 XOf34GXGDwXH6zOSXtXITM1yUZ5VychwIu7Tg0Or5A8siwzy9bS/anpBWPfhgn8b79z/eoM7NcO
 QAQA=
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

First, the locking around the PTP ports list in the adapter structure is
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

Next, the PTP reset flow is fixed to stop tearing down the Tx tracker
during a CORE or GLOBAL reset. This avoids causing Tx timestamps to break
permanently after such a reset. The fix also ensures that all teardown
paths properly release the tracker. This issue was found by Sashiko during
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
      ice: use reference counting and SRCU for PTP port access
      ice: fix PHY port restart serialization
      ice: fix removal of PTP timestamp tracker during reset
      ice: set in_use only after preparing Tx timestamp index
      ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
      ice: E825: clear PHY_REG_TX_MEMORY_STATUS prior to soft reset
      ice: E825: perform a soft reset when starting the PHY timer
      ice: skip reading Tx ready bitmap on ports with no timestamps
      ice: don't clear in_use until HW clears ready bitmap

Karol Kolacinski (2):
      ice: E822: keep Tx timestamps disabled during offset calibration
      ice: E822: flush offset verification work during reset preparation

Maciek Machnikowski (1):
      ice: Recalibrate PHY after settime64 on E825-C

Petr Oros (2):
      ice: wait for in-flight Tx timestamps before flushing the tracker
      ice: keep Tx timestamp slots tracked until completion or timeout

 drivers/net/ethernet/intel/ice/ice_adapter.h |  20 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h     |  16 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h  |   2 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |  14 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 484 +++++++++++++++++++--------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 133 ++++----
 7 files changed, 466 insertions(+), 215 deletions(-)
---
base-commit: ceac0de741bfb47ca255eee075257b3bb31f0651
change-id: 20260917-jk-e825c-timestamp-processing-logic-fixes-srcu-fb0b50d33e10

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

