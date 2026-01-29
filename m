Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374DBD358D9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C49AE83DB3;
	Thu, 29 Jan 2026 08:08:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WM-xi05bcHTL; Thu, 29 Jan 2026 08:08:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E0BF83D68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674118;
	bh=OFxfw+wifhcE/fc/k7WQZQd6bED6QOPQEGnratpX2zw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BFsq6ri3QWr++IkfKZxZi/hCgtO6pXmmE+bU/Q/erdTPtPkn/FazyyGhPnQd7lC/n
	 rvTlFo8m9vwKtOlrwvMUTrePJ/TSb9CiNqCwouC+ZdFkBYSr5/oxU+4HcmY8DDuH+O
	 WvHzhhqRLVJs5Q2Wmhr0EseAGbj6Mp9V+wSQcFSI2FdXzZFBlposlXGwbCvAUFaQGM
	 3QOn+iBlyOjdE1TMenpKcygl6T7ocYj+8Yo37ZvE1B+QoCBxQrZThHcGmtf5Co5ZJ2
	 jloh7LHIlg74tyeP1eCHCLPCJmdi1D2w6fYhpC9NgImqCQz/aKooXcYmjD6+h8w1mv
	 fbr+EAy4EwP2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E0BF83D68;
	Thu, 29 Jan 2026 08:08:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 68A6931D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C79183D66
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-Qyp9QdIlG4 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A9CBE83D5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9CBE83D5F
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A9CBE83D5F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CFB7A4445E;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3923C16AAE;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4m-0000000ERMv-3OoE; Thu, 29 Jan 2026 09:08:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:07:57 +0100
Message-ID: <aeffb85481cd2ee13d68377d4bed03cff1e7b378.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674110;
 bh=Rc+cvBbCrvl5gHPyjY0jltfZsAtkaYF+V2rrj3nvojw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iy0rZPfmlg0iZMenj0l8iK0/UODQjeNmySHulwExq9W4tJTI4+X34weZAGmD+DlNG
 02I7db29dVZWpQbhf1GTtI3P5f7kT/JU9Wc/HbbWmN3H95WvvGBR2ibZLVyLqh/D+L
 i0qnZB0TpPKMyZ33nDgcj0IHabhens0ostWAR8O+BKfI+3R2XDirm1wAq9AFva0d8J
 fL5dn2yA8P6xFQ3Wop2u62wPfIyPCel2SuzREMdnPrFq1PSDRx6FVd8/z+Sm+3PvSn
 2O0vmumx1UuyTZ4OPgErcjRGPx3UlWsYr5T2jFieuW7V/KexcVsJoiLwjv4DeTZ5ol
 9Us1o2dafHTUQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iy0rZPfm
Subject: [Intel-wired-lan] [PATCH v3 06/30] docs: kdoc_parser: use
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

