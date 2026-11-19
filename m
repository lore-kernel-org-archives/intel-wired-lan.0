Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D9606A31C
	for <intel-wired-lan@archiver.kernel.org>; Thu, 19 Nov 2026 00:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xcapIB/m;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ao/ATANz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3AE160AD4;
	Thu, 19 Nov 2026 00:31:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LySAg0OyGp_m; Thu, 19 Nov 2026 00:31:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3670160AC8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795048296;
	b=bEULWBfpI8BPC6pZHJfineB/OM3E6TZNM3XU4IiZ87N5i9j2yptW4DiPVYcCsVGPBe1V
	 1anrYHHE26QuqvPPeZpQLTmtLKiKBMyzRzsXhOJmZ4uuZdoadRwMcmgvEAuBJ+tYOOJC+
	 8TXNzf/DgzhH15GdZ12+EMLJvb0ZRCEd+cJOqkdiuOiPh5+dFQJhMVyKY+Z+IKO3SnH8/
	 fqY53VgapqKvjrzYRsUIIcjXH8KCuBzBqrRmZCCjEwDn2k/S14NG+naG0776is4MMQrMC
	 z6Sbwie7dF3xhJhuVIW7TCTHbFWgm/+fn9ufmWxdE4b3uYr+YJk6IMJvmRhMalpvehw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795048296;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JXJvScyq9Ldt+8iEuv0fZD7FSBifxL4ooWj1iAt++lc=;
	b=JTgmf6hCKikWMVgFMT1BWzAL5OmXvBv5+ZFIGE/DroXnZ4gXVUSBp4/bg7Y5CA+QdKIZ
	 P++oRN1utpOaX05gvuM5kiuRXCZGSnt9XB628JnQBrNWjm6Tu1OOLZfX1dqFwihjEGPKY
	 YybbmL+rNx7jCw/nf0y/aprzM8gSftVSaBuYic3l+tukLR4z5CPgH6G8get7feuhTdyHy
	 HYhw+WrSP20SMPwX7iRSRweQagtcKfJxD1LqsgRuO+wdOqXYWLNlDc4S5sI3ECkoF4Gb6
	 VbLxdGgO1L/xTh65HJXgSctYBdAQsrEqZDx7DcQafye9GwgPArJlgNge2lO9dWraNYg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795048296;
	bh=JXJvScyq9Ldt+8iEuv0fZD7FSBifxL4ooWj1iAt++lc=;
	h=From:Subject:Date:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xcapIB/mOns37pCttH8RBVqo7O6Lm4sENdK7FefqdwJJuw7oHjBKYecPVcYcCMXKL
	 SfER83ZGlUPIjn98p9v2pKVKUzIENlMdu/Fg3n7vtFYu3OqF3nZ2bHp5d1Zo/m6t/Z
	 N1XUw3Vz6fl27aOrpNyLn9mWWSE5vNtkKsc+wTQmYku8W3xawurcWEBSw70fDfNmBV
	 5K3ImP2vPZiMxyuyRu3229WnKMOgyzYWuBoXUrnveINnS/Z55CYlvr+CqcJatS76iD
	 T7jILXKmejaOBtbQYMFA9dDLZlbwAFB5ejqGOo8L601RAU7FFTiuOTRjrMtQZ+Bt9y
	 NseTaBb49+ZAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3670160AC8;
	Thu, 19 Nov 2026 00:31:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 835FB70B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69ADC8127D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:31:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFMbrCvnG8M8 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 19 Nov 2026 00:31:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8174F81279
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.15
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Ao/ATANz
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8174F81279
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Nov 2026 00:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795048290; x=1826584290;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to;
 bh=QC+GyWqdY5uG8OFP+ob2Vg/0DapKYCUNSRaXunRp9Qg=;
 b=Ao/ATANzKF9QG7S0Q+lUooYDAbbtof+CWDg9KdxLcV5Q7RELSUmiL3FN
 wNflJNQpfUCl4KbMTvejiY6vxU3Z4/pScNYfTqGgRK94/N6R8ttNC7L7p
 OXN/uulvlOpi/jFO9UtHJkxon0uuG2ejy2ey3+llz7FC72kV5ydevRznL
 6CAhTWt55x3yApf+CL7YjGAGexT6hfnQKXoRaD6NGu1NRNYrJVEbCLWY0
 R/wwPLYOaVBjMIAh3vKbx4V7CKRUndEvpvdJnvEHC5OqXQQWiIpyXv7dN
 rsPBvGUATG8+VUcxp2P97I7/GdFMQfEWm3rCSGPzYqHUVoiDjI+eZnU0W g==;
