Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C5B10BA436
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A32361275;
	Fri, 27 Mar 2026 07:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bvmfw3oT_1s; Fri, 27 Mar 2026 07:30:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 801FB61279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774596657;
	bh=XOdtCXv/sL6bkbAXHS2BMDeT0vV9KJidM/IMYsLaj34=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AJfoFvrnbgCRW9BjqW+RiFigagmVRh29GM+gHKc9gk+rFuY8/2jicwL2NDl6weIuJ
	 /VLDxaZ43Qt+65+ygO6oLWRIE5PUuylEuVnDJpuNgOSrjmTNOk2xZjSqKcAWsbRCA9
	 Bd2DbJ33vzCVk6VivgVJedBqZA1LRRM3o/V9OX+pXOyGlg1qHnnNHm+3ExLbiO/GPt
	 DF9Zenioyb+dCFDy4gnCEiA0FqfZLYLwaUz0LbFAaCML5/Bou6iuATB5fP9GXfpNck
	 Hp/FiiGf/lqeVjbdTjvlHabuPY/+Wra/kzn26/d7qa5E3S5Z/2nZ8lwiDKv+mA19U2
	 sC1yoHcEq0iFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 801FB61279;
	Fri, 27 Mar 2026 07:30:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15AA72D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EFC85415BB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N8sDQUpxJiWw for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Mar 2026 07:30:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.14;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 033F041598
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 033F041598
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 033F041598
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Mar 2026 07:30:54 +0000 (UTC)
X-CSE-ConnectionGUID: zGjvULzgScmSCOgDbzXthw==
X-CSE-MsgGUID: Alo0lcBkSHi6muC5bWmkkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75734313"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="75734313"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 00:30:54 -0700
X-CSE-ConnectionGUID: EGcBY00dRwKuyLjRiq9ndQ==
X-CSE-MsgGUID: ftIj9IbWRiqo1I/uHEPzRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="255740377"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa002.jf.intel.com with ESMTP; 27 Mar 2026 00:30:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Fri, 27 Mar 2026 08:30:39 +0100
Message-ID: <20260327073046.134085-5-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774596655; x=1806132655;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oNyWn7ZTbJJx+aP1g1MibJ76duDH082hR3WA37AcXC4=;
 b=Jte9SEYXJUhFQnxY0iA3R+hUQ70IKewsfxvqI/YObcj32zunef1yrF8f
 rjw6OWacm2H1itN5cqx59uj0FzAqyO9JErxzL75jSGXErJchyYXtcSTX4
 f6ut2TkrfRgnbYKp2mVkVMqKGenS8uuuSDlaFZ/gGIveIXi4F74hZnOi9
 ojmhywRc69K27soXnuFwTzPLLqqFPP3LuqDqLz4HcDIdohQw2JN92gpjZ
 j+vIVZURXk6tKLNKKRP/SYCBcFUcsK3vOfzEMUbbLjRjZZ+Py978EN7Ry
 MCsZZe5cDlRuCbsfnl8+1kKXTvHimoziYvjpgY0hc5QjNCwSn6Il7hNXt
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jte9SEYX
Subject: [Intel-wired-lan] [PATCH iwl-next] ixgbe: use ktime_get_real_ns()
 in ixgbe_ptp_reset()
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Replace ktime_to_ns(ktime_get_real()) with the direct equivalent
ktime_get_real_ns() in ixgbe_ptp_reset().  Using the combined helper
avoids the unnecessary intermediate ktime_t variable and makes the
intent clearer.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
index 6885d23..a7d1635 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
@@ -1347,7 +1347,7 @@ void ixgbe_ptp_reset(struct ixgbe_adapter *adapter)
 
 	spin_lock_irqsave(&adapter->tmreg_lock, flags);
 	timecounter_init(&adapter->hw_tc, &adapter->hw_cc,
-			 ktime_to_ns(ktime_get_real()));
+			 ktime_get_real_ns());
 	spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 
 	adapter->last_overflow_check = jiffies;
-- 
2.52.0

