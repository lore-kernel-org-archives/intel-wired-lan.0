Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D46606A882
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Nov 2026 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=YygJXk4Z;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XtWfW5MI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36F4F81246;
	Fri, 13 Nov 2026 23:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yHmNRdMBe6r; Fri, 13 Nov 2026 23:30:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6830181283
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794612654;
	b=dyRMZLTrawweBDSmxjbCzIXbCWdwrR6WgDliay/akcWifTV4ON9nJVcDep4AzGE6zw2m
	 7aXIBYJp5Z58KpRfA0Ogt2cZWJmq/57jcnq6k7NP9Cte0AP4dN8VmVemTpvEXcbcUgiPM
	 yGxf4r+o8HBDn/lJ3Qj6F2KQY8agUIPvS4hj4rkCj3u27gGpO/PZ6es9Xdvu/1Rto8CVS
	 QM9SNOAJAJOEFyZadkzEuwE2mjhJSTS+OtadL1gDO3r0+3m6zm3qRHQ78tExjbe/tuxP/
	 mlEo4NfpL5jPbdugfYNluhLON7TYOHgvM9p6ygDy3MKf6/OkUBFid8hqKXnZO8uGQ1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794612654;
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
	bh=lCOQTIHoaWsy7cEC/PV7dyF6XuyOOmaH05aoxjzsiUg=;
	b=bdDbP874d/Of/IZCNNS3nuWtAIRfn3B90gwrRdgfa5IiN/30C8bmZm69pYevHr1G3KFt
	 EBIs4JecUpP13olwxqeZHGWVyJJs7snzhWWLs4jRm5jiMJc30yKKZgzEBjpYGItKmLnvU
	 r499pTgrf0uoOL4ii7deuiQFJ03sQR7yVCzRDEJhsiE01cdiYubSXuxEz/rhF6S92prvq
	 t8jypdoSuuOH1NmpYSGhn8L3tiFbK7Wrz08oVKgiN1OTFOjij9YTQbLjhsVKOOLCVI+f/
	 rNNSD/kHlFh5VHzbWZX0+m+nZwGRGQveeVvCELN6qTBuJW6htyRH2+b2w1yxt0qCzIw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794612654;
	bh=lCOQTIHoaWsy7cEC/PV7dyF6XuyOOmaH05aoxjzsiUg=;
	h=From:Date:Subject:References:In-Reply-To:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YygJXk4ZKDLaHNPfYp3dqFxPmSGVKgZvaCwofg+cnWqOedGB0FfVJWbI1ppt2GUuk
	 iwPR8g8vey4ElNvp0YImDWZRAsSpnOwbolIT+7RCP4Zle0Ynf5985w22esaXhQZfp/
	 MXdE2P9ad2XaxIe2Pu16HivZfBqyGMQGz0BvJOBTooU0dBXnQqzjmBnS2tCqNaQMGU
	 l3Z2u0P10BNxCGoFMBv4m86C1TMmju+pzVvq1RBsxQl10hnnHiRP2iVF8M4/+fFKXp
	 1GtEe2sDnhdOqba3ZpAfiw8ekrDtJPRBtedoxwVlqFHFCC9rStIH6EJm4axy7FsbXF
	 G/qSbPFFgKz+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6830181283;
	Fri, 13 Nov 2026 23:30:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D24252FB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B6ED140E7E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WaQkHh_WmzSU for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 23:30:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8EA6B40EA6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.19
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XtWfW5MI
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8EA6B40EA6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794612650; x=1826148650;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to;
 bh=Y5ivBJhi/R2IjdbUpUdivoCPobg0uvCoZy0vukkbQec=;
 b=XtWfW5MISAepk5pNorP8bucjj6SpQD5gO87ldjifu61LCjh4we7TNc7B
 mX7q/AD7JpSAa/r0yM2vhE7lMcGgZmbrK4HYhMYT9RArtcR4Sze9GoZ3w
 arBgltOFGUANxDyViCWtAUCtUTFGnAARvxdcF6aDT3a6D2ws655nQCBPH
 CESLp8JXWZVdaNhKQH6pLx5v7nGNkmd4gqT9HSMwq27xSIjECm/f3FVHv
 Sx7WRxSd57Vwy6ry40eeY45+uIXzRb4Lc38c1sS564r0KjTGbCn0Pr4Nl
 DygQyZtmA5kvRNOSOHNV6XHT2UVtJ8cUhnJpKLl9xZw/nk+J2zk1+pvXk A==;
