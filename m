Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D496C624D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 31 Aug 2026 14:50:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23F8A80D23;
	Mon, 31 Aug 2026 14:50:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F30AfPFxHIYe; Mon, 31 Aug 2026 14:50:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788187816;
	bh=OMybOzOLGh/VfoufWjUW6TuJUrtPEMS8IX34AZuw2zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g+/DlMCU3W0gifMQicja8qUpBs1AVIojGwkcMpPwoHeumb/zhuP6MJd8ABtOJN/Qc
	 v29q/Fuui6ra6skSqNLynKV8XNuShh5d7R5ehezjVwayZlSXyyv4dyesuY3onejomX
	 zERbmDzdXWvdBFAAts64LWv/3N8GEciWiZ7zXnlAk7WmTuFTZNl3kkBP8H1qw7w1x7
	 md4Y1K4QKNxkgaABEgY3bCzttTz7h9jfsmJwCIgX3LCOZIYbglRzw2qbxRw7FNIc62
	 t5+d3QBN98jlFPY9fRYru0rT5zASqpfQ+G+JWQOHAEiI4VW8eSfN0kQRpAff0+VBX5
	 cgEHC8dXAZO4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9343580D2B;
	Mon, 31 Aug 2026 14:50:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F0C60355
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1CD94054C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bSJe6_HAKDSP for <intel-wired-lan@lists.osuosl.org>;
 Mon, 31 Aug 2026 14:50:09 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=sergey.temerkhanov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e/uOUCKD
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A8A0D4056E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 31 Aug 2026 14:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788187810; x=1819723810;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uS1Gk3FU8H9sDA2GM9EWDtq+Xlygp4KxaypBMwUQwy0=;
 b=e/uOUCKDEHMAyn/12I+1f7EjzXtcgwn5katg7kOCeoWvUZtCqOylwmMF
 WjlwzP+hQ40Zae6R6OITihOR/kw3iGqyScdnapvW221rT4ixW6XGWL07n
 5fij071PjUVRcgJV291BCSDB5eaD4mHx8uc1KkpGlfF8korBuQDn34ggh
 XEaZo4fs4SbJtxiryNjVsWaaKZOLSOQJBNsuBKezgpqZU65zRxp6yxZIy
 7mYQeHrUVX4ZnaqzKRqkpUBXXCPO/H4o31yoCqn9futIzpO/ByZ1AAO8i
 qHSfg7ZhhA3bRiN5xd3QtjRdV4HJTy/LfNT5Hyc0mgchTVYUZhuvhStWn A==;
X-CSE-ConnectionGUID: pp7TL6LyRAGsVZCl5o0B9Q==
X-CSE-MsgGUID: Zl48h0AjQA6Mjp3o7SMi6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="76144524"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="76144524"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 07:50:08 -0700
X-CSE-ConnectionGUID: QOzBMPyARimzG/+k+oM3fg==
X-CSE-MsgGUID: 7LCNMY+YQFeXI5C0EQSKqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="273003695"
Received: from gnrd8.igk.intel.com (HELO GNRD8) ([10.123.232.137])
 by orviesa005.jf.intel.com with ESMTP; 31 Aug 2026 07:50:08 -0700
From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v5 1/6] ice: dpll: Add the MUX tables to the
 documentation
Date: Mon, 31 Aug 2026 14:50:00 +0000
Message-ID: <20260831145005.191040-2-sergey.temerkhanov@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
References: <20260831145005.191040-1-sergey.temerkhanov@intel.com>
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

