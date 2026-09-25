Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C17EC9832E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 255EB81178;
	Fri, 25 Sep 2026 23:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bco2BJEw-WHf; Fri, 25 Sep 2026 23:58:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 25A9A811BC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380699;
	b=sc0qoKWwOmq1lT3VOWwEh6gv7hbwPphUP+eQ9eG3LtRhia+wUQL2RCfF7KSXig+9oqGx
	 LqKIs/KsgZswD+cUNeatUfEQCQfKu1iViVrTxZf0vU8uUTAsdxBOvPPXYAXfsfLIkdG4l
	 JsCEJVOGQ711aDRjyNaARF2JNzX980Jusdy43EqNbq58l3QlOefIG8Q7Q7p545nQn0qyK
	 StfevK0G4C8HSQL5i11jiqBniXz1Raa8Ruo4+dJmQaLeuNyAUeivvzDhf9hAcfqBDQ8vq
	 OWIJ5i/k44l9LC0A3Vp3h2GidzW1vP2RFYLEDxS0kq4RwWNMDCPHQVu/qgdHj/+L+eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380699;
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
	bh=H/1qfeO3RWkIKy4HElNZkAEAoRtVmrEFT1NHAjACzcE=;
	b=ORijEcErQSeOoL0XPUbBbZKeONLeVrQ1MqaA5z2UeY0wG3m/c28RVtvq2V6zN/ffsAj7
	 6GoOuxETW+hAxeHU/VBHE4eKufn1rfN58GchPl3okO4quj+EAfJUaRVGxqy3QrSZFiUrO
	 JhLtKZwkb2nHXhMKHpieS+SFh+tdRuO0E54ZvOTLvRZCpfO/9YxFXLOFLAnevumr4qyaN
	 CGQoeKMkDi9CpqQmR8WfnqPoKNS5X8LUruwzkBjA6a2IdwijBSd+TbgGki4WaZvaKl4Xl
	 qERKAJtFci+iNhtsY1n4RN8W3ktxbf+kG9+RqAk+VHiMxDbR083utx7cVuY+ZjHf2nA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380699;
	bh=H/1qfeO3RWkIKy4HElNZkAEAoRtVmrEFT1NHAjACzcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D8hjy2WuuBS3886aGCbTqT/nPP33i1DxGsU5sPdrstb0lKELjTdyWQ62PZ9Lu4Jcl
	 MJstrweLEd0SrKvGC9aDlmLItEKA7hnUVIQ+c6WaJO84YfedASaACG0ObDXvUlV14M
	 TOcN7WnMYsYcKr+L4KS+em1ebj8ybPgYfL7/hQrrjY3NMG/qCFVv/GaPL2Eq/87y1n
	 YN+LeaNi7VpdMXjlEQfu1AS3Node5vMZGTKl2J1bgq7Cb4Iczz/G4814c+VKWzo6yq
	 ObIO41qLc1e6w2VujXW47+e5SOGa9JTWt8bIuhlrhdYs2v1uGKm/jyKVdXZRWA3M0N
	 I0gyiJ4q+HqCw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25A9A811BC;
	Fri, 25 Sep 2026 23:58:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7453355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98CD640B46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yrLNG_dcIvxy for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6EC1240B68
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=YyvZHZ6TByMvwejTYwVyo7tC5mZftm/dtXnMo2ErowMcbGi+UbVg52fIU1fGwfqO3Xyb
 Z/vSjgKUnjkxTSTFBeFSuC9fPFC/4/ZOKBkLx85d/7WN/JunoepbCUNBZQ/HfWs5t8uCh
 O9Mu0I+b8H4dUKp7EAh6oDaLqvjRNyKtbsYOh/HYJXLLnMUZrFoKr0/5Dy/fD6wbb2UrU
 oRDlrXj4ake0TM8KJrg63qn/mYX6BaIkiNfURpJWZVEY4DqDytaEK+C1gLZK6BKgA+SkM
 6We0rOSORbJMqQ8/q01h558pUseyelOBwj0GtjUIlFab2BbTMYsg/kCpqcLemQyinDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=H/1qfeO3RWkIKy4HElNZkAEAoRtVmrEFT1NHAjACzcE=;
 b=IQHM2ydse2EYgsJhR/Ynygd24UDO5XLGKe7Spv17znkObk7XJuc9MjFjqp8FBYWn2GyO
 csCbJu7dwpi66NqmwO9cw0tcAccStFYpyM90fyytilMv17WFC7csYKmh0Q/XFEdZ5VM6u
 1d/6KL/jFZyIySk9suPZ2OPB0yDG/M0PacmE2q4Dl2y9VPVmSMCyl+5reqzk+bgqYBxOd
 bfEvC9dwshInZNkJslmvYh1Lm97p39l6trd7YRDrmNPR2H8aNIeibcw6Lg3KybA1miGuP
 tr+GGBj8OF0gxbGomWiTq/GAyKzk0wh11bvbVUBxD4XrJr1IwqCw8Ebwcrihzlo78Fg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EbpDUPPG; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EbpDUPPG
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EC1240B68
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380687; x=1821916687;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=AbxgOS5Ez50r0AWmbP+tWjRjZIZQhNECDIRs3kJmkX8=;
 b=EbpDUPPGtvyjPV2DoHsZE+Y2ms3d7bWpGjtvkAOfQ7iMc7hcnbrIlzfs
 dGNt+5+bOh+CKjAQL57vG3/MCsCMog+Vk+6199Efw6G9B22LsVLRvy0S3
 CjcFfdVS+yJ+kvKfdDvh3iw1kwtAF5+J2zDNGx1QfYNLIbT1hCXbRHafi
 aOZfOIeCXE9szUHIO3yiJ4/qU7JW5PXfPrcLYLuK60yA2+OHVAAZujXHt
 m/onqRrohbTCoCiIrZsoUJ85ddQyaCY0hOQqGUOw69FhoG0E4JzemGWew
 hLP39bk025Uf3ONEIz1eCaLKnOpTvFdehmB9SeDWmwP9qOY5mtvAYGlhW g==;
