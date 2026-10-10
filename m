Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07364CA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA5A340952;
	Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XOYvUTIxZmU0; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E123440955
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634570;
	b=NMuW0VwxX8sUsfoWqTtdj21/k5ykjIFk4Dac3jnDO+XOZNagvB5zqVN0M0ZxDDrSpxEy
	 EFxmLxZdCWofILRcr4f72TFxjUCiYTVmOlKKIUgpXUetKa+mwszi0vwGPOVmJXhx8ECPt
	 VcvoNnGD2pRLwmlwj7EGAJL7T7vWFkmyHp0f6hInQo6g5ZGqjNrabIyWH2ZyBDLXWRCQ8
	 MAlRIeYRuEAfidoNTKjArDNCNsmK8VXibRO/LvJgRgv7jjx2DXuQ1KFCFl8JaO9aZYUsN
	 KxvARmRU43OmkGivCCokPzRbC328w9DTCDaViVTpvaRCdgTkNTmt4Y9W+vIPBz0wf/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=3KOm8NOpd68WsJNZnCOWnegjk+4+itiXUHn1rzGL8wM=;
	b=CL9NTtJsKAJUFwOrSu/eMLNfqwwLwuWLYS+DMB31pWMTm0gkKcKZKxjYGFVbPPNLEj7i
	 WBnKYIWRZgkyDA+DFi/lR1oq4B+muygPsoay4o4PoqYpkMzaKj7M8NQ6GaYe4Po2yB1Tc
	 LdKie0pjzztDbAF6Y+NjEBlhB5lRRxjjaonya7A3jO+LsfyyhdxHYkG/7DQdZjgj/dgGW
	 uACivtwgktacsoTdgRtu1C0xJMjgE+/GAh8MbIvGh2JqgIqlVU/5OG5QKrierH/deFv+v
	 xvpuG09x9BspU0VeXPKJC0BEpC9j7SagI286nnMyjmwjCRH94T0+LeFMQwKoFvrOAbA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791634569;
	bh=3KOm8NOpd68WsJNZnCOWnegjk+4+itiXUHn1rzGL8wM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=uDYMKmYYJEVHHU9JwaFaJBMYHXBZN3o15QmI509uL6J4oZDey1NAnFZGWxgsu/b+m
	 IdjLy9doNNoiTK4Stokk6d1beFcgd/74A+7Ip9xlbNXrETD4FGStQ6WfQDgF5h5ozq
	 7Io8/FZi5zvxcrgEghlK9ABy8PrEmuCXIlgm6RL2o8rJkz9je/nA29i5DHXC3DU6R6
	 /yYfcRcBRnmKd2kS/BSNASAJr5gJAo6yLkktK9utuAlCpIj7Vi7DqBKV11eHJcRdAD
	 cHveJ3sl8wzutJGhoCPLqEje+Y1zUd6BzfgIsjKcmQ1HbUzxpXc9VM/1V9sV+mKi4A
	 JxSyJ2ykVYS/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E123440955;
	Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C747156
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E7A24010A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YwEPuaebqT2y for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 12:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3340D40004
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634567;
 b=eUvAttzISGvZrGNltOrHykuV73dPAKUCFz7kmGnsrB1huVaQrgpKznl7Jm10Joy/v7pn
 GMpYi3em2UKgougZ7klZxyEk8Zn9MulwRHaT0x+HlnguFSOnIzd5AsSZHxQHBkiTGI46j
 xfaT68U+xEEDIXNe0iU5SvejZUssYpl5KLKSSf26uwEDQDO68NnY0S93H413ewWYb5H0S
 cVlbqlKjXRQYkiF2c5POSJa1RQPDGsDPj9h4e84tigxejySQC+IS8xHBU7FrHrtVRvAuB
 WbGAdIjYceuyty9o2Klc9zwcEpxJXBBUGgFNb6n31M/IoHA3sl8tWugTS6qLIrCbmgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634567;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=3KOm8NOpd68WsJNZnCOWnegjk+4+itiXUHn1rzGL8wM=;
 b=QbkbsRegjU+9uu1mVDHy7ZL/HXEfhaXbldENhTsaUKYCXqrxNUooqfLkCGkJtbhYnRyl
 xja2u+PaFTyAOt5I+ppLH3hqNu5h0utgcuxoBSLGBQFzdY3gbk6qqmwv5F6vFR3X3kanC
 Qm5KxOVIOXYFgUKtbPTlBzLuUSi2z5zA+1OclV7MOxtW1ouymPvqXnqLlRNuJ6QxODF4L
 9yweM/NdCrFJRXR/E6+tWsTjyK4Kj3V/4JC/L88HHdNJzJFU7ER70eZ3vKubcWhrZeYgl
 Lb+TcbxMW62xN+RpONW6kw39PFZCCe+GpxPUg20Fs5DKGFfC7tsFFuVwSDp9HWCjRYw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kwdjwv2U; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kwdjwv2U
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3340D40004
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D76B40449;
 Sat, 10 Oct 2026 12:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0211F000FF;
 Sat, 10 Oct 2026 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634566;
 bh=3KOm8NOpd68WsJNZnCOWnegjk+4+itiXUHn1rzGL8wM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kwdjwv2UwiBXhaf+f0EDE6TsmeBTo7cdjzTnKHMJsiEa8LIAnohvJjZ8Ijlw4eH4P
 sR4FafmghO8pbysoYFqlm2UzcOWIg/jfgUUz+44m5AiGJD2Tjv70d2nh4ePNhZJoUB
 ektboxTGqiP7Jndv9bqiwBKYzSUqRKsnzi1lu1YIWwo/5Dek00UZtXvCem3gx4Xh5o
 uLozmSv3jSIAXWqnBeAgRzLpaAT/kLCzjDEgl8vPIRW9FBEYJK6zTJEwv0Ry75X2pW
 CJpyIrFwqOKo+eCPVj62IDR7de6Nz+NzkakBep/T+f8oGb72ouC0rqYCpFGvFyg0B5
 TZgU0ku4Rs+nA==
