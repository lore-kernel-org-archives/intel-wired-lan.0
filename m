Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B46CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFC4880F00;
	Fri,  2 Oct 2026 13:27:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hMT_HAWiboSb; Fri,  2 Oct 2026 13:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EC19480F02
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947664;
	b=EW5jjx1Jilbvw2kEKAO9eJTPoYcYByuYoBC3H2RXEunMxab3goQLGWyyq34YwV+NEXPb
	 SDA2tV22lwxRwRn6McTvETMLl3D+B6IezyonVK2id09bEYk6Q5eyjli1OvFVzGvKoZo7P
	 C4y08AH/YMXrvErFyCSr8p6BR5wZwODSgyyUAXCbHyALvKRdllMFH46TNk3eh6hBW0QAg
	 RyP497lNDJt0gzwucqlf6OpEfB4fUzSeWiWGfjdPsQGtW3RFkn8VVoaEY+h1YclI1gdbu
	 bK9aspsVzDU5LFhB3PGJ3XnVcN9MYG8/OMdMglfy+RCYY9SkCSE9nhdlfMylhJaIgcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=SkSliecVUNU+2gOO522ibmOu8d13PAMdSTDIPmpFCSo=;
	b=fixq3iPSfxs0FgkzcyFZCkGnylU6pvW6OO1fgjQZmkqLFcNXYeA4TNzDs9642D39D38S
	 TWbEMgIrsJIY5JkG8NnVvYx5/ZdXXQ8b5kVe0xIPNdmvkKlBc2CShyixHpbDmf8oTO6aq
	 91V9l/YnQ9C7o7d7IKMCbWiviB8aKgr/bqMGaROhT35CNeoq1zeE8BGJcAVo0Ii1SKeiP
	 etZNT8gz3H106LV1ugLgbNFDVGDKHRa/e4rKqAYCINaPmj8eL3bU3Dk5/VGzgXtGt3weq
	 je+lOggX7EwHhgm62CfXCwH/xvTw9H/b81gVPVybfRavZpNDtzdmsZU0Y07M7Ta+fsw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790947664;
	bh=SkSliecVUNU+2gOO522ibmOu8d13PAMdSTDIPmpFCSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=g9y8HLUHS32qGwfbQhrCfg+neuTtxxe3OsYgf16XnMDLwFeMuN4QnR8b5icB8VReY
	 bdUp3ggCV36dwrCRJ6JTMC+A8oIa/DNHqniauOQFbe4jGz5xTDkmZzYBYfU+l9EVT+
	 V6iFU4VUJsy71gFSHrMgWSICE7VE+LQ0T5LdXhdPtqruzPJkM4TK2kzpw6kUGOXwp2
	 uc5BOpKuSzZblU/XFgsiJs1Y8YOZSUXUgxxBa3Vsw7iEHicDFsw9AiJYp0JlrmKjjz
	 //To/qcbo5L+DGpqNagZkQJ1x6UycFemrdKZao7uGQR/kTpJo+9JX9ipkTRyLiL2rP
	 ktHkGisIzyrfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EC19480F02;
	Fri,  2 Oct 2026 13:27:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 323AD32F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 243A0406F1
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1hqxm3JUxcxI for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:27:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3EE3240501
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947661;
 b=bq1e8AWoVzhyC9/m4/N0bS/uENFgSE2DbzoM0t6uVquYmEDo0bpXBTXGdv1V4UDUm9hS
 8M9/p8qZzeGiwSP7cmh6dtA49LE9ZHrOBfLBoca1EkAVItwo5vdUlC0a4ID6eRmw4iAS9
 c0Y8CkGYLvoMuZ5huIGqJ+9wElbYhOmZICK9tGPR1PRKm0DDVQw7mrkHRji4N462bbYz5
 hQcHI6Iq4o4vsjqyoGjE4OCz0gLUkQ91Sa4k5+Sib4Sk5KauK/m9DFV2U1FZ+ORmrYyzl
 h0R0ixMb7hE/Yl2z0XxG0+m3srkQwn3kzP8WtVxnzi6/+9k99NPlJXiWfqzQNnJ+PPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947661;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=SkSliecVUNU+2gOO522ibmOu8d13PAMdSTDIPmpFCSo=;
 b=SrSerRrd8ysy2HtnJtquE962srMIVUrgYkQR8DP2BUUt1rte8ryv+EmPPDkUlI2zPicK
 zOZcFM35NrwAQXH9L0vRh2A0Zrvou37c8q2XdfuVCnaq5KhypI8gAELWeCHwmspPIBjaL
 ay4tyQ215JtB2Gm0VxbOJNBId7URwKhpwcmAQaVsdERAmFeBGaa6FwPWBeB+16MuVk7n7
 V0Fg9+p43xW8TaDJPwgmWVR5+pOZ2S3MhVgGlYGpyu30Fgd0qxXpWKfHmcmUWovieayWk
 W86zIzzjpubPWwPdpt6ALON7uzk6uoKxlf3yx24by2k7hmsr+npxlvdXDiYFWSgyLiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XAWuzS3p; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XAWuzS3p
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EE3240501
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:27:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 13DAF42B57;
 Fri,  2 Oct 2026 13:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C0F1F000FF;
 Fri,  2 Oct 2026 13:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790947660;
 bh=SkSliecVUNU+2gOO522ibmOu8d13PAMdSTDIPmpFCSo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XAWuzS3pP+LAPLbxRQhXic7Hd+BOA4xYbxZoT64leb6k5ZLSKvxR9KYgbPl8cAP9+
 GdrH/zQZoas0FRcwir809SYDP00azLGFBcaG3KROJ5aQvEsXEp7dGg7t0R43TimaXy
 PkU6WAUnktfrwnKacZdJPBP+luGTi0vn/Jh0eaCsEYihRGMuTSh7hA/ersBwoW5Dba
 bclgcSyPMAj4KUpf6VzMmKUGGgyweAbf4jrtLMnWK6tvRRZ/kN2B/2ghvfbI52m4sa
 duxFGoHkfTqtCJ6MfFpJEKricOOJNVPFkw6iYGmM2VEz2/dB0D0nIFtzj0H0TS5xoo
 7AJy0relXehTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from
 the response descriptor
