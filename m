Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A9C001B0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Jul 2023 10:20:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 94F8260B73;
	Mon, 24 Jul 2023 10:20:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94F8260B73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1690194020;
	bh=8Hhqwrw/9iyLdPDxtzttmIXnIn/HvYWn3qBrGKPTahY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=dcQmvvhmK0ZMY4p0s+vQfbNXQEzBNhNiCd9FKTaGVnJPx/kqiQ64XBZqIAN2l/P8t
	 yCX6pPbB6XrACVta20fMBM+ZJtZRmUsqebdCYYhBWHlChufJMPqXrYO36PRlQX04m5
	 BWv7lhhLyCw2WuH3A0VPAiO/n4fxYpdUKAtnDW/X0lobJbspdmLfouDs0usTJkbh6P
	 3O+RA3BmPyuKjD5gd202b+kJjJhmK4sMja4rVsjOx/8QctNJHwh/f/MmogLCPOJmTw
	 ovhchN84K4/IS8M/8fXHK62C17mgEaGpfCWwTKmU2ff1yVthM81jymqhAXagN2Lonr
	 uc5UVTeXtwbag==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZRulUBn7kZF; Mon, 24 Jul 2023 10:20:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id A63F360EAA;
	Mon, 24 Jul 2023 10:20:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A63F360EAA
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 8D2351BF45A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Jul 2023 10:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 654F960EAA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Jul 2023 10:20:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 654F960EAA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RElLlbK27cf1 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Jul 2023 10:20:17 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 24 Jul 2023 10:20:17 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B384160B73
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B384160B73
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Jul 2023 10:20:17 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367428235"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; d="scan'208";a="367428235"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2023 03:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="972206778"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; d="scan'208";a="972206778"
Received: from gk3153-or4-r750-36948.igk.intel.com ([10.102.19.252])
 by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2023 03:13:09 -0700
From: Olga Zaborska <olga.zaborska@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Mon, 24 Jul 2023 12:06:20 +0200
Message-Id: <20230724100623.79886-1-olga.zaborska@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690194017; x=1721730017;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DHBTLSs3z5tZF13kV/u8tC/3dwxEvB51vMJtvDi6Rak=;
 b=ggJK99rQJ6WMo4kCU6lua9AjNhgvXpCtd5e349TsYu31KTRVx8Gqq92G
 xN29iYsle2aIqmpyJZi+kM3TMDixBheA1NxCddgSKrToKMYki4Ub0H2E2
 mxxWQOUrFfEElwNKdK2wNsjjRoGJhjvW6TzBlI1tTHnLHS66P1bFF3nae
 nzdVMlp6jG+r2G9V0BbBtdG02PxeRDzypbTXeAOG4NmAN2hZyDU/ojNui
 HCh0HbslQXUUsWWrmON+jtHiHDabExYMbcayqXOgoaYZKdH5wvGuWR5w8
 ptbhcg9yd3a1OjA3a7foLJkum2hQDvJU6DFIfxj66rYhqfdAbJadcaobv
 w==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ggJK99rQ
Subject: [Intel-wired-lan] [PATCH iwl-net v4 0/3] Change MIN_TXD and MIN_RXD
 to allow set rx/tx value between 64 and 80
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
Cc: Olga Zaborska <olga.zaborska@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Change the minimum value of RX/TX descriptors to 64 to enabl'e setting the rx/tx value
between 64 and 80. All igb, igbf and igc devices can use as low as 64 descriptors.

Olga Zaborska (3):
  igc: Change IGC_MIN to allow set rx/tx value between 64 and 80
  igbvf: Change IGBVF_MIN to allow set rx/tx value between 64 and 80
  igb: Change IGB_MIN to allow set rx/tx value between 64 and 80 Change
    the minimum value of RX/TX descriptors to 64 to enable setting the
    rx/tx value between 64 and 80. All igb devices can use as low as 64
    descriptors. This change will unify igb with other drivers. Based on
    commit 7b1be1987c1e ("e1000e: lower ring minimum size to 64")

 drivers/net/ethernet/intel/igb/igb.h     | 4 ++--
 drivers/net/ethernet/intel/igbvf/igbvf.h | 4 ++--
 drivers/net/ethernet/intel/igc/igc.h     | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.31.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
