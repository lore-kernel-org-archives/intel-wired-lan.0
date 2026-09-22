Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E85C98308
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8EC5A80EC7;
	Tue, 22 Sep 2026 18:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VaDzr8WoRtpV; Tue, 22 Sep 2026 18:08:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AE40680EC1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100517;
	b=cEralrNj97gapiWsoYlTv6ekJ48QyAxjV8Vtn9zTqkr88ILWH3fpI8QdGTsWMXAs/LTr
	 hRVSDP2sKnTALsw0EZRPIjAMvM0xYmO5JKkbidLYSy2x3IYrEkrSz8edBc/zkxttyyqbt
	 v/QTNbh0x2AbZCwIYSHsMkQ2gmeqOW7gJpP4D1y11k9xAnXjxjreOF5ZvBuX6zMcpb1CL
	 YDoOciV1rbF9sco7dT/AxsXJtdIKDyhbfnZvkwFK7PCmthzGJcllFThXK6Ge+DoEMLmb7
	 8K4+jBcSERe1SgA4lUeuCmm+/R/hQJcSfWaGd7tE9jZiSsSvpIRCVuYRr0tP+6+iOkw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100517;
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
	bh=BCD4gtQyxXiLmzy0Y5znxeJlzjoaPt7PyTjMoxT6x34=;
	b=DbAeHoIq/2YDT3XriIj3v6ANdD5o9NcWuaFFZ+JEMdnzU53A523QiqxKiU1aknOw7rOG
	 CQ8VOFJOvbckki17sDVLhDah0o+pHMRE3POut+R4zdEA49pVHyQ0Eu3DRXMDa5h9hwXw0
	 uvOay/Zh86wbRg8PEEgHU44h7Xw9gwk+ZhDvM0rFuXC3Ijk0T120kR1AERfpdr/lFxfiA
	 GsPOSZwE/htGxOA+4MQAChCli99A0qzMkXAq5+UjJCWHBof6lgOBms4B+YwAsiqVOStCd
	 ywoZmU0fN8jToaNJhfolVuGeM02SDK4SocB3qO2HeMmemr+1t/k9X/2fWJsIzApLhIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100517;
	bh=BCD4gtQyxXiLmzy0Y5znxeJlzjoaPt7PyTjMoxT6x34=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QiTlZKq9foTUH66SaWESdLKobHqa1d3qj2sPzU5hFcomMbGIHN05vNngaLDHW6Oa4
	 K++u40tA+KBNX0U60ddIyxFTtZ5stxsAHDW2tV/ra+QaBtQineoIkmkEv1C4Aa641s
	 a3dqwtsr/jWwziCjtUksFfFSNQQgkaH6+Llcywa3tnPPmHYsL2twaEqL0KUWviCijv
	 xRbXAxCeYfKhMX8gbhZw5GhryGpmixMZ0eGQwrPYocGkBb8yd4hPSsWEFVATx7qvCX
	 sLI9aoSJkowSoI2dOCchIYVnjTT/BnRTHMkk5Tb2tvltHgxjr1QMmAurtK3J/zZ2Ni
	 M+O9H3NCdKpMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE40680EC1;
	Tue, 22 Sep 2026 18:08:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 827303A9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67CFD40076
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grXwJnI_1eKU for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 78CF94007D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100507;
 b=YrdXO4DmM+cFXd3ukcRTQERjt1pHFZO4r17DaULuq8zJ/fyqyr5ZPskMLJaDq99OsFMP
 2ywVmUgyabqjcw5ZCzMZl0p0+M0Lxlt6Y8EE4s0eRB4Qg0ofw0fAdER6olddcejACr1ga
 QIgYOlROjG2lvT46k2xhn8Te9YvHpuCkGtLZgIGslgbohP3byqdG1ZBjogtTmxGJNrIiU
 zWd70dIlKKxOS3fK3q64Rw44zE6VOQkO11Lmx7v1ZjXA4ZaqWhiOs3QYZt18ATA5DvNuH
 valC+3vXq+n912jTcKfXtfUdu2D1/Tz08npSwlPlyfJLmKaZGK2vWhTNcBZQQcT7WbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100507;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=BCD4gtQyxXiLmzy0Y5znxeJlzjoaPt7PyTjMoxT6x34=;
 b=Qauq5dAj0ER8KAHvykSv1IhSy4IELC7d18ROvOSdImlNxIfdnJbGcI88xUvVZc6Lasqq
 50pTERdMhWe4fCWFMyR1h77rVMyOVlUA6Z4lH6zTotKl9Gjqi1nUtXMU1Stn0Gd4HcSEQ
 nx0g7D1IpRqjpKtpi25byb9D21vmvrWlvL+mXMEJLMphe7SqlT4x50I88B2njvE5Pjvwa
 5Qg9XjmSdyfDygL/zVdl1UMWni3xX1iAaRlbMZAE6/TjH1zdHVJjqTYEc7BnN095E1V94
 rGI8B2WrRSPiRvOc4IRwv65zNI6VgA5HlTtp+J8KX1C6pXi72F2cpoO0U9wnR1khmSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=fe8xdBnS; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=fe8xdBnS
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78CF94007D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100507; x=1821636507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=Ckp24sqJcKgxFa8rbNUiMvY34Hz8I1/uzZo8ARccLMQ=;
 b=fe8xdBnSJoFtk24zJq99+bIh+8V+2FdhOVMkvyvqMiy6U8r228McoVZc
 BId286Ai7UsMFMbTwPabMZr8tRovhTpsZlTJnZj4VigZ6tRZoUKXuuUa/
 NdamGKY+c39ExILPPx3waDtIb4tuiFvw9xV261SBOURFUYmkWhFREKPst
 0Dr6aZBzmagwxC9yHZQ7vwvkTue+OdiCdh/DgupoDZ1gWUftoublIwUez
 iXcX1mfwY0Q72ISXbtHnPH6Fg4OZvmC7VqaiMkMIAi5fduK+NZglU++fG
 B9RAMQAo5nFVVPIB1z/1nZ8rvu8bjgeVDCHMguu2JWfK+b7BQdO77eESa g==;
