Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B3E9A047
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B971A81097;
	Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1MsgXm1i5Btu; Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAC23810B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409613;
	bh=kecqzCd+FZoNOUKJXSTKSeC+z7ee4jW/GR0X8AqLv1A=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6xwHbyDKGVDGfNNtHV62+lIbEHlwYqxJlHieXDm26RbDRi6iZ/PNVVx6vivKtUxE/
	 ZCQYJ18/hwP/fCsqyHljr1oVXZtcIkPxLHTOjLOaG5Tv0j7xJlvDZjunUgaeGzSr5u
	 Nm7M4rdgRe8+GqKgdnAsbhPMAQ37m9KQiyLlcNu67vNiuOqxdOA7rZJggI3OSIu6x+
	 feD/aZk2m2Okiaan3Zt65EuOZ8qmXcwOC4kbl0jBjsqb784eBX11MKq32ai9dPajBr
	 fFrsVFG7xUyg3TYidfru1bJYfmJKNgW6U8pG0t/05e3txO3C60hoIPhLf2pz0HNeox
	 UHZMBYlh/28Hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EAC23810B4;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C564A35B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB46140175
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jLqqd10kYIof for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0F8D84009A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F8D84009A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F8D84009A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 932F043D94;
 Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FEDC19421;
 Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYd-00000000LiL-35nU; Wed, 18 Feb 2026 11:13:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:50 +0100
Message-ID: <cee0338b152e57b841664bde9081db6f34ad5d33.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409605;
 bh=ioLa9q6sJJTF/v+qVABuiOCGnewuHvVB07azO/umkxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W2N8KsPyCPQzPnyyt5iGff8DGM/cK2sbMIH/1bvBNlb9V4D+29hAtxEEGQd3oPOnf
 C7xguU0Bc3PuPgb58uaRtNHDC5pI2XJ/gbpre0laoi4FfhdcqKOO66NykdGAiqXhaW
 xcJ12qRF8F5V6uKY86OvjofQJXS+IwVpUcDB0d6G72OA/rXHJKrzSdHKutEVsMBocC
 eVrQtYGIv6m5nRmSuJsioZds4HXl1GnWxKO92Lntgbwt+yM1pUm3BgK+3hTBnsUo8U
 M3AVqqBoOkwdHNyUa74CKCdOPfeHV33D5Kmz9WJ1gXsJ8H2ibOF7ipyaQT5kOgJiIx
 DC7V6XsME1wAg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=W2N8KsPy
Subject: [Intel-wired-lan] [PATCH 20/38] docs: kdoc_re: add support on
 NestedMatch for argument replacement
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

Currently, NestedMatch has very limited support for aguments
replacement: it is all or nothing.

Add support to allow replacing individual arguments as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 84 ++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index fed9894a5c71..05f36d665b70 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -177,29 +177,6 @@ class NestedMatch:
     will ignore the search string.
     """
 
-    # TODO: make NestedMatch handle multiple match groups
-    #
-    # Right now, regular expressions to match it are defined only up to
-    #       the start delimiter, e.g.:
-    #
-    #       \bSTRUCT_GROUP\(
-    #
-    # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter-aligned.
-    #
-    # The content inside parentheses is converted into a single replace
-    # group (e.g. r`\1').
-    #
-    # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to:
-    #
-    #   FOO\((.*), (.*), (.*)\)
-    #
-    # it is probably easier to define it not as a regular expression, but
-    # with some lexical definition like:
-    #
-    #   FOO(arg1, arg2, arg3)
-
     def __init__(self, regex):
         self.regex = KernRe(regex)
 
@@ -285,6 +262,59 @@ class NestedMatch:
 
             yield line[t[0]:t[2]]
 
+    @staticmethod
+    def _split_args(all_args, delim=","):
+        """
+        Helper method to split comma-separated function arguments
+        or struct elements, if delim is set to ";".
+
+        It returns a list of arguments that can be used later on by
+        the sub() method.
+        """
+        args = [all_args]
+        stack = []
+        arg_start = 0
+        string_char = None
+        escape = False
+
+        for idx, d in enumerate(all_args):
+            if escape:
+                escape = False
+                continue
+
+            if string_char:
+                if d == '\\':
+                    escape = True
+                elif d == string_char:
+                    string_char = None
+
+                continue
+
+            if d in ('"', "'"):
+                string_char = d
+                continue
+
+            if d in DELIMITER_PAIRS:
+                end = DELIMITER_PAIRS[d]
+
+                stack.append(end)
+                continue
+
+            if stack and d == stack[-1]:
+                stack.pop()
+                continue
+
+            if d == delim and not stack:
+                args.append(all_args[arg_start:idx].strip())
+                arg_start = idx + 1
+
+        # Add the last argument (if any)
+        last = all_args[arg_start:].strip()
+        if last:
+            args.append(last)
+
+        return args
+
     def sub(self, sub, line, count=0):
         """
         This is similar to re.sub:
@@ -313,9 +343,13 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \0 at the sub string, if \0 is used there
+            # replace arguments
             new_sub = sub
-            new_sub = new_sub.replace(r'\0', value)
+            if "\\" in sub:
+                args = self._split_args(value)
+
+                new_sub = re.sub(r'\\(\d+)',
+                                 lambda m: args[int(m.group(1))], new_sub)
 
             out += new_sub
 
-- 
2.52.0

