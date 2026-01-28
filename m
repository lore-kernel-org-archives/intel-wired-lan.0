Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32853D3F098
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jan 2026 16:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16A6A4070F;
	Wed, 28 Jan 2026 16:50:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0kQqlQPOdGMC; Wed, 28 Jan 2026 16:50:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7741B40A17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769619048;
	bh=BhehFTuvtSUZobGQ8YN/Vb9NG1w8Wpi4HBBk6jcgMr0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rn8h3NlmQ46AZ3yVnLi2lomLPdPAKZry9kxr/QsfTY9VR3g002DAHwpJJ1GlkKIHY
	 6hbVb4OBzR5ph61MLpmXUxYudHMQNQHsel6/l5HbfXzYK3FGrovhrsbMnk4l5HCYFC
	 RdX8407pC/5b7tceknGExP1/Uh4MscZR+EeY/Ci/k/8D8Vgzj98Ja6kvRwdfmzS/Nr
	 yELmGzb6HwiQCty6aXVaM1iAXiJhFyUBt20Uj//GigsVGVPbiHTnIRJFMvrTh6s+bp
	 SkmQjUk6q7l4mo2Wf3Nq94ZKqYOER4ZwqXopBaIz0TtHixpg5Tc6J0A8ZW7UP1Cary
	 YLBijACGfDngQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7741B40A17;
	Wed, 28 Jan 2026 16:50:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE5A4160
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E8C25400C5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jUe7kqZm_6V9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jan 2026 16:50:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org F1F7B400AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F1F7B400AD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1F7B400AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B477B44530;
 Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F5AC116C6;
 Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vl8kW-0000000DBDS-33rZ; Wed, 28 Jan 2026 17:50:36 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Jan 2026 17:50:23 +0100
Message-ID: <beef1362dbec07d025ce1fafa5d32b69cf30d705.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769619038;
 bh=yKLcYi21z0S4G3m+JtOZZ58rdI04u1dgDTVjrPTBONM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QNYwL1LloL0tgc/bNbJ4eTY7SP6VRNYxS21BwoJeOsGGSveE04ClXL0HOZ/+PDRnX
 FCf2Eg4BOqbx+rQ/c7VcgGslBcOlePMq7GI5oSPnfg7OgxUfFJvOVZWnEaS/vZ2Xb0
 iA8YYy7c8KI8IH9FHszPoQ2+0hoUZP4hE4+gn69yB//YUgiCiYlRtiPZZ4h+CZ9CSs
 8IUbbvq8LNjEwpFzj63GeIm7toBEilk6XFGTLdms7NmdMlBF5Zny79vYw4NoWikm9A
 jIAFIA34uV+sF9pHgazcC7oJm1x7EnJtAah71fcCrzD4MFumRQFoho9+5bzUGpNS92
 5NCEx/7eluGJQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QNYwL1Ll
Subject: [Intel-wired-lan] [PATCH v2 25/25] docs: kdoc_re: fix a parse bug
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
index f49a568b9155..8d4cfdf8f479 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -206,6 +206,9 @@ class NestedMatch:
         """
 
         stack = []
+        start = 0
+        offset = 0
+        pos = 0
 
         for match_re in self.regex.finditer(line):
             start = match_re.start()
@@ -255,6 +258,11 @@ class NestedMatch:
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

