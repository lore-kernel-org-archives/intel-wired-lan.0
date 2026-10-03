Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D98BCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CDE3140F22;
	Sat,  3 Oct 2026 09:52:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nQXwcx_kk5Bx; Sat,  3 Oct 2026 09:52:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 25F8040F23
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021152;
	b=iCywGzJk4mLekFHiFg4HXirLrwjee2CBtTedkkBCsEbKPlOr8rj6NwAqzlpHDGx7dGve
	 nOzODhX9dOfofyLzpaRE/+bR5ulQDoep96zgKIrZ3D2Lu7WwyCkZkjYVXN58svb1OLdHI
	 dSDRHSSLMHr19axOe7j7musML5qIYtzK8ekEEmclY+Ds15hEqueLVtDt+WUSBwXo0uUTH
	 ttOm1mpzSv1SV+h7PpFpLI2jJ9TvNQLYcwa9X5JH2Nee5Sx8c6sKPbxjEXNkfyzEwqFlb
	 p+yGD/YqVjVB6U8sL3ilZRGgbT5Nm/Dxo8sU92Qin1z6cBHbdGDxeRrZ1o3hkjN8jfw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021152;
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
	bh=E+FDqTbxWKBUKoHRzptZ0BLbK5KRgPhFrF++n6X62gs=;
	b=QUYzsW5nRYlbfCyj1H7l0xQAK6sBRgzsG0SGutxHlmB2S/QsiPhSEodfyIheohdQF5H8
	 +btjg8UQr9Evy7BIMg56dtoZmcZ/flnzht/JLm/g2AnxaOYPl0LUK0lH0bJUSgh56EWCH
	 pivvXmmEvq1uWuxu12HCBiuSkhJWD95e9zfSaUH7XPnpN9I0l5VD3vIlg1mJtaQf4f9kG
	 QjQfOKOrLUF8tetiAHz2s77iPb79dGb0ooXXjOO/HJsgaE38Sw1VaU86SobZJ0CFQ49Bn
	 KjmMdp+bi7cBBdOj80ta7GfisN+UlSDn42gVd+7b9FtG4THjIV2VVsqIObNCKDMLDMQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021152;
	bh=E+FDqTbxWKBUKoHRzptZ0BLbK5KRgPhFrF++n6X62gs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iICF+LJ2liS/3NQiYVa0SGI06J2QPWIJ8xgqfOcyxLj0/CIDK7kCbQ1a+lrlu6Xid
	 pYj+ASUJFXxTs+mWWARgdKKsedb4MGcQLz2mfAP9z5MJswWDrzczify/+ut8o0Yx79
	 y5rgbl2kL3p6BvYb9WjgNYGEGkmmUvHxSDNBhYhkGgw2dCuk+JfE2cWwrWQsXaN30v
	 HkGP8/xlLYR+MkoMvi2wzlyVkv1JVcy+691VdOauQ0001sUo2K0WIoEclT/0hI0010
	 a5jgJ3N1Pmz7F7uhJaIH03HWxX1t0WtgrKsuyNwLN5V4uTOfvyFH1DM+hMF624Kuw4
	 y1F+EuLLdQ8Iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25F8040F23;
	Sat,  3 Oct 2026 09:52:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 12214179
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECCE580E24
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:52:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oq741L-5Qz5Z for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:52:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9886B80DDE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021150;
 b=pgt8j84vfq4BFGuzWUNTz+7N0HjLBdnos5/HoR9CqYNfckyRQaMNeLTFDMx0wN3ntAsH
 ZzfqTu6EIfu6kZehJDjqLt6gDYZCUDNpkFAJg5KRMV2cLwwPXlbhexrhn32MX08mCYIEC
 jNhJNryrbTidrcQcA0kZKHX47tj8GH096rW0vSdWqY6PhrJCSy+PIJSoHIZ8hchIUfVgW
 OTrfibQAt9TqU0J62l/v6Uy3kTkJD+WOVoS2cFLg4Bcc6Tsrn3PRxraqxnl9Nupj0uJG0
 frNiW/ijNhktFW8+AsLYul2+JfJ4QfQaoVMnP3lh9dKffn6fKvq3Llwjug2vFiNTjAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021150;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=E+FDqTbxWKBUKoHRzptZ0BLbK5KRgPhFrF++n6X62gs=;
 b=l5S6RLZrhFMW250NxNRPUjP5vtuTJ3owlwO6jkJJawqUB5aWzOjGsiN7qw2t7+kdWSjq
 PR7C5dtIOvDjIg5qE01vFUu1zdDngxnC2+Vl2kc6j3GG3YGQfmw7NwJu9CDJkpkWKp9JZ
 1XkFmit5Yqp92sCCD2/qlyuD3m5Tbq2lsIdlLSWZFuSJOKwTDXTDQS0H2+LTgzsqbCfj7
 mXe3eYi8dtpKQ7fga6lJ8Ti31ge+lLuoIrhTvnzuMkF696UPKSJCbQRTIA/2Ruh8mz6GW
 /u/TR0FmgtqJpW1vMSUitpCFMODonDKozP+SkWrPISEKBp89kmUt3fdwJMhbmXo3eTw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="GRv2b+/T"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=GRv2b+/T
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9886B80DDE
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+FDqTbxWKBUKoHRzptZ0BLbK5KRgPhFrF++n6X62gs=;
 b=GRv2b+/TEx7uxmUsUDxqL3anqHEwOQ/XxR7onkjU86NAlGUR0N7AfZOApQM78SLkm63neh
 ZKp+1ORl8ZHK1yVwJR1V5y68LpWcy/SfoUs7RttvaluF86YXK07n6kSXqfUAbFE+U8c/uj
 bhhiTWj7ojHplf/zyKCPKF+HdNORDsM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-rEreEP2PMXO5e9jbtEqp0Q-1; Sat, 03 Oct 2026 05:52:26 -0400