X-CSE-ConnectionGUID: uWUiDUmdQhOjuViQvSMnHg==
X-CSE-MsgGUID: 6T5s+QRkT0usO/hufh6c1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3470196"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3470196"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:30:48 -0800
X-CSE-ConnectionGUID: b7MRtPjVR+6b/bKRXT3Huw==
X-CSE-MsgGUID: Xa1pK/UjSU67/xEReW6lzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9574075"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 15:30:47 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 13 Nov 2026 15:30:03 -0800
Subject: [PATCH iwl-next v2 3/4] ice: store cached PHC time in ice_adapter
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-jk-e825-e830-timecounter-v2-3-9c357a7ed349@intel.com>
References: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
In-Reply-To: <20261113-jk-e825-e830-timecounter-v2-0-9c357a7ed349@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=25237;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Y5ivBJhi/R2IjdbUpUdivoCPobg0uvCoZy0vukkbQec=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqzvcxfKKDk/mKyyUcv8peg5lTO/7RNspPWTp8p3lTo4T
 o699WJjRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNx/MzIMCOwz2g32yXZmdK5
 mZHiCx7s5brsbxC6QdqNs+9D+x52eYY/vKsy3LbFGhVM33J/xZ0VZgl1L/wXur/hXPX/2+8XmRO
 O8wAA
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

The ice driver uses a cached copy of the PTP Hardware Clock time for its
timestamp extension algorithm implemented in ice_ptp_extend_32b_ts(). This
algorithm is based on work originally from struct timecounter, and relies
on a cached copy of the PTP time used to extend 32-bit snapshots of the PTP
time into full 64-bit time values.

The driver currently stores this cache once in the ice_ptp structure for
each PF and once per each Rx ring on each PF. Each PF is then responsible
for calling ice_ptp_update_cached_phctime() at least once every 2 seconds.
This is handled by the per-PF periodic work task that runs on a per-PF
kthread. Each Rx ring must be updated, which requires looping the VSI and
ring structures, and might fail due to the rings being reconfigured.

In order to fix some device-specific bugs, a following change is going to
refactor the driver to support using a timecounter structure to avoid
needing to perform direct time adjustments in hardware on E825 and E830.

Use of a timecounter will require the that the Rx path have a reference to
that structure. To ensure that all PFs on the same device have the same
time domain, the structure must be part of the whole adapter, making
ice_adapter the best place to store it. The initial implementation will
focus only on migrating the E825 and E830 devices, to minimize impact and
potential regression.

Since the Rx path will need to reference a structure anyways, it makes
little sense to maintain both a cached copy of the PHC time in addition to
a pointer to the adapter.

As a first step, refactor the driver to store the existing cached PHC time
in ice_adapter, instead of per-PF in each ice_ptp structure and in the Rx
rings.

Create a struct ice_phc structure to store the PTP Hardware Clock fields,
and embed it in ice_adapter. Store a pointer to the PHC structure in the Rx
rings, replacing the cached_phctime.

Pass a pointer to the PHC structure to ice_ptp_extend_32b_ts() and obtain
the cached time from that structure. Modify the Tx and Rx paths to stop
using a zero value of cached_time as a canary for the clock owner
disappearing. The ice_ptp_read_src_clk_reg() can't fail when called by the
clock owner anyways, so this check is not very meaningful when only the
clock owner performs the cached update.

Modify the ice_ptp_update_cached_phctime(), removing logic to update the
cached time within the Rx rings. Convert it to a void function since it can
no longer fail in a meaningful way.

Change ice_ptp_periodic_work() to check ice_pf_src_tmr_owned() and only
call ice_ptp_update_cached_phctime() for the clock owner. To ensure a
consistent update after the clock adjustments, use a mutex to serialize the
calls to ice_ptp_update_cached_phctime(). This lock is acquired *before*
the read of the current time. This ensures that even if a periodic update
races with a clock adjustment, it will either happen before or will see the
clock adjusted after as it updates cached_time. Performing the update only
on the clock owner does make the late_cached_phc_updates ethtool stat only
apply for the clock owner.

Since the Rx path now has access to the PHC structure, move the timeout
check from ice_ptp_extend_40b_ts() into ice_ptp_extend_32b_ts(). This
ensures that Rx timestamps also get discarded if the cached PHC update
becomes stale.

