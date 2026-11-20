Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A327360A2618
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jxYpHEL1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KhuI3bL8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 87B4C817A7;
	Fri, 20 Nov 2026 22:16:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mMBSL9Ji8QjI; Fri, 20 Nov 2026 22:16:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B72F5817A9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795212962;
	b=BBtQqbiCVYQuV2Cn8flR0xAz/lF5jUxV87J9LXihDfymy8spRG8krk5RCfwgrVFvvxQb
	 Kq3Gc2sab0csxMlvdrMgD5roiK9xrgw/s3Q8uXTP2nnRvuJYEIIcRMQwTF3/KpadBK8wC
	 ym6ZFzODNgwiDv2Vrp2Zn0bsveaz9C8jRkEKzNAiT4y23/gSRUHVniiGX8XjbCNSPUHlO
	 rLdsnc6DvquQUedAwqJwEl3OsLEhOU1nfnXuBk7AmMU58dI1+IKCMQ9FTWAXnPk4b5rbl
	 w2IFETcCWR6phjNSOzbNNFb5y7mpo48mdheCZF6t+nR1aDdg+9cZRyhMogmtMREaOkA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795212962;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=amNkjt+4gpii4aylkTF8IcmFKWS7LX23xgeigY3rYGA=;
	b=Ay5Z6jBidazysDDSSc9eOKTr069XQgKyhNwyXQOSPcuPyySVaQp+5BABxj7aq38lxWvQ
	 wxR3tSg5xOZ78WNWHwVezLtodyatMdS4FUEjAdFU5My+hPuf3oVEPIjmWIk0pzuSN6EMI
	 G0rrgymU1dTRZHhu5Vq3aoVuknsAb3FfxgEKc6ms56EBjru2K64wjJoB3nNWKZQPq9LDq
	 X+hHVup4iTYWnvImWOQbI3ZU9V5Jlcwj+QsTWembYYu2PnYFKXPUvH6iipJ/PHtAOcVyk
	 tdT8H/sbXbjVvPcibFvTFetOqu3ji+ay4gHyaPITt+YKBvhYKwnQeX9V73q6UZwskyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795212962;
	bh=amNkjt+4gpii4aylkTF8IcmFKWS7LX23xgeigY3rYGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jxYpHEL1W+1bMprOQGhlWwhiimF5IwvsObwyQyGP1cKHYHTv5EOEVzgiB0D7ge5Nw
	 NqkjNspCHhEmIo97fwfUce4pCGqqh1b6AYNEJGCETgGEMz7fXdnT6bKorWJd0wUeBr
	 TogBh3T+7DnI2+YZMQts5BHcSfXGhQo+J1VtxmobvKkJZPk4UNMeRer48OJ2Lb4Wml
	 mRUrf25M4tS6NW0JCPjIHclCoA3Z8NgIqGDAoMI72RuoxN3uMUHkr+iOsFwFAGs/k7
	 3dppwE8IqRrRBvdrKvYKY3tQRZ0yqMTm7riGa8WXRlMmTMMaw5SpKVT3ljEUZSZZTQ
	 Ueqk5zRZT6WTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B72F5817A9;
	Fri, 20 Nov 2026 22:16:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00EE615D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 22:16:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DB06C6065F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 22:16:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHTu6vbJKipt for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 22:16:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0022F60760
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KhuI3bL8
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0022F60760
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 22:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8D444074C;
 Fri, 20 Nov 2026 22:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819051F000CF;
 Fri, 20 Nov 2026 22:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795212958;
 bh=amNkjt+4gpii4aylkTF8IcmFKWS7LX23xgeigY3rYGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KhuI3bL8p+6xNuVqgXYw+4OMU7s1+lH3mMEe4eZj8YvmD4oTB4p/wSYP8AZzE8wJQ
 ye004Se7ck9R7PiI+0tJoAPmYriTQSvv8u3cvvFsiz5FZvcYw6NsRsit9ecpEJuleI
 BpXf2a7+0GkyjywHUFsETKPr7dmv2JmH8VWwxk92FDMieARqYb44jzfn0igWhETp3Z
 MMw2cm5ujjHmDfypkU/WMsksX/hwXUytw00vKHH8/BbV8Zq4o4TZbg84+YLO17M8Gj
 kMQR+MeGwuIYIVjj0KzFiHkk/Eto7fV/o++M8qpP9LGOAR0KgM1w5JaSAInKdG3ATv
 whGYBeF/5m6Dw==
Message-ID: <sashiko-outbox-226237@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net] e1000e: fix link stuck at 10 Mb/s after DMoff exit
To: "Craig I. Hagan" <hagan@amazon.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261119221548.10466-1-hagan@amazon.com>
References: <20261119221548.10466-1-hagan@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 22:15:58 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] e1000e: data race on adapter->flags in e1000_watchdog_task()
  [1]
--

commit a2887ea1ca15cc20dbf05390436bdded73c4d7b5
Author: Craig I. Hagan <hagan@amazon.com>

e1000e: fix link stuck at 10 Mb/s after DMoff exit

This commit records the PCIM_STATE (DMoff) bit in the link status change
interrupt handler so e1000_watchdog_task() still enters the DMoff wait and
full-reset path if DMoff ends before the watchdog runs.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index c3e944ee4cf9a..47a6964fa7df0 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1785,6 +1785,7 @@ static irqreturn_t e1000_intr_msi(int __always_unus=
ed irq, void *data)
>  	/* read ICR disables interrupts using IAM */
>  	if (icr & E1000_ICR_LSC) {
>  		hw->mac.get_link_status =3D true;
> +		hw->mac.dmoff_at_lsc =3D er32(STATUS) & E1000_STATUS_PCIM_STATE;
>  		/* ICH8 workaround-- Call gig speed drop workaround on cable
>  		 * disconnect (LSC) before accessing any PHY registers
>  		 */

[Severity: High]
This problem wasn't introduced by this patch, but can unlocked updates to
adapter->flags in e1000_intr_msi() and e1000_watchdog_task() cause a data
race [1]?

e1000_watchdog_task() runs in process context with interrupts enabled and
calls e1000e_enable_receives(), which clears FLAG_RESTART_NOW with a
non-atomic read-modify-write while the LSC interrupt handler sets
FLAG_RESTART_NOW in adapter->flags:

drivers/net/ethernet/intel/e1000e/netdev.c:e1000e_enable_receives() {
	if ((adapter->flags & FLAG_RX_NEEDS_RESTART) &&
	    (adapter->flags & FLAG_RESTART_NOW)) {
		...
		ew32(RCTL, rctl | E1000_RCTL_EN);
		adapter->flags &=3D ~FLAG_RESTART_NOW;
	}
}

CPU0 (kworker)                    CPU1 (<hardirq>)
e1000_watchdog_task()
  e1000e_enable_receives()
    tmp =3D adapter->flags
                                  e1000_intr_msi()
                                    adapter->flags |=3D FLAG_RESTART_NOW
    adapter->flags =3D tmp & ~FLAG_RESTART_NOW  <-- overwrites interrupt up=
date

Losing the flag update skips the needed device reset or Rx restart and can
stall traffic.

[1] https://sashiko.dev/#/bug/linux-63b75aa0-7ff8-4f26-8fdb-d0ecb891cbfa

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119221548.1046=
6-1-hagan@amazon.com?part=3D1
