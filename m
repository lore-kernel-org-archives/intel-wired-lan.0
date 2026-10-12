Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F53CA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 12 Oct 2026 06:31:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBCE64061B;
	Mon, 12 Oct 2026 06:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bfTZBoCT3DvQ; Mon, 12 Oct 2026 06:31:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E942640629
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791786667;
	b=dioq28Ev9vIk3Qh8GvHietm1Mqk5uyYrbk2DcgHq0I56KGRRlrmAqP5O5wAUfcHY7JDg
	 B3y/ZJeWQRRAgdrDJodeDO27NQcA+D7DzKUdJzjsg3FGwj4xK1cO40Xke/ZLo2etYFKh2
	 NoKsJnZZZZnCmvB1B9Epw4WNox8db2JvBhGr/r+jZV7Bx6y3X/hE9n9gqcP6mv4nWl316
	 ozcBlRbteJgpO1JDH0bZwdvNcOUNF64JSQUuo33Q/s8g000K6TLFA/JeKhQFeS08zcS6y
	 hVMO9CXLqhz/vy9tVqhmQ0mwgtXa7DuEwHAwj4r4BZreOTQDxZs2jpA9iMJeRRQSZFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791786667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
	b=c8ahUT9Vy5YkAH6Ml09BD/sFwtwdAxXw7HO9xBncz70kzyxqLfmpfs+sKnFSilLBiBhy
	 bkFtsW4V2MZiL1pjp/FX5PUp/nBJbGpjiql+EFrc4bRTN73/iOVeDnGop2bn6vkiE+joU
	 R0BOaWKsMzUe98X9ymePURuCKwTVR5xuP0ivGWveU22xXGP3/ljUjUIWA3d4JZWM276r0
	 L3zs6sehSQfsIvxvVKnoO5kiHEoh4AHZfDI8zT3r6SaI7IKg6nNNi1eLhwcP1BsluWNfO
	 ppxKsxsFh0HPV7m5CaYpCaUpqWGasPNaf5HFyFKCYBnjCADI7PAhuupHbAKFpfDYzkg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791786667;
	bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnGvVevP5ZL9IIIsKs6onN4n5GX5dGxFNa1Ly1/PIS+xkavWZd61fp4FvRpW4d4lm
	 kYbjfVWNvsygy5afKbO1LlW9Lwadq06TZLNv2jiV4BsYtE9CA1Jj1Cy16+OnAxdZMQ
	 gZEaKuZv1FnMdJLuuGrP2PotFor0fCLDeHFsmyLax7/soCQEcK5sxSHkDnkLS+Kik7
	 B7pKIVhnbBqADj7S5OuT3dwsB2IaiotKeUH8YNZASwh/BQb43HhDWhY23VzdiyU4mB
	 bl0YMokU2jYisLoJDU6U3w7q0Q8GUkunVGg0dKP2dkJyrD8AWIk7HkX+4yxhRPaDQj
	 hwLqmqAyOCRXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E942640629;
	Mon, 12 Oct 2026 06:31:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A2EB380
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3F5280CEE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aCt_oUJxBhzi for <intel-wired-lan@lists.osuosl.org>;
 Mon, 12 Oct 2026 06:31:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02F8380CCC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791786664;
 b=JzICYRsVNfJcjd+OKoMgoIbdk+CpIbQFDIwGjFSHeanRsvk/lt5KkBDDb/kNMZ9bt43c
 pjIRDK+FIDlam6lw/fes6yaZ4D6+cGW7hjeqFiFChvegcTkJVrhB09U57M8Nl+CwD8ORH
 bujMC+g+qSKfV4nmNh5Vhk2tH5ZGPcgJMNzD+B2D8D/DRIrfSpBNwVqo973tafudMezx+
 SI11R2oHf5dG/sjhlrEfDEOWrDSxx3VbRpeRsWI4Z/8ff97VgBne/Zf1vae+wBtccrP1M
 XqvfWzoI6rYt9IV+6eo/IkbkWuYWWNdjRDSQAExqqtDa7Ehg7TPYONfyy1DfiEfReWQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791786664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
 b=D1Rb/fB8LCU6v6jMWTV39doWF6prZ5Fc/F8KV+a5E5gMKepz5IiHNJnzLcGo5aZjmjwo
 igwva3Hc49xHzd2QaloARrwECvKD3yXM/cOXyqQ41bn7dfOZLl0c6fm8syJY7Q4Sb4zQ1
 k0/wIC3ZymsmTSj4/xFwuW4nwbJ8zdlwviRbCOTX+1oBYEKLb6GRzdt8sZO+SX4OWSNn5
 sz+ypWK68CUsPMRsy6haxiZWQHVbso2Zepgv0vW1ZMRFasBwjPfexZzGYnzL0n8M+kYob
 EZi5pBGBXJOBT4Wrjlc2tdM356q14FqF+l/ayGnVBNLeB00IPNAlM/BFN0r5oCBumJw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KomRPg1L; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KomRPg1L
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02F8380CCC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 12 Oct 2026 06:31:02 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso630017a91.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791786662; x=1792391462; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
 b=KomRPg1LWkTMK3ckWPNUDCV84xsyRAip9/0VwpLDKYcKAuxPrnb8jurLcxowjTNVZG
 LFiCqxICKAvktxbvi8A25KyMKnBXXdy66vo7UU9cSMiGgtf8OgU8L5BMyEro2CDFkE90
 ATzb1+l1cuE3GF2Ta4SeulAWxLPr3z5A1PFRhElApmmzp3QTqMe4knXuZpz719Lm4EGB
 xunkUJ4AzkMq5kM5+O1eLxn4iLWIMOuANBtrHXjR/9C7y7q7xxARVw3rMzOghaNCREoa
 AU+yCg+zA2omZfm8a+26ZpBRlsTD4PLs1cw/VaatAxpfZT7eesyMgiyZ5GaDMVPhd9xu
 Fzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791786662; x=1792391462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LxsKVuVbCokcStaX9909Y7xuwbZTKwt8+2Tb8Dk91kE=;
 b=PxuJ9prYUR3EWXvyHwKjltu1fIAipOC1VVzzhgoJbFC195iMycPQM2YL8L2HVUJeMA
 leL41ZbNX/dSpgCfqeb9wSZso/3+8y2fPSiwLyfuiYnrQnFCBSqr75SpDQSPJkUbM/4L
 BIQ9BievywjsSE0qKEYOsFekAo3AqHaoFinFI8b25p2oDwHOzKNE9eiczwpcns2UvvoU
 i+zIptfLZxzTQ9GmcW+No6lsI/0goWQKOvwRV8xmWXbnN9fXw4EIOHArzc4xmKPwsX/y
 rTeAGyVuyA6nARwbvrk/lp/CSwC+F3r86M/ik3D1LKEvRoaysd3b4r8PGPdLmAOM3l+S
 yy6w==
