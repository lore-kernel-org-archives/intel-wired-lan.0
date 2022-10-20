Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24705C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 20 Oct 2022 14:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5A4241995;
	Thu, 20 Oct 2022 14:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5A4241995
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1666275041;
	bh=1Mtla5flVgL/8hw39fcwP6NH/CXH7Tc6EIWILVWqfCo=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=Tj+h0ofosBJbq+qXY/OWRPdAO+4mBgAIVXmH+jgPJMyCSbfevA0qQ+9RbS+RKPt0G
	 HB/NsCNChy3Tol0xcJIKtECypfhf512pI76Yk8OtX6nYo+9kEXnTXrc6tO6b4wjau/
	 4s9DejQC9KfFU1etoamJtE5ej300P8paZQA9L6+g1iigwyH24I52mJ5CJ9oeaNl4FC
	 6KPG30kjQNuJngXkCMV7GyfFzlQnMhYTsswwu9+ULhomqW9SqPiKbvOwSwbNmBC3ot
	 GjrgoO6q1kQS/iNnmTQjo1SA55BwTcwvUaGUC1M9hcO9KfUXxjBqDb1iUSVO1nZClh
	 OdYika+F5KThg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQsS-TrKQNfs; Thu, 20 Oct 2022 14:10:39 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id C3E9941BDC;
	Thu, 20 Oct 2022 14:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C3E9941BDC
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 2D4681BF316
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Oct 2022 03:36:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1439060ABA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Oct 2022 03:36:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1439060ABA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ISr4JRZ5e2lN for <intel-wired-lan@lists.osuosl.org>;
 Thu, 20 Oct 2022 03:36:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E0E38605A9
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0E38605A9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 20 Oct 2022 03:36:56 +0000 (UTC)
Received: from localhost.localdomain (unknown [223.104.21.35])
 by smtp1 (Coremail) with SMTP id C8mowAA3J3vEwVBjI1EnDQ--.34714S2;
 Thu, 20 Oct 2022 11:34:49 +0800 (CST)
From: xiaolinkui <xiaolinkui@126.com>
To: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, xiaolinkui@126.com
Date: Thu, 20 Oct 2022 11:34:25 +0800
Message-Id: <20221020033425.11471-1-xiaolinkui@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: C8mowAA3J3vEwVBjI1EnDQ--.34714S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryUZw45Kr4xur1xGFWxJFb_yoWfXFb_Wr
 1I9F1xWrW5GFnYqw4jkrs7C3yYkFWvgr95uF9Fq3yrA34DZw15AFyDWrWIqr4xGr4fAF95
 A3W3tayfC34rKjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xREWEE5UUUUU==
X-Originating-IP: [223.104.21.35]
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/1tbiHBug1lpEIOLkJgAAsv
X-Mailman-Approved-At: Thu, 20 Oct 2022 14:10:38 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=126.com; 
 s=s110527; h=From:Subject:Date:Message-Id; bh=NF524UiF1Rlho55kpZ
 ccnpG59hTNeQeOGBdNsC+P6/g=; b=jJ6eKhhsww5+aks+p7x/rHUPb0+ggdofaP
 rVATIC/Fgf6K9Qbb0FyWfduSE9OL77ihCAstUHxIr2f2CsYCtbaLXseYBuDGlzZD
 Y2nIROrJj6OxxufXS9gaNyn0ZGBNCZCDMk3rkSeVT/rGwwau7d30brUBAldpFCc6
 HyojH2CBo=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=126.com header.i=@126.com
 header.a=rsa-sha256 header.s=s110527 header.b=jJ6eKhhs
Subject: [Intel-wired-lan] [PATCH] i40e: add a fault tolerance judgment
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
Cc: netdev@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 intel-wired-lan@lists.osuosl.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Linkui Xiao <xiaolinkui@kylinos.cn>

Avoid requesting memory when system memory resources are insufficient.
Reference function i40e_setup_tx_descriptors, adding fault tolerance
handling.

Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d4226161a3ef..673f2f0d078f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1565,6 +1565,9 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
 	struct device *dev = rx_ring->dev;
 	int err;
 
+	if (!dev)
+		return -ENOMEM;
+
 	u64_stats_init(&rx_ring->syncp);
 
 	/* Round up to nearest 4K */
-- 
2.17.1

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
