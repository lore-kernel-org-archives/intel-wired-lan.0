Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57723C52D6F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Aug 2024 00:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 07C004054E;
	Wed,  7 Aug 2024 00:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kO0urrTt8U8r; Wed,  7 Aug 2024 00:36:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DCE8404F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1722991017;
	bh=ZkaoFuitHvLoQYL8BD8XKhAraJnuQXBIl/mlceZiAdY=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=b5R210OIA8FeMUwZPZUw+Y7YCp+AwGFKtLz3v9XyHgOiYu9g6r7+jVFKwAw8cCQZ5
	 nRwqYZA7xezO3cRHw8Lt9dImEfuz7Fl0tmLZJ4jyOuEmZeZmIyfZR9wc81XcpQl09U
	 Rb/R2Z3jTlNWn2Y/exdfopz+5LbhUVAFrHbDi8sWJ3DbDxtpsLn1l/j/ByBr3ukhv4
	 xeFC1SzQwX9ZkBR4Ii013ApnSRAe2Jk2EZgdY3j8NW08RxdWv+rDwHAWC1DpBkRtg5
	 +cXHBlboFQ4GF26+3Okh12rBlU8UCeJ2AFjdcvEtlqjsQLt5eANoeVKx+1QUQYMKcW
	 N+Xf9LxSaQqIQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DCE8404F5;
	Wed,  7 Aug 2024 00:36:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 571A81BF969
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Aug 2024 00:36:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 451C4606C2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Aug 2024 00:36:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OLBqjemXC-vs for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Aug 2024 00:36:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=christopher.s.hall@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A32F060668
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A32F060668
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A32F060668
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Aug 2024 00:36:55 +0000 (UTC)
X-CSE-ConnectionGUID: nnNyJD+JStGwKewMGCvBsQ==
X-CSE-MsgGUID: z0R6nJh4Q4CWapb2LX4p+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="31669756"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; d="scan'208";a="31669756"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2024 17:36:56 -0700
X-CSE-ConnectionGUID: 60BPayseTmqA8079N55kOQ==
X-CSE-MsgGUID: iUVYMvXvTxiTRTw+KfZA7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; d="scan'208";a="61497014"
Received: from timelab-spr09.ch.intel.com (HELO timelab-spr09.sc.intel.com)
 ([143.182.136.138])
 by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 17:36:54 -0700
From: christopher.s.hall@intel.com
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  6 Aug 2024 17:30:30 -0700
Message-Id: <20240807003032.10300-4-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807003032.10300-1-christopher.s.hall@intel.com>
References: <20240807003032.10300-1-christopher.s.hall@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1722991016; x=1754527016;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YW8OJ6ncs4oJPqe5fuxKSZeeTTvjkAOWYEUbEfU4uus=;
 b=Jp14x/pjsKgkblyT1v1awEnWy9jfrifuPXd1CP2aba7i6VjBIfcpExgv
 YeF4poXVhOHaxTIgRqBLcIW7OvTRhjP+k5NUUm/AlmPdkwlEkABSNqTeR
 569ipKXAls+POPy9SnadwgUHHpSGLRjFY5VfVO3j42/66Ky3EsF3Y9sZx
 slKEB/Z2xmlJPfrKHLac5fEy7GzrMJPRTrrny1u3fXw4ANZ/Db1+tvSQJ
 nnggHK5sWN6ggKwfJUf5JU/0N9dikpWC8VG+TGurl40q/aAS/HKv8iXoP
 PQoT7bl6qDvQbRJqp6Vg35G+6pbFsy+CIPsx2uBSsKn3szhigfKbcItNf
 g==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=Jp14x/pj
Subject: [Intel-wired-lan] [PATCH iwl-net v1 3/5] igc: Move ktime snapshot
 into PTM retry loop
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Christopher S M Hall <christopher.s.hall@intel.com>, david.zage@intel.com,
 vinschen@redhat.com, vinicius.gomes@intel.com, netdev@vger.kernel.org,
 rodrigo.cadore@l-acoustics.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Christopher S M Hall <christopher.s.hall@intel.com>

Move ktime_get_snapshot() into the loop. If a retry does occur, a more
recent snapshot will result in a more accurate cross-timestamp.

Fixes: a90ec8483732 ("igc: Add support for PTP getcrosststamp()")
Signed-off-by: Christopher S M Hall <christopher.s.hall@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ptp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
index 00cc80d8d164..fb885fcaa97c 100644
--- a/drivers/net/ethernet/intel/igc/igc_ptp.c
+++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
@@ -1011,16 +1011,16 @@ static int igc_phc_get_syncdevicetime(ktime_t *device,
 	int err, count = 100;
 	ktime_t t1, t2_curr;
 
-	/* Get a snapshot of system clocks to use as historic value. */
-	ktime_get_snapshot(&adapter->snapshot);
-
+	/* Doing this in a loop because in the event of a
+	 * badly timed (ha!) system clock adjustment, we may
+	 * get PTM errors from the PCI root, but these errors
+	 * are transitory. Repeating the process returns valid
+	 * data eventually.
+	 */
 	do {
-		/* Doing this in a loop because in the event of a
-		 * badly timed (ha!) system clock adjustment, we may
-		 * get PTM errors from the PCI root, but these errors
-		 * are transitory. Repeating the process returns valid
-		 * data eventually.
-		 */
+		/* Get a snapshot of system clocks to use as historic value. */
+		ktime_get_snapshot(&adapter->snapshot);
+
 		igc_ptm_trigger(hw);
 
 		err = readx_poll_timeout(rd32, IGC_PTM_STAT, stat,
-- 
2.34.1

