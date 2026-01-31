Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB13D79774
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 14:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5524D60B4A;
	Sat, 31 Jan 2026 14:25:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-1owAJIl6n2; Sat, 31 Jan 2026 14:25:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B82C560B4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769869551;
	bh=S0y8FysIz/thK4IwH4O1FCI1U56mxA+e+Qm66tW5c24=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=efUdGEMp+muGHXu9+U1u1+ighgtvmdJ1C96zFSBuSKn4CfCihBkKcPdQCeuTzE2c2
	 CMzHXNwcceKB3rD62iOOyTBGt/5WeVCzMhH1ZPMFNJltfeWKRzSjwq1NudjyLJHX8k
	 FTlbkTGfmwzR7YjMwu8HonSforEo/GHmVWx8FtxWwBHf1AdVFkC6QOosTNe3Fu+CQ2
	 AOsH3luKAUFWCZRszd6z3vVvCaXbWzBtC6L8XbJM82l8Whcp++a0MGDT2kZ8wgtC2v
	 B6LH9j+V89qD4O9U/SkQgwn83BKXgFWvA0W1C9ojANu5Kzg+mTn7PP+Opj0Y8gYe16
	 fu/8LLssiBnow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B82C560B4F;
	Sat, 31 Jan 2026 14:25:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 17B641E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 27C5060B4E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dGYouL9bo5ni for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 14:25:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6118960B4F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6118960B4F
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6118960B4F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 82E7260135;
 Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E75FEC4CEF1;
 Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vmBua-0000000AVlr-0oEC; Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Date: Sat, 31 Jan 2026 15:25:06 +0100
Message-ID: <64fe15e0ddaba7de59a7c031db03f87c19873c04.1769867954.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769869522;
 bh=4aMfKYcVERhHxWAsYjEi8+tgICvrID1mZsAmSUTyoxc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GwEnvRTBbcukjFCvBXvPdgcMk8cgUg/NaCFQ0rJOvDeTecyO+ZPAkjpB/Ku3JxiY8
 GMBLmijNIKMU44tEeKWSwefOeYvvim8vyZpfqFsjJMPO27NfrgSeVMkDacZNKm60Cb
 XNLdkazVD4yre6r7b0aF1is/lkAwGwRGaMrdozz4fvmF7zDzMfTsOM4TI6kuu2Slbq
 HzMCVXVkDYQh+J+b9YGeyPpOtOwVbT/ma64oMzW8R51OIxHD7f2f8KzCF9jzsjf+ZK
 Yy7GXjlkf9Owx8xrNBMDZGTq6Wzv4s0SsQNowqDsocRn2CoCKudSeOONO5uwmZbHCx
 3ZESXL3Kdrumg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=GwEnvRTB
Subject: [Intel-wired-lan] [PATCH v4 32/41] docs: sphinx-build-wrapper:
 allow -v override -q
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

Documentation builds were using "-q" for a long time, but sometimes
it is nice to see the Sphinx progress, without increasing build
verbosity - which would also turn on kernel-doc verbosity.

Instead of doing that, let's parse the sphinx-build already-existing
-v: each time it is used, it increases the verbosity level.

With that, if the default is to use -q, a single -v will disable
quiet mode. Passing more -v will keep increasing its verbosity.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 78ff7ac202ef..8080ace60680 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -168,6 +168,7 @@ class SphinxBuilder:
         parser = argparse.ArgumentParser()
         parser.add_argument('-j', '--jobs', type=int)
         parser.add_argument('-q', '--quiet', action='store_true')
+        parser.add_argument('-v', '--verbose', default=0, action='count')
 
         #
         # Other sphinx-build arguments go as-is, so place them
@@ -179,10 +180,14 @@ class SphinxBuilder:
         # Build a list of sphinx args, honoring verbosity here if specified
         #
 
-        verbose = self.verbose
         sphinx_args, self.sphinxopts = parser.parse_known_args(sphinxopts)
+
+        verbose = sphinx_args.verbose
+        if self.verbose:
+            verbose += 1
+
         if sphinx_args.quiet is True:
-            verbose = False
+            verbose = 0
 
         #
         # If the user explicitly sets "-j" at command line, use it.
@@ -195,8 +200,11 @@ class SphinxBuilder:
         else:
             self.n_jobs = None
 
-        if not verbose:
+        if verbose < 1:
             self.sphinxopts += ["-q"]
+        else:
+            for i in range(1, sphinx_args.verbose):
+                self.sphinxopts += ["-v"]
 
     def __init__(self, builddir, venv=None, verbose=False, n_jobs=None,
                  interactive=None):
-- 
2.52.0

