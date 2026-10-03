Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502F4CA5FE6
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 215096064E;
	Sat,  3 Oct 2026 09:55:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XfIP4_0YOfG2; Sat,  3 Oct 2026 09:55:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5694A60E65
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021317;
	b=DjxEPLEH5ZVSPGLuJozRbF3s3/5nypGi3ImCcP9woFgJxTyHvNOowxbmPRCZwrdYvYxg
	 e7aLAkj/JMSNbcxL7LJ7LMIoPM7EjkSFP2wHEvcPgUj3YzfC84SmlHQ1MkRzh3U8WUiE6
	 rZ3oL+xO9jhPdpduzSvYV8kGsbl70VFHuwfioXTRFgDeHjIFw+y8RFGe23qlMG5P+JVdI
	 JcqsJcu4D62HwHPPpXTPQJOKRaQYcZ3iB/b4t7rpEE811FGTmnqbpXgqYFPT6hp6Nkj72
	 Ske3Brlgu/Zm4Usjdx0sdijcNIqIY4MewSC5eOt9BCOlaGNQc84Io88Rv6m6C53E1QA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021317;
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
	bh=OGhEDVmSTvrBECmYPPowlZSuhAYSq1lHlrz8IFeYLuQ=;
	b=VRuD1XsajvXiJiPCINxHisBxzqrFI1AWK5tHAgoyKIocDhpf8Fo6Ywr4huLCrzudBgyi
	 OmxcHdO6dH19MoXy1eRklKP9YvHu4IZEPl548PpecyKvcg8n8XToEC1AP+Kpj5xR8PUh3
	 OUOKw3GRijbOEfsT0vE2EISJQlBHI3ZPgg/EbAmMgASCEFQXf9tKsywYsiNueL55Sim6z
	 GqPQFevtvZITB+XQi7zutLgcAw1r3z3F0xe9WMAaLAVBxjSy1tJct/PtJSWLZuZhp0MEp
	 RjU1eXr6hnyMCTyR+xNLbg1dCSoq6OVKZ4A8M6zVDNMNqb4oAK3j9ZdOfXnzR/pUbng==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021317;
	bh=OGhEDVmSTvrBECmYPPowlZSuhAYSq1lHlrz8IFeYLuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wmf/6fkgFyZ/UBLjEknBMAQb69hZ39CnYh65PNKyo3r1+HxrthwKiYGr7399T6rkb
	 90JvuE5ZiCFC3p6d0ZmTAtWGgYR9RDP4Q2wPiPR/NofHXeH1T+AbYYAZ4tz4zCaiiv
	 1jXfINpbxVYXrwxq4knrylDEE/9g51SWqIcq3Chjs7U0W3inxZcP4TJWF4YgwZ+Mq9
	 LqvOkhWnYAlB4tmLCSzrWFga38wHH+icNYXjaCRm0WPj7FjocXphf/J3SGKS3seAb9
	 P93dY3/8IqgFh2hlkMHKeP+osIw7iQqS95s/Z0LGYTAxp0VIdLg6gcH8RQKd0gRsrE
	 JHGD1A53F0adA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5694A60E65;
	Sat,  3 Oct 2026 09:55:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86371263
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6C15E400F6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8bYVQy5b1w20 for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:55:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3F12C40059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021314;
 b=KlfJCgMuWAOPnl8AIHXusKQDKjv5UKzxS7//hEf0XcoQ9Lb62dZbJhwYF8EdipmSFyiY
 kWt41hPH0AyUhNxsFHI6CdxJgdoerufkYmXMXojfoxxV6UCDXBfTsmGUWyZQlVNrv3zb/
 xvUNn8YokLZ5mp9dglVxIGBQv754mTyxgOlnwkVm6eH5lNcC7fEvoj3KaJrqpr4JfzBU0
 xjK9Z7B5q//8EzxvzZuM9R6WwAyB/wQM1uuGtfq7Mhr9Z3yQBRTHHEZInwru2DD2H9gMO
 +O00cdE3PbjQKpb8ys9p9VSxvJCB7NlJCPetY/Es8aNrM1I3ifLn6a5pkmp7xEZcFwQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021314;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=OGhEDVmSTvrBECmYPPowlZSuhAYSq1lHlrz8IFeYLuQ=;
 b=ECboANQ4f6SMFZ4ROimtk9cQWP7IaptWrERbSFhX2trCgmv2V9x51ZjfK7zmL12DBVb/
 JBBCfmeXc/mGyHouTp2HjFf2h9IZv5QHT4RcZF3tfTWqtnQAQu8l83Pqj+3SJSl9p5xp9
 jTEzMmPtgTzNVeG1pg4f2s7oPuNrMWmlnPZhLRRS1UBcWim/KOnGhHszfef9ccOeFjLj7
 dE4Xljs4F9/qBmPoPSZRBe4bwiqEjRKSwNG+bKRuJ9YhTJbba3D8wWFwGiT93teMWudAE
 jckGf6sI14TauWHpxqV65IIdRTDThZO5HFEuZL+S1YcWdv6bjERnONwZw3rkKVdN6oQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Eb0GvKzj; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eb0GvKzj
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F12C40059
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGhEDVmSTvrBECmYPPowlZSuhAYSq1lHlrz8IFeYLuQ=;
 b=Eb0GvKzjF53Gv4DIsC63Df6aEHtmsswNtfs1oB9Q8Yiq4R/j9R2oihG4mnWd0MVDg9S5cT
 Zr8jEAVGxYBUn33OT/lPl19WFD1ovMH4imy3+Ud7BKIYLvdjvqapO9nk/CaLz8xuyqV5m/
 7yR0mi450n8cYWuVSozxC8UG68e1yUo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-ixYnqL_vN4aLwoSw6FRGTA-1; Sat, 03 Oct 2026 05:55:10 -0400