To: "Petr Oros" <poros@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:27:39 +0000
Message-Id: <20261002132739.B6C0F1F000FF@smtp.kernel.org>
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
- [High] ice: conflated -ENOSPC causes silent MAC filter drop on queue full
--

commit 5b00f3f5a2fd8517b295e1041c4e6854bbdcfd81
Author: Petr Oros <poros@redhat.com>

ice: take the switch rule AQ error from the response descriptor

This commit modifies how the driver extracts switch rule AQ errors by direc=
tly
reading the return code from the descriptor that ice_aq_send_cmd() copies b=
ack,
rather than from hw->adminq.sq_last_status. This avoids races when other
commands complete and overwrite the shared last status variable.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
[ ... ]
> @@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  		 * should go into promiscuous mode. There should be some
>  		 * space reserved for promiscuous filters.
>  		 */
> -		if (hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC &&
> +		if (err =3D=3D -ENOSPC &&
>  		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
>  				      vsi->state)) {
>  			promisc_forced_on =3D true;

[Severity: High]
Does this change unintentionally catch transient software queue exhaustion
errors?

If ice_sq_send_cmd() returns a native software -ENOSPC because the control
send queue is temporarily full (e.g., under heavy administrative queue load=
),
this fallback block will now catch it.

Previously, this block was gated behind the hardware-specific
hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC check. By changing it to
check err =3D=3D -ENOSPC, a temporary queue-full condition could be misiden=
tified
as a permanent hardware MAC filter limit.

This would cause the driver to erroneously set the overflow state bit and
return success, dropping MAC filters and leaving the hardware permanently o=
ut
of sync with the OS.

> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/et=
hernet/intel/ice/ice_switch.c
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
[ ... ]
> +	if (status) {
> +		enum libie_aq_err aq_err =3D le16_to_cpu(desc.retval) & 0xff;
> +
> +		if (opc !=3D ice_aqc_opc_add_sw_rules &&
> +		    aq_err =3D=3D LIBIE_AQ_RC_ENOENT)
> +			status =3D -ENOENT;
> +		else if (opc =3D=3D ice_aqc_opc_add_sw_rules &&
> +			 aq_err =3D=3D LIBIE_AQ_RC_ENOSPC)
> +			status =3D -ENOSPC;
> +	}

[Severity: High]
Will this translation ignore hardware MAC filter exhaustion during rule
updates?

Because the error translation is strictly gated behind
opc =3D=3D ice_aqc_opc_add_sw_rules, if a rule update command (e.g., expand=
ing
a VSI list) triggers hardware exhaustion, it appears it will return a gener=
ic
-EIO rather than -ENOSPC.

Additionally, native software -ENOSPC errors returned directly by
ice_sq_send_cmd() will pass through unchanged, leading to the conflation
issue mentioned above in ice_vsi_sync_fltr().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002130752.2597=
259-1-poros@redhat.com?part=3D7
