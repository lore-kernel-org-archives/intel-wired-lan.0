Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE3CCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E41E741100;
	Sat,  3 Oct 2026 09:56:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mQEWgvBNwbTA; Sat,  3 Oct 2026 09:56:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 495D4410F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021381;
	b=CpqyXSlsA2jNih2jltXUdICydN6O2SX04gc2JDKhGlQ1MJvCpQG9hJwqKuZYuo8dz9Od
	 oUbGblmHH6NfONv7i7WBod46Ub8xZwzQuKpxjKUxCJ9L15fVS/sEBBjigHHlV3GWZ9c31
	 G3He//NejozlYaG9QOix2+VMtC4ICr0HQTtsgCUV4kJCReLjfqtzal4YOZAXmqLV1Ll48
	 nuIA0xE7K0DAEHu1pBoOJsshuzzafzU5ZHlYnN7m8TYeP7NXflX1HRXEj9UoRFVc2rvaZ
	 O4h/rDeLolIIDktHUz90X57bEVeWUbS0NpqQtxoG0DsY96BvJPtJGVF8OyTYBLLDHFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021381;
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
	bh=CpIHTq88G+Ad44d9NjKegaqZMYgsrsixZ/N6BLqPGYc=;
	b=LcxO3nhAve3hfRkZu7XFK0RrQZhN7YIhUOEYHHTmh6asK2rAyUir1FesYBV9Vr6RqC4Z
	 9GDVVlC8Mrj7ABE2D6KWkSQAh4gzlYkDV0meCUG/ehla/iegqFtPOQndQndAJEvlWdj6M
	 bezAsqS5MULt3a8OyKn0LY2tfN5db3WUmLjqlre8jdnoR7TldZjwGdWni7cJIC1VxvPbm
	 44nzwZWb3X2myFO5q66oGCYVQDhLd9ojn4GUuSjtox1H59/OjEHwiEACMTBndd+gKiwkj
	 bsnX/5iw6NKi7xnH6MBCDuKx6Al5FHK1Ib0bJmb1PDm9BwSNXRUBj30wd8djDCVZAvg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Rr5/Mdy4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021381;
	bh=CpIHTq88G+Ad44d9NjKegaqZMYgsrsixZ/N6BLqPGYc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xPI4OJjrD2jA37oXfwsqvxtMBsaieZophRNgSlBSdOl4OF7JrtiSaZmEmpCBFRiZS
	 63SrnCOcGrYTUNb7vhzylzc2DwVVk2Tqh+yVgq9etWfNZ3QRdhJ2EBHboY1qbISm/k
	 7PAcSWrwxlSHFzWEHguivNDMNFIuxZjNFcGhovBT4Fii12ng/PjpX9qtojDtuLcseg
	 fnDEesdni6FCzZxy3uP0t4bHHIBeaBpW8YlR/Nvi79m+SQGGox9OX0od4wWUBlSi6S
	 aNrxa1pKV0IAvbwiVyLHzgJKmfvUdqH8I1EPIms33v9StusYDU5u0xltRqTj3Q5zmT
	 FlSx5+LlYFVSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 495D4410F7;
	Sat,  3 Oct 2026 09:56:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44D6C179
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36B34410F7
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UsNGhve1La-T for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:56:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 77A28410F1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021379;
 b=XI01WAy4JmTpIPm12fNg7MinGXiTySYIp7CuCOLjPf2R2QF0sVdEsNgl0VDALqMMGyFy
 JPZ94CyHQAdfh64eZ7x7g03+VM79n5pvef/v3NIQ8umf/WigE/qL2ooSNOq5p7LPALZJr
 v3fartc5aqQzGtZbPDRVYjJPRxcbIOaTZcvjd8XrlKTRq+PF0mzedTLiD5CChLTKjeCUX
 KpAHvhNHewBHSWXUjr/YB80KVSP/nmy0CV/bA6GNtMBhcFm8fqZGKab+Ed8VRYpKGxFLM
 uf0l+6aVRouIaUFlHp7uQcDzlJWDzIKqD2OpsPN5PEzt5VcMWi7hGFZhQCq+WDRT/4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021379;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=CpIHTq88G+Ad44d9NjKegaqZMYgsrsixZ/N6BLqPGYc=;
 b=GkDy4ssXwwJyq0sgR+n0D4xXukvz7degHg+hMQP5HFq1BtY1GlxFXvXH8nLVicItGGS4
 v0aOcFjlJSAiuTscHPVj+qUD8LYSzZaOk59P4ywcWujLdQkDLB692rAOtz9hXIrRwDuAf
 GAL781cSPEXzXCnmXhj/inlQcU5XzIV6l5ZH+eFGVJMNVrABErz41ZyV4XW+ryPIXGF4L
 4dkj0R3/9pxG0d32YGAnL6eLpQhesqGJALvo8grZuf6K2vp1zxuwwlSOrwMCYuh7EmdQe
 tCrtdfHxolyY86ZdiA4t6zluI98gq9E5U8Ru0HPC/PVZqMoDJUcIqFBjJql30MV6dHA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="Rr5/Mdy4"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Rr5/Mdy4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A28410F1
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CpIHTq88G+Ad44d9NjKegaqZMYgsrsixZ/N6BLqPGYc=;
 b=Rr5/Mdy4IoEYgOYQ6flbkWoBc9w4qv3GRNyy5boCQsA6VU8VAekNrs8Otr8r2iUDOxV8HF
 P0xhKs50WsIf4zDB0VdQywImwU0wqADpRnnlxjYDJYBUTYtNFgEW7LKdRNantn4tKjZOxQ
 +76eC7cPti9gMTXHLQmWcFYWXvMHy9A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-toZO8N3FNWq4DKR5MvKK4g-1; Sat, 03 Oct 2026 05:56:17 -0400
