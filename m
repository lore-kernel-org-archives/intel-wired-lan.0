Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F064C98314
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Sep 2026 12:59:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A1E6819D5;
	Thu, 24 Sep 2026 12:59:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DrEBJaNj8HMq; Thu, 24 Sep 2026 12:59:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 96927819F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790254778;
	b=XCQJRyzgmfxFebrJvxo738S6NomFpAmusQLmdHrqk1/ZN8JU37vnxz4zuOP71kL8mmFb
	 b1Lc8bupagImqKfykw+Ja/LqYyu5QUevS8UNQXWjTZrB3hLX9QbxgRqfncCs5aSEy74dD
	 te/P5ZYHBNYGnEmMh9u8D0EFur/ZTg54sW3ArgZ6skBztrX+T7XDavan0RvBtg6LPScml
	 YNzRJGAgPA7y/6BLILh1gOmaTzRLBGlbMwIRQ35rI+z/b8fNPxVbBFdHW1gRl01p1KEC0
	 qPJFwD33Gpgy0dozn3EpaQdGGwVgcpF/cwWIOgxQ3g2rDF6+H8gEDoOnXyW8WadMVIw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790254778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uNMFT2QCDjVlZfJwuojXDQ13ilQUN12wpTKVfCqB+aM=;
	b=D+HDCowNk7M3RCITn0KFhzE+qrXfZB/Deqmc10jFdSaaK6A5PBa6KYYO3lULCTGV8+W5
	 jUZg+BwNkjXIYTsyTACTPe2Qprmyv42kQMUx5YF7S47Ui8HHjpO7LAFdz4qolj57pxnzC
	 xInckhv1U2nETdWT9tE2FFB6l534klJnqVfGgOlJg8L5XHlhKRSMbXZ/p1w/ObTmXWskj
	 p8nlPjVxekHZRH1vu/xraE6UEozkLEwXuTX5b4MvevQIQPc8XRiNurFLYqkkFgLzk9pTC
	 1MvQIaraI/VNvyfZmSDc14jnPGURS7u+HwvEoVRaZsf2WwtgVksbfWaBZkfkZPZGHsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790254778;
	bh=uNMFT2QCDjVlZfJwuojXDQ13ilQUN12wpTKVfCqB+aM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=03xnJDVdcE4B8kyfCLpeSMnFqRTZ8jCg3iNeXqH4bTOzjug+1mBFKFuvN4DQ3gu7i
	 sN1hpp7nMDKsTPq2mXyRVsk2pPcvzgaYRrHKjDlBJkrgM7s+PL4mEa/IYG8rFn+kDb
	 X/DURyFmMv0sUxQNtT+eowmz9i0vkAITyrjF+eCakh8qdn47pduXzp+Pv10c8bDMaQ
	 C87BEDQlsGzFfDih2UFCPJlxwzaMnMSvV8Asht9eMdXJnmmYceL7fuYch6cAEFFhkY
	 Nf8qkkwZgA+7BUq/vWA+o3sW94pp83hkvVOF9Xw6TYZ5lJwjVgWbS1IBP7tB2tM8P+
	 3dsydDYw9QLKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 96927819F3;
	Thu, 24 Sep 2026 12:59:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 14BEF1F41
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E530400FB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VLsXlhB9kFib for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 45B9640456
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790254772;
 b=VUENUiMd0rTu+U80DBkrVh1CoeujPUwpi/J2HwNITTJ+wUGBs67Zcos89OLy8Mb/74r0
 wA05H2lIQ7Ab5zBoxm2lYxRvYC4aPVksoJ5i3E/MIugkJCGvClvM3Tu39sEO2ihXsFDB2
 cThaxzqhBsIB46YXjssKmwHg5L7mqKPGQ2U7OMzfxirwg8vhzzNVzx7cplerpVNtQcTsF
 NYURLlN6vHhQsy5AmU/+eDV2SZHGI+PZPpEA541QMh2vxhI5xjANh1o4NyBESnRsa7RBF
 qnYBhT4uzjjIe6UWM09ounuHzxEJSkAW/RGToPMjaCbZTxV1Q/3EuAiPXBk2NyGuJ1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790254772;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=uNMFT2QCDjVlZfJwuojXDQ13ilQUN12wpTKVfCqB+aM=;
 b=YFvn7gu6WAKIqybOthOHeKt3w6BgZGtv5v9N+8GYn6I5uqR1CzwKTFjO6DYxkadoqH3c
 IC7ho+zSX3tz2ta/keoJXD27vrIsoz8ubsBU+mWTAUAaTG6FfR6/F99EPGof3l8/XRXoV
 v6yNj2HmL/zX2lvO0SI/lghudJhMlx1WwL62f2znq3r862nqVaKAy5cn2PQ+4qwc9idMM
 XeYPYKFaZST55/8g2dT9A5pvTU734u298T7apGjr4D8+XblP2lA6xcKbH2w9JpBiHxdf4
 8w1SuN5JlCPxsovGE9nJvFSALM4s2s1i8x0yI8meCgpNdIwYI9+zAcs8Jh+2gwAWA2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=muY0Uw9e; 
 arc=none smtp.remote-ip=198.175.65.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=muY0Uw9e
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45B9640456
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Sep 2026 12:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790254772; x=1821790772;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0b3wewW4J9me+EBD22mhqtMxIvwOlQSGeFmNhvtYCyc=;
 b=muY0Uw9eu5AjeTglwRiaILEMYakoKCRQi8p2fZ3s6sYYeKPZbOysO/PK
 pXaHhOrRwS/4qbCmgGTfV9c7Y19cZtkzn2ysiNWcs9NIQXLTtTYfr5zpE
 Se4tAfIT2373Bja5eBWvxiSHAEwmfS7rtNCO1tPJmhG1UYlF1ElerkXdw
 ODFSb9O+sbDhXkUr+v3TM1Sk3nx7iuzyK1GOmGpbnKyZhA00hcplZc8ie
 h90fEeUl8JanAwz7SL6YsMfPSPSR5HbLa6cQlB/JOkZax/OQjfeyWY6lU
 dpHb2IP8Qt9DD8yQuSQ0o4ifPTLyXm8OCxO7bmIrFzRaHBwUutvx7xen5 w==;
