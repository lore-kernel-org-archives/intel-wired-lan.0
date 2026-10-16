Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17A9CC6B38
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Oct 2026 11:26:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 55B934098F;
	Fri, 16 Oct 2026 11:26:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZmbEy-P8XI6n; Fri, 16 Oct 2026 11:26:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CC84409D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792150000;
	b=ifBZLSub8uVgT3rxHyI9sZZd/ntljWHqarf70yWzTPkkf3LIxdzimCGjBICILAULNnCY
	 2Zr0v1AjWk4cCMlo8MLpN1GzZ0KDenA3x7yo0SfF2mFkrbXeYpfAvu02o+4rDLIBMzCNa
	 I0FnVcNVuvIJT8LVaYyPynWalKZ5B6jGBW76XLbGn3fx1H55I1EXnOqAMp5W8ZtQf0iNd
	 QxHqyhU9JhRAhIDsexxB9NBTfEuVcIjhGR6NGPpSVDohX5yiudSXvVc7z+sWpBpv5K0EJ
	 SlbB5cs0azaA6sWCOZgwXdyREjWlruMCM8ckAmrO14wetVdcbJyaygdrNGuGAF9NbKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792150000;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Af7cTLsGK+ET03s4FEjGyDI6nn/3kMQiUUW7WpJmf3g=;
	b=dmUFkLx5ONoAeFwp+/ouBDDiXneylTzzHFVtwxRtRk04wV+eJm4Qo1zgSZEzzGdgjFZO
	 M64yfuo43CUYUCUK/i65zk+BhmCVJBbPd5EaqRgdtr3MsfXcrCDrYNbEERjbREgLnk03e
	 TC+nx3jCOAsUdbeyBkAx69ceWYv30UjVJ9uFQKMiXs5xSSkSjEsML/E6gPlMipthl3Fk2
	 SU9cMbdssB6YHk6XrvRGI2qkRPFb2/dLF6LATyLbumqA0HQhKeG9ND5TugstWNWMl4r4y
	 sYu8G5TiCB45a2akUbpL8mUAEekbu/oPBHSF18Z9O19+jm7f+EkkRpmzZdiuwZ4pPaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792150000;
	bh=Af7cTLsGK+ET03s4FEjGyDI6nn/3kMQiUUW7WpJmf3g=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=R/91zIDgwYDAFtU2AJDmljI5A4aS8++wsTv8ojFYL2O2IuO8xImKSaGlrNoBQ1fKb
	 K0qRNOQZGedPcEQvnqgUq9c+5ha1I/1CatD+3LDxjQIglzfKVCfN+y1mN8lFZ7rgWq
	 YuncI0VuofJw0TNz4RjSO6gvvWPTHwk8Pfd+KVEjxmiUePgCJftnEZK0gmKOV63Al4
	 UeARM8B+81DBadZyVP1ZSBMmJhybHN/WWfVSzIY3xw36VP3QSPYYpZzFi2D/9IbN94
	 3v9QaZwFDR6v6E4GQC9UuUyVkcZ97oUdXOch6CbG1bJCuiA13UCnFi3VbTVEEcZzLU
	 p8uhsLYq1GFww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CC84409D8;
	Fri, 16 Oct 2026 11:26:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E7CDD2A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 11:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CE8314046E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 11:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FDnWPsfIKv37 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Oct 2026 11:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C7D784016B
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792149998;
 b=e7aCg+LgEe3xlqdgV+KNpgSgdeTsOBtXQrXTKRQQPCT2zzwn5AIZkQu1/HV72cRwbmE7
 JOhqDFy4Q2UdX7KjQdZK3x23QfJ1EiPwi86w6a+Kk4wcq5AYpoSF/eWtPaFVTpvG+UbNb
 BhgYpPzay0cqr0yyajWp8OHOcOoD8QqOI8RTd3Yu5WXN2b/5UFCJxZAbDPonXAkwakkYh
 JdIFQAvM6E4iXtfP8ITliWCrUsEx6Bk21fsBSJ2G7shPwbp64KT4+uqwmVqE32SCHVjME
 Wi53f155ekg5hA9Iq6EoM3NY2ZHKMl+tlW8Hrw59Rwrl7mnplOW30OkFUiLxGyvb3LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792149998;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=Af7cTLsGK+ET03s4FEjGyDI6nn/3kMQiUUW7WpJmf3g=;
 b=P6UFXsgKwF6W2J3SoNrzpD2AHCxRTJ100pO8snogs56pLh35QnF7KcySbbQEvjJiKlHr
 CmeXlJqYcXWfFPHyM4IRfvL7p4/MitK2w3wI4QJ4rqyxLRyLgtD379wnZwnp4XOst2Uue
 jThiTCXK0lfO7jrpGb7gZptM0I6WVOHzZESmxY/YDE1qaRyWaCnxQLKEoSw1NVC4mWOZH
 6GEBCbLZR/LP3/hKSg56x3QsAnKEE6cLjGS5BgvaKkOIDuKzjOcx5HvdQXJiELdNa4IQx
 nY/sZ4Uc3ALw1XMFUCGIg6NqgXB8QW0NqK0nOGAWQogzjBU4GUEQVW+ZRUoKkieSsOw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cQmQrqD9; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cQmQrqD9
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C7D784016B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Oct 2026 11:26:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EA3E4435E4;
 Fri, 16 Oct 2026 11:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDDF1F000C4;
 Fri, 16 Oct 2026 11:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792149996;
 bh=Af7cTLsGK+ET03s4FEjGyDI6nn/3kMQiUUW7WpJmf3g=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=cQmQrqD9zJ8wMMZfmVj3uxI9DJ32AmBRRAt6jrJlnl5xeg2RIZlDnOESLQ65RsQW8
 gzcHG/bWx99fauObYZ9zTu79Bny8IOTvcaekslh58P5GQ65bAzHnMq2dbUcQextoEv
 DBKvnEdDqN5Vtx6uJN0npNghIKP59wsjn6aorBjywnPAagz5x8X5Avup0dWc/ie2MX
 gd1wyryOrnzYpR/yXDjG8BLYWIp3IqTLOJZoODkROpIyeCr5hB/2egYXQwOV/l8wA/
 skKhaRFEOZG4D/WqHhZ5gUnMiyeKfdsax3uVO/PELp3/K+1TowUbSwFmOFveRuRp5A
 ZJTCsaZCWQxrQ==
