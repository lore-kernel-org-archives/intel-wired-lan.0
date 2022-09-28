Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E718EC04A95
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Sep 2022 22:41:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 781E44023B;
	Wed, 28 Sep 2022 22:41:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 781E44023B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664404899;
	bh=uhAKJSz26QAC0Wsk+Ozu7Dv+nv/lzdwT1iv83izlUiE=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=2FkQYLHcvqAQqjHanhmWh7A9SyWhhYgGazapdgzUcTXR+kWOVe0I4XqU+5Rp4nPdj
	 9KutBV/FigoiOEJhixTxhRSBrg/e80Pf3ZoIA+Wp+XjeQs7FHBc8YYfM2lPBVANLwr
	 bAQu0una1naXEPfA3jmGIJ9tFWH4Vqx6ePLaAXhD1ss+mDigjr441YN39rlZigOojk
	 ETR6Qo5jQc3t1s2JWvHPtyVT9qvJgXYRRVtlNsr/XBzmoD57RR5DPhvXqCFIClifMr
	 Ful6w0nxl2+xoz0ScQupY/oMeSGWRXpPIEBQx8CxVuwPIUVAfeTJeztsffGVYz6kwy
	 jSxVw0wDQzyEA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zXOhkaaREAqk; Wed, 28 Sep 2022 22:41:38 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6B1B140AD9;
	Wed, 28 Sep 2022 22:41:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B1B140AD9
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 87B151BF2B5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 22:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6D924408AC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 22:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D924408AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mFpbXVeOJ4MX for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Sep 2022 22:41:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04DC640895
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04DC640895
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Sep 2022 22:41:34 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="363575750"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; d="scan'208";a="363575750"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2022 15:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764469735"
X-IronPort-AV: E=Sophos;i="5.93,353,1654585200"; d="scan'208";a="764469735"
Received: from avenkata-desk0.sc.intel.com ([172.25.112.42])
 by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2022 15:41:26 -0700
From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed, 28 Sep 2022 15:42:10 -0700
Message-Id: <20220928224210.813061-1-anirudh.venkataramanan@intel.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1664404895; x=1695940895;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OULDAti2/csyXeh/DajE9Kr5+qhgeL+Y0H8rjZKp4t8=;
 b=hKsJe0qsAddGQZzccTijRNhnzyrPUKTwr7JQyzEi4Mhr9u+Jvj8M0o/o
 JobK2UTD8LLBzR2u/6xKeAxkNtMeQuY4zzGMxOLBftUjEqdZPEYRAL5Nl
 qgWasqpfyYbZVYfpYf3aNlJ7fs2I93vvMnotZ3FBWe3aW2yxabgD275mJ
 ShQLrnOE8muB9Z8laJK5AdEKELMVtQx1vh06VGVeHtrfbrrW93yvF2PGn
 S4Z5dTCd9TQZFBW6qcMsRRnmMMsJNjfg1cx/UVo01Suio35ploCcWbmiv
 0SMMyHZqhfp1bhJReNFVxvRPre1lKBDZKqgZ1xXhkNVZy9J58e1Wi2UbI
 A==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=hKsJe0qs
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: Remove local variable
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Remove local variable "match" and directly return evaluated conditional
instead.

Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index e88e3df..365a65d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1960,18 +1960,13 @@ static bool ixgbe_check_lbtest_frame(struct ixgbe_rx_buffer *rx_buffer,
 				     unsigned int frame_size)
 {
 	unsigned char *data;
-	bool match = true;
 
 	frame_size >>= 1;
 
 	data = page_address(rx_buffer->page) + rx_buffer->page_offset;
 
-	if (data[3] != 0xFF ||
-	    data[frame_size + 10] != 0xBE ||
-	    data[frame_size + 12] != 0xAF)
-		match = false;
-
-	return match;
+	return data[3] == 0xFF && data[frame_size + 10] == 0xBE &&
+		data[frame_size + 12] == 0xAF;
 }
 
 static u16 ixgbe_clean_test_rings(struct ixgbe_ring *rx_ring,
-- 
2.37.2

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