X-MC-Unique: ixYnqL_vN4aLwoSw6FRGTA-1
X-Mimecast-MFC-AGG-ID: ixYnqL_vN4aLwoSw6FRGTA_1791021310
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a168a8209fso3039955e9.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021310; x=1791626110;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tQ8GTJMyG/70amiU9TQuHecr5ANRYYJaxoKqzMbMzN0=;
 b=AyGw2eptU/9B6XnQvHg3hMuNs/hiJf4HiyQxEA5/4ik3Tuak9cSNX6sMbajrPmmDx1
 uToZOEOfbm9i7gmknG3o/zVz4BPTJWdHjBc+Vxc8MSY+tMfyaQsOv2ZEzWc+94K2Zlye
 Yav2++Qh6+R+GUCLFFUOOXedqPG0xXC6bHRDmk4gzG6bmUulCFogaAWRQY/IgrbKBq7Y
 SQGiDP2KuTtadwGklwFcg3Y3AqZ/viUMCWiVVL5tuBMkqgTbqy3319X5EVuRJvbvq23C
 hAt2zj0unm388pmVDfXFey45G2EBVjcdJ4WE/cpONt5INSBmRZC82ncrYe6By/37mEbI
 bq+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWq17eZfvgbz9rjBZux7EAPYauxSKiaQcqhz3zRr1rMvGk1MdMHPL9q8AIGGxHPY1MvoA1NuNh5NjnS8x18Qk=@lists.osuosl.org
X-Gm-Message-State: AFuF++lOTYNnbng/0HWfjBE7Pnk1lhG1yY2iJWINyeqAHR4lVUDiT1lr
 IHsev2yaZId6KO05c88edRTP7I9RkmEkGpsj0nyzXVP6G+RFCcPCYqq/880saPPSnQbIqDxuLr9
 QLVscahtuuZ515epQKC0yXtWISYLZR6BC17r5gHqZpZm2IvhBAkh+XCphQNgM/oPSX9O1v60=
X-Gm-Gg: AYBFou1jYl1ZZcJXo6zr3k3evv3NyA/lfWS8VCxZ0CT39fU9MkRXrIXdbHLzh0Tlsbn
 xEspQK/fh50eC0pW8IYGDHL/qxgJ91/pElgD3iy7JTjs0GWYFZcW3niE+bGv6SSRkt90lrrTiaS
 Of8Z529InoYFAS1MXHYwQavznXK+JFvZC8jssE4Zdka/T3E5zii+I0Mta7WVGV5kIQBrMcgMljK
 XiE4wxdtZy/s0XicOiTiKm8jYC3WsNu1ZVnoNIaYqQaJE+pm8OrxalZI9X2Xqmivuo/39SqkaxS
 m60i5T1Ep63CXjnXViS/EmQu155cH86PWDuifrQFEyrgeLoOgDso7CCmhwdjIcyJh4UjmYFjjtc
 yhioUbP4055Sn86Ho/gizZmB2OQ8bXvTc9VwlMGw=