X-CSE-ConnectionGUID: S5Cc/b4nTuWZi7ukjPuf1A==
X-CSE-MsgGUID: +E/sMMRISLCXq5PeEtiXAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3886155"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3886155"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 16:31:28 -0800
X-CSE-ConnectionGUID: KwQQUesHQgGnc9pSl+YPjg==
X-CSE-MsgGUID: 2QGmBV5qTpimW07ZdoW/aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; d="scan'208";a="10287239"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 16:31:28 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v4 0/4] ice: E825 timer adjustment fixes
Date: Wed, 18 Nov 2026 16:30:58 -0800
Message-Id: <20261118-jk-e825-e830-timecounter-v4-0-0acd194b7357@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTU7DMBBGrxJ5XaPxOLETVtwDsQj2lE5pE2S7p
 qjK3XENiIJE2Yw0f+97JxEpMEVx25xEoMyR56k07aoRbjNOTyTZl14goFGAKLfPknrsStEgE+/
 JzYcpUZBgnOo8AZI1ory/BFrzsaLvBb/u5ETHJB4+NvHwuCWXzuTz7YZjmsNbtciqfnwG6r8Ds
 5IgadBoANfglbnjMt/duHlfYzJ+g5S6Yp6xgHoLHpz1Vg3dBWjVfAH0P4DB6c6Olrxuh98m+tL
 EXgHpakJj63oz4k/QsizvVLrWUa8BAAA=
X-Change-ID: 20261022-jk-e825-e830-timecounter-06c15de02e76
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=13774;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QC+GyWqdY5uG8OFP+ob2Vg/0DapKYCUNSRaXunRp9Qg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqx/zkEvFGdKVT1fK3G+eO7OtVP6Z0fXP59e67Jheusjv
 s3GavP9OkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhI4maGP3zXc7cVp7hFmd75
 +/OLj/qN5GdcCdverA9XYGa8dnXliT2MDNvOLPonPlsi06BqK3/2RimlY1fr9qVWtl5qF1jf4/D
 KnB8A
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Recently we've had reports of bad timer adjustment on E825. This series
fixes the issues by replacing direct timer adjustments with a struct
timecounter to maintain the phase in software instead.

To motivate this, the following is an analysis of how the E825 PHY
timestamps function.

    The ice driver maintains PTP clock time in the MAC with a 96-bit
    register. Timestamps are captured in the PHY which only stores 64
    bits, only including the lower 32-bits of nanoseconds. The driver
    performs clock adjustments using a hardware timer command mechanism,
    where the clock adjustment is programmed into shadow registers in
    both the MAC and PHY, and then a timer command is initiated to
    synchronously update the timers.

    Since the PHY only maintains the lower 32 bits of nanoseconds,
    adjustments are also limited such that the maximum atomic adjustment
    is ~2.1 seconds (2^31-1 nanoseconds).

    For large offsets, the driver uses a non-atomic flow where the
    current time is read, an adjustment is applied in software, and then
    written back. This necessarily loses some elapsed time, which
    applications must deal with. For particular servo configurations,
    where the parameters are tuned for a very slow servo, this error can
    take a long time to finish correction.

    On E825, the adjustment in the PHY does not always work reliably.
    The reason for this is subtle, and is a quirk of how the timestamps
    are actually generated. The timestamps for Tx and Rx packets come
    from the PCS timer rather than directly from the PHY timer. The PCS
    timer is derived from internal PHY signaling.

    To keep the PCS timer and PHY timer in sync, every few cycles
    (testing seems to indicate every 8 cycles) the PHY timer is copied
    to the PCS timer. On other cycles, the PCS timer is incremented by a
    value determined from the PCS clock rate.

    Crucially, the copy of the PHY timer is skipped if the current value
    of the PHY timer is lower than the PCS timer (*and* on this cycle
    the regular PCS clock increment is also skipped).

    During normal operation, the PCS timer will tick from its own source
    for 7 ticks then copy the PCS timer. If the PCS timer is slightly
    ahead, then PHY timer update is skipped, and the PCS timer skips an
    update every 8 clock cycles until it is back in alignment with the
    PHY timer.

    Unfortunately, this hardware logic did not take into account manual
    adjustments to the PHY. If the PHY timer is adjusted backwards, (or
    if a forward adjustment causes the PHY timer to overflow), the PHY
    to PCS sync will not occur again until the PCS timer wraps back
    around to zero. In the worst case, an adjustment could land the PHY
    timer to just below the PCS timer just after it wraps around. PHY to
    PCS syncs would stop for ~3.6 seconds.

    During this time, the Tx and Rx timestamps will read from the PCS
    timer. These timestamps will be fed into the timestamp extension
    algorithm which will produce incoherent results, and data will be
    fed into the PTP application servo. During the invalid window,
    faulty timestamps will cause the servo to steer incorrectly, likely
    away from the true target time. After the PCS timer synchronizes
    again, the timestamps will return to normal. However, the servo may
    have steered the clock incorrectly. In default ptp4l configurations,
    direct clock adjustment is only performed once during startup. This
    forces the application to use frequency slewing to correct any
    remaining offset. With slow servo parameters, this can take a *very*
    long time. In some setups, we had reports of taking several minutes
    to nearly an hour before stabilizing, and in some configurations the
    servo was unable to ever recover.

    Note that adjustments work properly on the MAC timer, and indeed on
    the first-layer PHY timer value that the driver can read over the
    sideband queue. Only the PCS timer (which is inaccessible to the
    driver) fails to adjust. This made tracking the precise origin of
    the failure difficult.

