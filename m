Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BDFDD3F09A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jan 2026 16:50:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4397E409EF;
	Wed, 28 Jan 2026 16:50:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id expC0-Cyu1Yw; Wed, 28 Jan 2026 16:50:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B1E36409D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769619045;
	bh=OFxfw+wifhcE/fc/k7WQZQd6bED6QOPQEGnratpX2zw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ri/FHHj13p05+w0O27G3YY1/PRlsXRNkyQNB95hPnGYvPJ9M2kWmIew6prYpZUPbm
	 mg5vXTuXXzxPhqTs+Y8cCGceDUIHbp0ocQqKnwp/xhl4m050xI/zUsbHcLPpLAaSnQ
	 pFI0qVsQhB0fJapVOiuE07up5x/hhJ41KibeDvHZXy/sFdGQp7VzRh8bcM0uS9wkzj
	 oy88bQ0sTmxuv3SmGqfUG00bvWaHh7bYYyrX00AeFtIb9u4Nx6od8iZDG0rgI4XAuB
	 ualWstGOseIkjtKY82nxBYRNJLdHX919eMcyWDEZKAK5m13SYdNVKCl+7wZHYEZ+IE
	 Jwy91FCZRaC/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1E36409D8;
	Wed, 28 Jan 2026 16:50:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 981A91AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB36960779
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwQY_ax-DTUy for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0B4756076D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0B4756076D
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0B4756076D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B82F4451D;
 Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DBFC116C6;
 Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vl8kQ-0000000DAqf-1hgM; Wed, 28 Jan 2026 17:50:30 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Jan 2026 17:50:04 +0100
Message-ID: <9c77e55b771dc19f0c1203bc107f69c8c2c371c5.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769619032;
 bh=Rc+cvBbCrvl5gHPyjY0jltfZsAtkaYF+V2rrj3nvojw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cScZw03YddUXVcztOtXAVx42vO/hlulf7PHru1VjgHAhVSmXdImxkmdeBTi9dIaXo
 rbRTQtEPWPLtq5o3abyVEDEeEY6C0H11KpiC9lRC6aNem/KzxY9KM8rbE9ZY81TyIb
 Db0P/2CSRJYIxc1uuFYpTmsy8fQu3ync9SAaqplq1K/rBwS6KaPcHLi/znGZyK80kC
 lHUu9B+td2Sd/DmCn0MF1AMkXRZ33yzh3rH9COWRtpOUrouLNnQK05tK5pAh9gksJv
 Y5jSylUilJ1ykhQEt6DTrsnT1SbHR1at4RaLTEBDNCrnafbzBwALUf/4q2ja9CyneK
 3ks4m1cN6PR2w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cScZw03Y
Subject: [Intel-wired-lan] [PATCH v2 06/25] docs: kdoc_parser: use
 NestedMatch to handle __attribute__ on functions
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

Some annotations macros may have nested parenthesis, causing normal
regex parsing to fail. The __attribute__ regex is currently very
complex to try to avoid that, but it doesn't catch all cases.

Ensure that the parenthesis will be properly handled by using
the NestedMatch() logic.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index ae5b2ef80f75..64165d8df84e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -165,6 +165,7 @@ struct_nested_prefixes = [
 # the start delimiter.
 #
 function_nested_prefixes = [
+    (re.compile(r"__attribute__\s*\("), ""),
 ]
 
 #
@@ -195,7 +196,6 @@ function_xforms = [
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__attribute_const__ +"), ""),
-    (KernRe(r"__attribute__\s*\(\((?:[\w\s]+(?:\([^)]*\))?\s*,?)+\)\)\s+"), ""),
 ]
 
 #
-- 
2.52.0

