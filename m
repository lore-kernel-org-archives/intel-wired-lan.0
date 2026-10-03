Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC8DCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:48:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37DB340F16;
	Sat,  3 Oct 2026 09:48:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4FNjsTcEdH7; Sat,  3 Oct 2026 09:48:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 478F540F12
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791020917;
	b=G5Gc0UjHqwcmNpAm+NqG/6kz/wsj2RiEI5zfOUtKgHgt9jidjZlgywuCqBqFHUHeCYMI
	 KgH4p31y9emPC6JEacjGIcKmoxRg8eedMXJmxplhUoEU96uWf8McP8+kOPuTN86rA5BNI
	 w6yhGtmSB/FAxMmpBvt+4Vwfe2vtOpB+Mfu99C/ZpvFTVm7yC8ssjGo5c8FzKfDz0RdrF
	 gvxxcxwiXbB+gKg3KVdjPrYz56HyDRUqtX5sU4Bnm0E1eiB9gUOxfJhM/NZwHFXrIk2hD
	 p7k94V6zz6PALmxJr0QE++W81SqfloXJ+cx2/q31lkKRlHWKNoAKucC5AiznpzvzfRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791020917;
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
	bh=z7x1TZkAnrywMMHW1at1EUB0V3+CaU/GoODTeXzBgvA=;
	b=mH/tapCHTWzLNkjYPur8btrwcdo8NbsLT5c1vTclDUm5YuZmApGnd0XPhIoRDb+ooL4X
	 TFckBiiuFXr9OXwDEU3wmvdbNWNDydjSrTjS3PbHxviP1SOlhcAo4gbAsDq4+bZHQb3Mu
	 ZCDAaSyeGbohY/bjtbm7qq8URSyGkENbUJbccwxoLYUEU+ggZOrXJpoKez1VmJDeAFRLj
	 ISxl1uCgEbl4XOJAiSZjABcKm/QB/x3emptgWjW3+7GGeGZR2tXmaUZWG5+dt7ojlqwck
	 ZIqind7jZ+B54BO9tSyCS+0vLVGmhOrAydEiDcLwfBGUcMgJIEXaijB4D+ehxLV+7mg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791020917;
	bh=z7x1TZkAnrywMMHW1at1EUB0V3+CaU/GoODTeXzBgvA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6Ho5xESuxiCtX+HGLK1C0Pex89w9JzjrJ81HKr31xeRyq0u5FghMXhFzYxlGvKGTS
	 laeiSOu11ZhDNVwdRwLwN+waT5ciaNEWKdtKevydhn2fBAasAy7/ubFyed8hF/lx+o
	 T3tk2hE/TT1Y8EMWDngCgqB4IaoiT5fY7+iE4AqMsyUPrAjFJgzsFEqXbKveSnUdZh
	 izFgzhnwWCDrie6CO6mdYOf2HV8uqYb3WJKH9A5uKLPl95UabcI5WohB+/xO50XFK5
	 o6UAGh2NmqqgaxAWrdqOF3Vzxc17VQW0BrAm4HdPbDy8PMHQmrThlGF51drGfZ4LaO
	 qtnyGacrNpwXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 478F540F12;
	Sat,  3 Oct 2026 09:48:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48D71335
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E6D3400F6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:48:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0daXSvZ9G1Cr for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:48:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 783F140059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791020915;
 b=XHTtPRGbEhK0mGGZSyKDh0aKRwxsT8pPTML8vcP9pyZNXts2xC2rfFWwbCuXWn62umA/
 SmCCTY9DIjcwaWCzWpV9W4nKh0c6HC8MQ9s78/0/PJWDMH710vtc7HM+OqxNQbghrtPbV
 D3F4oAGqepC5vYvFKWQoaUrwjY6YPB1xJq/1zlmTz8tvEB3agORgaksku3UjhpcDD+YvN
 SkyvOBm/e/l7nwO2/u+cTcdTzrvadIcDB3OnmM//SIPd8mWkXyH9ICeyN7Z1P2PJig1ce
 aS+VVKkyIDyihTMuTmQ1OLtrm3nvSGXGZgg5NjoNLgLtNNcjI2GYzgaWmtbAYMpMuQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791020915;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=z7x1TZkAnrywMMHW1at1EUB0V3+CaU/GoODTeXzBgvA=;
 b=fXCq1rmqln++PKYrt+zNvz5JaP8LikmfnBgjkbyc7/jzTMFJElOCvGYKkjF1sW0P+Vfz
 KvSFBRcyEdOrz1bN+fWN89QOsL+MOE/Gk8tEe7uHO4hxuFECNPQex8NNJOPEoIETr0GK9
 SYDQjud/nPiFQ6xEqOocnWxIgyoO1sCHm7LQN26zc1K+WhdCKPMmJDoLwVEATxYc7kYrv
 BzZ67tsYMj3hdc6eJp5XhyYKaitVlQpOuXYR7LBjz3e1S5c1HR/cx/sfS/POXgC+C8RHa
 YPFvDZ2ObChEK2uUzDqITDy8S/zJswRd5W2WKEbN8E01eb7OL42saDzku9kSEeNxebQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=EscnMoH6; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=EscnMoH6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 783F140059
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791020911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7x1TZkAnrywMMHW1at1EUB0V3+CaU/GoODTeXzBgvA=;
 b=EscnMoH6ss7sSFHnbHGAPK3UOiPpK4FUfKesFg4IZBn91FOroRMB6Siq91MEXpFaY9Yif2
 5dtYarljcKSCqHXGAWhhcqG4Hzn0vufD5KvSqhpafLDVa9zDAbqvNFtHCasQfaE/Z14PS9
 flAWBZFnCO1zfpdUORrKRMzviw5RLzI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-3v0fLyHHNRGuRpyUJdKM8w-1; Sat, 03 Oct 2026 05:48:30 -0400
