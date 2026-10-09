Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316A9CA601E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 13:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6B5A40919;
	Fri,  9 Oct 2026 13:43:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fFUIzmv_-4X4; Fri,  9 Oct 2026 13:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2F6514088E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791553427;
	b=jfZoEmW4IEZvDA231m9GLKSqCtSdesd8EI4PPqxx7ziCj1YN6lgMQ0Sz4n5k1UGIAJ65
	 Y+8gtpm8xpRhbQfRITIT+Yt1vWv08FaBLNgiBveIBybupNEXKk+IiOIx5xQGOBQhb3UZG
	 yZ1QoFDD8dGAf5dV8ij1KvCtHhnOayHbqhREKpEZo0GjFLYFOB3RngVKzAmRnEpKjdIdd
	 Q1v3sybGdxAwIh5ksaHyqAvtVK9Oal+8VuFV9zacjP4TAiXTPQmJDNjR98UFAQr7ORasW
	 /Y4Ta133gXJgJjhSa2t0RyoTeURPa4nhDFK7oEEA7yrDnb1H/NkHM6fbJmMvC/wm7VQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791553427;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
	b=KsSCaJ/xoBxBwJcMyPyxKSDPXCNsyIwtE44/9quoL7LIiJd9GwwgAeL2XDukDitt3PlY
	 KECqkJHNCMWS8FUgqyED4k59XPXvVTyCqmpUWKj7zjGKuJbsWnHccy51cTwIfDL7TRED6
	 io9YjdRYFjHrzHBQ359XBXxt4QAvBPwXL2FlxXDbFo957gvWJfwyq4uU+vHTVwEFcIkL0
	 v7PCDO6NH2JTSfKEy7VExNYtT+94r5y/qbDhjWdrAKWgHgeHAMEnzaNjtKE7L+qRpmxDn
	 3D7SeH83RW000WNN1TkMRk7xbx7RHUqj8mLUFRTksnIT385SpHPRQT5SGgo/7mGN4sw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791553427;
	bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrPiXmkE72cH25RRvc4CtyWpoRz+kmJlrbrYmHl9KqeOSMIFBNc1/eD8uk3T0e0gv
	 EuIhdPRImb+RKxSFWNeAjAmqQXcuzoPUa22tng3lB+SICP+Z9AYDwuAmh2DgDhyKqW
	 EknX6d5tMNzcLHvLkqkmeZ6X0lgpSDI82hJi4w22wUZ5JWyfbNUhS9OuleJz/iDcb+
	 1XEAW5Ij5ZEvZYxCP2KdaPJ7vyOk/YfDZveopdPY5PqiVYeTbvn41X6PsZGouWhRCK
	 L9PsdfrhQcEQBtIXk/mBArQDllcwtMsIef4P43DMU6+w0+2nLRnZfYyzuc6xn9FJZg
	 zG1n5KBVMAXzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F6514088E;
	Fri,  9 Oct 2026 13:43:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 36414422
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 336B6400F9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIzt3ERXoGaT for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 13:43:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6D63140061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791553424;
 b=F28cUmeEcx9RxSvO3dtrWyxGS57D1ZyE7u/K4VYBMWk0i9irz/envcU6+o5OvSQVsLq/
 6nkl4IGaN50lFpjNPDPUg6jOM0W8kFMaX/95IftmKPsWzHpCbiK9Lv1Nb9erGrCwjCkd1
 hz5M9HWOY5GTxUvEhh16yB6S2beu8iIiC7br8Qh2NAt+8GmzTeofVzkbxonJ5jMiCaVCo
 e1hO8uGvp9pbCG61fu5TpUUV+2uc19pWhfcUqatrbhVTn94fDiamqY1VFegPUfdEyJzHg
 EnkrF8rVFtgTBfHRkfapoAtpvFsRrUjZjd1eY8VdirbFdmefSQ1nUWcjg5U66ZJRSAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791553424;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
 b=o86mgEliaxntSM8Dz9fToaTIWs/PfDCk1MHJizmZ6U6kdSB122sKovoAU6rbvzDwOWJY
 702G70czcrgsQ+o+xBPFhJKMK1x26Oh+Ih5tD2Vin/TGJ1gbYPaCQrQbp6cP0p2Sj/5YL
 T17Cf5LpZs94dOJWr5EdQjN3RsIq56YvY1uc3ryv1ax0o7KmpFzYZrFX02c1ILtVCZfvp
 scqlGQLk7NY83HYoRotX5kYo9Nj1AUbmIYJiY6tGqv+MtdbHib7Qlf6TDz9CIwmTHa+xk
 HGBQIvMgIjFt9Pshu+coxXcfFfvohqevIyIj+kY9i3q0nvxgQzwoJPVRhqMSXnfbBGw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=toxicpanda.com;
 dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256
 header.s=google header.b=HyNa7aph; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com;
 envelope-from=josef@toxicpanda.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=toxicpanda.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com
 header.a=rsa-sha256 header.s=google header.b=HyNa7aph
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D63140061
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 13:43:43 +0000 (UTC)
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so680669eec.1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 09 Oct 2026 06:43:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791553423; cv=none;
 d=google.com; s=arc-20260327;
 b=lbXLKIPYyxV29Yb4btlCBUmxStUC8n0Q7RJ5Rp4QmVVJ9Bq/K4fN2Ccxvqlv6vKKlD
 Tjn1ZI3rG/K79ll5LJJDaFdrK7vo+3FveNHNu3+Y0J9JjJy0gyYvIJrZU9aUtZfZt2vU
 jOOKOka96Rt/4Sab8IOIbon5z5fJTNWA/+GX0fUipJ1VUfG0lrjeFyVn4wLrNXmQRRXa
 x8G/EmeAmfRG4z/eRZUV0UzltlK8xHq/Vc4345VGPGsLfI6oozvJ/kv8fPZDQypH8cKl
 MSxYYdJbsdzH7fECZL6ILlhzxGTz6E8P02/UbnkxVJ70UACqEEJzL+GcX2qqgJdXKRR+
 Y8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
 fh=O6A2RYbKpxKOgHJ0hM+meRTMD0LdmjER7MM8Djn5o2w=;
 b=bruyfxyhWUgR5a7Z7WdCo9icVfIwnt5oGNA2OeR0dMRRCQn38EZ+KpGMORNcyEHP24
 /4nlMti/kzKhtf1IMqdk37TrNAWFs3dB9JtLCpu9IGqpTFPwTtXXZpW4J5tFRE3cL4MI
 8k3RfECR7AnHmxluSkxFPAFSTk3V8avOr7iSPkPDcfxHyioMhnGfcWA/B9mjjozVHkoQ
 RPIQ2LtrGPB3gkdIu5fkG1Gy+YtGTjFN7284n3xb0p8NVDsMuXM2ISFIIM9r5vw11/8A
 fs0NdqglrQURPtUQTQraEAAf5EvFZwApI3qywcswWjm4QO+DU9U8lHf96p9Rda3a/cJu
 BxCA==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toxicpanda.com; s=google; t=1791553423; x=1792158223; darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
 b=HyNa7aphmJF/jGzXJeszOXmJR9OnXpJuZDaegvBUBjb6EOuYqX+UkoWauTWd3c7JRW
 lRuxoPLC4df/olBlsPR26ReNWFMfhXstOIoR3cRR+Mp3iHd+T/N12YDDV91E1AxtCjtB
 c4EutQm9BdOyqCTr5OpmLeIzbCXMVp3x96oryPP/G8zE5ZDhvHa0AxjaRsXmjpISf0Nx
 ppjuC8ICrKs7hJfJMBn/et8rFV1vqvtNqWcyIG0xdEOrclVSNmffPJSLkH1VugFwoJ5P
 6hO1nkWDDyzvKt3s1X+URYIE1AhQbkKZ6gqNZDXMllaaPhEmZS6uw1Hti+3NikUBgpQS
 BkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791553423; x=1792158223;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cr53QXzLPPnzzAYL9+Ow9RuREkmHHvveZLDzlgyx6as=;
 b=IYSUs9v3m0zSldxBMQx8Wf0s0ZIYGvAOUBzv/m45EqmM4rp/hbAVtZS7PmIwJW8V8D
 WDKroreMgCZ8jXQHsmBZD6yy/IpbMurKmBXIB2YSCjnlS4azVn/2b3UNLkL0Ja8BbSM2
 Gi5MDg6E4uAx2K5K3k2YlxSVCPwxNA7Ty2f+S9lzL6F53sLrve4RIN6SPU96aGyJjjpw
 G+NqndVyst2rEJVB1xmPBGhlHbxZYXAlHiTJLqt3sNFbiPg0MnzUfMUrQkkQyhnzRCQm
 QccoshM31rt33iAs1BRWuDQPFEaz+6xU9w9Dxtqtu+oD6G9NG5Il9e/avFpyXgtFzhjd
 fP7g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFtsv0C56BRb+IabccbIlc4bhUPSR+nxIgp+s86YjkFpkSjBnLIluLLU4oMx3n+H+P37oH8zyUjGMfgoWYzrs=@lists.osuosl.org
