Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED79ECC6B3A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 14:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9DE7881218;
	Thu, 15 Oct 2026 14:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jTz-hZb9eFPu; Thu, 15 Oct 2026 14:20:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C29B281225
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074042;
	b=NojEoV9LCjp1NKs8PindDBHr6gJ4Ln08qknx6DSfXYLDgE7i89zDLHSTa/ewYKhidZEr
	 AzUv7y4Th/oZ9Yr00aTNbKEFnMAm4RkI3jsUTJXm2BlGkTNsnIQ4soR1PgMV73IVKnJJU
	 5GVH5P5rPmej5oXaMWRxKH3fpoLCLPP19S0uhXWa+rODSq0PtUmAdACRhdGGIrg3XcCaS
	 +zZZ7Clytx0tJ7bhQqVvdUD9r+4hEjTysbgEueoQOr5MYbSZLOQDWG1n0Px29CfBbBq9+
	 9GT6Bi7VNkpS8L7fBp5xs1iF8S8c6hIX8AqmKk5SUVRNbYq+btXGJDYvR6C6yETL3mA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792074042;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=WjTFLagxSKQ6VkCqtR02GQGkKh1DGf6N1cttl3FwrBE=;
	b=r5FOSpkXirwZ/3CNhNK9X840xNFji9nvNny9NSoFWXCjaiTnO2SW8x6g8izqEBUgvaac
	 HdlX/gq+0PZyAuapwYWMj9pTrb6xxa64foTZdj/mYzQk+SohQds+57EtfoifA3IA7SX5D
	 DhlI45JBa0xMK71n7x2GVVf57q0m9BEjis2QKmVlAdNHi80dFg1bHT0NJmL42nH4aYUDD
	 b+8oWVObgbVEgDeSq9oScm8KbNWJCYsv6OYqEr4yJVOvvNq5nTcjnVDFN+Xf4tjTvjGou
	 gKSz1gdezwz3izklfEMHtf8TNuxZjEd6VC25LlAAe8F1wYCnq1HGIpkw8oBlX89P20A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V64OGK+l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792074042;
	bh=WjTFLagxSKQ6VkCqtR02GQGkKh1DGf6N1cttl3FwrBE=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NWhTaNM/he04l3qIx/pxMLBQhJkogIbQo8Zyxxuf3oNjEWh7gAYq1lUAXuaX4KY9r
	 k7wNF5J/c7gUeHX3V0kRnsl0YnX5QP9jMhVFDuGjHBezkFPinSXfoGf+SAY2FAGnrO
	 LDVIwkKPjXObjDMeDsr6cYNELzci5AZNxtML4QwvikgW3WBY9r/R0kPLOFXFHLeaaS
	 g3BtnvlGlmGGcYQYG9jwRSQPiB0vKmI49gbaPS0JlGEaiSlJkQ2scMiuPWaHy/HZvs
	 7YhtiAa5OEkJwT3cEaaYH2nnrCWd2U6OjvjtaHR9aHizEozEzRRREq99MtxDyZl5Mu
	 ScEVdHQUXvEdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C29B281225;
	Thu, 15 Oct 2026 14:20:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16E85105
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 14:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 08EBB81225
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 14:20:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pP79ddubckNl for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 14:20:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E10E381218
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792074039;
 b=F+XfF6mVNkPUt0x/RXQiYmsRbrfdY2LOzwNUI73BVFyP8VCfgiVKCptyq5k64L9wysIc
 yxvuE38yCtVWqIxGKry93S27nO7dQo/q8YlLqz5YuEWcfk62koXIm7gdaILnkoucXpZ/o
 fYhBP900aVJ8trwe+x6d+TIREpG+iorEXNuBAEEvJ0Yh4aUd18yj8j78jV1YT5mAaLDnh
 TqLEXZJHpb6hXrsqf3QL4wgmyxsd1xQ3omJj3+lkaLHh4JgSuKDubwJU2a7BJXjjTIIvy
 ODxU23t0qY7t6/YKzGXwOpfHpMjd5vPY3j2uIZqDAM80sVqygvcHsT5DRfyTPD3jqbA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074039;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=WjTFLagxSKQ6VkCqtR02GQGkKh1DGf6N1cttl3FwrBE=;
 b=GcbnR20uoRU7rAs12PogcbRo+mmBBectb4/c4H+Rw2cSTTPpJ3w/whwp4/PsdIuVCxDh
 urJvmbRqHbXmZ7tSloGKWllRARqyRatxkz+bwp5RxukfZdjxlHbGq8bTlqg0uT1iDEb+M
 Px3TV1HqLS8aVznIkxqepwDodvhAkvsBMRN5XMp5z8wT2i/m+EUtNtf+hCtSlABbmXCpl
 pMhfHCkHFk77gTAk8b/oBtxkaftY7gDaj+p2AOFs15f8yqF8xomadd3JLul93832qba4m
 Klq3VuRov8EFHGx8lI8XdKb3sP4cldxO5qW3ELtK2DmBIMJIbfe6+m5ZZvI7ABRcLHg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=V64OGK+l; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=V64OGK+l
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E10E381218
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 14:20:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 524FC601EF;
 Thu, 15 Oct 2026 14:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17291F000C4;
 Thu, 15 Oct 2026 14:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792074037;
 bh=WjTFLagxSKQ6VkCqtR02GQGkKh1DGf6N1cttl3FwrBE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=V64OGK+lRy2DtSbRgQ6ZWDHRTT59lWv+yBr2Zf3lGKJrbZb3nQuNNfMNXrjNOyFL0
 INkYoRp6HvgNa9XKiUI4RqY7ROUx1jtef/20wnqJv3cPRreiQsUW+tQbyQ0PTadEJV
 FRz49ouQIwfETgMgloZQIqUmNYO5P1SZA8NBuaubO7zX3Y7lzyFPglLR45RtDxkUpf
 gf4k+hewglZBLIuuYqqMPHRoWEp9shK8RrO+ikNRXdbJVFPm0UhA3bk/ro4v7RQrcR
 47Va3cptCkaPiG6xvlDLeLXrlNKRPSoXfbrE2RtPPf4+m+/IE9t9ojv8iOoHHkEeZe
 h7zdJOfVLwrKw==
