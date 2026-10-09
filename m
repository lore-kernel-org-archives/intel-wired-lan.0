Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A561FCA5FED
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 03:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 580656066D;
	Fri,  9 Oct 2026 03:27:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nctId6eU20S6; Fri,  9 Oct 2026 03:27:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3F711607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791516440;
	b=Vbfq8mTb0qs1KKh94jHkaORW2/4e5GQR+jl1635E+ElLl8F0JuLia3utEW4+Wgh7/gCt
	 nbN+o2h09nhkmhtsOvN7aatYzi5MNWZxsXYU++RylPZ+N29VHD3kRrUoq0L54IcCioqr6
	 Ot76pdjv2qPpdqS/xgpFENHD24ypz6uzqWjXoI02h0UaqLZ18PpNQff/izL/dBI+HSXL9
	 XG1FPUoKg4ztJGRa5g4P8wG05OiwSmCX6YtY6QUwi8e7/hWIj7xUDqWs4zdC9Hg/sWlN0
	 +6Rmus9x0zRpdx16QbEFPmhCXih7I6DpcQH854FVwA+sqOvLJSYbSjLYt6CEUcptf9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791516440;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
	b=CO+bTsILZyNhhPi08Ufi0FMgFonR+1Sa739nTuHHb3+0BhEUU1Je63+LTuZXywrRCevx
	 WvjzwjGhqh1Fg6kL6G4CwJu9Ejx3COwc23IHi/b7QOE0bqXACr578h7+kzpnqHp/LilLv
	 AqIOywEUh5AJKkwSykbQyVNWXa6P/9fCZnjz1LNhxf26NATTZnAs3aV9Am36jWMbuFc3d
	 SA+ZSjRL0IzoD3BzRb/pjBO4CZdKNiCLAAj0M7tkADzFVcwg4cm2mpA+IfjUG7VhCIe4l
	 mCNG0DaQGS54PzVcroIWW2htkU42qWG8cEyykjdcDmQfWfeCpz1zkOS7btoAVUXWr0g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791516440;
	bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pi/wNgCUB5M9JU5+DLIFlA0ypW5DfJHsF1JYsovEECWjbwqPhxwvv+P8KjLXrotZL
	 PCeaZP4kTTzRxAdDwQTLTQIqOp7u1l1caXUx8g0YY6teWx0WaioXNRk8iM7s9euY1W
	 n8PNXVWIxsVl74pvLimJ/Bu94FWCBXNk/tGTOOAgaymEnkGMptGIeuJbkuqY8CWRWT
	 7F2544WxWPqtuGEO9n/Fli/0Xo/nMT3JM5qGkISPKKTUx1is0xkB1YQVORa6UOCe2U
	 hf/c4lz4i/D68ioJT9TR8+GEfjeMlTGOdmYB5RgM38kgDfuWG+w2DBpZ6hKZ+AGk9N
	 9omrJYWslllmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F711607B2;
	Fri,  9 Oct 2026 03:27:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DF1342E0
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 03:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C458540923
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 03:27:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akFhfQFg55cv for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 03:27:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A36C44091F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791516437;
 b=jyj62535Debz8f6N2LokTOcdqStamYmaa7NrooFfNy/vse/voAdAn9dlES1jKRcWeQQU
 FvZ5crvMnHevqMG3XrD83Vj7JwefkNKMI6UfzO0/QtJloBk0rabi5naOSZJvKv0IbC4VJ
 dqbzUsOGE6unwT49au/GS9AMwqTZuV+4EEuYuzar68kK341WFztJ5I4YBP7EBFNEyGA6S
 dhZdMIZWtYIhz+D7cHr+VUGGhv/oozzC/Nng8PUZYE2Op0kc35r5XOveN9w0qo9EFZqgp
 2D6zgy50CzxngAEzzCjo23jA6ZYDw8N6ttHAQ5/CzcmWoDMt8InjENDDVNmFFultgiw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791516437;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
 b=iuh1Tv2NLm5mnsS1uBmcDtsB/XhMyqj+K8PmloPup2lceq0m34IHJV1svgdkVG10y3Y2
 aVDe2hqmK+EtllCwdeyh93KvTLMMIWS2hpLCIbey3u2I8V69FPefn7X/EGg5u0bjK95Jc
 KAwudPK8AmnNMexlJDcjqRbERwdtB45yylZac3lA8TWh/fb0+uyYv0E6vH1LJUVDmjiHK
 vILDknCGYnpKPSIk0MD75vHxOrpZ/05ktNPMUnN/JGZFG8gE82GOM+ebMtHTL1LMSgx3c
 PzJ/NMqdanMqBHi26Mfe8s+IfvxGwylBnSoxK8Sjw1b1HxBaXQcdT8e4HiP5g+ZxYYQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MecJQJsL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MecJQJsL
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A36C44091F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 03:27:17 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ab41538192so116398a91.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791516437; x=1792121237; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
 b=MecJQJsLwlZGrjXp4KDW/vflOpaXw/D6zKfb7NXnhI9VMai1ho9F3d7mMC25OyPgNu
 3hGE1Tl93yMSBo6nkrFW3UXDBAmH22JNkZvkJZwzHYvqRKnXwK//QryQAiCHlXn8DdOI
 ATg32eaEY1ZTm1WqGyv+id+iP88irDbEETzClqDZ7QJP2oANyoLtM3wyPAzTSM5INB+9
 if3Tlox0hsd/5F/uRmCJdLP5RuP5ovardt5eMPW+SWVIhmjatTBUVIlQCp3q8BFwjFmp
 ppbUgqSIAPeqJ8scobKhtEEH5nS/S8NeVyNxsxNpdecg33wgapxN/vfX07RW1Jkpixq7
 3DFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791516437; x=1792121237;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FhypQyvK+uhKjW29vTvRiillErDVf7GJbX4G0AwamWk=;
 b=wHa+RnVq+YOb+mVJ0Lw5RM7VeR28/U/7WrChDnqHJjbazZ7oA06/QCRR0AG7SZSQAC
 uoFP4sIBtAU65haXB00I+rTDrIkFssP7zjxvva4Ms7wLHTAFsEUz8pFfFIwEpeTkGUA1
 tAyxjFw01ig9ATV1jhRDHRzCnpE+TSeE5zPNe36N5p50eJLk6u4gMydRLaBSRe4mxOKI
 6QjUbiNTtqXr8wSSxREkXXnye8YdEUoR6/Dh0bVLPWfYs5OE6nH+aLK4kffPYlCyPmVB
 Fpury2/RwFjqeh2CNB4BS7uacpWMtEKxPzeyxiBu8f2Uc/E80N17cepMIWnm6K84QywZ
 MZZw==
