Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53E606A31B
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=a1fcKh8z;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i24UW16g
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C81E08165B;
	Sat, 24 Oct 2026 01:26:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GELM3_lWGfsA; Sat, 24 Oct 2026 01:25:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DA77281670
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792805158;
	b=SfFs5UECe4MB3+uMXNExa7H9szpNxB9CZKAlTjvh+8IVqBpfbnrwKMeZYTn1SF68r5TC
	 J2wS0Ecf9mlt52LNWkoG7ZXtjvsZuNenYqkuC7kGQVrzfnqrsZH5uRs/DE5kaZjO3ea+A
	 SAh21+tKsTlwCVbeL6+7xPwS4sS4+OQ7fwUKdyxy5ewZiA6VIrck2+i/lEA6YHQldEus/
	 raPG7XzlNYN6FdGVnDtKJXX4+h/kTVYmi0bKEu1wiXS9UkfbMq6601xy/zXklFGXL2TnF
	 zFR3+QFSmjrlJAezlDjHibLMHbrHq+e2lg9+2dMGwYz2RPF00rgcMoWO/opwaH8Od1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792805158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6jatqWU2ltsIbqum/ukE0Kky74H2w2ySLkcWe3YH/Kw=;
	b=EdrYnLQP5CZIaCNfCRAYvPBnSpLLe79utDFcDw7BKDtRAPcAOVI3+tIpJEt/OiyBBF+a
	 QxFTAA0vVPe4fFaS+rJ9vcQIlPBY8AXeJtJiAkitSWylyJRu1q/yHNUTa9K4ftCeDa1e0
	 PpvzL/zT/FAkBNIA/6maIUXJbcaCNVyGUW6x73ORs0C4riu4RAtEVVc7YLmJfvMr1DMOG
	 TJIlkQY+PASBZ96vnyNB3uweov2SNWj1pq5kO0qw9jRHk9JB6JDmjQ2o54kKXW40yzWdR
	 fYfRPrp5kokLzERtVzobj4IVE32pgKegL3L4JNQ59zCVX+5GBriiSchhaZsilWTXn1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792805158;
	bh=6jatqWU2ltsIbqum/ukE0Kky74H2w2ySLkcWe3YH/Kw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a1fcKh8zamJVYXmSKrRGewtdcXtiSORD4wqcDbklWsZ8BwKy3eZrth5nDKuBPnRb0
	 QqgN4FjPNXwupDHY2u86Z3GtP+89QCwKnO2DUM8Tuq5DcfXeIIT5GyNYe6mbOXWnV2
	 C1yF/gMLqxSke2oBeTf+Anal0lZxd/XBkLwX58sjcPP0U1IU8+rcTvuiOC6xh6ecwh
	 jfFgSYqOtBHMZBNkTSznBD+pPxKBkxCcYkh59Mtz11fiVn1nfdXov9hQ13ttbGONGw
	 Rfog3svnUKU76U031SR5xUemWOX6NT9IONbCmGcqCET6e1tPUp4JpeJFraqEq+i9NV
	 wWxivLjnc70Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA77281670;
	Sat, 24 Oct 2026 01:25:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9A1743
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CB2CE40068
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dhu1EyIaKWOI for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 01:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 16AA040476
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792805155;
 b=BPXRh3+ngG9kTsSGHQ+urVnB1E+fA7PYI9qbbPbzD08IA/2AxirLDYFxW5If9o1Hyot9
 dJ8SL3CbS1gW/bimYeVuu6XvTYMDREXvwuUj1+f1k6oB4E0soeXLp6lyOOVEno1Ob8oI4
 E6exhY86cEsyKFgoEnp+CbACseANJdSUgfAO+krUkHjr3v7gXAZq2POhESu+TetQ5QnjP
 iCqoyOB/3P2WEQajHKzi7vgfau3775g6XFE5yVH/fTCi3jWBNEoo5/rL0OBQSS0Hooy1k
 fN2bjkRGtRWdGaS0upWAqIYY+XmN3pNh6ruVtV8chFGeOsmOFKulu6CTp9bAUsyqoZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792805155;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=6jatqWU2ltsIbqum/ukE0Kky74H2w2ySLkcWe3YH/Kw=;
 b=K0qJzotYvehPW3tMGuBt6EScgJ2IOKnep164blLjG0qcLthfjsZRRkApjtx9tUCp0yHw
 hpU8gSWyPROH4HQl0rwgzEtXhzcjusZFJiqntINAbQoZdWozDIhra2TLcW2MkBfYh4NF/
 +gJT2IkqsLoL3tDslNoBgpCdXJAC0GpR4l4HgoaCucjcT+5FE0U2pVZqFtO346TFlYJQD
 5HX5b8G6gkNLbOl8x4fOPE8Zo7r75p8rDIuOGh7IlsmFA2LMvaVA+HMQvc2RhDHsC+EIw
 LfFIww4GegeWjXdf/NdYLaed8FuZm4hW8OKWNGqbKN8NQO0x7etyuf3rCrNW6li2wOg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=i24UW16g; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=i24UW16g
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 16AA040476
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792805156; x=1824341156;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=kae7h/4+19k0Odd+cpSCs2qSEPgjkAt9xFKKt5vUvTI=;
 b=i24UW16g55jIniJRYU22w9PUxxLZL42mPUNrKutBFEel1ygMQ3ENFPkT
 g62LzT+MS7/tLO6OPhwmVT/RXVu+SSiObGt66uiWnzX/jxvZ6iagVoTSd
 8923ykTfOEfjKbb2dMYkjlsEz5+US/0okTV9AYzhZfEXpwg9YIuG5MJah
 ShZ8txu0vYXj4HXOCY2dXYnnZK4et5MpTbiWWAEJMTx2630F34rflNLXy
 XddtDbqoqVNDgWpbY+mJfCD0++VMMu48otcDM0ISmpyhp1LKjp9oHJ6rx
 tZ4nVNG1JbUBq65fpAmJwqEN42QAa1fxSqZSJORJygR4uvaSxeYBTP94T A==;
