Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00EC606A31C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Nov 2026 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=pXpp+a3l;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Bg3Xsa/7
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A50DD810AC;
	Wed, 18 Nov 2026 00:32:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S7-75ZEnzACe; Wed, 18 Nov 2026 00:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3F07E810B4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794961930;
	b=q8sB/p7c43tVLchsM7dvwwCFtiGy0kqpDdwUMSnAU9zE/Ym3W/lGj8+lngybOsMbr6D0
	 m78GwJnK+lIS3K6u00TI4skPB5f0/I/wbVY7reCJnT63YAzuFPATUwU70ibAZ1sZsQrpD
	 hT+hoapCcbK6r7asw07iRCywyncr/WwY1dKvtviLN8QCkO4c2oIbquQOqWOfZN992t6sS
	 qUgAEj5vyh+RkaOpPZS3dtWSVwePYidfj/VQdlVRne9snEt04w3NMcB5XWPFAksF8Xcql
	 XMcrw8QY2mO3Edh9JPQgAhyneaAm1IBVjurRvrwCFbV11ZSVKzBJcAK+Mhfktw2jz3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961930;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OMdGMxnWvoy0JaqCGweQ4jH8OhxEALX16olrTp5YX1c=;
	b=PKvuM9OTVm8iWlK8SJSkDn1tT1s+VTVm5VOYRf7WDH2xk7IGYdiokDWhKONWyQVC56bL
	 VqW87LAgp17HXbSjsY9aE4ood1W0ovu7LQ1PFkiRtjWzFg1CR3eWrI+gVE44GuKiXgk81
	 EsQYZFpMLz21U9AP0ue3E0Kn/qr+k2nAti/BcAgaO5a5Km4MqhJP4+pVr5Xm9k+f4ypby
	 If2dpYSGyyhnxncyUJ33k5ecu6hTmFVLGPnm4seRXGBpLfzfJWmm6kuEwiRycwDKPgUlA
	 azTbGLnNFHqxz+jAzXU6Oe82qQqbqWaMbZZIvISwyHIMi9NDYXM++lSROwZ5OcEDqew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794961930;
	bh=OMdGMxnWvoy0JaqCGweQ4jH8OhxEALX16olrTp5YX1c=;
	h=From:Date:Subject:References:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pXpp+a3lrV7XWcZqT1Q3KAJ62XxPWQa8MAMiluiBoDswdt+mLm8IPFo1ZpmwTVDBi
	 WTsqEzlb2jC7TldHkBmCT42akPyycHNQu8DD6UVNvNGKZ/EErEuYbKcXu4pdYACL4m
	 ZP+uMaDi/0Ixnz3+tTmX2iIMDHDnsziYjJXJxGjZ+gEu6sgBUH8iIUBrUA1MhjBVbP
	 F0kR7iMv/ATjsFXmbueHWlv53frUR6XWI05EqZ2TjkKoVsTsjAibIHZfd/sQeTRfhE
	 jQZGqQnYGhXO59plTAiJU2IlU5GCefBeWygpc8R2OsK0W5SC+Pwp+IwVr/rd+gABWc
	 NO/IyVmErrS1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3F07E810B4;
	Wed, 18 Nov 2026 00:32:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 235A749B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3CAC60642
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kiWHiGKkda5c for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Nov 2026 00:32:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE8C860743
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.7
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Bg3Xsa/7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE8C860743
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Nov 2026 00:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794961924; x=1826497924;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to;
 bh=pJKag1Ta2kYVF+0xgf1kh9RZPwNd1mPVPH4IZfl98cg=;
 b=Bg3Xsa/7MICcIr13GPOicdrxURA0ycIpAILlDyvXR51jqRGB3d6J+C1O
 0Nm5QB5qOtWlqnknvneNzMKEN6AZHW7kffh6LETGLoVMNR67KVNTlrO6U
 m8VTlh4KLv49OrHojTK97R+uEb/OuQFXwPDqAuaV+sbp4zVFiEUSVNVvn
 z/EDHKXJu8a1PgBVewNhBm3T52BwfAdaQ5npF9KDfk7nZ3MTjWS3W+0YW
 xuvRSQ3IwjtXcz125rjYjUb6cLvPPakKK0h1lIdPrbCxo4R2Et8oWVDeJ
 oCeJoI68iCIinQj/v8WveGy0r2YMGR414BUhBYOm7PaTnH28Tr8aKcoOj Q==;
X-CSE-ConnectionGUID: cJIG8lLsTXaAvuHqM+9OYQ==
X-CSE-MsgGUID: 4oDDXA06TM2dyIFSmOohpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3618636"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3618636"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:32:02 -0800
X-CSE-ConnectionGUID: mQsb7Y2IRSK3RZ0WtYSJDw==
X-CSE-MsgGUID: bBlkfQnkSFiev+L8weQdLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9824892"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 16:32:01 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 17 Nov 2026 16:31:46 -0800
Subject: [PATCH iwl-next v3 4/4] ice: use struct timecounter for E825 and E830
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-jk-e825-e830-timecounter-v3-4-87ea4c86a249@intel.com>
References: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
In-Reply-To: <20261117-jk-e825-e830-timecounter-v3-0-87ea4c86a249@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=40324;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=pJKag1Ta2kYVF+0xgf1kh9RZPwNd1mPVPH4IZfl98cg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw/H/9O37t8/cpjIeam/7fKMUW+bby6iL9/eX3rwkPp0
 S5HDpp3dZSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRrJ+MDOsZdDWDuBm8t3sF
 eX1KenQ3rcU9XLxD8PSx9oRHDE9u3GJkeLtyhV2YW/O9b9m13VPtZsRcTdM4JcPzIHh29e8ehk0
 FjAA=
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ice driver maintains PTP clock time in the MAC with a 96-bit register.
Timestamps are captured in the PHY which only stores 64 bits, only
including the lower 32-bits of nanoseconds. The driver performs clock
adjustments using a hardware timer command mechanism, where the clock
adjustment is programmed into shadow registers in both the MAC and PHY, and
then a timer command is initiated to synchronously update the timers.