X-CSE-ConnectionGUID: SWqG6iCCQGeoJP56Libi4g==
X-CSE-MsgGUID: nILDpIvnSLG3cW7T0arfwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212817"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212817"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:04 -0700
X-CSE-ConnectionGUID: 33sRJqwIT6auNJFWJPt5mQ==
X-CSE-MsgGUID: gehbcZoHTWq3jFJUEmB/qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731135"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:44 -0700
Subject: [PATCH iwl-net v3 12/15] ice: keep Tx timestamp slots tracked
 until completion or timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-12-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=11431;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=54TAA5X/nPOJ/05hLnVrYmL5NMzq67ugdO53NVQSL1E=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXNWpEy8fX2W+tHC1UsSezSJr99xUDGxmURTZ8bLDb
 FrhGRetjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYiU8fIcDA5aO5KFcOZu6Ml
 980KEJHXNTx9jlXzVbLx4V0KEkKfMxj+xzzTtNI+Yd8qILTnRYVVoM7Ez7f8FicazC1R0ohsOa3
 KCwA=
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

From: Petr Oros <poros@redhat.com>

When the link goes down the processing loop drops every outstanding
request, and a request whose timestamp is not ready yet is freed
without reading the PHY slot. The hardware completes the capture a
moment later, the orphaned ready bit blocks the port interrupt until
the next link-up sweep, and the freed index can meanwhile be reused
by a new request whose slot the hardware then overwrites. Captured on
a reproducer as ready bits with no in_use owner right after a link
bounce.

Stop dropping on link down. Mark the outstanding requests stale so
their completions are read and discarded, reject new requests while
the link is down, and free a not yet ready slot only after the two
second timeout. This way an index is never reused while the hardware
can still write it and never left untracked while a completion can
still arrive.

Since we're adding a new call to ice_ptp_mark_tx_tracker, notice that the
function previously did not check the tracker initialization state. Fix
this by only accessing the bitmaps if the init field is set.

To avoid continuously re-triggering the IRQ at the end of a processing loop
when we have a stale packet that is not timestamped, modify
ice_ptp_tx_tstamps_pending() to ignore stale timestamps when checking for
whether to re-arm the IRQ from the miscellaneous thread function. Instead,
only count stale packets as part of the check in the auxiliary work thread.
This way we do not keep spamming the IRQ when the timestamp won't be
reported anyways.

To ensure that forward progress is made on clearing stale timestamps, fix
the check for ice_ptp_maybe_trigger_tx_interrupt to properly apply for
devices that manage their own interrupt, instead of only checking on the
clock owner. In the case of a timestamp which never completes, this does
result in one extra IRQ every 500 msec until the timeout. In some sense
this is extra work, but we need to recheck to ensure that timestamp slots
do not remain locked forever, and the software can't reliably know whether
a given index will or won't complete.

Note that E810 does not have the ready bitmap in its hardware. It is
currently excluded from the ice_ptp_maybe_trigger_tx_interrupt() by a check
against the has_ready_bitmap field. This could lead to an interrupt stall
if every single Tx timestamp index slot becomes stale. However, just
removing the check against has_ready_bitmap would be problematic for the
low latency path which currently is not protected against another IRQ
happening while a request is outstanding. That is a pre-existing issue, but
we should avoid making it worse until the path can be addressed by another
fix. The low latency path also completely bypasses the
ice_ptp_process_tx_tstamp() flow. For now, skip the
ice_ptp_maybe_trigger_tx_interrupt() when ts_ll_int_read is set and the low
latency path is in use. The path still has preexisting issues but this
avoids making it worse.

