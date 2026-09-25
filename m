Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A49E3C9830E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 25 Sep 2026 23:58:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D36F60D8B;
	Fri, 25 Sep 2026 23:58:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xKF60BnGIX2P; Fri, 25 Sep 2026 23:58:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6483060D93
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790380694;
	b=IJQklIrYTl3IzwNZ6b0oQZRjr3L8YyRLTpklRqOAHTsM+5arzJFBES87OIve8BQCN4EY
	 fMAELIv12o8+qpMx2L8AlnsBu88bbiMBNWTmoQ8NbJwsduqB+T1YhoDUfDVY3d7HYcdXV
	 gmtxzJJjCLqJjMuGOBQ3DK0P/Id0t5dpL+7mVPea7NHYQ91pcgOKX9eh+Ob1KCeDjm0lo
	 LHIhdje7l7JEba4+IC97/RGgbXUn3avehRMEbHRaiK4AkL/RcgfWp9Y9swCbbrho+vAHx
	 WJL2Yj87SH+kduN3c/5S1TDCexU430vHA/UwmYKAhxv8GKHKZQ1ta0VfTpIZ3RezZAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790380694;
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
	bh=TDrvCmdpL7g0taODl7+uEDkOWIdS/bIuO7lNSI63/zU=;
	b=EKN1PublEPQiOwW5rkzYr93NpK1MjZVxVZe6JuRc75KB7JFL2wLKNbtR37YpXh1DcsKH
	 p2fuHlqQED26/zKR8yAowS1xtFcGMD+hEzn8Rnq5v73LmhREvrSX4TQmGf+9AyJykWsEI
	 tUzV5cRP9Qcz1AyyiZo9SrQqu/6apyv9MY//XDW81BwkHxGtZhPEDO0UR6ZqyWTXh+nFU
	 Hq8DjQ2ZFMF70iHVtCaX9CqB14PB/qvtqsYk1Gtclv9/baCD4tMVOcxSoABQ1uld4DdSs
	 +pld/Wrc/mPnker8UYsNnoOTPW3ARXE/D/wPGRKkGOXL9HqeYnSip/GK7o8AxFmVpwg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790380694;
	bh=TDrvCmdpL7g0taODl7+uEDkOWIdS/bIuO7lNSI63/zU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QuaYqZpWrqnUZjrUSbV21a6qopp69wISUYPiY7RxPxs/2js8nmQhQoLi0MkZSYodP
	 9XIK0TQ958kn31D8M9pj1oN6md74sOsRva8VJ+Kk6+8n8QsY82roU7yfzk6g6s1TK5
	 +kaqErJ00Oq5SnXIrHwOQYVV/F8dRXWlsXdpolABdPT79096ksjq2nZ68ESxEU0Cah
	 CDIGGhPclNjyOEXs04Uhrr9F1vRmO09eRNQBDLpYJx/grIy00lujOmece43TfjHRyh
	 ckyWQTECQttFbSJF6+IOdW0HOEat/7BIWI6YiW4YfG7YbzX2mmUXMqkxYAZMAPVvR1
	 YW09kR6P4gmmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6483060D93;
	Fri, 25 Sep 2026 23:58:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F9F2355
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 289F240B46
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwFGae4C5U1J for <intel-wired-lan@lists.osuosl.org>;
 Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2A01840B88
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790380686;
 b=KKSd2gGnpsqkrAOjM3Fif5vRc3DFYYGQ1pZlIVzPpLlV7L1gz7961p1aNyNaVv9uhL2r
 tMqD/0a3bW7uYiN/oltNyCTAeGdrE3zdpxNI0kTXFIrFi+cg1TOCTwWuvEu6KHDAgoKW2
 vEQWGNUEHY8YZVl6ma/kOYer1DW2SilNnZcgGm8USCYb+fg4I+nopq/yt7FsUdtcAM5RO
 sJAz7LuGJSXrTD6hkbiIQmWpxS0KTmEVSFkexWxeiE+mwRrW9SU6OUux/L3UJCeBc6UMa
 H+T+9fw/TS9flVj1tj+3EJPkWfaohOWU8w3n0JdqsFKSxfBOQ4eFeRfEdjVZRLIcsVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790380686;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=TDrvCmdpL7g0taODl7+uEDkOWIdS/bIuO7lNSI63/zU=;
 b=sRB18Lbcb8nSbTWp3Oy3cMnoEdqOKq4/a/hhKgbfRV1mPgSmWmWVcksbwcZLabP3SDyG
 Cd7OANqKgOpx4hCUaJnN/EvoCpgf5GdzzkA9KntVtOIFTcQ4ZHCxSQA/fEWAqmhAqCN9z
 efUIQIJ5g1aKGKaXxovJjfZKlSCvP+/4B8vGesgagYizj2y4wdaRTW5QwwckK3fHQSTg0
 V0GBLGaiazGHrwOsCh1cXxInFC9VlzZAiTOitLZ7DcuR+VAiP7VUIn45NxTiVl6gcx9Cx
 7WjIiKoO8xGI6EbKUgCHq7nUUM1yyama7WsQQ7JaxWRcnomA/JXeQghYnfdbo6kZPKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=aXlh9jUB; 
 arc=none smtp.remote-ip=198.175.65.17
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=aXlh9jUB
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2A01840B88
 for <intel-wired-lan@lists.osuosl.org>; Fri, 25 Sep 2026 23:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790380686; x=1821916686;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=bLHmZbupbPi4ermRoXMZj63Du9BpHzk+CgJTxeOGei4=;
 b=aXlh9jUBvsYRqgzih8d6iy2K9ZCcXS/F/YX7hmrkWQUJO2ZulZJcgNmx
 GO7UdPuK/gvkWKqnfpGhFQHmxwzALg0P/0i5gSAjjDDIWgvTPLSIhuvgb
 JQpSo8UGGT3U41BjLFzcTVHyv/xaG9p3D2vF6sOLEF4eOrDb8iqfzpiaQ
 C9UToArTGPR5QCPu178Owy1syOEvAmOuRIZ+sz2zeWrzBCNe+zNFBTqvV
 r1w44X+umf3M+00aDG3nXuY7FpldO4WETXK2+n50bqT6qeFR+euiwtg1a
 ELTNu0JDWkt12AxbbxvjPdEsMQsU2zj6xTgAZ4sqNQ2ca1wzxGrkbCyXi Q==;