X-MC-Unique: rEreEP2PMXO5e9jbtEqp0Q-1
X-Mimecast-MFC-AGG-ID: rEreEP2PMXO5e9jbtEqp0Q_1791021145
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48c4d7ba211so160856f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021145; x=1791625945;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bGwiD5BsIU7SMUvm8z3LsVJJc+9NsNqtDssS4ilkK84=;
 b=kO9e0p/oJ3zd9mGr9sqb4XOEuqwt4DIdvT1Ma5o+LjubgSTR5GsSWdG8HE7ww+k4/X
 09FZ206xtSXeVpvVOue7rnamoISigxO+iaA5Ywc9whAifLXsoBYY1olQ364XDeTcM9EE
 cI1TP+QEo0EWcdXsekme0w1eKyboW56T5p/WMiupam20GWfzlxn/7hIyZ8b3J/4U4ria
 7r03LiQIc1oFNRWjv3kho1Ed0C3fzK8Dw9pN9v4MlrWF2SO5XDMfjb5NBcY7wbDBYySJ
 tEmVCXgDjH7gJhjhb/okEpABwca6yeki8Zos6ly7kdx00BPHdR6a6QD1Fj7AkHp3k+h1
 SQaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQIUXV1ChHMNPGvfXvwn2lQKk76tJF9A8Af2vzjTldqr7JId347ke6px8QyxBDCpRL54hrLDFNnjHQvKX6jwg=@lists.osuosl.org
X-Gm-Message-State: AFq9FYKK8ItwMINX9h/7cND9hoH8WXFSGBwWZ1iirxtHDCeTKpWJ220s
 V26NmhQaXtbB3QCdJjspdrJBvw9d0QHqA8ocxyMSBenjbP2Dd/LiFkuPoYtT7JmVJMZNaFGGkAK
 /snBPmjl5jt2R78/poI3Vnx4+YWXSXHpmTKqsHib5jRuZKlJwCeisa+3w5oiRyCfBSg87U1s=
