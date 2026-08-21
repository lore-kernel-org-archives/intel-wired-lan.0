Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175DCC5DF96
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Aug 2026 15:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DAA3281369;
	Fri, 21 Aug 2026 15:25:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgWUIX8g2bZE; Fri, 21 Aug 2026 15:25:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787325901;
	bh=OMybOzOLGh/VfoufWjUW6TuJUrtPEMS8IX34AZuw2zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xg3vR/9mDADp4F+0YhJ6IW4xFZkvmzAxxthKdqd8vZ5pjbbT3JtCt/LFLPM7wET5T
	 MGFZZfnlxp6spWDudKwQeVRdF4bgv205/b5ia/B//vXXD4oNoQo52lXv4JyctR8mHa
	 mU5UscE83qERujzkvhUPcteO3FP+EEqVVUyPR+jcML4Mi+cIVrD13OA0TdMpPFsU3T
	 +3cYHVnNM0Q8FJxZoPUM9Kyo47hX6lQQCSNN9RRqrgNq/ztdaRfO5Leqdukd1jx0Bf
	 PkzdQpQWHF9/Hvk6SWaFbw5X1WJuWZfC3IABOcX/VAlL9a/dok/cQy5zVYo6wOvvKK
	 hbR23VEYd0smA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E0A081330;
	Fri, 21 Aug 2026 15:25:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF3863A4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C15B960666
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYk0fm6qpqi2 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Aug 2026 15:24:59 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=h8/N3yzT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 907C2605D3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Aug 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787325898; x=1818861898;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
 b=h8/N3yzTu0sN67Z9BKsxCbC/WfqrEdFGfz1Ft5aOBXI9gXoqmksjfA/W
 TwKcC1QocmtzmTPI+BwxnEbPi/vTdzNDZrQWgOS36ludXXWwreYkGjAWp
 qhSp4DjDR/Gpwqje79GcK6lTBTB4eCYMj/EcR1zRc5bnLHP8Pe0Tyb4se
 zPCacwAZYfu0E4XRYGRSwJdK3ltvz6XO3qAJByqZgWQHMXnLbpH7CUyB2
 cTMe10SD7eakgNYb6h3XJDDf0ipdRoZTuuabECzk5AD3quNYKXu8AWbhs
 V/AtYzAFzAngxki0xsUm+hORzYlJ0djVaCudjY3RUQ5PnNIPXSRVBz+jw g==;
X-CSE-ConnectionGUID: Hksr2zO9S52njqDVvLWK5Q==
X-CSE-MsgGUID: Lamrh7QCSWap9GFR0YGY9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11882"; a="91553200"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="91553200"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2026 08:24:56 -0700
X-CSE-ConnectionGUID: riteX99IQ666q2+XxzqFTQ==
X-CSE-MsgGUID: 6dZFAxTHSAuzOrNuPlgyRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; d="scan'208";a="270602188"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 21 Aug 2026 08:24:55 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v3 1/6] ice: dpll: Add the MUX tables to the
 documentation
Date: Fri, 21 Aug 2026 15:24:49 +0000
Message-ID: <20260821152454.3703979-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
References: <20260821152454.3703979-1-sergey.temerkhanov@intel.com>
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

Add the tables documenting the DPLL pin MUX states and behavior
to the driver.

Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 382fbe98f2b0..9b3584fa43a9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -92,6 +92,29 @@ static const struct dpll_pin_frequency ice_esync_range[] = {
 	DPLL_PIN_FREQUENCY_RANGE(0, DPLL_PIN_FREQUENCY_1_HZ),
 };
 
+/*
+ * SMA1/U.FL1 MUX table
+ *+----------------+-------------+------------+
+ *|                | SMA1_DIR_EN | SMA1_TX_EN |
+ *+----------------+-------------+------------+
+ *|SMA1 RX Enable  |       0     |      x     |
+ *|u.FL1 TX Enable |       0     |      0     |
+ *|SMA1 TX Enable  |       1     |      0     |
+ *|All Disable     |       1     |      1     |
+ *+----------------+-------------+------------+
+ *
+ * SMA2/U.FL2 MUX table
+ *+----------------+-------------+------------+------------+
+ *|                | SMA2_DIR_EN | SMA2_TX_EN | UFL2_RX_EN |
+ *+----------------+-------------+------------+------------+
+ *|SMA2 RX Enable  |       0     |      x     |     x      |
+ *|u.FL2 RX Enable |       1     |      x     |     0      |
+ *|SMA2 TX Enable  |       1     |      0     |     x      |
+ *|SMA2 Disable    |       1     |      1     |     x      |
+ *|All Disable     |       1     |      1     |     1      |
+ *+----------------+-------------+------------+------------+
+ */
+
 /**
  * ice_dpll_is_sw_pin - check if given pin shall be controlled by SW
  * @pf: private board structure
-- 
2.53.0

