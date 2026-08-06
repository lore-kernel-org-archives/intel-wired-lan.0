Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C760C5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Thu,  6 Aug 2026 23:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0BB8640903;
	Thu,  6 Aug 2026 23:29:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sNqBJoUAnTCE; Thu,  6 Aug 2026 23:29:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FC7B40907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786058974;
	bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j+iAP1EPlvRbqQ0F9kTUV0ds9WcfsmRqDjwIz1kKkAdbGEBmeclu0/y3KFylIinQR
	 k3HYoIcSlp0FLI9sZ8At7vx1i1FKjos18dEMpfpb0Fbou7zMS+FeQzJJwe/4PkKRaj
	 xXgHbFCbvwCIR/YQqC15okVED4SsDh6aJ5XzEWj72+F+j+yMsL+DeC4sAVm576ybdD
	 jEXmEpZ1gctGZPHbOLPp+4b0glyJMG35IA79Y/Gp9cij7WC7sSTs2OPoM/ubuPJie3
	 RTNGxr/X4S6IEbubcDonITSldy0zNehFV8Mr8ojQpwQORem1znJYAs8utzSAHtqbyG
	 SzzCl44H3qNUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FC7B40907;
	Thu,  6 Aug 2026 23:29:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F101198
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D44080F8D
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZfdPr3HpnG8 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  6 Aug 2026 23:29:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b134; helo=mail-yx1-xb134.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9D41080F8B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D41080F8B
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D41080F8B
 for <intel-wired-lan@lists.osuosl.org>; Thu,  6 Aug 2026 23:29:31 +0000 (UTC)
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6688dfaed31so4367442d50.3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 16:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786058970; x=1786663770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
 b=YnnIeb4RtGJTTITMOpXkR0c5XW+6Vcb4XmYQ/IcPJGRcEkyWYEoelhql8G0XdSRUDA
 V+IJ9AyYdYoAcmfMbXSYzymrCHqsoSnVVxfkAsrf+WaZNokQIdqVGuB+aMQ2FqXTTALu
 AU0TXQd3ohJ2W+ZtjeBpsSowBlVH3S+fdx/fQ7tH7M5MlYtGuAk8DVr1G/hWapBCW3xg
 GAu4JCDDLOHaB4i+HWjGhbi7ePUJBbeo7Pklgv6yLXlhPIB8sZKBYldy7AGvB5wZoE6M
 mIw5oJowoPjtPgjlWYadLwPlW4Kxk+tKwBZYvNW1wEihxTz9++cDyP99oPn3k04tXBd3
 V1jw==
X-Gm-Message-State: AOJu0YxdKBygmupmSxQ8pS+/YCoeg8P4XZN16kN3K91Bgv+9BgIIfCHq
 G1yAFjmHV1Cqmz2McX5ZZndx211QEuyLJdp3HxHstfxKPw9fCC/hiwXJ
X-Gm-Gg: AR+sD11gXjQeB7INJnPa1bG/O2zSN2P8JdvFwiKJCoqT7hYCaTYkZz0oFzx7CSdYO+g
 JwHcQYN+CwMt/c7hqfXCZN7bV1UiW9Qw5ZLJk793/tiNTSa3sghyEKP+Y8zY8jE7sNQpkNL4Dh3
 K+f33XpKvt+/RgZj6cH6LWfiTmJXKdFAWCF14P/oG07IzvOZHn8ORco7SnmqqJ0Npn9G61UEKDS
 fIBVZCTKSVgCqnwKiT0AFb2RBuK9OEW+dlXfRzRh+bTIWQKv8G1sPY7wEsIbSnWiSCThEbF3/eu
 pxYzOtucv925vSTXzDJveqmel/3yElup/g0TZYIfCVyaKOrdqwoH7fCcXPjFwN08JLTRcVFDYPi
 KHpeApmvNnG05BfnNT9ugaJUXhB7RUCLJ61ok6xn+6TbKjms8BdyoPsdCl/XpFxIL3PUgrh1Ao1
 5ClMNfGtoYgg+tzRi1V/y2uenVML0pEDgbZWET6kYfjMFke2YeFcVVznub5Ox9fBuN03b2SrVBO
 ugPu7ZM7MVU99NHGKh3y8ySTpt6UBw+StbNlHNvv1vfpEE0G18AwQpkj7o=
X-Received: by 2002:a05:690e:445a:b0:668:713d:893 with SMTP id
 956f58d0204a3-6699a91a8efmr8651954d50.4.1786058970362; 
 Thu, 06 Aug 2026 16:29:30 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66acacdbdf2sm209273d50.4.2026.08.06.16.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 16:29:29 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Thu,  6 Aug 2026 19:26:03 -0400
