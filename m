Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D95D3F099
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6EC4408D0;
	Wed, 28 Jan 2026 16:50:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aE3RQTAdxtQE; Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D271A406E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769619034;
	bh=Nz/8GWbptjieyFse63jpt1U5FMM5fIMLkJfEBp7ljA8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PCxOGrXwX4qFrEKjAtezeXfS4RLoU/zqm77YlAaMW6vmtML461YVHsLmHf+NgBUI0
	 TGHktaim61P2mLFVmXaaL9blXTzdpdBMMLu72KQompE4q/Q1NkyKdR/DWpp92TxsVa
	 kJSh7uuh+t2Dw6+VRapbDo17/TRwiN9z+F6SsMOvUoLyN+fkRGykmM5jzJ/0cbkwIy
	 Opdsex2xKKRjXOI8a7M3rcvvPwsEr6Cezu84fRSy5Gy4HaKNMUSgEvI9kTZ8NJy6Or
	 0HG5szAApIYvr4Sttd9MD4WojlzaJIPETpZPfS5hwnnUjRhjQNWnILnD9I5U3GIYvT
	 SWp/p5hm/SC0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D271A406E8;
	Wed, 28 Jan 2026 16:50:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D983E31D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BD481810DD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MqmNY6zHUKoe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 21DF4810D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21DF4810D0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21DF4810D0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B1326443F4;
 Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2BC2BC86;
 Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vl8kP-0000000DAn7-2H9M; Wed, 28 Jan 2026 17:50:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Jan 2026 17:50:01 +0100
Message-ID: <ee823af3eebc4ece0278c9859f4d109dd0de54ab.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769619031;
 bh=1OHigLaB0I9Gr4pd6M4Zc3FWOaEqquAXFRRO/Gxw3CM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TjfXEptm0ADY3ifgqaYHKezKdvmZ0vdiu4HJLMBS7TERWWChwTE1Xzyeiuawdcaau
 7989W1/+LpY6k5kTjByO0/pedG+2Fau/rP7VQrEFfnNa21MOP98mp6x+tpR/0t8g1F
 ZZUyM2fgjTeBFBBGeu53u1D/WrM7HHTeTKuNF32yRhacr0ydl40FC6ViV+OKZfx9Cp
 cVe49eQdgNKHSOAJr+sb8eo5n6T5Le49xwuw8FTQrCTdAbEUDlwa9IwlwPQZLTaOdC
 zEw58RSxgeWu+Nrfi6iiYe0ALr0VH7//l/jWCLXmAZRGQXl/rrV9BkB0gorneZ3QFh
 fMboor8w+ReGw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=TjfXEptm
Subject: [Intel-wired-lan] [PATCH v2 03/25] docs: kdoc_parser: move var
 transformers to the beginning
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

Just like functions and structs had their transform variables
placed at the beginning, move variable transforms to there
as well.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index fd57944ae907..0b68b140cd02 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -191,6 +191,18 @@ function_xforms  = [
     (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
+#
+# Transforms for variable prototypes
+#
+var_xforms = [
+    (KernRe(r"__read_mostly"), ""),
+    (KernRe(r"__ro_after_init"), ""),
+    (KernRe(r"(?://.*)$"), ""),
+    (KernRe(r"(?:/\*.*\*/)"), ""),
+    (KernRe(r";$"), ""),
+    (KernRe(r"=.*"), ""),
+]
+
 #
 # Ancillary functions
 #
@@ -971,15 +983,6 @@ class KernelDoc:
         ]
         OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
 
-        sub_prefixes = [
-            (KernRe(r"__read_mostly"), ""),
-            (KernRe(r"__ro_after_init"), ""),
-            (KernRe(r"(?://.*)$"), ""),
-            (KernRe(r"(?:/\*.*\*/)"), ""),
-            (KernRe(r";$"), ""),
-            (KernRe(r"=.*"), ""),
-        ]
-
         #
         # Store the full prototype before modifying it
         #
@@ -1003,7 +1006,7 @@ class KernelDoc:
         # Drop comments and macros to have a pure C prototype
         #
         if not declaration_name:
-            for r, sub in sub_prefixes:
+            for r, sub in var_xforms:
                 proto = r.sub(sub, proto)
 
         proto = proto.rstrip()
-- 
2.52.0