The ice_ptp_reset_cached_phctime() function previously only applied to the
clock owner. This was wrong, as the driver should have been updating all
ports cached time copy, and marking each port tracker as stale. Introduce
the ice_ptp_mark_all_tx_tracker_stale() and use it here.

Separate the PHC reset time from the cached time value in
ice_ptp_rebuild_owner(), rather than relying on the cached_phc_time. Read
the value of the PHC time near the same time that we save ptp->reset_time.
If a hardware reset has already begun, the GLTSYN_TIME registers should
read as 0 which will trigger the rebuild path to reinitialize from the
kernel time.

These changes eliminate failure points from the cached PHC time update,
reduce needless duplicate work across PFs, and ensure consistency of the
cached time update w.r.t clock adjustments. They also pave the way for
introduction of a timecounter in a following change.

Careful readers may note that non-owner PFs now completely depend on the
clock owner PF being loaded to ensure the cached time is up to date,
as they will start discarding timestamps 2 seconds after the last update.
However, PTP already has a strong dependency on the clock owner PF. Only
the owner initializes the PHC mac timer and exposes the PTP clock device.
E822 and E825 devices also depend on the clock owner miscellaneous IRQ for
handling all Tx timestamps. PTP also will not behave right under PCIe
device passthru unless all PFs are assigned into the same VM, due to
depending on coordination via the ice_adapter structure. This is a
limitation due to the quirks of the device design.

The Rx path now requires accessing the PHC structure via a dereference and
performs the jiffies timeout check which may impact performance. However,
this ensures that Rx timestamps do not get extended on stale data and
access to the PHC is required for the timecounter refactor anyways.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  22 +++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   6 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h    |   4 +-
 drivers/net/ethernet/intel/ice/ice_adapter.c |   4 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c |   1 -
 drivers/net/ethernet/intel/ice/ice_lib.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 223 +++++++++++----------------
 7 files changed, 120 insertions(+), 142 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index ce1fe0846265..acde4031d528 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -35,6 +35,25 @@ struct ice_port_list {
 	struct srcu_struct srcu;
 };
 
+/**
+ * struct ice_phc - PTP Hardware Clock fields
+ * @cached_time: Cached copy of the PHC time for timestamp extension
+ * @update_jiffies: Jiffies when PHC was last updated
+ * @lock: For protecting updates to the PHC fields.
+ *
+ * Readers are lockless and rely on READ_ONCE/WRITE_ONCE for the cached_time
+ * and smp_acquire/smp_release for the update_jiffies field.
+ *
+ * Writers must acquire the lock mutex to ensure that the periodic task cannot
+ * write back an out-of-date cached value after a clock adjustment.
+ */
+struct ice_phc {
+	u64 cached_time;
+	unsigned long update_jiffies;
+	/* Serialize updates to cached_time */
+	struct mutex lock;
+};
+
 /**
  * struct ice_adapter - PCI adapter resources shared across PFs
  * @refcount: Reference count. struct ice_pf objects hold the references.
@@ -46,6 +65,7 @@ struct ice_port_list {
  * @cgu_synce_lock: Mutex serializing changes of the CGU registers R10 and R11,
  *                  which all PFs reach. Used on E825C devices.
  * @ps_lock: Mutex to serialize PHY port start/stop across adapter.
+ * @phc: PTP Hardware Clock fields
  * @ctrl_pf_lock: Protect control PF lifetime for sleepable users
  * @ctrl_pf: Control PF of the adapter
  * @rebuild_lock: serialize PFR recovery across PFs of the same adapter
@@ -73,6 +93,8 @@ struct ice_adapter {
 	/* For serializing PHY port start/stop sequences */
 	struct mutex ps_lock;
 
