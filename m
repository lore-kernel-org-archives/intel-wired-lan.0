Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59A4CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:54:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8590A60E65;
	Sat,  3 Oct 2026 09:54:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dJ7Xlar57N1h; Sat,  3 Oct 2026 09:54:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D04C460E67
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021297;
	b=sdEwuP55lJNWTcNSRdh7NU1gC4z81o6U94fBYaP8rx7vKQwpwm1aoDZvbWcQNiVzSDhZ
	 50KqwGGoixqxll8AjB0E0TC4Quk5GTlENGJGo3UMW6lCv8sOlPgRuICFYduxc4cG/8NSC
	 JhwEdCHHQJxNfJAtPHG60VMMYUXpNfpO2QVhInzn0Jr2ajGib0+fqER5B6Lr0CRQqzTDY
	 nbC5HOSChiZ/EVsxdUw7vTEsUaCU8/VnZL3BaFIQRQYZweYALHrCTOmGR2sy6OxDCdo/i
	 e/qZmNCfTy2L03zQpxRFhRNir/EulZj9ajKrV4d/QkpThmamFeU1Gz9zcI12jNtTG+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
	 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=5mXIRx1KZlrtwkDpVfcc98uvDcSXiaOAseUIZdT+GIM=;
	b=P9KwIT/jhVmGJOZ87AfyuN9Ujdy3kbZRAnO3ViZukScjJCF2vXTqdmtbCHTUXIDULgj4
	 IE1OcAnYXEwUdew4sijFSvao3VvjAsFNxkiL9evAVTTmPxmtzt8FA7h3omUJ8NgHxLhyW
	 UURbtcw+mHbpWxKy9OrrCTNrCoYmwj25l3QiNhIRnz55oI4iPzH8JUuS4RebhujgKyQ7l
	 ZrsgnLqghNUDag17pSRW/P2c5sQ6KQKObEEt5eK7tRc93VHwjzUNPFuWJIjYFmChpNLHt
	 XheBQIqTtkt9ArOJCBF4ur1TDV1NI9/zfTxTQzh78kc2rfkgTc+lheJMBfL9XomkK7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EG0D1lef;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021297;
	bh=5mXIRx1KZlrtwkDpVfcc98uvDcSXiaOAseUIZdT+GIM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B1ol/P2oI7hqZKSYm2Z87gNvuzH7/uhNYPh0xE5UBo1ujupqB1lUEKQhM3Y+iJls2
	 avcdPrW0YEhq+bmpcxPSotUeJRuUB7ZnCAQ+tLXWomSlqbe9knV6qBngE/T7ixhhlE
	 7vu+2OxcGIslnvZ/s9+qD+E2A2gT6bw3S23rRI0S2VLRbg99IcHyIc302NPUXTZzxR
	 jIpMW3t4d+heSsswVbmc5kwRkvu23ORrS0xl/My753q9SofGnVY8El4b7ikpGQJRwg
	 nC5zu/nMdjqr2HyRjxBQ/u1ycOHfaBYUs0R3AgxRB8r0jYujBSz/W/n5sEe7e8iN7X
	 k9WIz+NXQ4RKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D04C460E67;
	Sat,  3 Oct 2026 09:54:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D45179
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4ACC560E65
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BogasLzNSRIQ for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:54:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 93A306064E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021295;
 b=kGB399vbkr6MSXnYA6bjc6sIp5OmUqakDoHyCwPEq6xdgY4ZSZKbRC55CEFtvBgOqz3X
 5R+DmV36B4UTiEtoDwECD8L+nxf7z4m8qlnnw1jfmye/ASk2CnHI9hBxjBeUSk0M34kCE
 VyG83ePhK9ok0R7KBVKy+vX1NGNo7UIPG2G0ylwJxS2tvGwnUNPk9BRbQn9tKLFfHfvbb
 FA+CUJaXWoZvWJAdscjGcuTbG6xiLfZk5W7fQq/tJrreAHwZP6HEI2SJf+gl2lTVJ9QKN
 23RGA+G83Ovtma9ddG0BwXEWlGLTUUoKK23ipz2pgR/d5YWsil7iExeqfh+Vi4ltLIQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021295;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
 bh=5mXIRx1KZlrtwkDpVfcc98uvDcSXiaOAseUIZdT+GIM=;
 b=KbSI0YptnDHtDHYvnu1bw/dVTXljBo3O+R5rLUM+ghJsMgHOdoy3KnuU4Xj7JD7O9B1q
 JcScIkiJZN8ODSnDSLSOLhxPRjFYIsKyioEv/vCQMS0kFPRpl/TemSg1cx+9GU01USnDP
 QY0r5lh6QuCtPGFzFkk2D3hdM6Xc/oGrwKJd/WG0Nh0+L69ym3oguzlsAxazVZT+jyhPe
 qBYN8YxesX9vEUCWv3JTjkzg1cgrZ3iQUed1IZzioKMaCZWVytAqa+tkKZJAB/BdvqL9F
 pGIvq4s1RPVPReYyYrjReDnnCc7ORLuLqdL5Ztelm+CYbsDYUHcxXxwBA4d5jaNCt4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=EG0D1lef; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EG0D1lef
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 93A306064E
 for <intel-wired-lan@osuosl.org>; Sat,  3 Oct 2026 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mXIRx1KZlrtwkDpVfcc98uvDcSXiaOAseUIZdT+GIM=;
 b=EG0D1lefuXcxMZr43V+x2gIoUy+X3bJDDQfFCdEob8yL56zRcH7dpP+jMt69JbNtKrjukq
 MB/Ea6/+NKODunmbaPuEhCuQtvHp8Ck1+Jao/kOOkKiw8uhIar9/A48KLRldZTVV54Zmqx
 DOtQFKXVXxkOih4IGEpSNveJnwI6FPI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-HugoGVnQOIuHKIv0iqf9nQ-1; Sat, 03 Oct 2026 05:54:52 -0400
