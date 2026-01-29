Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753CAD358DC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4CEC16085E;
	Thu, 29 Jan 2026 08:08:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ksTqUcRIMynX; Thu, 29 Jan 2026 08:08:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B70B660865
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674118;
	bh=OEGkfPKDZdkYhNu11qSkya82/XhDq8bLmoMtLjv0r+U=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LhyPcIpqgqF2KsQlW/h1YtUzdNMdOVisJ2V6+y2iFaxQ7ZDdBXyTwpK1WXlkyI9iF
	 TRZkyoEuPno3p445pkIrRqRNf/iA28BOMiBmzYlX95kNQG/gfP1lyhkIq6MvkcxWye
	 FDxYD38UKaAbYel6BEnfxcdzs1vpsRIxC71a4ByRAIz4Ydzs5cYTJxgOelFjvRoj0X
	 WVc9CT7yPP4nJx8f8ljxv2JeELPxsLU8NeCxtq/IIinatMsGwP4bgmuZVgbOfFM3iY
	 DS51TV+SwmZESkAs4pT+03vfQanblZXduReSh4NDBdUyV2FP+pvngKBBwXKrpEMBRS
	 Ytzn70LtQ288w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B70B660865;
	Thu, 29 Jan 2026 08:08:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F05D1AD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E972740B83
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q3ua0BKOO9Mu for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2391F40B7F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2391F40B7F
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2391F40B7F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 307154453E;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7CAC2BCFB;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4n-0000000ERNd-0XBz; Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:08:08 +0100
Message-ID: <168e559a46713f390c2984fc1c11e16e552ab0c1.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674110;
 bh=ceZVyyPX2HM3A215qLrOaX/Gfxk8tK5tZhLuxNFkn38=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ClkZ5AacxK6NDrStNwCjyJvXg1qxbkYQbqzXHd0p6ie26FisfEYXRx1Fve4+WqsCG
 g6PjeE7mgn/fxMdcinSrXRkXqvTRcYI0aTI02MMrd+RO6nQWx2MvRMNg4gPatHCNBX
 XzdcND/d/AYxjkLtNpBaIIpfsFeSqBKNLk+ZckxxX6lS5EOZelaPTmqxP1daprU72v
 7QQbYWRYMS1IH5ihm1Ok1VznBJ1gRad8Q4+8gf1Q4PlorofDvarbqBU3LWTIQhjIVW
 OpygAxI1pZEpFjmERWxyQAlrD81lwSnJxebh38jf7AfqxclrgiKrBM6qP1yxnT0qN1
 AQEpCw6tsVEDA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ClkZ5Aac
Subject: [Intel-wired-lan] [PATCH v3 17/30] docs: kdoc_re: don't recompile
 NextMatch regex every time
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

Store delimiters and its regex-compiled version as const vars.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 35 ++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 3f405addcc58..7b7ddc50ac36 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -99,6 +99,13 @@ class KernRe:
         self.last_match = self.regex.search(string)
         return self.last_match
 
+    def finditer(self,  string):
+        """
+        Alias to re.finditer.
+        """
+
+        return self.regex.finditer(string)
+
     def findall(self, string):
         """
         Alias to re.findall.
@@ -134,6 +141,16 @@ class KernRe:
 
         return self.last_match.groups()
 
+#: Nested delimited pairs (brackets and parenthesis)
+DELIMITER_PAIRS = {
+    '{': '}',
+    '(': ')',
+    '[': ']',
+}
+
+#: compiled delimiters
+RE_DELIM = KernRe(r'[\{\}\[\]\(\)]')
+
 
 class NestedMatch:
     """
@@ -183,14 +200,6 @@ class NestedMatch:
     #
     #   FOO(arg1, arg2, arg3)
 
-    DELIMITER_PAIRS = {
-        '{': '}',
-        '(': ')',
-        '[': ']',
-    }
-
-    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
-
     def _search(self, regex, line):
         """
         Finds paired blocks for a regex that ends with a delimiter.
@@ -220,13 +229,13 @@ class NestedMatch:
             escape = False
 
             d = line[offset - 1]
-            if d not in self.DELIMITER_PAIRS:
+            if d not in DELIMITER_PAIRS:
                 continue
 
-            end = self.DELIMITER_PAIRS[d]
+            end = DELIMITER_PAIRS[d]
             stack.append(end)
 
-            for match in self.RE_DELIM.finditer(line[offset:]):
+            for match in RE_DELIM.finditer(line[offset:]):
                 pos = match.start() + offset
 
                 d = line[pos]
@@ -247,8 +256,8 @@ class NestedMatch:
                     string_char = d
                     continue
 
-                if d in self.DELIMITER_PAIRS:
-                    end = self.DELIMITER_PAIRS[d]
+                if d in DELIMITER_PAIRS:
+                    end = DELIMITER_PAIRS[d]
 
                     stack.append(end)
                     continue
-- 
2.52.0