X-CSE-ConnectionGUID: ENnkA49DTm60ho7X28h9qw==
X-CSE-MsgGUID: 1ORfBKifQ9q2DKwaIrDnAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1579038"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1579038"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 18:25:53 -0700
X-CSE-ConnectionGUID: HG5HubZURiO+JaTl96rk9Q==
X-CSE-MsgGUID: gJ+XL0GYRuy/KgR8HY9xNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3890851"
Received: from orcnseosdtjek.amr.corp.intel.com ([10.166.28.128])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 18:25:53 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 23 Oct 2026 18:24:30 -0700
Subject: [PATCH iwl-net 2/2] ice: use struct timecounter for E825 and E830
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-jk-e825-e830-timecounter-v1-2-e932602f0d16@intel.com>
References: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
In-Reply-To: <20261023-jk-e825-e830-timecounter-v1-0-e932602f0d16@intel.com>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-67df5
X-Developer-Signature: v=1; a=openpgp-sha256; l=26488;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=kae7h/4+19k0Odd+cpSCs2qSEPgjkAt9xFKKt5vUvTI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqw7nNIf7h84ZpC9Z4FeRcbtew2Pl4pdzjulbPT1U8VBv
 SLFT75zO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZjIUlNGhr8L+7sflBRMuJJz
 ZIPc6QyPYz9sZ/XfUL8ikyVobLQvh5vhD0e5nMh/PlXPgvojWunKidqHwkLe8G7xNrPl507zeaX
 LAwA=
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
the servo was unable to ever recover.

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

The timecounter and cyclecounter are embdded within the recently introduced
ice_phc structure, and initialized as part of the ice_adapter. A seqlock is
used to allow lockless reading in the hot path. The ice_phc_cyc2time wraps
the timecounter_cyc2time inside a scoped_seqlock_read() to allow converting
cycles from the hardware into the timecounter domain.

In most places, the timecounter is a drop-in replacement for existing
logic, including using timecounter_init instead of ice_ptp_write_init and
timecounter_adjtime instead of ice_ptp_write_adj.