X-MC-Unique: HugoGVnQOIuHKIv0iqf9nQ-1
X-Mimecast-MFC-AGG-ID: HugoGVnQOIuHKIv0iqf9nQ_1791021291
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48aef5cfe43so136437f8f.1
 for <intel-wired-lan@osuosl.org>; Sat, 03 Oct 2026 02:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021291; x=1791626091;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ikxWZJeYQ1V1AF6NYmjgqyaYfUGSJz9U1lEa1NQkyHg=;
 b=uf5AX1FLFuIe0MSJsJ1j/YHZtOtqmj91WdeF/e5TIiTWi99IVmz/40NOYKL0CUAv4O
 6Obq3dXXqYRJ2biv96VJr0+Tvr2WKVWx5p4jNpw1icbJ0l6HDAO9BRd0es1yZ7omofzW
 XzNf8hWBn74o3L4QDoe3+4HcTcRcQmpUd5Dk8iLKXvo3kEz0vfEbLiELg8sOJsqQjE0i
 zv635qoBZ1/UYx3QGJxHspIvdOk5mpyZTAY0nzX6Vj2RXJmPncr7Xbwv9U6goqT2n2Zz
 1MEXU7tNVn0OtQey/g+bFHJN3vQ5j2LrsM+eDqYeyWpLrpqaepNK3Dzi6RblVUkYVcSd
 q62g==
X-Gm-Message-State: AFq9FYKfmVxO5zaXFZvWmSjNQ1suEinSG0HQwr1FLyZN349ebsC6lVp3
 yiY2fZw5YOPcIhoHydvaMQqQSz6GX292up0lYzIE4eqLyMCRf0isDi6H5J3mF6hVX2Kfk6PerlH
 WPsEbgsjwIo3UG61PexKoE/RoH2EG27Nli3nEP3ZlZqtyQ+O6SI/IAd4FcN3G+le18EV1VzrIQv
 tTRkWmbZcNz2i40AB+cfXCVaRFcH4e3PKdm3KbEdzxOri9W3eY