X-CSE-ConnectionGUID: gYaOVveKSz6C8BUJRgH+tQ==
X-CSE-MsgGUID: 1ry1OywGSMiN+tyW/rqIpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="90212812"
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="90212812"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:03 -0700
X-CSE-ConnectionGUID: 1b87TSj1SziAGiqXJteF2w==
X-CSE-MsgGUID: J/yRTfWmTfiySQXFXEQzvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,123,1787036400"; d="scan'208";a="300731126"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 16:58:02 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 25 Sep 2026 16:56:41 -0700
Subject: [PATCH iwl-net v3 09/15] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-jk-e825c-timestamp-processing-logic-fixes-srcu-v3-9-6532598e8da8@intel.com>
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
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=9921;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=bLHmZbupbPi4ermRoXMZj63Du9BpHzk+CgJTxeOGei4=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqztXFWlC6bztzdl887cejJ6Wf6q93euL4zi/v/5Lt8KD
 /Z7FtqTO0pZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZiIhD0jw2on9XiJzycPnpHZ
 Ebr5+Netk722TjTxnm7culI4S6xfewfD/2Lj17p7yqxXrzMKPLz26gut2GnaK3flrS5e92BGdZH
 gCQYA
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

The current implementation of ice_ptp_reset_ts_memory_eth56g() is flawed.
It tries to clear the timestamp memory by writing to the
PHY_REG_TX_MEMORY_STATUS region. This does not work properly, as it does
not trigger appropriate PHY actions.

To clear outstanding timestamp memory, the driver must read the timestamps.
However, naively doing this as part of ice_ptp_reset_ts_memory() is
problematic. When reading the timestamp index, hardware kicks off a chain
of actions including clearing the ready bitmap index, and decrementing an
internal counter if the timestamp index was marked as valid.

This can potentially leave the internal hardware counter out of sync with
the actual number of timestamps. This occurs because the
PHY_REG_TX_MEMORY_STATUS region is not zero-initialized when the device
boots up. Instead, it is filled with garbage. On a cold power on, attempts
to read the stale data result in the hardware triggering a counter
decrement for a timestamp that never happened. This underflows the counter,
and prevents new timestamp interrupts from being triggered for real
timestamp requests.