Since the PHY only maintains the lower 32 bits of nanoseconds, adjustments
are also limited such that the maximum atomic adjustment is ~2.1 seconds
(2^31-1 nanoseconds).

For large offsets, the driver uses a non-atomic flow where the current time
is read, an adjustment is applied in software, and then written back. This
necessarily loses some elapsed time, which applications must deal with. For
particular servo configurations, where the parameters are tuned for a very
slow servo, this error can take a long time to finish correction.

Worst, on E825 in specific, the adjustment in the PHY does not always work
reliably. The reason for this is subtle, and is a quirk of how the
timestamps are actually generated. The timestamps for Tx and Rx packets
come from the PCS timer rather than directly from the PHY timer. The PCS
timer is derived from internal PHY signaling.

To keep the PCS timer and PHY timer in sync, every few cycles (testing
seems to indicate every 8 cycles) the PHY timer is copied to the PCS timer.
On other cycles, the PCS timer is incremented by a value determined from
the PCS clock rate.

Crucially, the copy of the PHY timer is skipped if the current value of the
PHY timer is lower than the PCS timer (*and* on this cycle the regular PCS
clock increment is also skipped).

During normal operation, the PCS timer will tick from its own source for 7
ticks then copy the PCS timer. If the PCS timer is slightly ahead, then PHY
timer update is skipped, and the PCS timer skips an update every 8 clock
cycles until it is back in alignment with the PHY timer.

Unfortunately, this hardware logic did not take into account manual
adjustments to the PHY. If the PHY timer is adjusted backwards, (or if a
forward adjustment causes the PHY timer to overflow), the PHY to PCS sync
will not occur again until the PCS timer wraps back around to zero. In the
worst case, an adjustment could land the PHY timer to just below the PCS
timer just after it wraps around. PHY to PCS syncs would stop for ~3.6
seconds.

During this time, the Tx and Rx timestamps will read from the PCS timer.
These timestamps will be fed into the timestamp extension algorithm which
will produce incoherent results, and data will be fed into the PTP
application servo. During the invalid window, faulty timestamps will cause
the servo to steer incorrectly, likely away from the true target time.
After the PCS timer synchronizes again, the timestamps will return to
normal. However, the servo may have steered the clock incorrectly. In
default ptp4l configurations, direct clock adjustment is only performed
once during startup. This forces the application to use frequency slewing
to correct any remaining offset. With slow servo parameters, this can take
a *very* long time. In some setups, we had reports of taking several
minutes to nearly an hour before stabilizing, and in some configurations
the servo was unable to ever recover. Note that this issue with the PCS
synchronization happens regardless of *how* the PHY timer is set, either
with the ICE_PTP_ADJ_TIME or ICE_PTP_INIT_TIME.

Note that adjustments work properly on the MAC timer, and indeed on the
first-layer PHY timer value that the driver can read over the sideband
queue. Only the PCS timer (which is inaccessible to the driver) fails to
adjust. This made tracking the precise origin of the failure difficult.

To handle this, the most robust solution is to simply not adjust the
hardware clock directly. The kernel already has struct timecounter and
struct cyclecounter for representing hardware counters that cannot handle
64-bits of precision. Indeed, the PHY timer already is only 32 bits, and
ice has used its own custom logic in ice_ptp_extend_32b_ts to extend
timestamps without using a timecounter.

This makes switching to a timecounter fairly straight forward in most
cases. However, such a switch covers many product families and devices. To
limit the initial scope, implement the timecounter only for the newer E825
and E830 devices. Older E810 and E822 platform devices will currently
remain using the legacy approach which has been in use for years. We may
opt to convert all devices in the future, but for now limiting the scope
keeps from potentially regressing legacy deployments.

The timecounter and cyclecounter are embedded within the recently
introduced ice_phc structure. They are initialized as part of ice_adapter.
Locking and concurrency requirements for access are a bit awkward. The
timestamps are extended from multiple places including the Rx hotpath, the
Tx IRQ function on E830, and the Tx IRQ thread function on E825. The
timecounter is updated as part of .adjtime and .settime64 callbacks, as
well as periodically from the clock owner kworker. The updates are expected
to be rare relative to reads, and we want to avoidt  a global lock on the
readers.

Original versions of this used a seqlock_t which allows multiple readers,
but unfortunately had issues because the updates necessarily call the
read() function of the cyclecounter, which acquires a spinlock to access
the time registers. On RT kernels, the spinlock can sleep which violates
the requirements of the seqlock_t (according to Sashiko AI reports).

Instead, use a seqcount_latch_t along with two copies of the timecounter
structure in the ice_adapter. The sequence counter allows readers to
retry until they get a consistent snapshot. The seqcount_latch_t directs
the reader to the appropriate copy, to allow readers to fully preempt the
writer. The timecounters are fully initialized as part of ice_adapter and
all updates only ever modify their cycle_last and nsec fields.

Writers will first perform the update on the first timecounter, then latch
and finish by copying the values from the first counter to the second.
Readers that preempt the writer will be directed to the non-modified copy
and see a clean status. If the writer preempts the reader, then the
sequence counter is invalid and the reader will re-try.

The reader logic is embedded in ice_phc_cyc2time which wraps the
timecounter_cyc2time and handles the seqcount_latch_t. Similarly, writer
logic is embedded within ice_phc_refresh(), ice_phc_init(), and
ice_phc_adjtime().

In most places, the timecounter is a drop-in replacement for existing
logic, including using ice_phc_init instead of ice_ptp_write_init and
ice_phc_adjtime instead of ice_ptp_write_adj.

