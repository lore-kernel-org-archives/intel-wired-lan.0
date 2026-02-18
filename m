Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB58BE9A04C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6D35140758;
	Wed, 18 Feb 2026 10:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7Y0SuqWsxj_v; Wed, 18 Feb 2026 10:13:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBA78407FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409620;
	bh=Ei+GsIaTtGSh4XJ4j6fZc4hERDpknyZYs+o2vOPmRhk=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FbN7moDeV3Sm+ME6Yzkr/ZrArhLOaEht3NVNCRyQxG5GxKpnR7zVEbclp/wR0ji3T
	 9TWcQc3s4h8+G46Nb9J+/imuFJojGr5ncvQtkUJ6D4ZKYYzzBqujcvu8JKpn+O4EJu
	 WaqOZmPf+zMgu2mAggyTu38M7eSPqilCiQYBVeqLbTnPE66EUTo2J9IeTEQajh9MV9
	 wliBEJG5gtrJOUKGgysW9ixm8yKMqXSSeSIW/SGn0Zua2dQ+wp+bCUZMtkP0u/91Us
	 f3/d6TSJa0juDdLZJfATS/2C4nv+KH6rPolDKzxovgiH2HEqY1Mcol0Q7Hw5X6u1To
	 QAWrEkUAOjAiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBA78407FF;
	Wed, 18 Feb 2026 10:13:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 15C5135B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F00AD810A5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ihr8q-dEsWdz for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4EE0F810A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4EE0F810A8
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4EE0F810A8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 700476185E;
 Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23843C19423;
 Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYi-00000000Lux-1Xmg; Wed, 18 Feb 2026 11:13:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:13:00 +0100
Message-ID: <f245479bfa8cd8dc2ad2041a87085dd2ace8c502.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409610;
 bh=3n5zkoFrFUOIWGD8NapCIbtnoFCw7B0BzF+EBvzaUy8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tcOYv7LYcrZ5Lrw7m9IiFT46WDG8lvQC26H6JL+ld2BPUJ/cRpb+fn46o6dyjvT3z
 fZ36++HlWV8B7DRuYo13mjduPE5fT8nnpO8Rv4MCt6ukJ39Dg+ah/qQ8tKt1Ool9pE
 3hGfWgGufvONBSABEpw0bdqfPtL4E4y34ZLJMcjtnt7ZIKGQw92gavA/u+Xv+b6qng
 r9OUi0xaTOnNYXzwOI5k5FLzmWbtUL8ZKzpCOco0nDN+Bj3li2TGD1gTX25P+1WSN8
 G+BraAGRnfcSmOEanFQ64tv8eoq/NABA9KyFjwEh8fSy0vvBTNR5DKd4utoDLvLdjg
 KXoPaETHcYK+Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tcOYv7LY
Subject: [Intel-wired-lan] [PATCH 30/38] docs: kdoc_files: allows the caller
 to use a different xforms class
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

While the main goal for kernel-doc is to be used inside the Linux
Kernel, other open source projects could benefit for it. That's
currently the case of QEMU, which has a fork, mainly due to two
reasons:

  - they need an extra C function transform rule;
  - they handle the html output a little bit different.

Add an extra optional argument to make easier for the code to be
shared, as, with that, QEMU can just create a new derivated class
that will contain its specific rulesets, and just copy the
remaining kernel-doc files as-is.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_files.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
index 7357c97a4b01..c35e033cf123 100644
--- a/tools/lib/python/kdoc/kdoc_files.py
+++ b/tools/lib/python/kdoc/kdoc_files.py
@@ -118,7 +118,7 @@ class KernelFiles():
         if fname in self.files:
             return
 
-        doc = KernelDoc(self.config, fname, CTransforms)
+        doc = KernelDoc(self.config, fname, self.xforms)
         export_table, entries = doc.parse_kdoc()
 
         self.export_table[fname] = export_table
@@ -154,7 +154,7 @@ class KernelFiles():
 
         self.error(f"Cannot find file {fname}")
 
-    def __init__(self, verbose=False, out_style=None,
+    def __init__(self, verbose=False, out_style=None, xforms=None,
                  werror=False, wreturn=False, wshort_desc=False,
                  wcontents_before_sections=False,
                  logger=None):
@@ -193,6 +193,11 @@ class KernelFiles():
         self.config.wshort_desc = wshort_desc
         self.config.wcontents_before_sections = wcontents_before_sections
 
+        if xforms:
+            self.xforms = xforms
+        else:
+            self.xforms = CTransforms()
+
         if not logger:
             self.config.log = logging.getLogger("kernel-doc")
         else:
-- 
2.52.0

