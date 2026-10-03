Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56437CA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 23DCF6064E;
	Sat,  3 Oct 2026 09:55:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzylNLNovZC5; Sat,  3 Oct 2026 09:55:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7D3B360E65
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021342;
	b=SLYHA4X/8Oj95LiHVDJGuBObwyTY8HBWXhqUS2DrmRpvbWOXrrwIUCvLu40Bq1fTF5Bk
	 V3HrbokEVd/Sid2pISUqhB3QYpMzezkeHVUnrV9g+jP+yztkRyydCV+VryYQA5ZSZapnQ
	 luKP4zaQmQ177vz+jX8F2NTQVKgjkuxpoV18lAy0wn3JUy0OXFzesxHX1TDq+IIsi63Pf
	 zviojU0rztw5I00/MSk06vMs6ut8eb7ndYmjrdRgVt6DetMUrBZu3XH33wVZ4NgFwaR7K
	 /CH7MO+MG8o4t69jLcW8Jc4POwDCfCRms/ykLu4S1BvfZoWsjXGzSY8yIghVAy17acA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021342;
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
	bh=H0DAH1Min5mqUCcvgHIf/iTJSsGuEtvv7F+joGpmhsw=;
	b=ErbyhUcQYCf9BB+Ug7OSKdeOqZjvHMyucN3bCbyYJT7RSaCYGdVeHAAzSeEu1tGEPEjw
	 h3CD3SD7RqG0ZyCUt9gNmHnZ6y6HOyJ/e284eT0s3rDwFnSn+Dcmdf7OWlUvHeclL1Nqz
	 skV7eunNs5xq5i5/le4+KECIEee2Fb7LONjEbwSj7SU6EjuhFKbll66f1Ej5dbBvaRSyt
	 wH3NHPwnKUshjEaqu1D38MEK0zXSYsIE2Gv6x40CboRNR9UqUYMApJWsA6ZTLELGr8Y5I
	 W2EHN4qF+U3WHESstkI7O52fEtkugfnxz/T+cUZNXVHdKqMAw126qpVf8GtjNrb8oxQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021342;
	bh=H0DAH1Min5mqUCcvgHIf/iTJSsGuEtvv7F+joGpmhsw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vNhIK2ioXs6YXRpvBdbeeP6rfNAsLBj9E1ljiJotxmOWsi9SUen3BmRutn1PNhagL
	 yBqpxPgnjO4b8eMpnNhIHR5LBqK/GQaSy4W/V22etcA2P+ZBEsGiyO3MbWNV4mwXtT
	 QljGLpyXdaI6IFb18jvGhbxx9HlFvhJkzyUL5DHgDjA4hrv1kjVFSaRrwUf+OkgM6R
	 Haou7BMbQPi18OhsHBLdrSkBWW+GVtNB2eCHwx6weEKKvE1tgFQCjhliy8IHSZ6jCC
	 1eGi/YLRxGMhnlPDJf/My5NvPsnp52HI1ZwBhA5kbVA8StEnihz0U7f7/Uq4BRvHWk
	 hqY3vqmDC82pA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D3B360E65;
	Sat,  3 Oct 2026 09:55:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DCA7179
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FF29400F6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SgZShLO1vh8p for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:55:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C4AA140059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021340;
 b=ARTHDX0/BqkvvqvfMIFLx/Now4qW6HDiysF8cujgtQFejgscBXRMG9jCD3rvyVvJ/rHX
 RdhmybazilBdaGvXEKx1+QPUKEafrNaU1Xy1sNn3/eus2a4BU2L8cqXj93ti0tTb86rlm
 1H55ptoCsrO4NhnDZT5h9/IEAP4GzaHPqY4T+DDNQSgDnFgqzei4nRPJqv4p8ilsYgHrv
 mKtD4sdDrL1f4giXa5a6YZJeMLwmhyyYtx0utSgvE1nqJUWUGtIZLJAaYLX9eYoHSbznS
 NtmzsVkKbUX3KZOIqOkJbnPZ+f9bLvZ6VBgJoUMYAyNII/E4y9L5hpr7ZoKE9pHQj9w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021340;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
 bh=H0DAH1Min5mqUCcvgHIf/iTJSsGuEtvv7F+joGpmhsw=;
 b=Na8nxVC8uzi6gZbMGxJkmL9iSYsO3knG5xqHdkvErR5PR9hhnonN3Chw4mj6CDvWFDWh
 5T3pJS+PQGD/wp3DOpoZ5CxVqKZyt4eAIa6+MSh+YszFp9IfSd9Lk6aq6r/9V3emB0ujk
 dyTvEMzwEtL2Rp1m9a6Y2wm5nevJi8V/Sjh8Zwp/Ez3Tg0RLLDw5WwB1x46ihe+Uz7FUs
 rd0XeOLFEP2vn0Oc2Tgcg7oIA2x81z7sIT7A3HlhOfnlATa/MvHSgs9BC74HXeR5ptY1T
 DRWTM9LMIlR9nWsOyTxAS2TLDi6BuVqxUvRE6voJkVQygcXXhk6NOPzgsrMCscpaIzw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PI7UBBX4; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PI7UBBX4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id C4AA140059
 for <intel-wired-lan@osuosl.org>; Sat,  3 Oct 2026 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0DAH1Min5mqUCcvgHIf/iTJSsGuEtvv7F+joGpmhsw=;
 b=PI7UBBX4rD+O+eiIvLrUYV9J6IYL1lSLSk/oNhRQa4K4OfKwKO3E9xBioum0ADDOPm5L5e
 7TF0h9IjG7PXFR7p7NQ2phdwp4pHRcE/Ucj0DFP0NwQVRXnb0EDOn10ZjzB0t6hEdxbNTC
 BStf/t2MU519boMBGZ8cvimV77lNDdY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-xkKzLEZsNSuXkYPBIwRfEQ-1; Sat, 03 Oct 2026 05:55:37 -0400
