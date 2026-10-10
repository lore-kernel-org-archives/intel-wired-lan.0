Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F0CA9EC3
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 12:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 997D781359;
	Sat, 10 Oct 2026 12:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 40VP1MeOlQHO; Sat, 10 Oct 2026 12:16:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A47918134D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634572;
	b=Z1wULe6eW222CSOs6LHMEntKcQcbit7gEz7+DQCP1QgRCC6jBE/SvxG3rgJcJE0JhsCC
	 w8DtcX28zG5nGEWvEl9SzmEub61uLMCydJQVEsDq5wGR+ndMQwhPFqtgHkDc7O0+P1gHa
	 vLSqw7PdnaU9TNR3C/VIBOqJzbOwWTyuPGvczVEXEIUyxMJT0TxxkJZKU+OmOt86lRJyQ
	 zkVnn3ixLGMOsQKl9M6ZBIHBPEZV+gG/8UXVFVQ2Eh3/g4lUslPEGYOwn5mBcLs20rttK
	 hbicrgHUb3lpyC5i+7Fp9B1fut9F35I89CdfX4hRtWlMN8BNqVRq7xJ28uJWYLXa2YQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634572;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=e7f/Uj4Be9Id0izy9ViML3yrTdcnC6bSv7RttqmM/nI=;
	b=Li4DQaUzcLqzEbI/RJtbUgMRlX/d9MhR3Go1BDGR8OzNI/DTMAFYMVVELs7sG015j4OW
	 yxM57GeU6FnlJopnXAnMxs6AXs0poV1/8FvSCiFQvArTSmMBpj8H1oEkrM/z0D3YeJKkD
	 FNnvkIbbuIMk0qJp8KTu6zllhZEmaWgAtzGm+HSNLVyjyhYIOtlwfrk/WvSAoQQYZcOQe
	 ydv+3xTmik1dFzTAZs/WZLZVTo4PxTdyPK55OhVpBuzcGd7ceRDP3Q+XBYYyJh5DLs63k
	 AV3QNMlHdwiozC1WLJjuskZFZ15cXoY/0Ocp4b6CBIhweQa0g5Jp1g3J1k2+fmXzmQQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791634572;
	bh=e7f/Uj4Be9Id0izy9ViML3yrTdcnC6bSv7RttqmM/nI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=A1sOd3NVOHYDjRig/sKJrRITUjKarWYz/6udAGKX7F0BFBaU7P4+4t/DVFG0efQgU
	 0B675c37wqaTiBE+PH/Dt74o1ssny34trumulU7orKKUKQA3trsLZVlNFlOuv622xC
	 krqG0UbeHKdI/l3jzH4K62WuQJ7797+3vx0QmccB9Ni/BtRrOozR9cUQKy9cyYFoqZ
	 R/g+SxMDCzPHeYVChgVIi3Jp5SSZlO6zQ9kWNHsehQZDkwW/whQOe8K/HX2rEK6o9Y
	 vTKcg9+Y3uTq2OOZoPvyr9J4tTAMAwrvCRUaKbN/ZmGNHEjN+u4907slqAPcPvDFMA
	 tz7lne+BomTSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A47918134D;
	Sat, 10 Oct 2026 12:16:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C34622B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72EE94010A
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKiy3viqlBRX for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6239940116
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634569;
 b=GjSv5ba+cvtybY9mIG03SZdv4eeTgyRIQLNT3DKApAE1EsdcjJ3Fh+PFav7rQ8Sogr8S
 zj+VVVxDu633wbyhhAFXRiL/c8lENf2D4a86X6Mg2x4idop8eQHDQ/mvHVkytMSZ3RYbT
 65zW6OhlHMKRvMS2QHt3u5KinuK4PoBCWJ2drCPHgz3oqkdx9a0lQI+VanyIq+TThrLPf
 pdqwZIJ+3DB7Nh43f7DXfFi/sLziaXGlZJ710A+USCgyqqIhzZsvlVgNbmggzUS9hkWv7
 BRlOG73z/n6ZU22rljWfsqEi0OHR/FTsS2w034IwBXx+t/pIyjFf5uBw6Tj0YOG113g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634569;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=e7f/Uj4Be9Id0izy9ViML3yrTdcnC6bSv7RttqmM/nI=;
 b=Hh7HrgMj7ruBNJzD/ZnWb1zJ51XKA/+BaZUBrnWokqWegfezucX9Cqv7Jyzg1NVTX+CM
 MCf5LsugU6eHq2wFZ2DHa49uW5B8X1Pg0VUY1kwzMru1yVWT0tbjlppEZAN1sx+Z+vweK
 hLlQftImmg14+YFb5NBBiiH90syv1UvRzag1ZAIm6O0pyzlddy0D+ukOiMfuC18yuwn0G
 UZXaOvZoBBHYrdjMGgzhMR0BPn1olSlmpFr8q0mKa9kGcMSybCPhHCmfAnhk75q0Lruh4
 UcyYvYRRBOqbhDwlG4Xtc+GiqQyw7Jrw/ldPvM58Ifu8G0P69sJmxBiM/4VkhXhednw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UZhLTQPS; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UZhLTQPS
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6239940116
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EEEC60202;
 Sat, 10 Oct 2026 12:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BEB1F000FF;
 Sat, 10 Oct 2026 12:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634567;
 bh=e7f/Uj4Be9Id0izy9ViML3yrTdcnC6bSv7RttqmM/nI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UZhLTQPSERfRmtjrwwoiucTuvOLSVGLRDbcYO6Ki/Dz6+npWxoDeUEXl/GNRs2qkC
 r1HdQy7wNpgJQDi5Z6TTyB5qjKhuudK6RDfHhQUE4SaYWe0+QkGLeuLsroInFlSVDi
 nNWdBNYSPkXBMfFybkDQUFKIA+tLxEJ/NAVoSYll4i4RPfwpncwM4c863ptW6gDQ6a
 3tgPe9Jf26cbDLMRciHdJgHheeV/WYYkKM5FOXqJvT2LODcVCfSjyz7R+C0rQJe7P/
 cRyjKYLhqxymPSKHeC7wK6z/t7q4/HHycgSKFJPTcMTI19+d7l9UAyMmXeDNW4P3SJ
 f/Pa+t0hupgdg==