X-MC-Unique: 3v0fLyHHNRGuRpyUJdKM8w-1
X-Mimecast-MFC-AGG-ID: 3v0fLyHHNRGuRpyUJdKM8w_1791020909
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a01b112fa2so8840565e9.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791020909; x=1791625709;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3MSVzV+7zvbUIA5pRFEiBSu7+i6jPYbihTCBHKNz0yo=;
 b=rbvgoKWWhYVktUxaSZKlmhC5xJUkcvqxjEE96P9crTMyls0yNRi7RhURZzYPRZVnKt
 oom6zEx6fafoAoEjv2YcsMZSb7ruvLXVzPmKAIDwYSb9cTu+7aUTw1x4shbx6ZUiaXMH
 EyTuti4u7NQQZWCtI7Ni6f56QGJF2J3rYJJqp9t3unp9Pi67hAYrURFsTSCOIGp4TyZR
 kzzkRe+ZuhwINxfvLs/OwfldLNoK/sDSfkGYpf5AvsbMj+F3ZoqjQ0ueF2qRokQJHRwh
 OM3Lq8w+YBELS+FsyPP4az+2tUQgDZp80d40ReJcLjc62zefVrilNGq5jACVSpIpciRY
 c2OQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnm79w1m8I9ZhS0Uxmvx8FfsG/NyRxlckyIBsrk1vDWzcdynAgz2UAmWVJwNzgjIcAKrgCoWxlEb3bbxVQHd0=@lists.osuosl.org
X-Gm-Message-State: AFuF++lYZStt2t6M70k+hjbW1Z0M5R9rjzdQQzV5d/k9o3xFSiatrB+Z
 GGKDpgDRliYT742HukNsutfE1w2a2rhjeE621AiZqeH8FOSHWyuNu0D5mf7mXOt0F3L85Xu7pfH
 RtDyLmgfzcvsNUzj+OyqgUvTE+wndh0hHv6jBjhP+0CKCuUqcCA6GpZDxbngEm2Gv+GdDQ5g=
X-Gm-Gg: AYBFou0BnqLkFBc76vNxWwAi7Xu31Aq7QJ1JPbfKbJQP8mHitsh53H3IMuu8Lo1/Bpy
 P5yYLkpMr2I6w2veBYgR32T3Fa7V9pnVySA9rZYBQlYFbXsSYdeMZ9zD+zGVqguJzkdyg26JrBI
 +92hLqLGbelrFPKlC6SLcg7Wo2uYwLLqQMVYy6vixoZO0desxWmdj5OoT91ryFIR0uxEiWnLNu2
 TMy1z4P+GIhy9pIa0sxYPWDSEHWKYWTJZLsypBHsmBCuj9s3UxHFS977mvqe/y80oURgdzO5e8h
 bssMJo/9bQwC6L2BxWmY75NOmpAEPutxg1uVXu4pKEPCCTPUAOPJToPoHQ0iIoq1ug4dNRYd7Oe
 QrvSxD2s/jO/Du5A2PmnR8OsC9Yx8bgQlKE61iz0=
X-Received: by 2002:a05:600c:3ca4:b0:4a1:6424:41bd with SMTP id
 5b1f17b1804b1-4a1681001e3mr27916915e9.27.1791020909094; 
 Sat, 03 Oct 2026 02:48:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3ca4:b0:4a1:6424:41bd with SMTP id
 5b1f17b1804b1-4a1681001e3mr27916455e9.27.1791020908587; 
 Sat, 03 Oct 2026 02:48:28 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16bcb9a21sm37119375e9.10.2026.10.03.02.48.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:48:28 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:48:25 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net=5D_ice=3A_keep_the_VLAN_tag_of_p?=
 =?US-ASCII?Q?riority-tagged_frames_with_Rx_stripping_enabled?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002103108.2513191-1-poros@redhat.com>