X-MC-Unique: toZO8N3FNWq4DKR5MvKK4g-1
X-Mimecast-MFC-AGG-ID: toZO8N3FNWq4DKR5MvKK4g_1791021376
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a024bce773so7360875e9.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021376; x=1791626176;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i118fgept/V5HNHIJAC4nRHOFN2iHEPIInJ6/LxCKAc=;
 b=0tPWCLdGz6xU8DVQ+XNCrCAdORNRvsjaq54EhZWr1FRN1RGqKzjQ5fvyhgzFHGPtIG
 Qft/WPwhvr8CFNkrDGCz0aCer20u1nfbIyGSlLEAej/C/Xzg2IF+K1sDtSwgLS6pK61k
 PzyWbACXoD2a/Nxxgiv5tCUx0kiM0mYYJDvEBXgvvQVrMIxMrUbHXD+hImJSrVI4GgPw
 9T7/fWNS5jG7Y5P8U55SARwPoYcFqXsjUW1qMQiwiTyW+BTzjTnR2gQf4Iu+ZOxgyxB9
 JLjyz4+IqWBO2c+oOsToH60mqSwV8CxvTJTKqf+YhR9OjagF2rNnW5yT0uTiSKha172d
 u5Kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJQyZ+jziKiaI2F2HOBt6t+ZlNmyjekGCg/Z8V+pXRbJbn5dE9KmtMkHVAh6bGV7NAWNMefAi46AdlLNz/jXk=@lists.osuosl.org
X-Gm-Message-State: AFuF++mKEsCeXMe2wcSMY8UQdGPeng1X5M+aN8csNwYd4I5448m0QdwR
 0N28gDvnmE6Ibu76G6XHLhj7KJVsY6RIEFBQFKXZLOQGuVyYO9jAd6IPziehqbtEaE0RG4rUzqS
 kkYKnlZ8ClwWwftakk9XA7VP1FQSx1fRwc3Bx3e5pdHnfx5KxTkZzVaCkzwwXjeWA9EnPCF8=
X-Gm-Gg: AYBFou01khaYCsD+mpvUgRffiRhE23NHsYfX8zfqFDWlMobxydlO4r0auvY44ZohTk7
 nPA3PWR713WT15/7iO/eb4BnR4pGcvQpwTKNnPmBU5SDZM4uSFO0QLF631/gSGhAewwyyttfJ2w
 him57F4KiPHlOuqFn8F+hQcRAJlo47OPKlmC8Evo0HvhNh8/EhJRNAYAxMuu9lyqeZAWlPobnfP
 aQMW2joSfCHY2njC7Hu6cgSjBHrNAZyzn5ldj6B5/3u/z+g99OKGRaaabkJhNC355bmCG5jBu1Q
 u0wM/JocRSjvxOpltTI4/IqvEBiasnt2J7GosuvpiJczL09rzEICpZ993b/iZn59vqznk0qTlYn
 JghheH+EzMaxZz5W1pN3Ln0NlIQzwjQsB4yYrfC4=
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id
 5b1f17b1804b1-4a1680b5402mr30627925e9.2.1791021375672; 
 Sat, 03 Oct 2026 02:56:15 -0700 (PDT)
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id
 5b1f17b1804b1-4a1680b5402mr30627735e9.2.1791021375223; 
 Sat, 03 Oct 2026 02:56:15 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0394e6c5asm121786205e9.2.2026.10.03.02.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:56:14 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:56:12 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_09/10=5D_ice=3A_program_multica?=
 =?US-ASCII?Q?st_magic_wake_before_tearing_down_the_main_VSI?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
Message-ID: <5BEDFB6E-4B19-47EA-9CB8-893CCF103D49@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vdhlM9WJChfOzgZT8cWYsfExdwkHgz6mjlWQkl6_31o_1791021376
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

On October 2, 2026 3:07:51 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>Since commit 5b246e533d01 ("ice: split probe into smaller functions")
>ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
>frees pf->vsi. ice_get_main_vsi() then returns NULL and the function
>returns before it sends the Manage MAC Write command, so multicast magic
>packet wake and keeping a locally administered address across the PF
>reset are never set up on shutdown with WoL enabled.
>
>Program it before the netdev and the VSIs are torn down, as it was done
>before that commit, so the current netdev address is used again.
>
>i40e had a similar problem, where the multicast magic wake setup ran
>after the admin queue had already been shut down, and fixed it in
>commit e661414c98df ("i40e: Remove duplicated prepare call in
>i40e_shutdown").
>
>Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ether=
net/intel/ice/ice_main.c
>index ceb9fec2af21e7..a885b3e0baaa5d 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
> =09if (!ice_is_safe_mode(pf))
> =09=09ice_remove_arfs(pf);
>=20
>+=09ice_setup_mc_magic_wake(pf);
>+
> =09devl_lock(priv_to_devlink(pf));
> =09ice_dealloc_all_dynamic_ports(pf);
> =09ice_deinit_devlink(pf);
>@@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
> =09ice_deinit(pf);
> =09ice_vsi_release_all(pf);
>=20
>-=09ice_setup_mc_magic_wake(pf);
> =09ice_set_wake(pf);
>=20
> =09ice_adapter_put(pdev);

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

