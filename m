Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3907FCD4851
	for <intel-wired-lan@archiver.kernel.org>; Tue, 12 May 2026 14:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F20040C88;
	Tue, 12 May 2026 14:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89v_GmdPfptL; Tue, 12 May 2026 14:09:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FBFE40DDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778594963;
	bh=zz2JOjgOGHH6a2oRcPxaLAaResvQDXMqaXsen0bF8HI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=4O0Nl2HwCkhd4ZIYc8419IGtBe8LBvQaBQP58nIxce1aXDHaV+DPqF0QVlZZcXDdc
	 JDznlKkz5tn/RU0Yz6XDSViE5Moqdnb0J/Wnm1WWLph3p2EdT+MiwGNDvj4WMo2Uoe
	 b++71aau4BtzzvOjWSofjIYBPv9eYjw6ZR/sV+6y7pDnsNupt6o6qGHlnUID9ZM+LB
	 V1Juhr8tsXloV2g17DzdYgw6KW/5l/0Q2874sXoh049Ge8merTRag9Mp9j0U2JaO0D
	 qt0GWyH7V+FUCOMmp+1Nj9ddkpvmC68D7V6QK54Tov0ut8UFniDWzG5+Kd5cSDU0W9
	 xAv+pnrRSPU7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FBFE40DDB;
	Tue, 12 May 2026 14:09:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EE8D223
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 14:09:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40F6860DB6
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 14:09:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NqpbJ5CTq3DC for <intel-wired-lan@lists.osuosl.org>;
 Tue, 12 May 2026 14:09:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 03F3460DB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03F3460DB5
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 03F3460DB5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 12 May 2026 14:09:20 +0000 (UTC)
X-CSE-ConnectionGUID: mcQzSeBHQl67++diZLaG8g==
X-CSE-MsgGUID: uQJROWIwQdSYf73JuA76XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="96929685"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="96929685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 07:09:20 -0700
X-CSE-ConnectionGUID: wf90NH/7TpWrSl89hfjhlw==
X-CSE-MsgGUID: Ni6M6WAXTFujsPs9OCrmGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="275892507"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 12 May 2026 07:09:19 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Date: Tue, 12 May 2026 16:09:04 +0200
Message-ID: <20260512140904.4105236-9-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
References: <20260512140904.4105236-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778594961; x=1810130961;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VAHyAc2KoEUe2v4Yu2JRFPdha1c8Fnc9na45xhGWkSk=;
 b=AuhPxCSvHaBn/h4/n/EtG1c5MG03J/6BQAcMR3QSBbdgFjsrP1t0NZ04
 zBk8qbouewN3FX+JHqqMHRyU2ARsYGv7CxiFIrjc5+fsfaHazBjXJOnHw
 35uavlnCIt/chGdyk0F+4MYYHLOTaIOW+Xc16B0V8mQlxtIzONY1/bciq
 QUHxr3f0IrVSLh/XbZLGoI3Gu/yhELCSJwyrMaMuWCJM+/xvQ45qNi6Gv
 tGx2yVyDU6pWUg+Tgi8hpzkj+vFGU2B0Jk2PjYuYMRFadIHb9vma+ZSfV
 2oDgBq9gQNk89q1oLCdl9I6vhr8VNd0d2+RCCkNDqQy8PjqD4lar955FA
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=AuhPxCSv
Subject: [Intel-wired-lan] [PATCH iwl-next v2 8/8] ixgbe: add
 IXGBE_ITR_ADAPTIVE_MASK_USECS constant
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

ixgbe_set_itr() clears the mode flag (IXGBE_ITR_ADAPTIVE_LATENCY, bit 7)
with the open-coded complement expression ~IXGBE_ITR_ADAPTIVE_LATENCY.
This is equivalent to keeping only bits [6:0], i.e. the usecs sub-field.

Add IXGBE_ITR_ADAPTIVE_MASK_USECS = IXGBE_ITR_ADAPTIVE_LATENCY - 1 =
0x7F to name this mask explicitly and replace the open-coded AND-NOT
operation with the cleaner AND form.  The two expressions are
arithmetically identical; the change improves readability.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index cf2df18..20e2a97 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -478,6 +478,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 #define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
+#define IXGBE_ITR_ADAPTIVE_MASK_USECS	(IXGBE_ITR_ADAPTIVE_LATENCY - 1)
 
 struct ixgbe_ring_container {
 	struct ixgbe_ring *ring;	/* pointer to linked list of rings */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index ba7b013..be40655 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2959,7 +2959,7 @@ static void ixgbe_set_itr(struct ixgbe_q_vector *q_vector)
 	new_itr = min(q_vector->rx.itr, q_vector->tx.itr);
 
 	/* Clear latency flag if set, shift into correct position */
-	new_itr &= ~IXGBE_ITR_ADAPTIVE_LATENCY;
+	new_itr &= IXGBE_ITR_ADAPTIVE_MASK_USECS;
 	new_itr <<= 2;
 
 	if (new_itr != q_vector->itr) {
-- 
2.52.0

