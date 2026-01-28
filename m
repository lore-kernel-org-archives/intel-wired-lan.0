Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3010CD3F083
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Jan 2026 16:50:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0AA9409A0;
	Wed, 28 Jan 2026 16:50:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xUAkxeBdoc12; Wed, 28 Jan 2026 16:50:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DFF794097C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769619046;
	bh=X2IDBEdYKbLoHIHTheeSTTurGZSimgHp+hraUOuBw48=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K4g0rk5WlaqIEpfjFa29pHW/e/B0vypIIVH+6ShHY36ylrKBfUc7CYtKIzmgXiGk9
	 NtoSNV/TOetSb9EqXGIa7NEsR1EArbh6KbeFdMvt/0Vke3gmnkyJEZW/6X03Bm8MBZ
	 /C3V0A8zzDS0njBlw/Vai694+iWsaDvfQbj+cVhkRH+bc3UoLQT15AiJso95fYEpa+
	 qHj61NXKdWqQLUFq2p+JbLiP+k8HnjC0mHnSJGUmyWp9O+DKufidzBm+HQfzEOt0SC
	 pP1luuNILZ4rgiQ9udqRmwh+Uh2vX+Uj+FMkl2h0g7CdxKxEI8tOU5GlSF94Ap3vlf
	 ih2aU7pSFh1bg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFF794097C;
	Wed, 28 Jan 2026 16:50:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16212160
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0481381124
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNUK9jpYWCCr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6922281106
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6922281106
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6922281106
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1738544502;
 Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF896C4CEF7;
 Wed, 28 Jan 2026 16:50:37 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vl8kW-0000000DBB4-0bdW; Wed, 28 Jan 2026 17:50:36 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 28 Jan 2026 17:50:21 +0100
Message-ID: <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769619038;
 bh=xPgXK1Bxhql6KwBQMghZiM8porm1utQ6AVnpiugaqXI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L52Is0d2Mam9VJ+4YyKHw1zLjYczDjF+baeNR4vHB26sFkhUBDLbAVrQFv2uTDSKC
 d7cLGmgpmI93G/ZRxWuZS8P4LzgHpLLntNDVJTs163AvSVDSS326iDw8yHfbJzXAUs
 7akuYBSCS1QjtWefJUVP8iWzgl7unab3zdzhgTO5+ygwLEdzTljtWwYIfnlwAqxRUQ
 ZaHiv9HLvtufnVmn1+/piCFM3ZQogA3HNU/VunJZQKYtI/bUm4ljfWDkxUfexL0VRA
 LSdCAMa0h/oR+dWNMSlAFb00nE5+7b24OayJ0TKOejbCXpe0ulDsf0383a+/LA+Xed
 JMZ2p1xI9Zk9g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=L52Is0d2
Subject: [Intel-wired-lan] [PATCH v2 23/25]
 tools/lib/python/unittest_helper.py
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

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/unittest_helper.py | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
index e438472fa704..3cf1075b1de4 100755
--- a/tools/lib/python/unittest_helper.py
+++ b/tools/lib/python/unittest_helper.py
@@ -8,21 +8,7 @@
 Helper class to better display unittest results.
 
 Those help functions provide a nice colored output summary of each
-executed test and, when a test fails, it shows the different in diff
-format when running in verbose mode, like::
-
-    $ tools/unittests/nested_match.py -v
-    ...
-    Traceback (most recent call last):
-    File "/new_devel/docs/tools/unittests/nested_match.py", line 69, in test_count_limit
-        self.assertEqual(replaced, "bar(a); bar(b); foo(c)")
-        ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-    AssertionError: 'bar(a) foo(b); foo(c)' != 'bar(a); bar(b); foo(c)'
-    - bar(a) foo(b); foo(c)
-    ?       ^^^^
-    + bar(a); bar(b); foo(c)
-    ?       ^^^^^
-    ...
+executed test.
 
 It also allows filtering what tests will be executed via ``-k`` parameter.
 
-- 
2.52.0

