Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E30CA5FF1
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Oct 2026 06:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 107E780EE1;
	Wed,  7 Oct 2026 06:05:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id azTjsgYt8Esj; Wed,  7 Oct 2026 06:05:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1260280EE4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791353129;
	b=NDrV9SmyM2dyydJH4qDXIbtlAaNXm5XAeYgZ+a3qTjS+gEGjQm+TTbvTesiBsXRahMHQ
	 xFnyDRvbUtLNrUxnxT5JMRGrUF3nP0f4M0XIDFQtJvH2ieDbZultld5RleoSQEVbgJCwg
	 oaD08/7tbnaBou/7vfP3ciVskexzeX+fNHKh4AH8YGdWbyKEwm6pmXjWfGxcyAaGf9DO1
	 g6s9wmJNZIYG6tj8i3MrfbdM9LPWdo/X+tWP83OLKc/ioX0MHsaudERaEhrCGXObp15aV
	 XnSGBDu5sSZM8rmeKhYNoRWvQlzcBkI0FX7xFu3mMxQ+iTYB7y+LlGvG6iP0bVJ+6Uw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791353129;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
	b=FZzOJBbrMk/i8mgmBtadGA3XNUzK66AhTiJR+IssgrWEj2cKcWfjXo4Q5MDlkJ2h3nAV
	 Bx/E/KRSYtikrverqQh+t3SVvrJc03ETh8nTCySOWeQC9AZO/udsi+zQA6PXdL/9CrXZW
	 WM4UwH5uAp6NUDKZphIAWhUz1qX0E3VMK9f62p2c0pknNTUTNmAMyc03M2DVTiIxXcHlZ
	 83M1aVC2csO+KCeeS2/pHERh/1fMnGGAQzAFyfsjxqLQryV3RQ6vNkU2i27+0vMw6LBaK
	 kfZoJ9FxFhxcZqHKwmPfiyI7MIesS4np9ONgMOdUzICi1Z3SdYi704AXicPPBUinxlw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791353129;
	bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=afLnRxl/dyT7KCEGmGFUq8y+sjQ4Nyzm4Q/z96QBZybj8eV5rDrCqIHYiLveW7yrB
	 56hy7CRNWMb5bOLojV//29sIBZUHK17wMyfmAwBej03Sl9xlOjYmX9T2P0tIyip6+9
	 0uKybqe236RMRRzs9Q+0C378MM5W/gwXWC2gSr19gN5VNA5uUq/J3LObC5BZvAki8f
	 7qbzn0alepKf8tc5MGMBbdxMaiTPTvgMlW4zSiIWPy49dyXzId8U3BTbEyGVr6En4c
	 9EuXaJ+TG+omcZn7mmzgEybmwKIkqNygcKqWkOksh6cyHHvW37Q1nEaHmUAKfRVapq
	 Wh41arqPom3NA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1260280EE4;
	Wed,  7 Oct 2026 06:05:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6832E1D2
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 05:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 598006065C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 05:57:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tiMJrHrZb-TG for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Oct 2026 05:57:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 363FF60616
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791352674;
 b=esyyHYTDlUFQCny2wTagMQ6ljbb1N7S3jMNbMb6T1KhGfiymbSmIiIsBPczDAOc/LIBC
 bXe8DmX0uyKReH/n9iBq0alo1qt0tITxQcPooGeJM6pAkJx64bp8hdU94QcVvqm5T9Tw7
 M5MBAUSfYvYICrvfWOFLeT1cuLz0W815tqwRXW7zf9dToPUCMBev6eNoToUSvmWJnxMkm
 SkJXEX1dNkmWVpxFuSFEvt5FjfXoPevN+2r/zXwuJsMqjFfUuS/+gNbXuFq+Q79hC1TPI
 6gAOZRXoOVhjYxChhDAPqQKrntgzfi5zxwxdAgtGr6HxI0eBfHpOtTeKtI6sH9TVLBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791352674;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
 b=pMQ/O8pNTRQ+dj3QmzlGbVFqAh4it+oLbFeNxkHceCb07W8ZPuRRvGxoDwfF4bT3alYc
 dOuIdRnJGKReXJ/RaOCJ0SVuKnX1zxLtunKeA9zXB+F/FLBUXGA0mWbm/N01dHN21dwfC
 f6Ar6xhKbSHJxi6gM4JhaTIp4vysSrv02kyJD8r4tNHRTnbowt6y51GbbCMl8M8vU3x3S
 U9dSkxxszD/SW7JigXAUhxAzet21DRklZtfxBvcWuSDKFxhiWt7rjiVI2PX+wPrFPTLUd
 AbTCylZFWWl5dVkzh6Rt23OTluwg/SB2EnWB0VJ5CROn5UXBf9vT1AeZf3vvk6mZGIw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fqsP8KEd; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fqsP8KEd
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 363FF60616
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Oct 2026 05:57:52 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3a49623b865so2235019a91.0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 06 Oct 2026 22:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791352672; x=1791957472; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
 b=fqsP8KEdUagm7ybmgkdQnxI+ouO1dsnAqHaiBIUeHhtcaV1/p1qG+B4TACLqHsNqS/
 3SRi1uyDlrxBI939eMw7Kd9H1E2V1afbZx9viIRw203w+gRiFnWSnOcYsyp5FUoZ5Ak8
 viLFkURh8+dTIzRx1/Q04d3u0DTEpGqvOBggzdHss7nRiyuXTakAH2OlR1hgEhkpLGp1
 yCZO0kixSlj57FOwcpt1I7kWqKMegaCO8MyvWqoX+M8ggnnu+vdhUuGK7NL0YdtnNIi2
 YEP/0qgFeZIwMJMiCZI2E2M88ZZcOW4a2jP4k65l5MIUNJLqfa8lIvQd+IpY7Faue0Wu
 +r0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791352672; x=1791957472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ikOwxns0VmdI3pIxqCsYIX0nHfPqhedZNBgRsLYW1pU=;
 b=tSXeT3jyfEM8PnvI2ZG16LxTu8yRFjTGHz8qep62N09fHakIUShVKCGdwZ3sXo7WHw
 rkKiLSUijQtJe7/pLKc7CByar6D2EDy4INxnHyHCSotu5JpMR9r/USIepkDDSUs5WX8f
 ocNEgJSOmnj62HcedSQs1CL3CilPrUVquPQx/sKXVBNMbEqzTcpdiEGlNEV1EZ6MIHIj
 UN3nSHK+2/pZx/MlauCihzK1/z/HO57HWmpm+fP8LCmK/h2R+ueaXg0r945/tBc+/S5Q
 YyDlHhxJ9sAmFQChQrTWk7r3SUW7qYWkFKBH7V+3uhldWd/eeFh1mQsmG/kIZ64yvd4F
 vmGg==