X-Gm-Message-State: AFuF++nEP/uJg8qKr5jSN58tQPhxc7XmrHZ6W0rnBNNmbAqxt38CDInd
 ol75PXyzWqAEf5wUY1sy0CVZs2DRaszsj204uGHe0sNL0aK2ngELY7yqw4v4kjSDR8WsmWLMm6w
 T/3BE/mxdf61Mvyf2XUNbAxJYSbZ32vyeNISayElPUg==
X-Gm-Gg: AYBFou1XBfr3Mn4BPSRtsevGF8SklW9XYNkGEskUSPxgOlJV6pJH2ytG/Sh+iVNp3W1
 w5fcqsaxk2lgUd1lxqmUCiFtcA3bppuwKBe03Csv02UgPJ9kVSkjuBv3zNM++mhh23ufGRT2tCV
 Zd3N9xF5xMdtCALzWqbgHGBcCFzTjOR0nzntKr4c5vN6pbJxNiG/sCtKmxDP8SwYgCQ5cJ7qROJ
 n1n+ridKlh1OYJqjkiOQvIbcXV+OQxwPOPVujYx/+HBQTLtwPRxLdVeF3/JI1ElagmPpIVfc2cx
 WajRLkBGzv0SmkIn/S7X9lRaC0yGDyuYY+B3QjNPEY08stvWwkD6FgbQvDAt7DeyqoBrvsilOne
 Jl0/nj76zA1/cjg==
