Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 839A7C982FA
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A758607B7;
	Tue, 22 Sep 2026 18:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tng977IIoSzK; Tue, 22 Sep 2026 18:08:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 70109606D0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100522;
	b=rmLge8iUyMwe2/M5yez7HHLzSX1ibKFx23lKtrSAymnV6yLM0Xrb5o9MDZoUGeZpIAcM
	 Y71ljznmwp1p7zxNw+cUWKtADlMPZgEmOOLK4etBU9g6UHN1cL8zF1zbrRcaIdg7wgBin
	 vxikg/e6m8Xk/jgGHKIoHzf7A3AhVEVjQyDszQStXZIYGwJNbIEMe9cXyO5tWBAYG/l/y
	 r7s8uKRl53ZtUCqmAvC/yYZY34Kv/F1FpjnzemlLuWjqHZK75bi9aRcr64W/aGWxnb4zV
	 pm1TPw94B10puJqRlRpRIjIsVNliWOtfPgythM4w7eFtq484V6pCxR2ccqyOQV7oPIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100522;
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
	bh=i0Iv9HCqZ8ztEAmP/WbvP/HaDGM3SHbxAAE1o/mSYf8=;
	b=LIYcbogksDJtdjCg9ezKxsAKR6WqeAT9jUUWoha1GGUY7lOdY59yN5ui2ZMzSgkQ6+aJ
	 9p4xeJpsqXLFSNeNp/89uACN9oWg8wPFeb3KoSyZQjayUXtzjGjCTodJ52ndaDekxPcmY
	 IYaddajwtHjAx1nO1fViChYKrPsGe2xV6Fn3AcA8wDxvDS7rMiOnSPFMxMOpg0Ztq8Rzl
	 9kiLyTJWeBngO9KVmmqKO+21bUVHz+jxRj9D+71czswISAH+rh52XJ+/Na689Mhd9GAXL
	 0RQuVg78kR4W5DN28Au9PyeVLnullERWtJC25+pZ2ijG49Pjv2XMepDz5Vw698T051w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="e696Mm/c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100522;
	bh=i0Iv9HCqZ8ztEAmP/WbvP/HaDGM3SHbxAAE1o/mSYf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BDOyS2DOlpQIgbxBmN+UuQolvbeV7p8BiBVl/f513SgaXm/H5rbmTwH1Kul2+tUJw
	 038mFZv6raK5FOD/Eq7091PuJuc+Y/0u4AUElProw4nzemXSm6OrOrCedOtqE7yB8z
	 4wdFzYRWWHu2GyfCLLgFMinmmYxxjmG1jyHuTWq75XbTXsaOIKo5u+zpum0+tic8r2
	 y93OBFNfmBA7P/dB0/3ze8RlrDXK+QYYDX9wwFmIBaLcub1gO8BAbuIUSuBTnFJU9o
	 GLRMM8ccS2MJZeEzlzmAa1Cm1t6um/M2FrA0lqOlDnFRnQz3VYAADJQxC4ZwD+i0iY
	 bmmkLjKSPxPKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70109606D0;
	Tue, 22 Sep 2026 18:08:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29ABD12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B59C6069C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fvh9jNSl3ktQ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 12F836067F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100508;
 b=cmm/vVya0Lqh7R1efgsZePeFMvbgnTaYMJ8uhg/gTbLkWrjN3r8C9iejDRPoxd0Jn3dG
 rGEUPuPoCZbdkZcKyctTu9mubdNf5Oz/cpZ+48UwG8R52G2W+ybLSwJeKFpvov+plwpbR
 p29TIJT4wfAjZUMXnNlC6j/EKNC83SIqwmLNgTemxvRpzItLmABm6YxPGyu0d4DBFCsci
 rIhGD8ppX02ZEtOrTApWNJiCbpPfQ1O7NbXwWXfbfRLfut+PGan+bv9g29nukeH8lXu5u
 AZnD6IAxp7fFVliwnZldoNp2etc2mds9FH1prA3mdnjp+cOU3ebm6bs4wsWijfFvepQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100508;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=i0Iv9HCqZ8ztEAmP/WbvP/HaDGM3SHbxAAE1o/mSYf8=;
 b=X1M0LV2D+Pbol/3x8pS7Vjrd/PTiWCMK0wl52wlyX1hPlDx3o9jcRofx23k9YDKznm1/
 3AfKn1WUT6pnAwXilP9ndVvEc3NIvQZxzZz+LUUtD3cpTYkleqVEoCsInFWYS9Ruqjf8L
 FrAYt2gESat3SSsym0yUPx3QaPaPIrgMtt9Pxqc8UpwtsVi4Jzl6jArgDk0HGxpftf7/B
 9Hx60bhhmjz3bSq9hQC8HERnZQnCvgPmtdfGaaHmFouZn44Iw3F+RHDdl/uiUBkJUltCG
 yW/TDQjlxf+XpOy/0jgDNcOH4TjipQzvM6vQC5vzQ8xaDD7g9dL/kXpuyisrXxlRuzQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="e696Mm/c"; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e696Mm/c
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12F836067F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100508; x=1821636508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=o6q8akGBg1N3Y/iOLxvXvs3dNA4GaThrYun7KxJYPhs=;
 b=e696Mm/ccsWYkJtUyr1FlNTldeUwU11dap/7nA6crPqFH+Zi1y2KEen7
 zctxUbo/azwjn4W0aiEaL1ps0IM9h2mpfAP9MH/uu9B0B0lRPHAw3CHDH
 pUeLMC5/oEyKWwTVqfXu+tilurYZXePgCt1L4r/jgmraACzWgCVC4w8iS
 JOdLPHyu9yRJQNmjbyAXO1zb37mfqGx6pLPFbBJ64b3Xu7212TU2wMIJ4
 pO0z6jts0/qKucr7XLGt3JPvn3rL1StQUWjl6dR0NUF26VixXGkl9anAm
 Rty41yOpR4SG569l+TSW+3q5y0iRY1eXGrmzIlQTiMUSPTjdD3vxEo24U A==;
