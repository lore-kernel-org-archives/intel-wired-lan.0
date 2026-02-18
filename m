Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD447E9A047
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2886607FD;
	Wed, 18 Feb 2026 10:13:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fa9EFq2-LyE5; Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58BEB607DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409615;
	bh=39GdJGyOvS/cxrKN4fNqdfA6j4Cc6KRIX/QkB2f4X9k=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTHxtFi4GjUeJSFqFGgJf8gPqKbXPcz0aBHRqi69UznSm6A14pJXBwe/gTEbJqedz
	 BZI9qEgGIgDZq98m0M8HQPrcPEDOUCMS84FETep/Aspd8Q0DGhse4V9zCMOVyP07cZ
	 PAkQ5GwKWtwJ7HpNL3ncFmf5c8vRHNpz1FR50tiNqPWng5RRb+rZfzAvcOOj+Y5CP3
	 +DT/8mxUTeegwqKKUxOw+6WNp8k7tK6DAZX4LTBm0AOCPOppi0msQS2Q3YC6xTldyh
	 /NYKYYJb2yssuyAuAa6G2QvTRNCZUPZFfmJoaEJEg6j1HL9H0x0zeMU4w2b8J7rd1f
	 FInKgEJmrLRXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58BEB607DB;
	Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 642E371A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49C148109F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n4-GP3i8024s for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ABF6F810A0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABF6F810A0
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABF6F810A0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 71F5944578;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC54C19421;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYe-00000000Lkk-2R7d; Wed, 18 Feb 2026 11:13:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:52 +0100
Message-ID: <db9a6339a339b203a474acc2ee9f56da1227a186.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409606;
 bh=HfA9d8T9A4lV+0318XofpC8IU2OubqTIaLYGnkL8N/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ppwqRnrjYO15gyib+5lOd1ODAKoyy3cbzAvuXAwJPFrtNqICxs3RAC8jYSWdmmMdZ
 ql7Usz87PIjZt1BVES3WLc1Jj4pNfTEZLv8XV5SqztnYc1eHRTBn4hx2uB4NEoXCdg
 BAl0ju2sz5gzWXVg6z9PQRha+zgKsZDZ6sAQG6u9Ey+DiUc4x8kzFfKnqpsBmK34Uc
 7Boeesp9dD3r8quVIBzIUTC08TavKn/9m0lzBTcLixRwha1kN2HTwjcbroCcCJWJg8
 ZNDQWYA2OvsPR++OMK/uvlCU2VWvEb5VNKhUXqp6CFfZSgDFp2yG43H10+9pxnrtx6
 8+c6fmRkMdKNQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ppwqRnrj
Subject: [Intel-wired-lan] [PATCH 22/38] docs: kdoc_re: fix a parse bug on
 struct page_pool_params
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

The struct page_pool_params definition has a private
definition on it:

    struct page_pool_params {
	struct_group_tagged(page_pool_params_fast, fast,
		unsigned int	order;
		unsigned int	pool_size;
		int		nid;
		struct device	*dev;
		struct napi_struct *napi;
		enum dma_data_direction dma_dir;
		unsigned int	max_len;
		unsigned int	offset;
	);
	struct_group_tagged(page_pool_params_slow, slow,
		struct net_device *netdev;
		unsigned int queue_idx;
		unsigned int	flags;
    /* private: used by test code only */
		void (*init_callback)(netmem_ref netmem, void *arg);
		void *init_arg;
	);
   };

This makes kernel-doc parser to miss the end parenthesis of
the second struct_group_tagged, causing documentation issues.

Address it by ensuring that, if are there anything at the stack,
it will be placed as the last part of the argument.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 05f36d665b70..cdc842f5fc8f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -201,6 +201,9 @@ class NestedMatch:
         """
 
         stack = []
+        start = 0
+        offset = 0
+        pos = 0
 
         for match_re in self.regex.finditer(line):
             start = match_re.start()
@@ -250,6 +253,11 @@ class NestedMatch:
                         yield start, offset, pos + 1
                         break
 
+        # When /* private */ is used, it may end the end delimiterq
+        if stack:
+            stack.pop()
+            yield start, offset, len(line) + 1
+
     def search(self, line):
         """
         This is similar to re.search:
-- 
2.52.0

