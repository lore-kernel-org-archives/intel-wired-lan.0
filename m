Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138F9C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB63540B68;
	Fri, 25 Sep 2026 23:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pyhsai_wvivX; Fri, 25 Sep 2026 23:58:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DB2E840BEF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380702;
	b=nQrRjkcDj+JsGhSfDsKGI5AF1UHhF13enDpqTyS0ZLg6pOhRZ32sN8UcbS0MKrePaaCy
	 b7us4gHImiqu1kYqiOd7eV9YI3ob+g9MLxq/U5GIJ7SUWcrPQiN8cf76+qj0Z3TZu3fCN
	 FXQZuExvQJW1rkVSUzAfEAySzD/+82ibSCDon+b86rBe+CVFApU4bElRcMnw2SK5F15kp
	 PNbqOBisZUi2lbezAIp4+sZP206khUyD3yFIVDK1xqgIPidAmrJKHii76vd0QUd5qTKvV
	 Yuf6BdjLug2oe6INMKnNvPxoHF8g+qRvyPuAWWX1zyHKCDCL6GnPbl+2wgldO3EU0Uw==
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
	bh=Q27qAhnaqw+rw6OGi7FZIhA1ZQnXGuq+G3IZoCOXCK4=;
	b=EgLaSjt1szn0ru4CdUAW6rBtSULl/PfkKfIXcAIPCCjIgOkH4/84tGuJH4nywdWamXLq
	 QQ0MqJui87ytoVrwlgfRuc1jRWoQOW6+gtmrMwd8QcBLtlW8MD2dnJLTlcH55eJ3kTbPz
	 dLJ+FCkmVd1njSzU+vfzkOvNlIqVtcH624fmfLJz/PTEFdrtINAxjkYHMr4+e6pHbuRiz
	 1RaFCGJYxUAhhePxVveIHrNItz63DPyjRORRhUfA1798NzESFGxPXNSxAqb4nL+7obBzl
	 wL0CPn9k06S/t6h+POB6PAVXPoR/oTJOhT5pJ7uEOgeG83TOROtcTTG9Rk+KOROUR2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380702;
	bh=Q27qAhnaqw+rw6OGi7FZIhA1ZQnXGuq+G3IZoCOXCK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=7qVvD+lz6ZpY/POsN/ofsvBj1DQSxnu5IdIqIiR9heu3wTqdjrPlSxtdsf+qyFKPw
	 S9p12wrVC394yawh75w+65Eel2YIy8DNOQk8i6sJZLckFxjy0iDqSj2pSLX/wLZzYE
	 kE5at2ClkYMg7NJGMJvz2QrwJLKvGZEDTDQwEKN+9N8KcBrAiGaAf602ZxtGkS/OlL
	 j+XWP8Ir98jXUKMpXW1UtMJL5BA4eSl41OzgzzCTZUrfqd0nqby9lAHVmJ+X6b3scc
	 iD5MEDsF2hnK6HkNlU1h1blVoDcbqmffW8JgfeBfnIfI+nM4QpqkzcgIympr6QcOqx
	 qU1UV+2rmgH1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB2E840BEF;
	Fri, 25 Sep 2026 23:58:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DF06355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1447781103
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mxNtJoijrTAk for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1DF528110A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=kU9cEtsK5DI7bbUHTHB3wI/SJzvKPFA4aTWV4fjQGPprXNsSsq/Jrma2phDkWtXUC2YN
 0Zcvm3Qd6cmsxE0ZfrUKYp6TufSDorw7/Y+rI6CI/0pxTZPZcHRsjFmkyBdGddP3v255U
 D0rUp0syngIpkQfpbMFF30US2HvCZC0TQDasv1m1igqX6bRWdeVkTbQlUUB52taQumdVP
 c1tzyA8fuHVZPyeEv5bTn9NX3EgiDDqdG8tVRr3hprXaHKTDQYKpbPhulLANVrnYrEhai
 vHZlhE8ZHSvarquuxzvWHMwjyk3mEYURrrA1d2SbtvpEcqU7l/GsNWyK8FuafK+EISA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=Q27qAhnaqw+rw6OGi7FZIhA1ZQnXGuq+G3IZoCOXCK4=;
 b=qWwzECX+rFUfzzIMDqHweDqVv/q1gR1+lY8BSCVQE6IU1VR4PaWiptHtPqXJ1CmO3nn3
 ErI+p/fHe7jWVwXzhTdlRh8DRo4bSeH41kSgqV9vWnjKYaVIwA/1Rr4GZZrr20KjtNSE3
 q64C15LPhoIu/4BHdpAH77b20q7e1hp6b2THxy5iXRW+SzS6UDjO4g0PZh9BcTvmZbYW5
 P53ksjVcy6VuSg5Vugnm7DPyjypEnH6uIjPFke6MS6CTWeIHn1wy7gkqPOyfl5ar4TkbC
 SJrNqUja+cODzp6Vnw2vadbtxhPaDQdlTaXvOtQWJHddIosCW6lYkO6RqyZcqBXaMpA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=k1FUyG6t; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=k1FUyG6t
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1DF528110A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Ixi3xlRbFie++0QrRLxsAaMUfrphcaPjbsMN2PiFluA=;
 b=k1FUyG6tlnla5vZvGtfHIA4EIKOoRje+V0EIH4gEiMmzN7zZnnqGBhVM
 vwQdYjcdL74/9LsHOKUW7P+Zu5UQXLFFRwgw2k81AmpHkLq/ZTc8pzC1c
 eS8QIfoeCw4wD9h3m96AiuwJZiwAoOlcSkzcUE5OOJXXfgZGzpizmjyDX
 jfZA6S5cd7xzaovb/mINMX39WapSPVQB9Ym3ogwY9nLezGP1XVYd6XI5d
 AFD0opdVY5WZHWKHb+lkyddL+fsuYUBGJW1RISGOTz/9aCmwF3tck9ghC
 bhRaZ12TxGt1sD7htA5EYl+VyuRz35tdngepegsU5x1WyULztgTNWAjcQ A==;
