Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E7CCA600B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 06:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B81DD81192;
	Thu,  8 Oct 2026 06:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6bGgc5db8Ui7; Thu,  8 Oct 2026 06:54:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 16C1D8118A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791442482;
	b=l7lHf1oSmUsmdpP7KjlLbVtFTH2iTqrB6qrc8rHJxC4mv0rNpv5euk10jsP39zo+bnVC
	 afc+PLoWT9z+S3Rm1B60ndhwFnzj9sBlloV0zejunwToO0q2Oo+C5JliaWMRjaIVhf7Lh
	 gSMsD/MO2vmrtzEznOR8i8yqPaL9K1/71AZpvfa3skvCzS4Rt1wMZ1zu0U9vT9t0VLdZp
	 sYINg69Vmz109j/NgNsSyyF1uxzqD1Gu+P2aPNVgpgqmpwLNp2vsqgsZRx6d/GYuLwKip
	 RWzgfhooRJoiu6qOCPce+W/097deBcQWbM5NsXbSJDUFiA29VcWkh65Tvj1xZzn1wwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791442482;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
	b=ZDndek0uhR/Ye6u9BwEUV23RblylDxUxCAtpyKu3jwzNpYOyOcPgaEpOtx6jK20Jjmie
	 z8qg3HcAlI9V+VouB1NWvA3vpsI3uYvxOQ7bwVvr6XPbkPFR2OrEkpkHno9HPq6qY0Bhi
	 9/Xx2BTQsBIZMBLvPR3ztApYvUeSnRDNARs6AbcQaqkEo+hD4ZUAqJmfX2UfPIlALmmJ3
	 2Tz1ywNQ+ka7/j1amm6QVWG32TbNUfugvbs6+bHRHy8cp0R5fIXg4sfZGOgx2dF0HsTIP
	 8X56+q0QYoiTgqh1zY2ciV39h8OEzuvYPQ5yZU8DLBgaiC+IFAkdZSPccv9suzmvGtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791442482;
	bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=os/jlTX3VHlSJpBBKRxn3SXtKjnOt3w54hY4ZU24113LEhAPqSYCdMb8/AnuUngsD
	 sX22qQf2GZMu02sgNdhStMCxd8WloeKSnevAr++9P97J0+siqfXrIwXXItngE6I9T6
	 bAaS2RsGg+JwD7mIio2xEHBmKEx0vo5s0VNfv0YmTtJD1FjUg6/D7B3mOIkDxm/BOR
	 oApETHLJZJX1ZOBCy8yH2sOcRfBJ94oJZFHXVi51fycTuUhzqK3Xv8PUGY4QhRyHDv
	 YQCL3AeRRkXr/hhuYO6WR9xOquE2umI4AS6H1cN5RXVp0dbTKZZRQr2+a1CuBaFpC1
	 kCKX76/+tdRig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 16C1D8118A;
	Thu,  8 Oct 2026 06:54:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D155B317
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 06:54:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE9C2606C6
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 06:54:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c1pvVB0WnTl5 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 06:54:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0BD89606CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791442480;
 b=TGlYHnT5IHgHj6rZgKkUrWezEDmYCPjCYMOftb/LMWywMxvVmWYcnYtpn+NZCWYOldDP
 nDiH4zdA2PShvEpKCu2EcOfXl0v6iJGe3nMs9Nusxuh02CFUWFQEnpgFHuoFkxdr8ssIs
 lFNa244+b3kQtN5hVa4Uil5iFUyix1Pg7p6Jhb3fq77KOJ7odk7KApa+qj44v+Nn5O1yO
 C1vunjPkcqG8yoFReaA5lUiUBM+m2bA9HkFXPs+SwnTqxxogHi1Q9poztMYWL3Lo8AZ3s
 Xqm3bMDc6ojvVy/rmAvkME5H8vl70nbdmifdNOplx1GFW86U29vDG2WepaeN5+y0kpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791442480;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
 b=PJMKDeZ1T7ezxIoZGEojQFHmroBy2PnlJNhYAPTuHe8/xdjVG2DOl+sfxQD5Nhw8YS1m
 wPTZjEHwuUbsVCduZRMvk5oi0qtYi3GsZa9OkID3XTIU9wfl7ZC6wW0T9wFcezWSTX9P7
 vKHtMcMXWY21lSnWhAXNgfs9xC5I+0fq0RUkykyPVqDs98otD0A/no6PvzXIt1sjmylSp
 FPi9cMz4mRHiAaTS6E14bChqjwTI/N997jVm07M1+ISIAfMKTe2mzrplXm7SSd1fMO7G6
 Z5VImMWTxq/XSIohSn6H32pxH8CVGflv0egvekza6WsBNguJa6BDTDKo9VoFx7wnOFw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RG1Y+0sO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com;
 envelope-from=luckilystar08@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RG1Y+0sO
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0BD89606CF
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 06:54:39 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-88bd2b44f3aso1457487b3a.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 07 Oct 2026 23:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791442479; x=1792047279; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
 b=RG1Y+0sOChbl4Pj07t0KR9ge7CmBfG7AWJD1hwwm+Wd+gEa3eA3FXGKbbYTKZsLxtU
 jdHGu4ryOmn5Vp3GusKqh2TUhJ63/Xcx5ePIXapyE9XU0lxrb5yEW+gZIVat3pbQSZnA
 8xCIzqv81I4mrsB9mzO1y+2cbdvdQrugauLP6X7sRD3XvcoQvPShdRM288bIDqwQDMoe
 E8KGv6djd8AydFxBqYX1cD1Uhy6p+lKiC1KaZlkjJr/9YyA7Wz1OZRZlxRp4myvXdblp
 bjB9ikcKboR9l/iZXXLHfYwhSoKwUTk6nZcyGsba+hQnSoalGcFaw8kCNpF2K3BqpwH8
 GpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791442479; x=1792047279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SblAIcLrH38wu2bsZL9MNN4O5Hg8mJIn4mR+P2dFYYo=;
 b=FjbJAPGAfR30foQVgUxjhXcOGLJDwBSOVA1Tie/iteLt/6xqpzI3nhFmf1nmdDKogz
 3ee4cLblY1v8x7cnWGnZMSiBo199lzKMOKYJQqkMO+Fy+sPiJKVAnIBg/Bvy3k2EkEr5
 2U10pbIdsF+ImkoifV6KsERkk5y85hje3TKmT2ueg6fhADa6Y7CoDrPLTvTek6DhfEwQ
 yngV35Eeu4V/gwA9wjiwxXZrB8g3ERB8NH82WBGnoe8u4l3CoLU93H7ZQik9l+Kuu9rz
 yuSnR+wvf4AIQaihzNV/8groBzlWTRrnyFceqOoYPBO4nynjPEPJeG3jxNJ/x4cTesFP
 LSvA==