X-CSE-ConnectionGUID: mZgV4GtUR5qQMePXCjK4IA==
X-CSE-MsgGUID: cx6ENbGLRB+TKx/wE3mzOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90249242"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90249242"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 05:59:24 -0700
X-CSE-ConnectionGUID: gXqXcLCPTLKAoOkqsR84Aw==
X-CSE-MsgGUID: AxK0IT0xRgOeOsUpOT+SRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="311934430"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa001.jf.intel.com with ESMTP; 24 Sep 2026 05:59:24 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net  v5 6/8] ice: Document control PF lock ordering
Date: Thu, 24 Sep 2026 12:59:14 +0000
Message-ID: <20260924125916.2796499-7-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
References: <20260924125916.2796499-1-sergey.temerkhanov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Document adapter->ctrl_pf_lock as the outer lifetime lock for TX clock
state and PTP hardware semaphore operations. This makes the existing
ordering constraints visible to future callers and helps avoid nesting
the rwsem below a DPLL lock.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index f7e6680d124c..67f2fc6e79e4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -156,10 +156,21 @@ struct ice_dpll {
  * Locking:
  *   Acquisition order (top to bottom):
  *
- *     txclk_notify_rwsem (read)
- *       -> pf->dplls.lock
- *         -> ctrl_pf->dplls.lock
+ *     adapter->ctrl_pf_lock (read)
+ *       -> txclk_notify_rwsem (read)
+ *         -> pf->dplls.lock
+ *           -> ctrl_pf->dplls.lock
  *
+ *   PTP hardware semaphore path:
+ *
+ *     ptp_port->ps_lock
+ *       -> adapter->ctrl_pf_lock (read)
+ *         -> PFTSYN_SEM
+ *
+ *   - ice_ptp_port_phy_restart() takes @ps_lock before reaching
+ *     ice_ptp_lock() via ice_start_phy_timer_eth56g() or
+ *     ice_start_phy_timer_e82x(), so ctrl_pf_lock is not the outermost
+ *     lock on that path. Never take @ps_lock with ctrl_pf_lock held.
  *   - @lock serializes all DPLL state mutations on this PF. When the
  *     controlling PF's lock must also be taken (e.g. updating the shared
  *     tx_refclks usage map), acquire pf->dplls.lock first, then
-- 
2.53.0

