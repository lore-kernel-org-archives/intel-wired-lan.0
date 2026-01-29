Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE6AD358D8
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B071B83DC4;
	Thu, 29 Jan 2026 08:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8gTkMpajcYs2; Thu, 29 Jan 2026 08:08:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD34983D71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674121;
	bh=RYq8d6gKWNzSfhIpEQ5CaasGiYqT2kt7/UwpM9NMmuM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M8LQA94yf5DfPeWVZGMEPb8oxNAgy2xbBEkLJdj3/uOztftN/CEb0q4f1bdLAEj2c
	 cdDJuWLH4XA+n0+4wVNmm25wn9QQHLlXTUXfJH4Rd242hAptblTLu/SRRei+xr5G1A
	 +lLgD7CpziDQecazfwz53R3jlPkgXfGn24WxxAKy0pGv3r/TcMUmUz0vilDQP59nJM
	 /gQ2uOig8nuBhDuAEZwduwSVUBnVTU2zJyT4zbcAkCbcIGNBFM2xM9mGGG56FFF+6L
	 932GNZICV15htAQbLC7Ee5IRMBFwY10+ZbvOcHMC5xe331xwzPCKSi45zMUXmpbO8i
	 baTSL3NS+wxbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD34983D71;
	Thu, 29 Jan 2026 08:08:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EA4D118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EAA534035B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jnLxW3aSOzSh for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 31E154030D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31E154030D
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31E154030D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 41A5944551;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68C7C32781;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4n-0000000ERNh-0eOz; Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:08:09 +0100
Message-ID: <04552ce2ac1a426e74bf7353e1ba1586e2af4f36.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674111;
 bh=rCmGw1Wb+1Jckq+xhR2lN4gdNL9na4qiJFEWwkWiJR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IUAsCq5qj7DiIxihFXTCS1JgP1c4yGGiUCww/qZKGIPCTSyxdMq+eAMsid9MGZ4DC
 RpdvbLFm2ssU03DL9ukwFVfGeTabsDkCSNjPNpbvcP/CvtIihKcWgMpjzuEQywSt80
 h3kAKbpm1rr+cRlZfuRxabolUJ12tKi6lyPNtWNSUG/FLyB4ZxIrZRZ0V6NdvZeBdU
 08CtnRJG7Fxs6NmE4RVKOoyNhp6dY6v14omfHGlaytD1BashrOX8Z3Snr7aUgs7Rmf
 zPjJ3h8P1OEN7y4S7XzrxynaOBumW/Rn9dEEENjcCR1R5QrzJyIiJLdF2MUVEr78LD
 V+dmCTRqoiLDA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=IUAsCq5q
Subject: [Intel-wired-lan] [PATCH v3 18/30] docs: kdoc_re: Change NestedMath
 args replacement to \0
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

Future patches will allow parsing each argument instead of the
hole set. Prepare for it by changing the replace all args from
\1 to \0.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 tools/lib/python/kdoc/kdoc_re.py     | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index db140363104a..4d52a00acfad 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -160,7 +160,7 @@ struct_xforms = [
 # is allowed.
 #
 struct_nested_prefixes = [
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 7b7ddc50ac36..8933e1a62776 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -289,8 +289,9 @@ class NestedMatch:
         It matches a regex that it is followed by a delimiter,
         replacing occurrences only if all delimiters are paired.
 
-        if r'\1' is used, it works just like re: it places there the
-        matched paired data with the delimiter stripped.
+        if r'\0' is used, it works on a similar way of using re.group(0):
+        it places the entire args of the matched paired data, with the
+        delimiter stripped.
 
         If count is different than zero, it will replace at most count
         items.
@@ -306,9 +307,9 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \1 at the sub string, if \1 is used there
+            # replaces \0 at the sub string, if \0 is used there
             new_sub = sub
-            new_sub = new_sub.replace(r'\1', value)
+            new_sub = new_sub.replace(r'\0', value)
 
             out += new_sub
 
-- 
2.52.0