X-CSE-ConnectionGUID: 9OJNCpz1S8i2wj04IQ1LGg==
X-CSE-MsgGUID: tg+4VB+rSv61tBCKYKkeSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232056"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232056"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: xAxmdzKSTUWhKoi9Jyy2zw==
X-CSE-MsgGUID: JVbhBlNOTK+ScH+UTqR5EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315341"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:45 -0700
Subject: [PATCH iwl-net v2 12/15] ice: keep Tx timestamp slots tracked
 until completion or timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-12-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, 
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=9215;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=bScmJ2APos81Wpd63uPUzOiy9ePSLtU37ePBl7tRMiQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh2Us8jUKXt8+9rXvX33+1a6rHakbmWUCZ9xRO6VY8
 c7iQ+W1jlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACbib8Pwv+pdJ0dVyU4j59lZ
 Whse/Dn7ZvZ+3e4JP7oSkwJCrhlMt2D4Z7LlfmRhhGPQt4usBW1ttSdmXlHx3Lj42Xw/Z5Xr9ce
 e8QEA
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

To avoid an IRQ storm in the event that we really do have a stale packet
that is not timestamped, modify ice_ptp_tx_tstamps_pending() to ignore
stale timestamps when checking for whether to re-arm the IRQ from the
miscellaneous thread function. Instead, only check for stale packets in the
auxiliary work thread. This way we do not check in a tight loop waiting for
a timestamp that may never come.

To ensure that forward progress is made on clearing stale timestamps, fix
the check for ice_ptp_maybe_trigger_tx_interrupt to properly apply for
devices that manage their own interrupt, instead of only checking on the
clock owner.

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
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 51 ++++++++++++++++---------------
 3 files changed, 34 insertions(+), 27 deletions(-)

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
index 142d9e1c1f2e..06f383415d07 100644
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
@@ -564,7 +567,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
-	bool link_up;
 	int err;
 	u8 idx;
 
@@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
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
@@ -1399,6 +1398,10 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	if (pf->hw.reset_ongoing) {
 		mutex_lock(&pf->adapter->ps_lock);
 		WRITE_ONCE(ptp_port->link_up, linkup);
+
+		if (!linkup)
+			ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 		mutex_unlock(&pf->adapter->ps_lock);
 		return;
 	}
@@ -1448,6 +1451,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 	 */
 	WRITE_ONCE(ptp_port->link_up, linkup);
 
+	if (!linkup)
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 	switch (hw->mac_type) {
 	case ICE_MAC_E810:
 	case ICE_MAC_E830:
@@ -2804,21 +2810,22 @@ void ice_ptp_process_ts(struct ice_pf *pf)
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
@@ -2832,7 +2839,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (ice_port_has_timestamps(&port->tx))
+		if (ice_port_has_timestamps(&port->tx, in_irq))
 			have_tstamps = true;
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -2846,7 +2853,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 	return have_tstamps;
 }
 
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_hw *hw = &pf->hw;
 	int ret;
@@ -2856,11 +2863,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
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
@@ -2936,7 +2943,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		/* E830 can read timestamps in the top half using rd32() */
 		ice_ptp_process_ts(pf);
 
-		if (ice_ptp_tx_tstamps_pending(pf)) {
+		if (ice_ptp_tx_tstamps_pending(pf, true)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -2966,19 +2973,15 @@ static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	int ret;
 
 	if (!pf->ptp.port.tx.has_ready_bitmap)
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