X-Received: by 2002:a05:600c:354a:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a027447475mr93187475e9.0.1791021309723; 
 Sat, 03 Oct 2026 02:55:09 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a027447475mr93187105e9.0.1791021309284; 
 Sat, 03 Oct 2026 02:55:09 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0280be5dfsm173800425e9.7.2026.10.03.02.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:55:08 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:06 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_04/10=5D_ice=3A_restore_th?=
 =?US-ASCII?Q?e_default_XPS_map_after_a_netdev_TC_change?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-5-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-5-poros@redhat.com>
Message-ID: <83677D09-EC66-48A1-94CA-6DE008FE1AE5@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0BWUzul9yicNY4qQibul285-9W1l7eSEzXn9hIefo_c_1791021310
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

On October 2, 2026 3:07:46 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>ice_cfg_xps_tx_ring() programs the default XPS map only once per ring,
>guarded by ICE_TX_XPS_INIT_DONE. netdev_reset_tc() and
>netdev_set_num_tc() drop all XPS maps of the device, but the bit is never
>cleared, so the default map is not programmed again.
>
>Since commit 122045ca7704 ("ice: config netdev tc before setting queues
>number") ice_vsi_open() calls ice_vsi_cfg_netdev_tc() after the Tx
>queues have been configured, so the map is wiped right after it was
>written on every open and stays empty:
>
>  # cat /sys/class/net/enp4s0f0np0/queues/tx-*/xps_cpus
>  0000
>  0000
>  ...
>
>A DCB reconfiguration ends the same way through ice_vsi_cfg_tc().
>
>Clear ICE_TX_XPS_INIT_DONE in ice_vsi_cfg_netdev_tc(), which resets the
>netdev TC state, and configure the netdev TCs in ice_vsi_open() before
>the Tx queues so the default map is applied after the reset, not before
>it.
>
>i40e fixed the same stale bit in commit 82e0572b2302 ("i40e: Fix not
>setting default xps_cpus after reset").
>
>Fixes: 122045ca7704 ("ice: config netdev tc before setting queues number")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++++
> drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
> 2 files changed, 9 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethern=
et/intel/ice/ice_lib.c
>index 5e183314e0d792..416e2d6a6f1709 100644
>--- a/drivers/net/ethernet/intel/ice/ice_lib.c
>+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>@@ -3218,6 +3218,12 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 =
ena_tc)
> =09if (vsi->type =3D=3D ICE_VSI_CHNL)
> =09=09return;
>=20
>+=09if (vsi->tx_rings)
>+=09=09ice_for_each_txq(vsi, i)
>+=09=09=09if (vsi->tx_rings[i])
>+=09=09=09=09clear_bit(ICE_TX_XPS_INIT_DONE,
>+=09=09=09=09=09  vsi->tx_rings[i]->xps_state);
>+
> =09if (!ena_tc) {
> =09=09netdev_reset_tc(netdev);
> =09=09return;
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ether=
net/intel/ice/ice_main.c
>index e62a8f544345a3..8a21f87eb6ca21 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -7559,6 +7559,9 @@ int ice_vsi_open(struct ice_vsi *vsi)
> =09if (err)
> =09=09goto err_setup_rx;
>=20
>+=09if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
>+=09=09ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
>+
> =09err =3D ice_vsi_cfg_lan(vsi);
> =09if (err)
> =09=09goto err_stop_tx;
>@@ -7569,9 +7572,6 @@ int ice_vsi_open(struct ice_vsi *vsi)
> =09if (err)
> =09=09goto err_stop_tx;
>=20
>-=09if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
>-=09=09ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
>-
> =09if (vsi->type =3D=3D ICE_VSI_PF || vsi->type =3D=3D ICE_VSI_SF) {
> =09=09/* Notify the stack of the actual queue counts. */
> =09=09err =3D netif_set_real_num_tx_queues(vsi->netdev, vsi->num_txq);

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

