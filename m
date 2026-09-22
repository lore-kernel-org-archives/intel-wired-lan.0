Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B4BC98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:08:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82E0D606E9;
	Tue, 22 Sep 2026 18:08:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W--4hLukGkD3; Tue, 22 Sep 2026 18:08:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9390960715
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790100519;
	b=r/ws0mdAV3vgSv4wTnD3+4z5IpGYaa7uT22pqRukMulvxwv3ocQY1P4Xu5ZrqUY4t7rn
	 3IqPJ0c+kJ40pK7acguLjfwgpTr4jD8PgXyoWvA9zJgK1kJcvzyT6S31Gk9iNYxgCPa2w
	 f4NRKKE8gLDVYrtGvms/VCSWF4L+TRmm4CbuId1bdlhLpibFXnpN7nhCEXKjWdrTW0cFa
	 S3xt8A2zqRM6JSjBwguapOpPoSWts3knYc+uAqaopYPjn8Pu8QG/m1OFBymqgYQg0mAeA
	 0SGqT6lDZAdVO8/84dft7HOx6YhRugxeliK0rAMTRFxb036A0gkSk9FdZCMZv+WZ1JQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790100519;
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
	bh=wFSGt2XI40dnFNMe43v/3Fib1mKTUlDsA7UFrg0Mbw4=;
	b=du704RdKc3PdszOcYg1NDx2JJw0mdjhiVSUxCm4sr0vykOR1BH/d89kcLxA0RWPXVKDE
	 m1Yt++uneFT8eLXgR8Ur5wHhUlgFtzB3UwV0XM+MzLpglo9zlWQhI/MY9YMNNrrI1uMwl
	 sTzPNwGXLlWXkaM9YsUgJpgtN3JOkEVb/ek9ahn6hi/zUrU2hOjTNrxZoOpBh01B1dsOE
	 0q8nYKoRA2GEBdUSaeMLzkv8MRAEsG4W2hy9M1OWBT0xZR8PSLZlufv34qWK6jAhogkWk
	 ELXWhjg1rsQWH4RNb2gk69hx4jKw7irvn5K+tF0cd7+cOVcSG5SS3ZvPAd9Rqlt1ufA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790100519;
	bh=wFSGt2XI40dnFNMe43v/3Fib1mKTUlDsA7UFrg0Mbw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sdiPrPESDhR0NC7mh2Gaooes3s5YVUmswsmnihfcRx9F+Iaz2RAhsj7CjO+OMl/gU
	 9jDsnJW9G/gWQYEsadxVsFkq/3V3hRUNxzvI5a00VJn8q0LA8hVwy18YxjeeEdoHsi
	 miNrSdfMM61ZY6pFbq5PgqVoWu4Me/wwFaljfg/CJ5DC5cMPsrTCFjMjofqCe2HJH9
	 Ee7t69TQ8+MLGnp8fwh/IFdM58ZQhURmri+rFV7kK+hWXhNRK/s6+regtJKUSHwv8F
	 0QuEZ6XopSbs3KtzPUmztq7m5C+rWG5FbSvWPQvyRmTRra90kbnaDcds/QLobmykys
	 UCvA+nl3jUOlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9390960715;
	Tue, 22 Sep 2026 18:08:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFEBB12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9695540738
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CjMXEiUuTYLc for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9D904406FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790100507;
 b=JjwrZVpSUEZt0VZPIGtTRjfkonhwwQ0igU0o3jV41T3O/KKdka/jMW7sPTLl2WhbUO6R
 k0oDaEOYEuxXzFhmGv6UBM6bA4bbOuHW54XO/WXdrWqA4BKWtgihtc+75c5Ps66Ynnq/X
 8h/qWyTgBo+wWBNug5ciofwjPG2BIjR64j7qcBM4xyXVIgwSLtPG+pBuQtR0hjgCg5Ujn
 Rb1NPDfagzxLR3nToocvrXRA0LqQ16l3zO3QiYNYBv5UFUa1KBepTGzdfDySMmg4SkQ79
 Z4yNk15/eL6h4wb3vApiHsfShfYxfRtGzTIR3R6IBf9t8Gpjjyaol3B7ht3/LLZ8lTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790100507;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=wFSGt2XI40dnFNMe43v/3Fib1mKTUlDsA7UFrg0Mbw4=;
 b=mn8X12Iov5E+i+NHVf5KjIvrXNMkytcXrBcVhTNMO7ATriI5vkJLnshA2gTBzkYepVU5
 O7YSk85uhGbJ0XoQTWm9UpMPRuhscxxFWuNQUAkhJd4Y4JX0HZctKyWWOAffZYiKVgWB5
 E715w0s3ftZghXz6TSljPjToey0b9FsciAICYvljdIFRwMWB9AbeCk1e1kYFYuFGtfWSA
 suZ7ODOZgKYCIXHMzJIgxaPskJJYtuAzH+6u+ispUwGkSOuhNhuxOQhzjGhFtV9x4RDzN
 rOr2YTJ28rOZzUtCvyK6ZjgT4MbNkJ/rXo8abTtPavY3nAGJOkF7Gd2aHdo6w6kTKRA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=EQPGBtmu; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EQPGBtmu
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D904406FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790100507; x=1821636507;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=C7Ec1UZI8OuV+n2YbfOkK1M6yHR2cHa3IjtGFNfXmOU=;
 b=EQPGBtmuIvUabuaEzHnfuY64qxDGQb3VTHGeZ5VYpz9GhhvlkZd6h2qP
 QUl0C3W2r12hqgCos1qDe+u6yMwj/w6d8WldxOp58D0UZuhKO6GE74lTF
 hPKfN8Sc2DMI+7VZAW0ZkRuztWPwvnaiXW807q0BuGfeZ9vm+vk9FXyzS
 7HBafda6feR4HOQ8IWiyGYa+RJBFfuHfhrpWlS5Ib4QqYkrb2Cf8j9p3m
 enAJNr3cDjn+PEYuweWiURyEOgBchwmuB5PJ0VldyZ8q5okbw5bQZJP10
 jcF1cA6FQYh3WsNYo0RVWJn7/8QyvnHgDuNBG6kvFiKSJgsKy0YD1SvjC g==;