We must read the PHY_REG_TX_MEMORY_STATUS in order to clear stale
timestamps. But doing so may cause a desync with the counter. To prevent
issues, perform this clearing always and only right before initiating a PHY
soft reset.

The soft reset will clear and reset the internal counter and the ready
bitmap. The reads to PHY_REG_TX_MEMORY_STATUS will reset the region valid
bits ensuring that no stale data is left behind. This combination ensures
that we always have a clean slate with no stale data and with the counter
properly reset to zero.

If a read fails (i.e. due to a transient sideband queue failure) it is not
treated as a fatal error. There is already a dynamic debug message for each
read failure. Keep track of the total number of timestamp registers that
fail for a given port and log a warning message indicating the total number
of failures. Continuing is acceptable as clearing the memory is a
precaution against faulty software. Correct software access won't read the
index twice and won't read it at all except when it has already confirmed
that the index is valid by reading ice_get_phy_tx_tstamp_ready().

Fixes: 3ec46e157c7f ("ice: perform PHY soft reset for E825C ports at initialization")
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 100 +++++++++++++++-------------
 1 file changed, 52 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 07b55fbb88dd..e83ad2bb8d42 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -737,24 +737,6 @@ static int ice_read_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
 	return ice_read_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
 }
 
-/**
- * ice_write_port_mem_eth56g - Write a PHY port memory location
- * @hw: pointer to the HW struct
- * @port: Port number to be read
- * @offset: Offset from PHY port register base
- * @val: Pointer to the value to read (out param)
- *
- * Return:
- * * %0      - success
- * * %EINVAL - invalid port number or resource type
- * * %other  - failed to write to PHY
- */
-static int ice_write_port_mem_eth56g(struct ice_hw *hw, u8 port, u16 offset,
-				     u32 val)
-{
-	return ice_write_port_eth56g(hw, port, offset, val, ETH56G_PHY_MEM_PTP);
-}
-
 /**
  * ice_write_quad_ptp_reg_eth56g - Write a PHY quad register
  * @hw: pointer to the HW struct
@@ -1134,16 +1116,12 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
  * @port: the quad to read from
  * @idx: the timestamp index to reset
  *
- * Read and then forcibly clear the timestamp index to ensure the valid bit is
- * cleared and the timestamp status bit is reset in the PHY port memory of
- * internal PHYs of the 56G devices.
+ * Read the timestamp index to ensure that the valid bit is cleared and the
+ * timestamp status bit is reset in the PHY port memory.
  *
- * To directly clear the contents of the timestamp block entirely, discarding
- * all timestamp data at once, software should instead use
- * ice_ptp_reset_ts_memory_quad_eth56g().
- *
- * This function should only be called on an idx whose bit is set according to
- * ice_get_phy_tx_tstamp_ready().
+ * This function should only be called on an index whose bit is set according
+ * to ice_get_phy_tx_tstamp_ready(), or as part of a full sweep when paired
+ * with a PHY soft reset via ice_ptp_phy_soft_reset_eth56g().
  *
  * Return:
  * * %0     - success
@@ -1152,24 +1130,16 @@ static int ice_read_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx,
 static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
 {
 	u64 unused_tstamp;
-	u16 lo_addr;
 	int err;
 
-	/* Read the timestamp register to ensure the timestamp status bit is
-	 * cleared.
+	/* Per the PHY spec, reading the timestamp memory location is what
+	 * clears the entry's valid bit and its corresponding (read-only)
+	 * ts_memory_status bit.
 	 */
 	err = ice_read_ptp_tstamp_eth56g(hw, port, idx, &unused_tstamp);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read the PHY timestamp register for port %u, idx %u, err %d\n",
 			  port, idx, err);
-	}
-
-	lo_addr = (u16)PHY_TSTAMP_L(idx);
-
-	err = ice_write_port_mem_eth56g(hw, port, lo_addr, 0);
-	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to clear low PTP timestamp register for port %u, idx %u, err %d\n",
-			  port, idx, err);
 		return err;
 	}
 
