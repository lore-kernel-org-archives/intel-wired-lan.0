Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48757E9A04E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C94A810B6;
	Wed, 18 Feb 2026 10:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RYAdY_vyzD8Z; Wed, 18 Feb 2026 10:13:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E900681091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409616;
	bh=tJlcHrphR51KQpBCcCcntFwPplpVoyviuJh7PqibIcI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8Wa3XNd/qtpW4MQ0k+NnYxz/HAMEEc/osDz4/qOEtXZY/ZL+O3SKJ7F+QLJ/vI7b7
	 lhgpxKfqVmvxmn992KR8+CjttB0osFYb4TU1MlJi1Qq5soDLZfPm9yW2mHvSbr2D+R
	 5ipWngAe5fKkEvTtEsqoRzX5kGrkMenlwyxZ12K13bUKVh6ShaCMSdaCrnyyzbRW1L
	 rAdYDtf7Bk8wOzqnknXIEO8O22muzrsXdd2mZAxzMQgtbut+2VxBe78HjiHOFwX4Zg
	 hhFEL4wo6T35/EvJ7jas0v9NW7H7MEpcZ51kY6kXkyNLCWvGU27Nht12rKZDA0PV2+
	 y0MF8Vel+jFfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E900681091;
	Wed, 18 Feb 2026 10:13:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21C21206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07F9940078
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LiFOSD8Y2hDM for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 156EB4009A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 156EB4009A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 156EB4009A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CF6494454A;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA8C19421;
 Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYf-00000000Llw-00lq; Wed, 18 Feb 2026 11:13:25 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:53 +0100
Message-ID: <a20aa001f4a0c8051f2d004aa21ca73d1db14613.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409606;
 bh=86xDsz00XoZv72qsVxrMGG+DckqmwvjpK6jYFBlRKlc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iJgsNj1ILFH/W404vgqOOGidsNLkMe7JdUEX16v4Uau/P2nB9asfrZh/MsBF6mG1p
 +dXmaF+m95974ysB4gS0Hdt73+2d0dETu3C4BvovzUrKcfvucv2NqxnM0kbuNcv1g+
 yT/AEh39PjncL/tuEIYKGo6UfJVkKSh/W04IAWASLWUxWHrSokyUNVLThZiCIwgSNP
 X9tTUZq41lIw4eb4XKnGUr+/yWpCMbdQEU2VHjZh3G+tRj4bD+P1j/DRuPgijn6vW8
 wczH34zjTznei9NFRqdXI6agVnpnSHAK5GvxBwwPB9G3X5Msy+nfKKFHtdlRFHwpo0
 YlzAUxHzoIZAw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iJgsNj1I
Subject: [Intel-wired-lan] [PATCH 23/38] docs: kdoc_re: add a helper class
 to declare C function matches
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

Add a more convenient class to match C functions and avoiding
issues at the beginning and ending of NestedMatch inits.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index cdc842f5fc8f..f72b80ea4f1b 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -383,3 +383,14 @@ class NestedMatch:
         """
 
         return f'NestedMatch("{self.regex.regex.pattern}")'
+
+
+class CFunction(NestedMatch):
+    r"""
+    Variant of NestedMatch.
+
+    It overrides the init method to ensure that the regular expression will
+    start with a ``\b`` and end with a C function delimiter (open parenthesis).
+    """
+    def __init__(self, regex):
+        self.regex = KernRe(r"\b" + regex + r"\s*\(")
-- 
2.52.0