X-MC-Unique: xkKzLEZsNSuXkYPBIwRfEQ-1
X-Mimecast-MFC-AGG-ID: xkKzLEZsNSuXkYPBIwRfEQ_1791021336
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1624abeacso4402415e9.3
 for <intel-wired-lan@osuosl.org>; Sat, 03 Oct 2026 02:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021336; x=1791626136;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R9oKQ4IhLDD9wBALXASu8n+QwFqOU76snzOYZ8jECb0=;
 b=LELsNwP23AuHbZzpZccLfpTZhb9DoKjmTCVUx/IJhVJF6vBqUAkzfLJrsjZx+Ad5hN
 9xIRbh3PrheYBEDjK/g+GpMz+dkJKVBeXw+65NFF6VYgXA0TosDFOaiCtzaPCF5h+T7s
 drjfRPQfmw4V6AxU/edLPqkUOeg5CeDYrye+fok9MHivtVzR2IU5PjLIxQDPIKdNPqxd
 SXWA6xAbCOM8Llkk/m29MVkqc3GBvy1UzlYHMcAKPiPtFEW58VzGIwNUM5cm7eB11G4L
 t2kEMWjMG+aSx//ci3CLD1ASVIqJZYsF3JDuZ70nIyMHAsG+K7o+NhzM1mvzVsWMJtDq
 s3tQ==
X-Gm-Message-State: AFuF++lSwieckRxrXT0PlEVQPCHPuV3cUf7uPFxgj/tuqvJJvZ0rGmjo
 8Y2H5r1j8RNJ3m5jte23nPajz3fwSflYXGlkfQFvTM9ntDKRnvm4SF1mqpbOvwbHNyHkVDHOv6L
 g2HmL2Qk/xs9WgSsqlRY2ItKLLLlckw4ho2zmhZkoBRCbynRWAFbGe0YKC1GZ0Y18v72t9Vhbkm
 KQ+kMSfJsxp0VzG8knZ5SgevczrQitp9+BNgTwl89q2R/ZqDR6
