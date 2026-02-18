Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085F4E9A04C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE664407F2;
	Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnV-XUieq8um; Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF8C9407F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409610;
	bh=sJAscFD1aP8LHoL2Gm0SAHdhyDXWzkbbK1fwSJNCxLQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hgOCUB9ejJqaDN/JcypBiPaprBuO83z9nuUUdZiPijoZsGc639IzPTQqGdDmVoGAq
	 MFE81v/gxr5Eeho+Iqx600OAOdehjQENGj4xmJiL22GCxUbQkQ4Maad0w6MY16EnCq
	 McrEntX7/+Clc0gqEFm4lXBjMaE0HhiqKHfQzVovPzfdH1RsIUBqpBS6iqjvTdU2PG
	 mX5cr3X3u5MRMlLD5OADTIwmJyojn9Q7UoDwBda071GEESfMLuCRQ4Sznz2r5WJzGV
	 efUXfaIFmUNT+4ShBmKWu4oVcldjyVjKJLUTy7oSoApRgtm8IQlYbElUxel/gpAx7P
	 kjldOcTFBtEOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF8C9407F0;
	Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 489EA35B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3AC0D81091
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iczSr6hNWKOH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8459081095
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8459081095
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8459081095
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B51F4454C;
 Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F518C19421;
 Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYb-00000000Lar-0nUE; Wed, 18 Feb 2026 11:13:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:44 +0100
Message-ID: <7b7809ce8ee561e6023a82288e3c429e9a1889d2.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409603;
 bh=Z36YMV6EMn5rFyaqYGer/gsooo6w2VF9hIyZNnrWbgI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UZ7ngsvQWV+yF2K49kxsi+ciJK1WcKwWLhpRYok7EriWqUsYG1+ZzzpC98QV/LN3l
 x1hg94t3i7+rNvR3dLhbArDLu2YMg6Cgz4wHjYx5dP8V0WxTHPZP8ZxxOLS9t+WgD+
 IIL/0twb+1YWHTgo+zBwRvaDxbQ92NJA22djnbAntcGyyhFRJ5Sd61HvkRTxrrMNqw
 4rjOQAdWYdQilTEDOk3Lg8PZk+Oz0dEsSm8vVUfAY+OOhu5/krsuTYIqyCIsFEddnB
 Y99GPuDA43lOC6jikWdLaKoGWyHrIxSWs1EgSCCXQhcFxXbcTcE2mT7CdzZUy1Ieel
 /lQQzVLhf79MA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UZ7ngsvQ
Subject: [Intel-wired-lan] [PATCH 14/38] docs: kdoc_parser: handle struct
 member macro VIRTIO_DECLARE_FEATURES(name)
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

From: Randy Dunlap <rdunlap@infradead.org>

Parse the macro VIRTIO_DECLARE_FEATURES(name) and expand it to its
definition. These prevents one build warning:

WARNING: include/linux/virtio.h:188 struct member 'VIRTIO_DECLARE_FEATURES(features' not described in 'virtio_device'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 6fe2fa032900..32a30851db08 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -152,6 +152,7 @@ struct_xforms = [
             struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+    (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
 ]
 #
 # Struct regexes here are guaranteed to have the end delimiter matching
-- 
2.52.0

