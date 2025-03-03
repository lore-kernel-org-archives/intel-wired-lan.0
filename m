Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBD4C282C5
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Mar 2025 10:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50CB54096C;
	Mon,  3 Mar 2025 10:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s-nvdyq2QlcN; Mon,  3 Mar 2025 10:28:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C8F5240958
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1740997705;
	bh=ilQ0fw2/vsFSHPIaJHUprOHSCd3tNvnLIMU/9tgEHV4=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XdsU2B+CHBmCKlCPqzwE8PogkYt6Mfs/Q4iLmMllpDijCz5B3NDvWa70o6WWsVmOW
	 euX+jaWprvbICXCulFJUDXGKAccC79mFcLwt60KPcJc2LkizCHkrH37rdXO9zQlfyA
	 PurQI2J6Ke94xoamOrhvej8BHJ079yK03O+vmXora0NEtaWO2ab/ki+/0ihpJUUQgO
	 n62QO7mUqcfaitVfTB5N76srj6eFJbTY4XipaY6h+8krMkwE5c/KWBrtUnhlHw2KzK
	 Ip9McA4fdToi8gMh7kgPZE8Jh26ofVHlfpq0jew1iVxaAKHOXqpbmZb1we2R+Y60fZ
	 MtTK2TeO/X1jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8F5240958;
	Mon,  3 Mar 2025 10:28:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64FBDD2
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 10:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 50929409FF
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 10:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i_cYb7DoPmrM for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Mar 2025 10:28:23 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9;
 helo=mgamail.intel.com; envelope-from=faizal.abdul.rahim@linux.intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3D11D400C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3D11D400C4
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3D11D400C4
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Mar 2025 10:28:23 +0000 (UTC)
X-CSE-ConnectionGUID: ILAXNsxiQQyUZEfM6Xdtmw==
X-CSE-MsgGUID: C4nivzEyR3uu11bDaDL7Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="64310239"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; d="scan'208";a="64310239"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 02:28:22 -0800
X-CSE-ConnectionGUID: w4pCy+ifSdmjYRxSLDAKCw==
X-CSE-MsgGUID: WMXFEbW1SyugSAw2veHtzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; d="scan'208";a="122569912"
Received: from mohdfai2-ilbpg12-1.png.intel.com ([10.88.227.73])
 by fmviesa005.fm.intel.com with ESMTP; 03 Mar 2025 02:28:15 -0800
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Xiaolei Wang <xiaolei.wang@windriver.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
 Jesper Nilsson <jesper.nilsson@axis.com>,
 Andrew Halaney <ahalaney@redhat.com>,
 Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Date: Mon,  3 Mar 2025 05:26:56 -0500
Message-Id: <20250303102658.3580232-8-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
References: <20250303102658.3580232-1-faizal.abdul.rahim@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740997703; x=1772533703;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=naH9KspwalUC4SIxcxcdhcuCdSPyeBw7+LL7ZKcyavQ=;
 b=ib8K1KKmZHBkCl8J4dcdi0vDFYoFdmwD7535Z8CoHYHgqiIaHknlLu1Z
 jee3/IwNpgJStDmrf3kSQyCMuCGPhUBsh0LsTfO9UFejgIoySJvj3xMfV
 cbSB6qqhtlP0nJBcF72JrFormj7WMhYgkGrsqIVcnCJcdeTEA4UW+SyKD
 t9b5ZmY/s7RmBkdU8IZ4CvKZ4oTGWzmxLQ2+2yPTXyXLuE5/0JfbEOBwk
 xby8NVA+LoZ0vGP+DkO30hWaUS/wJBmqVplMl69CdIDhRHKQ/c5SS3wql
 EUMPHjz8tHSnJEwQIOVFe5KUurrj588ofCRvXc3aev8/3dAcGl6qwYLdV
 w==;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=linux.intel.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ib8K1KKm
Subject: [Intel-wired-lan] [PATCH iwl-next v7 7/9] igc: Block setting
 preemptible traffic class in taprio
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

Since preemptible tc implementation is not ready yet, block it from being
set in taprio. The existing code already blocks it in mqprio.

Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index fc086919387c..319eeb5b0a54 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6407,6 +6407,10 @@ static int igc_save_qbv_schedule(struct igc_adapter *adapter,
 	if (!validate_schedule(adapter, qopt))
 		return -EINVAL;
 
+	/* preemptible isn't supported yet */
+	if (qopt->mqprio.preemptible_tcs)
+		return -EOPNOTSUPP;
+
 	igc_ptp_read(adapter, &now);
 
 	if (igc_tsn_is_taprio_activated_by_user(adapter) &&
-- 
2.34.1

