Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3859BE9A03E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B6B2407B7;
	Wed, 18 Feb 2026 10:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ONTQtpWxYWUU; Wed, 18 Feb 2026 10:13:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84EB7407F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409616;
	bh=bYIumUm4/6I/80YT9R2kLqmdI6rJpcXbxrwNY1yYz38=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O3BWaFXcfbjZvsKPOZE3v085sHA32gjRmEaWS40+CHjtKQ24FnQAh3r+irYMqgMdM
	 d9oFIZPrVVi1Y+N8/R3eM4H+CftOywUmtKXh3G861B81M/wSlqeNsWOMF6iH/5x8Ab
	 GiFHzU8VMU5pBXgwbZMTHHSKbyvhRPShcqiNU4/cgN/8Nqt+drM93y2VBPAmdQnPzC
	 MNphbV/k0cvkj3l+jbm7mlkD50VByJtVgJoAkwJHum9YJDJmar+IRQednNFrXfCX+z
	 kDTVkbc2rT9OfWQVSnux4ISkppIiVUfPK0gWVVKNEyEtdJ+7y491FOvYFFDWFbm1dg
	 l88ewJ2/1VOZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84EB7407F9;
	Wed, 18 Feb 2026 10:13:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23FFD438
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A0A7810A1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7EGmX8OQRXmF for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3F298810A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3F298810A2
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F298810A2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2A2376185F;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A9AC19421;
 Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYe-00000000LjY-0ayj; Wed, 18 Feb 2026 11:13:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:51 +0100
Message-ID: <0f5400a1573288f9e0d48c34954ac9e769f83aa3.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409605;
 bh=pTv8fyARiYUzN0SDULk8va6HhWxLlLCbC3eYwm4RiCo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P3ChlR4bTE9lXd1SFNrL/stGx3aof4/2iZ+R4z2npTsJJzrL0y7iSZcs0aHf69M7Y
 YpCuS5UxLto9x8LI8zDheQxYMNMKWMBNpFxFfsaWt3S3rZXT32cXhmWFFfwQrXBnsU
 GP9d9Yv6BEakf0VD86lH4RNMBJVm8dphzPXA8UFwK10Dv5t0S/PRpA7JZEElgvHNlA
 sm1RyZwr3P/r4ntFzHfvJ3MSo3EbhNS/2fkf5EdJjwx/gAVfVisFqk2S0sYBXk5xYv
 ZL0xw8/GQuqQjXrjcIwF7GsUm3MiycxfP60XQYz+KcQzPLI3g+DsGjocPJzg6+N7P+
 m9x6Zhlxw5l6w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=P3ChlR4b
Subject: [Intel-wired-lan] [PATCH 21/38] docs: kdoc_parser: better handle
 struct_group macros
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

Instead of converting them on two steps, implement a single
logic to parse them using the new sub functionality of
NestedMatch.sub().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 06a7af4bfa57..b63a70f184eb 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -124,10 +124,11 @@ struct_xforms = [
     # matched. So, the implementation to drop STRUCT_GROUP() will be
     # handled in separate.
     #
-    (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-    (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-    (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+    (NestedMatch(r'\bstruct_group\s*\('), r'\2'),
+    (NestedMatch(r'\bstruct_group_attr\s*\('), r'\3'),
+    (NestedMatch(r'\bstruct_group_tagged\s*\('), r'struct \1 { \3 } \2;'),
+    (NestedMatch(r'\b__struct_group\s*\('), r'\4'),
+
     #
     # Replace macros
     #
@@ -153,7 +154,6 @@ struct_xforms = [
     (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
     (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
     (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-    (NestedMatch(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
-- 
2.52.0

