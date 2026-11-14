Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE4606A32D
	for <intel-wired-lan@archiver.kernel.org>; Sat, 14 Nov 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=jDMKccyD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEUEdG3l
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A171440DEC;
	Sat, 14 Nov 2026 10:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6aWl967TAOXk; Sat, 14 Nov 2026 10:59:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B81CC40DF5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794653955;
	b=TB7Th9AgOvPQOxXKFOAW2yKR0nYxhnIKsLkb5k/CmuVnkfUYgdlmrXhmMAo5A4Hi9GBO
	 DkAZI/YlfVqCrMOkGdmwyHz2SkMVQGDrzyvG76J1oFgwfbOAix5AliL7YMZORDX+od3Ye
	 +WNkQIew36OniGnHKcOenxDzwM0pxQklhygiu6lzweJlfxigwqs77b9yKXdzy5JYPtavQ
	 hCZuQmHnRaXtzIWVf3+MxPl4EfvmulYhhtbYaDnqSWW/Mze1bk/FsZ6HC7sSmi4Ow3m1+
	 kerBV1MHjzUo/4IoUDhXzLMKV8Q1PI77ocSLolZGe4e4vMKnYiAuIHee4v0KAMXSQ3g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794653955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=JXn+4Bs4INx2rURRdPlItTph8v61wmHLizW/OAkR6KU=;
	b=THoOFTvpNUv/n8sG1YdDRvmrJ+TmTbeF3+yfoduDOUNN8sfEkFT29tW2mVxukeQ176xp
	 TEiq4FaoQuaAZuNvQk7al7SuBF/368zR59WZsjAtMHTcIaiK/1pkUznEqufomx+PiNECv
	 xCwuJlCcfA/pyR0clktAkXw+BS3FxV8NJTG615Tf9dS0wy7GzPjYF+41OqRVt3taXRr8e
	 zLDZ2Jt0AhNw5qU8FykCur1VxDXbjjs853OOstnYMasijhprRtPkHNPWQobqP84zBKPYh
	 AzU018pz09zHImXpUdptCM5JAugYHTlYp+UkdCkcUQYaL04LDD5LVPfsaaI5Jfjs1zg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEUEdG3l;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794653955;
	bh=JXn+4Bs4INx2rURRdPlItTph8v61wmHLizW/OAkR6KU=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jDMKccyDxlgMD7QEFE5yQk4ILWjyFUL/mvSppRwu8+/wOA2Xw4n7YEK+3Z4iPRE7d
	 tu8CcKH7fG/yLMLlm0/C+9rB6ce3kV9gwK5ctWOPrXRPPufkEMtG5kULBhtgt4gplD
	 O7eYX0mNR0/KxbJKl56M+YEOFuLjMpHS6VubM5buzmYGqNeTMZOUZPFqYsAZJvSFJW
	 Lm95qtwYnI0zFoWPikh1ht3lX395wuE1A8r+z0Ywm2tXlaQQ7eqONQpeN6mpaAmnSR
	 QMALa0t/4kU8PzR1NymVlTa0pxIhxNeP46pRn4Owqs4QOavq5NyPWu88JGWbuzoka5
	 tO4NMqF6yHlXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B81CC40DF5;
	Sat, 14 Nov 2026 10:59:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B02594DD
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 10:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A21AF40DEC
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 10:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g7F4_g-VIi2z for <intel-wired-lan@lists.osuosl.org>;
 Sat, 14 Nov 2026 10:59:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A36740DF6
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KEUEdG3l
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A36740DF6
 for <intel-wired-lan@lists.osuosl.org>; Sat, 14 Nov 2026 10:59:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50DCC61121;
 Sat, 14 Nov 2026 10:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6CF1F000C4;
 Sat, 14 Nov 2026 10:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794653951;
 bh=JXn+4Bs4INx2rURRdPlItTph8v61wmHLizW/OAkR6KU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=KEUEdG3lqX3ZG+MtCdc8dqSNZvzN+sqvEokbf9GdC26FHOa1evcRXbuavxAlc5Jnt
 LRkZ/MvoY06ocPvnBg8TcT38mp4nsG2+I5oj2O6LUSuZTXbl9UKXqtTVBhSp7LvAGC
 edkoE2QmX1On1uNeSXGPA8OwvSk19PhJmVQjHRVvTQCt8PspbLBZrFQZGdZLE9nwrc
 j+TZEiqkJp9scxDMlUfjhZwkQDd/bEmqiRdohkqdRJCc6HeCkiKKAx/f7ntOWIKzF4
 hwZtksE2pBnICHTAC1qPwdcJ5AxbH8bhd1Yy0FckDC9vPc8imcI1WYBsmt9C2/B32V
 q2BwPYpCKdC0w==
