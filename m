Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D508D358D9
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4753460888;
	Thu, 29 Jan 2026 08:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1L9P1hWXHU1T; Thu, 29 Jan 2026 08:08:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABB6960889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674128;
	bh=Dvivad/C+bWYpV+C7Kzin/HuGjEaJYclGH/FeKPEdp0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZYi0FL+izdAjCN0EU4TrMxA54diPloNGgsM0hRHDdKy/XpGnuT3PGQeeh2fLl5PQQ
	 x5woZAuP6eLeg5th5p5TVfCJJB7UsQIV+38+4+ErsuxHHQD3E/sYZk65rdxxa9oPhT
	 WqqVNWcuos+v2mrdHspkC2HIekJWsg1msVHGnWTx1UrhhoAmZ1qu8NmA6v/DgtIi5K
	 9tH4RmQaaRWrb+RkLv5981WkyugHq2RHRzdPxWZT0p/Y2gkB9PVA5Q+c3RsksiB556
	 5OeN2sGg62m+qP54O5pFvIxihIXFVHJLP6SJoJBNL4n04/mrzra2PKGutH9c4ne+5M
	 5jYvjp0l5wNeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABB6960889;
	Thu, 29 Jan 2026 08:08:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1B9B4118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE80A60856
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x8_uuMu0L7Tg for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 56E5C606F6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56E5C606F6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56E5C606F6
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B11060132;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2EAC2BCB6;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4n-0000000EROH-1jpG; Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 29 Jan 2026 09:08:18 +0100
Message-ID: <50ef80ed8a1a638d08974e55a7828371bab09c0d.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674111;
 bh=aAYr/rdf8rPhk+DzwcPpBGhnCkODn024mb+J5zDgPZA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HxEvSNHQEtL0D59ODsnQi0p3l8kMpRAIJaWt8HUV5lvtVPe2caGw5Z0eLuIIQN8Cr
 4xRaxDBGT+igKQhlHOaxNvX+eFQ6ZA82YxsTv0FjkNdeBvTBYl+iYm50wea3VTsOcQ
 fKt6u+LN7F4u4p4Zx30THYRuTvRzoAHmjiH9PlcAVFT47GW9CKIqfpogm1q0jwt9b3
 7RjMh3jWaL0T1izR+e8ryofdpsfSH4aWF1PVlipelfiqJLjpGEWRmXNp90sSw+dIzh
 /5erIn2XU+qhq6rfbrfcgR33uPNecU9q3U2RZybpjFOVd8oICaZfNpY9xMZj77zvIS
 xM/EStNmmUzQA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=HxEvSNHQ
Subject: [Intel-wired-lan] [PATCH v3 27/30] docs: kdoc_parser: minimize
 differences with struct_group_tagged
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

While the previous version does a better job representing
the actual struct, it ends losing documentation from each
member.

Change the replacements to minimize such changes. With that,
the only differences before/after using NestedMatch new
replacement logic are (at man page output):

    --- before.log  2026-01-29 06:14:20.163592584 +0100
    +++ after.log   2026-01-29 06:32:04.811370234 +0100
    @@ -1573701 +1573701 @@
    -.BI "    struct ice_health_tx_hang_buf  tx_hang_buf;"
    +.BI "    struct ice_health_tx_hang_buf tx_hang_buf;"
    @@ -4156451 +4156451 @@
    -.BI "    struct libeth_fq_fp  fp;"
    +.BI "    struct libeth_fq_fp fp;"
    @@ -4164041 +4164041 @@
    -.BI "    struct libeth_xskfq_fp  fp;"
    +.BI "    struct libeth_xskfq_fp fp;"
    @@ -4269434 +4269434 @@
    -.BI "    struct page_pool_params_fast  fast;"
    +.BI "    struct page_pool_params_fast fast;"
    @@ -4269452 +4269452 @@
    -.BI "    struct page_pool_params_slow  slow;"
    +.BI "    struct page_pool_params_slow slow;"
    @@ -4269454 +4269454 @@
    -.BI "    STRUCT_GROUP( struct net_device *netdev;"
    +.BI "    struct net_device *netdev;"

e.g. basically whitespaces, plus a fix NestedMatch to
better handle /* private */ comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 50d57c6799bb..1e8e156e2a9e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -126,7 +126,7 @@ struct_xforms = [
     #
     (CFunction('struct_group'), r'\2'),
     (CFunction('struct_group_attr'), r'\3'),
-    (CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;'),
+    (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
     (CFunction('__struct_group'), r'\4'),
 
     #
-- 
2.52.0

