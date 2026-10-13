Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40665CC6B10
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 06:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF8814055B;
	Tue, 13 Oct 2026 06:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1ut1Z1f_zWxP; Tue, 13 Oct 2026 06:31:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E593440536
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791873076;
	b=tYsu1f8jMNrmVh6oCIgx00fKinJUToXRhlIEpQSDqieMM/ZaYoB/bhfYPoxycQ7WDZYn
	 exZH6qP+ofatgiRPsCRkJ2XRjQyfVJXiXDCkVX/SRIHW47wLv3EdOB0xnpCYqRHdmUr0P
	 As173COG3lK8fgBdeDKXXCDMU8TLFwypkxrFbbGU+GYiDA515rK3q4EdIFpJLNlLglfQt
	 hC6j9FrTknPVsnOmLl6MNGNJuYINjnd58tEp+2i5u3g9+3KWlALs3ITu+2xTAcX6wmKpR
	 qjtgSFZu2xCPNpj9HjhVzbx6e6S5HHodYzEn4wTCd2rIJWAFL2dOPZ14hlOCgKLOOyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791873076;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=XoFDFP93lblgWqkBhjDeu7Jxq2n/lmJQHt9GYM5gmXY=;
	b=oeW2wYZfDAqtaV9nPSVp1N+To9CXP4k6q/vO9scJGGXO5OREFj2Oe52/Yag583j18DE0
	 3tq2DVSQm/Pm6KpZBb/JZGevDi9R6nD3rinO6pJZOvsRwh1ka/KPd/8Od9cQpXfHEYG19
	 dQzGY18Pry24YdW0+zMg+EIif5xuFwjCOY+LM3DgEuSDM4lcJwarCWyBUkmINneSzRTk9
	 otz5pR0u9Lxdf07bkaHFkTnnZsR/BpLN0YERHuLB/CmWGIHEM3cdyBXzgDSQ7KB5X3JMA
	 YghfUgSwuddYmHIdqeT+qWx/6bzwVE7zR/WDbR0oGghSAPJnwV6DUSmGhPK2UdwVddg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791873075;
	bh=XoFDFP93lblgWqkBhjDeu7Jxq2n/lmJQHt9GYM5gmXY=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=iEhvBpGcbGmtxYo2xuZMdcIT6rHfiAuM+Fmzr2FtuwgSCDvj0QMQ3CAkRTDszUACT
	 doC8eNgYLqJRQWxYSNkP8wk+1oK2vQ1gq93l+mhrIuDRHVnZU/mMEXxNxMmpGdscU3
	 miiYyDc+iHofec9jeI9EW8e4O/ZyXjcugvgDyd52YOPSVKt4GOPpa2+cdztH5v2Mvq
	 SNQ62lQQsM5eRD2Kc5DZxWuMgrNyTceiENqod6Ghox9pgm4NFDXXf+OuYEMzuJl/Xy
	 BS+/PSH65JSinCy/8ihgiPKzB6bu1JWWYx+8/u2RlTI3YUdSqH7tag+eI5Rzi74Nda
	 /QELDk/PzQZAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E593440536;
	Tue, 13 Oct 2026 06:31:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F015A4DD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 06:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5FA680BF5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 06:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id THyoAgXLNV3S for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 06:31:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 96E1C80A5A
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791873072;
 b=LEc11g2F/ki1ensC9tFmQ4YOvS55vrBPCAC3554uF3m/H3yFTj+EZQOFuqzfhdBhJkW+
 PREjaLMlhfg8egWML1P83Vjtt4kbUVkPrB6vOuFGUxeljhzqAs0XdPgIQfXpKcXMujzPI
 75bEjO7UKwl1bH/2hQfo3cioKdiI/F6FDCMlxX5j9nZCTSe+IDmwX1cw5xXCS+8/b/tq3
 KvkZbeQQ/fUN7w8U74A/aQ9oqKgZnqW+yvK33SKnd7NnLzFVjxEoEfxCcUJ7N3Repk9JT
 nKW/8V5ojEyQr3lqbDaUeKaqxB7Nk/Kll9PO60wBGO/CJ/0g9vW8ffMR8/Bt24jIgyg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791873072;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=XoFDFP93lblgWqkBhjDeu7Jxq2n/lmJQHt9GYM5gmXY=;
 b=KciC1hVpmr5kC4/AKFXA4eJC631N2kWuj8UEebHI36TelYjGJcJEJ+FkxI5KiFAqeGjO
 Z/HfnK+9e47TXSV57rjEBRv3Y1dw+tvBorT0wJVWv8EYu1lHojf6rcENfX/jIBUyB5/JT
 2siyb2F9+6KFqpf2ai0fXFLExWyC3DnUUBzyg2wNivczRwoVajckmq2E2DA5l5BAdkK1G
 LCNlFNAO3UK33fEpEJXbD9xNVnwq8rxSQWP3wnLSshluxnTAsnya3C5+ya5fokquD2fre
 YPcybXmUR2yhUpuhpsCaJDwI+smhUWUSN+wqLuxWj/ywMkb3PGecfZ0sqP+zHy5RNUg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RQzr2NSV; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RQzr2NSV
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96E1C80A5A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 06:31:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98A73600D1;
 Tue, 13 Oct 2026 06:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9F11F000FF;
 Tue, 13 Oct 2026 06:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791873069;
 bh=XoFDFP93lblgWqkBhjDeu7Jxq2n/lmJQHt9GYM5gmXY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RQzr2NSV7M5hSEB3csmMGhYlpEss8XWH0RnWLWCxQ5GznyS4JksF0FwfU+HA7FzZy
 jRDSzkeGh98FfiWfNVOD14+ZUWZ5DgL3aDm0ySOXPPokbt2xYCvs+n20U96EkhkCci
 q0x5fROXfbD4ysiagR6391Pqlsafu8wzF7386Gog7DGJqA9FL/mOGcSJwtLCl80NX5
 X+KxybntBpUJs/jkcDQFO9ptESmn9Vz2nLQqA3e6NIHnJSZHym4mS+t4m869khJ+n7
 NHUK83VAhr3x49yfIhfgRdrFGIhXtOnrOS9OLJJ6LGe6qMxlz59J2rqPucQ4pxwR0X
 jOzGGzZDm2jww==