X-Gm-Message-State: AFq9FYJof1JfOmcgMt9c0DjD0lB7/tGNtpCiHw5qIJnSG66S5wPBbZD6
 VyLiE2XHpvQDPuHmKhZ199FTvqog/hukFH/6V2bEF9XETW0lRSX4QHMupPf8gVC3
X-Gm-Gg: AYBFou3GljhEP3PlX4F6/LG/orFiq0OE1EwMjkZ8bih5/wdic33u1zXd3bKJ6A24lCK
 bbBg32H1MqXo75oXHHX6u+oj4XKOMNaXeUcrUZxx37WvhVFcJDfGK4Swdeu139Ee9CDQenkOIhS
 e7ibAq4BiGlB6LE73WB8wUnvJf9T0z7BR+ht1yQqyoc55RI/rw147bF1/Hra7dcXzcwjTjAgCPI
 lI7Tka1OQgjVWUzBLKZEiyywJp9dnPa/u9y1Rt6Vp+7Ltgp3/8/1FJppHRrNQYS9rgwsFRZRZPF
 2emOCE+KWvgOgd889wdkfLMEx4ET3yP6AY+B7vRJjT4JlAE+HGY79Mvb6EAjv+r6bhcy2jqDPx0
 3DYOpoK0gZHBhPwk40pdA0g5M8zLu7v5slKAKJmmc1FPj0WXZDZIOHY289G7M7Jc1qUmyk3was2
 EVhbMrJlp4iQrTOeThYydqiKNDw1wj1ZG4/EQ79/dVz1xq6YjDLCfbKUePajDsLGtJAb35OxT9/
 24d7rpZex1d88VaP4BtFwZQOWYtg93KgNUDTyDXslQA0tPguOXc1Sxn1m/JDRKPAOekYw7vs1kl
 agE=