X-Gm-Message-State: AFq9FYKRKrOfazN50JQk/nj4+W9fZ/ZQzuIxDqitRNClpxLprpDI85ce
 FWhKdVpsnl9dOKGgkxz18uw1yvPvQEwSOkxDITdwVCNpveufuqRsI/cvOnh/bw5b
X-Gm-Gg: AYBFou0yssH2eKF5GWzQhjjfOOBMzaBDLmV9KEgtRtG53H3rMTAD+JSF7vo5hJuE8Eq
 SgEIA+FrHMk6k/L9a0EhWW88JMOK2k5V62H+pNdt/rxt7wouABvNF2Ll/YWSXZHS++qDhGc1Ski
 UXScK0PyImOU+j0ShVYcPY//GobqsigVry90setbFWW9H84Y/1vSwlvvoyQJSR6ifu1NkuScXGX
 RYBa/Gm7vGjeViLXf+NQeUS2H3bJDM5nhEmTgf+eVsSPSkZScrw7DO3a/wIIfJ7k9zUI+glwNzG
 DofN8q8PS8PMOMLMXcVnL73OkV0AzsmAFpmSO/uFDg3JPytv8Vba+fp1lEpkc3U2b0w3kesk5+f
 NAerIOrFWehsuVNfnqueb03NZX4/G0XwlQgcIYzUN3A+yzXo4iWzD0BkCaQggJ6NgTazF/DjjO3
 9R7DRSb1Ap0leqgWKzkZ8zrmzzlZVak7tYnU4jC8/HQ99Q04sn9DYjtctfWJaJfGvZ7RwZ/GqgH
 Q8Co5bXc6nCY557HfXvgyjPbPDWCpjlzaOufD7LYM+eJPOEEqeN8xeh5qM+VZd7LgYwA0coyHvD
 DrKTLnE+hoQ9+w==