Testing shows that pretty much all "negative" adjustments and about half
of the positive adjustments can trigger this failure. It is also
difficult to see without using extremely slow servo parameters. With a
servo tuned for fast reaction, the incorrect timestamps will cause some
difficulty in the first adjustment, but the servo will quickly correct
and recover within a few seconds at most.

I used the following P/I servo parameters in my testing:

    pi_proportional_const 0.60
    pi_integral_const 0.001
    pi_proportional_scale 0.0
    pi_proportional_exponent -0.3
    pi_proportional_norm_max 0.7
    pi_integral_scale 0.0
    pi_integral_exponent 0.4
    pi_integral_norm_max 0.3

In particular, the pi_integral_const will force the servo to be very
slow at reacting.

Even trying to compare the MAC timer with the Tx and Rx timestamps is
not trivial. There is no mechanism to synchronously read the MAC timer
along with a timestamp. Additionally, timestamp extension makes this even
harder to track. The MAC timer is immediately adjusted and the cached PHC
time is updated. Normally timestamps from before the adjustment should
reasonably convert, however if the adjustment is large enough the timestamp
can flip to being detected as "in the past" and in the worst cases the
resulting extended timestamps will have a second sudden jump of -4.2
seconds before the PCS timer adjustment is applied and things settle. All
of this while being fed into a servo trying to steer the clock can make it
difficult to understand what is going on.

With that background out of the way, here's a summary of the patch content:

First, the SO_TX_TIME support in ice_tx_map() is adjusted to compute the
timestamp from the full nanoseconds instead of only the sub-second portion
of the timestamp.

Next, the PTP callback functions are adjusted to check that the PTP state
is ready. This makes them fail early if the driver is resetting or enters
an error state. This isn't a complete synchronization fix as it doesn't
protect against an already-running command when a reset starts. More work
is underway to investigate and determine the best synchronization solution.

Next, the timestamp extension logic is refactored to store the cached
PHC time value inside the ice_adapter structure under a new ice_phc
structure which will be used to store timecounter data. This change
reduces the number of threads that need to perform timestamp extension
and makes introduction of timecounter simpler as it gives a natural
place for accessing the structure and simplifies modifications to the Rx
hotpath in particular. This does further solidify the dependency on the
clock owning PF.

Finally, the driver is modified to allow use of a timecounter for
representing the time instead of directly adjusting the phase in
hardware. Frequency adjustments continue to be handled in hardware. For
now, only the E825 and E830 devices are switched. The legacy
implementation remains for supporting older installations of E810 and
E822 platform devices. We plan to complete migration in the future, but
felt that immediate conversion would slow down ability to validate that
all older installations will behave correctly. Since the E825 device
timer adjustment logic is completely useless, this can speed up ability
to adopt the fix. Although E830 does not appear to have the same timer
command issue, it was decided to convert both since they are the most
recent devices and undergoing the most testing and active development.

Because the timecounter already exists within the kernel, it was deemed the
best solution, despite its trade offs required for implementation. I'm
open to other alternative fixes if anyone has a better solution. One key
thing is that we need the 32-bit cycle counter mask in order to enable
timestamp extension, but this means we effectively (mostly) ignore the
upper 32-bits of the MAC timer when they could be used for tracking time
over the wraparound. Sashiko is not happy about this dependency on
requiring the periodic 2 second check on the clock owner, and complains
about ways it could break if that stops.