The ice_ptp_update_cached_phctime will conditionally handle whether to
update the cached_time value, or perform a timecounter_read(). To minimize
the risk of contention, this is the only place which actually performs a
timecounter_read(). In this way, only the periodic thread and the actual
modifications through reset, .settime64 and .adjtime need the writer lock.

All other accesses to time values use ice_phc_cyc2time when
phc->use_timecounter is enabled, ensuring that the timecounter phase offset
is handled, including external timestamp events, gettime, cross
timestamping, and periodic output signals.

The SO_TX_TIME needs to compensate for the timecounter phase and uses
ice_phc_get_phase() which computes the difference between the cycle_last
and nsec fields. Note that the cyclecounter mask is 32bits to allow
extending the shorter PHY timestamps. However, the cyclecounter still reads
and reports the "full" 64 bit value from the MAC. This is important since
phase adjustments need to convert from the timecounter to the MAC timer
which keeps counting the higher bits after a rollover.

Periodic output signal programming is a slightly tricky conversion:
The ice_ptp_cfg_perout() function programs the SDP output signals. For
timecounter, the clk time is adjusted using ice_phc_cyc2time to convert to
the timecounter domain. Then, the timecounter phase is subtracted from the
requested start time. This works because the MAC timer still maintains the
full 96 bits, so even if it overflows, we can still reliably program start
times more than 4 seconds in the future.

Finally, VF PTP features are disabled for the devices using the
timecounter. To support this feature, the virtchnl interface must be
extended to handle the timecounter phase appropriately which will require
its own development work including modification to the VF driver. This will
be investigated and planned in the future.