X-Gm-Gg: AYBFou27/Hpr/xEZk2gvWdsYR6cqv/AC6fMoAxEk/rXBVFt3XCN3oEA1PUFmhSVawBb
 FonPte0TtdErX7YsWICBoaXXEsY0uXyRUGoq+FY9slJF86BUzcMpfwPk4qAIfrgy3T6pI+p5NJh
 BzLuJ9NoRUZMyQ2fcJZQBGF6MlmXvoRoMDPBF5J+zhIFjdiTBNaeA01Fk91F8rz4trrA4B4QFJ4
 SHXTzhPnoNrW+2cjc42AZxbIuh+tiFkT+VlvoarNaaqvWAvzBQNxGylW/GvQ+svIvpdk/4JaTiN
 mCudDgk3u4NF8oOg3YpBqbbZSbl0/97l67x397355KCwDBrzVj7gLer7KR4u17RDDVFzxynJmt3
 hXpBRK2xTcFfuCvsrNo5u3TKwZgxui3OmIOkAXdM=
X-Received: by 2002:a05:6000:4553:b0:48b:610:df98 with SMTP id
 ffacd0b85a97d-48b1276366bmr5185022f8f.40.1791021291410; 
 Sat, 03 Oct 2026 02:54:51 -0700 (PDT)
X-Received: by 2002:a05:6000:4553:b0:48b:610:df98 with SMTP id
 ffacd0b85a97d-48b1276366bmr5184980f8f.40.1791021290914; 
 Sat, 03 Oct 2026 02:54:50 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104d58sm12123904f8f.28.2026.10.03.02.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:54:50 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:54:48 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_03/10=5D_ice=3A_stop_the?=
 =?US-ASCII?Q?_LAN_Tx_queues_when_ice=5Fvsi=5Fopen=28=29_fails?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-4-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-4-poros@redhat.com>
Message-ID: <1465AD22-8132-4286-A2AF-ED94E64E12C8@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kGTgbRptImahxXjLIibSIwaH6ew95FcxlG8JoIEQIDw_1791021291
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
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

On October 2, 2026 3:07:45 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and
>enables them in hardware. If anything after it fails in ice_vsi_open(),
>for example requesting the MSI-X vectors, the error path only frees the
>ring memory and leaves the queues configured. Every following open then
>fails to add the same queues again and the netdev can not be brought up
>until the driver is reloaded:
>
>  ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
>  ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x0002
>
>Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
>The ice_up_complete() failure path already does it through ice_down(),
>so let it skip the new step.
>
>There is no i40e counterpart of this fix, i40e does not add its Tx
>queues through the admin queue. It was found while verifying the
>previous patch. With the IRQ unwind fixed the warnings were gone, but
>the netdev still could not be opened again after the forced
>request_irq failure.
>
>Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
>Assisted-by: LLM

Which one?

Otherwise...

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ether=
net/intel/ice/ice_main.c
>index d246cde36ae726..e62a8f544345a3 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -7561,13 +7561,13 @@ int ice_vsi_open(struct ice_vsi *vsi)
>=20
> =09err =3D ice_vsi_cfg_lan(vsi);
> =09if (err)
>-=09=09goto err_setup_rx;
>+=09=09goto err_stop_tx;
>=20
> =09snprintf(int_name, sizeof(int_name) - 1, "%s-%s",
> =09=09 dev_driver_string(ice_pf_to_dev(pf)), vsi->netdev->name);
> =09err =3D ice_vsi_req_irq_msix(vsi, int_name);
> =09if (err)
>-=09=09goto err_setup_rx;
>+=09=09goto err_stop_tx;
>=20
> =09if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
> =09=09ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
>@@ -7593,8 +7593,14 @@ int ice_vsi_open(struct ice_vsi *vsi)
>=20
> err_up_complete:
> =09ice_down(vsi);
>+=09ice_vsi_free_irq(vsi);
>+=09goto err_setup_rx;
> err_set_qs:
> =09ice_vsi_free_irq(vsi);
>+err_stop_tx:
>+=09ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
>+=09if (vsi->xdp_rings)
>+=09=09ice_vsi_stop_xdp_tx_rings(vsi);
> err_setup_rx:
> =09ice_vsi_free_rx_rings(vsi);
> err_setup_tx:

