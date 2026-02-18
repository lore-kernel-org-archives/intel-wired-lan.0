Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EA4E9A047
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B47BD605EE;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NcSeqfVtzQmb; Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 307B560600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409604;
	bh=4yno0WjNYtI6aqq546RSxfVkuNKdS3DKkQ02fdN0FrI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jK4S99zIXDA8FCQuYjO3YlO7p7Xj79pva6Wr5wH8I1mHg4EU6iHVkQE+0RRFY7DA/
	 rpE4HHlsUfwRvFEN1xsg2NG9q99tG2kI6xNHJRom8jHB9nf8n6PfDTa99sanmSoRYR
	 +JipZIJ9qFUJUP2MypySTenFfz4Zc8J8HizEExHg+ooghxNXIm57yPdDSt2XnPHH05
	 +SV2X3APoGNaGwmysKBDiyu1S+r/VgXwS+sAQwX/4VWtsdwE9YC+ZdvPJ56+A4ZQXL
	 8QPd5zAAndhilX7Z9qVxm9fRn1DjPiplgVNsAXFauLQn0XDtTKOY3a4YeFw0j+eNZ2
	 F/7+v0hs++rYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 307B560600;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 23CD7206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AFE4605D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HgdOfZh8EiZs for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B978E605DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B978E605DC
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B978E605DC
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A7FB44551;
 Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49139C2BCB2;
 Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYX-00000000LOY-1StF; Wed, 18 Feb 2026 11:13:17 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:34 +0100
Message-ID: <87e79a43714d1de8258c169bf2a8e2ce30705df2.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409599;
 bh=l1TnXg9K1HZGJE+MUFeDj5Ao7LGwzZBBWNXmq8OcdpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MCvrIShRWQOn3kud+SrF72GQRRQoy8OmrR6yjDW5RlNisEJFpIUqVjFy08irxCVc+
 mjZgJcxkDMHVCNC8UshxLFNGBjByVeTTuuEgWLEWwnsvR1pmPN3/4xtswo9q/hiK9p
 gTyhtm4iw/YYOvpvJgtn8QfXn/lXb1oYxajx4Y5vMNt/hqvE1aU/NcV80bjSvHoFhz
 DlJryyoGqHz0vmCsAdDwilJwlqgOlKCISe1RoJf3A1lEtNw1Z3qQEiI+XmsGCvMldf
 Ac1SFPW5V1GguUfndsay9o6/+4fAj69FV+5wDZ98TJ55Alw7jJqSrmYU9TzlndEuii
 ELbd0z/ONbmnQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MCvrIShR
Subject: [Intel-wired-lan] [PATCH 04/38] docs: kdoc_parser: don't mangle
 with function defines
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

Mangling with #defines is not nice, as we may end removing
the macro names, preventing several macros from being properly
documented.

Also, on defines, we have something like:

	#define foo(a1, a2, a3, ...)			 \
		/* some real implementation */

The prototype part (first line on this example) won't contain
any macros, so no need to apply any regexes on it.

With that, move the apply_transforms() logic to ensure that
it will be called only on functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 68a5aea9175d..9643ffb7584a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -163,7 +163,7 @@ struct_nested_prefixes = [
 #
 # Transforms for function prototypes
 #
-function_xforms  = [
+function_xforms = [
     (KernRe(r"^static +"), ""),
     (KernRe(r"^extern +"), ""),
     (KernRe(r"^asmlinkage +"), ""),
@@ -1066,10 +1066,7 @@ class KernelDoc:
         found = func_macro = False
         return_type = ''
         decl_type = 'function'
-        #
-        # Apply the initial transformations.
-        #
-        prototype = apply_transforms(function_xforms, prototype)
+
         #
         # If we have a macro, remove the "#define" at the front.
         #
@@ -1088,6 +1085,11 @@ class KernelDoc:
                 declaration_name = r.group(1)
                 func_macro = True
                 found = True
+        else:
+            #
+            # Apply the initial transformations.
+            #
+            prototype = apply_transforms(function_xforms, prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
-- 
2.52.0

