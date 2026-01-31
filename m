Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E0DD7977A
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 14:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABC1040817;
	Sat, 31 Jan 2026 14:25:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F4-mo2hWz8zj; Sat, 31 Jan 2026 14:25:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD73B409E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769869529;
	bh=DvP4oc8ORpKMVfkhcdvMfCujewBq3dcM8Oxjun2tmSA=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ehsTXFV5LhpdhrbtI7WRbWmsBLKj7S+dKRSM1J7EeX03V2ga2Ih8P6t1cmz8ANcEC
	 dPNIdbucznyhsLrV+ovBjIFOTAY+e5xUbj22YSbuYvfKgYk9y2+3rtS0vNIquxMn6X
	 oSxHaAZrtL70NWOw1ebkvEV5+jF0sRqL8GyK4caxyf+2AyRFx6Pol7UbSpLH7zozsH
	 0/kuVojqmo1LaWGPS+Kf1Go9QW2rsapQfxNvtQRRJXUkQcPBNK2g/SNUwV5/lNgXRH
	 tpiKVBzBA1BRntgH10K3m70qn+Dqg/nnW3bQySvJe4PzZwLSWMFnmS8/b0g82/DGFD
	 3cEk1bfMEXFjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD73B409E3;
	Sat, 31 Jan 2026 14:25:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1292625F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA2ED60B50
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wz5uzdMqhO-7 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D567560B49
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D567560B49
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D567560B49
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DB9544448;
 Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7430C2BD00;
 Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vmBuZ-0000000AVlE-3xBx; Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 31 Jan 2026 15:24:57 +0100
Message-ID: <019e85b047f25aa5472d447e1ed087cd077a79f6.1769867953.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769869521;
 bh=3ksnXE7vkIV4Gy30ihYdParnXgZsaJn15iVxtzuvJ4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=maeQ6NIQqyOmmMZ1bq5xg5TRiG9YE2TRuw+KFDcCAsstytrpri5AUbDdMoLYCiXr/
 Rzio2GydR6Dv/NeY8AaELoinK8d3kO8b14GsDxBQOXiKDSIfrvkW8VRmUcxB9cEZgC
 fXjwoxKc20EccgAV+k3X/REHlwxfOR/k6YuxvsezhNWh+8S+X8rPO6+cVeCa2XjZOM
 GnM0CzQiWWMBEOlM30V2pP+ybuhnqmpUJToGMueBZ32g3EaVRy1gC7nL+NVQabpkRV
 UqhQyt5cLn+oBww9CIfdBLoka3VzVOScA55A2YjFcQ6k823LBoIjCs56dpbGTYn3wR
 8nre1pj0Z7i+g==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=maeQ6NIQ
Subject: [Intel-wired-lan] [PATCH v4 23/41] docs: kdoc_re: add a helper
 class to declare C function matches
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

Add a more convenient class to match C functions and avoiding
issues at the beginning and ending of NestedMatch inits.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 5f455ffff7b2..a49b42e3d189 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -380,3 +380,14 @@ class NestedMatch:
         """
 
         return f'NestedMatch("{self.regex.regex.pattern}")'
+
+
+class CFunction(NestedMatch):
+    r"""
+    Variant of NestedMatch.
+
+    It overrides the init method to ensure that the regular expression will
+    start with a ``\b`` and end with a C function delimiter (open parenthesis).
+    """
+    def __init__(self, regex):
+        self.regex = KernRe(r"\b" + regex + r"\s*\(")
-- 
2.52.0