+	struct ice_phc phc;
+
 	struct rw_semaphore ctrl_pf_lock;
 	struct ice_pf __rcu *ctrl_pf;
 	struct ice_port_list ports;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 40a0e654c2c6..430441b43150 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -235,8 +235,6 @@ struct ice_ptp_pin_desc {
  * @tx_interrupt_mode: the TX interrupt mode for the PTP clock
  * @port: data for the PHY port initialization procedure
  * @work: delayed work function for periodic tasks
- * @cached_phc_time: a cached copy of the PHC time for timestamp extension
- * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
  * @kworker: kwork thread for handling periodic work
  * @ext_ts_irq: the external timestamp IRQ in use
  * @pin_desc: structure defining pins
@@ -248,6 +246,7 @@ struct ice_ptp_pin_desc {
  * @tstamp_config: hardware timestamping configuration
  * @tx_refclks: bitmaps table to store the information about TX reference clocks
  * @reset_time: kernel time after clock stop on reset
+ * @phc_reset_time: PHC time at clock stop on reset
  * @tx_hwtstamp_good: number of completed Tx timestamp requests
  * @tx_hwtstamp_skipped: number of Tx time stamp requests skipped
  * @tx_hwtstamp_timeouts: number of Tx skbs discarded with no time stamp
@@ -270,8 +269,6 @@ struct ice_ptp {
 	enum ice_ptp_tx_interrupt tx_interrupt_mode;
 	struct ice_ptp_port port;
 	struct kthread_delayed_work work;
-	u64 cached_phc_time;
-	unsigned long cached_phc_jiffies;
 	struct kthread_worker *kworker;
 	u8 ext_ts_irq;
 	struct ptp_pin_desc pin_desc[ICE_N_PINS_MAX];
@@ -283,6 +280,7 @@ struct ice_ptp {
 	struct kernel_hwtstamp_config tstamp_config;
 	unsigned long tx_refclks[ICE_E825_MAX_PHYS][ICE_REF_CLK_MAX];
 	u64 reset_time;
+	u64 phc_reset_time;
 	u64 tx_hwtstamp_good;
 	u32 tx_hwtstamp_skipped;
 	u32 tx_hwtstamp_timeouts;
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 5e517f219379..83a34322e0d3 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -221,7 +221,7 @@ enum ice_tx_ring_flags {
 };
 
 struct ice_pkt_ctx {
-	u64 cached_phctime;
+	struct ice_phc *phc;
 	__be16 vlan_proto;
 };
 
@@ -321,7 +321,7 @@ struct ice_rx_ring {
 	union {
 		struct ice_pkt_ctx pkt_ctx;
 		struct {
-			u64 cached_phctime;
+			struct ice_phc *phc;
 			__be16 vlan_proto;
 		};
 	};
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 29e089a5a86e..f3ee5e60613e 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -83,6 +83,8 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 
 	mutex_init(&adapter->ps_lock);
 
+	mutex_init(&adapter->phc.lock);
+
 	return adapter;
 }
 
@@ -98,6 +100,8 @@ static void ice_adapter_free(struct ice_adapter *adapter)
 	cleanup_srcu_struct(&adapter->ports.srcu);
 	mutex_destroy(&adapter->ps_lock);
 
+	mutex_destroy(&adapter->phc.lock);
+
 	kfree(adapter);
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 90fa11b22820..ca5137724b38 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3338,7 +3338,6 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		/* clone ring and setup updated count */
 		rx_rings[i] = *vsi->rx_rings[i];
 		rx_rings[i].count = new_rx_cnt;
-		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
 		rx_rings[i].xdp_buf = NULL;
 		rx_rings[i].xdp_rxq = (struct xdp_rxq_info){ };
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 9be3f52bb9d9..f3fefab09f8c 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1527,7 +1527,7 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
 		ring->count = vsi->num_rx_desc;
-		ring->cached_phctime = pf->ptp.cached_phc_time;
+		ring->phc = &pf->adapter->phc;
 
 		if (ice_is_feature_supported(pf, ICE_F_GCS))
 			ring->flags |= ICE_RX_FLAGS_RING_GCS;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index bf37c2a7ff86..a0451c1083a4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -274,8 +274,9 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 
 /**
  * ice_ptp_extend_32b_ts - Convert a 32b nanoseconds timestamp to 64b
- * @cached_phc_time: recently cached copy of PHC time
+ * @phc: PTP Hardware Clock structure
  * @in_tstamp: Ingress/egress 32b nanoseconds timestamp value
+ * @trace_rx: True if this call should trigger an Rx timestamp trace
  *
  * Hardware captures timestamps which contain only 32 bits of nominal
  * nanoseconds, as opposed to the 64bit timestamps that the stack expects.
@@ -309,13 +310,27 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
  * This is prevented by (a) periodically updating the cached PHC time once
  * a second, and (b) discarding any Tx timestamp packet if it has waited for
  * a timestamp for more than one second.
+ *
+ * Return: the extended timestamp value, or 0 if phc->update_jiffies is stale.
  */
-static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
+static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc,
+				 u32 in_tstamp, bool trace_rx)
 {
+	unsigned long discard_time;
+	u64 ns, cached_phc_time;
 	u32 delta, phc_time_lo;
-	u64 ns;
 
-	/* Extract the lower 32 bits of the PHC time */
+	/* Discard the timestamp if update_jiffies hasn't been initialized */
+	discard_time = smp_load_acquire(&phc->update_jiffies);
+	if (!discard_time)
+		return 0;
+
+	/* Discard the hardware timestamp if the cached PHC time is too old */
+	discard_time += msecs_to_jiffies(2000);
+	if (time_is_before_jiffies(discard_time))
+		return 0;
+
+	cached_phc_time = READ_ONCE(phc->cached_time);
 	phc_time_lo = (u32)cached_phc_time;
 
 	/* Calculate the delta between the lower 32bits of the cached PHC
@@ -336,6 +351,9 @@ static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
 		ns = cached_phc_time + delta;
 	}
 
+	if (trace_rx)
+		ice_trace(rx_hwtstamp, cached_phc_time, in_tstamp, ns);
+
 	return ns;
 }
 
@@ -359,7 +377,7 @@ static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
  * calling this function.
  *
  * Extract the 32bit nominal nanoseconds and extend them. Use the cached PHC
- * time stored in the device private PTP structure as the basis for timestamp
+ * time stored in the adapter PHC structure as the basis for timestamp
  * extension.
  *
  * See ice_ptp_extend_32b_ts for a detailed explanation of the extension
@@ -367,28 +385,17 @@ static u64 ice_ptp_extend_32b_ts(u64 cached_phc_time, u32 in_tstamp)
  */
 static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	const u64 mask = GENMASK_ULL(31, 0);
-	unsigned long discard_time;
-	u64 cached_time;
+	u64 ns;
 
-	/* Discard the hardware timestamp if the cached PHC time is too old */
-	discard_time = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
-	if (time_is_before_jiffies(discard_time)) {
+	ns = ice_ptp_extend_32b_ts(phc, (in_tstamp >> 8) & mask, false);
+
+	/* A value of 0 indicates the timestamp was discarded */
+	if (!ns)
 		pf->ptp.tx_hwtstamp_discarded++;
-		return 0;
-	}
 
-	/* Discard it as well if there is no cached PHC time at all, which is
-	 * how ice_ptp_update_cached_phctime() reports that the source clock
-	 * has become unreachable.
-	 */
-	cached_time = READ_ONCE(pf->ptp.cached_phc_time);
-	if (!cached_time) {
-		pf->ptp.tx_hwtstamp_discarded++;
-		return 0;
-	}
-
-	return ice_ptp_extend_32b_ts(cached_time, (in_tstamp >> 8) & mask);
+	return ns;
 }
 
 /**
@@ -903,6 +910,31 @@ ice_ptp_flush_all_tx_tracker(struct ice_pf *pf)
 	srcu_read_unlock(&ports->srcu, srcu_idx);
 }
 
+/**
+ * ice_ptp_mark_all_tx_tracker_stale - Mark all unfinished timestamps stale
+ * @pf: Board private structure
+ *
+ * Mark currently outstanding Tx timestamps for all ports as stale. Called by
+ * the clock owner when a time adjustment is made to prevent accidentally
+ * extending timestamps captured before the adjustment.
+ */
+static void ice_ptp_mark_all_tx_tracker_stale(struct ice_pf *pf)
+{
+	struct ice_port_list *ports = &pf->adapter->ports;
+	struct ice_ptp_port *port;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&ports->srcu);
+	list_for_each_entry_srcu(port, &ports->list, list_node,
+				 srcu_read_lock_held(&ports->srcu)) {
+		if (!kref_get_unless_zero(&port->ref))
+			continue;
+		ice_ptp_mark_tx_tracker_stale(&port->tx);
+		kref_put(&port->ref, ice_ptp_release_port_srcu);
+	}
+	srcu_read_unlock(&ports->srcu, srcu_idx);
+}
+
 /**
  * ice_ptp_release_tx_tracker - Release allocated memory for Tx tracker
  * @pf: Board private structure
@@ -987,35 +1019,28 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
 }
 
 /**
- * ice_ptp_update_cached_phctime - Update the cached PHC time values
+ * ice_ptp_update_cached_phctime - Update the cached PHC time value
  * @pf: Board specific private structure
  *
- * This function updates the system time values which are cached in the PF
- * structure and the Rx rings.
+ * Update the PTP hardware clock time values which are cached in the PHC
+ * structure.
  *
- * This function must be called periodically to ensure that the cached value
- * is never more than 2 seconds old.
- *
- * Note that the cached copy in the PF PTP structure is always updated, even
- * if we can't update the copy in the Rx rings.
- *
- * Return:
- * * 0 - OK, successfully updated
- * * -EAGAIN - PF was busy, need to reschedule the update
- * * -ENODEV - no control PF owns the source clock register space
- * * -EOPNOTSUPP - PTP support is not compiled in
+ * This function must be called periodically by the clock owner to ensure that
+ * the cached value is never more than 2 seconds old.
  */
-static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
+static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct device *dev = ice_pf_to_dev(pf);
 	unsigned long update_before;
 	u64 systime;
-	int err, i;
+	int err;
 
-	update_before = pf->ptp.cached_phc_jiffies + msecs_to_jiffies(2000);
-	if (pf->ptp.cached_phc_time &&
-	    time_is_before_jiffies(update_before)) {
-		unsigned long time_taken = jiffies - pf->ptp.cached_phc_jiffies;
+	mutex_lock(&phc->lock);
+
+	update_before = phc->update_jiffies + msecs_to_jiffies(2000);
+	if (phc->update_jiffies && time_is_before_jiffies(update_before)) {
+		unsigned long time_taken = jiffies - phc->update_jiffies;
 
 		dev_warn(dev, "%u msecs passed between update to cached PHC time\n",
 			 jiffies_to_msecs(time_taken));
@@ -1024,44 +1049,13 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
 
 	/* Read the current PHC time */
 	err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
-	if (err) {
-		/* The source clock is gone, so the cache can no longer be
-		 * refreshed. Publish zero instead of leaving the last good
-		 * value behind: neither ice_ptp_get_rx_hwts() nor
-		 * ice_ptp_extend_40b_ts() may extend against a value that no
-		 * longer tracks the PHC, and both treat a zero cache as
-		 * "no timestamp".
-		 */
-		systime = 0;
-		WRITE_ONCE(pf->ptp.cached_phc_time, 0);
-	} else {
-		/* Update the cached PHC time stored in the PF structure */
-		WRITE_ONCE(pf->ptp.cached_phc_time, systime);
-		WRITE_ONCE(pf->ptp.cached_phc_jiffies, jiffies);
+	if (!err) {
+		WRITE_ONCE(phc->cached_time, systime);
+		/* Paired with smp_load_acquire in ice_ptp_extend_32b_ts */
+		smp_store_release(&phc->update_jiffies, jiffies | 1);
 	}
 
-	if (test_and_set_bit(ICE_CFG_BUSY, pf->state))
-		return -EAGAIN;
-
-	ice_for_each_vsi(pf, i) {
-		struct ice_vsi *vsi = pf->vsi[i];
-		int j;
-
-		if (!vsi)
-			continue;
-
-		if (vsi->type != ICE_VSI_PF)
-			continue;
-
-		ice_for_each_rxq(vsi, j) {
-			if (!vsi->rx_rings[j])
-				continue;
-			WRITE_ONCE(vsi->rx_rings[j]->cached_phctime, systime);
-		}
-	}
-	clear_bit(ICE_CFG_BUSY, pf->state);
-
-	return err;
+	mutex_unlock(&phc->lock);
 }
 
 /**
@@ -1070,41 +1064,18 @@ static int ice_ptp_update_cached_phctime(struct ice_pf *pf)
  *
  * This function must be called when the cached PHC time is no longer valid,
  * such as after a time adjustment. It marks any currently outstanding Tx
- * timestamps as stale and updates the cached PHC time for both the PF and Rx
- * rings.
- *
- * If updating the PHC time cannot be done immediately, a warning message is
- * logged and the work item is scheduled immediately to minimize the window
- * with a wrong cached timestamp.
+ * timestamps as stale and updates the cached PHC time.
  */
 static void ice_ptp_reset_cached_phctime(struct ice_pf *pf)
 {
-	struct device *dev = ice_pf_to_dev(pf);
-	int err;
-
-	/* Update the cached PHC time immediately if possible, otherwise
-	 * schedule the work item to execute soon.
-	 */
-	err = ice_ptp_update_cached_phctime(pf);
-	if (err) {
-		/* If another thread is updating the Rx rings, we won't
-		 * properly reset them here. This could lead to reporting of
-		 * invalid timestamps, but there isn't much we can do.
-		 */
-		dev_warn(dev, "%s: unable to immediately update cached PHC time, err %d\n",
-			 __func__, err);
-
-		/* Queue the work item to update the Rx rings when possible */
-		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work,
-					   msecs_to_jiffies(10));
-	}
+	ice_ptp_update_cached_phctime(pf);
 
 	/* Mark any outstanding timestamps as stale, since they might have
 	 * been captured in hardware before the time update. This could lead
 	 * to us extending them with the wrong cached value resulting in
 	 * incorrect timestamp values.
 	 */
-	ice_ptp_mark_tx_tracker_stale(&pf->ptp.port.tx);
+	ice_ptp_mark_all_tx_tracker_stale(pf);
 }
 
 /**
@@ -2479,28 +2450,14 @@ int ice_ptp_hwtstamp_set(struct net_device *netdev,
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx)
 {
-	u64 ts_ns, cached_time;
 	u32 ts_high;
+	u64 ts_ns;
 
 	if (!(rx_desc->wb.time_stamp_low & ICE_PTP_TS_VALID))
 		return 0;
 
-	cached_time = READ_ONCE(pkt_ctx->cached_phctime);
-
-	/* Do not report a timestamp if we don't have a cached PHC time */
-	if (!cached_time)
-		return 0;
-
-	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
-	 * PHC value, rather than accessing the PF. This also allows us to
-	 * simply pass the upper 32bits of nanoseconds directly. Calling
-	 * ice_ptp_extend_40b_ts is unnecessary as it would just discard these
-	 * bits itself.
-	 */
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
-	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
-
-	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
+	ts_ns = ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high, true);
 
 	return ts_ns;
 }
@@ -3099,24 +3056,20 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 {
 	struct ice_ptp *ptp = container_of(work, struct ice_ptp, work.work);
 	struct ice_pf *pf = container_of(ptp, struct ice_pf, ptp);
-	int err;
 
 	if (pf->ptp.state != ICE_PTP_READY)
 		return;
 
 	ice_ptp_tspll_monitor(pf);
 
-	err = ice_ptp_update_cached_phctime(pf);
+	if (ice_pf_src_tmr_owned(pf))
+		ice_ptp_update_cached_phctime(pf);
 
 	ice_ptp_maybe_trigger_tx_interrupt(pf);
 
-	/* Run twice a second, or retry soon if another thread was busy
-	 * updating the Rx rings. Other errors, such as a missing control PF,
-	 * do not clear up on their own and must not turn the periodic worker
-	 * into a busy loop.
-	 */
+	/* Run twice a second */
 	kthread_queue_delayed_work(ptp->kworker, &ptp->work,
-				   msecs_to_jiffies(err == -EAGAIN ? 10 : 500));
+				   msecs_to_jiffies(500));
 }
 
 /**
@@ -3211,6 +3164,8 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	/* Acquire PHC and system timer to restore after reset */
 	ptp->reset_time = ktime_get_real_ns();
+	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
+		ptp->phc_reset_time = 0;
 }
 
 /**
@@ -3250,13 +3205,13 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	if (err)
 		goto err_unlock;
 
-	/* Write the initial Time value to PHY and LAN using the cached PHC
-	 * time before the reset and time difference between stopping and
-	 * starting the clock.
+	/* Write the initial Time value to PHY and LAN using the PHC time
+	 * before the reset and time difference between stopping and starting
+	 * the clock.
 	 */
-	if (ptp->cached_phc_time) {
+	if (ptp->phc_reset_time) {
 		time_diff = ktime_get_real_ns() - ptp->reset_time;
-		ts = ns_to_timespec64(ptp->cached_phc_time + time_diff);
+		ts = ns_to_timespec64(ptp->phc_reset_time + time_diff);
 	} else {
 		ts = ktime_to_timespec64(ktime_get_real());
 	}

-- 
2.56.0.215.g47fdf2208c5b