X-Gm-Gg: AYBFou2UJljvKCf9vprJ6RfuRsG9Vb7h6JxXKJhcmnPQcchXqOSiuPmdt33XcPpkLpm
 g/SGNI44l/jQZK24lRzuM5cE6monJxKEYEXQef9j3+CRE2Pe1MUxX+4EpaDDkXVq2qHW2BM/7YW
 bAgiWiXFtBkIQsTj8Z3L3l3wl/BA12w5UqON8eS/fkj3Hh4posGySBn/HifNkuzIs1CGc1UL4ZX
 oOLpgSDbISQrXj0GN3uUb6jU7Q+4dssgizibw9zk/RDI5HTh/4JYjlk6Xh/2xN3/4CABS+brjUk
 1K6oFUr4yvLLYhFTeDw1k420Iq2QW3cO23niuvmQi+BUcWNysEyY8LnUcTJTgzMjOTTNrsF8TFm
 JpFH9t766S0/ljaiaAoNcD1cZtcq54qmLFhMjo9U=
X-Received: by 2002:a5d:64c9:0:b0:488:8437:b8b7 with SMTP id
 ffacd0b85a97d-48b126f1596mr9932280f8f.7.1791021145318; 
 Sat, 03 Oct 2026 02:52:25 -0700 (PDT)
X-Received: by 2002:a5d:64c9:0:b0:488:8437:b8b7 with SMTP id
 ffacd0b85a97d-48b126f1596mr9932244f8f.7.1791021144825; 
 Sat, 03 Oct 2026 02:52:24 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f0613sm12752818f8f.13.2026.10.03.02.52.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:52:24 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:52:22 +0200
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_01/10=5D_ice=3A_replay_UDP?=
 =?US-ASCII?Q?_tunnel_ports_after_a_core_or_global_reset?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-2-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-2-poros@redhat.com>
Message-ID: <E2F0ABAB-6E8A-4672-8DCC-9F3C07E902A5@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q9O2ocP8MCqlJ_Lf7uP2Cp5uYOApXaRgCJwTd8g0qRM_1791021145
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

On October 2, 2026 3:07:43 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
>ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and GENEVE
>port is gone from both the boost TCAM and the driver table. The
>udp_tunnel_nic core is never told about it and still considers the ports
>programmed, so the Rx tunnel offloads silently stop working after the
>reset. With VXLAN port 4789 offloaded, 64 flows that differ only in the
>inner headers are spread over all six Rx queues of the test port by
>RSS, after a CORER they all land in a single queue, the same as without
>the port. Removing the port later trips the WARN_ON() in
>ice_destroy_tunnel() because its table entry is no longer valid:
>
>  WARNING: ice_flex_pipe.c:524 at ice_udp_tunnel_unset_port+0x56/0x280 [ic=
e]
>  ice 0000:04:00.3 enp4s0f3np3: Error removing UDP tunnel - -5
>  ice 0000:04:00.3 enp4s0f3np3: UDP tunnel port sync failed port 4789 type=
 vxlan: -5
>
>Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the core
>programs the ports again. A PF reset keeps the package and the table, so
>it is left alone. No rtnl_lock is needed since commit 1ead7501094c
>("udp_tunnel: remove rtnl_lock dependency").
>
>i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram
>port offloads after reset").
>
>Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ether=
net/intel/ice/ice_main.c
>index 8c4b0fbc790644..f2121e79fca993 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -7859,8 +7859,11 @@ static void ice_rebuild(struct ice_pf *pf, enum ice=
_reset_req reset_type)
> =09=09ice_rebuild_arfs(pf);
> =09}
>=20
>-=09if (vsi && vsi->netdev)
>+=09if (vsi && vsi->netdev) {
> =09=09netif_device_attach(vsi->netdev);
>+=09=09if (reset_type !=3D ICE_RESET_PFR)
>+=09=09=09udp_tunnel_nic_reset_ntf(vsi->netdev);
>+=09}
>=20
> =09ice_update_pf_netdev_link(pf);
>=20

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