Message-ID: <sashiko-outbox-172956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [iwl-net v2] iavf: fix VF stats not updating due to PTP command
 preemption
To: "Tomasz Lichwala" <tomasz.lichwala@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261015140409.3124712-1-tomasz.lichwala@linux.intel.com>
References: <20261015140409.3124712-1-tomasz.lichwala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 14:20:36 +0000
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
- [High] iavf: permanent starvation of background VF stats due to PTP worke=
r preemption
--

commit 1a35506e39b53de13d7adda52b712e11b62285e8
Author: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>

iavf: fix VF stats not updating due to PTP command preemption

This commit attempts to fix frozen VF stats by making stats requests
unconditional when the adapter is in the running state. It also sets
adapter->current_op around the PTP send to avoid dropping completion tracki=
ng.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index b6e10cc9faca0..830da8f1cdb62 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -2983,18 +2983,12 @@ static int iavf_watchdog_step(struct iavf_adapter=
 *adapter)
[ ... ]
>  		} else {
> -			int ret =3D iavf_process_aq_command(adapter);
> -
> -			/* An error will be returned if no commands were
> -			 * processed; use this opportunity to update stats
> -			 * if the error isn't -ENOTSUPP
> -			 */
> -			if (ret && ret !=3D -EOPNOTSUPP &&
> -			    adapter->state =3D=3D __IAVF_RUNNING)
> -				iavf_request_stats(adapter);
> +			iavf_process_aq_command(adapter);
>  		}
> -		if (adapter->state =3D=3D __IAVF_RUNNING)
> +		if (adapter->state =3D=3D __IAVF_RUNNING) {
> +			iavf_request_stats(adapter);

[Severity: High]
Could this regression lead to permanent starvation of the background VF sta=
ts
request?

The PTP auxiliary worker runs periodically, queuing a PTP command and waking
the watchdog immediately via mod_delayed_work. Since the maximum interval
between PTP commands is around 1500ms, the watchdog's 2000ms natural idle
timer never expires. It only executes when preempted by the PTP worker.

During this PTP-awoken watchdog step, iavf_process_aq_command() processes t=
he
PTP command. With the changes in this patch, iavf_virtchnl_send_ptp_cmd() n=
ow
explicitly sets adapter->current_op =3D VIRTCHNL_OP_1588_PTP_GET_TIME.

Immediately after, the watchdog unconditionally calls iavf_request_stats().
However, iavf_request_stats() checks if current_op is occupied:

drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:iavf_request_stats() {
        if (adapter->current_op !=3D VIRTCHNL_OP_UNKNOWN) {
                /* no error message, this isn't crucial */
                return;
        }
        ...
}

Because netdev_lock is held by the watchdog, iavf_adminq_task cannot run
concurrently to process the PF's reply and clear current_op. Thus, the stats
request silently aborts.

Since this cycle repeats indefinitely, will VF statistics remain permanently
frozen at zero?

>  			iavf_detect_recover_hung(&adapter->vsi);
> +		}
>  		break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015140409.3124=
712-1-tomasz.lichwala@linux.intel.com?part=3D1
