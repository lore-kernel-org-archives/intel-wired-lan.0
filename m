Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0E606A31C
	for <intel-wired-lan@archiver.kernel.org>; Sat, 28 Nov 2026 13:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=R932+TZi;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skI8/+rW
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD6766063A;
	Sat, 28 Nov 2026 13:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxetPd16ZS2j; Sat, 28 Nov 2026 13:38:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EA6FD6063E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795873115;
	b=WUVd0eVUUG/Yz18K4XlvzmMScmpdHttvFalCA3QB8CLNQ1sgwKJXSTJrV0KAmJOaCZp7
	 0+b80GnO5TkdlOURPWUQ4b6LACzLEAWXpjPn7u5HLsR+5CgQ5v1FCyOAsaV35tdMxg9In
	 //mDwD+xey6IJcKtRaOEA2OsfkoLk5GU+adlG8a4vCP/rwsUhyNnrQm3TQ2pUK1GBLjhG
	 y5TcvtBMabWx1FeGwwKkkr7okr2w1BPHYZfe/T8Iiydtq9WwTDYDvd9qYsUhg8FhQJUn7
	 Qz7zjScCmhcRNcx+TRsgEPz6hu1F8vaOBnQjjfh1puVkr/3qQsKDka3AYWcSjsz7qKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795873115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
	b=IoSW9JSzjDCGIKD4AX7cuBtJHconYmbo5nWhL8vQIj/VzBXLAr7xtcUlqCgV2p1NjV9a
	 hUicZBoItY+TxgtA4dk7s0qsTaw/LeSHgo1QvXJqrIAdX1EGftd9jnir4XVm5jsGyBTKg
	 Ik42r0OxiZSJKCowjJaJt8kMa23w13QkQMi4KqzqnJ4y8Q4kFFU49+kC56R1GpdVPzgBJ
	 SY7kUaZbIHhAPRx3O92QCjewEMBaqLgWPwe07bVZpAjzC+f8aAQnKjPKls30awVOHdxbW
	 yj/ltY4TRREbRiBZlsDeligwdDqpIZJSVtXjYH+eNMxbgi05RwslkNHm8capnjFTN9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795873115;
	bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R932+TZi9A16lpZJkwI9apF3XiaEOcuI6+i7W0AeCilPIA0PrhJFpCaDdGAtUGfqp
	 8i4XKy8auoPqNtctywkFA8+ZaM7JeMfP2zwvdSkrHPPiQycHEtTswER+aL3p963Z9V
	 YLpP1oq1Hzv5mnD0uR2fxhytjugESLvHTjwS2Riy62d3UEAJmQovuLPmE8WITnsxAc
	 vey0/Vswkm3bFtM0HAqsFJIenai3/6hHaoPYloZBi+XJvkSoBtSJ6bAP0c9Pu/YSQt
	 R8n+qRxxce4aexCePRFjlFYT7F+csoS0E+ntCZZTvBgnaUWlZVwXgYOd3NTVUj2COd
	 VLGUD1wKRgCTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA6FD6063E;
	Sat, 28 Nov 2026 13:38:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2AA43C0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0457400F3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:38:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pIHhgHTGSK-V for <intel-wired-lan@lists.osuosl.org>;
 Sat, 28 Nov 2026 13:38:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7C855400E0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=janislacis06@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=skI8/+rW
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7C855400E0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 13:38:31 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so84648345e9.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 28 Nov 2026 05:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795873110; x=1796477910; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
 b=skI8/+rWe0Dwx05qgktlmFY7Or8j8obkx90TlI5gILYdkx1nn7SPML9oRc8HxTgsT6
 n5PHLAbN4SWweAcy0EWKZyXBPLWhi7BUqzUPKs4IcstRgVqBd1Q8LwdNwxjPC3Vu9G/t
 JxCRohCqozx35hSLNdBDmW8KCgvlXoEvFipzUs0Y/vuGAxYKjCdyt6d+t3Z0+i4APALq
 cjJVM0j/80orZUGHMyZKFEIkb9gtXTRp1DcDv7ROW1UDnF3yIx2HMLL7SOeAlImktsYM
 uoDxI4KdKIkCtq66eU0n7C6L+CvW/UCwF4SmbHZC4V92Qyz4zUwpKgipz6EDi0Qpfurz
 mBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795873110; x=1796477910;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VTacDzAA1ESFTjHp52qh+p5lhJ/YIsbYiH3IBIWoBxM=;
 b=GMMnGCHdqpwoVfTnBvaWkDTlxWF54ruKdA29xkLOsZm5kuzy2mmIvPmIIh4eZknTXn
 Vzuu83IOggI40Glfiw8h5/SYtNQkgK7n3jykZPH+wj23pFScnWVujaxK/DGs8GugwgEM
 kiKMrEdryoTkNcWhidjwH1kkf8Sx+lgEp9rWfy6HDKtcc9ii6FEgXlEIHWXKPspJco+A
 BVP6QRqr5P0do/FqAHKPCbIm6ex+SqTWGsvIxru8EjA1/Y5VEzL3OLnKS1HaYE2RCQqb
 qPdHogcIHfudicpzBsivIUhCfDGpCwfBgSTOYDxA+auZAvQzibdRWhgaF+VrmBcewmHr
 DQNw==