X-Received: by 2002:a17:90b:5346:b0:3a4:f9cc:3b9b with SMTP id
 98e67ed59e1d1-3ab3a7a1950mr7067950a91.33.1791786662259; 
 Sun, 11 Oct 2026 23:31:02 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab371c32cesm14452767a91.16.2026.10.11.23.30.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Oct 2026 23:31:01 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, milena.olech@intel.com, joshua.a.hay@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: [PATCH iwl-net v4 2/2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Mon, 12 Oct 2026 14:30:27 +0800
Message-ID: <20261012063027.27750-3-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012063027.27750-1-luckilystar08@gmail.com>
References: <20261012063027.27750-1-luckilystar08@gmail.com>
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
destroyed while the mailbox is still up; the previous patch keeps the Tx
timestamp callback away from the state released on the way. So that an
unresponsive control plane does not hold up a reboot for long, cap each
transaction sent during the teardown at 500 ms instead of 60 s, through
a new adapter->vc_xn_timeout_ms, and fail later ones at once after the
first timeout. The SW marker that each disabled Tx queue waits for is
handled the same way: once one does not arrive, the remaining queues do
not wait for theirs. The statistics task stops sending once
IDPF_REMOVE_IN_PROG is set; a request it already has waiting keeps its
own timeout, as bounding that would need support in libie. If the
function has already been reset, for instance a VF whose PF went down
first, idpf_is_reset_detected() fails the messages without waiting.

Tested on two arm64 (64K pages) servers, each with two idpf PFs, with
this series backported to a 6.17 kernel and the IOMMU translating: 20
warm reboots without a fault. Each PF's teardown took about 1.2 s for
six mailbox transactions, with all 64 Tx queue markers received; the
slowest transaction, VIRTCHNL2_OP_DEALLOC_VECTORS, took about 300 ms.
With the driver made to skip sending the teardown messages, every reboot
faulted again.

Fixes: 4c9106f4906a ("idpf: fix adapter NULL pointer dereference on reboot")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
---
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  3 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 11 ++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 56 ++++++++++++++++---
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  1 +
 5 files changed, 67 insertions(+), 7 deletions(-)

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
index 129bccaa6..2e018d02f 100644
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
+	/* Bound the teardown transactions and Tx queue marker waits started
+	 * from here on, so that an unresponsive control plane costs a single
+	 * timeout. A transaction already in flight keeps its own timeout.
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
index d0db60647..a97279447 100644
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
+
+	if (idpf_is_reset_detected(adapter))
+		err = -EBUSY;
+	else if (!timeout_ms)
+		err = -ETIMEDOUT;
 
-	if (idpf_is_reset_detected(adapter)) {
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
@@ -355,6 +372,33 @@ static int idpf_send_chunked_msg(struct idpf_adapter *adapter,
 	return 0;
 }
 
+/**
+ * idpf_wait_for_marker - wait for TxQ marker
+ * @adapter: driver specific private structure
+ * @txq: Tx queue to wait for
+ *
+ * Return: %true if the marker was received
+ */
+static bool idpf_wait_for_marker(struct idpf_adapter *adapter,
+				 struct idpf_tx_queue *txq)
+{
+	u32 timeout_ms = READ_ONCE(adapter->vc_xn_timeout_ms);
+
+	idpf_queue_set(SW_MARKER, txq);
+
+	if (!timeout_ms)
+		return false;
+
+	idpf_wait_for_sw_marker_completion(txq);
+	if (!idpf_queue_has(SW_MARKER, txq))
+		return true;
+
+	if (timeout_ms < IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC)
+		WRITE_ONCE(adapter->vc_xn_timeout_ms, 0);
+
+	return false;
+}
+
 /**
  * idpf_wait_for_marker_event_set - wait for software marker response for
  *				    selected Tx queues
@@ -375,9 +419,7 @@ static int idpf_wait_for_marker_event_set(const struct idpf_queue_set *qs)
 
 			netdev = txq->netdev;
 
-			idpf_queue_set(SW_MARKER, txq);
-			idpf_wait_for_sw_marker_completion(txq);
-			markers_rcvd &= !idpf_queue_has(SW_MARKER, txq);
+			markers_rcvd &= idpf_wait_for_marker(qs->adapter, txq);
 			break;
 		default:
 			break;
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

