Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307D5C9832E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EBBB3811DF;
	Fri, 25 Sep 2026 23:58:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NAadT45HLSrd; Fri, 25 Sep 2026 23:58:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E43A681179
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380702;
	b=DnQrlCDKKcYD1DjyT3xdrsvapGXVMlkq0Yd3lwyAXDkS6INU8O7MjsEHBtflpbbZ+NF0
	 cWtqMbv769H0KY1KUjM1jf4ErtBOR1BzewLm4zneKPTdjSXDuhMWMt5FJPBwRYlljunS0
	 z9NHUrsETa2QXgmtBCW4GMqIFvR8eyo28d9c+3miw1ytkBfC6TmFamCPdfo4fjhXCuqFU
	 6+2bmm64jg7lMqMNzWokXcKReTMDr9s+lBh3rSJiD/Jq6yJ6gg8Wt7HJjfBwLYmFwlntY
	 zYx2BBJ0+PexVUmHkFETloTQRzdmil9DbLh4I59lgMcAz2vIrephO6C0FcbLF8PzZYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380702;
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
	bh=JfQcv80nP38c5ndqJcXMDsw8xl3umpDRtbAMusQKmMk=;
	b=AfVzvoXrTldQvwV7thBxG4Ieazq/yY1fblwcMBG1x2VwqyzWBv4fmxnSHKaAbekb46JK
	 uyyBN6WWPxs2CJS2dRekppAqFbRo8M0WoCRazE0dVkqPE5ipO1odtHO7d7wEjufg48L9x
	 rwCuD0iPg/0Y31pnaLIqIW+4ENgarJWvrkj1QiLfB5CG5jOC3XepJ1AhN9fiIEj7uMcDS
	 aKDmzVeU+hdBVd1gIelPfMVt9T1cBsxyKWykvqvC/mruAyourglLq+0eoUfyxxOYn7ifP
	 dChBM77jlYkHVj10shIOeWxm7dU8E2R0hIA0pSGPm7kdrhw3gr5ixVvw136Cg9MhAmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HiZqLLer;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380701;
	bh=JfQcv80nP38c5ndqJcXMDsw8xl3umpDRtbAMusQKmMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WaHWF5AKaKb17wBB/C/WhOW7FhHIM4OGZLIdiPM+CRECrYj06n33EUmse2jkk1hM/
	 Zl8n14s0Q1kY0SDFZujzOsa50NVbkP5usBG+e80OnA9vhH2JuQPqc43EK1gR4XxI14
	 2I6hjNeOOl8/rXey6MMSMBDubSWo0SmgO6ygFE82MMlMzx4F9jTZMdJRyNT7Y5XI3R
	 m58wuNZVVHnO3lAvPz/AvOAjNbZHxfch53z7LDrltOCfjHUBWxtKeBJKZaL8PBwTsP
	 aFHcMKvqtr0osDuSISvKMjLc5t054oPvy/UxXeCwCFsCmYBEeMV3MODUvLA5YOPq25
	 /cOke/ugraFHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E43A681179;
	Fri, 25 Sep 2026 23:58:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0DF40355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7B6181104
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xucnVGyRW-N1 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C9191811BC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380687;
 b=T5RfkIV+PJk6ymNiJti6F7eTNMZVeJwwb3zPystSMTyQM2RtqJWrUThXvlgHOJrz9b8g
 lLuPsstrGwqHRYPTazI29uBV0zAo2dRBQfj/sgS2SOOHuBmX5VmGoGKPQvJ8iWrFBV3P4
 kB7evJ4CsBSbWDPW10G52sGlVLhdP6rNhE9JfZwCVLwzUdS1tM4OMjzLsBsv/Li9NTvEq
 9NJGwfLMAmHGBJObVwwadICdlFG5oBEgeJhqxSvC0N+nLnA6wffzavsVg70TTpRPLWeWx
 mlodwvy7oAwktXqTV0cnn4iW404YqjomOfiq1PmjMBbNpNIe38RJ4ODPg5YJn30qF7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380687;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=JfQcv80nP38c5ndqJcXMDsw8xl3umpDRtbAMusQKmMk=;
 b=l27PfH7psenHTvO6cHt1hSOjJczc9lCdiEgDgbyXN0MkZg9jcNw4QH8pWpFJLQ/iOgSY
 a5uuSIEUDGssbD0FIKKx1eX8TvH6hd2GcwJDNMH8v58w7Pyvn9+p+SIli2Or/mruTeQyY
 jSYItWwy1lBu2VMWk6lkN4YJCHP3MUpxXO7rJC9oHWJXw8AYNwhF8UW7xikUVIBgBHRuw
 jyvf1VEojeKettJnAZRa/eLr+sPy8tEqLvPhZld25lxupb44F6EaEpV/FIQ8HTqmSG5Jh
 Y8+zhn+N5OZGNRFRCsgnqO/3XTV3dL2SF23engQG8+puALvPvKICe6JUeu2+HQYIp2w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=HiZqLLer; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=HiZqLLer
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9191811BC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380687; x=1821916687;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=jHsylG5pJhNAcMvrI8YAz2K/m5N2bCklIYXyz43o5cU=;
 b=HiZqLLer3tHqIOA29cOMdmhxIf3gkIw8xqLc1+znDf1hHMqlSMZMbsN0
 PiWncFEhsMbJtSDIhjjKwzhm7T51sHdAZP/CLonigK/J6QP7H2J0ucOc+
 F5mkz6JyQ6qATAOEHGeAEHOM+7v0FsmPWA1urorPTvELlk4xuVL8d+4H8
 Ee/aWmCx6bD2F/cC02HgVIBOiMa8KlR43OX3Kq2qYqVGIYVmy14AWkBjk
 /3VAzmpAOkSXubGkG6DHoTOq1H7aIGurJ+ur/7FTNGxhLbzcqTyqAKyYf
 BAmAbY+74Aym0U1bDVtOM8BJYynXv16NRE0/q5xqwspEDFOTKocgQUhXV w==;