References: <20261002103108.2513191-1-poros@redhat.com>
Message-ID: <70B89D99-E9C5-471A-BCBF-5CD56D92DDA2@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SshHKvYyfhRI7HLl_JMqi5O6wz3enJ4Gd7K1eBvl-bU_1791020909
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



On 2 October 2026 12:31:08 CEST, Petr Oros <poros@redhat.com> wrote:
>With Rx VLAN stripping enabled the hardware also strips tags with VID 0,
>but ice_receive_skb() only puts the stripped tag back when the VID is
>non-zero. Priority-tagged frames reach the stack as untagged and a vlan0
>upper device never sees them, while the same traffic works with rxvlan
>disabled.
>
>Hit by our QE VLAN test on an E810-XXV, where ping over vlan0 fails and
>tcpdump on the PF shows the peer's priority-tagged ARP requests arriving
>untagged. Reproduced on the net tree with a PF and its VF as the peer in
>both single and double VLAN mode. i40e had the same bug, fixed by commit
>2a508c64ad27 ("i40e: fix VLAN.TCI =3D=3D 0 RX HW offload").
>
>Put the tag in ice_process_skb_fields() keyed on the L2TAG1P/L2TAG2P
>status bits, let ice_get_vlan_tci() report whether a tag was stripped
>(this also fixes the XDP VLAN hint for a zero TCI) and drop the now
>trivial ice_receive_skb().
>
>Fixes: 2b245cb29421 ("ice: Implement transmit and NAPI support")
>Fixes: 714ed949c6f3 ("ice: Implement VLAN tag hint")
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_txrx.c     |  5 +---
> drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 ++++--------------
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 27 +++++++++++--------
> drivers/net/ethernet/intel/ice/ice_xsk.c      |  5 +---
> 4 files changed, 23 insertions(+), 40 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ether=
net/intel/ice/ice_txrx.c
>index 31303ab5be175a..3935ac05a251b4 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
>@@ -970,7 +970,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_rin=
g, int budget)
> =09=09struct sk_buff *skb;
> =09=09unsigned int size;
> =09=09u16 stat_err_bits;
>-=09=09u16 vlan_tci;
> =09=09bool rxe;
>=20
> =09=09/* get the Rx desc from Rx ring based on 'next_to_clean' */
>@@ -1051,8 +1050,6 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_r=
ing, int budget)
> =09=09=09continue;
> =09=09}
>=20
>-=09=09vlan_tci =3D ice_get_vlan_tci(rx_desc);
>-
> =09=09/* probably a little skewed due to removing CRC */
> =09=09total_rx_bytes +=3D skb->len;
>=20
>@@ -1061,7 +1058,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_r=
ing, int budget)
>=20
> =09=09ice_trace(clean_rx_irq_indicate, rx_ring, rx_desc, skb);
> =09=09/* send completed skb up the stack */
>-=09=09ice_receive_skb(rx_ring, skb, vlan_tci);
>+=09=09napi_gro_receive(&rx_ring->q_vector->napi, skb);
>=20
> =09=09/* update budget accounting */
> =09=09total_rx_pkts++;
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/e=
thernet/intel/ice/ice_txrx_lib.c
>index e695a664e53d18..19307086c238f5 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
>@@ -218,6 +218,7 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> =09=09       struct sk_buff *skb)
> {
> =09u16 ptype =3D ice_get_ptype(rx_desc);
>+=09u16 vlan_tci;
>=20
> =09ice_rx_hash_to_skb(rx_ring, rx_desc, skb, ptype);
>=20
>@@ -238,29 +239,13 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
>=20
> =09ice_rx_csum(rx_ring, skb, rx_desc, ptype);
>=20
>+=09if (rx_ring->vlan_proto && ice_get_vlan_tci(rx_desc, &vlan_tci))
>+=09=09__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto, vlan_tci);
>+
> =09if (rx_ring->ptp_rx)
> =09=09ice_ptp_rx_hwts_to_skb(rx_ring, rx_desc, skb);
> }
>=20
>-/**
>- * ice_receive_skb - Send a completed packet up the stack
>- * @rx_ring: Rx ring in play
>- * @skb: packet to send up
>- * @vlan_tci: VLAN TCI for packet
>- *
>- * This function sends the completed packet (via. skb) up the stack using
>- * gro receive functions (with/without VLAN tag)
>- */
>-void
>-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vla=
n_tci)
>-{
>-=09if ((vlan_tci & VLAN_VID_MASK) && rx_ring->vlan_proto)
>-=09=09__vlan_hwaccel_put_tag(skb, rx_ring->vlan_proto,
>-=09=09=09=09       vlan_tci);
>-
>-=09napi_gro_receive(&rx_ring->q_vector->napi, skb);
>-}
>-
> /**
>  * ice_clean_xdp_tx_buf - Free and unmap XDP Tx buffer
>  * @dev: device for DMA mapping
>@@ -587,8 +572,7 @@ static int ice_xdp_rx_vlan_tag(const struct xdp_md *ct=
x, __be16 *vlan_proto,
> =09if (!*vlan_proto)
> =09=09return -ENODATA;
>=20
>-=09*vlan_tci =3D ice_get_vlan_tci(xdp_ext->desc);
>-=09if (!*vlan_tci)
>+=09if (!ice_get_vlan_tci(xdp_ext->desc, vlan_tci))
> =09=09return -ENODATA;
>=20
> =09return 0;
>diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/e=
thernet/intel/ice/ice_txrx_lib.h
>index f17990b68b621d..579ce56c0c3c0a 100644
>--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
>@@ -70,25 +70,32 @@ ice_build_tstamp_desc(u16 tx_desc, u32 tstamp)
> /**
>  * ice_get_vlan_tci - get VLAN TCI from Rx flex descriptor
>  * @rx_desc: Rx 32b flex descriptor with RXDID=3D2
>+ * @vlan_tci: VLAN TCI stripped by hardware
>  *
>  * The OS and current PF implementation only support stripping a single V=
LAN tag
>- * at a time, so there should only ever be 0 or 1 tags in the l2tag* fiel=
ds. If
>- * one is found return the tag, else return 0 to mean no VLAN tag was fou=
nd.
>+ * at a time, so there should only ever be 0 or 1 tags in the l2tag* fiel=
ds.
>+ *
>+ * Return: true if a VLAN tag was stripped and stored in @vlan_tci, false
>+ * otherwise.
>  */
>-static inline u16
>-ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc)
>+static inline bool
>+ice_get_vlan_tci(const union ice_32b_rx_flex_desc *rx_desc, u16 *vlan_tci=
)
> {
> =09u16 stat_err_bits;
>=20
> =09stat_err_bits =3D BIT(ICE_RX_FLEX_DESC_STATUS0_L2TAG1P_S);
>-=09if (ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits))
>-=09=09return le16_to_cpu(rx_desc->wb.l2tag1);
>+=09if (ice_test_staterr(rx_desc->wb.status_error0, stat_err_bits)) {
>+=09=09*vlan_tci =3D le16_to_cpu(rx_desc->wb.l2tag1);
>+=09=09return true;
>+=09}
>=20
> =09stat_err_bits =3D BIT(ICE_RX_FLEX_DESC_STATUS1_L2TAG2P_S);
>-=09if (ice_test_staterr(rx_desc->wb.status_error1, stat_err_bits))
>-=09=09return le16_to_cpu(rx_desc->wb.l2tag2_2nd);
>+=09if (ice_test_staterr(rx_desc->wb.status_error1, stat_err_bits)) {
>+=09=09*vlan_tci =3D le16_to_cpu(rx_desc->wb.l2tag2_2nd);
>+=09=09return true;
>+=09}
>=20
>-=09return 0;
>+=09return false;
> }
>=20
> /**
>@@ -132,7 +139,5 @@ void
> ice_process_skb_fields(struct ice_rx_ring *rx_ring,
> =09=09       union ice_32b_rx_flex_desc *rx_desc,
> =09=09       struct sk_buff *skb);
>-void
>-ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vla=
n_tci);
>=20
> #endif /* !_ICE_TXRX_LIB_H_ */
>diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethern=
et/intel/ice/ice_xsk.c
>index 0643017541c35a..fd2e628a8bc95c 100644
>--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
>+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
>@@ -591,7 +591,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> =09=09struct xdp_buff *xdp;
> =09=09struct sk_buff *skb;
> =09=09u16 stat_err_bits;
>-=09=09u16 vlan_tci;
>=20
> =09=09rx_desc =3D ICE_RX_DESC(rx_ring, ntc);
>=20
>@@ -667,10 +666,8 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
> =09=09total_rx_bytes +=3D skb->len;
> =09=09total_rx_packets++;
>=20
>-=09=09vlan_tci =3D ice_get_vlan_tci(rx_desc);
>-
> =09=09ice_process_skb_fields(rx_ring, rx_desc, skb);
>-=09=09ice_receive_skb(rx_ring, skb, vlan_tci);
>+=09=09napi_gro_receive(&rx_ring->q_vector->napi, skb);
> =09}
>=20
> =09rx_ring->next_to_clean =3D ntc;


Reviewed-by: Ivan Vecera <ivecera@redhat.com>