Message-ID: <20260806232913.4020403-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786058970; x=1786663770; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f6avniWt0KYSUT1rJggrxMEdUFeAg0dFqmkqy+4409U=;
 b=pIJF5E4c2ahvE+Ki/EVxPXXSYdLG7GgsP0tBqU71xHXHnAmF6di9CKlyNhLYOD9xeG
 kCVabFFVbPxU6tDPnaLcowT+9NawEUFAQKgVLY0lW8RPGxzOkmVyS3os/0GYKTEGc5Ej
 l1oOarZyTgxjyuX+KbdWDfHAkgVTiBPj9gXzemILuSdk6YCSlSokm5fpjcm27vbKXRBM
 wRMM+vhspUYaZDjfyPgC8HpJL2+Mud2LcxdZT9IJUK1A4aGx3dBu6qER1kz3d+6vyM0N
 QHss0JYzsntK3YZMHWBMwnEfcIys9i1Hvz02gy2mS10tZ+SfHyeILR6ClA1UTb7uIvy6
 C7ig==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pIJF5E4c
Subject: [Intel-wired-lan] [PATCH net-next v4 6/6] selftests: drv-net:
 extend so_txtime with hw offload
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

From: Willem de Bruijn <willemb@google.com>

Add two pacing hardware offload variants

1. one that uses FQ to safely offload when within bounds.
2. one that uses pfifo_fast and thus forwards all packets.

Verify that the packets are paced in hardware with new flag '-H'.

Also increase rcvtimeout significantly to reduce flakiness. Especially
for the new beyond_hw_horizon test, which is close to the 100ms limit.
But update recv_verify_empty to take MSG_DONTWAIT. That last empty
check must not delay each testcase by the receive timeout.

Hardware pacing offload can complete packets out of order. So the
reverse_order test is expected to pass with pfifo_fast too.

Do not test ETF, which does not change its dequeue behavior based on
pacing_offload_horizon.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v3 -> v4
    - replace ethtool with rtnetlink APIs
    - expect_fail: correctly handle negative test pfifofast beyond_hw_horizon,
      also when KSFT_MACHINE_SLOW suppresses timing errors
    - commit-msg: clarify that rcvtimeout increase is also needed for
      beyond_hw_horizon test
    - define the horizon (50ms) once, rather than three times
    - leave cfg.require_ipver in place
  v2 -> v3
    - remove drivers/net/settings timeout change: superseded by recent commit
    - add reverse_order comment
  v1 -> v2
    - re-raise NlError from e (patchwork pylint)
    - simplify expect_pass test (patchwork pylint)
---
 .../testing/selftests/drivers/net/so_txtime.c |  4 +-
 .../selftests/drivers/net/so_txtime.py        | 75 ++++++++++++++++++-
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/so_txtime.c b/tools/testing/selftests/drivers/net/so_txtime.c
index 951312e67b66..9028f9e5a411 100644
--- a/tools/testing/selftests/drivers/net/so_txtime.c
+++ b/tools/testing/selftests/drivers/net/so_txtime.c
@@ -155,7 +155,7 @@ static void do_recv_verify_empty(int fdr)
 	char rbuf[1];
 	int ret;
 
-	ret = recv(fdr, rbuf, sizeof(rbuf), 0);
+	ret = recv(fdr, rbuf, sizeof(rbuf), MSG_DONTWAIT);
 	if (ret != -1 || errno != EAGAIN)
 		error(1, 0, "recv: not empty as expected (%d, %d)", ret, errno);
 }