X-Gm-Gg: AYBFou0dOV5Dw3Iu8xewSgiSw1lxhER2yweH9vvV2Ly7fozefPVt0HugQJA0aDj3jNj
 d/25kJ6eKA2qFA1qK0x2eilTKkGxodbTDdR8rI30w8PJkW1059SWcD/FtRhycdRkmzuwuspfxid
 XsvrbJ55X6AS7t13cYJRs3i1nBtPoaoIPvi8J30MSX4ky5FKaFBoQc5MW8HIeML531LllCnB2B4
 OEmud6kEhOxtpMTRaxGBpGqXntgeGoibCbvr1dwtXWiuf0u6Mqg8cVaWeFEseqi1Rnw9t792K4t
 StR56uf6d36KPHihoAxrO2X1V4ztULZm+HeprsVkrHaSqmaxV8aAj5chzkOBf/WaIhEdGq9/7oI
 NCECQdl4TCvcVN5kkD4ZtiFvzwSzGFWQxyJXtmxc=
X-Received: by 2002:a05:600c:8b2f:b0:4a0:e45:e8d6 with SMTP id
 5b1f17b1804b1-4a027559b0emr79402485e9.13.1791021336444; 
 Sat, 03 Oct 2026 02:55:36 -0700 (PDT)
X-Received: by 2002:a05:600c:8b2f:b0:4a0:e45:e8d6 with SMTP id
 5b1f17b1804b1-4a027559b0emr79402045e9.13.1791021335818; 
 Sat, 03 Oct 2026 02:55:35 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a027735be1sm217904535e9.11.2026.10.03.02.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:55:35 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:33 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_06/10=5D_ice=3A_keep_adding?=
 =?US-ASCII?Q?_MAC_filters_after_one_that_already_exists?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-7-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-7-poros@redhat.com>
Message-ID: <C4418E3E-4192-4627-8614-E35AB517DA4A@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MiM8VLL8ZkjRg2WwhqBjEbcRWBwGRs4o7MRDIdG3eAU_1791021336
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

On October 2, 2026 3:07:48 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>ice_add_mac() returns as soon as one entry of the list fails, including
>-EEXIST for a filter that is already programmed for the VSI. The rest of
>the list is never added. ice_vsi_sync_fltr() treats -EEXIST as success,
>so the skipped addresses are considered synced and their traffic is
>dropped until they are removed and added again.
>
>In a test that adds 50 multicast addresses to a port in a burst with
>the port MAC address in the middle of it, 19 of them were left without
>a filter.
>
>Continue with the next entry on -EEXIST and report it once the whole
>list has been processed. Other errors still stop the loop.
>
>There is no i40e counterpart of this fix, i40e keeps its MAC filters in
>a hash with a state per filter and syncs them differently. It was found
>while building a reproducer for the MAC filter overflow handling that
>i40e fixed in commit e58872398684 ("i40e: fix disabling overflow
>promiscuous mode") and commit 7363115efb04 ("i40e: do not force filter
>failure in overflow promiscuous").
>
>Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt
>with the same problem for the VF MAC filter requests, which are now
>added one by one with -EEXIST tolerated, but left ice_add_mac() and the
>PF filter sync as they were.
>
>Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already exists")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/eth=
ernet/intel/ice/ice_switch.c
>index 2ee5cb6ffdab1f..239d4d9633baa6 100644
>--- a/drivers/net/ethernet/intel/ice/ice_switch.c
>+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
>@@ -3659,7 +3659,9 @@ int ice_add_mac(struct ice_hw *hw, struct list_head =
*m_list)
>=20
> =09=09m_list_itr->status =3D ice_add_rule_internal(hw, ICE_SW_LKUP_MAC,
> =09=09=09=09=09=09=09   m_list_itr);
>-=09=09if (m_list_itr->status)
>+=09=09if (m_list_itr->status =3D=3D -EEXIST)
>+=09=09=09status =3D -EEXIST;
>+=09=09else if (m_list_itr->status)
> =09=09=09return m_list_itr->status;
> =09}
>=20

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