The ice_ptp_update_ached_phctime will conditionally handle whether to
update the cached_time value, or perform a timecounter_read(). To avoid
contention, this is the only place which actually performs the
timecounter_read(). This is sufficient since the clock owner periodic task
runs twice a second, so this will guarantee to read the timecounter at
least once every overflow.

All other accesses to time values use ice_phc_cyc2time when
phc->use_timecounter is enabled, ensuring that the timecounter phase offset
is handled, including external timestamp events, gettime, cross
timestamping, and periodic output signals.

Periodic output signal programming is the only tricky conversion:
The ice_ptp_cfg_perout() function programs the SDP output signals. For
timecounter, the clk time is adjusted using ice_phc_cyc2time to convert to
the timecounter domain. Then, the timecounter phase is subtracted from the
requested start time. This works because the MAC timer still maintains the
full 96 bits, so even if it overflows, we can still reliably program start
times more than 4 seconds in the future.

Although the particular hardware issue is only known to affect E825, this
timecounter conversion is applied to both E825 and E830 family. These two
products are the most recent and consistency between their behavior is
desired. Older products could benefit from the timecounter (as arbitrarily
large offsets may be programmed atomically). However, at this time it was
deemed safest to initially implement timecounter only for the new devices,
leaving legacy implementation alone. After some time is given to prove out
the implementation and ensure there are no gaps, we may opt to convert all
devices and drop the legacy code entirely.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adapter.h |  29 +++
 drivers/net/ethernet/intel/ice/ice_ptp.h     |   6 +
 drivers/net/ethernet/intel/ice/ice_adapter.c |  10 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c     | 260 ++++++++++++++++++++++-----
 4 files changed, 259 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index a56dc5306541..38600ee81168 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -8,7 +8,9 @@
 #include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/srcu.h>
+#include <linux/timecounter.h>
 #include <linux/spinlock_types.h>
+#include <linux/seqlock_types.h>
 #include <linux/refcount_types.h>
 
 #include "ice_type.h"
@@ -36,12 +38,39 @@ struct ice_port_list {
 
 /**
  * struct ice_phc - PTP Hardware Clock fields
+ *
+ * Structure used for handling the timestamp extension logic for this device.
+ * Devices will either use the legacy timestamp extension logic or
+ * a timecounter, not both.
+ *
+ * For simplicity, the timecounter fields are initialized as part of creating
+ * the ice_adapter regardless of whether the device will actually use them.
+ * The PTP clock owner is responsible for setting use_timecounter and
+ * initializing the timecounter to the correct start time.
+ *
+ * Legacy timestamp extension fields:
  * @cached_time: Cached copy of the PHC time for timestamp extension
+ *
+ * struct timecounter fields:
+ * @tc: timecounter representing the current time
+ * @cc: cyclecounter underlying the timecounter
+ * @tc_lock: seqlock_t used to protect access to the timecounter
+ *
+ * General fields:
  * @update_jiffies: Jiffies when PHC was last updated
+ * @use_timecounter: if true, the device uses the timecounter
  */
 struct ice_phc {
+	/* Legacy timestamp extension fields */
 	u64 cached_time;
+
+	/* struct timecounter fields */
+	struct timecounter tc;
+	struct cyclecounter cc;
+	seqlock_t tc_lock;
+
 	unsigned long update_jiffies;
+	u8 use_timecounter : 1;
 };
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 430441b43150..6da9762b2a4c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -330,6 +330,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts, u64 *time);
+u64 ice_ptp_read_cycles(struct cyclecounter *cc);
 
 u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 			const struct ice_pkt_ctx *pkt_ctx);
@@ -388,6 +389,11 @@ static inline int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	return -EOPNOTSUPP;
 }
 
+static inline u64 ice_ptp_read_cycles(struct cyclecounter *cc)
+{
+	return 0;
+}
+
 static inline u64
 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 		    const struct ice_pkt_ctx *pkt_ctx)
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index a702b13e4352..02ba6f4e9d46 100644
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
@@ -81,6 +82,15 @@ static struct ice_adapter *ice_adapter_new(struct pci_dev *pdev)
 
 	mutex_init(&adapter->ps_lock);
 