X-Gm-Message-State: AFq9FYLYRAHK/KPlEffHWogEcZUTYASfeTgHrxNEytfk6oYCU7C6mUn9
 pIjlJeiIlx69s/RwEeLxNbERXv8E+Zf/6CKuaJFZi4FwWK7+kUUrVrYOxjedHbQundk=
X-Gm-Gg: AYBFou2irle5efAD96zpHVLhl67EMDSeCLttxdHoouVvqC4Sjss3i0UkGBLqR+XxcET
 QU3U3zgShse+0O4sw/qyqFhAVsAeNRcqhrXjz9PMmPlzrcDJPlJoGHS76GZpC/t2OfLKn9cDCiK
 JVJpS8xJVU7jP+YpmQaJWiEtbBYaz7UyWdSFSpgW00qPLFruOynX1RqVmaIP8Bua71doW/moZ3C
 +J6hdGVyCvVb/jDyq71BgioCK9EnhCdwHbuslg6Yimo+dGZYww+yZaeg1ObuJcPp36EEOqfq1tQ
 VCa6bkBdEvFiRuAmpQvLWxTkDoX6rX5qwtb9+rYXL1LGtZWBfO74YCYRr51MBNutEUOlChnO4pc
 Ki3+c6Xd51OpGBf3oa53AOL2UFkD4gUiMYv3lUDY8xionJh0pGgPs32j93CD5pFfGeC+WtqIiEL
 efmseap0slSewjrM7Cu3xz7VuEoQB+Wz448ODU+WEnpe/hdBVd1i7IzOaXeIK6eLujm3hx3NQvT
 Nw4C1KqsiKcQr1UMpnCVtqGYLeHdXrwkSZGzl/08nHeaOKSf6gp+OGJVya6HOcY8kx1qL2xM1Cl
 EwE=
X-Received: by 2002:a17:90b:2d86:b0:3a4:f8da:2478 with SMTP id
 98e67ed59e1d1-3ab3a778678mr715625a91.29.1791516436586; 
 Thu, 08 Oct 2026 20:27:16 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab395e11a0sm761630a91.2.2026.10.08.20.27.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Oct 2026 20:27:16 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v3] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Fri,  9 Oct 2026 11:27:06 +0800
Message-ID: <20261009032706.94324-1-luckilystar08@gmail.com>
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
fails at once, and the device is never told that the vports are gone.

