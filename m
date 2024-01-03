Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5D5C3DA6E
	for <intel-wired-lan@archiver.kernel.org>; Wed,  3 Jan 2024 16:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1D3FF419D2;
	Wed,  3 Jan 2024 16:18:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D3FF419D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1704298697;
	bh=qbDf6mDOr5pUTTrGJy5r3HxwSzx5reuigJeU16xqtBs=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GS6i4e/V/Xcd2cBPMOmTMp9jCNY0XFKS00j1UOH63+OMIa1IcFe1soySfS97s49yE
	 x6KiisPFH03qLE9r13PCQh5ZgKoL/knrzhy/meCg+dc47GvW8OqZbbi1tz+xaVfWwV
	 slEwUa+ccxZMb5RVLSBQ/wP45sZ97EQwEFxH8NcvMgKzfbXhZTcR9F4HYuJTIdb2G1
	 VEDs6GljtyPNvPHOstfIbLan3AT1/4Sgk5W98DqdSKcio/+piKiIjcg6J0+PKL+kiX
	 C5Xmm1D/lpd5jShfOBjEwwXjXGV/nBQBhzoji1mPO2emX1lsXn2l+dDgT3mZP55MmJ
	 bhdvbfjQpsKBQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TmUlnpvq2WG0; Wed,  3 Jan 2024 16:18:16 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29FAD419DE;
	Wed,  3 Jan 2024 16:18:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 29FAD419DE
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 05C681BF95D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 11:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE77A41775
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 11:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE77A41775
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AMKF7e7rHCSG for <intel-wired-lan@lists.osuosl.org>;
 Wed,  3 Jan 2024 11:56:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B8FC417B7
 for <intel-wired-lan@lists.osuosl.org>; Wed,  3 Jan 2024 11:56:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4B8FC417B7
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="428169523"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="428169523"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 03:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111348081"
X-IronPort-AV: E=Sophos;i="6.04,327,1695711600"; d="scan'208";a="1111348081"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
 by fmsmga005.fm.intel.com with ESMTP; 03 Jan 2024 03:56:35 -0800
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Date: Wed,  3 Jan 2024 17:25:56 +0530
Message-Id: <20240103115602.19044-6-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 03 Jan 2024 16:17:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704283007; x=1735819007;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uUU6Aeoh21pgVprRQuKox95GRqR5aTWn9mMsl4N1jcQ=;
 b=iiEmb+Kqy/MbDN8a0g1iV0cMqRlr5nnJz94i/8a9SsHZ5uQS6p3o/DrN
 bCIMqnHKnbyoGr8zJnMwII+84Rmib3PuGbM448KsjI5VVqY7E08R18ACg
 pau1eEhZy2u8jpOAtLYq2fqjiR2GITeXnvYyB4QDbxTAaSLBaXTR8Gnqs
 gdw9bCNyuzhF0mN1gBA2vRoQmlRVnxYhiI5WEOmyGv4FVnKczRK+lAbKa
 Thzv0PxZN3rYnEQmH1o+6v4XeVuEhYs0DMsn56zW07birS67tgC18F/sy
 5SVw7sRJGraVAbjp3SNP3UqY31xGDGrc9LPUkSijOdywEvUfIxnYB4vUZ
 Q==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=iiEmb+Kq
Subject: [Intel-wired-lan] [RFC PATCH v3 05/11] stmmac: intel: remove
 convert_art_to_tsc()
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
Cc: christopher.s.hall@intel.com, lakshmi.sowjanya.d@intel.com,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, pandith.n@intel.com,
 x86@kernel.org, eddie.dong@intel.com, jesse.brandeburg@intel.com,
 linux-sound@vger.kernel.org, alexandre.torgue@foss.st.com,
 mallikarjunappa.sangannavar@intel.com, joabreu@synopsys.com,
 intel-wired-lan@lists.osuosl.org, mcoquelin.stm32@gmail.com,
 thejesh.reddy.t.r@intel.com, perex@perex.cz, anthony.l.nguyen@intel.com,
 andriy.shevchenko@linux.intel.com, davem@davemloft.net
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Thomas Gleixner <tglx@linutronix.de>

Remove convert_art_to_tsc() function call, Pass system clock cycles and
clocksource ID as input to get_device_system_crosststamp().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 60283543ffc8..e73fa34237d3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -390,10 +390,11 @@ static int intel_crosststamp(ktime_t *device,
 		*device = ns_to_ktime(ptp_time);
 		read_unlock_irqrestore(&priv->ptp_lock, flags);
 		get_arttime(priv->mii, intel_priv->mdio_adhoc_addr, &art_time);
-		*system = convert_art_to_tsc(art_time);
+		system->cycles = art_time;
 	}
 
 	system->cycles *= intel_priv->crossts_adj;
+	system->cs_id = CSID_X86_ART;
 	priv->plat->flags &= ~STMMAC_FLAG_INT_SNAPSHOT_EN;
 
 	return 0;
-- 
2.35.3

