Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F07606A33B
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 23:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=cQS9FesB;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IfoFFk8a
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC779812E1;
	Fri, 13 Nov 2026 23:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 84Dvgf8ghQHE; Fri, 13 Nov 2026 23:30:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4D874811B4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794612652;
	b=jFXa0rLb5UVDwGk4lSRGJYL8Chq6e6cFza9+A0r/UBpy0EnyL2nI0G8lGs4K+uUzb8Ew
	 e2Sxh/nNiMV5pF08edUOnvIF5FxyAkENeFpDcn5Ol8TMzFSw2mR9ggvKN9+teivBHB9Jz
	 hTheNlDkmlHHxqGKFkf2LAcIFxHS9dVuHmrQ6NIdyGdxKCFw9YoOTXfSxBOKKkuIjIFXq
	 HBbPQU4EtYcoPrne+y1g052b2pednBiXLpOzag3K1fUyTXUM8rA7TjNjAwPjbg+USmAc1
	 fTNub1RfE1l9nse7e33VBEaZtbeXJCNyP+5i7Csbly6dpV5L5j2lvDuX/NFjXaWCQCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794612652;
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
	bh=fECqK5FC/6/+j0EzziFGVoKKAyDMujkZhMDvG38YgpA=;
	b=gIjkBNKQFsjy5F3j/jqNYm+hRAev/dzk+0LrXbp96U8FHqmuYZT55MdHU66fIXbi7AcD
	 iap6VW45J3QBdmw91WQBYdhlbyKhbx4+K32tZK2jw8daWI7ai6RiKdGJdgDFlK1/aGG8Q
	 eheIptbNowPk0wyoonfzyv69A+t1RYgKBgbu+l85DzyCL8GxE3BPAyr/XPa36mdeh6AZJ
	 rJIHozPQGX81q3vmzZ0KbCoZhji9bnfRpR/sv9T9NarZrtu9PXKK5+479CLEwkbdfVTt2
	 XXs3GlGsMD8AdmZoFDd68BuVQlgqyBjBvuGe6PkX2dfRz6jv6AE22vLJbAv1xFoJYEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794612652;
	bh=fECqK5FC/6/+j0EzziFGVoKKAyDMujkZhMDvG38YgpA=;
	h=From:Subject:Date:To:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cQS9FesBXhvjHDxjQMGJ/MsBLBfiSYG1pHpQVx6YRIrzoa2yWisDOipjVAmuAo2ji
	 j0yS6V6cfnS/FYRL61S/YFtcTo7znYx+uS3GS7hmlh4LQb4NuBvTMYazEirMbzjM1O
	 xiSVTYAtqCltGZCRwlOg9/VXAaPhwtny+aPCPVn14/MskJXt7ec1y0q3T1sXTx1E7C
	 r7OnBoY9UTEZGik02N8+wtWpvNT0JqJb7bBkgI/QBzXzmrCJdPN7Bu8cjR/vUvihLi
	 om1tV8LeH53I4R+JcttQfUygL2Fd8qfEeHF49bnxno+0wOH6syT8KTzyrSKAzrgQP5
	 3+YM0q5qYp+jQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D874811B4;
	Fri, 13 Nov 2026 23:30:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AEF3B2FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A0C2040EA5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xE7T720UxdNY for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 23:30:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2417340E7E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=IfoFFk8a
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2417340E7E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794612648; x=1826148648;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to;
 bh=LhbK78X1SO++Iq9/J+MUG86HXOgu3qZmS7dW2MtxaHw=;
 b=IfoFFk8acz2BbLhkq557bXddR36EuV2tuDGim6vpgTJFMCI3tsBhYH3+
 EVk07zbAna1b9+LKjuEOdKVkMtIYpj8LlVZSEsuXYJOb4ljYn7E3sLKBa
 wV+IQMKh3+JSvHgG63cBZHvdsiJ8sbOSph0O6TgTrKynVh2x3KMoKb5if
 wn6nkd2z0Qnta7foWqyJCTIAQBTp1Wpby7tYCKgLz3a/OPrKTHPq004vj
 FdbG76x/qezn3ZhZnpxI4K5SQCs3lk4TKd0WB6GE1wAAMEpdaucv+fyw8
 TZPCsKeEvt3b15tZuFCGSjAJieDXaIwDLuMUF0Yk1AcXcrTI7NROSuYEN Q==;
X-CSE-ConnectionGUID: y2Enx/SzSp6IfmC1/zCx9Q==
X-CSE-MsgGUID: il3UDvFVTFOpX8U0ND3NgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3470193"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3470193"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:30:47 -0800
X-CSE-ConnectionGUID: y7ER600gQOSJnen/acLBaw==
X-CSE-MsgGUID: B6/20H0OT4y3VmEC1ysM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9574065"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:30:47 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v2 0/4] ice: E825 timer adjustment fixes
Date: Fri, 13 Nov 2026 15:30:00 -0800
Message-Id: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OsQ7CMAxEfwVlJshx1bQw8R+IARKXukCLkhBAV
 f+dtCDBAouls33vrheeHJMXq1kvHEX23LVJ4HwmTL1rDyTZJi0QUCtAlM1RUol5GhnIwGcy3bU
 N5CRoo3JLgFRokewXRxXfJ/RG8O0kW7oHsX1d/HXfkAkjefyt2YfOPaYWUU2Od2D2OzAqCZKWG
 WrACqzSa07708J05ykm4gek1J/mEROoLMCCKWyhlvk3aBiGJ6yBwhslAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13056;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=LhbK78X1SO++Iq9/J+MUG86HXOgu3qZmS7dW2MtxaHw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzvczuTnp4JuGiZv9n1JLf4Z9tdUqqnnfNULF7f+K3FJ
 9l9eo1yRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABPp3c3IsCyYjd3swzOxh4bC
 Ehv9PglWVs/tX5//4V5f4e93lmlHwxgZnu15vtdIxT+ivJ0rJ5I7fv7VYsPp7pOL/Zb+LnLxzud
 mBQA=
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

 drivers/net/ethernet/intel/ice/ice_adapter.h   |  54 +++
 drivers/net/ethernet/intel/ice/ice_ptp.h       |  18 +-
 drivers/net/ethernet/intel/ice/ice_trace.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c   |  51 +++
 drivers/net/ethernet/intel/ice/ice_ethtool.c   |   1 -
 drivers/net/ethernet/intel/ice/ice_lib.c       |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c       | 607 ++++++++++++++++++-------
 drivers/net/ethernet/intel/ice/ice_txrx.c      |  16 +-
 drivers/net/ethernet/intel/ice/virt/virtchnl.c |   7 +-
 10 files changed, 608 insertions(+), 171 deletions(-)
---
base-commit: c3ceba9087610ff11af6406df68acabeb2d4c34c
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
change-id: 20261022-jk-e825-e830-timecounter-06c15de02e76

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>