Careful readers may note that the driver still performs ICE_PTP_ADJ_TIME on
the PHY timers after a device reset and when the PHY needs to be
reinitialized at link up. The PHY must be adjusted to align with the MAC
time in order for timestamps to be accurate. These adjustments are safe
because the PHY restart procedure performs a PHY soft reset which forces
the PHY to reinitialize to zero, and then be forward corrected as part of
the ice_sync_phy_timer_eth56g() procedure. The soft reset was introduced as
part of commit 24e335fff462 ("ice: E825: perform a soft reset when starting
the PHY timer").

Although the particular hardware issue is only known to affect E825, this
timecounter conversion is applied to both E825 and E830 family. These two
products are the most recent devices and consistency between their behavior
is desired. Older products could benefit from the timecounter (as
arbitrarily large offsets may be programmed atomically). However, at this
time it was deemed safest to initially implement timecounter only for the
new devices, leaving legacy implementation alone. After some time is given
to prove out the implementation and ensure all remaining gaps are closed,
we may opt to convert all devices and drop the legacy code entirely.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h   |  40 ++-
 drivers/net/ethernet/intel/ice/ice_ptp.h       |  12 +
 drivers/net/ethernet/intel/ice/ice_trace.h     |  18 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_adapter.c   |  47 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c       | 390 +++++++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_txrx.c      |   7 +
 drivers/net/ethernet/intel/ice/virt/virtchnl.c |   7 +-
 8 files changed, 482 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index ade829c05000..4a9c0f5da1c6 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,6 +8,8 @@
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/srcu.h>
+#include <linux/seqlock.h>
+#include <linux/timecounter.h>
 #include <linux/spinlock_types.h>
 #include <linux/refcount_types.h>
 
@@ -37,21 +39,51 @@ struct ice_port_list {
 
 /**
  * struct ice_phc - PTP Hardware Clock fields
+ *
+ * Structure used for handling the timestamp extension logic for this device.
+ * Devices will either use the legacy timestamp extension logic or
+ * a timecounter, not both.
+ *
+ * For simplicity, the timecounter fields are initialized as part of creating
+ * the ice_adapter regardless of whether the device will actually use them.
+ *
+ * Legacy timestamp extension fields:
  * @cached_time: Cached copy of the PHC time for timestamp extension
+ *
+ * struct timecounter fields:
+ * @tc: timecounter representing the current time. Accessed via seq to allow
+ *      lockless readers during updates.
+ * @cc: cyclecounter underlying the timecounter
+ * @seq: seqcount_latch_t used to protect readers and direct to the
+ *       appropriate copy during updates.
+ *
+ * General fields:
  * @update_time: Monotonic time when PHC was laste updated
  * @lock: For protecting updates to the PHC fields.
+ * @use_timecounter: if true, the device uses the timecounter
  *
- * Readers are lockless and rely on READ_ONCE/WRITE_ONCE for the cached_time
- * and smp_acquire/smp_release for the update_time field.
+ * Readers are lockless. Devices without a timecounter rely on
+ * READ_ONCE/WRITE_ONCE of the cached_time for consistency. For devices with
+ * a timecounter, readers rely on the latched sequence counter to be directed
+ * to a copy of the timecounter not being modified. Both styles depend on
+ * smp_load_acquire/smp_store_release for checking update_time.
  *
  * Writers must acquire the lock mutex to ensure that the periodic task cannot
- * write back an out-of-date cached value after a clock adjustment.
+ * race with clock adjustment callbacks.
  */
 struct ice_phc {
+	/* Legacy timestamp extension fields */
 	u64 cached_time;
+
+	/* struct timecounter fields */
+	struct timecounter tc[2];
+	struct cyclecounter cc;
+	seqcount_latch_t seq;
+
 	ktime_t update_time;
-	/* Serialize updates to cached_time */
+	/* Serialize updates to cached_time or the timecounter */
 	struct mutex lock;
+	bool use_timecounter;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index ab9bf86f7a4c..a2fa45429c42 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -326,6 +326,8 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts, u64 *time);
+u64 ice_ptp_read_cycles(struct cyclecounter *cc);
+s64 ice_phc_get_phase(struct ice_phc *phc);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -384,6 +386,16 @@ static inline int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	return -EOPNOTSUPP;
 }
 
+static inline u64 ice_ptp_read_cycles(struct cyclecounter *cc)
+{
+	return 0;
+}
+
+static inline s64 ice_phc_get_phase(struct ice_phc *phc)
+{
+	return 0;
+}
+
 static inline u64
 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 		    const struct ice_pkt_ctx *pkt_ctx)
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 7c43683a77d4..40c710a1d8b7 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -263,19 +263,27 @@ DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_complete);
 
 /* Trace event for Rx timestamp */
 TRACE_EVENT(ice_rx_hwtstamp,
-	    TP_PROTO(u64 cached_time, u32 ts_high, u64 ts_ns),
+	    TP_PROTO(int timecounter, u64 cycle_last, u64 nsec,
+		     u64 cached_time, u32 ts_high, u64 ts_ns),
 
-	    TP_ARGS(cached_time, ts_high, ts_ns),
+	    TP_ARGS(timecounter, cycle_last, nsec, cached_time, ts_high, ts_ns),
 
-	    TP_STRUCT__entry(__field(u64, cached_time)
+	    TP_STRUCT__entry(__field(int, timecounter)
+			     __field(u64, cycle_last)
+			     __field(u64, nsec)
+			     __field(u64, cached_time)
 			     __field(u32, ts_high)
 			     __field(u64, ts_ns)),
 
-	    TP_fast_assign(__entry->cached_time = cached_time;
+	    TP_fast_assign(__entry->timecounter = timecounter;
+			   __entry->cycle_last = cycle_last;
+			   __entry->nsec = nsec;
+			   __entry->cached_time = cached_time;
 			   __entry->ts_high = ts_high;
 			   __entry->ts_ns = ts_ns;),
 
-	    TP_printk("cached_time=%llu ts_high=%u ts_ns=%llu",
+	    TP_printk("timecounter=%d cycle_last=%llu nsec=%llu cached_time=%llu ts_high=%u ts_ns=%llu",
+		      __entry->timecounter, __entry->cycle_last, __entry->nsec,
 		      __entry->cached_time, __entry->ts_high, __entry->ts_ns)
 );
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 83a34322e0d3..095513c22ebc 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -266,6 +266,7 @@ enum ice_dynamic_itr {
 /* descriptor ring, associated with a VSI */
 struct ice_tstamp_ring {
 	struct ice_tx_ring *tx_ring;	/* Backreference to associated Tx ring */
+	struct ice_phc *phc;
 	dma_addr_t dma;			/* physical address of ring */
 	struct rcu_head rcu;            /* to avoid race on free */
 	u8 __iomem *tail;
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index f3ee5e60613e..ef057fa419e0 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -6,6 +6,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/seqlock.h>
 #include <linux/srcu.h>
 #include <linux/xarray.h>
 #include "ice_adapter.h"
@@ -41,6 +42,41 @@ static u64 ice_adapter_index(struct pci_dev *pdev)
 	}
 }
 
+static bool ice_adapter_use_timecounter(struct pci_dev *pdev)
+{
+	switch (pdev->device) {
+	/* E825 */
+	case ICE_DEV_ID_E825C_BACKPLANE:
+	case ICE_DEV_ID_E825C_QSFP:
+	case ICE_DEV_ID_E825C_SFP:
+	case ICE_DEV_ID_E825C_SGMII:
+	/* E830 */
+	case ICE_DEV_ID_E830CC_BACKPLANE:
+	case ICE_DEV_ID_E830CC_QSFP56:
+	case ICE_DEV_ID_E830CC_SFP:
+	case ICE_DEV_ID_E830CC_SFP_DD:
+	case ICE_DEV_ID_E830C_BACKPLANE:
+	case ICE_DEV_ID_E830_XXV_BACKPLANE:
+	case ICE_DEV_ID_E830C_QSFP:
+	case ICE_DEV_ID_E830_XXV_QSFP:
+	case ICE_DEV_ID_E830C_SFP:
+	case ICE_DEV_ID_E830_XXV_SFP:
+	case ICE_DEV_ID_E835CC_BACKPLANE:
+	case ICE_DEV_ID_E835CC_QSFP56:
+	case ICE_DEV_ID_E835CC_SFP:
+	case ICE_DEV_ID_E835C_BACKPLANE:
+	case ICE_DEV_ID_E835C_QSFP:
+	case ICE_DEV_ID_E835C_SFP:
+	case ICE_DEV_ID_E835_L_BACKPLANE:
+	case ICE_DEV_ID_E835_L_QSFP:
+	case ICE_DEV_ID_E835_L_SFP:
+		return true;
+	}
+
+	/* Keep legacy approach for older devices */
+	return false;
+}
+
 static unsigned long ice_adapter_xa_index(struct pci_dev *pdev)
 {
 	u64 index = ice_adapter_index(pdev);
@@ -83,8 +119,19 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 
 	mutex_init(&adapter->ps_lock);
 
+	adapter->phc.cc.mask = CYCLECOUNTER_MASK(32);
+	adapter->phc.cc.mult = 1;
+	adapter->phc.cc.shift = 0;
+	adapter->phc.cc.read = ice_ptp_read_cycles;
+
+	timecounter_init(&adapter->phc.tc[0], &adapter->phc.cc, 0);
+	timecounter_init(&adapter->phc.tc[1], &adapter->phc.cc, 0);
+
+	seqcount_latch_init(&adapter->phc.seq);
 	mutex_init(&adapter->phc.lock);
 
+	adapter->phc.use_timecounter = ice_adapter_use_timecounter(pdev);
+
 	return adapter;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index d07dcf619bb1..a74a2075e5f5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -272,6 +272,202 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	return 0;
 }
 
+/**
+ * ice_ptp_read_cycles - cyclecounter read() callback function
+ * @cc: the hardware cycle counter structure
+ *
+ * Read the PHC time via ice_ptp_read_src_clk_reg() and report it for use
+ * within timecounter_read() and timecounter_init().
+ *
+ * Although the cycle counter is masked to 32-bits for timestamp extension,
+ * this still reports the full 64-bit time to enable determining the phase
+ * difference between the PHC hardware value and the timecounter properly.
+ *
+ * Return: The current PHC timer value from the hardware on success.
+ *         Since failure cannot be meaningfully reported, return the previous
+ *         cycle_last value when unable to access the device.
+ */
+u64 ice_ptp_read_cycles(struct cyclecounter *cc)
+{
+	struct ice_adapter *adapter;
+	struct ice_phc *phc;
+	struct ice_pf *pf;
+	u64 time;
+	int err;
+
+	phc = container_of(cc, struct ice_phc, cc);
+	adapter = container_of(phc, struct ice_adapter, phc);
+
+	scoped_guard(rcu) {
+		pf = rcu_dereference(adapter->ctrl_pf);
+		if (!pf)
+			return phc->tc[0].cycle_last;
+
+		err = ice_ptp_read_src_clk_reg(pf, NULL, &time);
+		if (err)
+			return phc->tc[0].cycle_last;
+
+		/* Paired with smp_load_acquire in ice_ptp_extend_32b_ts */
+		smp_store_release(&phc->update_time, ktime_get());
+		return time;
+	}
+}
+
+/**
+ * ice_phc_get_phase - Determine timecounter phase offset
+ * @phc: pointer to the PHC structure
+ *
+ * Compute the phase difference between the timecounter and the current
+ * hardware clock value. Note that the cycle counter reports the full
+ * 64-bits of nanoseconds, so this computes the phase difference between the
+ * timecounter and the full MAC timer which keeps counting after the lower
+ * 32-bits of GLTSYN_TIME_L overflow.
+ *
+ * Return: phase difference between the timecounter and the MAC timer.
+ */
+s64 ice_phc_get_phase(struct ice_phc *phc)
+{
+	unsigned int seq, idx;
+	s64 phase;
+
+	do {
+		seq = read_seqcount_latch(&phc->seq);
+		idx = seq & 0x1;
+
+		phase = phc->tc[idx].nsec - phc->tc[idx].cycle_last;
+	} while (read_seqcount_latch_retry(&phc->seq, seq));
+
+	return phase;
+}
+
+/**
+ * ice_phc_cyc2time_with_trace - Wrapper for timecounter_cyc2time
+ * @phc: pointer to the PHC structure
+ * @cycles: the hardware timestamp to convert
+ * @trace_rx: True if this call should trigger an Rx timestamp trace
+ *
+ * Wrapper for timecounter_cyc2time which converts hardware timestamps. Note
+ * that this works for both 32-bit PHY timestamps and 64-bit MAC timestamps,
+ * since the cyclecounter mask is set to 32-bits.
+ *
+ * The seqcount_latch protects against concurrent updates by directing the
+ * reader to use the appropriate copy of the timecounter while a writer is
+ * active. The reader may convert according to the old time domain, but will
+ * retry if the conversion could be inconsistent.
+ *
+ * Return: the timestamp converted to the timecounter domain.
+ */
+static u64 ice_phc_cyc2time_with_trace(struct ice_phc *phc,
+				       u64 cycles, bool trace_rx)
+{
+	u64 ns, cycle_last = 0, nsec = 0;
+	unsigned int seq, idx;
+
+	do {
+		seq = read_seqcount_latch(&phc->seq);
+		idx = seq & 0x1;
+		if (ice_trace_enabled(rx_hwtstamp) && trace_rx) {
+			cycle_last = phc->tc[idx].cycle_last;
+			nsec = phc->tc[idx].nsec;
+		}
+		ns = timecounter_cyc2time(&phc->tc[idx], cycles);
+	} while (read_seqcount_latch_retry(&phc->seq, seq));
+
+	if (trace_rx)
+		ice_trace(rx_hwtstamp, phc->use_timecounter,
+			  cycle_last, nsec, 0, (u32)cycles, ns);
+
+	return ns;
+}
+
+/**
+ * ice_phc_cyc2time - Wrapper for timecounter_cyc2time
+ * @phc: pointer to the PHC structure
+ * @cycles: the hardware timestamp to convert
+ *
+ * See ice_phc_cyc2time_with_trace().
+ *
+ * Return: the timestamp converted to the timecounter domain.
+ */
+static u64 ice_phc_cyc2time(struct ice_phc *phc, u64 cycles)
+{
+	return ice_phc_cyc2time_with_trace(phc, cycles, false);
+}
+
+/**
+ * ice_phc_refresh - Read PHC timecounter to refresh phase offset
+ * @phc: pointer to the PHC structure
+ *
+ * Called from ice_ptp_update_cached_phctime() to refresh the timecounter
+ * periodically. The latched sequence counter is used to ensure readers get
+ * a consistent view of the timecounter phase. The frac, mask, and cc fields
+ * always remain their initial values, so only cycle_last and nsec need to be
+ * propagated to the secondary timecounter structure.
+ *
+ * To avoid contention, timecounter_read() is not used in any other flow, and
+ * its return value is ignored.
+ */
+static void ice_phc_refresh(struct ice_phc *phc)
+{
+	lockdep_assert_held(&phc->lock);
+
+	write_seqcount_latch_begin(&phc->seq);
+	(void)timecounter_read(&phc->tc[0]);
+	write_seqcount_latch(&phc->seq);
+	/* Update the secondary copy */
+	phc->tc[1].cycle_last = phc->tc[0].cycle_last;
+	phc->tc[1].nsec = phc->tc[0].nsec;
+	write_seqcount_latch_end(&phc->seq);
+}
+
+/**
+ * ice_phc_init - Initialize PHC timecounter to new start value
+ * @phc: pointer to the PHC structure
+ * @init_tstamp: New initial value for the timecounter
+ *
+ * Initialize the PHC timecounter to a new offset. The latched sequence
+ * counter is used to ensure readers get a consistent view of the timecounter
+ * phase. We always pass the same cyclecounter structure, so the mask, frac,
+ * and cc fields always remain the same, and only the cycle_last and nsec
+ * fields must be propagated to the secondary structure.
+ */
+static void ice_phc_init(struct ice_phc *phc, u64 init_tstamp)
+{
+	lockdep_assert_held(&phc->lock);
+
+	write_seqcount_latch_begin(&phc->seq);
+	timecounter_init(&phc->tc[0], &phc->cc, init_tstamp);
+	write_seqcount_latch(&phc->seq);
+	/* Update the secondary copy */
+	phc->tc[1].cycle_last = phc->tc[0].cycle_last;
+	phc->tc[1].nsec = phc->tc[0].nsec;
+	write_seqcount_latch_end(&phc->seq);
+}
+
+/**
+ * ice_phc_adjtime - Adjust PHC timecounter by delta
+ * @phc: pointer to the PHC structure
+ * @delta: the delta to adjust by
+ *
+ * Adjust the PHC timecounter offset by the provided delta. The latched
+ * sequence counter is used to ensure readers get a consistent view of the
+ * timecounter phase. The frac, mask, and cc fields always remain their
+ * initial values, so only cycle_last and nsec need to be propagated to the
+ * secondary timecounter structure.
+ */
+static void ice_phc_adjtime(struct ice_phc *phc, s64 delta)
+{
+	lockdep_assert_held(&phc->lock);
+
+	write_seqcount_latch_begin(&phc->seq);
+	timecounter_adjtime(&phc->tc[0], delta);
+	write_seqcount_latch(&phc->seq);
+	/* Update the secondary copy */
+	phc->tc[1].cycle_last = phc->tc[0].cycle_last;
+	phc->tc[1].nsec = phc->tc[0].nsec;
+	write_seqcount_latch_end(&phc->seq);
+}
+
 /**
  * ice_ptp_extend_32b_ts - Convert a 32b nanoseconds timestamp to 64b
  * @phc: PTP Hardware Clock structure
@@ -283,6 +479,12 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
  * Note that the captured timestamp values may be 40 bits, but the lower
  * 8 bits are sub-nanoseconds and generally discarded.
  *
+ * For devices which use the timecounter, call ice_phc_cyc2time_with_trace to
+ * convert the hardware cycles, accounting for the phase offset of the
+ * timecounter.
+ *
+ * For other devices not using the timecounter:
+ *
  * Extend the 32bit nanosecond timestamp using the following algorithm and
  * assumptions:
  *
@@ -329,6 +531,9 @@ static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc,
 	if (ktime_ms_delta(ktime_get_coarse(), update_time) > 2000)
 		return 0;
 
+	if (phc->use_timecounter)
+		return ice_phc_cyc2time_with_trace(phc, in_tstamp, trace_rx);
+
 	cached_phc_time = READ_ONCE(phc->cached_time);
 	phc_time_lo = (u32)cached_phc_time;
 
@@ -351,7 +556,8 @@ static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc,
 	}
 
 	if (trace_rx)
-		ice_trace(rx_hwtstamp, cached_phc_time, in_tstamp, ns);
+		ice_trace(rx_hwtstamp, phc->use_timecounter,
+			  0, 0, cached_phc_time, in_tstamp, ns);
 
 	return ns;
 }
@@ -1021,20 +1227,18 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
  * ice_ptp_update_cached_phctime - Update the cached PHC time value
  * @pf: Board specific private structure
  *
- * Update the PTP hardware clock time values which are cached in the PHC
- * structure.
+ * For devices that use a timecounter structure, update the timecounter.
+ * Otherwise, update the cached PHC time used for timestamp extension.
  *
  * This function must be called periodically by the clock owner to ensure that
- * the cached value is never more than 2 seconds old.
+ * the timecounter or cached value is never more than 2 seconds old.
  */
 static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 {
 	struct ice_phc *phc = &pf->adapter->phc;
 	struct device *dev = ice_pf_to_dev(pf);
 	ktime_t mono_now;
-	u64 systime;
 	s64 delta;
-	int err;
 
 	mutex_lock(&phc->lock);
 
@@ -1046,12 +1250,20 @@ static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 		pf->ptp.late_cached_phc_updates++;
 	}
 
-	/* Read the current PHC time */
-	err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
-	if (!err) {
-		WRITE_ONCE(phc->cached_time, systime);
-		/* Paired with smp_load_acquire in ice_ptp_extend_32b_ts */
-		smp_store_release(&phc->update_time, mono_now);
+	if (phc->use_timecounter) {
+		ice_phc_refresh(phc);
+	} else {
+		u64 systime;
+		int err;
+
+		err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
+		if (!err) {
+			WRITE_ONCE(phc->cached_time, systime);
+			/* Paired with smp_load_acquire in
+			 * ice_ptp_extend_32b_ts
+			 */
+			smp_store_release(&phc->update_time, mono_now);
+		}
 	}
 
 	mutex_unlock(&phc->lock);
@@ -1597,6 +1809,7 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
  */
 void ice_ptp_extts_event(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct ptp_clock_event event;
 	struct ice_hw *hw = &pf->hw;
 	u8 chan, tmr_idx;
@@ -1621,7 +1834,11 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 
 		lo = rd32(hw, GLTSYN_EVNT_L(chan, tmr_idx));
 		hi = rd32(hw, GLTSYN_EVNT_H(chan, tmr_idx));
-		event.timestamp = (u64)hi << 32 | lo;
+
+		if (phc->use_timecounter)
+			event.timestamp = ice_phc_cyc2time(phc, lo);
+		else
+			event.timestamp = (u64)hi << 32 | lo;
 
 		/* Add delay compensation */
 		pin_desc_idx = ice_ptp_find_pin_idx(pf, PTP_PF_EXTTS, chan);
@@ -1823,8 +2040,9 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 			      int on)
 {
+	u64 clk, period, start, phase, cycles, tc_phase;
+	struct ice_phc *phc = &pf->adapter->phc;
 	unsigned int gpio_pin, prop_delay_ns;
-	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
 	int err;
@@ -1869,13 +2087,23 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	err = ice_ptp_read_src_clk_reg(pf, NULL, &clk);
 	if (err)
 		return err;
+	if (phc->use_timecounter) {
+		cycles = clk;
+		clk = ice_phc_cyc2time(phc, cycles);
+		tc_phase = clk - cycles;
+	}
 	clk += NSEC_PER_MSEC * 500;
+
 	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
 	/* Compensate for propagation delay from the generator to the pin. */
 	start -= prop_delay_ns;
 
+	/* Compensate for timecounter phase offset, if necessary */
+	if (phc->use_timecounter)
+		start -= tc_phase;
+
 	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
 }
 
@@ -1973,6 +2201,8 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
 		if (on && pf->ptp.state != ICE_PTP_READY)
 			return -EIO;
 
+		/* Serialize against concurrent timecounter updates */
+		mutex_lock(&pf->adapter->phc.lock);
 		err = ice_ptp_cfg_perout(pf, &rq->perout, on);
 		if (!err) {
 			*cached = rq->perout;
@@ -1980,6 +2210,7 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
 			cached->period.sec = 0;
 			cached->period.nsec = 0;
 		}
+		mutex_unlock(&pf->adapter->phc.lock);
 		return err;
 	}
 	case PTP_CLK_REQ_EXTTS:
@@ -2009,8 +2240,7 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
  * @sts: Optional parameter for holding a pair of system timestamps from
  *       the system clock. Will be ignored if NULL is given.
  *
- * Read the device clock and return the correct value on ns, after converting it
- * into a timespec struct.
+ * Read the device time from the PHC and return it as a timespec.
  */
 static int
 ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
@@ -2024,6 +2254,9 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 	if (err)
 		return err;
 
+	if (pf->adapter->phc.use_timecounter)
+		time_ns = ice_phc_cyc2time(&pf->adapter->phc, time_ns);
+
 	*ts = ns_to_timespec64(time_ns);
 	return 0;
 }
@@ -2085,6 +2318,43 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	return 0;
 }
 
+/**
+ * ice_ptp_settime64_tc - Initialize the PHC timecounter to requested time
+ * @info: the driver's PTP info structure
+ * @ts: timespec64 structure that holds the new time value.
+ *
+ * Reset the PHC timecounter to the provided user input value.
+ *
+ * Return: 0 on success, -EIO if PTP state is not ready.
+ */
+static int ice_ptp_settime64_tc(struct ptp_clock_info *info,
+				const struct timespec64 *ts)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_phc *phc = &pf->adapter->phc;
+	u64 ns;
+
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
+	ns = timespec64_to_ns(ts);
+
+	mutex_lock(&phc->lock);
+
+	ice_ptp_disable_all_perout(pf);
+
+	ice_phc_init(phc, ns);
+
+	ice_ptp_mark_all_tx_tracker_stale(pf);
+
+	/* Reenable periodic outputs */
+	ice_ptp_enable_all_perout(pf);
+
+	mutex_unlock(&phc->lock);
+
+	return 0;
+}
+
 /**
  * ice_ptp_adjtime_nonatomic - Do a non-atomic clock adjustment
  * @info: the driver's PTP info structure
@@ -2155,6 +2425,37 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	return 0;
 }
 
+/**
+ * ice_ptp_adjtime_tc - Adjust the timecounter offset by the indicated delta
+ * @info: the driver's PTP info structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ *
+ * Return: 0 on success, -EIO if PTP state is not ready.
+ */
+static int ice_ptp_adjtime_tc(struct ptp_clock_info *info, s64 delta)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_phc *phc = &pf->adapter->phc;
+
+	if (pf->ptp.state != ICE_PTP_READY)
+		return -EIO;
+
+	mutex_lock(&phc->lock);
+
+	ice_ptp_disable_all_perout(pf);
+
+	ice_phc_adjtime(phc, delta);
+
+	ice_ptp_mark_all_tx_tracker_stale(pf);
+
+	/* Reenable periodic outputs */
+	ice_ptp_enable_all_perout(pf);
+
+	mutex_unlock(&phc->lock);
+
+	return 0;
+}
+
 /**
  * struct ice_crosststamp_cfg - Device cross timestamp configuration
  * @lock_reg: The hardware semaphore lock to use
@@ -2290,6 +2591,11 @@ static int ice_capture_crosststamp(ktime_t *device,
 	ts_lo = rd32(hw, cfg->dev_time_l[tmr_idx]);
 	ts_hi = rd32(hw, cfg->dev_time_h[tmr_idx]);
 	ts = ((u64)ts_hi << 32) | ts_lo;
+
+	/* Account for timecounter phase offset if necessary */
+	if (pf->adapter->phc.use_timecounter)
+		ts = ice_phc_cyc2time(&pf->adapter->phc, ts);
+
 	*device = ns_to_ktime(ts);
 
 err_timeout:
