Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE72CEDD9A
	for <intel-wired-lan@archiver.kernel.org>; Wed,  9 Oct 2024 14:02:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBF6D4073F;
	Wed,  9 Oct 2024 14:02:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a59bZYHHw37C; Wed,  9 Oct 2024 14:02:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 15E2840761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1728482560;
	bh=qBNXlCUyC5pKxaTFkDNDN4xi3DQtH/srv6QY5iPE6KU=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=oCGXoeMVl4GJiq2oX2A/G7jTgOyKEebRO7lXCLzfW3DfyGOJeMYWWA4+1ea0WCNPh
	 GpS1Xpe3KELWWGYXTePoaJA4G1DdyNvGMWtTN5gR5yKuSktwynmR8Yww0jYjeKYyw5
	 8AHrQc7RpcbrOVOmOrHdCjFt9+D/06F6tsHXaBYYigE3qED7pCFB5DAsp5M+7rbPTA
	 t8kZZF8i+TkltaquBOkiYEwJHQ7U4zr8tLzHLIv8Ezk2WZet67S5mdZJQVn3a/ccrN
	 HyAik/HuA/ZMEUuYnhasFVi2qj/WutfFsxA/vlBLBwSFxgH+V9SayGZNrS9eLU6H7y
	 Br0xtkilpzxZQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15E2840761;
	Wed,  9 Oct 2024 14:02:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 841D31BF215
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Oct 2024 14:02:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 71B9140767
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Oct 2024 14:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQgjWM5JaHtA for <intel-wired-lan@lists.osuosl.org>;
 Wed,  9 Oct 2024 14:02:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.15;
 helo=mgamail.intel.com; envelope-from=karol.kolacinski@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A9A244075E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9A244075E
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A9A244075E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  9 Oct 2024 14:02:35 +0000 (UTC)
X-CSE-ConnectionGUID: RljCsJA8ROK3uuUbKCLHlQ==
X-CSE-MsgGUID: fAdMEVZvTTCNY8cNs2F4bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31483950"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="31483950"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 07:02:35 -0700
X-CSE-ConnectionGUID: 1Nq8/WdYQUWvi/5SvPgaLw==
X-CSE-MsgGUID: lAWabKODSq+xmL/WQXLPoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="76210785"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO
 kkolacin-desk1.igk.intel.com) ([10.217.160.108])
 by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 07:02:34 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  9 Oct 2024 15:59:28 +0200
Message-ID: <20241009140223.1918687-4-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009140223.1918687-1-karol.kolacinski@intel.com>
References: <20241009140223.1918687-1-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728482555; x=1760018555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jiPvPXxBq3tdFiDO1nLpvgYWsPIczFNWPyj+6nTmfuo=;
 b=WYQwcYgjxrXh4hBCmWNbcm+YII61SqLdsgGv7rKNO1vHmzqF0GPtGM3p
 Vep4jYkOiwXD4ixr2stGhoG8oiKyq7J68qbjINAp2cn+J0T4tb0YwIOYx
 gqbnqoMwBreSIJhBqyONPiXvkP0nTlNG6CWkkAMG6Ol1RJXjwYNDHqJ9i
 BxC16lZ3Szb8xPVKsis6w3AX5Z0IqMIk70/kHjD3yXIzF9UjPIkUm6Mv+
 cN2Cw2xVakj1YnTUq/y03Xz7ZCPWzA4xQ3GBPR2nGHIpHSNdMOB02PaVb
 M8cJRB2nqvOVckoYktF97F8zsux1Aooex7oQMsros5PoQmlK0ovcnwfmi
 w==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WYQwcYgj
Subject: [Intel-wired-lan] [PATCH v2 iwl-next 3/4] ice: Fix ETH56G FC-FEC Rx
 offset value
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

Fix ETH56G FC-FEC incorrect Rx offset value by changing it from -255.96
to -469.26 ns.

Those values are derived from HW spec and reflect internal delays.
Hex value is a fixed point representation in Q23.9 format.

Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
index e63f2a36eabf..339b9f59ddde 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_consts.h
@@ -86,7 +86,7 @@ struct ice_eth56g_mac_reg_cfg eth56g_mac_cfg[NUM_ICE_ETH56G_LNK_SPD] = {
 		.rx_offset = {
 			.serdes = 0xffffeb27, /* -10.42424 */
 			.no_fec = 0xffffcccd, /* -25.6 */
-			.fc = 0xfffe0014, /* -255.96 */
+			.fc = 0xfffc557b, /* -469.26 */
 			.sfd = 0x4a4, /* 2.32 */
 			.bs_ds = 0x32 /* 0.0969697 */
 		}
-- 
2.46.2