@@ -379,7 +379,7 @@ static int setup_tx(struct sockaddr *addr, socklen_t alen)
 
 static int setup_rx(struct sockaddr *addr, socklen_t alen)
 {
-	struct timeval tv = { .tv_usec = 100 * 1000 };
+	struct timeval tv = { .tv_usec = 600 * 1000 };
 	int fd;
 
 	fd = socket(addr->sa_family, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
index adf6c848d6d8..24a686eda562 100755
--- a/tools/testing/selftests/drivers/net/so_txtime.py
+++ b/tools/testing/selftests/drivers/net/so_txtime.py
@@ -12,7 +12,9 @@ import time
 from lib.py import ksft_exit, ksft_run, ksft_variants
 from lib.py import KsftNamedVariant, KsftSkipEx
 from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
+from lib.py import RtnlFamily, NlError
 
+_HW_OFFLOAD_HORIZON_MS = 50
 
 def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     """Main function. Run so_txtime as sender and receiver."""
@@ -32,10 +34,39 @@ def test_so_txtime(cfg, clockid, ipver, args_tx, args_rx, expect_success):
     expect_fail = not expect_success
     if slow_machine:
         expect_success = False
+        expect_fail = None
 
     with bkg(cmd_rx, host=cfg.remote, fail=expect_success,
              expect_fail=expect_fail, exit_wait=True):
-        cmd(cmd_tx)
+        cmd(cmd_tx, fail=expect_success)
+
+
+def _dev_setup_pacing_offload(cfg):
+    """Configure pacing-offload-horizon."""
+    rtnl = RtnlFamily()
+
+    try:
+        link = rtnl.getlink({'ifi-index': cfg.ifindex})
+    except NlError as e:
+        raise KsftSkipEx('getlink not supported by device') from e
+
+    if 'pacing-offload-horizon' not in link or \
+       'max-pacing-offload-horizon' not in link:
+        raise KsftSkipEx('pacing offload horizon not supported by device')
+
+    horizon = _HW_OFFLOAD_HORIZON_MS * 1000_000
+    if link['max-pacing-offload-horizon'] < horizon:
+        raise KsftSkipEx('pacing offload max horizon too small')
+
+    cur_horizon = link['pacing-offload-horizon']
+    rtnl.setlink({
+        'ifi-index': cfg.ifindex,
+        'pacing-offload-horizon': horizon,
+    })
+    defer(rtnl.setlink, {
+        'ifi-index': cfg.ifindex,
+        'pacing-offload-horizon': cur_horizon
+    })
 
 
 def _qdisc_setup(ifname, qdisc, optargs=""):
@@ -56,6 +87,7 @@ def _test_variants_fq():
             ["one_pkt", "a,10", "a,10"],
             ["in_order", "a,10,b,20", "a,10,b,20"],
             ["reverse_order", "a,20,b,10", "b,10,a,20"],
+            ["beyond_hw_horizon", "a,70", "a,70"],
         ]:
             name = f"v{ipver}_{testcase[0]}"
             yield KsftNamedVariant(name, ipver, testcase[1], testcase[2])
@@ -69,6 +101,39 @@ def test_so_txtime_fq_mono(cfg, ipver, args_tx, args_rx):
     test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
 
 
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_fq_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic fq tests, with offload horizon."""
+    cfg.require_ipver(ipver)
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    try:
+        _qdisc_setup(cfg.ifname, "fq", f"offload_horizon {_HW_OFFLOAD_HORIZON_MS}ms")
+    except Exception as e:
+        raise KsftSkipEx("netdev does not support offload. skipping") from e
+
+    # Expect all tests to use only hw pacing, except beyond_hw_horizon.
+    # Do not pass -H to that test so that with sw pacing fallback it passes.
+    hw_only = "-H" if args_tx != "a,70" else ""
+    test_so_txtime(cfg, "mono", ipver, f"{hw_only} {args_tx}", args_rx, True)
+
+
+@ksft_variants(_test_variants_fq())
+def test_so_txtime_pfifofast_mono_hw(cfg, ipver, args_tx, args_rx):
+    """Run all variants of monotonic tests, without fq pacing sw backup."""
+    cfg.require_ipver(ipver)
+    cfg.require_nsim(nsim_test=False)
+
+    _dev_setup_pacing_offload(cfg)
+    _qdisc_setup(cfg.ifname, "pfifo_fast")
+
+    # Expect all tests to pass, except beyond_hw_horizon without sw fallback.
+    # It will send immediately, failing the receiver arrival bounds check.
+    expect_pass = not args_tx == "a,70"
+    test_so_txtime(cfg, "mono", ipver, f"-H {args_tx}", args_rx, expect_pass)
+
+
 @ksft_variants(_test_variants_fq())
 def test_so_txtime_fq_tai(cfg, ipver, args_tx, args_rx):
     """Run all variants of fq tests, but pass CLOCK_TAI to test conversion."""
@@ -108,7 +173,13 @@ def main() -> None:
     """Boilerplate ksft main."""
     with NetDrvEpEnv(__file__) as cfg:
         ksft_run(
-            [test_so_txtime_fq_mono, test_so_txtime_fq_tai, test_so_txtime_etf],
+            [
+                test_so_txtime_fq_mono,
+                test_so_txtime_fq_mono_hw,
+                test_so_txtime_pfifofast_mono_hw,
+                test_so_txtime_fq_tai,
+                test_so_txtime_etf,
+            ],
             args=(cfg,),
         )
     ksft_exit()
-- 
2.55.0.679.g6767b8d81c-goog

