Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E53D358DE
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE2583DA3;
	Thu, 29 Jan 2026 08:08:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mSsX9oNouS1R; Thu, 29 Jan 2026 08:08:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFAEB83DB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674130;
	bh=OpZ1gwbVGlI8sx3pS0dUi5KsatfJbLeR6qF630EI5zI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WtRvzg5QxbfQBdGU/IsgnTMzIWULE+TrW5O1JbvtGNlRWxjjk/5z08kykQHe4CBlD
	 n5dsGv+PJi9ORoxOfaLFiCoQwniEr75VqNEwKLi5idCaytaJkD0c/UW1bB1d4OJ1b3
	 onQOENJK9hZzs4WaIdDzRDqx7gWIJsFgv6/CgwhTCEoDIyGZqXakD18OjhgvtrgPEq
	 nVJv13pFdiwe5P85/Y7hIYRqxfwUeMG21t2W5MvuyztZ4yBYjWD/qcLExQ/b1AFOJv
	 scGu4wC/0M2QORg3ezDWG0TLTFjBZ9tTqmpKeh5STOBYtzCdM17FZlBKHm6cW+CsJD
	 U0xShVIgOtZ2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFAEB83DB1;
	Thu, 29 Jan 2026 08:08:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A4B31BD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E72E40292
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0EtF0Jjs_i_i for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 41C6E403C4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 41C6E403C4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41C6E403C4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 508074455B;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1810FC4AF0B;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4n-0000000ERO5-1O5T; Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:08:15 +0100
Message-ID: <053367b7bf66f07444b45790db0e2b1998d3a3fe.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674111;
 bh=jXKyTJKBXMc1s7NB0MjWyQ30waz0m2moRL2HWFXUGcQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=J7PkFnqwl2NyEeDLu1PjLukhjjtiF+Ro2e05fbSOt0bbYe/La5snvMsV/XSZp0/kW
 7tRFxouHgJdH9LNlXIjiRrXisPkCjbjbWU9X1TqnPD/6OWGeQnW+BE9DSIENFTYMF/
 4S4+ZvgncMp8Y9a3LrLSBQnR6jUE4VacgREmd58LhtEpvytSPSjgZrw9MvJVRAzHad
 bdu1aKJI4bLQ8C59UsWBAeaFD3L1LyrHoTj93SSsJE3mrYLitlkoBHoa4XSIJKmrm/
 6a0A8riOd4DXnNvl8SDpJ06A4ULLZT/BFl63zJyP1oHt86G3GO6DqRXRFLKKrrHh2a
 QuIqETItOATxQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=J7PkFnqw
Subject: [Intel-wired-lan] [PATCH v3 24/30] docs: kdoc_re: fix a parse bug
 on struct page_pool_params
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
---
 tools/lib/python/kdoc/kdoc_re.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 858cc688a58f..5f455ffff7b2 100644
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

