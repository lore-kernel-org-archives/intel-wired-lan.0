Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B67E9A04E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48B3281091;
	Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4f7t3lYJuyF; Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BF1118108F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409604;
	bh=oitKeBHWLcb0qSk3OTP9eiIHSxZ1aSUyworufI11fes=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=osfRiM9PXvh3ZMpH1mnVR3FGoJyB7cRAfwfmsXHYjaEnTWeTf/KPP0GCKrq9/bVeh
	 FZYviBv1vs165dwTDrTTC7WTOGlsyncL1Ah3RizhveKiSu+TByu5QbHaOIgzdDLJcZ
	 jmvQpObU3j2W33vbhS4ifxP8HwkEulADZORRx5v1RKUagKmhACXfGXlqvpn3+yZHrD
	 ZomqX32hr8J+dOPEPRQ0LwMxye13kYGHgi/aXozf6aE40zX+Q8hPDdLMudM9hr87B9
	 aMoEHy4yvDWn/z1F4l+zfpbcPw5ZGLBN0n+TSvmH1rvXvwXMuFyBBVxaZU9RhAPGrj
	 VxDIr2CPVzFJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF1118108F;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CD5B438
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12B3840749
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zm-nNximjEjR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 67AF8406EF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67AF8406EF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67AF8406EF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5341143642;
 Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DEDC19423;
 Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYY-00000000LS7-1wTG; Wed, 18 Feb 2026 11:13:18 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:37 +0100
Message-ID: <8c3a59498247039f45bd3b519651f958b0b4c0d9.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409600;
 bh=oriSnGajTdXbMgaP9NfkyzvS+hRyHX9AaxdTAIMkPtI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=t9MxVgpY2IFr8x/LKLcguDM3/lk4NPqx4Dub8TQIJCYpsy4h+B8T3w5UrbYJXz0mS
 hC5l/6KXNE6PuIWccTNV4z7yWwCZ/ecvqCpUSxMMH5ygCt7/cYq5+JEI5QFCde25Px
 tAe8OYCgn6hhz0BJphdv4E2oQxPVCKXYDhxj2x7Wf9S7NFPtLbl5t+do101ESm01sM
 w9lJ74yBEPqhRcjhsp+3wiCMi5IJQ0IwPY6ajH4vb2KQJxpPsAYqacmgcAVMswoZ7R
 xpond0X3jdAdrA3xxDbGQR0nUONAwfsnLu7m1QqhEVR2Qucvt7F4dfQvb0x96KW7Zl
 kvS76SE7gdL4w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=t9MxVgpY
Subject: [Intel-wired-lan] [PATCH 07/38] docs: kdoc_parser: fix variable
 regexes to work with size_t
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

The regular expressions meant to pick variable types are too
naive: they forgot that the type word may contain underlines.

Co-developed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index b704755d2f0a..b63d91b7f79e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1028,14 +1028,14 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"\w.*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:\w.*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             default_val = r.group(1)
 
-- 
2.52.0

