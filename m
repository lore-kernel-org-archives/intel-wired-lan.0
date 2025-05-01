Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850DDC3ABA9
	for <intel-wired-lan@archiver.kernel.org>; Thu,  1 May 2025 22:54:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2427B6112A;
	Thu,  1 May 2025 22:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TM2oAw6GPebM; Thu,  1 May 2025 22:54:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 887A2608F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1746140076;
	bh=1JPEGyG604MfA/zCqNuPjBF5D6EtCqWjLM8iCvCxGHc=;
	h=From:Date:References:In-Reply-To:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cgoPpnXHZfX+5RU6kx91XDprAYp25o+/QrUdC8J7OCmGkvkf4qqFMvhp9GiO8H1mk
	 xM/8xFhGF8zpD4Rro+RniDkVLHpfdAOxMRUTDyRznBSMBhcUS+ao3Rbymhx5WjoIX5
	 1mHmAVUhk7b2Nej6BDtw0Q4It/PCPyZbsIUWDmh3EXeQlnGLJGIYUkYKg1Wfw29yqy
	 PKysOTa0D1Mql8baCrOB+d9zwdhEFjIgHpWQum78zX87FWU9VPnLM1vnLRfB2hHBvk
	 ojYOB8Fuz8g6sZFy7WocumWTAIyj6o51bXnxhRL8J2FJ9hH4z/9RRn7eUOxMEPHawb
	 pYD/FtVvsKx8Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 887A2608F6;
	Thu,  1 May 2025 22:54:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0C86E4
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 May 2025 22:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 925F9417BD
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 May 2025 22:54:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ll61Vo1etJ0f for <intel-wired-lan@lists.osuosl.org>;
 Thu,  1 May 2025 22:54:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=jacob.e.keller@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D8ECA417B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8ECA417B0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8ECA417B0
 for <intel-wired-lan@lists.osuosl.org>; Thu,  1 May 2025 22:54:33 +0000 (UTC)
X-CSE-ConnectionGUID: /P3uo+lfRMW1Xz3/LnKlcQ==
X-CSE-MsgGUID: wiDw3eYrRh+NPJXrJLsrBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811716"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="58811716"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 15:54:34 -0700
X-CSE-ConnectionGUID: DWG51QrqQxKY4JU1uB7ZHw==
X-CSE-MsgGUID: Ba64fF4eTom7MBMs8fmN9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; d="scan'208";a="138514284"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2025 15:54:32 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 01 May 2025 15:54:16 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-5-24c83d0ce7a8@intel.com>
References: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
In-Reply-To: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746140074; x=1777676074;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=p4ooCRtCJKeRfP1ccPMjYMHRLD7QTyW54ke+j3QUJog=;
 b=lJ+pGLlr3BT85NVMU/Ha/itySbgDI6DVwLpWEphejlqATjuspBXx/Zhp
 zBXkz4mZu4Wn1UcYfRaT6uJfsxpBYo72DrG6QW0Lwhpw8kcOTWK8WN/DX
 z/P4sjA8nIyud2ENHJcQlJN///qiWksm3BrhsJNmXrT53vlwvKE6wPyDC
 4WcjoyjzZNxcSmf+uG9G8mM0l128myVH6IKeWy/YJEbSo13wo9wNksn9t
 QAluXkJ0n1WlCW8VpY7CwXKtxo+EDlqbVWkHX4T2XB2nY6ZTxLa2we1qT
 YQXjtcuzTw2GO5chwLyGMIOGxWNpABwuw2Fj22YaKV1odcNuSyP2kUIdL
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=lJ+pGLlr
Subject: [Intel-wired-lan] [PATCH v4 05/15] ice: use designated initializers
 for TSPLL consts
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

From: Karol Kolacinski <karol.kolacinski@intel.com>

Instead of multiple comments, use designated initializers for TSPLL
consts.

Adjust ice_tspll_params_e82x fields sizes.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.h |  8 +--
 drivers/net/ethernet/intel/ice/ice_tspll.c | 95 ++++++++++--------------------
 2 files changed, 34 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.h b/drivers/net/ethernet/intel/ice/ice_tspll.h
index 7aef430258e23e8e65cfc37ef8436ac158fa7ee5..c0b1232cc07c3ebd73264d16fc9cd8bfaec29fec 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.h
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.h
@@ -7,18 +7,18 @@
 /**
  * struct ice_tspll_params_e82x - E82X TSPLL parameters
  * @refclk_pre_div: Reference clock pre-divisor
+ * @post_pll_div: Post PLL divisor
  * @feedback_div: Feedback divisor
  * @frac_n_div: Fractional divisor
- * @post_pll_div: Post PLL divisor
  *
  * Clock Generation Unit parameters used to program the PLL based on the
  * selected TIME_REF/TCXO frequency.
  */
 struct ice_tspll_params_e82x {
-	u32 refclk_pre_div;
-	u32 feedback_div;
+	u8 refclk_pre_div;
+	u8 post_pll_div;
+	u8 feedback_div;
 	u32 frac_n_div;
-	u32 post_pll_div;
 };
 
 #define ICE_TSPLL_CK_REFCLKFREQ_E825		0x1F
diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index eb7fbae719843e8b446f78943a2edcc4d5a9de6c..cf0e37296796c5bbda011d027dc8ef007b0e2021 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -7,76 +7,41 @@
 
 static const struct
 ice_tspll_params_e82x e82x_tspll_params[NUM_ICE_TSPLL_FREQ] = {
-	/* ICE_TSPLL_FREQ_25_000 -> 25 MHz */
-	{
-		/* refclk_pre_div */
-		1,
-		/* feedback_div */
-		197,
-		/* frac_n_div */
-		2621440,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_25_000] = {
+		.refclk_pre_div = 1,
+		.post_pll_div = 6,
+		.feedback_div = 197,
+		.frac_n_div = 2621440,
 	},
-
-	/* ICE_TSPLL_FREQ_122_880 -> 122.88 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_122_880] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
-
-	/* ICE_TSPLL_FREQ_125_000 -> 125 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_125_000] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
-
-	/* ICE_TSPLL_FREQ_153_600 -> 153.6 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_153_600] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
-
-	/* ICE_TSPLL_FREQ_156_250 -> 156.25 MHz */
-	{
-		/* refclk_pre_div */
-		5,
-		/* feedback_div */
-		159,
-		/* frac_n_div */
-		1572864,
-		/* post_pll_div */
-		6,
+	[ICE_TSPLL_FREQ_156_250] = {
+		.refclk_pre_div = 5,
+		.post_pll_div = 6,
+		.feedback_div = 159,
+		.frac_n_div = 1572864
 	},
-
-	/* ICE_TSPLL_FREQ_245_760 -> 245.76 MHz */
-	{
-		/* refclk_pre_div */
-		10,
-		/* feedback_div */
-		223,
-		/* frac_n_div */
-		524288,
-		/* post_pll_div */
-		7,
+	[ICE_TSPLL_FREQ_245_760] = {
+		.refclk_pre_div = 10,
+		.post_pll_div = 7,
+		.feedback_div = 223,
+		.frac_n_div = 524288
 	},
 };
 

-- 
2.48.1.397.gec9d649cc640