This series fixes a separate issue from [1] and does not *directly* depend
on it. The fixes in that series are necessary but not sufficient to
completely eliminate PHY timer desync issues on E825.

There are some structural conflicts with the ctrl_pf RCU changes at [2]
which I have tried to integrate, so this won't be a straightforward
cherry-pick to trees without that series.

One final note, the conversion to timecounter supersedes the changes
from [3], and that patch has been removed from more recent versions of
that series. The reset partially helped, but was only applied to the
non-atomic settime interface. In particular, the settime interface was
vulnerable to the same PCS issue, but the PHY soft reset *does* clear
both the PHY and PCS timers back to 0. Performing a reset after the
adjustment will force both timers back to zero and then perform a
forward adjustment that won't trigger the failure condition. However,
attempting to add this reset to *every* timer adjustment comes with
unnecessary delay since the whole process takes a long time especially
with the PHY soft reset. It was ultimately deemed as not a proper fix
suitable for deployment.

Link: [1] https://lore.kernel.org/intel-wired-lan/20260925222824.270640-1-grzegorz.nitka@intel.com/
Link: [2] https://lore.kernel.org/intel-wired-lan/20261013091235.1423979-1-sergey.temerkhanov@intel.com/
Link: [3] https://lore.kernel.org/netdev/20261008215614.1987250-16-anthony.l.nguyen@intel.com/

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v4:
- Use the seqcount_latch_t for legacy mode as well as timecounter mode
- Fix the locking on failure in ice_ptp_rebuild_owner()
- Use ktime_get_boottime() for the update_time
- Link to v3: https://patch.msgid.link/20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com

Changes in v3:
- Fix locking for periodic output signal configuration
- Use ktime instead of jiffies for cached PHC time check and staleness
  check on Tx timestamps
- Use last cached PHC time and ktime to reset clock after a reset instead
  of reading the reset time at the end of ice_ptp_prepare_for_reset().
- Link to v2: https://patch.msgid.link/20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com

Changes in v2:
- Replace the seqlock_t with a seqcount_latch_t and a mutex that protects
  serialization of the periodic update with the direct updates from the PTP
  hardware clock callbacks.
- Replace use of "0" as a canary value of cached_time and apply the
  cached_jiffies stale discard check to both Tx and Rx timestamps.
- Fix the rx_hwtstamp trace to record the timecounter values and properly
  use the same copied value of the cached_time on non-timecounter devices.
- Fix the SO_TX_TIME support on E830 to account for timecounter phase
  offset.
- Modify ice_ptp_read_cycles() to always read and report the full timer
  value, enabling proper phase calculation even as the MAC timer rolls
  over.
- Add ice_phc_get_phase() to compute the timecounter phase, currently used
  only by SO_TX_TIME, but likely necessary for VF Rx timestamping in the
  future.
- Disable VF Rx timestamping support for devices using the timecounter.
  This will need some investigation and virtchnl development work to enable
  properly, which I plan on doing in a different series. I don't like
  regressing this, but I don't have a simple alternative. I don't believe
  that simply accounting for the phase in the GET_TIME would be sufficient,
  as I am not certain it produces the correct math in the iavf timestamp
  extension algorithm.
- Fix the phase offset calculation in ice_ptp_cfg_perout(), computing the
  timecounter domain first before adding the 500 msec.
- Separate the E830 ETF fix out to its own patch, as it seems like the
  driver is incorrectly programming all ETF timestamps.
- Add a patch to have all the PTP callbacks check for the PTP ready state.
- Target net-next despite being a bug fix since this is unlikely to be
  accepted to net due to the scope.
- Link to v1: https://patch.msgid.link/20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com

---
Jacob Keller (4):
      ice: fix computation of ETF timestamps for E830
      ice: exit PTP callbacks early if not ICE_PTP_READY
      ice: store cached PHC time in ice_adapter
      ice: use struct timecounter for E825 and E830

 drivers/net/ethernet/intel/ice/ice_adapter.h   |  53 +++
 drivers/net/ethernet/intel/ice/ice_ptp.h       |  18 +-
 drivers/net/ethernet/intel/ice/ice_trace.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c   |  51 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c   |   1 -
 drivers/net/ethernet/intel/ice/ice_lib.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c       | 578 ++++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c      |  16 +-
 drivers/net/ethernet/intel/ice/virt/virtchnl.c |   7 +-
 10 files changed, 568 insertions(+), 181 deletions(-)
---
base-commit: dcd4565f5b5a8126958e787c7b5c15bbe8460e0c
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
change-id: 20261022-jk-e825-e830-timecounter-06c15de02e76

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

