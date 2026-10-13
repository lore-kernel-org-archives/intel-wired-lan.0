Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F733CC6B0E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 13 Oct 2026 14:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37AD56075B;
	Tue, 13 Oct 2026 14:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHY9a9lXgUWd; Tue, 13 Oct 2026 14:58:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E0FB605DF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903496;
	b=BKNcFmdB8f//4lSe7K5HhA77Hdxqoehd15j22kXnxz10Xj9O41k+5nP8G9FkDE0qyoYC
	 FXwhefYA3edo/ubV/RZ/LDAliUuPLAJq6EppTNFIhSP4Sq6PwYtQzQKDboi6ru0U8wd3E
	 2dAuHnTCpcEQqfs654xas4f4KknHfI98PdE1JyNoXKRYs35+t1YnKrh0ICCakLBkH3Nwr
	 joWdco/g9qjaTxJ6lua1jZ0rx8ksABixtXmxnsraDaxjVcpmzluKktTRd+9hOW7DmJhWP
	 RZANTpuBLCLzVyFEwM4GMjxzxRcBYHp9WTuv+oE5oPVh8IeH1LkjANWrj5USd2ZZQRA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903496;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=5WooK9VoxmQu7NbBL+uHiH74JJTMUwwvl7SUrTQEvJc=;
	b=XZtzmffihR4uZn8VWXykkM2UCJ4rzH6J7Eu1qupgOk5BHBnKhFRqJ36u/VEggGhoKE05
	 2OKtRJc6jhhF7u3Da9nXNhA/hC7mXJUOURSj8UH36oPqD4xOJT8eLrvrCHlpzmhQE3qNu
	 iLyZDvI6Bv39MEhZNlGRnPCL3a+inRFVVh3/RiHaWWCO+DmQhYvo/5VaXL/Ej9Ds7WrMI
	 iTbd+1YSebZtNJRcGaoNytDxQYv0T+Yp6E2hPC/Hy5pMdHR8IGp/rC58eZ+HntJLl00sR
	 OCogxot4r6qNd6qf+Xx1it/apKh7eXYcvruKe4PMkbpypthIyNWcqKbTxY3H42QY3WQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791903496;
	bh=5WooK9VoxmQu7NbBL+uHiH74JJTMUwwvl7SUrTQEvJc=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=0jce1sMRR7x2fhuN4Zg60hlmUFJQB1i3vJ1FQtAU9oYRG9gEagaGNryC/XUpmanPF
	 tCUbJkvGh15nBS8k52JHi5FEdTpFrMueaZrl3lAUBYgGxnBVl3jZcBbQxFAqp+of7C
	 ZcYr6zIXxhUP0Px0COgxSv80kZerQ6alNPAsyAY4GwwxmUwvIuUf9hxongZL2P4WoS
	 lsKBJqJSCSDmfGHTAOZo5XDAZicZxAWrEpm2xET3gYVQ7+QXRSuhS5TAwgyA2Zm7at
	 TMZZa4XGXF7IHdcX6H1iGpayuvYhYNJnebKk1+RTZIy+DYeF8HMyNzGsS8Idi0TJrp
	 6RzZ7foloMBiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E0FB605DF;
	Tue, 13 Oct 2026 14:58:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F03A32E0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 14:58:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5197403C5
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 14:58:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gNBHOo5aRIms for <intel-wired-lan@lists.osuosl.org>;
 Tue, 13 Oct 2026 14:58:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0CBAA403E4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791903494;
 b=YNAzcBt4cX8K82Z7g0pXpFi5JjVMQVQFIZiYlFqWKCi01B8YlnKaBw3zZZhYDiKAKogY
 ED5ijAwTen4F7znzY5GIwYpkgMSxZxVGhZJERa71pj1tjYCMR7HrBZUX51faOaFvQwEIZ
 /TveGepI2N8kzXr9kBRe0FDUvDnFpGraXojYd6UL+wqB/5l1Qe0lnk28BvPn9lcASlkEx
 L5cvoUGNqnZTcQzRHjFixfDrj5oLkvm/EtKQY+kUDJJ/sW4hWiZunkeovnyOxFkN/r4cx
 e3p7ORwiSMseGrLEmp2Yp/YHEBwT0jiQclPjakQZ/SxzZ/XUV0TecQie6YHBjaBAzDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903494;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=5WooK9VoxmQu7NbBL+uHiH74JJTMUwwvl7SUrTQEvJc=;
 b=oUPK8Yd8ReEmR+shHy56h2wCA/FGV0xofmY5NRR8XbKtqI9/6cWzVlp2UUg6LLtgY68V
 +HprDX4m8PwBZ5aDAJ181pqOowoj4wPElYXga1ukD5M5o+5en6rylT8SDaQXpTAoRbvns
 WyqTyq9iegv9gpmvuGsFS7FNbuuoNcFxixRNQZk+fB+5qO0kSLgbZ0ZrYVWXVpKFaAPiS
 z8T8yvFGMVHWHQD4k3cw+HaEYcfPrUhCTOoA4X3nkEUinjFZn/UFiSulnt5Z7om3NLM5j
 tdQ3e6AXljTf4rIT6Lx/kHY86XmuxernGWezjl1sFlygCMfxEw5rshYf8ZhzIItOUVA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IOAoZsiU; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IOAoZsiU
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CBAA403E4
 for <intel-wired-lan@lists.osuosl.org>; Tue, 13 Oct 2026 14:58:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3FF27602C3;
 Tue, 13 Oct 2026 14:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF0321F008A0;
 Tue, 13 Oct 2026 14:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791903492;
 bh=5WooK9VoxmQu7NbBL+uHiH74JJTMUwwvl7SUrTQEvJc=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=IOAoZsiUxt7F2MvnWFg7TVECWclTxoq1fR53VLFVIXopV2kx+MgQjEqch/Ul0AdcQ
 GCZ/Q73Wzr4ruz4RFaaEqPJfVI2ghfrZVHoUUsGLu6SHL7spqHX0XgKbm/G8zLiBFM
 GuC6OHcb9LXFGoIW4PB9PKKRZqTp9vPbAnnEW2UlY2aW1CrK//KWtjg3jB2hfGjZKQ
 fGm2xreYLmFQqpIeKtdAC+/RxM4vCT9doMRnoEMwtDJQ7NwoJSiWMkJ4sq3Mysd9yf
 9Ddqw4v6EhTYdg1X2mCQ4WeTNSVJpS1w98VD3KOLOphB8DKwEEaeOkhDlckEhqoYRZ
 x/7TTvIRTXEDg==
