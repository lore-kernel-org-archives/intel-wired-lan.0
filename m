Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F720CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 47E60410F4;
	Sat,  3 Oct 2026 09:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BYZ-HWbnr_Eh; Sat,  3 Oct 2026 09:55:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9AC1C410F3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021327;
	b=czgmeABZOIT8IrZmR2IKtv5d6bwD3pMmMRcZ0b6ocTyruk3+6FIc9e8hRAgnXxUmgSWR
	 JbkO5f32KhI7TSoLRXxt66QXkXbJkI1Vn4LsL7Ql7+jUN3/oq4wiK6vYzzVgwgXInlNOg
	 BIXP/b5dVhmUVsO6Tt0w/LyRopAhR7cLtp/tPG0fIHdq4UzQSOOv6qzN7IGd0Q5w9lGMw
	 rBXZMyGpJWISb38VEhiJbg5J7MMu4J9BuEjTe1NK3lt0DZGd8VVWy3juBWpimNzGYGy6x
	 VYinU90w2LNG1xw2ScWXXInaIbm3KH/+mDo7QOTc9YilgTJVODs+Bo5hurXighWDM8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021327;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=7zCJ2BJZEPhpvPdn1k8QCEV2zrGPavG5ItcZduMLw/8=;
	b=C7A4wO5yIDhL/eITs6LiAgVOU4p1BC6Jy7ig5swj0VrTKCAvz58mn6gzQDb1RxUNfDYe
	 EgNJ61i1IAkf64dQQmauNFjXJIZlLNaVq22JHaxiANOvZ4MNJx3zYU/rtqcBezYFsFII3
	 U+dh6/0nD3sv4Ic6muKD5SDWx33RZYMCoHljCi/W2s5QizMK6S7Y2YSB0EjY/1Zb3T6ej
	 FRzSiK2Wp0SVjDWM/UG7AGL/gKcgKZJjtGgSBTXDWyMW8Opfn08G9ZhjQkUimVQPpVofk
	 gRpSDcV3M8L/MhmOeW5+ik6nqo4amBelLOmE9OyhzT7QzdZwb2Tl2SLKDpSfpztRpcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021327;
	bh=7zCJ2BJZEPhpvPdn1k8QCEV2zrGPavG5ItcZduMLw/8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqrsKd92G+MI9ghacWq5dQCbMjGdzKGCoaGSdf8z/3JdJhuWao2VCy0zuHDISiHp/
	 kKvGH3ryRtIqP8jABxu1QuNCUsc0kUuXsiy01r1k9UbU5/hTrcjsVdO7l6/Tbu4uiR
	 K2/S8F58iFztmBB6e1X5facuqCN/CN44hEasuNWlG72/y/WYwEePU2G/Ivt0eOOnj6
	 Sj4PbV5G3W/MW+dA1XFjbDQU/wDG2lfDsv09sYXofpjuespDy1sTz/DjcFkYJ9NJ9w
	 13HWtkE18A42pxMqboiSOtxm+1YMIBez1NffXbHj07FekiRAnKV/ZNJ14YiFD98HKr
	 eI98CmVZ1oS9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AC1C410F3;
	Sat,  3 Oct 2026 09:55:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC6AA263
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE4F4400F6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AIfiRXnRbSkT for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:55:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EBE4B40059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021326;
 b=iXGXaIskENAW4dinLEAELqFPEoR3uhf8iiQ88B1uZ00UO2U6QW3F3H1Fml0gtSoIwTRZ
 deWIJEHeMD4UX8HrXqM6vmjSNhkRrZDCu9MteTkTWlGLqXQxSAoPUtYA8A1+M+mPDH0HW
 pnjgL2PMR8Rsm/ZxRdbjk4kJm4a9jFJypRdfP/R0eCLJIskRV5LGv/tR4PiQzVmmWmF3x
 01FxDsKQX58tl0QxOi1lZs+BZVUHpGZWTXZ1VpVhDC66QLh5atx6CX1U1c4+aJKjw49UW
 t7vNzochK7OciI/3MxUrqZZsF5AfEwTZi5UYuygCFaEfnzCQ85wohqBjFU0fYavRv2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021326;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=7zCJ2BJZEPhpvPdn1k8QCEV2zrGPavG5ItcZduMLw/8=;
 b=GcvlCm/ex/IZiALZTe2vYPVsNw+mC767XNqUhpPPbLWSNn1iX2dZznN3NqxbykQaUTyk
 oxUd2stt8aBKm+0BpUOOdxuzVM1V6K2zcX9uUP+tzq4q5FSeD4UYaYMqinFQuSoTumAvx
 AO2Ht/Mh0n2FCK9WGFy4u+Wlg+iWkSSTjLKfi/up8ORL1xXjDS4aFhtWt2TUDWSkutTZo
 lz8y0zOvdj7t43Ic/fJ6R8Y0jrloxqqv0pfNCf79K0y6caV6E6zc9S32Ki4TLRAHEMtUx
 xUGM58WJgHLSFtUSxESNKt5AyBz2cF8P6GnN+Dh2aHMWmeszzoWsFPHRhnpIPRnxMWw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=iC21gA63; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iC21gA63
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id EBE4B40059
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7zCJ2BJZEPhpvPdn1k8QCEV2zrGPavG5ItcZduMLw/8=;
 b=iC21gA63HB9mAANPuAI75kBAxfUVZjgoUpsgQnMLI/MOjQf0jMZeYfo9Om6btMKS2eW576
 Kl7nPwsCZOD0SNa0I99ImlK2oaVnQiNqisqHkqp1HKhAR7RPb9+JqdvU2+PuSrkqMLTzEJ
 p+LsPCp4t7VVGtzoMgvF50xCprv/ef4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-b7zCqUGLME-n43aai-rLEw-1; Sat, 03 Oct 2026 05:55:22 -0400