@@ -2677,15 +2983,21 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 		 dev_driver_string(dev), dev_name(dev));
 	info->owner = THIS_MODULE;
 	info->max_adj = 100000000;
-	info->adjtime = ice_ptp_adjtime;
 	info->adjfine = ice_ptp_adjfine;
 	info->gettimex64 = ice_ptp_gettimex64;
-	info->settime64 = ice_ptp_settime64;
 	info->n_per_out = GLTSYN_TGT_H_IDX_MAX;
 	info->n_ext_ts = GLTSYN_EVNT_H_IDX_MAX;
 	info->enable = ice_ptp_gpio_enable;
 	info->verify = ice_verify_pin;
 
+	if (pf->adapter->phc.use_timecounter) {
+		info->adjtime = ice_ptp_adjtime_tc;
+		info->settime64 = ice_ptp_settime64_tc;
+	} else {
+		info->adjtime = ice_ptp_adjtime;
+		info->settime64 = ice_ptp_settime64;
+	}
+
 	info->supported_extts_flags = PTP_RISING_EDGE |
 				      PTP_FALLING_EDGE |
 				      PTP_STRICT_FLAGS;
@@ -3174,8 +3486,8 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	struct ice_phc *phc = &pf->adapter->phc;
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
-	struct timespec64 ts;
 	int err;
