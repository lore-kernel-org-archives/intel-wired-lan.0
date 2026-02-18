Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A435E9A03E
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 038B48108E;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IDsQN2LoNkG; Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 782058109A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409606;
	bh=Uod/zLPl9PfT59GGWMAHeoJ27f8/A27Uie+YMsw6KSA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kP+T5nhZGMHE4Usqf4Og5lqUhoHmZ859C1W0LutARSJfheAN/yQtCE+HmvyNPiUk4
	 uNRTve4pKp4Csd6P+/kQf8onspUTtQNwLCMpMW9Or523NFwdbgn5QO/40rZtuVkPn5
	 HykQlYBtUcEiVm4wecKG1fwjaINBL3p3Hql2iPmHk9g4w3iOfFMa6/ImYL+vSrlEzF
	 u8Q7Wg0sj7XhDutaaRW/7djlFedf0Qy3gPy0p9h1exMuCoYq5hATchlpb8kAexz4AQ
	 RfkbYibI03OUfkxVZqYllvGRln7M/wtbujE9SMWJAhC3h/qKDMYYP51vRIMPwIUISM
	 hZtOCv5BKzwVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 782058109A;
	Wed, 18 Feb 2026 10:13:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA09835B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CBF738108E
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zNAI5Gtjd4hD for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 445678108B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 445678108B
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 445678108B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DDC64445B8;
 Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF90C2BCB7;
 Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYa-00000000LXG-0D7i; Wed, 18 Feb 2026 11:13:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:41 +0100
Message-ID: <35ed0e29955ab12d67e22d451d03c7cf0a3530c3.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409601;
 bh=4ie062/uAY7NEPbx8HftQesMKv4XY2PkHG2S9mIU+Tg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bZBY/1FaTnkXJUmGtrYofH1jQEkrmiDH3KpK/oMOiX4Il8R4zcJIniD3IhdIE89iD
 TU2dKrLM62QIp5pdYkTIq/mStnBg5nB+o6jSOfZpo78kXbwZZwAtbOOZrg3j2N1J85
 k/354c4U3twO9yQeUdzuck7fSvOQlLJAbgymluH+vMuv5/fmRVQcXgC2CXUyH97UwX
 UsFyVRua0vtH7FN2nUSVuFpuM0sC9RAEY/m6qMd30gQRsDhJyhj4hG0mh6XNBMdZrG
 xB78oUuxqKOy4l/DKj4Srg8JPVJO+iSpfdWM8mY1XpTPvoOnloKFmKktwGWIxp5WSi
 LGtOUSyPF6MVA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bZBY/1Fa
Subject: [Intel-wired-lan] [PATCH 11/38] docs: kdoc_parser: fix parser to
 support multi-word types
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

The regular expression currently expects a single word for the
type, but it may be something like  "struct foo".

Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index d8e96c6c4ebc..f524385543a6 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1027,7 +1027,7 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
@@ -1038,7 +1038,7 @@ class KernelDoc:
                                   r.groups(), proto)
 
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_\s]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
-- 
2.52.0