Message-ID: <sashiko-outbox-174243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v3] ice: Fix "Unknown bps" during link events
To: "Lukasz Czapnik" <lukasz.czapnik@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261016111653.1196653-1-lukasz.czapnik@intel.com>
References: <20261016111653.1196653-1-lukasz.czapnik@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 11:26:36 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ice: data race on bitfields in struct ice_vsi causing state corrup=
tion
- [Medium] ice: unsynchronized RMW of phy_info->link_info in ice_link_event=
()
--

commit 35fcfc2f1fd4d9de2d01f00551ed70ac2dd02bbf
Author: Jakub Kaminski <jakub.kaminski@intel.com>
Subject: ice: Fix "Unknown bps" during link events

The commit refactors the link event flow in the ice driver to use refreshed
link state rather than event values when the status read succeeds. It also
safely caches event values on read failures, introduces ice_update_media_ca=
ps(),
and updates ice_print_link_msg() to take the link speed as a parameter.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index c26cef0214552..ac0867ef812a0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -844,8 +844,9 @@ static void ice_print_topo_conflict(struct ice_vsi *v=
si)
>   * ice_print_link_msg - print link up or down message
>   * @vsi: the VSI whose link status is being queried
>   * @isup: boolean for if the link is now up or down
> + * @link_speed: current link speed value to display
>   */
> -void ice_print_link_msg(struct ice_vsi *vsi, bool isup)
> +void ice_print_link_msg(struct ice_vsi *vsi, bool isup, u16 link_speed)
>  {

[Severity: High]
Does this function trigger a data race on the bitfields in struct ice_vsi
that can cause state corruption?

The current_isup, irqs_ready, and stat_offsets_loaded bitfields share a
single byte in struct ice_vsi:

	u8 irqs_ready:1;
	u8 current_isup:1;		 /* Sync 'link up' logging */
	u8 stat_offsets_loaded:1;

Compilers implement assignments to these bitfields as non-atomic
read-modify-write (RMW) operations on the shared byte. This function
modifies current_isup locklessly from the ice_service_task workqueue.

Concurrently, ice_vsi_req_irq_msix(), ice_vsi_free_irq(), and
ice_up_complete() modify irqs_ready and stat_offsets_loaded from process
context (e.g., ndo_open/ndo_stop) protected by the RTNL lock.=20

A concurrent RMW by the service task can silently overwrite and revert
changes to irqs_ready or stat_offsets_loaded. Reverting irqs_ready to true
after it was set to false during interface teardown can lead to a double-fr=
ee
of IRQs on the next down operation, or missed interrupts if reverted to fal=
se.

[ ... ]

> @@ -1188,23 +1190,32 @@ ice_link_event(struct ice_pf *pf, struct ice_port=
_info *pi, bool link_up,
>  	old_link =3D !!(phy_info->link_info_old.link_info & ICE_AQ_LINK_UP);
>  	old_link_speed =3D phy_info->link_info_old.link_speed;
> =20
> +	/* don't drop an event that the refreshed link info no longer shows */
> +	changed =3D link_up !=3D old_link || link_speed !=3D old_link_speed;
> +
>  	/* update the link info structures and re-enable link events,
>  	 * don't bail on failure due to other book keeping needed
>  	 */
> -	status =3D ice_update_link_info(pi);
> -	if (status)
> +	err =3D ice_aq_get_link_info(pi, true, NULL, NULL);
> +	if (!err) {
> +		link_up =3D phy_info->link_info.link_info & ICE_AQ_LINK_UP;
> +		link_speed =3D phy_info->link_info.link_speed;
> +		err =3D ice_update_media_caps(pi);
> +	} else {
> +		/* read failed, keep the cache in sync with the applied state */
> +		if (link_up)
> +			phy_info->link_info.link_info |=3D ICE_AQ_LINK_UP;
> +		else
> +			phy_info->link_info.link_info &=3D ~ICE_AQ_LINK_UP;

[Severity: Medium]
Does this code introduce an unprotected read-modify-write operation on the
shared link_info member?

The driver's service task handles link events via ice_link_event(). On this
newly added failure path for ice_aq_get_link_info(), the code performs a
read-modify-write (RMW) operation on a shared structure field:
phy_info->link_info.link_info |=3D ICE_AQ_LINK_UP;

Concurrently, other execution paths (e.g., ethtool callbacks like
ice_set_link_ksettings() running under the RTNL lock) can trigger
ice_aq_get_link_info(), which unconditionally updates the same
pi->phy.link_info cache without holding any locks.

While the commit message acknowledges that accesses to phy.link_info are not
serialized between the service task and other contexts, adding a new bitwise
RMW operation on the error path increases the risk of tearing the link_info
byte or silently clobbering concurrent state updates.

> +		phy_info->link_info.link_speed =3D link_speed;
> +	}
> +	if (err)
>  		dev_dbg(dev, "Failed to update link status on port %d, err %d aq_err %=
s\n",
> -			pi->lport, status,
> +			pi->lport, err,
>  			libie_aq_str(pi->hw->adminq.sq_last_status));
> =20
>  	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016111653.1196=
653-1-lukasz.czapnik@intel.com?part=3D1