+	adapter->phc.cc.mask = CYCLECOUNTER_MASK(32);
+	adapter->phc.cc.mult = 1;
+	adapter->phc.cc.shift = 0;
+	adapter->phc.cc.read = ice_ptp_read_cycles;
+
+	timecounter_init(&adapter->phc.tc, &adapter->phc.cc, 0);
+
+	seqlock_init(&adapter->phc.tc_lock);
+
 	return adapter;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4b4a00beadd2..488db8298059 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -210,6 +210,38 @@ void ice_ptp_restore_timestamp_mode(struct ice_pf *pf)
 	ice_flush(hw);
 }
 
+u64 ice_ptp_read_cycles(struct cyclecounter *cc)
+{
+	struct ice_adapter *adapter;
+	struct ice_phc *phc;
+	struct ice_pf *pf;
+	struct ice_hw *hw;
+	u8 tmr_idx;
+
+	phc = container_of(cc, struct ice_phc, cc);
+	adapter = container_of(phc, struct ice_adapter, phc);
+
+	scoped_guard(rcu) {
+		pf = rcu_dereference(adapter->ctrl_pf);
+		if (!pf)
+			return 0;
+
+		/* This came from ctrl_pf so it is always the primary HW */
+		hw = &pf->hw;
+		tmr_idx = ice_get_ptp_src_clock_index(hw);
+
+		/* This does not acquire the adapter->ptp_gltsyn_time_lock.
+		 * This is safe because (a) devices which use the cyclecounter
+		 * do not directly adjust the clock and (b) we only need to
+		 * read GLTSYN_TIME_L, so no tearing is possible anyways.
+		 */
+		if (hw->mac_type == ICE_MAC_E830)
+			return rd32(hw, E830_GLTSYN_TIME_L(tmr_idx));
+
+		return rd32(hw, GLTSYN_TIME_L(tmr_idx));
+	}
+}
+
 /**
  * ice_ptp_read_src_clk_reg - Read the source clock register
  * @pf: Board private structure
@@ -272,6 +304,17 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 	return 0;
 }
 
+static u64 ice_phc_cyc2time(struct ice_phc *phc, u64 cycles)
+{
+	u64 ns;
+
+	scoped_seqlock_read(&phc->tc_lock, ss_lock_irqsave) {
+		ns = timecounter_cyc2time(&phc->tc, cycles);
+	}
+
+	return ns;
+}
+
 /**
  * ice_ptp_extend_32b_ts - Convert a 32b nanoseconds timestamp to 64b
  * @phc: PTP Hardware Clock structure
@@ -282,6 +325,11 @@ int ice_ptp_read_src_clk_reg(struct ice_pf *pf,
  * Note that the captured timestamp values may be 40 bits, but the lower
  * 8 bits are sub-nanoseconds and generally discarded.
  *
+ * For devices which use the timecounter, call ice_phc_cyc2time to convert the
+ * hardware cycles, accounting for the phase offset of the timecounter.
+ *
+ * For other devices not using the timecounter:
+ *
  * Extend the 32bit nanosecond timestamp using the following algorithm and
  * assumptions:
  *
@@ -315,6 +363,9 @@ static u64 ice_ptp_extend_32b_ts(struct ice_phc *phc, u32 in_tstamp)
 	u32 delta, phc_time_lo;
 	u64 ns, cached_time;
 
+	if (phc->use_timecounter)
+		return ice_phc_cyc2time(phc, in_tstamp);
+
 	cached_time = READ_ONCE(phc->cached_time);
 	/* Do not report a timestamp if we don't have a cached PHC time */
 	if (!cached_time)
@@ -387,7 +438,7 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 	 * has become unreachable.
 	 */
 	cached_time = READ_ONCE(pf->adapter->phc.cached_time);