X-CSE-ConnectionGUID: aixD1ex5QIWBa+kfv3eOBA==
X-CSE-MsgGUID: h2w8Xtz5TfSA9Lwlq2k62Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212819"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212819"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:04 -0700
X-CSE-ConnectionGUID: o/qhAiUPTfGFML8VLq5TZw==
X-CSE-MsgGUID: mnvxQyg9SH+eu9MKSQpu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731142"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:46 -0700
Subject: [PATCH iwl-net v3 14/15] ice: don't clear in_use until HW clears
 ready bitmap
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-14-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=11452;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=jHsylG5pJhNAcMvrI8YAz2K/m5N2bCklIYXyz43o5cU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXNWCDOmnLd9/LWgXm5hjdDLB6ZYm1wGutq0WjH0dk
 Uz8Bds7SlkYxLgYZMUUWRQcQlZeN54QpvXGWQ5mDisTyBAGLk4BmEioG8M/Da5MRcEsacdNaz5J
 XrOrqxc/1rl/kbLjbiv2et+VLD3HGf4K6jf0Nz4o6r768GUn01OpJXaO00qsClJn/P76VHbd1Fd
 cAA==
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

During a link down transition, there is a small window where hardware
does not properly respond to reading the PHY timestamp registers. When this
occurs, the PHY does not automatically clear the ready bitmap or the valid
bit for the timestamp. This begins happening slightly before a link
transition even before the firmware has notified the driver of the state
change.

The driver happily completes the timestamp, releasing the in_use bit. This
allows another request to reuse the bit potentially reporting an invalid
stale timestamp. Additionally, with the ready bit still set high the driver
continues to re-trigger the IRQ and check for timestamps in a tight loop,
wasting CPU cycles.

To fix this, re-read the PHY timestamp memory status after each read of a
PHY index. Double check if the hardware cleared the index properly. If it
hasn't, mark the timestamp index as stale and keep the index locked. The
index will be re-checked once another interrupt occurs (either from a real
timestamp or from the watchdog kick). Marking the packet as stale makes
sense since we know this begins happening when link is going down.

If the ice_get_phy_tx_tstamp_ready() fails, treat it the same as if the
hardware hadn't cleared the bitmap. Continuing here is safe since the
ice_get_phy_tx_tstamp_ready() device implementations do not update the
output parameter except on success. Note that "transient" errors to access
the PHY will result in marking packets as stale. This is the simplest
approach and avoids risking a potential reuse of the stuck ready bit.