X-CSE-ConnectionGUID: 3b4XfAsjS++mRGOYq7OXHA==
X-CSE-MsgGUID: 9nzLtqQCSF+uQVwLueuu+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212811"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212811"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: Reml+1mbS32oAGUY94lxbw==
X-CSE-MsgGUID: e2y2I5xkTuSci1mP+OnAjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731123"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:40 -0700
Subject: [PATCH iwl-net v3 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-8-6532598e8da8@intel.com>
References: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
In-Reply-To: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-0-6532598e8da8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=9725;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Ixi3xlRbFie++0QrRLxsAaMUfrphcaPjbsMN2PiFluA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXJW77mTorinsfa3cwhDAse2BMlf1XmWLnxfcrXYfC
 Zqf3yveUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwET8cxn+Jy30r/2t0RI4t/Pi
 Z4knuplHjW9Gdnbk6a/6ZWLTvcQ/gJHhq5nARVF/o7/JBQkOVe13rlb6R3omhmcuyXkdHFa+IZ4
 FAA==
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

The ice_stop_phy_timer_eth56g() function is called by the driver for E825
devices to ensure that the PHY timer has been stopped. The equivalent
function for older E822 devices performed many steps. However, on E825 it
only clears the PHY_REG_TX_OFFSET_READY and PHY_REG_RX_OFFSET_READY bits to
indicate to HW that it should no longer treat the PHY offset as valid.

When PHY_REG_TX_OFFSET_READY is cleared, the hardware still captures Tx
timestamps, but it no longer sets the valid bit for these timestamps. This
sounds reasonable at first glance. However, this results in the internal
outstanding timestamp counter becoming out of sync.

When capturing a timestamp, hardware increments its internal counter and
sets the associated "ready" bit in the timestamp memory status. Then it
compares the timestamp count to the threshold to determine if it should
trigger an interrupt to the MAC.

Upon reading the timestamp hardware is supposed to decrement the counter,
clear the valid bit, and clear the associated bit from the memory status
register. However, it only performs these steps *if* the valid bit is set.

Since the valid bit is not set while PHY_REG_TX_OFFSET_READY is clear, the
timestamp counter is not decremented and the memory status is not cleared.
This leaves the counter out-of-sync until a PHY soft reset.

According to the hardware engineers, the PHY_REG_TX_OFFSET_READY bit has no
other effects. It only controls whether hardware captures timestamps with
the valid bit set or not. Since capturing timestamps with the valid bit
clear is problematic, they recommend simply not clearing
PHY_REG_TX_OFFSET_READY.

Note that the PHY_REG_RX_OFFSET_READY performs a similar task. However,
clearing it is fine as there is no associated timestamp counter on the Rx
side. Receive timestamps are simply inserted into the descriptor. Clearing
this register clears the valid bit for timestamps until we complete
calibration and re-enable the register.

Notice that the soft_reset parameter of ice_stop_phy_timer_eth56g() is
totally unused. It is a relic from a copy-paste of
ice_stop_phy_timer_e82x() that is unnecessary, so remove it.

Now that we do not clear the PHY_REG_TX_OFFSET_READY, new timestamp
requests could happen while the PHY is calibrating. To avoid this, set the
tx.calibrating field of the Tx timestamp tracker when stopping the timer
and clear it when finishing the restart. This ensures that any new requests
will be rejected until the PHY timer calibration has completed. Also call
ice_ptp_mark_tx_tracker_stale() to prevent reporting any previous
outstanding timestamps to the stack.

Unlike E822 devices, set the calibrating flag when "stopping" the PHY and
clear it immediately after the start procedure. The E825 device does not
perform vernier calibration and thus does not need to wait for hardware to
mark the offsets as valid.

In the event that the PHY timer start procedure fails, the device is in an
unknown state and timestamps will not behave properly. As such, and similar
to E822 devices, the calibrating field is not cleared on failure. This
leaves timestamp requests disabled until the next link restart.

Failure in the start flow is unexpected and it is unclear precisely what
state the hardware is left in. Attempting to add a complex retry mechanism
for a rare event is not worthwhile. The port restart procedure can already
be re-initiated by triggering a link reset (i.e. via ethtool).

Instead update the dev_err message at the end of ice_ptp_port_phy_restart.
Clearly indicate that timestamping is disabled, and add a note that a link
toggle might recover the device. For the invalid MAC type path returning
-ENODEV, skip this message and log a dev_dbg that we failed with an unknown
MAC type instead.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 36 +++++++++++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 25 ++++++++++----------
 3 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 16b1988e993d..17000df77ce9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -378,7 +378,7 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 
 /* ETH56G family functions */
 int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status);