X-Gm-Message-State: AFuF++nEkwfIK+0XZYLLirq3cY7D+TsJRM0d8d8cV3yrE0wyhTtMrsWh
 24eKNDgq2N5dhPdRa2TuQgnb8IT9lb67LcOoilFNdZAbuRUDGZTh1yB8
X-Gm-Gg: AYBFou1dQ/7OlWfZShFz5Jii5K7ZzNskyXsNmnx0/EJHHDgjE/0xkXRJ5Ar8y6X2ecG
 wVXHCJzj6Xm/l9ICNygCcj4RHBHh571D4NIlRqgPHhWVgSxmh3Qm6TBsLGucMvY7zqepx2bfxs4
 8W7eSqutrF7tKFiThwKCsz9cDLf61oGXPFp3u8fLhxATTVys6pi7c9h7vublL5icOwncFbSYPlh
 YWRPe9Q5m1TAjXcZZ+TtF7t4s0gpX6+51tOqm0JSVkRLB0fYkDOCErJmEql4LsjQX3h96M5RBqD
 LKEKrIKm1Ua0Q4I+iLgNRsOC9niafrpVgIy4j2aGAHY+hBPz29tduhIndJWEX1chSUo6hCp7BeV
 qDEXU5HuhY7hJ/0MXwCrNEZz1cLNfu+FjCTx/f6NIu3tzeiUdrsZ7/3YSiU5TDs1BRa7i+HimTv
 qjpYoQfzQt1Ksv+7VyWfuFdQ4Mms17OE2Wrw6OtEOUYXNULE31b+oNd72PD46s/KHTvDQZHWFUb
 kVBp3+1EC/y9V8HMxTGgUpjWffY9rTjTbKV0RnZLBauRc2w4rweminFhpk0WnkA0k36EAAJo+vv
 CxY=
