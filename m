Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23ADCC6B03
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 12:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F31B809C2;
	Tue, 13 Oct 2026 12:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwFhGQMK0HOO; Tue, 13 Oct 2026 12:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7E6E5809EC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791893576;
	b=qD77me+cDYLgp518Xw+rfY9AVcPCcUdbQeGROGQZMTNw5GyhROdSC3wOnLpZz56d69aN
	 1K+ABpoyJxX2xGIXeCpl0vUbTa7oZCv7su2zo0CrXPeQ+hRpUxeFgw29kKI9H6IyOmdES
	 wfTCfWGEyG4XtBE1ECKCElEuOIs7LyU+1wsl3fcS3lfcrkREYnQQ90C8h6w9/JMG0xUnj
	 5I4GX9RNLXXT9fsCyI/90md6zi7ZifOOnVCc4VJvgCl2Qc89tM4KTTI8mQ9OXNT/Guqn9
	 knWK2EqV2fhrpAXCZqgL/1bxJ4qLmekOqukb+Xl+riC56C+iuVDUZvTqJqCBveIBI+A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791893576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
	b=qyisJXVcS+VKLYeiVm4Z+FxJF/vKbbAbkJlR4MM0YI3dBtouKKOoc/KMUpLh8apF4MwH
	 9OO7bIfIWJnaqvc40XYVzXRUA0N3ZAQYRbVjA+d6Z+hoCuBRJQhu4ZwvEG3jfOyqN93DO
	 a7ONxOwkFKxDHhuI/yP7JKB/kY4TxRDQu+B2hLgQCb+k4J390j75I/MokkEp1+1WnnRMz
	 oHYVVcVvApnpLbi2ZI+jU7l2LuwoT1m4mrznhQZN2+WZsPtXbwu9fd1dPk8q/uAipNy5U
	 5Gg5uxq2iZAlrzMFZfimwmn2BHsrpq+AZWRVi1Qpw/K/ka/SeZF4c6L4FQN12z+wFUQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jZDmtUHE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791893576;
	bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kbJupCjJfK81LnkZIFMsk/6FKXqkDBtqlVpiM+GIn5/pvlIh6QBz/YWJOiJbqP6Uq
	 OxVuUiFjXmFutRF5vMlYsBkI4u+Glf3AjzUzsLluDinKo5alLb/DQ1UFQSi4wYH3at
	 K0M/4i5k6ocjhv3x1tjZV+C48PqpzUJw3pH0AmIjlWqUXtVlcaLpBrFOosvzzwFY4X
	 Sri/2UdB8OdD1ZKa4/O/DevIc6Nar6royrhv1n5H1tsGUJs1kPngMpCLdmphM0LrI1
	 hVJXIBTq9l+ldSoKDce1QRxaaURfDNt6bSWxMJeE2MHapyJqubGtyyLg5Mz+aYJuyB
	 8q/i6ilFssnfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E6E5809EC;
	Tue, 13 Oct 2026 12:12:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 92A4B2E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74508809F5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJBR-lgR1HCZ for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 12:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 60797809C2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791893574;
 b=ql/w+MxG05YH4NL0vNOCTP3BVdA7G2of6welM82Ruaj5jgUg6QUujTvTfqY49vWwTX8g
 MI4FaavRhGKsslbNo6r4fiWlo+vlmCGLFPGSTHyexxtRr30Y96eRpnMiozo7mupc649PS
 gCHUgK1S5WsoV0FizxqOinP481zR9MatzMq3Cnq1AZ3pYm8UmpRSf81lCoDWI82Cg07bc
 5zKukOqf64W4gA/FzX0S4l5PRuGJfjc8VNUBRCnXQkcEYN4zVPlxFc7VEprauaC7aJ9jl
 0kTaOyRn78gV7g7mTaVPHg6DQxn97yG0fP4VQIBmudMuzIyDnoL3RXl6XGL3MaoDp8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791893574;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
 b=f4rWMTcClPv28Je7rQ5/Inbjt43e9gfH+jHi+/CY6XXE4htqTBLgJ4p83gZnAFEC88Ft
 iwBwAQxUw41MdB3juGB73n4Gtt0aPVHpkmOFO8pj3o8/F4tgNC7jSFAVv8C7jeIdeYKeM
 gFi8dmHzfmfqSxnm4M0tlRCX7XTuOBn1ap2riQ4sgY+4Mj0PNalfo9y8Ia0KsDamMfh9N
 MrbHY+PdGuoeZTxpEd2g+60Srg8HBT70GAeP+8+UeFAvCkhf/5Tc7RaqfOlPu8A0pHb/A
 vprh6VcRv7uCl39xRTYweMRaCsNphqNAcaQagHuyogGY4vmBk/1ZUevLQpxhaqkDn5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jZDmtUHE; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1330; helo=mail-dy1-x1330.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jZDmtUHE
