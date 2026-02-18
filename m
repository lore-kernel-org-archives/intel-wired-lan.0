Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC41E9A047
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1319060690;
	Wed, 18 Feb 2026 10:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GVXsF6KujeJn; Wed, 18 Feb 2026 10:13:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05035607DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409619;
	bh=HmUulhqmR9g1Pk2Yq99Pf0SlubS9h1H+P/NzhdhFEo0=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q6DLSLxJJbkn/oriPNUXo/v3KPOVdump1ujgarLR+mEvG8AX02gRktYSzpn3qICfY
	 O63UbZi/riOPWR1R59YZ1fFNrTKkJl5mGgko8tHxiEWK6To5XpEm6B7BUKKUWFeHzs
	 C5CrwbumgyZannG7misDM1k09+n49t658m9iZUXaKwKXti5XnrnRI4ZdAk7pDMKiQ/
	 3brS5FYjWj6RTi9LBkyen7Xe3KowxcKxNMmFm791AtQ6seKDWmTlx0VkiDndUh0s0a
	 7kpq4Kt5auWgNKuyzQrXFnknjGGMAqo1H3Gkmjv9TrMAj9VL7QVKryndWnaAUocg0U
	 zT+LwqI/wXwOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05035607DB;
	Wed, 18 Feb 2026 10:13:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 49DFE438
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3019D407F2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lbpe1gc01Z88 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4991E407EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4991E407EE
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4991E407EE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 109FD44594;
 Wed, 18 Feb 2026 10:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8E00C19425;
 Wed, 18 Feb 2026 10:13:28 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYh-00000000LrO-0bkQ; Wed, 18 Feb 2026 11:13:27 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Wed, 18 Feb 2026 11:12:57 +0100
Message-ID: <a472199335411724935cf11a75916b78071cb24b.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409608;
 bh=P5m12KaIRlLZkIbryHITxBCt1b6WqbNCa3v60HgP3pM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AAcfGmf63U6yk5n0NQY3nvBCQc9k0oCir9opirkc6aJj22+wR6i+ExY4JcFXV6lHL
 AlpJRtLXH0n8p7tzAOryvoSZ3bJYT0FTzib176Y21ZYCkhFkJjzyUBUudRykL+LAIV
 JkqNrDWo2oF1HI/eWoKXX9oYDtfA3fvHsERAk8kcdYLZA4I9H7IUreFLH54eGAEO3Y
 CXB9kn6Icb+6pNpn+2cWxQIkx1bVVSPHdAWU1YhBChEa6noGwMM4RdcNBRlwEoZlMN
 EOMOLG8k3FRMJ79uWF3keNgTU1suiFh/O/1Aa8TEMi36YSfCWjfUW9A2qELOzv9zCD
 kfEtW5H+6WcdQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AAcfGmf6
Subject: [Intel-wired-lan] [PATCH 27/38] docs: kdoc_re: don't remove the
 trailing "; " with NestedMatch
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

Removing it causes the parse to break some conversions, when
NestedMatch is used on macros like __attribute__().

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index f72b80ea4f1b..e3809aaa0310 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -361,10 +361,6 @@ class NestedMatch:
 
             out += new_sub
 
-            # Drop end ';' if any
-            if pos < len(line) and line[pos] == ';':
-                pos += 1
-
             cur_pos = pos
             n += 1
 
-- 
2.52.0