@@ -1177,19 +1147,43 @@ static int ice_clear_ptp_tstamp_eth56g(struct ice_hw *hw, u8 port, u8 idx)
 }
 
 /**
- * ice_ptp_reset_ts_memory_eth56g - Clear all timestamps from the port block
+ * ice_ptp_clear_tx_memory_status_eth56g - Reset one port's Tx timestamp memory
  * @hw: pointer to the HW struct
+ * @port: port number to clear
+ *
+ * Fully reset a single PHY port's Tx timestamp memory. Per the PHY spec, the
+ * only way to clear a timestamp valid bit (and its read-only ts_memory_status
+ * bit) is to read the timestamp memory location, so read every entry for the
+ * port (two 32-bit reads each). This discards all timestamp data on the port,
+ * so it must only be used for a full reset; callers that must preserve
+ * in-flight timestamps clear individual indices via ice_clear_phy_tstamp().
+ *
+ * Due to interactions with an internal HW counter for the number of
+ * outstanding Tx timestamps, this *must* only be called as part of the
+ * ice_ptp_phy_soft_reset_eth56g() procedure. Otherwise, the internal counter
+ * may become out of sync and prevent new timestamp interrupts.
+ *
+ * Failure to read a given index (i.e. due to a transient sideband queue
+ * failure) is not considered fatal as the PHY port is about to be soft reset.
+ * While the soft reset does not clear the timestamp memory, software
+ * shouldn't be reading the timestamp memory without already knowing it is
+ * valid via ice_get_phy_tx_tstamp_ready(), and this sweep is just
+ * a precaution to ensure the memory is in a known state.
  */
-static void ice_ptp_reset_ts_memory_eth56g(struct ice_hw *hw)
+static void ice_ptp_clear_tx_memory_status_eth56g(struct ice_hw *hw, u8 port)
 {
-	unsigned int port;
+	int err, failed = 0;
+	u8 idx;
 
-	for (port = 0; port < hw->ptp.num_lports; port++) {
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_L,
-					 0);
-		ice_write_ptp_reg_eth56g(hw, port, PHY_REG_TX_MEMORY_STATUS_U,
-					 0);
+	for (idx = 0; idx < INDEX_PER_PORT; idx++) {
+		err = ice_clear_ptp_tstamp_eth56g(hw, port, idx);
+		if (err)
+			failed++;
 	}
+
+	if (failed)
+		dev_warn(ice_hw_to_dev(hw), "Failed to clear %d PHY timestamp registers for port %u\n",
+			 failed, port);
 }
 
 /**
@@ -2295,6 +2289,7 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  *
  * Trigger a soft reset of the ETH56G PHY by toggling the soft reset
  * bit in the PHY global register. The reset sequence consists of:
+ *   0. Reading every timestamp memory register to clear its valid bit
  *   1. Clearing the soft reset bit
  *   2. Asserting the soft reset bit
  *   3. Clearing the soft reset bit again
@@ -2303,6 +2298,12 @@ int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status)
  * to settle. This provides a controlled way to reinitialize the PHY
  * without requiring a full device reset.
  *
+ * To ensure that the internal counter matches the contents of the
+ * PHY_REG_TX_MEMORY_STATUS, read every timestamp index prior to performing
+ * the soft reset. The PHY_REG_TX_MEMORY_STATUS reads ensure that the region
+ * is cleared, while the soft reset procedure ensures that the timestamp
+ * counter is reset to zero.
+ *
  * Return: 0 on success, or a negative error code on failure when
  *         reading or writing the PHY register.
  */
@@ -2311,6 +2312,8 @@ int ice_ptp_phy_soft_reset_eth56g(struct ice_hw *hw, u8 port)
 	u32 global_val;
 	int err;
 
+	ice_ptp_clear_tx_memory_status_eth56g(hw, port);
+
 	err = ice_read_ptp_reg_eth56g(hw, port, PHY_REG_GLOBAL, &global_val);
 	if (err) {
 		ice_debug(hw, ICE_DBG_PTP, "Failed to read PHY_REG_GLOBAL for port %d, err %d\n",
@@ -5802,8 +5805,9 @@ void ice_ptp_reset_ts_memory(struct ice_hw *hw)
 		ice_ptp_reset_ts_memory_e82x(hw);
 		break;
 	case ICE_MAC_GENERIC_3K_E825:
-		ice_ptp_reset_ts_memory_eth56g(hw);
-		break;
+		/* E825 hardware must only reset timestamp memory as part of
+		 * the soft reset procedure.
+		 */
 	case ICE_MAC_E810:
 	default:
 		return;

-- 
2.56.0.rc0.395.gd1f3524e15dc

