Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7847BCA5FA9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 470CF80E5E;
	Mon, 28 Sep 2026 15:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8POOcJxLM3e0; Mon, 28 Sep 2026 15:13:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6F5A880F2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608419;
	b=Ocv/5crP6Sy1MeqBVafOKeSKQJDhWeSAiaimQCBxDBj6URWmawxW7HGHNSyhoXZAbc0d
	 hHppuznaYVSOJgSjhiwuF3NKW5wHdjqKkbeBRtZSmTWpbfLuRVxj9YTwGRVCDPWcOs5qH
	 zoaSFkq6kzO9DyCwOnV1VNSkE5K+BRCESnR6gYptVZIaznoswlAgLv/3oqWdLMJfZA1sM
	 u4P4eKmDesz4b3qwaCqC/mTMjIBn6qQC6lhNxWIrhQzMW+CraHrHIjgBMNtDvVakRy5bw
	 P2Amc8onpcFswjGM2snzRfjKIfjdy0cHtVx9uiXfnL4ICcnnIqg1pLXSXAGqBoojVjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608419;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9Y5aMWqoAq1uOVxpOyjGeC3g3XkCWAkdCuPxoE8cuBY=;
	b=JKi/WttkXmIhiqEWiw0G24HO/nP4NymgxoK0UzZb7N3SrxMNs3Uom8ZwLV1635PQ5vY8
	 vv6IScskPLmYh7NcYavDN75SwJis2g+RlPFIkHAY25AUBs9lyuCNxa3uAJJ+4+C/GEWfA
	 obdYMZSMxfc+Ixk50qtD5WbUxvHYQ3sHlM2gs1W6rtUkoedCEqE5RBPYDDNutQsodFxfD
	 tQYOO1isUPbvxubid/BleqW241hY5xzQNUxuiSi0IFDrVrWblYIp5Q2f5C6RY8qSzI4Hb
	 PWetGehmBQc1iyKk2bxVJPLBLQqcOo6Jdihr1PV8aGuVS0lTtUOzCudUkdIRH/nOZYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608419;
	bh=9Y5aMWqoAq1uOVxpOyjGeC3g3XkCWAkdCuPxoE8cuBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/1cynbVuIYoGdSat0bZONtVhjiq6uhllDr9qLgUpeDQ0HrI3itnCXpFEBokHAbdd
	 T81JtIzb5zxIEfWE1/WzoxasewGq9Zjdgipu/AKXwNYjyOc02otVDlVILRiQBHyNlv
	 rV2klaNaO/3qXVz8G+vHISTeX6nS+GmZEQ4JlicaB1Do504kJOv+xfSx6xLeQT8C1d
	 srrx74fpuvVD6Hq+iU0dIuw0kCIkjE12s60Low6Bh5zKAn4hGOjcKmRwBVku1z/KgN
	 aom8MS7VAbbvEBR0Lo6xsmCELb/pVlFgpdJaXRzMPac2K1vgGYueSRoUa64D9tO0gD
	 Ugkfd/iZbDsxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F5A880F2C;
	Mon, 28 Sep 2026 15:13:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2BEBF194
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DA0340099
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:59:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rGB_FX3tmXbL for <intel-wired-lan@lists.osuosl.org>;
 Sun, 27 Sep 2026 13:59:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4E5E240068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790517568;
 b=qKkWRAfTNi8hOWAog1asrMsZMY83zU3BtlJQKyFZtU8TKQzVVVu9jANxILivnnlCK5Ww
 NBySzQCZhOdniVIWFsVVEEevTHu1pLnbatr0K7XgiIMPymFYWjJlQQABtpc3eFk7Vau0T
 nHyjrt+p9wRutWvlc0Q/a2Zrl4wfbULj0ptLDkDtAVsWNnIAHGc2yChH4+hYCu6qyuChx
 2om/tKsFW8oHwrkv9hEz96D9CTbk6JiWN4sE0UcyUnJaCOdysY2kTSxObDTwBOO6kxq/n
 juLJlSYOImFPxPHAOI0WAEA6nyEtXq9AeL+szekLKWX3BqQwt9asYM50rf++MmItj6Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790517568;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding;
 bh=9Y5aMWqoAq1uOVxpOyjGeC3g3XkCWAkdCuPxoE8cuBY=;
 b=J4pV2Bl2LsdBRKVDZgopeBcZb1J1zMIfL0ykhs2tSEhSBUko7xcK0/T28r3coJCdsCSB
 tmcWoyc/KuVoI82ZlC/muP6vzkbVefcNQa7IKeR6tOsMgGCEpPV2fioYpjhO5qinQZLpA
 uJPh18cVt5BU1z0gGmi38ZtQT5E0AP3OOazZPEjo33SLntdWXyHCVF3Kj8Hm+s66ghyrs
 ob6tPlW0nA0KyH3usyd/DVASBdj7aai+5uWU/iSsynb+zuOVlKFqOmEh4oMA9ASx1sDC9
 M2bkdrxQ0NgRvDUq1rDTbbnIdrvj9Hisi5ziHB9QD1O/9vrhtbvY2EGUo+J+wm2T6Yw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nHRuTF1+; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=edumazet@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nHRuTF1+
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E5E240068
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:59:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62CAB44095
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4B01F008A4
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 13:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790517567;
 bh=9Y5aMWqoAq1uOVxpOyjGeC3g3XkCWAkdCuPxoE8cuBY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=nHRuTF1+HUuyhJkKZe5l1P1W74M3GohQhRXuAYdfnAl7xY17Xdigx9DegKqOWRStS
 c0sZmLO1iPLzo6mD8E8tidsrfHiv9tr+pU/Pi16IzJnSar5NHZegmZM2ct9Tz3/kzH
 lBBvVkw5+YW23jFcfxk29RWNgDDHsERL9LuRbMMe/1cd/Ie6QJFZuS6XewX23JZJNL
 duoIM1bjsir4XU/VXtiaPLp2DnwWivuF69zOz5DE6iR/Ogt9I9TDRunti/sso+4ves
 jn8FBkbbE4EQOMNFS/ByktErl61Mzm9U7XMorvcoid4oosrH604IPDZ3T7aAE0pSW+
 qT/DOqp2uyQPQ==
