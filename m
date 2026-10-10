Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294CCA9EC5
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 12:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB83B40969;
	Sat, 10 Oct 2026 12:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iaH8DyNTect2; Sat, 10 Oct 2026 12:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B552E40966
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634573;
	b=LGXs68dSgXtoCllhE8eebZ81V0MZOio41e/H7v+TZOIpOuh4++mkVR1TE/5pfB4rxeJB
	 EVybQjYvO9qTmbGHXGb/hc3Js5Dlr2JYhbyD9e0tDXGgzmnjQyqvqdjulwGkNpJo2P3J0
	 lI00lGY49eCNvU8DzN2bbqghXJYqHgpRpiuC0xJySxJv2jWaxS3fZ5JuTG0yYOppYx4Mb
	 MId375wRC4uODGsaJQBI+VwgKLa4T9Ekq0ZtZv749g/QQ31RSHz9XOdvLg7W9y6saVw1k
	 1LfM+setsmaRQWOcS7VqKf+KvRlOOCuVbrnDztirUJKuzaAps2Krqb13/T1Fs21c2yA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634573;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=6mKhDlOgx3l/UgtwSiw6kFGJpYEctxz1SE/VirBm7Ks=;
	b=SBHlhUwtD8e0thdhgZfUxq5cknP1ODZVvtwPpUYVypEzZcAP+dje5Lyi96j/tyzjIWK+
	 LSi4hyUE/KKM0VC34VIOic9AIBnM8Ybgsb3pYXAhUuI1EcXjCphUS0YJkkXxyTGJvd804
	 xFFTPalxa70URmKnXr90IR9900fgH+cmcnxMAdxmPaNSkkyjrSP8CKGSaRieiBq0rI6RR
	 +ydsX4vMt3k3HU6n0O5m+aRK+oYOIy5PQplNwlk9ov4FeMbjcNGWerQUsneMwm+1ZvBaI
	 YOhy/5pmYVo8n+mtn1/JAS09Ead/SR8c86qMHgoOq6dWIBolU9DCwq3XWdMuR4av3kQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791634573;
	bh=6mKhDlOgx3l/UgtwSiw6kFGJpYEctxz1SE/VirBm7Ks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=IS3vXLXF/0cQZeqhsGvIt4OoqaMishdn3TRHcirs6mb3k5gyTfNEDRChvm51ZqUB4
	 h8MAPbSQFjrNLZIBCJG6MNxGe2nZU6rurZlA7URR0TkZziatzUbt3H7iaoVA78YWQE
	 8ffvODb75QN/pq14pRuI5ffZxHKa1vFRBkwKYkCqVn+P1X3AoSjXon2Vk0zhXaXslO
	 dZpuZ6+eDDsJ4ICkYJX3MbCK4N3I7I12JoQsIYGK2IJzECDIXfc5nxpdwoOQH3OKT0
	 Ca6Y5clFF5jT0VfHe2/vCspaR34auY9f+DWlbIWFiZg++sB5hqTa2wgX3QRwrw4AmD
	 Mc7fTiJS9eS6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B552E40966;
	Sat, 10 Oct 2026 12:16:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BBA26317
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ADC2B4010A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ric6hP6AUuy2 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8BF2640176
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634569;
 b=TZiJn15dQkb8ZFrls067wIjHTdoyJK99euQ3BTRd4AtlAa0K1ydSS3iqYhq5g0V/Zu00
 0cXnJpOXGiI7+A1xKYrz0NTPiKrctBTXjCYtnxQKuWpr+iBog20t3XlqRrbF2voQeBaX1
 xb3O0VJ7KFl3q4wJ2xFZUvmPDhdPOzlWWu7r6PC5+kDd4DKmYfkEplhCY1CYHcJ/Y0l/+
 aq1o3vRp5+4dzIBok5jw0bTbtP5sFnzQqN3knZKULbxgN0jI6TIwtdCAc1Lt05DH7FNfy
 m7ocODBNn9Rkqqlmm0kehZaHNHM3TiD4C5BTTHTcuWAzgckH56jwy0PBwHeFSJ2bmxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634569;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=6mKhDlOgx3l/UgtwSiw6kFGJpYEctxz1SE/VirBm7Ks=;
 b=S0oWGZjcVUmoXDrzI6u7RP22vOc5gatgbkGNwiQYONr7pnTkFcYOsWgBF02APoJkFFvB
 eqFQR4T4YZrkqnWu+usHRMxyUiFLUOfidkCc78wbvY/kpcDjZD2uTIrj/blNLV/vXXDL/
 qck6c/iOkZY/v7z7bJ+UoxR+GI8Xh8uFAAf4GyxtcxCnIdV7N2WLYf50ELSiamAcQr8ZK
 HfFi+3rCw0MT9oAeDhLR9z4q3hebzz3DKgPlr5Sf4yTFCPyExMOLxnHjuBySwH+Yhr4yC
 UOmjf+KivE+EjpwMjUSRzjppFqZEUXJyyyQ4oyWKYPnfGJ6ImCWj/IXufn8tRmcmjeQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IYYC4ETz; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=IYYC4ETz
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BF2640176
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2598A60204;
 Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31521F000FF;
 Sat, 10 Oct 2026 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634567;
 bh=6mKhDlOgx3l/UgtwSiw6kFGJpYEctxz1SE/VirBm7Ks=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IYYC4ETzpm1B0C8MIomFJMgGRXe7Sl7Maqkviq3n+7bBI4xW1ka2bx6k+DL3wZOfo
 jkhyMv0rofxwJla6lC6+Lx7JzCThLebs8hcd/cu9YGjmS7LK2Kge21p212IDrSrLlh
 dLqLjgGbc7MrmSiRko8HZbuECqT5OOFhBOj0CH1eVl+AePDnWZsJ0HyRleExtZBh1o
 VZIM9lIfHBB7HYSuBmhuqpnCpnWI2DVzgFrPG4ZO+ID9+GUgdgekxeXqgnfDJaavBf
 WGU64BN1yX4pZl3RpKGKMYOo0nEDvTeiKMZohK5QH5FHatVwPp7981JGDTNzHpibyf
 fbhJZOrtRQpPA==