Message-ID: <sashiko-outbox-166501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 06/14] ice: bump to 256qs for VF
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009121433.30347-7-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-7-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:16:05 +0000
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
- [High] ice: virtchnl error path disables wrong queues when loop index !=
=3D queue_id
--

commit a7e9d03ecfb2e4d593b7ee51e67a3a4e87ee7a85
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>

ice: bump to 256qs for VF

This commit adjusts limits, bitmaps, and arrays in the ice driver to support
up to 256 VF queues. It updates the requested and default queue limits while
retaining the legacy 16-queue limit for older virtchnl opcodes.

> diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/e=
thernet/intel/ice/virt/queues.c
> index 2667634e3c8c3..61304493af34b 100644
> --- a/drivers/net/ethernet/intel/ice/virt/queues.c
> +++ b/drivers/net/ethernet/intel/ice/virt/queues.c
[ ... ]
> @@ -841,7 +841,7 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>  	if (!vsi)
>  		goto error_param;
> =20
> -	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF_VCV1 ||
> +	if (qci->num_queue_pairs > ICE_MAX_QS_PER_VF ||
>  	    qci->num_queue_pairs > min_t(u16, vsi->alloc_txq, vsi->alloc_rxq)) {
>  		dev_err(ice_pf_to_dev(pf), "VF-%d requesting more than supported numbe=
r of queues: %d\n",
>  			vf->vf_id, min_t(u16, vsi->alloc_txq, vsi->alloc_rxq));

[Severity: High]
With the queue limit raised to 256, does the error handling at the end of
ice_vc_cfg_qs_msg() disable the correct queues when a failure occurs?

Since 256 queue pairs exceed the 4096-byte admin queue buffer limit, the VF
driver must split queue configurations across multiple virtchnl messages. In
the second and subsequent messages, the array index i will not match the
actual queue ID being configured (qci->qpair[i].rxq.queue_id).

If an error occurs during these later messages, the cleanup path iterates
using the array index i:

error_param:
    /* disable whatever we can */
    for (; i >=3D 0; i--) {
        if (ice_vsi_ctrl_one_rx_ring(vsi, false, i, true))
            ...
        if (ice_vf_vsi_dis_single_txq(vf, vsi, i))
            ...
    }

Could this use of i instead of the actual queue ID inadvertently disable
unrelated queues, causing a denial of service to other active queue pairs,
while leaving the newly configured, partially-initialized queues active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121433.3034=
7-1-przemyslaw.kitszel@intel.com?part=3D6
