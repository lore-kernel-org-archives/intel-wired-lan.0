Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55525CA5FE6
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:54:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F7D240F44;
	Sat,  3 Oct 2026 09:54:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AmC2A05WmCpT; Sat,  3 Oct 2026 09:54:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6EE4240F47
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021248;
	b=AxJEXqm3Oh4/O0xsx/f+B7tS37JQyTnEcE7WmiYnd0FU7usgsqwSxRv1HkNxvi5p3e8f
	 fHqP+EAPadIvX4CUiViUcLB9E8zYl+rmcpwMZakQY6G071k2AzXWDM9pPvrO+Xy7Mcpca
	 MCfTGgnvr5tue/M8EMVYP9JMcNKcr9BgptmzbF1ShpYrYvDzvhpJ+wLi6kmVy7IsTC9H7
	 lO6Q9/j5cs47XQrW8WN9f2p/rL6Se+TmrMg69LmN3HWmVPYth9CScPpqajMpGF9imZzkJ
	 +133rIA8jiMhcuvEpq8nNYH5Q458aVfUP72npYnZxuVvDE/WEh+ri0ph1QCyrEwwV4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021248;
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
	bh=7XCvElq0w4wrnV3KAX4/n12COPeH+q0jHKHuyXoXmrU=;
	b=bVtsHtki+b8eMfX7XVv5CmEEgKzZE0uz24szDvoj+xX/sKmj4wutLy/XCEgHnm+/jxMH
	 qUsSiwLwiFmMFvP0i/G8/1zEoEn8p59CEL+XyIilEpx0EyMp+rfdGsGuWmsmbxhv8HVcw
	 RiGPGhq7zxN6i2s34jd78/qteqipDtDV4Hq+jw9iF0T2pkD1wDviEs8DXT3wMXKqcRuhu
	 ehLZ/rh49O5xQiAX3FGI7KThDPn6nnzawHkR7/YLbfycS2rZ9ae8fF4oiIwzbZBeirt3b
	 Xo61VNvaABJyzEpC+gUsEgp7Ot0slxxf29+lzBJFomzfPFjuYiFua1jeO2Rf4pCb9xQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021248;
	bh=7XCvElq0w4wrnV3KAX4/n12COPeH+q0jHKHuyXoXmrU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WKoASsY5LnE72ng8I9sbxTllEV3VZ2K0mVC/HUG+dwJM/6O7oOLKQA4YE4wktcRpl
	 HIsSKNgwJLtGsTuLR3oUoO8YJrc8qLlbHf+KVZqH1PRc4/6hmreeb5PC9B9zXt00AR
	 USKQfHQ6CfYfAeLt04rMdGi0hwBbykP9DryL5iN0QnlrLmSeFbV6I8d1fhXUBfnH7B
	 7j1jbY/qNXjMr+RIqHoTDTq4iVeq4SxCJfxd3YFCDUspRAKSCW6wOTwxWh2nlAFAKd
	 qlcbzONcXwIt+swbqPLURXToGOWCyYI2Dp8pIWljADo6p04ljOr01nEDwqmZEekFns
	 9ISupItSf2RYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6EE4240F47;
	Sat,  3 Oct 2026 09:54:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 069E2263
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E13766064E
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:54:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bbL-25GV8w11 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:54:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86EA160621
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021244;
 b=FNPBBgccyOVFEa90qsMPdGX1Tn6d9JDjF2CYGU7rsSwpsPbPVX88eXjs9tFoKc/VbEPm
 wjVNXRfdEHLG5XN1TDGb2rqAtnA+P929fYT/Oe3Uj9dFt4z/EbEfZ6RZ4Vev25SVpEY2n
 wpRPL25xd47ulx8eoBHmAdsBFCWAve8dY3+LYk6dzL08dIJ2dNilGxHn4IbZgwJIdjYUG
 X69Rb8z+anUrEifOKvQzG8GAnV2WKq3GFai3kK4KoXRSszwnPvd9we5gbemI5xDRGYebs
 goiWXsMTjsHezVAvI//xNv3ij5Ns7lfL+lSFgpDl/kYc2Qy9/q+lzmcNHrH4rnDG2ZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021244;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
 bh=7XCvElq0w4wrnV3KAX4/n12COPeH+q0jHKHuyXoXmrU=;
 b=O7Tkj4n7pHMGqu/dXiBhQFADf8BGTc3Iyw0d5ZIEdZXBtqHAikfZkeDHuS/4t+0hV/0T
 fo8k6sGIUO4Q9rECGsT4VSNuvj0DV5MYh4tPZmDaRG5pGMJPIUdjO+ZVQk6M0apA4gB5B
 MTIR615mCR+21Jqm8/oF/zOCdPKaYDNbs9zDC3R2S6C6bBfkjuJUge8cYLySKXAyI+rfr
 OtFKOCq4jp+/6NhuTvbqktMmo/8HMsBlPJesxIe+r0lTArz03bFjhiEN0hDDd0hZaCb4I
 TNbLcyMi18hyGdaJBwUKXAXBfV8Iln5QP3X0O8A3vHYpZ4e6mRG3DOvWfrLkGccNiuw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=EARbp0+g; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=EARbp0+g
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86EA160621
 for <intel-wired-lan@osuosl.org>; Sat,  3 Oct 2026 09:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XCvElq0w4wrnV3KAX4/n12COPeH+q0jHKHuyXoXmrU=;
 b=EARbp0+gyJ9Selc0xHpXSCq4hpeq1zG8NukgIC+HsOkvSU0UCK9lEJIlJu+0J6b7m2DrOL
 2rJbrPIYqC9rADXLRv3RYHIO8gigPY83Dt9DpYUbeS/HrjGkZwO2mjayLssHCJTFehAHxy
 LMRIlgW2AIQlE43QPebifRWFb6QueuM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-UqoxnwuVP9uvDUqAX2qSAQ-1; Sat, 03 Oct 2026 05:54:00 -0400
