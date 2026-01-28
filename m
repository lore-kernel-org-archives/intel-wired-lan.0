Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D16ED3F099
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jan 2026 16:50:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 48EA040966;
	Wed, 28 Jan 2026 16:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BoMOy-9RxAPp; Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 82CA3406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769619035;
	bh=GPt39J/z14kVG5JW3Ifz/vrTsdXGI+DceJjB3l42Wv8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N3ZlCka0ejcAeWIqyo+EUP+hhGLZhrkiOO8S2EbJRCttEipRsK9XxDtmRTgV4sUSf
	 0HdelYKpd2rcWWlIwuA1QEfZ0uAaRTz9jsv4QfL58gxW3hxfzd5t9GrdZ0r2V5UZ9m
	 QnQ/hUoGLTSxlXiWYY2h3vxRZObEGCjodaNZ36gBDPVl1Ehgp+08zsMFpaPRp57HCP
	 j/NDP9vhd9DhkaIFwxSRtYGHg//U0rT4VGAwgaljIjitG3G/l2iEZ7BNlJfWfTAkmt
	 LMyoHgMZ2bsyZy8EbChpGxgv8z5yCqbRZebBXur5YylyuKk7xUyU8Ni8F3W+neHBDr
	 32PcQw9zL99EA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82CA3406FA;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49B74160
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5B1A60643
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SFAOx91AUUZe for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 62A396076D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62A396076D
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62A396076D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AA6C41A48;
 Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753C3C4CEF1;
 Wed, 28 Jan 2026 16:50:31 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vl8kO-0000000DAkj-3zTj; Wed, 28 Jan 2026 17:50:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Jan 2026 17:49:59 +0100
Message-ID: <e1ba55866b3a8ce7fe95535981fa3c22bdaf9785.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769619031;
 bh=Mtp3U2b4BAZhIQ5Am742/0g+jFDD4JwsLEBjzPmmPH0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nmixZLGVxxndMEUPOHEcC/ljHC7OcOHdhG+qCVStSGMa2pJuMpU+5U6vYAA0Rado9
 7/BBAD1SmTMSLtmcV2BWclNTvWNUGWklzQ+UvMzyNMdZ9pI6VgTyAgNAROUzJVnmGf
 fnAntSedfmRPvM70thFn/o1Rsv12zu2a6NycKT3pzy+85fMrF4AycL0Sd5Zblrya5o
 x9X6XiVPTKxFhU8iwjiaAO3pTF6l4HuHpP1Wd9q6SpH1wXr2zB37UAhGG7YUaeyspf
 2CHq5z8GI+DBlIT2SmgLxmUotLFzm1ZlykGEa+dJLoETKe0HGJ0pj1/Gabbn4uJbB+
 7258GfjWTox0g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=nmixZLGV
Subject: [Intel-wired-lan] [PATCH v2 01/25] docs: kdoc_re: add support for
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
---
 tools/lib/python/kdoc/kdoc_re.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 2816bd9f90f8..19e777e2c97e 100644
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