Received: by mail-oi2-f13.google.com with SMTP id
 5614622812f47-4c3b639adbcso2085221b6e.1
 for <intel-wired-lan@lists.osuosl.org>; Sun, 27 Sep 2026 06:59:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBzzWELimgt3575v7bpmpo96nJVlAXUIZyDhPsKSAWmsyseOofwGw/G1qQrYYM9/L8da+LqGdzNu9jQivUjQ17E=@lists.osuosl.org
X-Gm-Message-State: AFuF++kRVLKLBrsFXcD2UZ+S5SAHYMVTLXVTUqUFLo8loxYqHomo4iPh
 Ocl19gBUho37eW6zChaFqE2b5ZHUH3fZ7hGtKIuqUlwhpJdZ47N0Xg0NpJVvzcNvhkr+gm/6/lM
 c94Dv3y6PZBGeFw0T8aeHPVb6F7dQFPw=
X-Received: by 2002:a05:6808:1817:b0:4e8:721f:283d with SMTP id
 5614622812f47-4e8721f3e12mr2278833b6e.38.1790517566507; Sun, 27 Sep 2026
 06:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790082243.git.petalzu987@gmail.com>
 <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
In-Reply-To: <79c2c81b7c61c61b242dbe1cc9b2db9860524a3f.1790082243.git.petalzu987@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sun, 27 Sep 2026 15:59:15 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiq6ughX_9V5cDxnb8GT-LTEunhdTq4T_YbhV2mq3zFhBQ@mail.gmail.com>
X-Gm-Features: AclHuK-tZ2AsBvnvtM7lmolBaWy7jW9oHQr9QF_kOj1-HeuNpD3TMPw_ARGI0OM
Message-ID: <CAL4Wiiq6ughX_9V5cDxnb8GT-LTEunhdTq4T_YbhV2mq3zFhBQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] i40e: validate TCP header before ATR access
To: Ren Wei <weir@nebusec.ai>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, kuba@kernel.org, 
 pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com, 
 herbert@gondor.apana.org.au, lucien.xin@gmail.com, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, sln@onemain.com, 
 fw@strlen.de, petalzu987@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:34 +0000
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

On Sat, Sep 26, 2026 at 8:23=E2=80=AFPM Ren Wei <weir@nebusec.ai> wrote:
>
> From: Zixuan Chai <petalzu987@gmail.com>
>
> i40e_atr() uses ipv6_find_hdr() to locate the TCP header. A successful
> protocol match does not verify that the complete TCP header is present in
> the skb, so dereferencing the result can access data beyond the packet.
>
> Check that the complete TCP header is available before inspecting it.
>
> Fixes: fd0a05ce74ef ("i40e: transmit, receive, and NAPI")
> Cc: stable@vger.kernel.org
> Reported-by: Florian Westphal <fw@strlen.de>
> Closes: https://lore.kernel.org/netfilter-devel/aq1HaYS96SNn7HJY@strlen.d=
e/
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40e/i40e_txrx.c
> index ef5e657816f0..cdac279b8aed 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2911,6 +2911,9 @@ static void i40e_atr(struct i40e_ring *tx_ring, str=
uct sk_buff *skb,
>
>         if (l4_proto !=3D IPPROTO_TCP)
>                 return;
> +       if (unlikely(skb_tail_pointer(skb) < hdr.network + hlen +
> +                            sizeof(struct tcphdr)))
> +               return;
>
>         th =3D (struct tcphdr *)(hdr.network + hlen);
>

pw-bot: cr

1) Please do not add bogus Reported-by: / Closes: tags. Florian never
reported an issue in i40e, unless this was not public?

2) How can this code be reached with a truncated or non-linear TCP header?
Unlike ixgbe_atr(), i40e_atr() returns immediately unless
tx_flags & (I40E_TX_FLAGS_IPV4 | I40E_TX_FLAGS_IPV6) is set.
Those flags are only set in i40e_tx_enable_csum(), which only acts on
CHECKSUM_PARTIAL packets and runs right before i40e_atr().

Furthermore, i40e_tx_enable_csum() (and i40e_tso()) already assumes the
network and transport headers are present in the linear skb head and
already dereferences ip.v4->version, ip.v6->nexthdr, and l4.tcp->doff
before i40e_atr() is ever called. Even within i40e_atr(), hdr.network
is already dereferenced prior to your check in the IPv4 branch.