The extra reads of the timestamp ready bitmap are saved in the same
tstamp_ready field. This effectively updates the ready bitmap for all
timestamps remaining in the loop. This is safe, and actually increases the
changes that a given timestamp will be processed by the loop in the event
that a timestamp completed after the initial read. Update the comments to
remove some text that might imply otherwise.

This flow has been observed on E825, but allowing the driver to free an
index which is not cleared would be incorrect regardless of which device
type it occurs on. Thus, this re-read is applied to all device types.

In the unlikely event that a timestamp has timed out the 2 second wait
*and* somehow suddenly has its ready bit set but unable to clear on read,
this could accidentally increment the timeout counter. It is intentional
that we do *not* release the index even in a timed out case, as we must not
allow reuse of that index until we can be certain it has cleared. Instead,
refactor so that the timeout counter is only incremented once the index is
released, (after the skip_tx_read label). This ensures that we don't double
count timeouts or count them prematurely. The "stuck" ready indexes remain
locked *indefinitely* until the hardware reaches a state where the clear
works.

Stale timestamps are already ignored by the ice_any_port_has_timestamps()
function. However, the ice_ptp_tx_tstamps_pending() function also checks
the ready bitmap. Instead, modify it to only check the software tracker.
Additionally, stop re-triggering the interrupt from the IRQ if the
timestamp tracker is calibrating or has the link marked as down. Continue
to check the hardware ready bitmap from the watchdog to catch cases of
unexpected timestamps.

With these changes, the timestamp processing no longer triggers a repeated
spamming of the IRQ during link down events where timestamps get stuck as
the PHY transitions to link down. Once link is restored, the PHY will be
reset and the stuck timestamps are cleared.

Measuring CPU utilization of the miscellaneous IRQ thread function during
timestamp storms near a link reset shows that this prevents the spikes
caused by the "stuck" ready bit. Without this fix, the CPU handling the IRQ
becomes slammed due to the IRQ re-triggering logic.

Measuring latency using the ice Tx timestamp traces does show that this fix
comes at a latency cost. Latency is measured using the ice Tx timestamp
traces for the request to completion time. I measured a couple of different
workloads both before and after this fix:

 * ptp4l using a profile with ~16 SYNC messages per second

    before: 189.71 microseconds mean, stdev 43.24
     after: 195.92 microseconds mean, stdev 25.28

 * a C program generating 16 timestamp requests every 10 milliseconds on
   two different ports:

    before: 457.11 microseconds mean, stdev 180.63
     after: 717.77 microseconds mean, stdev 321.58

In the normal work flows this comes with about a 10-20 microsecond penalty on
the average, and the standard deviation remains similar (with some variance
between run to run comparison).

For heavy workloads with many more timestamps than expected for typical
applications this comes at a significant cost. This is because we handle
all timestamps in a single thread. If there are many concurrent timestamps
being requested at once, any which use the later slots on ports later in
the port list will take much longer to be processed once the interrupt is
fired. Since each timestamp now requires an additional PHY register access,
this cost is much higher in the case where the device is under unusually
heavy load. The high standard deviation indicates a very high variance in
timestamp latency, with many timestamps completing in the usual time but
some taking significantly longer when multiple timestamps are outstanding
in a single IRQ.

Ultimately, *correctness* is more important than speed here. Additionally,
we still remain well below the default limit of 10 milliseconds that ptp4l
will wait before complaining about missing timestamps.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 78 ++++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 9dc0b5fa3319..8d302b500a39 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -588,9 +588,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
+		bool drop_ts = false, timeout = false;
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Prevent speculative re-ordering of start and skb */
@@ -599,18 +599,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		/* Drop packets which have waited for more than 2 seconds */
 		if (time_is_before_jiffies(tx->tstamps[idx].start + 2 * HZ)) {
 			drop_ts = true;
-
-			/* Count the number of Tx timestamps that timed out */
-			pf->ptp.tx_hwtstamp_timeouts++;
+			timeout = true;
 		}
 