X-MC-Unique: b7zCqUGLME-n43aai-rLEw-1
X-Mimecast-MFC-AGG-ID: b7zCqUGLME-n43aai-rLEw_1791021322
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so4003595e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021322; x=1791626122;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T2/SsgxfyWuM6rZwWMjamjv6eHU2cXgtGdTv8wJ/i0M=;
 b=l4tHdmVO1NE9c6sr3lMnfv/BlmtwRSKgpUQCCotmMyKMsRgahHod8u3Q4UvGfooAlz
 c+1JEHb6YLc1Gq9qEj9joogBvo7f0StOUCaqXuxfULKgL2mXE2cFavtLKhaJsDKH3g7b
 k+PRmZ8sl5fG5hODJZg+sWtPa1jNrQKLxRhIIVI5nkBdRskdHoBTpvj0LEHoz8K4Zf8X
 3S5AKgfdTFbRT+52oAIIuKJJOd+TUam4G946Oo1VE3MkFNe3opo+uE0RlxZRFgXr3Fwp
 qyYgY4fme3vCc60rWq8t4+rPAwwlubKNS9uK9E4p2JnEsM+tXbhQAHWzYfHw3Lj94xhY
 KpCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBKEG+RwR4aIgkYhmcNVnhxwgBt1aCiS47296KedY87qioyTA2DxFtURhKrKGUCith93C57jQZXFrL/buTqAs=@lists.osuosl.org
X-Gm-Message-State: AFuF++mbMM9DsWSnzwCWw1d5ue60rucXOCsHO2/ik4RYTQ7Xdfhb4qTV
 Tx+esqY2BhWzd8YD9vH/Ym+TmlolcwGP/pPdI2Sv3fLVBcbZPRPK+dwS/un/509cmrmQOzYzCDt
 4n3ctdvuaA6PTjhDFDoocZqbDvL5UpjrZH4K0+VJ1SRmGpErH1jeVe1jZTA1dk8QMgwE0AA4=
