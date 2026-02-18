Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC71E9A03E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43757407D0;
	Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KPflimCyVTcy; Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B01F1407F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409611;
	bh=CD09W1Cs/CKxtTlaYQEjSUVqXi90SvD+QSCwnQD/cGQ=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K9JTqXVso9j3kHf772HfwVDPkqiGbPgXKh89GRa/EqxRncr7EpH1jWcUlJU8BspUZ
	 qUpgZ6ymDvoDNTiNc/IK1KgcoBRBvedeOQppe3HjXtfRTchBgvyOS/eHHI4pVDeI+A
	 Xc4Br6RAdUnPAHbLYbVq/rytI+1h0qYkxyzBsXdXYPKfbj1tYhi6buG59ehPlLD83K
	 qzEH9wyy1uR+zOG8FzlbjdxpXc6YAgiy45R94rdS4z9sz6qxcqUvr1srzEBnQQy0TG
	 Hr2/vXW7MOaaO7xlkE0TiStuXg5oqUqPn6nvO786cboqQL55S2w3OdVcw/memteVIm
	 gGeJhCO6Bte3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B01F1407F0;
	Wed, 18 Feb 2026 10:13:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 17FAE206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A01B78108F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1RiXCknZ_SiR for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org AA1EF81096
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA1EF81096
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA1EF81096
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6259041B6F;
 Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46342C2BCAF;
 Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYb-00000000Lc3-2Hp4; Wed, 18 Feb 2026 11:13:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:45 +0100
Message-ID: <eba972628cc478ab977d0403716029e9190ef9da.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409603;
 bh=2s+fzq6gQbWuB1ApycJQ9BmmsdbPbLOVTREB5x1uqxI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NXzlsSSLNhbbqZv4lPRJrQvqahR3ZaCkRyRkFGnD6lg7Sy60W5BiePskmESRP/Cty
 Al/DpzbA4GpxnY4SYtJWZ5vowF3oLv4OTEQPtc6+J+5sNphAgmrH07REMm3xP2LJxH
 Ium9012IyjZQcYf/hl6TSD66MGlgCs6Bnz85TBnTW+as9GhtZUTi0G08kF9Fpa3EXJ
 mBSpw2KqNuN2kTo+wpsEjT7i+F74cTLDQwLWrdUt/8pwmxnouST8eJtr7jlRkuO6Za
 vGLJoV+iuj2C99MfdyjGtV5OW5J7Q8M9CtNXH3gjF6rtgHQATdS2nIuxVU7tMRyo4y
 zXJjPqeaV7j4w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=NXzlsSSL
Subject: [Intel-wired-lan] [PATCH 15/38] docs: kdoc_re: properly handle
 strings and escape chars on it
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

The logic inside NestedMatch currently doesn't consider that
function arguments may have chars and strings, which may
eventually contain delimiters.

Add logic to handle strings and escape characters on them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 6c44fcce0415..420cb8879ba3 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -195,6 +195,8 @@ class NestedMatch:
         for match_re in regex.finditer(line):
             start = match_re.start()
             offset = match_re.end()
+            string_char = None
+            escape = False
 
             d = line[offset - 1]
             if d not in self.DELIMITER_PAIRS:
@@ -208,6 +210,22 @@ class NestedMatch:
 
                 d = line[pos]
 
+                if escape:
+                    escape = False
+                    continue
+
+                if string_char:
+                    if d == '\\':
+                        escape = True
+                    elif d == string_char:
+                        string_char = None
+
+                    continue
+
+                if d in ('"', "'"):
+                    string_char = d
+                    continue
+
                 if d in self.DELIMITER_PAIRS:
                     end = self.DELIMITER_PAIRS[d]
 
-- 
2.52.0

