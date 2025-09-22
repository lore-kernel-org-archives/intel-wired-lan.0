Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38806CAC5B0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Sep 2025 10:16:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BBE440C55;
	Mon, 22 Sep 2025 10:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4WNvSP7hAGj; Mon, 22 Sep 2025 10:16:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B250840C75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1758536167;
	bh=HDGo5NsaOWxAVdRlSv/qyz+9ho8tgsHJrjJhMpfwDKg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oBK4kuOCVNpnVqWSwalLH15lhZBkpdAxm/jm3p2c0N3KHM+oLDmA7ih6jGgbwMvEs
	 bweVSQPa/FBpWZjvWkqX5xU/lZ59KxM2HbYTWc/K8/7jYVxTRKIuDVyscQYTzinNkS
	 3kRrqxsXzH+vYcR3GVs6r5yUcxqmtnkg6YUC864twGONRMvIN4HN1pGlLiDOQ9Gnwo
	 D8zhO0Bkkvc5q13zwwpS68cr9NQB5CGNLUj2OOkbRC2zRub+KoY4c38r83dCian6pi
	 ZPDIjrWh7XsseFaQA8QJ/5nM2FLJAPf6okNMTzHX+hMiO+uJ+k1j9FEeS79fOtSyXa
	 q8i/7Ip+NdIBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B250840C75;
	Mon, 22 Sep 2025 10:16:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 58AC6E7
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Sep 2025 10:16:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5694640C25
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Sep 2025 10:16:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b8Vgsk35_F-q for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Sep 2025 10:16:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.180;
 helo=out-180.mta1.migadu.com; envelope-from=vadim.fedorenko@linux.dev;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 99F9540AB5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99F9540AB5
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 99F9540AB5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Sep 2025 10:16:04 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org,
 Donald Hunter <donald.hunter@gmail.com>,
 Carolina Jubran <cjubran@nvidia.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Date: Mon, 22 Sep 2025 10:07:41 +0000
Message-ID: <20250922100741.2167024-6-vadim.fedorenko@linux.dev>
In-Reply-To: <20250922100741.2167024-1-vadim.fedorenko@linux.dev>
References: <20250922100741.2167024-1-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1758536162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDGo5NsaOWxAVdRlSv/qyz+9ho8tgsHJrjJhMpfwDKg=;
 b=lNjX83gKigV8Zq5tP4myLVb+/Zti3ma0DAq5FTzqZKttCZFjNRtJ/X0Lxlcc+rl7P+y1lW
 Q5XJ5wsG26N8wi2ARIawWE21E3RNSvY9aW+CY0S1kxOZkEmIoZZbhhVpMLJhrdQbaZiy/y
 8dJhA4jE1YKlbAVkc3x9FmXRyZVVPQg=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=lNjX83gK
Subject: [Intel-wired-lan] [PATCH net-next v5 5/5] selftests: net-drv:
 stats: sanity check FEC histogram
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

Simple tests to validate kernel's output. FEC bin range should be valid
means high boundary should be not less than low boundary. Bin boundaries
have to be provided as well as error counter value. Per-plane value
should match bin's value.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 tools/testing/selftests/drivers/net/stats.py | 35 ++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index c2bb5d3f1ca1..04d0a2a13e73 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -57,6 +57,36 @@ def check_fec(cfg) -> None:
     ksft_true(data['stats'], "driver does not report stats")
 
 
+def check_fec_hist(cfg) -> None:
+    """
+    Check that drivers which support FEC histogram statistics report
+    reasonable values.
+    """
+
+    try:
+        data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
+                                         "flags": {'stats'}}})
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("FEC not supported by the device") from e
+        raise
+    if 'stats' not in data:
+        raise KsftSkipEx("FEC stats not supported by the device")
+    if 'hist' not in data['stats']:
+        raise KsftSkipEx("FEC histogram not supported by the device")
+
+    hist = data['stats']['hist']
+    for fec_bin in hist:
+        for key in ['bin-low', 'bin-high', 'bin-val']:
+            ksft_in(key, fec_bin,
+	            "Drivers should always report FEC bin range and value")
+        ksft_ge(fec_bin['bin-high'], fec_bin['bin-low'],
+                "FEC bin range should be valid")
+        if 'bin-val-per-lane' in fec_bin:
+            ksft_eq(sum(fec_bin['bin-val-per-lane']), fec_bin['bin-val'],
+                    "FEC bin value should be equal to sum of per-plane values")
+
+
 def pkt_byte_sum(cfg) -> None:
     """
     Check that qstat and interface stats match in value.
@@ -279,8 +309,9 @@ def main() -> None:
     """ Ksft boiler plate main """
 
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
-                  check_down, procfs_hammer, procfs_downup_hammer],
+        ksft_run([check_pause, check_fec, check_fec_hist, pkt_byte_sum,
+		  qstat_by_ifindex, check_down, procfs_hammer,
+		  procfs_downup_hammer],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.47.3

