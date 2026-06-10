Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090BDCD8CB2
	for <intel-wired-lan@archiver.kernel.org>; Wed, 10 Jun 2026 15:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AEF6081AF6;
	Wed, 10 Jun 2026 15:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KGsvbIP_b_h; Wed, 10 Jun 2026 15:27:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2FCF881B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781105234;
	bh=Klrgs6S1L7vyN25nRg842jZqnd2p9mAU1kL/Okh4r2g=;
	h=To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=alsZBMne0fIgmnQ5l2kxuaCuLD7LI3lFVx29rh9FCmfyb22tA9iTirfzLLiFeWRTN
	 EfW7LoAfr+kh+cXw95ut6lP48yEN6gpgIYhC1mL4NpmYT/Uli6+WUbIhEn7ilW+s2z
	 9Yw9Am1Ee+qihha0s1gFWJWMiOueoSDk+cW8yojLQo4yesUDaR5gTNkXNQAYhUc5kX
	 1T1vTV8K+SDyQByY1M9UQyyUXKvfKIxSb3Qi1KfZ0zSKquo26xyf9rOme4cL1AwdAe
	 Auht0MzwJ4B/5y8hUxXhKOTLOS6ydFh3/4n2NmmmeaTDTLHsM5mU0baYI4xa1ObloZ
	 0TiAZ9pKUIwww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FCF881B01;
	Wed, 10 Jun 2026 15:27:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7F42D256
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 08:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70B7B4025D
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 08:47:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwS0RoTnTwfg for <intel-wired-lan@lists.osuosl.org>;
 Wed, 10 Jun 2026 08:47:02 +0000 (UTC)
X-Greylist: delayed 599 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 10 Jun 2026 08:47:01 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8114B4024B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8114B4024B
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=manuelebner@mailbox.org; receiver=<UNKNOWN> 
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8114B4024B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 10 Jun 2026 08:47:01 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gZzWZ5yN8z9tr7;
 Wed, 10 Jun 2026 10:31:06 +0200 (CEST)
Message-ID: <c80c7ad9aa48dca8799ed2e76b1628aa7bec92b0.camel@mailbox.org>
To: Markus Elfring <Markus.Elfring@web.de>,
 intel-wired-lan@lists.osuosl.org, 	netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Przemek Kitszel	 <przemyslaw.kitszel@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Wed, 10 Jun 2026 10:30:59 +0200
In-Reply-To: <f0b4e354-9ed7-43f5-8ffe-97019e421c02@web.de>
References: <f0b4e354-9ed7-43f5-8ffe-97019e421c02@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-ID: 9bb7a79ae9e476ce094
X-MBO-RS-META: inxwp8m3dr45e16ycngz46gfm9ofxwch
X-Mailman-Approved-At: Wed, 10 Jun 2026 15:27:12 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1781080266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Klrgs6S1L7vyN25nRg842jZqnd2p9mAU1kL/Okh4r2g=;
 b=lWvP8vUk+/Yq1piLALsm6ZrhFiE/iK7HqSXmQgTgi4Dpy1HU8z/83dIVf8wKs96VjYHyJ3
 SqCHixavV22sESbcCmwqckKzLsEeuYnFJQu2Uz/KSqUnosc7ezrLnKiFDEuVz8uReoRGf+
 w554SrnIpV3EY2HkBwvcEFPFWG1OiJxAip1KqbUGCizfB/5v7vcruIrI+0fMU/POWYR0Ia
 NTB51AUPmn7rUYGaAr+XAhEqOVvXa/YB0VLmD4yCrt0DLT+tcldvs63gdP4SBUJmsv7BEe
 jpt9DsneikbnvYusyCMr+X3lvVb7uy5ENCkH1r2Np/V77g07FXLi6rMvknOj4w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=lWvP8vUk
Subject: Re: [Intel-wired-lan] [PATCH net-next] i40e: Use common error
 handling code in i40e_register_auxiliary_dev()
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
From: Manuel Ebner via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Manuel Ebner <manuelebner@mailbox.org>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 2026-06-10 at 10:20 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 10 Jun 2026 10:02:58 +0200
>=20
> [...]
>=20
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c
> b/drivers/net/ethernet/intel/i40e/i40e_client.c
> index 84a97ca8a6d8..389b8b83afbd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_client.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
> @@ -304,15 +304,15 @@ static int i40e_register_auxiliary_dev(struct i40e_=
info *ldev,
> const char *name)
> =C2=A0	ldev->aux_dev =3D aux_dev;
> =C2=A0
> =C2=A0	ret =3D ida_alloc(&i40e_client_ida, GFP_KERNEL);
> -	if (ret < 0) {
> -		kfree(i40e_aux_dev);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto free_aux_dev;
> +
> =C2=A0	aux_dev->id =3D ret;
> =C2=A0
> =C2=A0	ret =3D auxiliary_device_init(aux_dev);
> =C2=A0	if (ret < 0) {
> =C2=A0		ida_free(&i40e_client_ida, aux_dev->id);
> +free_aux_dev:
> =C2=A0		kfree(i40e_aux_dev);
> =C2=A0		return ret;
why do you do this? There's no functional change, right?
is it just readability?

Thanks
 Manuel