-	if (!cached_time) {
+	if (!pf->adapter->phc.use_timecounter && !cached_time) {
 		pf->ptp.tx_hwtstamp_discarded++;
 		return 0;
 	}
@@ -995,19 +1046,17 @@ static int ice_ptp_init_tx(struct ice_pf *pf, struct ice_ptp_tx *tx, u8 port)
  * ice_ptp_update_cached_phctime - Update the cached PHC time value
  * @pf: Board specific private structure
  *
- * Update the PTP hardware clock time values which are cached in the PHC
- * structure.
+ * For devices that use a timecounter structure, update the timecounter.
+ * Ohterwise, update the cached PHC time used for timestamp extension.
  *
  * This function must be called periodically by the clock owner to ensure that
- * the cached value is never more than 2 seconds old.
+ * the timecounter or cached value is never more than 2 seconds old.
  */
 static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 {
 	struct ice_phc *phc = &pf->adapter->phc;
 	struct device *dev = ice_pf_to_dev(pf);
 	unsigned long update_before;
-	u64 systime;
-	int err;
 
 	update_before = phc->update_jiffies + msecs_to_jiffies(2000);
 	if (phc->cached_time && time_is_before_jiffies(update_before)) {
@@ -1018,21 +1067,33 @@ static void ice_ptp_update_cached_phctime(struct ice_pf *pf)
 		pf->ptp.late_cached_phc_updates++;
 	}
 
-	/* Read the current PHC time */
-	err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
-	if (err) {
-		/* The source clock is gone, so the cache can no longer be
-		 * refreshed. Publish zero instead of leaving the last good
-		 * value behind: neither ice_ptp_get_rx_hwts() nor
-		 * ice_ptp_extend_40b_ts() may extend against a value that no
-		 * longer tracks the PHC, and both treat a zero cache as
-		 * "no timestamp".
-		 */
-		WRITE_ONCE(phc->cached_time, 0);
+	WRITE_ONCE(phc->update_jiffies, jiffies);
+
+	if (phc->use_timecounter) {
+		unsigned long flags;
+
+		write_seqlock_irqsave(&phc->tc_lock, flags);
+		timecounter_read(&phc->tc);
+		write_sequnlock_irqrestore(&phc->tc_lock, flags);
 	} else {
-		/* Update the cached PHC time stored in the PHC structure */
+		u64 systime;
+		int err;
+
+		err = ice_ptp_read_src_clk_reg(pf, NULL, &systime);
+		if (err) {
+			/* The source clock is gone, so the cache can no
+			 * longer be refreshed. Publish zero instead of
+			 * leaving the last good value behind: neither
+			 * ice_ptp_get_rx_hwts() nor ice_ptp_extend_40b_ts()
+			 * may extend against a value that no longer tracks
+			 * the PHC, and both treat a zero cache as "no
+			 * timestamp".
+			 */
+			systime = 0;
+		}
+
+		/* Update the cached PHC time stored in the PF structure */
 		WRITE_ONCE(phc->cached_time, systime);
-		WRITE_ONCE(phc->update_jiffies, jiffies);
 	}
 }
 
@@ -1567,6 +1628,7 @@ static int ice_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
  */
 void ice_ptp_extts_event(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct ptp_clock_event event;
 	struct ice_hw *hw = &pf->hw;
 	u8 chan, tmr_idx;
@@ -1591,7 +1653,11 @@ void ice_ptp_extts_event(struct ice_pf *pf)
 
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
@@ -1793,8 +1859,9 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 			      int on)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
+	u64 clk, period, start, phase, cycles;
 	unsigned int gpio_pin, prop_delay_ns;
-	u64 clk, period, start, phase;
 	struct ice_hw *hw = &pf->hw;
 	int pin_desc_idx;
 	int err;
@@ -1840,12 +1907,21 @@ static int ice_ptp_cfg_perout(struct ice_pf *pf, struct ptp_perout_request *rq,
 	if (err)
 		return err;
 	clk += NSEC_PER_MSEC * 500;
+	if (phc->use_timecounter) {
+		cycles = clk;
+		clk = ice_phc_cyc2time(phc, cycles);
+	}
+
 	if (rq->flags & PTP_PEROUT_PHASE || start <= clk - prop_delay_ns)
 		start = div64_u64(clk + period - 1, period) * period + phase;
 
 	/* Compensate for propagation delay from the generator to the pin. */
 	start -= prop_delay_ns;
 
+	/* Compensate for timecounter phase offset, if necessary */
+	if (phc->use_timecounter)
+		start -= (clk - cycles);
+
 	return ice_ptp_write_perout(hw, rq->index, gpio_pin, start, period);
 }
 
@@ -1973,7 +2049,7 @@ static int ice_ptp_gpio_enable(struct ptp_clock_info *info,
  * @sts: Optional parameter for holding a pair of system timestamps from
  *       the system clock. Will be ignored if NULL is given.
  *
- * Read the device clock and return the correct value on ns, after converting it
+ * Read the device time from the PHC and return it as a timespec.
  * into a timespec struct.
  */
 static int
@@ -1988,6 +2064,9 @@ ice_ptp_gettimex64(struct ptp_clock_info *info, struct timespec64 *ts,
 	if (err)
 		return err;
 
+	if (pf->adapter->phc.use_timecounter)
+		time_ns = ice_phc_cyc2time(&pf->adapter->phc, time_ns);
+
 	*ts = ns_to_timespec64(time_ns);
 	return 0;
 }
@@ -2046,6 +2125,33 @@ ice_ptp_settime64(struct ptp_clock_info *info, const struct timespec64 *ts)
 	return 0;
 }
 
+/**
+ * ice_ptp_settime64_tc - Initialize the PHC timecounter to requested time
+ * @info: the driver's PTP info structure
+ * @ts: timespec64 structure that holds the new time value.
+ *
+ * Reset the PHC timecounter to the provided user input value.
+ */
+static int ice_ptp_settime64_tc(struct ptp_clock_info *info,
+				const struct timespec64 *ts)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_phc *phc = &pf->adapter->phc;
+	unsigned long flags;
+	u64 ns;
+
+	ns = timespec64_to_ns(ts);
+
+	write_seqlock_irqsave(&phc->tc_lock, flags);
+	timecounter_init(&phc->tc, &phc->cc, ns);
+	write_sequnlock_irqrestore(&phc->tc_lock, flags);
+
+	/* Reenable periodic outputs */
+	ice_ptp_enable_all_perout(pf);
+
+	return 0;
+}
+
 /**
  * ice_ptp_adjtime_nonatomic - Do a non-atomic clock adjustment
  * @info: the driver's PTP info structure
@@ -2113,6 +2219,27 @@ static int ice_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
 	return 0;
 }
 
+/**
+ * ice_ptp_adjtime_tc - Adjust the timecounter offset by the indicated delta
+ * @info: the driver's PTP info structure
+ * @delta: Offset in nanoseconds to adjust the time by
+ */
+static int ice_ptp_adjtime_tc(struct ptp_clock_info *info, s64 delta)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_phc *phc = &pf->adapter->phc;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&phc->tc_lock, flags);
+	timecounter_adjtime(&phc->tc, delta);
+	write_sequnlock_irqrestore(&phc->tc_lock, flags);
+
+	/* Reenable periodic outputs */
+	ice_ptp_enable_all_perout(pf);
+
+	return 0;
+}
+
 /**
  * struct ice_crosststamp_cfg - Device cross timestamp configuration
  * @lock_reg: The hardware semaphore lock to use
@@ -2248,6 +2375,11 @@ static int ice_capture_crosststamp(ktime_t *device,
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
@@ -2414,15 +2546,9 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 		return 0;
 
 	cached_time = READ_ONCE(pkt_ctx->phc->cached_time);
-	if (!cached_time)
+	if (!pkt_ctx->phc->use_timecounter && !cached_time)
 		return 0;
 
-	/* Use ice_ptp_extend_32b_ts directly, using the ring-specific cached
-	 * PHC value, rather than accessing the PF. This also allows us to
-	 * simply pass the upper 32bits of nanoseconds directly. Calling
-	 * ice_ptp_extend_40b_ts is unnecessary as it would just discard these
-	 * bits itself.
-	 */
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
 	ts_ns = ice_ptp_extend_32b_ts(pkt_ctx->phc, ts_high);
 