Message-ID: <sashiko-outbox-166503@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 08/14] iavf: temporary rename of
 IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009121433.30347-9-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-9-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:16:06 +0000
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
- [High] net: iavf: missing bounds check on num_vsis causes out-of-bounds w=
rite
--

commit 96fe4c02ff0c0cd29e48e38845a6fbbedd204284
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>

iavf: temporary rename of IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1

Rename IAVF_MAX_REQ_QUEUES to IAVF_MAX_REQ_QUEUES_VCV1, in preparation for
the next patch that will extend the max to 256, using old value of 16 for
the "v1" variant of virtchnl opcodes.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/ne=
t/ethernet/intel/iavf/iavf_virtchnl.c
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> @@ -268,19 +268,19 @@ int iavf_send_vf_ptp_caps_msg(struct iavf_adapter *=
adapter)
>   **/
>  static void iavf_validate_num_queues(struct iavf_adapter *adapter)
>  {
> -	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES) {
> +	if (adapter->vf_res->num_queue_pairs > IAVF_MAX_REQ_QUEUES_VCV1) {
>  		struct virtchnl_vsi_resource *vsi_res;
>  		int i;
> =20
>  		dev_info(&adapter->pdev->dev, "Received %d queues, but can only have a=
 max of %d\n",
>  			 adapter->vf_res->num_queue_pairs,
> -			 IAVF_MAX_REQ_QUEUES);
> +			 IAVF_MAX_REQ_QUEUES_VCV1);
>  		dev_info(&adapter->pdev->dev, "Fixing by reducing queues to %d\n",
> -			 IAVF_MAX_REQ_QUEUES);
> -		adapter->vf_res->num_queue_pairs =3D IAVF_MAX_REQ_QUEUES;
> +			 IAVF_MAX_REQ_QUEUES_VCV1);
> +		adapter->vf_res->num_queue_pairs =3D IAVF_MAX_REQ_QUEUES_VCV1;
>  		for (i =3D 0; i < adapter->vf_res->num_vsis; i++) {
>  			vsi_res =3D &adapter->vf_res->vsi_res[i];
> -			vsi_res->num_queue_pairs =3D IAVF_MAX_REQ_QUEUES;
> +			vsi_res->num_queue_pairs =3D IAVF_MAX_REQ_QUEUES_VCV1;

[Severity: High]
Can a maliciously large num_vsis value from the PF cause an out-of-bounds
write here?

In iavf_get_vf_config(), the message from the PF is copied into
adapter->vf_res without validating num_vsis against the allocation
size:

	memcpy(adapter->vf_res, event.msg_buf, min(event.msg_len, len));

	/* some PFs send more queues than we should have so validate that
	 * we aren't getting too many queues
	 */
	if (!err)
		iavf_validate_num_queues(adapter);

When iavf_validate_num_queues() runs, if the PF sent a num_queue_pairs
value greater than 16, this loop will iterate from 0 up to the unvalidated
adapter->vf_res->num_vsis.

If num_vsis exceeds the allocated size, this assignment writes the value 16
repeatedly into adjacent out-of-bounds heap memory. In confidential computi=
ng
environments, could a malicious PF use this to corrupt the VF kernel memory?

It does not appear that a bounds check is added in subsequent patches in
this series.

>  		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121433.3034=
7-1-przemyslaw.kitszel@intel.com?part=3D8