Message-ID: <sashiko-outbox-166505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 10/14] iavf: use new opcodes to request more
 than 16 queues
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009121433.30347-11-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-11-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:16:07 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] iavf: early return in iavf_parse_vf_resource_msg() skips VSI i=
nitialization causing panic
- [High] core: strict type mismatch in min() macro causing build failure
- [High] iavf: division by zero in iavf_fill_rss_lut() from unbounded qregi=
on_width
- [High] iavf: RMW data race on adapter->flags leading to lost state updates
- [High] iavf: early success return from iavf_parse_vf_resource_msg causes =
BUG_ON panic
- [Medium] iavf: auto-requesting queues on every reset destroys user config=
uration
- [Medium] iavf: ignored ENOMEM from iavf_parse_vf_resource_msg leaves inco=
nsistent RSS state
--

commit 30797d207471017781d2b1737aa86bb6b0ea80c5
Author: Ahmed Zaki <ahmed.zaki@intel.com>

iavf: use new opcodes to request more than 16 queues

This commit introduces new opcodes to enable the VF to request a variable
number of queues (VIRTCHNL_VF_LARGE_NUM_QPAIRS). It defines a capability
exchange using VIRTCHNL_OP_GET_MAX_RSS_QREGION and introduces V2 opcodes for
enabling/disabling queues and mapping queue vectors.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/et=
hernet/intel/iavf/iavf_main.c
> index 8059e855dc096..f8193b0cae4ab 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1775,10 +1775,14 @@ int iavf_config_rss(struct iavf_adapter *adapter)
>   **/
>  static void iavf_fill_rss_lut(struct iavf_adapter *adapter)
>  {
> -	u16 i;
> +	struct virtchnl_max_rss_qregion *qregion =3D &adapter->max_rss_qregion;
> +	int max =3D adapter->num_active_queues;
> +
> +	if (LARGE_NUM_QPAIRS_SUPPORT(adapter) && qregion->qregion_width)
> +		max =3D min(max, (int)BIT(qregion->qregion_width));

[Severity: High]
Is it possible for a malicious or buggy PF to trigger a division by zero he=
re?

If qregion_width is >=3D 32 (on 32-bit systems) or >=3D 64, the BIT() shift=
 invokes
undefined behavior. On 64-bit systems, a width of 32 results in 4294967296,
which becomes 0 when cast to int. This makes max =3D 0 via min(), causing a
divide-by-zero panic on the subsequent modulo operation.

> =20
> -	for (i =3D 0; i < adapter->rss_lut_size; i++)
> -		adapter->rss_lut[i] =3D i % adapter->num_active_queues;
> +	for (int i =3D 0; i < adapter->rss_lut_size; i++)
> +		adapter->rss_lut[i] =3D i % max;
>  }

[ ... ]

> @@ -2486,6 +2493,23 @@ int iavf_parse_vf_resource_msg(struct iavf_adapter=
 *adapter)
