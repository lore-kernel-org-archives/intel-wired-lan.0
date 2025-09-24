Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3524CAC5B5
	for <intel-wired-lan@archiver.kernel.org>; Wed, 24 Sep 2025 12:41:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D87D81368;
	Wed, 24 Sep 2025 12:41:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JV5lTcEQMy1D; Wed, 24 Sep 2025 12:41:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9C9181367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1758717661;
	bh=HDGo5NsaOWxAVdRlSv/qyz+9ho8tgsHJrjJhMpfwDKg=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CI1mnbZOz9BWRLVq9+IQ63N+uFVuG1DyVTQLjSJE0xH6MWdhtCWuHQdZsR8sSZwou
	 kJS5vPbCZJqWi8NN3m+TndBqLf2+ElaIQKPOsXT9Zhb9b/Bg6mA7hDUpnWYKyADWd5
	 /kRR2D2lAajEQ2QrT7aL4PjaMhn7Cic3G5X5LTztMuIUQcs7gIdqejwCo6xNLGnRVg
	 IfsL7tmiC/evLdK5FSwdhRRE+q1Ejg9QY8oVm7kT0y6lFPL1GTU+Cl+W1flOdDrpOi
	 RrZlxFwP0uYfa/753rVzIO6DkoNF/fsPlMnPNvMiwsn5d0FhN5mo7uLaDo1kB5c/j4
	 C9pJgsyq0W1Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9C9181367;
	Wed, 24 Sep 2025 12:41:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E64D199
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Sep 2025 12:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6292581368
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Sep 2025 12:41:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJ8m8JiUGEpg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 24 Sep 2025 12:40:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::b1; helo=out-177.mta1.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 81AFC81384
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 81AFC81384
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81AFC81384
 for <intel-wired-lan@lists.osuosl.org>; Wed, 24 Sep 2025 12:40:59 +0000 (UTC)
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
Date: Wed, 24 Sep 2025 12:40:37 +0000
Message-ID: <20250924124037.1508846-6-vadim.fedorenko@linux.dev>
In-Reply-To: <20250924124037.1508846-1-vadim.fedorenko@linux.dev>
References: <20250924124037.1508846-1-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1758717657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDGo5NsaOWxAVdRlSv/qyz+9ho8tgsHJrjJhMpfwDKg=;
 b=lnj7V6jVdd2CvGFzsSfvI3rdiYtpqSC7u8a3TT4EUOAqhCEVA25a8Jf7uI4yQo1GESlI+x
 yVVv/wr10j8dAgWTzZncnQ3Hf7CL0mfSBNHlTRN6dSkmXAPnP+3+1ldUuycAJh/NWBBNdu
 Qgewnx4oS6lTfDkrh7Zq35coq88v0NA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=lnj7V6jV
Subject: [Intel-wired-lan] [PATCH net-next v6 5/5] selftests: net-drv:
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