X-Gm-Gg: AYBFou1O+w5B3WtHC4Mluh+qBE31TWEWvT3KtL5qocObJXAvNQ0ztVSAAfc0GDv6raA
 mlecaR/A/i+1IFORdkn4QEH5lDmmxZS3ZiYcOZlBM4Hqlxc/UZ5ksItf1DKQJDu82wkKao9AAx9
 dysVN4QVOlAXB7yWpPzwzmuQmRzGGC56o/fSczpWuxdTsi4AWOJ3UXQe6gQb9aC6ueLUdqj16dh
 snH3dYp7rbscCbcg0RsL0c9UW/oZQIi08i/igfti4Zv6Uylx+usPEyFmEsiGRkgAYi/blaB6Urh
 dF8BeuFeN1sSydlM1olhJrJvuF+6Kr/g95mPWN4H1tifVKr0KJtu4+OeNxz/89q6NSQ9rMVCkS0
 h9frIjhmgW+hbFhDoGrDDCzbj3rpz0+ZhFCapYjI=
X-Received: by 2002:a05:600c:858b:b0:4a0:1f9e:5f7d with SMTP id
 5b1f17b1804b1-4a0275430a0mr66345185e9.7.1791021321636; 
 Sat, 03 Oct 2026 02:55:21 -0700 (PDT)
X-Received: by 2002:a05:600c:858b:b0:4a0:1f9e:5f7d with SMTP id
 5b1f17b1804b1-4a0275430a0mr66344995e9.7.1791021321223; 
 Sat, 03 Oct 2026 02:55:21 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104d58sm12126984f8f.28.2026.10.03.02.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:55:20 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:19 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_05/10=5D_ice=3A_report_VF_tx=5F?=
 =?US-ASCII?Q?dropped_with_tx=5Ferrors_instead_of_tx=5Fdiscards?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-6-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-6-poros@redhat.com>
Message-ID: <42067B5C-78B8-4580-BAC9-7E03520EB167@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oxnKQTedtqo62jSzj-GqvnN-zHICvOPQFznOvbD1Hpw_1791021322
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

On October 2, 2026 3:07:47 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>ice_get_vf_stats() fills tx_dropped from eth_stats.tx_discards, which
>ice_update_eth_stats() never updates because the GLV_TDPC register it
>would come from is not implemented in E810 hardware. The Tx drops of a
>VF, such as switch drops on an anti spoof violation, malicious driver
>drops or TTL expiry, are counted by GLV_TEPC into eth_stats.tx_errors
>instead, so the VF always reports zero dropped packets.
>
>With spoof checking on, a VF sending 60 valid frames and 30 frames with
>a forged source MAC shows:
>
>  vf 0 ... spoof checking on, link-state auto, trust off
>    TX: bytes  packets   dropped
>          3600       60        0
>
>Report tx_errors as tx_dropped, the VF stats have no separate error
>field. With the change the same test reports 30 dropped packets.
>
>i40e fixed the same issue in commit 50b2af451597 ("i40e: report VF
>tx_dropped with tx_errors instead of tx_discards").
>
>Fixes: 730fdea40bef ("ice: implement VF stats NDO")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethe=
rnet/intel/ice/ice_sriov.c
>index b21279f0f5f1e1..8faddf8ba0d523 100644
>--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
>+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
>@@ -1640,7 +1640,7 @@ int ice_get_vf_stats(struct net_device *netdev, int =
vf_id,
> =09vf_stats->broadcast  =3D stats->rx_broadcast;
> =09vf_stats->multicast  =3D stats->rx_multicast;
> =09vf_stats->rx_dropped =3D stats->rx_discards;
>-=09vf_stats->tx_dropped =3D stats->tx_discards;
>+=09vf_stats->tx_dropped =3D stats->tx_errors;
>=20
> out_put_vf:
> =09ice_put_vf(vf);

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