A reset should clear that state, but on the system where this was found
the device kept the queues enabled across a warm reboot. The first queue
reconfiguration in the next kernel (udev setting the MTU) sends
VIRTCHNL2_OP_DEL_QUEUES, and the device then writes SW_MARKER TX
completions to the previous kernel's completion rings. With the IOMMU
translating, those writes fault about 19 s into every such boot:

  arm-smmu-v3 arm-smmu-v3.12.auto: event: F_TRANSLATION client: 0006:01:00.0 sid: 0x30100 ssid: 0x0 iova: 0x3ef60840 ipa: 0x0

In IOMMU pass-through mode they corrupt pages the new kernel has reused.

Set IDPF_REMOVE_IN_PROG at the start of idpf_shutdown(), as idpf_remove()
does, so that the event task cannot be requeued and the vports are
destroyed while the mailbox is still up. So that an unresponsive control
plane does not hold up a reboot for long, cap each transaction sent
during the teardown at 500 ms instead of 60 s, through a new
adapter->vc_xn_timeout_ms, and fail later ones at once after the first
timeout. A transaction that is already waiting when shutdown starts
keeps its own timeout; bounding that would need support in libie. If
the function has already been reset, for instance a VF whose PF went
down first, idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this change backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions; the slowest, VIRTCHNL2_OP_DEALLOC_VECTORS,
took about 300 ms, and the queue-related ones at most 240 ms. With the
driver made to skip sending the teardown messages, the first transaction
timed out after 500 ms, the rest failed at once, and every reboot
faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
v3:
- No new flags (Emil): idpf_shutdown() lowers adapter->vc_xn_timeout_ms
  (60 s from probe), and idpf_send_mb_msg() caps each transaction with
  it and sets it to 0 once a shortened one times out, which fails the
  rest at once.
- Shutdown timeout 500 ms instead of 2 s (Emil).
- Set IDPF_REMOVE_IN_PROG before cancelling the service and event tasks,
  so the event task cannot be requeued (Emil). The timeout is lowered
  after the tasks are cancelled, so a reset that was still running keeps
  its normal timeouts.
- The comment and commit message no longer state that a reset does not
  clear the vports (Emil), and say that a transaction already waiting
  when shutdown starts keeps its own timeout.
- Retested as a 6.17 backport: 20 warm reboots without a fault; the
  slowest teardown transaction took 306 ms.
- Not addressed here: with the transaction manager shut down later, an
  async PTP Tx timestamp reply can race idpf_ptp_release(). The same
  window already exists on remove; left for a separate fix.

v2: https://lore.kernel.org/all/20261007055741.30629-1-luckilystar08@gmail.com/
- Dropped patch 2 (function reset on shutdown): on a VF it queued
  VIRTCHNL2_OP_RESET_VF and then freed the mailbox.
- Bounded the shutdown teardown and failed the rest after the first
  timeout; no VF special case, since a VF whose PF has been reset already
  fails fast through idpf_is_reset_detected(). Not tested on a VF.

v1: https://lore.kernel.org/all/20260917105205.37561-1-luckilystar08@gmail.com/

 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +++
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 10 ++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 25 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 4 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c8..0739861a1 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 129bccaa6..ec751f4a6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -194,8 +194,17 @@ static void idpf_shutdown(struct pci_dev *pdev)
 {
 	struct idpf_adapter *adapter = pci_get_drvdata(pdev);
 
+	/* As in idpf_remove(): keep the event task from being requeued, and
+	 * destroy the vports while the mailbox is still up.
+	 */
+	set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
 	cancel_delayed_work_sync(&adapter->serv_task);
 	cancel_delayed_work_sync(&adapter->vc_event_task);
+
+	/* Bound each teardown transaction, so that an unresponsive control
+	 * plane does not hold up a reboot for long.
+	 */
+	WRITE_ONCE(adapter->vc_xn_timeout_ms, IDPF_VC_XN_SHUTDOWN_TIMEOUT_MSEC);
 	idpf_vc_core_deinit(adapter);
 	idpf_deinit_dflt_mbx(adapter);
 
@@ -267,6 +276,7 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->req_rx_splitq = true;
 
 	adapter->pdev = pdev;
+	adapter->vc_xn_timeout_ms = IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC;
 
 	err = idpf_dev_init(adapter, ent);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706..3afd6e62e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -190,20 +190,32 @@ static void idpf_prepare_ptp_mb_msg(struct idpf_adapter *adapter, u32 op,
  * Cleanup the mailbox queue entries of the previously sent message to
  * unmap and release the buffer.
  *
+ * The transaction timeout is capped at adapter->vc_xn_timeout_ms. Once a
+ * transaction with a shortened timeout times out, later ones fail at once
+ * instead of waiting again.
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
@@ -214,10 +226,15 @@ int idpf_send_mb_msg(struct idpf_adapter *adapter,
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