X-CSE-ConnectionGUID: hAQpoqE4SQeNPZ3N3558MA==
X-CSE-MsgGUID: AC50Ox35Qo2DlhnQTdGDLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="108232046"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="108232046"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
X-CSE-ConnectionGUID: /cu6qgGqRH+evoVu/PnRkw==
X-CSE-MsgGUID: il3ELlyBTwW+pHd7fvy+BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="281315331"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109])
 ([10.166.28.109])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 11:04:24 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 22 Sep 2026 11:02:42 -0700
Subject: [PATCH iwl-net v2 09/15] ice: E825: clear PHY_REG_TX_MEMORY_STATUS
 prior to soft reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-jk-e825c-timestamp-processing-logic-fixes-srcu-v2-9-e55b692d0e6b@intel.com>
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
 Maciek Machnikowski <maciej.machnikowski@intel.com>
X-Mailer: b4 0.17-dev-8b7ea
X-Developer-Signature: v=1; a=openpgp-sha256; l=9921;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=C7Ec1UZI8OuV+n2YbfOkK1M6yHR2cHa3IjtGFNfXmOU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhqxNh6V99vEF19VdbK5zzGpe+3fuEwGGIwzfGRJPueYvs
 utd+Uy2o5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInM3MvwV0C94p2t2uu8pe4S
 Gms1m3hnWf/PfzRPukqaP3r71VPndjIydF2y+njYSiJx+sVtb7e7Feus/vPn2hsDiQOH7ufsimm
 cxAMA
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
index c8a67a307832..e1a5ff5793d1 100644
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
+			 port, failed);
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