X-MC-Unique: UqoxnwuVP9uvDUqAX2qSAQ-1
X-Mimecast-MFC-AGG-ID: UqoxnwuVP9uvDUqAX2qSAQ_1791021239
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a01eb045feso3883925e9.1
 for <intel-wired-lan@osuosl.org>; Sat, 03 Oct 2026 02:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021239; x=1791626039;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pj3fnkRnguG1XzZ2CAsEmH/UIzLjDfjSPrnu5Kpy4iA=;
 b=cPMxOn2IkRgQpBsJu8nSuFiHm43Q52wAqSHhwVgVBB5TrIBWNUCpVtBHZd+wlonLxe
 Vjcj2OsIxWk0jDsb7Nok44p56gghYCkpYcRtb7J/6oKUED7WUBBbTd28qCguxzH/KTaV
 Xvcaz2VduFNF5pupOIFFwSHCfxURzfBdr5vx2iGmoCWjk01BaRNV4ErEOEO+u262aWD+
 db/Vz1AS+4fzcsYHSaY4uABPtyYJbMeaaqXKr/eWabASp7tsR9JvE5gBhPPxnwL9+QEp
 zjrcVT7RGB4KS7ffUiTX/Z56Hky2cNNM4jin7knY9HTuuGOtZpcgEXZ7hC33on6TKamZ
 NuMw==
X-Gm-Message-State: AFuF++nYyKyuu514HfRZ0D4asps40zWSVczJpet2Pn87aKdimuHyDQXE
 psqmHZpADdOB/xHlfKcp8RMLw0anoVwRU4kuyU4Z9FsEzN3oDduGRe9HZtgjd5otCRtiauO5ue1
 7JU/wDC5E2J+BjNngWQvPlNM3wOQK+J6guQdiKJGXjsAuKYNE0pAYnyR4lBpWaDGLPqBLBxPrpA
 ryNUqmrr9OUgSciXLTZtITmG8Q+rHH1XUKjbWVMqgNz+D1ogEL
