Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543B71073CBF
	for <intel-wired-lan@archiver.kernel.org>; Wed,  8 Apr 2026 14:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1278040ED8;
	Wed,  8 Apr 2026 14:09:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ArMTCVy4g6HB; Wed,  8 Apr 2026 14:09:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7F82640ECA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775657369;
	bh=bYzchrb2PJb1o1pVGTErHKK6Im21E7HDexP01h7Ldws=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pgGOGS4+nlJCaOZ8cKZfrGVwFFB/hyRopCL5Hja0/nt8AcA/eDVe9hUH8R7r/7yz/
	 ii2kk56+YHGCu9+RdcjpG2tK6MXQwaYBaIFuvsheAQfyhhiwjQyoNI4JFarH2HjpsE
	 LH+i3HC7yCWuXS+OKVCYSNGKC7UHjZsPa6vWDuLJjLr3W9ScWArdJr7yx5dJBKAQ1J
	 01qfHObCCdrez9JKHvfoSMCQNX57OmY9b94BqFv3ETjUvSy6V7xX7MKh4Eehm9KcSB
	 4RHuXm2HrIazXAaa38MLK5zB76MC1RQwu6NbC8HuTx6dNaC8taT7+WQ5aV6H1wBpd3
	 cObgCP1tPod8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F82640ECA;
	Wed,  8 Apr 2026 14:09:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D0EE237
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 361AB40282
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:09:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SamSFoBdR6q2 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  8 Apr 2026 14:09:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 54A99400C8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 54A99400C8
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 54A99400C8
 for <intel-wired-lan@lists.osuosl.org>; Wed,  8 Apr 2026 14:09:26 +0000 (UTC)
Received: from x1 (13.3.31.150.dy.iij4u.or.jp [150.31.3.13])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 638E9I4t057284
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 8 Apr 2026 23:09:19 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Wed, 8 Apr 2026 23:09:18 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <adZd5ZtEzUL_4Oz0@x1>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
 <20260408131216.2662245-8-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260408131216.2662245-8-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=bYzchrb2PJb1o1pVGTErHKK6Im21E7HDexP01h7Ldws=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1775657359; v=1;
 b=UvddOKBuf42IdroTWJsyDyQKYzZRTfDkYThL6stQ0Ibpp1q4Ti9T/39mTlbzGiNb
 E8q0Atfo1haypJpPBRofmN00JTS6tZx1Xh/xYhSb+JjnKkrRZ+L1kUB0iPa0v/NY
 93LEx+F7LWre+wfz8oKiIr2qxcLOeDjI7Xn3PhqeYizDzz3RiHH+yGhZ7cFIomgb
 3Eomxh4mnBr/OEpt7+KlDiRYD77cWAtMS5RMb9BkDgsg3NhxRUQVcy2VMkcOoOTd
 q1vm8CcEBSURWi7igzCyHM1fL/KYyII11oFtrsZAXj7GeZ621Ga6sPrtrvhHTbhz
 MEz1QjdnBIcK9jwqJ0dBoQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=UvddOKBu
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 7/8] ixgbe: use GFP_KERNEL
 in ixgbe_fcoe_ddp_setup()
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

On 04/08 15:12, Aleksandr Loktionov wrote:
> ixgbe_fcoe_ddp_setup() is always called from process context (FCoE
> offload setup paths) and never from an atomic context.  Using GFP_ATOMIC

As I mentioned in v1, I don't think this path is non-atomic.

fc_exch_seq_send()
  fc_exch_alloc() # acquires ep->ex_lock (spinlock) internally
  fc_fcp_ddp_setup()
    lport->tt.ddp_setup() == fcoe_ddp_setup()
      .ndo_fcoe_ddp_setup() == ixgbe_fcoe_ddp_get()
        ixgbe_fcoe_ddp_setup()
  ...
  spin_unlock_bh(&ep->ex_lock);

So even if this runs in process context, it still appears to be in
atomic context while ep->ex_lock is held and also bh is disabled.
GFP_KERNEL still looks unsafe here for me.

If I'm misreading something, please let me know.
Thanks.
