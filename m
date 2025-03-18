Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390D1C28B30
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Mar 2025 03:09:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 071A160AC6;
	Tue, 18 Mar 2025 03:09:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BJbAmCMB4tUj; Tue, 18 Mar 2025 03:09:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A378560667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1742267346;
	bh=6K3rMkGKwZc5jvMd/z4ZpGe61fYCEZVXizmE07X2kg8=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PBNPHLl2zcOlhS72w6iiBpNnjKL/XvdLZdLuBOBiGno3LircXcrbEjqPZMRAptUzJ
	 XP+8VdRhfXAxXCpUI6U2tSWbwt9uGER0Pbmz3jowFd7nyXXnfYIa+pZLWpk1xCNB0u
	 ZfGr60Tt53aLcNNBpAij8uKGAw3KsQv0BGWfsq5OzBQZvnTu4dr9TFaFXRTx6XwHsk
	 g+ZdO4FanDXLln0DEvxuPFGscR3E6SSJ3YYhRQsA4M7NnboV2x+swifZ/gOBbEvmVc
	 SvuYDDAbrRYEb2XGWMmeZLF8R78vuAxCxP+LNR2UpAoSwWWP9PUn+qiE8yezkKrn4c
	 zcJ52ejZ/hGJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A378560667;
	Tue, 18 Mar 2025 03:09:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 185E916E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Mar 2025 03:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0F1440D94
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Mar 2025 03:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4hd0YW0XmUSa for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Mar 2025 03:09:03 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13;
 helo=mgamail.intel.com; envelope-from=faizal.abdul.rahim@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7E17A40D84
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E17A40D84
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E17A40D84
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Mar 2025 03:09:03 +0000 (UTC)
X-CSE-ConnectionGUID: 6tRQpgXdTg6Ff1/E4PTGmw==
X-CSE-MsgGUID: wD35CB6dT0CjRTDGN3TuGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="54382983"
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="54382983"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2025 20:09:02 -0700
X-CSE-ConnectionGUID: 6ScQ+CC6QASbNGSWqJ1K2Q==
X-CSE-MsgGUID: 8G7UL6nyQd65/FtNHfjpZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,255,1736841600"; d="scan'208";a="126313814"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
 by fmviesa003.fm.intel.com with ESMTP; 17 Mar 2025 20:08:55 -0700
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Hariprasad Kelam <hkelam@marvell.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-stm32@st-md-mailman.stormreply.com,
 Chwee-Lin Choong <chwee.lin.choong@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Serge Semin <fancer.lancer@gmail.com>
Date: Mon, 17 Mar 2025 23:07:33 -0400
Message-Id: <20250318030742.2567080-6-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
References: <20250318030742.2567080-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742267343; x=1773803343;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cRb+CbjWo0ZjK0e4vuvO/MeSF/KtBDAkMvyjIUZVP0Y=;
 b=FRMVhL9av5aicfXTQLX/RisbwJ4+NZr5yI3ScPkoA9o0Z/PpbL122O2e
 hFsoltAKCUxYs0skfeJ8mqCGnkJ+ou/uf3VrJ4kVj/It0gr3l5oq/3w3F
 qVeW5BM6STr9prXVNHUnujBPNThUNfswFbZYhpsEQ35Nda6saSGzL5V+y
 2GxQObc3HeIiJE5fW5gbYCLoEioN0JqwSdkQJd/mvf416x8mlQiQYm8u7
 8NovkdVX5y4RE2ZG9uqzMzfUbvD4HmGUfbVZeXlc8nmwimvkHyfP3Rm1R
 HcForriTEliyDshW0fw6FzyUdTIQRMSnPWs5DTnHWvd+HyeU1Bb5c5xpv
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=FRMVhL9a
Subject: [Intel-wired-lan] [PATCH iwl-next v10 05/14] igc: rename
 I225_RXPBSIZE_DEFAULT and I225_TXPBSIZE_DEFAULT
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

Rename RX and TX packet buffer size macros in preparation for an
upcoming patch that will refactor buffer size handling using FIELD_PREP
and GENMASK.

Changes:
- Rename I225_RXPBSIZE_DEFAULT to IGC_RXPBSIZE_EXP_BMC_DEFAULT.
  The EXP_BMC suffix explicitly indicates Express and BMC buffer
  default values, improving readability and reusability for the
  upcoming changes, while also better reflecting the current buffer
  allocations.
- Rename I225_TXPBSIZE_DEFAULT to IGC_TXPBSIZE_DEFAULT.

These registers apply to both i225 and i226, so using the IGC prefix
aligns with existing macro naming conventions.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 7 ++++---
 drivers/net/ethernet/intel/igc/igc_main.c    | 4 ++--
 drivers/net/ethernet/intel/igc/igc_tsn.c     | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 8e449904aa7d..b6744ece64f0 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -396,9 +396,10 @@
 #define IGC_RCTL_PMCF		0x00800000 /* pass MAC control frames */
 #define IGC_RCTL_SECRC		0x04000000 /* Strip Ethernet CRC */
 
-#define I225_RXPBSIZE_DEFAULT	0x000000A2 /* RXPBSIZE default */
-#define I225_TXPBSIZE_DEFAULT	0x04000014 /* TXPBSIZE default */
-#define IGC_RXPBS_CFG_TS_EN	0x80000000 /* Timestamp in Rx buffer */
+/* RXPBSIZE default value for Express and BMC buffer */
+#define IGC_RXPBSIZE_EXP_BMC_DEFAULT	0x000000A2
+#define IGC_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
+#define IGC_RXPBS_CFG_TS_EN		0x80000000 /* Timestamp in Rx buffer */
 
 #define IGC_TXPBSIZE_TSN	0x04145145 /* 5k bytes buffer for each queue */
 
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 99123eef610b..6f0110e3ac22 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -7156,8 +7156,8 @@ static int igc_probe(struct pci_dev *pdev,
 	}
 
 	/* configure RXPBSIZE and TXPBSIZE */
-	wr32(IGC_RXPBS, I225_RXPBSIZE_DEFAULT);
-	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
+	wr32(IGC_RXPBS, IGC_RXPBSIZE_EXP_BMC_DEFAULT);
+	wr32(IGC_TXPBS, IGC_TXPBSIZE_DEFAULT);
 
 	timer_setup(&adapter->watchdog_timer, igc_watchdog, 0);
 	timer_setup(&adapter->phy_info_timer, igc_update_phy_info, 0);
diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 1e44374ca1ff..498741d83ca6 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -136,7 +136,7 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 	int i;
 
 	wr32(IGC_GTXOFFSET, 0);
-	wr32(IGC_TXPBS, I225_TXPBSIZE_DEFAULT);
+	wr32(IGC_TXPBS, IGC_TXPBSIZE_DEFAULT);
 	wr32(IGC_DTXMXPKTSZ, IGC_DTXMXPKTSZ_DEFAULT);
 
 	if (igc_is_device_id_i226(hw))
-- 
2.34.1

