Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723C7E9A050
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4530F810AA;
	Wed, 18 Feb 2026 10:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kVDwWZu1Cus6; Wed, 18 Feb 2026 10:13:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB2FE810B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409625;
	bh=wdFZ7U7Tpj+kPiVHWajWcirOtm5rMR/kdQtoAt2VIh8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6cySdFSCuvi7sm7185JCghW1J9aaT3/hqsNOo1myv4p4w5LE5m4rCN0JeSGDiiF6n
	 2t3iRAMOeY7oTBTXImbpLSTQJjhuo4HFeQuadzjcgN2RVxySU731kYAg6jHf62W6IW
	 DRzagHFd969itCe89+WwDXma9jXdESkj0EPtaP6ZjjregfC4eJ9ukYv7rPkI26aZC2
	 6aBGsx6J+ldmT+LiBq6VeP2bL6/2ocu7lELmV+FwuWTH6XmyywIyLjkuxY7Z6cB0R1
	 AVvH30BWbRhflN8ixA6aAGsQHwz3T6ns8FE0V3O839gMgdHH3CdL3lPy0drX1sNyjL
	 knODZL37mSwLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB2FE810B0;
	Wed, 18 Feb 2026 10:13:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E162B206
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D331F407FA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DxesaGsJyVT9 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org DA631407CB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA631407CB
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DA631407CB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0910B600AE;
 Wed, 18 Feb 2026 10:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF45FC4AF09;
 Wed, 18 Feb 2026 10:13:32 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYl-00000000M2R-00ln; Wed, 18 Feb 2026 11:13:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
Date: Wed, 18 Feb 2026 11:13:06 +0100
Message-ID: <343c89692a53b256670c1bd393aff2159dc3faa2.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409612;
 bh=StLiyG6YMI5Qu+bnXMhDG5SBpIn/ZhlyGc1i11g1b5g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PH4vkffYkqJW5ZJe/JehvYwIYLyV37DkmsbCHziw3ZVSjHd4EliM7zDIQlCjtaU0Z
 U20j9CXVrMqrxjt74/nCU9pV909y8KZl7Kx29eAoi8pHbTaHCZLWLqkh0edxn8F33h
 QhfzO7VKCgJy8x9eg+oCwr7h+SKHdBib2ixx09YOEGwNjsXBz0bgbAciMULtmq/712
 qSIDw4AlysSb8aejoFbM1yB9o2t+2EKb+dpOlHYIaTBUE40qW6WQhk48HGObOlaVOV
 uQe3rukCNq0ZZnYRv4xNIusCcPOxhwpL7RkYt8ha0BbOjd6/BhAVtz7TQY6WisSC5M
 3yIFoKlyOeSpg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=PH4vkffY
Subject: [Intel-wired-lan] [PATCH 36/38] docs: sphinx-build-wrapper: don't
 allow "/" on file names
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

When handling "DOC:" sections, slash characters may be there.
Prevent using it at the file names, as this is used for directory
separator.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index ac6852e3dd8c..d4bb1175fe32 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -625,7 +625,8 @@ class SphinxBuilder:
 
                 # Use shlex here, as it handles well parameters with commas
                 args = shlex.split(line)
-                fname = f"{output_dir}/{args[1]}.{args[2]}"
+                name = args[1].replace("/", " ")
+                fname = f"{output_dir}/{name}.{args[2]}"
 
                 if self.verbose:
                     print(f"Creating {fname}")
-- 
2.52.0