> =20
>  		return -EAGAIN;
>  	}
> +	/* in LARGE mode num_queue_pairs is the PF limit, not our allocation */
> +	if (!num_req_queues && LARGE_NUM_QPAIRS_SUPPORT(adapter) &&
> +	    adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_REQ_QUEUES) {
> +		adapter->current_op =3D VIRTCHNL_OP_UNKNOWN;
> +		qnum =3D min(adapter->vsi_res->num_queue_pairs,
> +			   num_online_cpus());

[Severity: High]
Does this code trigger a strict type mismatch build failure?

The min() macro requires both arguments to be of the exact same type. Here,
adapter->vsi_res->num_queue_pairs is a u16, but num_online_cpus() returns an
unsigned int.

> +
> +		return iavf_request_queues(adapter, qnum);

[Severity: High]
Could returning 0 here (success) instead of -EAGAIN falsely signal the state
machine to proceed?

If it returns 0 instead of -EAGAIN, the initialization state machine falsely
believes parsing completed and advances before the PF can respond. This lea=
ds
to calling netdev_rss_key_fill() with a length of 0, hitting a BUG_ON.

[Severity: Critical]
Does this early return skip essential VSI initialization, causing a NULL po=
inter
dereference later?

By returning early, critical fields like adapter->vsi.back remain uninitial=
ized
(NULL). Once the interface receives packets, a checksum error will crash the
kernel in iavf_rx_csum() when it executes vsi->back->hw_csum_rx_error++.

[Severity: Medium]
Will this unconditionally clear user configuration on every runtime reset?

Because adapter->num_req_queues is reset to 0 at the end of this function:

    adapter->num_req_queues =3D 0;

the initial auto-request condition (!num_req_queues) will evaluate to true =
on
the next normal reset. This causes an unexpected auto-request to the PF,
resulting in a double-reset and persistent loss of user queue configuration=
s.

> +	}
> +	/* PF could lower the limit on reset, e.g. when RSS LUT got smaller */
> +	if (adapter->num_active_queues > adapter->vsi_res->num_queue_pairs) {
> +		adapter->flags |=3D IAVF_FLAG_REINIT_MSIX_NEEDED;
> +		adapter->num_req_queues =3D adapter->vsi_res->num_queue_pairs;
> +		iavf_schedule_reset(adapter, IAVF_FLAG_RESET_NEEDED);
> +
> +		return -EAGAIN;
> +	}
>  	adapter->num_req_queues =3D 0;
>  	adapter->vsi.id =3D adapter->vsi_res->vsi_id;

[ ... ]

> @@ -2494,13 +2518,40 @@ int iavf_parse_vf_resource_msg(struct iavf_adapte=
r *adapter)
>  	vsi->netdev =3D adapter->netdev;
>  	vsi->qs_handle =3D adapter->vsi_res->qset_handle;
>  	if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
> -		adapter->rss_key_size =3D adapter->vf_res->rss_key_size;
> -		adapter->rss_lut_size =3D adapter->rss_lut_size;
> +		if ((adapter->rss_key &&
> +		     adapter->rss_key_size !=3D adapter->vf_res->rss_key_size) ||
> +		    (adapter->rss_lut &&
> +		     adapter->rss_lut_size !=3D adapter->vf_res->rss_lut_size)) {
> +			reconfig_rss =3D true;
> +		} else {
> +			adapter->rss_key_size =3D adapter->vf_res->rss_key_size;
> +			adapter->rss_lut_size =3D adapter->vf_res->rss_lut_size;
> +		}
>  	} else {
>  		adapter->rss_key_size =3D IAVF_HKEY_ARRAY_SIZE;
>  		adapter->rss_lut_size =3D IAVF_HLUT_ARRAY_SIZE;
>  	}
> =20
> +	if (reconfig_rss) {
> +		u8 *rss_key, *rss_lut;
> +
> +		rss_key =3D kmalloc(adapter->vf_res->rss_key_size, GFP_KERNEL);
> +		rss_lut =3D kmalloc(adapter->vf_res->rss_lut_size, GFP_KERNEL);
> +		if (!rss_lut || !rss_key) {
> +			kfree(rss_key);
> +			kfree(rss_lut);
> +			return -ENOMEM;

[Severity: Medium]
Is it safe to ignore the -ENOMEM return value when this allocation fails?

In iavf_virtchnl_completion(), the caller ignores this return value and bli=
ndly
proceeds to iavf_process_config(). This leaves the driver's RSS state out of
sync with the PF, causing silent misconfigurations.

> +		}

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/ne=
t/ethernet/intel/iavf/iavf_virtchnl.c
> index 3b9545d2c0217..89d95d3b564ce 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -602,6 +793,40 @@ void iavf_map_queues(struct iavf_adapter *adapter)
>  	kfree(vimi);
>  }
> =20
> +/**
> + * iavf_request_queues - request queues via virtchnl
> + * @adapter: adapter structure
> + * @num: number of requested queues
> + *
> + * Return: 0 on success, negative on failure.
> + */
> +int iavf_request_queues(struct iavf_adapter *adapter, int num)
> +{
> +	struct virtchnl_vf_res_request vfres =3D { num };
> +	int err;
> +
> +	if (adapter->current_op !=3D VIRTCHNL_OP_UNKNOWN) {
> +		/* bail because we already have a command pending */
> +		dev_err(&adapter->pdev->dev, "Cannot request queues, command %d pendin=
g\n",
> +			adapter->current_op);
> +		return -EBUSY;
> +	}
> +
> +	adapter->current_op =3D VIRTCHNL_OP_REQUEST_QUEUES;
> +	adapter->flags |=3D IAVF_FLAG_REINIT_ITR_NEEDED;

[Severity: High]
Does this non-atomic read-modify-write operation on adapter->flags race with
lockless contexts?

For example, iavf_tx_timeout() updates this variable from a softirq context:

    adapter->flags |=3D flags;

If iavf_request_queues() executes concurrently, the updates from the watchd=
og
timer could be lost, preventing the device from recovering from a TX hang.

> +	adapter->num_req_queues =3D num;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121433.3034=
7-1-przemyslaw.kitszel@intel.com?part=3D10
