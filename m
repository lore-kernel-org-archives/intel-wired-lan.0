Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31E8D79745
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 14:25:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA0F560B7D;
	Sat, 31 Jan 2026 14:25:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NxavmvY_lSRt; Sat, 31 Jan 2026 14:25:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D749260B4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769869549;
	bh=R9k3gi5WAwLLfRFbONKk4Z6cOv+7EZ4eRK4QB/mvfxY=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ttMe23L+lyckcdT1nri7f9Ugzs1QiMwj+1PgdAlWXsuXtIAdRFzrQlIQT4JkM2rVv
	 Tj57Ezla+CrxJNEYkhxiA2oAvhBWgVJpSKaPlBVme9/9spE8P9oRFrhpWMKZryBrJ/
	 zrE0Sz4TGEMs7uQ2Eo6LIXBIce5fqM43FYoGOe0o4PWQwiIlYvp0/PLr+oT6J5tQu5
	 +so+22296aXmg5z2XJaweVCUZXlzjLuLdrKMJ73L9LPuR6wkRvmbQXJeOTOJS1noz7
	 9TMS3SwokIb/P4aNALy4byL+onIwHf4ZDnol2Ebgw/2ULircrmeSTw+feDHsEkydRw
	 lBkXMAUvUylYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D749260B4F;
	Sat, 31 Jan 2026 14:25:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1ACAB69
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B97A60B53
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vN14VTE9xbQb for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 92CA06064A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 92CA06064A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92CA06064A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 34E436012B;
 Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E28C4AF0B;
 Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vmBuZ-0000000AVki-31UN; Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 31 Jan 2026 15:24:49 +0100
Message-ID: <6c8e7354e4aa7042daae46b8c778c4195de10df6.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769869521;
 bh=T/tjtljgzM6ONqM7zhOV7Yk4y75K/wRjyLKxDsGKFtU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FkI80vV6n8l3oW8lP1wSbfB0XPQ8C7wAan32GnKk0HvATwLICSCBRX2x6QZ/ajzb+
 Ty5boZfyRuzsQg+Y9QsgOtZuDo4SUQr5lWk4jjwgPg7sc4Yav4O2DQJ9iZJgZRapyk
 E5ybY6Y6tWdiOxZoq+qVgvQvlRKvEgzNJz4eQDcSIXQW6TG/N7AFZby0zH99zIjXPj
 cIbzMxpTBUBrrG+nQMWj/sSNLVW4zVVo8sKcrA/2g7VEBI6B7QSnSTLv40mVqoilIe
 VZoOB0MMKmay6en0IPHcwFqEkQReiNZw9dZhbf+SHLnfBetOI7e7/DCcZMYpMvEWr0
 NYIjs6aVBSVBQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=FkI80vV6
Subject: [Intel-wired-lan] [PATCH v4 15/41] docs: kdoc_re: properly handle
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
index a0402c065d3a..1861799f1966 100644
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