Message-ID: <sashiko-outbox-169098@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v4 1/2] idpf: don't use the Tx timestamp
 trackers once removal has started
To: "Tian Xun Ng" <luckilystar08@gmail.com>, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261012063027.27750-2-luckilystar08@gmail.com>
References: <20261012063027.27750-1-luckilystar08@gmail.com>
 <20261012063027.27750-2-luckilystar08@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 06:31:08 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: idpf: UAF in idpf_handle_event_link during vport teardown
--

commit 5304a7984fe1d9aebd2f5a30c9206db3b232eff1
Author: Tian Xun Ng <tianxun.ng@bytedance.com>

idpf: don't use the Tx timestamp trackers once removal has started
   =20
On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
up until the vports have been torn down, so mbx_task keeps processing
replies while idpf_ptp_release() frees the Tx timestamp trackers. An
async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
vport->tx_tstamp_caps and takes its lock after
idpf_ptp_release_vport_tstamp() may already have freed it.

Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
running a callback before releasing anything, and make the Tx timestamp
callback return when the bit is set. Matched replies to synchronous
transactions are not affected, so the vport teardown still receives
them; mbx_task is requeued straight away for that.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_virtchnl.c
> index 1caf527069737..d0db6064757cf 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3204,8 +3204,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adap=
ter)
> =20
>  	/* Avoid transaction timeouts when called during reset */
>  	remove_in_prog =3D test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
> -	if (!remove_in_prog)
> +	if (!remove_in_prog) {
>  		libie_ctlq_xn_shutdown(adapter->xnm);
> +	} else {
> +		/* The transaction manager stays up for the teardown below, so
> +		 * async replies can still arrive. Wait for a mailbox task that
> +		 * may be running an async callback; callbacks that run later
> +		 * see IDPF_REMOVE_IN_PROG and leave the state released below
> +		 * alone.
> +		 */
> +		cancel_delayed_work_sync(&adapter->mbx_task);
> +		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);

[Severity: High]
Does requeuing the mailbox task here introduce a use-after-free window
during vport teardown?

While the task is running, it can process an async
VIRTCHNL2_EVENT_LINK_CHANGE message and trigger idpf_handle_event_link(),
which searches adapter->vports without locks via idpf_vid_to_vport():

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_handle_event_link() {
	...
	vport =3D idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
	if (!vport) {
		...
	}
	np =3D netdev_priv(vport->netdev);

	np->link_speed_mbps =3D le32_to_cpu(v2e->link_speed);
	...
}

> +	}
> =20
>  	idpf_ptp_release(adapter);
>  	idpf_deinit_task(adapter);

Concurrently, idpf_deinit_task() iterates over vports and frees them:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_dealloc() {
	...
	idpf_vport_rel(vport);

	adapter->vports[i] =3D NULL;
	...
}

Because idpf_vport_rel() calls kfree(vport) before the adapter->vports[i]
array element is set to NULL, idpf_vid_to_vport() in the concurrently
running mbx_task could find and return a pointer to freed memory, leading
to a use-after-free when idpf_handle_event_link() dereferences it.

Could idpf_handle_event_link() check for IDPF_REMOVE_IN_PROG, or could the
vports array be updated before the memory is freed?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012063027.2775=
0-1-luckilystar08@gmail.com?part=3D1