X-Gm-Message-State: APuU4Z98708VOo8If7cM8KVeM1OiEdhgNHtYS3dcGVeaXPQuZ+ZXTUAL
 TX2gyDz+XCJQB6vbA9zDxo0vVTfdblKqo5+x8pdxQUycy0PzgQGR8yCe
X-Gm-Gg: AZFdTZcsnEkyMQfbXIZC0OIUQaLRGG3W70+kBI7ww17U8iWP5DPIn3pDG+wFLMU7P0p
 4ibNB0eaL/XJi8Y1Fq6KjzjqnALFEnAxmlnyiEmIJbhb0pTZYeYm3AnyhaRcFo+OFHlUkdVcIpq
 qvO5oE4zkA4zE4GW5LoP/Bd1ReioNxSWT0sBCJwAAThO78/+bIZ7lw3mTtfh3nxs4xlIwvwpKYp
 eYXuZ/Rb/+SXqJJcUNitc+vzjaLooRzm5ZCxtJlLGw8+MH4nf7d643pVFheKoBcb6icEFSyvkat
 8csosxPghIXJ+RSz0Tco2qIbraPgmtu/8YaUdoGV7h57kbGpdQ7HnDaWGEKndVRc/2S8E6ZAjvT
 K/VjgjBBqy0DBOnKojhwPWsEDu/20FdYvOUuU+7rCIRqEj04COhLJ+XHx2rERht8WGwzij7o2Th
 w07rCPoakKsFxb2HDlKDiMlxuqQd7Dg1okMLytC30DZ4M3YSYSDi5QKW3QtUCyb83g2dJLigN5F
 SUCJ87XTdj08rLxcmRqPJDNw5sBIDuJSii+Y7BpmTsavBR3Q5bYz3Oy8HuSnpIHe/K5bk2PVEMG
 ehgahGpMt63aCFtjPLc6LEqpboJc8QE7RJl+RU90z5x0SDkU71ILXdbom629aADeQVDJQb/pF2f
 WbddRvLkKekReYOxrL6G7unj6xX2ts+CQ2Ic=
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4bb888283d8mr558194005e9.17.1795873110119; 
 Sat, 28 Nov 2026 05:38:30 -0800 (PST)