+	u64 ns;
 
 	err = ice_ptp_init_phc(hw);
 	if (err)
@@ -3207,14 +3519,24 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	if (phc->update_time) {
 		s64 delta = ktime_sub(ktime_get(), phc->update_time);
 
-		ts = ns_to_timespec64(phc->cached_time + delta);
+		if (phc->use_timecounter)
+			ns = phc->tc[0].nsec + delta;
+		else
+			ns = phc->cached_time + delta;
 	} else {
-		ts = ktime_to_timespec64(ktime_get_real());
+		ns = ktime_get_real_ns();
+	}
+
+	if (phc->use_timecounter) {
+		ice_phc_init(phc, ns);
+	} else {
+		struct timespec64 ts = ns_to_timespec64(ns);
+
+		err = ice_ptp_write_init(pf, &ts);
+		if (err)
+			goto err_unlock;
 	}
 	mutex_unlock(&phc->lock);
-	err = ice_ptp_write_init(pf, &ts);
-	if (err)
-		goto err_unlock;
 
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
@@ -3403,8 +3725,8 @@ int ice_ptp_clock_index(struct ice_pf *pf)
  */
 static int ice_ptp_init_owner(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct ice_hw *hw = &pf->hw;
-	struct timespec64 ts;
 	int err;
 
 	err = ice_ptp_init_phc(hw);
@@ -3432,11 +3754,19 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	if (err)
 		goto err_unlock;
 
-	ts = ktime_to_timespec64(ktime_get_real());
-	/* Write the initial Time value to PHY and LAN */
-	err = ice_ptp_write_init(pf, &ts);
-	if (err)
-		goto err_unlock;
+	if (phc->use_timecounter) {
+		mutex_lock(&phc->lock);
+		ice_phc_init(phc, ktime_get_real_ns());
+		mutex_unlock(&phc->lock);
+	} else {
+		struct timespec64 ts;
+
+		/* Write the initial Time value to PHY and LAN */
+		ktime_get_real_ts64(&ts);
+		err = ice_ptp_write_init(pf, &ts);
+		if (err)
+			goto err_unlock;
+	}
 
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 8576f186480f..6d4d97ac1d6d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -395,6 +395,7 @@ static bool ice_clean_tx_irq(struct ice_tx_ring *tx_ring, int napi_budget)
  */
 static int ice_alloc_tstamp_ring(struct ice_tx_ring *tx_ring)
 {
+	struct ice_pf *pf = tx_ring->vsi->back;
 	struct ice_tstamp_ring *tstamp_ring;
 
 	/* allocate with kzalloc(), free with kfree_rcu() */
@@ -403,6 +404,7 @@ static int ice_alloc_tstamp_ring(struct ice_tx_ring *tx_ring)
 		return -ENOMEM;
 
 	tstamp_ring->tx_ring = tx_ring;
+	tstamp_ring->phc = &pf->adapter->phc;
 	tx_ring->tstamp_ring = tstamp_ring;
 	tstamp_ring->desc = NULL;
 	tstamp_ring->count = ice_calc_ts_ring_count(tx_ring);
@@ -1520,6 +1522,7 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 	if (ice_is_txtime_cfg(tx_ring)) {
 		struct ice_tstamp_ring *tstamp_ring;
 		struct ice_ts_desc *ts_desc;
+		struct ice_phc *phc;
 		u32 tstamp_count, j;
 		u64 tstamp;
 
@@ -1528,10 +1531,14 @@ ice_tx_map(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first,
 		if (unlikely(!tstamp_ring))
 			goto ring_kick;
 
+		phc = tstamp_ring->phc;
+
 		tstamp_count = tstamp_ring->count;
 		j = tstamp_ring->next_to_use;
 
 		tstamp = ktime_to_ns(first->skb->tstamp);
+		if (phc->use_timecounter)
+			tstamp -= ice_phc_get_phase(phc);
 		tstamp >>= ICE_TXTIME_CTX_RESOLUTION_128NS;
 
 		ts_desc = ICE_TS_DESC(tstamp_ring, j);
diff --git a/drivers/net/ethernet/intel/ice/virt/virtchnl.c b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
index 76f0b4d85dc9..135dc03c8ffe 100644
--- a/drivers/net/ethernet/intel/ice/virt/virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/virt/virtchnl.c
@@ -326,7 +326,12 @@ static int ice_vc_get_vf_res_msg(struct ice_vf *vf, u8 *msg)
 	if (vf->driver_caps & VIRTCHNL_VF_OFFLOAD_QOS)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_OFFLOAD_QOS;
 
-	if (vf->driver_caps & VIRTCHNL_VF_CAP_PTP)
+	/* Do not enable VF PTP capability on devices which use a timecounter.
+	 * Proper support for these devices requires extensions to the
+	 * virtchnl interface that have not yet been developed.
+	 */
+	if (vf->driver_caps & VIRTCHNL_VF_CAP_PTP &&
+	    !vf->pf->adapter->phc.use_timecounter)
 		vfres->vf_cap_flags |= VIRTCHNL_VF_CAP_PTP;
 
 	vfres->num_vsis = 1;

-- 
2.56.0.215.g47fdf2208c5b

