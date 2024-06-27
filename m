Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C68C30653
	for <intel-wired-lan@archiver.kernel.org>; Thu, 27 Jun 2024 15:11:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BAF2A60E44;
	Thu, 27 Jun 2024 15:11:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EJlfWYR-gbxg; Thu, 27 Jun 2024 15:11:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59EC860E48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719501104;
	bh=3HMRtz0eNpm8IQk9H1RrsQNWq8/MC6KbNjmtkU1nVTI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zrl3+zj4ry55s2ZwA9Ru6cry88tJ8uMSyXzCJ3TfOR/3MLC1tsh1IIouZmbmrTB6j
	 ZEQ0sD4dTvJyK9TngpyNGG4BJCdaJl9XHop3e64VHM/03a6WPIxUniDszSgAF6YzZ0
	 NqkHA358JoIcefnrf9qav/BjEYmfqfvCthRReuZTxOx6+NoGJr4GLkEDASVtYEhE3n
	 Frkhu1Nnmiob+oaZdko6B24OdYw/M/9+Rxcwdm7rcIRe5GwgXreKXQgtu9NhUAcy+W
	 rC3QUFMIzxoMdr8Jo+pVX2yUqBs5Kg/ncd6uSN+bZnrmxh+rWB1tBGYvKlR4ObMJdA
	 036bfvpRyExNQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59EC860E48;
	Thu, 27 Jun 2024 15:11:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 335851BF3CE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 15:11:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C82508411F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 15:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzH2WTLsPSE5 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 27 Jun 2024 15:11:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=karol.kolacinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ECB018411E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ECB018411E
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ECB018411E
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 15:11:38 +0000 (UTC)
X-CSE-ConnectionGUID: hQqWrD6nRoK2QcljGpvT0A==
X-CSE-MsgGUID: w+dlqS0xTJWMnX7/HAp7oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="27222465"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; d="scan'208";a="27222465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2024 08:11:38 -0700
X-CSE-ConnectionGUID: WrIrOiGpSsqI/TlOkqpf5Q==
X-CSE-MsgGUID: PS1PPfeTS2qpCFTEBRMGQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; d="scan'208";a="48759670"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
 by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2024 08:11:36 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Thu, 27 Jun 2024 17:09:26 +0200
Message-ID: <20240627151127.284884-11-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627151127.284884-9-karol.kolacinski@intel.com>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719501099; x=1751037099;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i7BbOZrYnpbGWibWnhCboLr9HlYFVCb4RkJceAzyCZE=;
 b=e91ZuNQKvsh+dXMw0vy91ObwUdvFgY+2dUr0kteV/HgKxS4eEyBj2yp5
 YgEpHqFRHKHtChCxyzTIyUf3/blLXVOAnZEwvZebWQzR4Kw7gzqq4/+Me
 iOjjwbp1xhmbCDvAUNlWCgUz13lUPBztMziotU6Crud14ZQUlPLq854Rc
 rEuBmu0jPsU0L9UJLY00x3AUTdes8CrLa4FbVJuAwYdsT1xPk2mOAmNjV
 KL7Y6blLjFDWYoCFWWA75MuL+K8PK7IlYCxH1KVRYHfLxiOPip3OGLju5
 aETHRl8BBX1epFbOcPZ9Wf7XglEoSnPJsNhfgFddl3TX9+vklopzAYjBf
 w==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=e91ZuNQK
Subject: [Intel-wired-lan] [PATCH iwl-next 2/7] ice: Add SDPs support for
 E825C
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
Cc: netdev@vger.kernel.org, Karol Kolacinski <karol.kolacinski@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Add support of PTP SDPs (Software Definable Pins) for E825C products.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 28b82c634194..e38563905ca7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -20,6 +20,16 @@ static const struct ice_ptp_pin_desc ice_pin_desc_e82x[] = {
 	{  ONE_PPS,   {  5, -1 }},
 };
 
+static const struct ice_ptp_pin_desc ice_pin_desc_e825c[] = {
+	/* name,      gpio */
+	{  SDP0,      {  0,  0 }},
+	{  SDP1,      {  1,  1 }},
+	{  SDP2,      {  2,  2 }},
+	{  SDP3,      {  3,  3 }},
+	{  TIME_SYNC, { -1,  4 }},
+	{  ONE_PPS,   {  5, -1 }},
+};
+
 static const struct ice_ptp_pin_desc ice_pin_desc_e810[] = {
 	/* name,      gpio */
 	{  SDP0,      { 0,  0 }},
@@ -2623,9 +2633,13 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 		pf->ptp.info.getcrosststamp = ice_ptp_getcrosststamp_e82x;
 
 #endif /* CONFIG_ICE_HWTS */
-	pf->ptp.info.enable = ice_ptp_gpio_enable;
-	pf->ptp.info.verify = ice_verify_pin;
-	pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+	if (ice_is_e825c(&pf->hw)) {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+	} else {
+		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
+		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
+	}
 	pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
 	ice_ptp_setup_pin_cfg(pf);
 }
@@ -2673,6 +2687,8 @@ static void ice_ptp_set_caps(struct ice_pf *pf)
 	info->settime64 = ice_ptp_settime64;
 	info->n_per_out = GLTSYN_TGT_H_IDX_MAX;
 	info->n_ext_ts = GLTSYN_EVNT_H_IDX_MAX;
+	info->enable = ice_ptp_gpio_enable;
+	info->verify = ice_verify_pin;
 
 	if (ice_is_e810(&pf->hw))
 		ice_ptp_set_funcs_e810(pf, info);
-- 
2.45.2

