Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3113CD358DB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0E5283DE3;
	Thu, 29 Jan 2026 08:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dXBhdXQCyfw8; Thu, 29 Jan 2026 08:08:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E2B383DDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674129;
	bh=5og9an4vHprjI6axHzYabPB1Qo5Xo2uFcxZ07zGdC4s=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HsEdNDBqN++fty2x/p9mSc0Iubapg5BV4cIFF3ziXVG46ZWqi2XN32EX2xeUT8jJD
	 WXJryarowFIeBihwXk8az/zvEc9oKQEFs/HNiZEQjOLA3UE2Qb552ezAI5rlClqFVh
	 5iyLPGAl5M8jPnlu7SbKhU4Mm8lmqxl2PDCXqtC44+FdnD8h8aTinfeCSZ1NhNxJGu
	 Axmn26x0knMHMekHz2SRbld+4OOBHZ9l+HIAd4TPYkZy7jkFvnAULEmanPrPlAPE4g
	 IvshinwSp8rG5b+XdSQJn9ZhvL6JDtdhM33wRKFe0JLtTdgT9j0AOwIIufw8kBevgS
	 tZnaHWP3zkpIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3E2B383DDD;
	Thu, 29 Jan 2026 08:08:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F402118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F322E40B8A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ub9MIm5RHgxw for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5418140B86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5418140B86
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5418140B86
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 555304455F;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26799C2BCFC;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4n-0000000EROD-1cdk; Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:08:17 +0100
Message-ID: <4ca4e256922bc42ce1c86e70c20e6a35a599fcfd.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674111;
 bh=HZIWPQtHuKRBHDG4lIuIJ9k4nhNjGP3jcqbI9/NYBFM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GSjxV5N8m6DyFxui8ZZdGu4+xPizuar3wU0AtGMsI1qMuSXRq0l1WC9X+Zm3hRWAb
 uHyt5mVPJxNtLtSoi/g5xBZ+XgycQK5IV5d3TCaY/cONDpBFpi5AZyMGEDMZSMAaS7
 PvNQ9d8qwDoZkcH6vynHxk5dHtdrfMEC/byQCk12jutLU9F/f4tGSLoCiUvVb+ZNzT
 3plvFnws7sQ+qDOtrTZrwPZvo0lOixx671zZ3a8i3gmYGclELOt1gfZs/iCquZRctV
 r9AB9hYU9TzKNAtgXBplJu0RrpHkoOish+Q/YVMq167JVSHF23onkBcndBpuq5xnaA
 thMRLBM+FNnVg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GSjxV5N8
Subject: [Intel-wired-lan] [PATCH v3 26/30] docs: kdoc_parser: use the new
 CFunction class
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

The match logic for transforms becomes a lot clearer if we use
CFunction convenient alias class instead of NestedMatch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index d2eb93f9d489..50d57c6799bb 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -13,7 +13,7 @@ import sys
 import re
 from pprint import pformat
 
-from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.kdoc_re import CFunction, KernRe
 from kdoc.kdoc_item import KdocItem
 
 #
@@ -119,22 +119,22 @@ struct_xforms = [
     #
     # As it doesn't properly match the end parenthesis on some cases.
     #
-    # So, a better solution was crafted: there's now a NestedMatch
+    # So, a better solution was crafted: there's now a CFunction
     # class that ensures that delimiters after a search are properly
     # matched. So, the implementation to drop STRUCT_GROUP() will be
     # handled in separate.
     #
-    (NestedMatch(r'\bstruct_group\s*\('), r'\2'),
-    (NestedMatch(r'\bstruct_group_attr\s*\('), r'\3'),
-    (NestedMatch(r'\bstruct_group_tagged\s*\('), r'struct \1 { \3 } \2;'),
-    (NestedMatch(r'\b__struct_group\s*\('), r'\4'),
+    (CFunction('struct_group'), r'\2'),
+    (CFunction('struct_group_attr'), r'\3'),
+    (CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;'),
+    (CFunction('__struct_group'), r'\4'),
 
     #
     # Replace macros
     #
-    # TODO: use NestedMatch for FOO($1, $2, ...) matches
+    # TODO: use CFunction on all FOO($1, $2, ...) matches
     #
-    # it is better to also move those to the NestedMatch logic,
+    # it is better to also move those to the CFunction logic,
     # to ensure that parentheses will be properly matched.
     #
     (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
@@ -185,17 +185,17 @@ function_xforms = [
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
     (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
-    (NestedMatch(r"__cond_acquires\s*\("), ""),
-    (NestedMatch(r"__cond_releases\s*\("), ""),
-    (NestedMatch(r"__acquires\s*\("), ""),
-    (NestedMatch(r"__releases\s*\("), ""),
-    (NestedMatch(r"__must_hold\s*\("), ""),
-    (NestedMatch(r"__must_not_hold\s*\("), ""),
-    (NestedMatch(r"__must_hold_shared\s*\("), ""),
-    (NestedMatch(r"__cond_acquires_shared\s*\("), ""),
-    (NestedMatch(r"__acquires_shared\s*\("), ""),
-    (NestedMatch(r"__releases_shared\s*\("), ""),
-    (NestedMatch(r"__attribute__\s*\("), ""),
+    (CFunction("__cond_acquires"), ""),
+    (CFunction("__cond_releases"), ""),
+    (CFunction("__acquires"), ""),
+    (CFunction("__releases"), ""),
+    (CFunction("__must_hold"), ""),
+    (CFunction("__must_not_hold"), ""),
+    (CFunction("__must_hold_shared"), ""),
+    (CFunction("__cond_acquires_shared"), ""),
+    (CFunction("__acquires_shared"), ""),
+    (CFunction("__releases_shared"), ""),
+    (CFunction("__attribute__"), ""),
 ]
 
 #
-- 
2.52.0

