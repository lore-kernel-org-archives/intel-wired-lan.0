Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FADC44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 08:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D65440684;
	Wed, 15 Jul 2026 08:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZBisBUKDo8H3; Wed, 15 Jul 2026 08:27:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC40C4067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784104048;
	bh=/i/S6+I3OZ6MoEmGhUzQo3sY9bpnI/3MGwofuQD07JM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rf9/SrLLeUVEnaqS3z0PZZzErsfZ6V2kqYVBeH9hBZr3VU0gLKgZrc+Eg+/hTTmL7
	 MV/czoWehgaCGVlkgH57ZezrRttAG/Wsk5oINu7pwqPnQkTV97q8LPEayOIFGrcfny
	 +xsPEWqyhcOQHAz00CsSCVvC8b10J6/Yy6+LpFMidP8yXsTGdW+c3PQCE9sb7s41lU
	 R31RDdndSVbHuWWyesYqvh/TrB/3ixooi0slrAXalgndttk1DpJvDTJxQkBEd1LG/+
	 EVZL1iy3ondJGlPO12hBwejoxa+oqJRoXzfSc3e5xRpcuFVD75EQ08TO4TmAKUA61L
	 2vT0xlOm+D8aw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC40C4067F;
	Wed, 15 Jul 2026 08:27:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E877203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0AC7480DA5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:27:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NtPXnQenNV9A for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 08:27:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.189;
 helo=out-189.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4640380DA1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4640380DA1
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4640380DA1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:27:27 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jagielski,
 Jedrzej <jedrzej.jagielski@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Mitch Williams <mitch.a.williams@intel.com>,
 Greg Rose <gregory.v.rose@intel.com>,
 Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
 netdev@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
 stable@vger.kernel.org
Date: Wed, 15 Jul 2026 16:25:47 +0800
Message-ID: <20260715082548.56687-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784104045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/i/S6+I3OZ6MoEmGhUzQo3sY9bpnI/3MGwofuQD07JM=;
 b=gMvU5E+BoQXinDcxY0VE9NNWOgIOTiXhFBa0QAVqn2HVe2M2IdvyiKn2etcgQ7QO6ijOTf
 IxQsp6m2F5+VgZSYoZjITzsWJrfmmuXRq7eq2LN3NCJjKCKL5TXytUNCrr/KfeSQ8MrAdp
 Nb7QxbQ90AQ//0ugFSg0gorNv/46jdU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=gMvU5E+B
Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/2] iavf: fix ASQ command
 buffer leak on init failure
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
unwind path elides cmd_buf while freeing the other allocations.

The ASQ count is not set until initialization succeeds, so the shutdown
path cannot reclaim the buffer. Free cmd_buf in the common unwind path.

Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 6937b7dd44cbb..40f76f9507f4b 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -60,6 +60,7 @@ static enum iavf_status iavf_alloc_adminq_arq_ring(struct iavf_hw *hw)
  **/
 static void iavf_free_adminq_asq(struct iavf_hw *hw)
 {
+	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
 	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);
 }
 
-- 
2.43.0

