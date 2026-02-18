Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E076EE9A050
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AED66407E4;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j2Mb5o_YqtXo; Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 040F4407CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409607;
	bh=i+d3jTIL00faN1OTXFR7H2YyQ1aclavZYQQ0aJ0WgJ0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rNKxMJyfZWmP2ldkkJKNkZQpbA5CpWBvc/HV3LrvxrtEXxkrFj7O2NkwqJZ6Q1Mqr
	 Aaj26XpJdMJNjDQUXjzhvjstrwEdwEI3cPFZzC06DNjvVHCoW9Umm+PYdqQLec6rGU
	 hB7jBr+mMdNMTNSvVqSCSkKVP4reFTVSrOm00lW1V5AqPsOQvp32RVcxWb+3IPVdxj
	 /ULNMHmeXUvROsIye8YybYXyH8xy/QYD0O4PQ/l4VX9NqOsGHJnjG8vL2rWzanT4Ta
	 sEzBSVWsCJgHNS0faUHM7NZYQFutQLvj3LY/N4OCIGj/wXZRmDpn4yUlsP+1KEi0Vq
	 GXTKXHP0nRQzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 040F4407CA;
	Wed, 18 Feb 2026 10:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 007D035B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA71C4009A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6cxpK3VAK2j for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2E98440078
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E98440078
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E98440078
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:21 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EF9F56185E;
 Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AB1C19421;
 Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYY-00000000LTL-3hcM; Wed, 18 Feb 2026 11:13:18 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:38 +0100
Message-ID: <6141a2f9378a79c76b3a8e860b82c46bc8bfb048.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409600;
 bh=SOaPcpSwL2YOZCy5eFxw6vXlh6YPzp2zJBUs62B0pPk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hQKq7jXQAmnA1oi17FdW1WrT9lMnn/BxlrBnoB38O4kWhyj2xlLjtbM5SZFCp+kvw
 nnhJlECeI4ozMfT81rso4oUW/f/vIAHy4h2Vdg/sDz1xSMGvwpmDfcGoe1u+S5NEqN
 tPDK5O8K1r0+wDO/7rOmxS/ODjxxmVsa+CnhhUZpk/lHkJ5Mvr912Oz9Au/8FI8CNk
 s+364r21AxnZXLoAaXjf3bWb1VOqXDdmkeRY2HOKIeehkAy/Od4ZJ0VJ+QRTLoZIkd
 dogFzd2iBPNdPPLWXOkSm/0LZw4ek1MeGsLpDh099eFQsXCJklqXDA0YharYHMa4rw
 gpnjrPPbhFwYw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=hQKq7jXQ
Subject: [Intel-wired-lan] [PATCH 08/38] docs: kdoc_parser: fix the
 default_value logic for variables
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

The indentation is wrong for the second regex, which causes
problems on variables with defaults.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index b63d91b7f79e..abfa693051cb 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1036,9 +1036,9 @@ class KernelDoc:
             default_val = r.group(2)
         else:
             r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
-        if r.match(proto):
-            default_val = r.group(1)
 
+            if r.match(proto):
+                default_val = r.group(1)
         if not declaration_name:
            self.emit_msg(ln,f"{proto}: can't parse variable")
            return
-- 
2.52.0