@@ -2647,15 +2773,21 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
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
@@ -3103,6 +3235,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
 	u8 src_tmr;
+	u64 ns;
 
 	if (ptp->state != ICE_PTP_READY)
 		return;
@@ -3133,8 +3266,11 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	/* Acquire PHC and system timer to restore after reset */
 	ptp->reset_time = ktime_get_real_ns();
-	if (ice_ptp_read_src_clk_reg(pf, NULL, &ptp->phc_reset_time))
-		ptp->phc_reset_time = 0;
+	if (ice_ptp_read_src_clk_reg(pf, NULL, &ns))
+		ns = 0;
+	else if (pf->adapter->phc.use_timecounter)
+		ns = ice_phc_cyc2time(&pf->adapter->phc, ns);
+	ptp->phc_reset_time = ns;
 }
 
 /**
@@ -3146,10 +3282,10 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
  */
 static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct ice_ptp *ptp = &pf->ptp;
 	struct ice_hw *hw = &pf->hw;
-	struct timespec64 ts;
-	u64 time_diff;
+	u64 time_diff, ns;
 	int err;
 
 	err = ice_ptp_init_phc(hw);
@@ -3180,13 +3316,24 @@ static int ice_ptp_rebuild_owner(struct ice_pf *pf)
 	 */
 	if (ptp->phc_reset_time) {
 		time_diff = ktime_get_real_ns() - ptp->reset_time;
-		ts = ns_to_timespec64(ptp->phc_reset_time + time_diff);
+		ns = ptp->phc_reset_time + time_diff;
 	} else {
-		ts = ktime_to_timespec64(ktime_get_real());
+		ns = ktime_get_real_ns();
+	}
+
+	if (phc->use_timecounter) {
+		unsigned long flags;
+
+		write_seqlock_irqsave(&phc->tc_lock, flags);
+		timecounter_init(&phc->tc, &phc->cc, ns);
+		write_sequnlock_irqrestore(&phc->tc_lock, flags);
+	} else {
+		struct timespec64 ts = ns_to_timespec64(ns);
+
+		err = ice_ptp_write_init(pf, &ts);
+		if (err)
+			goto err_unlock;
 	}