This effectively reverts commit fcc2cef37fed ("ice/ptp: fix the PTP worker
retrying indefinitely if the link went down"), which tried to release an
index before this 2 second wait period.

Fixes: fcc2cef37fed ("ice/ptp: fix the PTP worker retrying indefinitely if the link went down")
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  8 +++--
 drivers/net/ethernet/intel/ice/ice_main.c |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 57 ++++++++++++++++---------------
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 029ee4612d76..7810fefc546e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -132,6 +132,9 @@ struct ice_ptp_tx {
 #define INDEX_PER_PORT_E82X		16
 #define INDEX_PER_PORT			64
 
+/* Maximum number of timestamp indexes across all devices */
+#define INDEX_PER_PORT_MAX              INDEX_PER_PORT
+
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
  *
@@ -314,7 +317,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf);
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts);
 
@@ -362,7 +365,8 @@ static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	return IRQ_HANDLED;
 }
 
-static inline bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+static inline bool
+ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f32041dd8b27..d12952171a99 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3248,7 +3248,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	ice_flush(hw);
 
-	if (ice_ptp_tx_tstamps_pending(pf)) {
+	if (ice_ptp_tx_tstamps_pending(pf, true)) {
 		/* If any new Tx timestamps happened while in interrupt,
 		 * re-arm the interrupt to trigger it again.
 		 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 5220de274819..a5ee8c8edf3d 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -365,9 +365,12 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 static bool
 ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
 {
+	struct ice_ptp_port *ptp_port =
+		container_of(tx, struct ice_ptp_port, tx);
+
 	lockdep_assert_held(&tx->lock);
 
-	return tx->init && !tx->calibrating;
+	return tx->init && !tx->calibrating && READ_ONCE(ptp_port->link_up);
 }
 
 /**
@@ -554,7 +557,9 @@ void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx)
  * extremely unlikely that a packet will ever take this long to timestamp. If
  * we detect a Tx timestamp request that has waited for this long we assume
  * the packet will never be sent by hardware and discard it without reading
- * the timestamp register.
+ * the timestamp register. Note that in the unusual case where the PHY
+ * continuously fails to clear the ready bitmap index, the slot may remained
+ * locked for more than two seconds.
  */
 static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 {
@@ -564,7 +569,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
-	bool link_up;
 	int err;
 	u8 idx;
 
@@ -582,14 +586,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			return;
 	}
 
-	/* Drop packets if the link went down */
-	link_up = READ_ONCE(ptp_port->link_up);
-
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = !link_up;
+		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Prevent speculative re-ordering of start and skb */
@@ -875,7 +876,8 @@ ice_ptp_mark_tx_tracker_stale(struct ice_ptp_tx *tx)
 	unsigned long flags;
 
 	spin_lock_irqsave(&tx->lock, flags);
-	bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
+	if (tx->init)
+		bitmap_or(tx->stale, tx->stale, tx->in_use, tx->len);
 	spin_unlock_irqrestore(&tx->lock, flags);
 }
 
@@ -1426,6 +1428,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	WRITE_ONCE(ptp_port->link_up, linkup);
 
+	if (!linkup)
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 	/* Skip HW writes if reset is in progress */
 	if (pf->hw.reset_ongoing)
 		goto out_unlock;
@@ -2824,21 +2829,22 @@ void ice_ptp_process_ts(struct ice_pf *pf)
 	}
 }
 
-static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
+static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 {
-	bool more_timestamps;
+	DECLARE_BITMAP(tstamps, INDEX_PER_PORT_MAX) = {};
 
 	scoped_guard(spinlock_irqsave, &tx->lock) {
 		if (!tx->init)
 			return false;
 
-		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
+		if (in_irq)
+			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
+		else
+			return !bitmap_empty(tx->in_use, tx->len);
 	}
-
-	return more_timestamps;
 }
 
-static bool ice_any_port_has_timestamps(struct ice_pf *pf)
+static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_port_list *ports = &pf->adapter->ports;
 	bool have_tstamps = false;
@@ -2851,7 +2857,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (ice_port_has_timestamps(&port->tx))
+		if (ice_port_has_timestamps(&port->tx, in_irq))
 			have_tstamps = true;
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -2864,7 +2870,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 	return have_tstamps;
 }
 
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_hw *hw = &pf->hw;
 	int ret;
@@ -2874,11 +2880,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx))
+		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
 			return true;
 		break;
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf))
+		if (ice_any_port_has_timestamps(pf, in_irq))
 			return true;
 		break;
 	default:
@@ -2954,7 +2960,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		/* E830 can read timestamps in the top half using rd32() */
 		ice_ptp_process_ts(pf);
 
-		if (ice_ptp_tx_tstamps_pending(pf)) {
+		if (ice_ptp_tx_tstamps_pending(pf, true)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -2984,19 +2990,16 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	int ret;
 
-	if (!pf->ptp.port.tx.has_ready_bitmap)
+	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
+	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
 		return;
 
-	if (!ice_pf_src_tmr_owned(pf))
+	if (pf->ptp.tx_interrupt_mode != ICE_PTP_TX_INTERRUPT_SELF &&
+	    !ice_pf_src_tmr_owned(pf))
 		return;
 
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
-			ret);
-	} else if (ret) {
+	if (ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);

-- 
2.56.0.rc0.395.gd1f3524e15dc

