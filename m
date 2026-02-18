Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D8E9A03B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ED06A407CF;
	Wed, 18 Feb 2026 10:13:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yv5SX8OXqS9z; Wed, 18 Feb 2026 10:13:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57B4F407D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409618;
	bh=wmd6cajhBeqS7MwWAWNkj6+KB5KQsyjtGNRBV2rfse0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EqlhXCGdqTUjHNCVN2J6cD4cOCkRS3KaJjdIRCRq8igFH2AQVW/J4G5RIAhqOsTGQ
	 +HN4YqS0e1CQ63eoHluYmyxcg+9OnU8xmF+2mOjjxhicCHv3Cj0Lna65y4Vm11cOd9
	 WnrppFl1yULbfoKbgkxEdaKo9tr3MACQV3/OgWB+eRmXkzliqwefLcwwNIKLN+urUe
	 FehMOxjEg9fRjxsGjhurlcp3gubZKkdxY2ifTkPhbJT0mFZhodRZ/rD76vnxN3eotk
	 nbyxAeRNDQVMi+qFTzpdzgUc+WYZZwOM2XRIMwhQh3yFR/xVavdnSeXJakevUR62Mh
	 OynoEUGPOxb3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57B4F407D4;
	Wed, 18 Feb 2026 10:13:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C79735B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E46C60650
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3jqzDCVdizl for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 93208605E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 93208605E6
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93208605E6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 59A40437A6;
 Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39346C19421;
 Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYh-00000000LsZ-1yLx; Wed, 18 Feb 2026 11:13:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:58 +0100
Message-ID: <24cce8e6d41b2f16698ac9f683b3f1df125e306e.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409609;
 bh=yQBydwNaRIYMlzU4Ubfa3gdUJcPIj4ppbNTFE+NM7Rg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nYJ1wD6tseePJcKQKbRGVSxpEMfowqnIii6b7lTyIP7X3gOW6ouyFqT1d4g2obgZv
 D9EJKHEKg0KjkEPQgzNK+VHrRWm1pRD14A1yuHHb7FuejYCUasnbNPvJg74BF6NDt0
 dXFEtVaASa+GJ4ENq4tXcaAyeo4B/TGRDlH0lzvWf7fHgdZTwX99oitgxNz0WSoSKT
 NUliYg2dFgzC/x+JPjBH55K/Th7gDFo71E9xxwtZAMfhu/xxLE7yCMJ4ZBrOSiCVQG
 rDvH/6/76wu+waqE+8vV+xRu/447e+OIlRnu3w7/+UPaTT1Js5edtbT/Qx8ik1sIoI
 67z4X3b9j1WXQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=nYJ1wD6t
Subject: [Intel-wired-lan] [PATCH 28/38] docs: kdoc_re: prevent adding
 whitespaces on sub replacements
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

When NestedMatch is used, blank whitespaces may be placed after
substitutions. As such spaces are part of the C syntax, we can
safelly drop them, improving the quality of the output.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index e3809aaa0310..44af43aa1e93 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -344,8 +344,12 @@ class NestedMatch:
 
         cur_pos = 0
         n = 0
+        l = len(line)
 
         for start, end, pos in self._search(line):
+            while cur_pos < l and line[cur_pos] == ' ':
+                cur_pos += 1
+
             out += line[cur_pos:start]
 
             # Value, ignoring start/end delimiters
@@ -368,7 +372,9 @@ class NestedMatch:
                 break
 
         # Append the remaining string
-        l = len(line)
+        while cur_pos < l and line[cur_pos] == ' ':
+            cur_pos += 1
+
         out += line[cur_pos:l]
 
         return out
-- 
2.52.0