-int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
+int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 7cc151b01a13..818e2e265a7e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1221,6 +1221,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_pf *pf = ptp_port_to_pf(ptp_port);
 	u8 port = ptp_port->port_num;
 	struct ice_hw *hw = &pf->hw;
+	unsigned long flags;
 	int err;
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
@@ -1236,7 +1237,14 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		err = ice_stop_phy_timer_eth56g(hw, port, true);
+		/* Disable new Tx timestamp requests */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
+		err = ice_stop_phy_timer_eth56g(hw, port);
 		break;
 	default:
 		err = -ENODEV;
@@ -1302,15 +1310,35 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
 					   0);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
+		/* ice_ptp_port_phy_stop() may have already disabled
+		 * timestamps, but some restarts occur without first stopping
+		 * the timer, so we ensure that new requests are disabled
+		 * here.
+		 */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 		err = ice_start_phy_timer_eth56g(hw, port);
+		if (err)
+			break;
+
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = false;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
 		break;
 	default:
-		err = -ENODEV;
+		dev_dbg(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u with unknown MAC type %d\n",
+			port, hw->mac_type);
+		return -ENODEV;
 	}
 
 	if (err)
-		dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d up, err %d\n",
-			port, err);
+		dev_err(ice_pf_to_dev(pf), "PTP failed to restart PHY port %u on link-up with err %pe; Timestamping remains disabled; A link-toggle may recover.\n",
+			port, ERR_PTR(err));
 
 	return err;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..07b55fbb88dd 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2098,32 +2098,33 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 }
 
 /**
- * ice_stop_phy_timer_eth56g - Stop the PHY clock timer
+ * ice_stop_phy_timer_eth56g - Clear PHY Rx offset ready flag
  * @hw: pointer to the HW struct
  * @port: the PHY port to stop
- * @soft_reset: if true, hold the SOFT_RESET bit of PHY_REG_PS
  *
- * Stop the clock of a PHY port. This must be done as part of the flow to
- * re-calibrate Tx and Rx timestamping offsets whenever the clock time is
- * initialized or when link speed changes.
+ * Disable Rx timestamping by clearing the PHY_REG_RX_OFFSET_READY. This
+ * causes Rx timestamps to be captured with their valid bit clear, ensuring we
+ * discard any timestamp captured while the PHY is being recalibrated.
+ *
+ * Note this does *not* clear PHY_REG_TX_OFFSET_READY. Clearing it would
+ * cause the Tx timestamps to be captured with their valid bit clear.
+ * Unfortunately the captured timestamps still increment the internal counter
+ * and result in off-by-one accounting. Instead, Tx timestamp requests should
+ * be disabled by other means.
  *
  * Return:
  * * %0     - success
  * * %other - failed to write to PHY
  */
-int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset)
+int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 {
 	int err;
 
-	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_OFFSET_READY, 0);
-	if (err)
-		return err;
-
 	err = ice_write_ptp_reg_eth56g(hw, port, PHY_REG_RX_OFFSET_READY, 0);
 	if (err)
 		return err;
 
-	ice_debug(hw, ICE_DBG_PTP, "Disabled clock on PHY port %u\n", port);
+	ice_debug(hw, ICE_DBG_PTP, "Disabled Rx timestamps on PHY port %u\n", port);
 
 	return 0;
 }
@@ -2151,7 +2152,7 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
-	err = ice_stop_phy_timer_eth56g(hw, port, false);
+	err = ice_stop_phy_timer_eth56g(hw, port);
 	if (err)
 		return err;
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

