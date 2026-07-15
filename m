Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664C6C44501
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 08:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2790940687;
	Wed, 15 Jul 2026 08:27:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INM1WNjY4NbA; Wed, 15 Jul 2026 08:27:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60ACC40684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784104059;
	bh=j5zxSO+IiC/aaC3ze1Xp0Plh4QW43E7b/Q2x8rCpqKQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=62LKjo0t0NW03NAN3zPmrrREO2ATPvwJscnfy4HpvASW00q94spMXapWYgt7D7SbH
	 hnqUtsJNknJLhUfOmt18mPfx4u9xlqYMaHv9/MgAau9+HU1tzGcQOxKvWlzPudxObv
	 V4AuTxZ1NMuzvyu9eTDa3CMryk9n0dSlF3raf7iFgcTgJb/M6Z2FilCUDJIjMF8vBD
	 P7FTp2KnjghHSGSLXuq3De0Kbh3OZp//AYoo9uNHJkuQoJr2+/HxtedQxndPanLKU6
	 +IxOEnBR822F+B3+yqFx6TCsk4+WJ/tj0ERERMgcWg38soU8vHvz8hCxxltqf97Lif
	 sqyGhkZqgSi5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60ACC40684;
	Wed, 15 Jul 2026 08:27:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 40C5249D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 328F540687
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:27:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TPdXwOEqmH_j for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 08:27:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.187;
 helo=out-187.mta1.migadu.com; envelope-from=xuanqiang.luo@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 59E3640684
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 59E3640684
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com
 [95.215.58.187])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 59E3640684
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:27:36 +0000 (UTC)
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
Date: Wed, 15 Jul 2026 16:25:48 +0800
Message-ID: <20260715082548.56687-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1784104054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5zxSO+IiC/aaC3ze1Xp0Plh4QW43E7b/Q2x8rCpqKQ=;
 b=YgBrBjyeXwATe4y8fj92081fvgvxwEYXr5EgJazBct+C6+8lAewYvYoAXJOWa/67RO1E/U
 XFHtLTq6c95SQaNnMdqNiwrd7TG9YAN2c/pGTWMNny0zwJGHuQVSxDY7W0hbi/F9rUxk6l
 c5rGR08p01eKodOsqpIxEG1JJJJVg8M=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=YgBrBjye
Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/2] iavf: fix QoS capabilities
 memory leak
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

Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
allocates adapter->qos_caps during probe, but iavf_remove() does not
free it. This leaks the allocation whenever an iavf device is removed.

Free adapter->qos_caps in iavf_remove().

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066bc..c7f69a9040588 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5589,6 +5589,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
 	kfree(adapter->vf_res);
+	kfree(adapter->qos_caps);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
 	 * hanging out there that we need to get rid of.
-- 
2.43.0