X-Received: by 2002:a05:7301:6e98:b0:33c:e74:4624 with SMTP id
 5a478bee46e88-3537e112919mr2778982eec.27.1791553422908; Fri, 09 Oct 2026
 06:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008141131.0ac356dd@kernel.org>
In-Reply-To: <20261008141131.0ac356dd@kernel.org>
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 9 Oct 2026 09:43:31 -0400
X-Gm-Features: AclHuK9i2kH_QiKyGXflCaQStHSk6ronnlxME5kUtzkQ0rs0GpgdrjH4gnmAJRI
Message-ID: <CAEzrpqfgBrvwy0Q_AX8X1s3ogq3g1U=JmpqHAM8QUmMHAqWPsw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/10] net: stop calling __pskb_pull_tail()
 from drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Manish Chopra <manishc@marvell.com>, 
 Rahul Verma <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com, 
 Shahed Shaikh <shshaikh@marvell.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: intel-wired-lan-bounces@osuosl.org

On Thu, Oct 8, 2026 at 5:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Thu, 08 Oct 2026 21:02:47 +0000 Josef Bacik wrote:
> > v1->v2:
> > - New 1/10: skb_drop_empty_frags(). xen-netfront, netxen and qlcnic
> >   relied on __pskb_pull_tail() releasing zero-length frags even when
> >   there's nothing to pull, which pskb_may_pull() doesn't do (Sashiko).
> > - xen-netfront, netxen, qlcnic: call skb_drop_empty_frags() after
> >   pskb_may_pull().
> > - skb_drop_empty_frags() checked with a boot-time test under KASAN and
> >   kmemleak, on cloned and uncloned skbs.
>
> Please keep in mind that we ask people to limit themselves to 15
> outstanding patches per tree. You have 18 right now.
> (200 active netdev contributors + an LLM) x 20 patches =3D=3D insanity :/

Eesh sorry Jakub, the skbuff BUG_ON() removal series is the more
important one, this series is the followup so I can finish that work.
By outstanding do you mean per-merge window or once I get
notifications for things being merged I'm good to send the next batch?
 Thanks,

Josef