-	err = ice_ptp_write_init(pf, &ts);
-	if (err)
-		goto err_unlock;
 
 	/* Release the global hardware lock */
 	ice_ptp_unlock(hw);
@@ -3375,10 +3522,21 @@ int ice_ptp_clock_index(struct ice_pf *pf)
  */
 static int ice_ptp_init_owner(struct ice_pf *pf)
 {
+	struct ice_phc *phc = &pf->adapter->phc;
 	struct ice_hw *hw = &pf->hw;
-	struct timespec64 ts;
 	int err;
 
+	switch (hw->mac_type) {
+	case ICE_MAC_GENERIC_3K_E825:
+	case ICE_MAC_E830:
+		/* Use struct timecounter for E825 and E830 devices */
+		dev_dbg(ice_pf_to_dev(pf), "PTP 1588 enabling timecounter mode\n");
+		phc->use_timecounter = 1;
+		break;
+	default:
+		break;
+	}
+
 	err = ice_ptp_init_phc(hw);
 	if (err) {
 		dev_err(ice_pf_to_dev(pf), "Failed to initialize PHC, err %d\n",
@@ -3404,11 +3562,21 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
 	if (err)
 		goto err_unlock;
 
-	ts = ktime_to_timespec64(ktime_get_real());
-	/* Write the initial Time value to PHY and LAN */
-	err = ice_ptp_write_init(pf, &ts);
-	if (err)
-		goto err_unlock;
+	if (phc->use_timecounter) {
+		unsigned long flags;
+
+		write_seqlock_irqsave(&phc->tc_lock, flags);
+		timecounter_init(&phc->tc, &phc->cc, ktime_get_real_ns());
+		write_sequnlock_irqrestore(&phc->tc_lock, flags);
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

-- 
2.56.0.215.g47fdf2208c5b