Received: from pc.tail250202.ts.net ([87.110.86.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm491389535e9.4.2026.11.28.05.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:38:29 -0800 (PST)
Date: Sat, 28 Nov 2026 15:38:28 +0200
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: intel-wired-lan@lists.osuosl.org, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Joe Damato <joe@dama.to>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 4/6] igb: link queues to NAPIs under RTNL after
 runtime resume
Message-ID: <jgtd7s37k4srp7zsqp44yrvc675n5pgo44cvkekhdaetmsqddg@56pjiixzbba4>
References: <20261124235723.1135808-1-antonio@mandelbit.com>
 <20261124235723.1135808-5-antonio@mandelbit.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20261124235723.1135808-5-antonio@mandelbit.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25 Nov 00:57, Antonio Quartulli wrote:
>__igb_open() links queues to NAPIs with netif_queue_set_napi(), which
>requires RTNL, but RTNL isn't held when resuming from runtime suspend:
>this triggers "RTNL: assertion failed".
>
>Link them in __igb_open() only when RTNL is held, and from the work
>item that sets the real queue counts on runtime resume. The links can't
>be kept across a suspend, because __igb_shutdown() frees the q_vectors.
>A suspend now cancels the work item before freeing them, so it only runs
>after the resume that scheduled it allocated them, and it checks
>__IGB_DOWN under RTNL for a close in the meantime.
>
>Tested with the 82576 emulated by QEMU.
>
>Fixes: b75a1dea500f ("igb: Link queues to NAPI instances")
>Cc: stable@vger.kernel.org # 6.16+
>Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562
>Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>---
>v5: cancel the work item before a suspend (Sashiko)
>v4: no changes
>v3: link the NAPIs from the work item added by the previous patch, and
>in __igb_open() whenever RTNL is held (also on system sleep resume);
>dropped Joe's Reviewed-by, as the patch changed
>v2: no code changes; mention the tested hardware
>
>Note: igc has the same issue: __igc_open() also links queues to NAPIs
>(igc_set_queue_napi()) on the RTNL-less runtime resume path. A fix will
>follow separately once it has been tested on igc hardware.
>
> drivers/net/ethernet/intel/igb/igb_main.c | 22 ++++++++++++++++++++--
> 1 file changed, 20 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
>index 6961646..acd9a33 100644
>--- a/drivers/net/ethernet/intel/igb/igb_main.c
>+++ b/drivers/net/ethernet/intel/igb/igb_main.c
>@@ -4146,8 +4146,19 @@ static int igb_set_real_num_queues(struct igb_adapter *adapter)
> 	return netif_set_real_num_queues(netdev, adapter->num_tx_queues, rxq);
> }
>
>+static void igb_link_queue_napis(struct igb_adapter *adapter)
>+{
>+	int i;
>+
>+	for (i = 0; i < adapter->num_q_vectors; i++)
>+		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
>+}
>+
> /* Some settings need RTNL, which isn't held when resuming from runtime
>- * suspend: apply them from here instead, if the device is still up.
>+ * suspend: apply them from here instead, if the device is still up. A
>+ * suspend cancels this work before freeing the q_vectors, so it only runs
>+ * after the resume that scheduled it allocated them; checking __IGB_DOWN
>+ * under RTNL covers a close in the meantime.
>  */
> static void igb_rtnl_resume_task(struct work_struct *work)
> {
>@@ -4160,6 +4171,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
> 		if (igb_set_real_num_queues(adapter))
> 			netdev_err(adapter->netdev,
> 				   "error setting real queue count\n");
>+		igb_link_queue_napis(adapter);
> 	}
> 	rtnl_unlock();
> }
>@@ -4237,7 +4249,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
> 	for (i = 0; i < adapter->num_q_vectors; i++) {
> 		napi = &adapter->q_vector[i]->napi;
> 		napi_enable(napi);
>-		igb_set_queue_napi(adapter, i, napi);
>+		if (rtnl_held)
>+			igb_set_queue_napi(adapter, i, napi);
> 	}
>
> 	/* Clear any pending interrupts. */
>@@ -9548,6 +9561,11 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
> 	u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
> 	bool wake;
>
>+	/* Don't let a work item queued by an earlier resume run once the
>+	 * q_vectors are freed or reallocated
>+	 */
>+	cancel_work_sync(&adapter->rtnl_resume_task);
>+
> 	rtnl_lock();
> 	netif_device_detach(netdev);
>
>-- 
>2.56.1
>
Reviewed-by: Janis Edvarts Lacis <janislacis06@gmail.com>