X-Received: by 2002:a05:6a00:1da7:b0:88d:4241:9fa0 with SMTP id
 d2e1a72fcca58-891b54c6216mr3889423b3a.32.1791442478885; 
 Wed, 07 Oct 2026 23:54:38 -0700 (PDT)
Received: from C9P9279WY4.bytedance.net
 (21.186.101.34.bc.googleusercontent.com. [34.101.186.21])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-892bac8e8f3sm1176182b3a.15.2026.10.07.23.54.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 23:54:38 -0700 (PDT)
From: Tian Xun Ng <luckilystar08@gmail.com>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 decot@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Tian Xun Ng <tianxun.ng@bytedance.com>
Subject: Re: [PATCH iwl-net v2] idpf: keep the mailbox up while tearing down
 vports on shutdown
Date: Thu,  8 Oct 2026 14:54:26 +0800
Message-ID: <20261008065426.86267-1-luckilystar08@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
References: <20261007055741.30629-1-luckilystar08@gmail.com>
 <a9d7c483-b34c-4b5c-8951-c9f1bb1c1f81@intel.com>
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

On 10/7/2026 10:07 AM, Tantilov, Emil S wrote:
> I did a rough draft, keeping your logic and I think we
> should be able to avoid the new flags by introducing a global variable
> adapter->vc_xn_timeout_ms and set it based on the flow we're in

Thanks, that works well. v3 is ready along those lines: no new flags,
adapter->vc_xn_timeout_ms set to the default at probe and to 500 ms in
idpf_shutdown() right before IDPF_REMOVE_IN_PROG, and idpf_send_mb_msg()
caps each transaction with it and sets it to 0 after the first
shortened transaction times out, so the rest fail at once.

Backported to our 6.17 kernel (two arm64 servers, two PFs each, IOMMU
translating): no faults in 30 warm reboots. The slowest teardown
message is still DEALLOC_VECTORS at ~300 ms, sent after DESTROY_VPORT;
the queue-related ones took at most 158 ms. With the driver made to
skip sending the teardown messages, the first one timed out at ~500 ms,
the rest failed immediately, and every reboot faulted again.

Before I post it, two things it exposes that I would like your view on:

1. Setting IDPF_REMOVE_IN_PROG on shutdown also moves
   libie_ctlq_xn_shutdown() after idpf_ptp_release() and
   idpf_deinit_task(), as on remove. mbx_task keeps running in that
   window, so an async PTP Tx timestamp reply can reach
   idpf_ptp_get_tx_tstamp_async_handler() after
   idpf_ptp_release_vport_tstamp() has freed tx_tstamp_caps. Remove has
   the same window today; shutdown would now have it too. An unmatched
   VIRTCHNL2_OP_EVENT (link change) has a similar window against the
   vport being freed, which exists on shutdown already.

   One way to close it without new flags: once IDPF_REMOVE_IN_PROG is
   set, cancel_delayed_work_sync() and requeue mbx_task, and have the
   PTP callback and idpf_recv_event_msg() return early when the bit is
   set; matched replies are still consumed, so the teardown is not
   affected. I can send that as a prerequisite patch, but I cannot
   exercise the PTP part here (PTP init returns -EOPNOTSUPP on our
   parts). Would you prefer that, or to handle it separately?

2. A transaction that is already waiting when shutdown starts keeps its
   own timeout. For example a GET_STATS from stats_task, which is only
   cancelled in idpf_deinit_task(), can still hold shutdown for up to
   60 s with a dead control plane, where the early xn shutdown used to
   wake it. Fixing that would need a way in libie to expire waiting
   transactions, so I would note it in the commit message rather than
   claim a hard bound. Does that sound right?

Thanks,
Tian Xun