Message-ID: <sashiko-outbox-214371@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
To: "Antonio Quartulli" <antonio@mandelbit.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 10:59:10 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] igb: premature netif_set_real_num_queues() call in igb_open()
--

commit bc721a3925f29bdad59ef5c4890bb7278bb44a56
Author: Antonio Quartulli <antonio@mandelbit.com>

igb: fix RTNL assertion when resuming from runtime suspend

This commit moves the TX and RX real queue count updates from __igb_open()
to igb_open() so they are not called without RTNL during runtime resume.

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethe=
rnet/intel/igb/igb_main.c
> index 131df3e09ba14..028cdd90522cb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4178,17 +4178,6 @@ static int __igb_open(struct net_device *netdev, b=
ool resuming)
>  	if (err)
>  		goto err_req_irq;
> =20
> -	/* Notify the stack of the actual queue counts. */
> -	err =3D netif_set_real_num_tx_queues(adapter->netdev,
> -					   adapter->num_tx_queues);
> -	if (err)
> -		goto err_set_queues;
> -
> -	err =3D netif_set_real_num_rx_queues(adapter->netdev,
> -					   adapter->num_rx_queues);
> -	if (err)
> -		goto err_set_queues;
> -
>  	/* From here on the code is the same as igb_up() */
>  	clear_bit(__IGB_DOWN, &adapter->state);
> =20
> @@ -4223,8 +4212,6 @@ static int __igb_open(struct net_device *netdev, bo=
ol resuming)
> =20
>  	return 0;
> =20
> -err_set_queues:
> -	igb_free_irq(adapter);
>  err_req_irq:
>  	igb_release_hw_control(adapter);
>  	igb_power_down_link(adapter);
> @@ -4241,6 +4228,17 @@ static int __igb_open(struct net_device *netdev, b=
ool resuming)
> =20
>  int igb_open(struct net_device *netdev)
>  {
> +	struct igb_adapter *adapter =3D netdev_priv(netdev);
> +	int err;
> +
> +	/* Notify the stack of the actual queue counts. */
> +	err =3D netif_set_real_num_queues(netdev, adapter->num_tx_queues,
> +					adapter->num_rx_queues);
> +	if (err) {
> +		netdev_err(netdev, "error setting real queue count\n");
> +		return err;
> +	}
> +
>  	return __igb_open(netdev, false);
>  }

[Severity: Medium]
Can calling netif_set_real_num_queues() before __igb_open() leave
netdev->real_num_tx_queues and netdev->real_num_rx_queues out of sync with
adapter->num_tx_queues and adapter->num_rx_queues?

Inside __igb_open(), igb_request_irq() falls back to MSI if
igb_request_msix() fails, which resets adapter->num_tx_queues and
adapter->num_rx_queues to 1 via igb_init_interrupt_scheme(adapter, false):

drivers/net/ethernet/intel/igb/igb_main.c:igb_request_irq() {
    ...
		igb_clear_interrupt_scheme(adapter);
		err =3D igb_init_interrupt_scheme(adapter, false);
		if (err)
			goto request_done;
    ...
}

Because netif_set_real_num_queues() already ran, the networking stack keeps
the pre-fallback MSI-X subqueue count and transmits on multiple subqueues
under separate _xmit_lock locks, while igb_tx_queue_mapping() folds every
r_idx % adapter->num_tx_queues onto adapter->tx_ring[0] without
synchronization.

Also, if igb_xdp_setup() is called while the interface is up and
runtime-suspended, igb_close() is a no-op because !netif_device_present()
and __igb_shutdown() has cleared adapter->num_{tx,rx}_queues to 0;
igb_open() then passes 0 to netif_set_real_num_queues() and fails with
-EINVAL before __igb_open() can call pm_runtime_get_sync() to resume and
reinitialize the queue counts.

Keeping the queue count update in __igb_open() after igb_request_irq(),
guarded by if (!resuming), would avoid both regressions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113105835.3821=
433-1-antonio@mandelbit.com?part=3D1