Message-ID: <sashiko-outbox-169952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v2] ice: validate VF FDIR queue and queue region
 actions
To: "Aleksandr Loktionov" <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
References: <20261013144435.1406126-1-aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:58:11 +0000
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
- [High] ice: memory leak of pkt_buf and prof in ice_vc_add_fdir_fltr error=
 path
--

commit 6477a5eb13b0a0dff01249d4a775aff5939e63e5
Author: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

ice: validate VF FDIR queue and queue region actions

This commit validates the VF-supplied queue index and queue region in
ice_vc_fdir_parse_action(), rejecting invalid values to prevent a VF from
steering matched packets to queues beyond its own range.

> diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/eth=
ernet/intel/ice/virt/fdir.c
> --- a/drivers/net/ethernet/intel/ice/virt/fdir.c
> +++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
[ ... ]
> @@ -1176,11 +1181,25 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struc=
t virtchnl_fdir_add *fltr,
>  			break;
>  		case VIRTCHNL_ACTION_QUEUE:
>  			dest_num++;
> +			if (action->act_conf.queue.index >=3D vsi->num_rxq) {
> +				dev_dbg(dev, "Invalid queue index %u for VF %d\n",
> +					action->act_conf.queue.index, vf->vf_id);
> +				return -EINVAL;
> +			}

[Severity: High]
This problem wasn't introduced by this patch, but does returning here leak
memory if conf->pkt_buf and conf->prof were previously allocated?

In ice_vc_add_fdir_fltr(), if ice_vc_fdir_parse_action() fails, it jumps to
err_free_conf which frees the outer structure but not the inner ones:

ice_vc_add_fdir_fltr() {
    ...
    ret =3D ice_vc_fdir_parse_action(vf, fltr, conf);
    if (ret) {
        ...
        goto err_free_conf;
    }
    ...
err_free_conf:
    devm_kfree(dev, conf);
    ...
}

Earlier in the request handling, if this was a raw flow,
ice_vc_fdir_parse_raw() allocates pkt_buf and prof and assigns them to the
conf structure:

ice_vc_fdir_parse_raw() {
    ...
    pkt_buf =3D kzalloc(pkt_len, GFP_KERNEL);
    ...
    conf->pkt_buf =3D pkt_buf;
    ...
}

Could an untrusted VF exhaust host memory by repeatedly sending requests
with invalid queue parameters that trigger this return path?

>  			input->dest_ctl =3D ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX;
>  			input->q_index =3D action->act_conf.queue.index;
>  			break;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013144435.1406=
126-1-aleksandr.loktionov@intel.com?part=3D1