X-Received: by 2002:a17:90b:4fc5:b0:3a7:db88:3495 with SMTP id
 98e67ed59e1d1-3a8a1d5b8fcmr1120154a91.52.1791352671922; 
 Tue, 06 Oct 2026 22:57:51 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e60d0b0e2esm3051775ad.7.2026.10.06.22.57.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Oct 2026 22:57:51 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Wed,  7 Oct 2026 13:57:41 +0800
Message-ID: <20261007055741.30629-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

Since commit 4c9106f4906a ("idpf: fix adapter NULL pointer dereference
on reboot"), idpf_shutdown() calls idpf_vc_core_deinit() directly instead
of idpf_remove(), so IDPF_REMOVE_IN_PROG is not set on shutdown.
idpf_vc_core_deinit() uses that flag to decide when to shut the virtchnl
transaction manager down. Without it, libie_ctlq_xn_shutdown() runs
before idpf_deinit_task() tears the vports down, so every message sent
during that teardown (disable vport, disable queues, destroy vport)
fails at once. The device is never told to stop its queues and keeps
them enabled, with the ring addresses of the kernel that is going away.

After a warm reboot, the first queue reconfiguration of a port that has
not been opened yet (udev setting the MTU) sends VIRTCHNL2_OP_DEL_QUEUES.
The device then drains the queues it still considers live and writes
SW_MARKER TX completions to the previous kernel's completion rings. With
the IOMMU translating, those writes fault about 19 s into every such
boot:

  arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0

In IOMMU pass-through mode they land on pages the new kernel has already
reused, which shows up as "pagealloc: memory corruption" with
page_poison=1 and as crashes in unrelated code without it.

A function reset on shutdown does not help on these devices: with a PF
reset issued in idpf_shutdown() and PFGEN_RSTAT polled until the reset
completed, every warm reboot still faulted, and the reset the next
kernel issues at probe does not clear the queues either. Delivering the
teardown messages does.

Set IDPF_REMOVE_IN_PROG in idpf_shutdown(), as idpf_remove() does, so
that the vports are destroyed while the mailbox is still up. So that an
unresponsive control plane cannot hold up a reboot, give each mailbox
transaction during shutdown a 2 s timeout instead of 60 s, and fail the
remaining ones at once after the first timeout. If the function has
already been reset, for instance a VF whose PF went down first,
idpf_is_reset_detected() fails them without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this change backported to a 6.17 kernel and the IOMMU translating: no
faults in 25 warm reboots, against a fault on every warm reboot
without it. Each PF's teardown took about 1.2 s for six mailbox
transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS, took about
300 ms. To stand in for a control plane that does not reply, the driver
was also built to skip sending mailbox messages during shutdown: the
first transaction timed out after 2 s, the rest failed at once, the
teardown took 2.8 s per PF, and every reboot faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
v2:
- Drop patch 2 (function reset on shutdown). On a VF it queued
  VIRTCHNL2_OP_RESET_VF and then freed the mailbox, and on these devices
  a PF reset does not clear the stale queues anyway (numbers in the v1
  thread).
- Set IDPF_REMOVE_IN_PROG in idpf_shutdown() instead of changing the
  condition in idpf_vc_core_deinit(); no new idpf_is_reset_detected()
  call (Emil).
- Bound the shutdown teardown: 2 s per transaction instead of 60 s, and
  fail the remaining ones at once after the first timeout (Emil). 2 s is
  about six times the slowest teardown transaction measured here.
- No VF special case, unlike what I suggested in the thread: a VF whose
  PF has been reset already fails fast through the existing
  idpf_is_reset_detected() check in idpf_send_mb_msg(), and a VF with a
  working mailbox leaves queues behind on a warm reboot just like a PF.
  Not tested on a VF; I have no VF setup.
- Compile-tested on net-queue dev-queue (W=1, allmodconfig and
  allyesconfig, no new warnings); runtime-tested as the 6.17 backport
  described above.

v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

 drivers/net/ethernet/intel/idpf/idpf.h        |  4 +++
 drivers/net/ethernet/intel/idpf/idpf_main.c   |  7 +++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 28 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c8..5d2e8a346 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -88,6 +88,8 @@ enum idpf_state {
  * @IDPF_REMOVE_IN_PROG: Driver remove in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
+ * @IDPF_SHUTDOWN_IN_PROG: Driver shutdown in progress
+ * @IDPF_SHUTDOWN_XN_TIMEOUT: A mailbox transaction timed out during shutdown
  * @IDPF_FLAGS_NBITS: Must be last
  */
 enum idpf_flags {
@@ -97,6 +99,8 @@ enum idpf_flags {
 	IDPF_REMOVE_IN_PROG,
 	IDPF_MB_INTR_MODE,
 	IDPF_VC_CORE_INIT,
+	IDPF_SHUTDOWN_IN_PROG,
+	IDPF_SHUTDOWN_XN_TIMEOUT,
 	IDPF_FLAGS_NBITS,
 };
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..fa27ee1cd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -196,6 +196,13 @@ static void idpf_shutdown(struct pci_dev *pdev)
 
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Destroy the vports while the mailbox is still up, so that the
+	 * device stops its queues before the next kernel reuses their memory.
+	 * A reset does not clear them on every device.
+	 */
+	set_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..5f5d72671 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -190,22 +190,38 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * During shutdown each transaction gets a short timeout, and once one of
+ * them times out the rest fail at once, so that an unresponsive control
+ * plane cannot hold up a reboot.
+ *
  * Return: 0 if the request was successful, -%EBUSY if reset is detected
- *	   or Tx control queue is full, other negative error code on failure.
+ *	   or Tx control queue is full, -%ETIMEDOUT if a transaction already
+ *	   timed out during shutdown, other negative error code on failure.
  */
 int idpf_send_mb_msg(struct idpf_adapter *adapter,
 		     struct libie_ctlq_xn_send_params *xn_params,
 		     void *send_buf, size_t send_buf_size)
 {
+	bool shutdown = test_bit(IDPF_SHUTDOWN_IN_PROG, adapter->flags);
 	struct libie_ctlq_msg ctlq_msg = {};
+	int err = 0;
 
-	if (idpf_is_reset_detected(adapter)) {
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (shutdown && test_bit(IDPF_SHUTDOWN_XN_TIMEOUT, adapter->flags))
+		err = -ETIMEDOUT;
+
+	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
 			kfree(send_buf);
 
-		return -EBUSY;
+		return err;
 	}
 
+	if (shutdown)
+		xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms,
+					      IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
+
 	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
 	xn_params->ctlq_msg = ctlq_msg.opcode ? &ctlq_msg : NULL;
 
@@ -217,7 +233,11 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 
 	idpf_mb_clean(xn_params->ctlq, false);
 
-	return libie_ctlq_xn_send(xn_params);
+	err = libie_ctlq_xn_send(xn_params);
+	if (err == -ETIMEDOUT && shutdown)
+		set_bit(IDPF_SHUTDOWN_XN_TIMEOUT, adapter->flags);
+
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5d27805ff..b0809d149 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -7,6 +7,7 @@
 #include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	2000
 
 struct idpf_adapter;
 struct idpf_netdev_priv;
-- 
2.50.1 (Apple Git-155)