X-CSE-ConnectionGUID: O5hQYFTpT4+9te+eYUPMEg==
X-CSE-MsgGUID: hclpo9R6Q0a78t1daoKORg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232042"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: 0vpD6wXETpeAmo5W7remVA==
X-CSE-MsgGUID: igAZSAQARhimxV4PB2UDJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315325"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:41 -0700
Subject: [PATCH iwl-net v2 08/15] ice: E825: stop clearing
 PHY_REG_TX_OFFSET_READY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-8-e55b692d0e6b@intel.com>
References: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
In-Reply-To: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-0-e55b692d0e6b@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>, 
 Przemyslaw Korba <przemyslaw.korba@intel.com>, netdev@vger.kernel.org, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Maciej Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=7881;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Ckp24sqJcKgxFa8rbNUiMvY34Hz8I1/uzZo8ARccLMQ=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6ULzKKae5qFV65Z/UVQketCtVf2Ib7EPyzC6w9Ob
 6nUEY7rKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCIxbQz/U5s+hlUfO/er4ien
 VeiRlx7GhpPuWJ1RYjtxUXp1yOxnpowMh1ItbGbdLJgXu+D/dat57re2357GJ5v96cxvTl2fJT7
 WTAA=
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
will be rejected until the PHY timer calibration has completed. Unlike E822
devices, set the calibrating flag when "stopping" the PHY and clear it
immediately after the start procedure. The E825 device does not perform
vernier calibration and thus does not need to wait for hardware to mark the
offsets as valid.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Suggested-by: Maciej Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 24 +++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 21 +++++++++++----------
 3 files changed, 35 insertions(+), 12 deletions(-)

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
index 328e90dc51aa..657cd78ec738 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -1221,6 +1221,7 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 	struct ice_pf *pf = ptp_port_to_pf(ptp_port);
 	u8 port = ptp_port->port_num;
 	struct ice_hw *hw = &pf->hw;
+	unsigned long flags;
 	int err;
 
 	lockdep_assert_held(&pf->adapter->ps_lock);
@@ -1236,7 +1237,12 @@ ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
 		err = ice_stop_phy_timer_e82x(hw, port, true);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		err = ice_stop_phy_timer_eth56g(hw, port, true);
+		/* Disable new Tx timestamp requests */
+		spin_lock_irqsave(&ptp_port->tx.lock, flags);
+		ptp_port->tx.calibrating = true;
+		spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
+
+		err = ice_stop_phy_timer_eth56g(hw, port);
 		break;
 	default:
 		err = -ENODEV;
@@ -1302,7 +1308,23 @@ ice_ptp_port_phy_restart(struct ice_ptp_port *ptp_port)
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
 		err = -ENODEV;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..c8a67a307832 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -2101,24 +2101,25 @@ static int ice_sync_phy_timer_eth56g(struct ice_hw *hw, u8 port)
  * ice_stop_phy_timer_eth56g - Stop the PHY clock timer
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
@@ -2151,7 +2152,7 @@ int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port)
 
 	tmr_idx = ice_get_ptp_src_clock_index(hw);
 
-	err = ice_stop_phy_timer_eth56g(hw, port, false);
+	err = ice_stop_phy_timer_eth56g(hw, port);
 	if (err)
 		return err;
 

-- 
2.56.0.rc0.395.gd1f3524e15dc