X-Gm-Gg: AYBFou3uhGBeUCKtTKgMRnAunfdVWoNYAIwgHUm4g8ow3kmuV9loyb1aCY0AMLLRKva
 10RjdgrqnTJ1ooeJvhNB4gJPrMDc4w9tdYglzGFVwpaTbTienKajEG3tXZN6jRwIQU/1pkgSO+X
 Mk+Tr/hPf+1PvvLQxejXzNb+mWVQQvKqZKFFkH7KOSWmGdHo+5bSdqT1rsCToef+vvK5ylhdwjY
 2kslCMNujsb4dS7S+cj+5ophsdF4eyj+RosL6QH4sPrw5u1+MzusNiW4teJTw7NuOSsRJqdwy0T
 mtrz3wvRew5iLl+zXDW66Y3AqMti1PG8ewSGVB/00luLSahQiMj3eUH2GLcGr3NkDMSMdb83gYf
 +t9/ItyXynTSZckX87RKmp/I2sV2nXlbpwgUwBi4=
X-Received: by 2002:a05:600c:3c98:b0:4a0:37d:9e21 with SMTP id
 5b1f17b1804b1-4a168101d2dmr29369035e9.29.1791021239108; 
 Sat, 03 Oct 2026 02:53:59 -0700 (PDT)
X-Received: by 2002:a05:600c:3c98:b0:4a0:37d:9e21 with SMTP id
 5b1f17b1804b1-4a168101d2dmr29368635e9.29.1791021238635; 
 Sat, 03 Oct 2026 02:53:58 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104d64sm10844602f8f.29.2026.10.03.02.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:53:57 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:53:56 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_02/10=5D_ice=3A_fix_IRQ_fr?=
 =?US-ASCII?Q?eeing_in_ice=5Fvsi=5Freq=5Firq=5Fmsix=28=29_error_path?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-3-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-3-poros@redhat.com>
Message-ID: <5E5BE0F3-4AB6-4DCB-A730-511D626B9189@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NECPYXM9obBuOakprOiUXdj66_Mgw0hWE_ptsyzWNkI_1791021239
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

On October 2, 2026 3:07:44 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>The vectors are requested with the q_vector as dev_id, but the error
>path frees them with &vsi->q_vectors[vector], which is the address of
>the array slot. devm_free_irq() finds no matching devres entry, warns
>and leaves the IRQ requested. The unwind also tries to free vectors that
>the request loop skipped because they have no rings.
>
>Forcing request_irq to fail on the fourth vector during ndo_open gives:
>
>  ice 0000:04:00.2 enp4s0f2np2: MSIX request_irq failed, error: -16
>  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
>
>and the three IRQs stay registered in /proc/interrupts while the
>interface is down.
>
>Pass the q_vector as dev_id and skip the vectors without rings, which
>the request loop never requested.
>
>i40e fixed the same mistake in commit 915470e1b44e ("i40e: fix IRQ
>freeing in i40e_vsi_request_irq_msix error path").
>
>Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ether=
net/intel/ice/ice_main.c
>index f2121e79fca993..d246cde36ae726 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -2582,8 +2582,12 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi=
, char *basename)
>=20
> free_q_irqs:
> =09while (vector--) {
>-=09=09irq_num =3D vsi->q_vectors[vector]->irq.virq;
>-=09=09devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
>+=09=09struct ice_q_vector *q_vector =3D vsi->q_vectors[vector];
>+
>+=09=09if (!q_vector->tx.tx_ring && !q_vector->rx.rx_ring)
>+=09=09=09continue;
>+
>+=09=09devm_free_irq(dev, q_vector->irq.virq, q_vector);
> =09}
> =09return err;
> }

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