-		/* Only read a timestamp from the PHY if its marked as ready
-		 * by the tstamp_ready register. This avoids unnecessary
-		 * reading of timestamps which are not yet valid. This is
-		 * important as we must read all timestamps which are valid
-		 * and only timestamps which are valid during each interrupt.
-		 * If we do not, the hardware logic for generating a new
-		 * interrupt can get stuck on some devices.
+		/* Only read a timestamp from the PHY if it is marked as ready
+		 * by the timestamp_ready register.
 		 */
 		if (tx->has_ready_bitmap &&
 		    !(tstamp_ready & BIT_ULL(phy_idx))) {
@@ -626,6 +619,20 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 		if (err && !drop_ts)
 			continue;
 
+		/* verify ready bit cleared */
+		if (tx->has_ready_bitmap) {
+			err = ice_get_phy_tx_tstamp_ready(hw, tx->block, &tstamp_ready);
+			if (err || tstamp_ready & BIT_ULL(phy_idx)) {
+				spin_lock_irqsave(&tx->lock, flags);
+				if (test_bit(idx, tx->in_use) &&
+				    !test_and_set_bit(idx, tx->stale))
+					dev_dbg(ice_pf_to_dev(pf), "PHY port %u failed to clear ready bit for idx %u\n",
+						ptp_port->port_num, phy_idx);
+				spin_unlock_irqrestore(&tx->lock, flags);
+				continue;
+			}
+		}
+
 		ice_trace(tx_tstamp_fw_done, tx->tstamps[idx].skb, idx);
 
 		/* For PHYs which don't implement a proper timestamp ready
@@ -642,6 +649,9 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			drop_ts = true;
 
 skip_ts_read:
+		if (timeout)
+			pf->ptp.tx_hwtstamp_timeouts++;
+
 		spin_lock_irqsave(&tx->lock, flags);
 		if (!tx->has_ready_bitmap && raw_tstamp)
 			tx->tstamps[idx].cached_tstamp = raw_tstamp;
@@ -2837,10 +2847,14 @@ static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 		if (!tx->init)
 			return false;
 
-		if (in_irq)
+		if (in_irq) {
+			if (!ice_ptp_is_tx_tracker_up(tx))
+				return false;
+
 			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
-		else
+		} else {
 			return !bitmap_empty(tx->in_use, tx->len);
+		}
 	}
 }
 
@@ -2872,41 +2886,18 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 
 bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
-	struct ice_hw *hw = &pf->hw;
-	int ret;
-
-	/* Check software indicator */
 	switch (pf->ptp.tx_interrupt_mode) {
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
-			return true;
-		break;
+		return ice_port_has_timestamps(&pf->ptp.port.tx, in_irq);
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf, in_irq))
-			return true;
-		break;
+		return ice_any_port_has_timestamps(pf, in_irq);
 	default:
 		WARN_ONCE(1, "Unexpected Tx timestamp interrupt mode %u\n",
 			  pf->ptp.tx_interrupt_mode);
-		break;
-	}
-
-	/* Check hardware indicator */
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(ice_pf_to_dev(pf), "Unable to read PHY Tx timestamp ready bitmap, err %d\n",
-			ret);
-		/* Stop triggering IRQs if we're unable to read PHY */
 		return false;
 	}
-
-	/* ice_check_phy_tx_tstamp_ready() returns 1 if there are timestamps
-	 * available, 0 if there are no waiting timestamps, and a negative
-	 * value if there was an error (which we checked for above).
-	 */
-	return ret > 0;
 }
 
 /**
@@ -2990,6 +2981,7 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
+	int ret;
 
 	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
 	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
@@ -2999,7 +2991,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 	    !ice_pf_src_tmr_owned(pf))
 		return;
 
-	if (ice_ptp_tx_tstamps_pending(pf, false)) {
+	ret = ice_check_phy_tx_tstamp_ready(hw);
+	if (ret < 0) {
+		dev_dbg(dev, "Unable to read PHY Tx timestamp ready bitmap, err %pe\n",
+			ERR_PTR(ret));
+		/* Don't trigger an IRQ if we are unable to access the PHY */
+		return;
+	}
+
+	if (ret > 0 || ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
2.56.0.rc0.395.gd1f3524e15dc

