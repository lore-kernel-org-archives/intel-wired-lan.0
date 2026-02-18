Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F35EE9A04D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17B8681098;
	Wed, 18 Feb 2026 10:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JoO7F2_f7WtR; Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC31C8108E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409603;
	bh=eUaAAsD+P031RxF/b/73os45Ari+JsNEx0EH8nj/T5o=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c07icC5IZu0d7cYRiR2czo25u582r0YWPOjS8DxqFUntgW0RILP3appt223rJkAPm
	 jCYHbs6v+UfaDKQGXP8PpQFmWjdbWoj3hoEX0Kb1o2wttIYKs6p1vAsjp4KozdH0iu
	 xz4VpD0VtRHjdnRhu+NbismPaWHyM+XjOjwAneYYmokKlz/Q0KHmIhgEKbBAiVPLpF
	 rPNurxQgbKcrtEcLvl/Wrj63/xi5ZrYj9H+ZmZ7qhFBuvMpTVGRzOhU2jt7N/832b8
	 v7rVRyfNjkYVa+SQDtrNpYEc5Ewy/a8qOqfYy9Wdf5TjjayQgNCYBFm0LTRLqyFOXQ
	 NUfoKVA++8gvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC31C8108E;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B98CA3C
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 211B0605E5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HP1uDQGQX_94 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B5FFF605D1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5FFF605D1
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B5FFF605D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B6FD44524;
 Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2914BC19425;
 Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYW-00000000LKh-0WnY; Wed, 18 Feb 2026 11:13:16 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:31 +0100
Message-ID: <49b2f5bd2284b0685d8a8ab363d60f89d4d53935.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409598;
 bh=Mq94eCCs+RKATmleknUccsvrIqNogkHHQ1NGR1scPL0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y+9PRPJSkjz11xvjOQGqeiX1T1CMS1ZijJxTf/OBtdeedFvvTx/WzQJZCMtcnEGLN
 oS7/wIqluqzChdEfIhT2PaNOIn4rle3aieEQKaqwQ1bos38Uz9YEhbr4GfYSJW0dIu
 yTXZAaB5WnO9cismVDnyNRH7HN6DE7B4OID1PEOUgCxsrnG3SDecUr2ybtaiXWLEdU
 Bi8UZNa3fBnmLnDcv3UMGGAKt9nnWjrreTjGradPefIWDS9W1uvq9Ag/6zA1D8pYFQ
 bsTnUA9BN/6ZIUVuw3zq+Yb2xzyKGoNBt9jvPGGv8hCMq8neI7CvkQny/kLPbdSUOJ
 iLqnG953iI+0g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Y+9PRPJS
Subject: [Intel-wired-lan] [PATCH 01/38] docs: kdoc_re: add support for
 groups()
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

Add an equivalent to re groups() method.
This is useful on debug messages.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 0bf9e01cdc57..774dd747ecb0 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -106,6 +106,13 @@ class KernRe:
 
         return self.last_match.group(num)
 
+    def groups(self):
+        """
+        Returns the group results of the last match
+        """
+
+        return self.last_match.groups()
+
 
 class NestedMatch:
     """
-- 
2.52.0