Received: from mail-dy1-x1330.google.com (mail-dy1-x1330.google.com
 [IPv6:2607:f8b0:4864:20::1330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60797809C2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 12:12:54 +0000 (UTC)
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-3514b90bb89so5296349eec.1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 05:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791893573; x=1792498373; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
 b=jZDmtUHE3w6+bkCK9WuDLjiWrQz0Hk4zw3cXoGvbIV4BTj5MAMJ1cNZlVikxjtEQX5
 41lU0bctcSr+b5UTBOIofXNF31ErTBZ4mB4LiN9lun5LPtF+yikAoc34HL1l8lEhYTHp
 nFjtBTwGKtU5vfB9n3pBvACsKTZioKSGhbchH3isXwPJLizPLunYJp4hLmNQBLWHO+Kp
 bYsRjhTlVx8On8WZiM+VT8b2RBhfGS7rCtklFNSAGotVAMXyrIH/RO5BtC0pWgLC99hU
 0TlRkTsXnkaJCpNWhXMlbYbF6+ivH4NOnfLC8HH8Pn3MglE2qYhyLsB+LLVH8U9g4uV8
 Remg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791893573; x=1792498373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XgSawlgCCv2bUBiG5qpJyX9qIeKEXbciVx8zpVGh7Rs=;
 b=K0DUoNwScq+6qKmegq+YqMVbHTWfmuup7V6qJVLRr8/hi5B58CZscq3j47zXl3qAF8
 0S9387AUmFu5EXkmLCNuVkedXIiJsPcCg68q2SFejyGXG9TaIjtDS/39tB0RaNRuA0DD
 T8H1eD0lIc1+BSgpACU9lRED6D8I7i+KHeIswmPG188oZkmk0gVB2eq6F/vKPI3ZHNR1
 mroYR7XYfe6pju8p5nR8Ri7hDGLqfDIUN6Ol+GZbJy1GiOwWyaDXjonzX7Q5AvFxvErN
 96cRjS3vYnH1neOT2nfyeuim9ceKWKEV3FZpc1xxBSR0/ExMMXUxzJR5M3VDKjy3a0BR
 8KRQ==
X-Gm-Message-State: AFq9FYJIsyhrK/VUM+5VKoo+w1QMhRCs7cQYDLID+Ie5FHm5NjOkb2VZ
 Q5UzoTlz4dcLXGpbZvUyPy5Z7eRp6XWSkGThTCv1tyIeaunIcck6z21ggIRMnEHUq/kgtQ==
X-Gm-Gg: AYBFou16K8oKxIokugdNN81+tDqnX8S482bBy6MCRAJexErG9PI9ZdXku0RVzRAKyDQ
 YvuXykB5c9czmMnVe+tovrEo4gjT20+rhj+f+W9rrIQGSDzQcx/yTVSvvzwZvxGBYuFIfgSllTn
 L+/nNkAqm5yEnfp+z6V4bFqEfx0maV1y9yyE3SzM8piLl3QNAjmhk7yO3VwxxbefRRYPztdHJDL
 MS+a6KUr9wWxz5Y+vck958uSLdxTeG3cGnaKzsZ9fxFlXYQaCrxS8f55wbekCW+aMchYZLGwuHM
 HXI8O00gO69JIFULoihEVeu2WC1941rQzWQh1zM1E0lwLsV+LmxI7l2qy6oqUzKYkxx0QpnX0uq
 jnLJthFCjRFhQs0G5hBflPyQleMMUeTC2+caJCVmdTP2m1L5uDlz7vO1S3r+kM8dMqIemNyWoyK
 IbkMSQVWR76Terj+/U6WPHcruLnOz8DQntjlPY4kanx0EQv239P8oiwnQ1OYYh2YtqpS6nioxqC
 VBcZjBnCpTdb6qreNL9Ffb0mY7z2IC2SDpaggG/czpGOndvZ6M76l4qTzW2AfPquLkW+ry7v8P7
 cw==
X-Received: by 2002:a05:693c:87c5:20b0:35c:34f:7da3 with SMTP id
 5a478bee46e88-35c034f7eadmr4048266eec.21.1791893572852; 
 Tue, 13 Oct 2026 05:12:52 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (34.224.142.34.bc.googleusercontent.com. [34.142.224.34])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca7133asm52304765eec.14.2026.10.13.05.12.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Oct 2026 05:12:52 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 alan.brady@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v5 3/3] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Tue, 13 Oct 2026 20:12:24 +0800
Message-ID: <20261013121224.84482-4-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261013121224.84482-1-luckilystar08@gmail.com>
References: <20261013121224.84482-1-luckilystar08@gmail.com>
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
fails at once, and the device is never told that the vports are gone.

A reset should clear that state, but on the system where this was found
the device kept the queues enabled across a warm reboot. The first queue
reconfiguration in the next kernel (udev setting the MTU) sends
VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX
completions to the previous kernel's completion rings. With the IOMMU
translating, those writes fault about 19 s into every such boot:

  arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0

In IOMMU pass-through mode they corrupt pages the new kernel has reused.

Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as
idpf_remove() does, so that the event task cannot be requeued and the
vports are destroyed while the mailbox is still up; the first two
patches keep the Tx timestamp callback and the link event handler away
from the state released on the way. So that an unresponsive control
plane does not hold up a reboot for long, cap each transaction sent
during the teardown at 500 ms instead of 60 s, through a new
adapter->vc_xn_timeout_ms, and fail later synchronous ones at once after
the first one times out. If the SW marker of one disabled Tx queue does
not arrive, the remaining queues of that vport do not wait for theirs,
but the mailbox messages that follow are still sent: the device has just
answered DISABLE_QUEUES. A control plane that dies at that point costs
one marker timeout per vport and one mailbox timeout. The statistics
task stops sending once IDPF_REMOVE_IN_PROG is set. A request it already
has waiting, or a reset already running in the event task, keeps its own
timeouts, as bounding those would need support in libie. If the function
has already been reset, for instance a VF whose PF went down first,
idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this series backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions, with all 64 Tx queue markers received; the
slowest transaction, VIRTCHNL2_OP_DEALLOC_VECTORS, took about 300 ms.
With the first Tx queue marker treated as missing, the other 63 queues
did not wait, all six transactions still completed, the teardown took
about 2 s per PF, and 3 of 3 warm reboots were clean. With the driver
made to skip sending the teardown messages, every reboot faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  5 ++-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 +++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 33 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c8..a789230dd 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -85,7 +85,7 @@ enum idpf_state {
  * @IDPF_HR_FUNC_RESET: Hard reset when TxRx timeout
  * @IDPF_HR_DRV_LOAD: Set on driver load for a clean HW
  * @IDPF_HR_RESET_IN_PROG: Reset in progress
- * @IDPF_REMOVE_IN_PROG: Driver remove in progress
+ * @IDPF_REMOVE_IN_PROG: Driver remove or shutdown in progress
  * @IDPF_MB_INTR_MODE: Mailbox in interrupt mode
  * @IDPF_VC_CORE_INIT: virtchnl core has been init
  * @IDPF_FLAGS_NBITS: Must be last
@@ -625,6 +625,8 @@ struct idpf_vport_config {
  * @asq: Send control queue info
  * @arq: Receive control queue info
  * @xnm: Xn transaction manager
+ * @vc_xn_timeout_ms: Upper bound for each Xn transaction timeout, shortened
+ *		      on shutdown and set to 0 once a shortened one timed out
  * @num_avail_msix: Available number of MSIX vectors
  * @num_msix_entries: Number of entries in MSIX table
  * @msix_entries: MSIX table
@@ -684,6 +686,7 @@ struct idpf_adapter {
 	struct libie_ctlq_info *asq;
 	struct libie_ctlq_info *arq;
 	struct libie_ctlq_xn_manager *xnm;
+	u32 vc_xn_timeout_ms;
 	u16 num_avail_msix;
 	u16 num_msix_entries;
 	struct msix_entry *msix_entries;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795af..e4af4ebd4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1358,6 +1358,9 @@ void idpf_statistics_task(struct work_struct *work)
 	for (i = 0; i < adapter->max_vports; i++) {
 		struct idpf_vport *vport = adapter->vports[i];
 
+		if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
+			return;
+
 		if (vport && !test_bit(IDPF_HR_RESET_IN_PROG, adapter->flags))
 			idpf_send_get_stats_msg(netdev_priv(vport->netdev),
 						&vport->port_stats);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..21be83dc8 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -194,8 +194,18 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	/* As in idpf_remove(): keep the event task from being requeued, and
+	 * destroy the vports while the mailbox is still up.
+	 */
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Bound the teardown transactions started from here on, so that an
+	 * unresponsive control plane costs a single timeout. A reset or a
+	 * transaction that is already running keeps its own timeouts.
+	 */
+	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
@@ -267,6 +277,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_rx_splitq = true;
 
 	adapter->pdev = pdev;
+	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	err = idpf_dev_init(adapter, ent);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 2cfd216ae..331d56fae 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -194,20 +194,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
+ * synchronous transaction with a shortened timeout times out, later ones
+ * fail at once instead of waiting again.
+ *
  * Return: 0 if the request was successful, -%EBUSY if reset is detected
- *	   or Tx control queue is full, other negative error code on failure.
+ *	   or Tx control queue is full, -%ETIMEDOUT if a shortened transaction
+ *	   already timed out, other negative error code on failure.
  */
 int idpf_send_mb_msg(struct idpf_adapter *adapter,
 		     struct libie_ctlq_xn_send_params *xn_params,
 		     void *send_buf, size_t send_buf_size)
 {
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
 	struct libie_ctlq_msg ctlq_msg = {};
+	int err = 0;
 
-	if (idpf_is_reset_detected(adapter)) {
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (!timeout_ms)
+		err = -ETIMEDOUT;
+
+	if (err) {
 		if (!libie_cp_can_send_onstack(send_buf_size))
 			kfree(send_buf);
 
-		return -EBUSY;
+		return err;
 	}
 
 	idpf_prepare_ptp_mb_msg(adapter, xn_params->chnl_opcode, &ctlq_msg);
@@ -218,10 +230,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
 	xn_params->xnm = adapter->xnm;
 	xn_params->ctlq = xn_params->ctlq ? xn_params->ctlq : adapter->asq;
 	xn_params->rel_tx_buf = kfree;
+	xn_params->timeout_ms = min_t(u64, xn_params->timeout_ms, timeout_ms);
 
 	idpf_mb_clean(xn_params->ctlq, false);
 
-	return libie_ctlq_xn_send(xn_params);
+	err = libie_ctlq_xn_send(xn_params);
+	if (err == -ETIMEDOUT && timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return err;
 }
 
 /**
@@ -371,6 +388,11 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 	struct net_device *netdev;
 	struct idpf_tx_queue *txq;
 	bool markers_rcvd = true;
+	bool wait_all;
+
+	/* On shutdown, once one marker is missing, don't wait for the rest */
+	wait_all = READ_ONCE(qs->adapter->vc_xn_timeout_ms) >=
+		   IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	for (u32 i = 0; i < qs->num; i++) {
 		switch (qs->qs[i].type) {
@@ -380,7 +402,8 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 			netdev = txq->netdev;
 
 			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
+			if (markers_rcvd || wait_all)
+				idpf_wait_for_sw_marker_completion(txq);
 			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
 			break;
 		default:
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 5d27805ff..911a25ad9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -7,6 +7,7 @@
 #include <linux/net/intel/virtchnl2.h>
 
 #define IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC	(60 * 1000)
+#define IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC	500
 
 struct idpf_adapter;
 struct idpf_netdev_priv;
-- 
2.50.1 (Apple Git-155)

