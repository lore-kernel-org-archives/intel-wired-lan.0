Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF171C4167B
	for <intel-wired-lan@archiver.kernel.org>; Wed,  6 Dec 2023 01:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66B0A61429;
	Wed,  6 Dec 2023 01:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66B0A61429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1701824511;
	bh=v3PbowOQDgFy36TDufSX6LNA97gRgVXn0ml1bRVzwNw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XgaAUIJ27EPKPV7b6520BPP7yM8COY2K6GnV/xLxcsS7300fgY/CIlBNF4yBHVtcr
	 h2sLSolugdHm5Sw1hd9M8SsLDabcLUCXoZs1J32Y0BvZxVqFCFnq5oe5zq1kw8g+iX
	 gSDQzDn9H/QTgmU+Z8QTpS61VR2KNqFyJpOuKEBhSatkX723iFMeb8ChEpVzLE+x7r
	 LtTZ0PiOp8jrzGM56PiM5OzEo5QdtPymFnNETrpoi05ILDtfpVs3II+xUQH+Hc4UvX
	 koImGDAhGDPFJy9+iTtD78dkrUPeh/ei2/cKpyEffL8j+EsiSu5mPiSH5BvGXL/SOT
	 7QHvBQESG9IFg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zSAi8BV14KPJ; Wed,  6 Dec 2023 01:01:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77FE86142B;
	Wed,  6 Dec 2023 01:01:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77FE86142B
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 1D9DA1BF97D
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 01:01:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A647182C35
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 01:01:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A647182C35
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dEIJGzmyNR3T for <intel-wired-lan@lists.osuosl.org>;
 Wed,  6 Dec 2023 01:01:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C1AD882C18
 for <intel-wired-lan@lists.osuosl.org>; Wed,  6 Dec 2023 01:01:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1AD882C18
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="12700304"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; d="scan'208";a="12700304"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 17:01:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841655262"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; d="scan'208";a="841655262"
Received: from jbrandeb-spr1.jf.intel.com ([10.166.28.233])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2023 17:01:33 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue,  5 Dec 2023 17:01:07 -0800
Message-Id: <20231206010114.2259388-9-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
References: <20231206010114.2259388-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701824495; x=1733360495;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kvzei3+ovK/51i0s2+v6v/D+4CvRA9trUDjXetYyV9U=;
 b=GJaO2ZE3053Zg3SFKPuVijUoupQiDwJewGitvjQWEgtbMW0tvctK80qn
 Ps7sXZOFsTrlNGC/YD13H3ZStWN353RrW+x1PgWZDh7lB79tCHl2d/YMh
 fQXwU8aJs5GIAvHGfq/vqrhMmDeXhbHxYtI8+yhdr6GilOWaXnmxeTK0F
 jhsnOF/hiNnF6/B/yj67cCFYUUSVd+pKe0JHOCGeVD1f9mGZkBqrPL/TH
 TkQT96pP+OU0qzMGTpH6KerliCFnDesljVYjZwaaRv7pp5ki/DgEXaWfO
 5C18+rWx5hyd9zjEhOyRDqyT9xF0kCzKLl7pFUc7XYh/NvXAgO4MbN53O
 g==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=GJaO2ZE3
Subject: [Intel-wired-lan] [PATCH iwl-next v2 08/15] igc: field prep
 conversion
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
Cc: Sasha Neftin <sasha.neftin@intel.com>, przemyslaw.kitszel@intel.com,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, aleksander.lobakin@intel.com,
 marcin.szycik@linux.intel.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Refactor igc driver to use FIELD_PREP(), which reduces lines of code
and adds clarity of intent.

This code was generated by the following coccinelle/spatch script and
then manually repaired in a later patch.

@prep2@
constant shift,mask;
type T;
expression a;
@@
-(((T)(a) << shift) & mask)
+FIELD_PREP(mask, a)

@prep@
constant shift,mask;
type T;
expression a;
@@
-((T)((a) << shift) & mask)
+FIELD_PREP(mask, a)

Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Sasha Neftin <sasha.neftin@intel.com>
Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
v2: no change
---
 drivers/net/ethernet/intel/igc/igc_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 61db1d3bfa0b..d949289a3ddb 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3452,8 +3452,8 @@ static int igc_write_flex_filter_ll(struct igc_adapter *adapter,
 
 	/* Configure filter */
 	queuing = input->length & IGC_FHFT_LENGTH_MASK;
-	queuing |= (input->rx_queue << IGC_FHFT_QUEUE_SHIFT) & IGC_FHFT_QUEUE_MASK;
-	queuing |= (input->prio << IGC_FHFT_PRIO_SHIFT) & IGC_FHFT_PRIO_MASK;
+	queuing |= FIELD_PREP(IGC_FHFT_QUEUE_MASK, input->rx_queue);
+	queuing |= FIELD_PREP(IGC_FHFT_PRIO_MASK, input->prio);
 
 	if (input->immediate_irq)
 		queuing |= IGC_FHFT_IMM_INT;
-- 
2.39.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
