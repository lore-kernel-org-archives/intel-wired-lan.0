Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F7E9A04C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B032407FA;
	Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r9FBngoahQYg; Wed, 18 Feb 2026 10:13:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6C3F407F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409614;
	bh=8SJZyB3nH6Px2jGwZbynqtU8/yj/pq1eQsQJ6U9zMOc=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=63BughyO5kLmJZRY5Gv8oDisDSEJJchfavwSDra1My7LpkH2GbUMxXKux3q647fUR
	 T+tPrR50gea6N7Bib1kyrbtKyi17SecO0Pn3+rluRgucxdgiZ19Hhiqv5chHk+akOU
	 lNmyfXTqd0DdCGHnGYQK0FAUKTDyrxNbjFIQry+M8dvXUKAu+fEUoJ7mNnD4owSnGY
	 q66fjaUQaAEKT7CiWnizx+iSvu/Ugx+NdzvUFC2GjKCXtvorqYFgsinO0mthLrsAoU
	 3VMTGckQSHy0MEznM20YOTU1Fiv8mT9oZq9U3DToK+V2wmYo3Uo+TfxTaE8mdmwxN1
	 OvQQQMDzHHhRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B6C3F407F7;
	Wed, 18 Feb 2026 10:13:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 56744438
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 42B7B40175
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C-Xe92tSNFHb for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C342740078
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C342740078
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C342740078
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A15AD61857;
 Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562EDC2BC86;
 Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYc-00000000Lfc-2Xc1; Wed, 18 Feb 2026 11:13:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:48 +0100
Message-ID: <fe5e5235ca96c990d8400d1cb8f05e378348b5c5.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409604;
 bh=lxqRyV3o4DNkRR+ET0M9mJXcj01vT7DB3Ke8NI6BKWU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hhN90xsme2OpQoKScg+Ymx3ZPnjDy7G9dkB4NVgmtIPkagZU7INCyETmk4A71JD/8
 nJTXnGOJ0hwHLa/W3ZTgs2hGS+YwTtr3O0Cf66QJzQX+TNYNADmA5droDseKoZYGJl
 BYhn64LMCV3+OeT06dfwGTvGjsEEfGcFG9pc3jefPv851r6gPflQyffjyHNZmuZ8bb
 FC3JtHpZ+2PviFdTsiN9i/zCc34BK/dBtbTFvzAaMWqqSF+e4PpjVBu5fdwjysvUgq
 TP5eXeAfChShpGnR0q9CPfEYtGnzf4burktNWKYsh6L++2lYPEmjpbLofnxaeHzTpp
 t82jf4AwAKR7A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hhN90xsm
Subject: [Intel-wired-lan] [PATCH 18/38] docs: kdoc_re: Change NestedMath
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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 tools/lib/python/kdoc/kdoc_re.py     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 32a30851db08..3ee169b505d3 100644
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
index 00afa5bccd6d..2d83b6fb1cd6 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -291,7 +291,7 @@ class NestedMatch:
 
         if the sub argument contains::
 
-            r'\1'
+            r'\0'
 
         it will work just like re: it places there the matched paired data
         with the delimiter stripped.
@@ -310,9 +310,9 @@ class NestedMatch:
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

