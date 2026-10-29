Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF0606A327
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Nov 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=MtSIUyVm;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wqLYSDI9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E299F40506;
	Mon,  2 Nov 2026 22:32:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uEeQF4a3Jt81; Mon,  2 Nov 2026 22:32:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F58640507
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793658764;
	b=dDZu9c4Ef2ndt4kxEBNGJ7xVCLt35Z0/UfZVW9UWApgib73IdkbGO3aRpProRfRSadeH
	 Xkyxf3fkte3ocC33fRpPYdA5ghYwIOwq3SbBKsieRLdOqdv6uUNnckyMHgrkUaWhJrIqq
	 lmiKGP8kPaHmC+x1HaPmFmebTvnih2X8Y26Gm1NzPqZ5osRxa5mEX8Kr+M+BLd4o90yqT
	 TUQf9y9UE4f/hmdDXUV50TXPyFitDYwoGWuUkh7H34/O+Phkk9HEGPQGcKPct26lZrEPX
	 qD1qhK8W5FcY/7JK/m6Ykaj9FNR1WarGidageQriHESaVyIHFPcsd7fermMqDad7v1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793658764;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
	b=ZpBOfl3TAqypGuKTehJb2B+x7YMIXQg4Sh8MiYcTER1yvMkTtVc+VaV2O5xLuOzLEi3k
	 U29+trwtfycauVW/gujOPnisWNYbr/NsXiVGtROoMWo1VfQnfubVetkREkNBR0APytYsI
	 i6cROrSB6MY4SKsNySE7Q2tXWTqgc2QRlR/JAE1i/gs7RzVE1pQFnzhXZmRv8YC0R2pqz
	 tR+F62VSbSggkCAz7itvbsgJCVZy8EN2Ffg2dceJZ7fS81QJec4IxBhzY4jgyB5cUBer0
	 1Ts/MBliBtXGsaJ6foVKKormfjWdBV5wEVgWb44auYPOrJKqZVrsZNhxvhWi0tugR0w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793658764;
	bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MtSIUyVmMrTtHKtk6k1fl5/ebqZEKfEMRzpiDVUmnkJPbgKc1hSduA1fnrGl0VraN
	 KZFmy8J1LVbcXrEPDtcdiq/cUAM0juNpvIRSf/cNprMbpR9MQeHmU4I87GcM+mg4SS
	 0E/ZujfJE3qTxVo4/RS3AwHqZxN6AGuETPg/kjN68a8tASlPxSz0pDvYO22PdyxpNG
	 QtdWrSKva7DG/5p1DC4n/oo5zzdGLv8UpfKq+CmAJUEIwiFNsDqQK7IsNgSHWvXGN1
	 5rtSsVzYrcmgdq55dZyUT2AFmoHiDq58GzDL3QE/u7HEOnA/HKupaNYv6ZQT8dkvwX
	 y/jYYJoDxLwug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F58640507;
	Mon,  2 Nov 2026 22:32:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C0036D22
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 16:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A68BC606C4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 16:47:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 09ThETotBP41 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 16:47:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB14F606BB
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793292457;
 b=tZy6zy4r1U1L7SX8dbOgMPBnWf+UJdhhPynh1pTn/vEDuhi/jEdT/S/LJWooy/QToQS3
 BI0oWvn9PI/Hdjd/PKP33mI0wIU+0gTrO395yC/WgpwNMyzIljcVmvZYI+8uic13nkCjv
 GchA/fouSn9tcoL7dMaz33VBND4VFQ5Ifl0zYbNKsHNpgaU9No+CYwUQK+3SzJZTduJv7
 S8fhly+HqFmqJaHBQlnERE5IVSIpd6vn9zku0ag1WWoaXPNj52YYS3sPG80poL495FTTO
 p2MMlZChm5y7tg5aV6U5TYBOQ2lYS+I9tPJA8dD+zRdB2jKQBqhHKkMb1PTk4oSaK5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793292457;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
 bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
 b=PylraI8/3+SvQIKrRON06tMFJGtoKtg+5CAu1/qtsfg2R9J79K3u1NydKqqjnhR1ohW9
 PyFy+mFX3VfMC/zoTWtmd4XL3SClsEm6z0WU5JeCUfs8m8zpM4p6BtNb/vUGYCUVIFsUs
 1DuR/pG6jw16HVLGhISxbgsGPBoGIrdNHasnwnUy4yk+YHTnv32N3dLB7717rdlrUom1P
 7oDW/BxmwihMgH+v4smtQfumE7YPM06Crf0qzaDGwKqKWeN7EIqd3O8bqaf65J9u7VQ4b
 07wwcFtinWMtM+JAli2dNg3h+1ZDB9OKRUcFZ4UpLsqxSKJs8a0X3eEVwysC2yGtnPA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=wqLYSDI9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=alexander.duyck@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=wqLYSDI9
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB14F606BB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 16:47:36 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso1039441a12.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793292456; x=1793897256; darn=lists.osuosl.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
 b=wqLYSDI9zGLray2NUXS09eU2NdBlc2BoYJIsRZCudiL6zi9/t9dU8pj6NypmIroHdC
 G18sNJfa46UlZ+6d0biE9U4MLPdH7YoKF+DPo9BxtaOfRd522hwIl5eiMcl8whNq+AJ7
 08xHynvbckyXV6kmhiSoz1eYSffYbjOMiZt8/PFm9GNiVHoCIMZLnGX4au/YReylGxdY
 Sj+fs3INx1lAKiJC/3lYdeWDe6lty5wI5meArCNYuOx2OT2XjqVLj8lEeVx8emhwSHJG
 8gkfqFO37sUGV3ynRFmYA8fi8bm8A2GzoZKk+v9vxi+grk+GagaWwtD/GKwsb1O1kyGf
 WSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292456; x=1793897256;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
 b=Me5iFn3/qbxoNnYi0PGGZydD++X0sP9f9UgZVGops9ddecNqH75fV2BtknVVjlUIqf
 NcINIHwZOqIPwOfZ14xg5/EJCYGSFmvjMvnWsL32o2pRRxu6IGGx5zQZq0RAzNNlCJwB
 iLIi/F1o2FzNF/9NfNwG35/G5CyMRr6N1dpAVUq1A8+8tdqLMcfuASie07U2e74VieQb
 EF4lscPQIB4bP0y7evCaOAV5h29RbN4qjOpa/tm4ahxyxBLBjrwV2qibn+A8+b/jh3Io
 JStBZDq/25MyOX1NoJXMVxquBNyTf+N9SMuRWhkMbeAmi+5oiaGhdDJOQPQhrsApKPRp
 JbsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxuU6Uc+TgNgUKwTgBHgH4ro03NmxOWfGcvlryttVylmWsv7cBIfnC/vrX/Di7j4AIG249Z/Zk8SIIMYVKil5E=@lists.osuosl.org
X-Gm-Message-State: AFq9FYJCIXxL+YV99b1Kuktlb8QWOF5KQJJxHqKKBXe5msvmXgUrMVXO
 7keuEyuw6XELzoaqYvjhNxeYiJ7w9NQS4ccvc7cagTb/DkIhw9Dv5axL
X-Gm-Gg: AYBFou3zQ1ULFlgu7CB0tYykDSQVAHoXfFRm8rhJjIk4TVYjVulugK3PHkQSWeR9DLP
 JpFq5WNPKbZ54UcKKyvJ5voXVOvbNJHjIVgYo3Tza7r12DCuvK1RZS/URVc/q9BBRCesxk8HONy
 7FWpwk9h673Wr3bmQmgtnyLlO922k5VwR+AHXjSs4w1PDlwQ4YMTe/ZOyG8IisX2xZfpxvVO4fY
 ZfTwdCVI8aRK+Ab2kBauSV2Yymue4K5bZBMszvS8pdJwQveEyJdb9Bk70bXp3S8DSlRuYwUR9k4
 PNoJQgvJiN+r7GioAQUOzO02K13k6oB/FVtgvJBch3l7r1v9OP8z//r2Gl1g9e4R56SK+NvQAMY
 tIc+HTSdpQzW+JsASd7isV7tEhRg9UmQaiurYw16+KlsCof1Bz1yjGl2S7OT1XdhDLphXo1KGFr
 9kC3wye0oVgpYkO2Mg524PP8nixUuR9N6Wb9cgP9UZEoRRMq+nwf5A18Up+8z/EfyC1nZz9MAOB
 aVajKC0oeiaE32LjUqElanko/Suy3so0wS5+K99WgTCMsDQXUUXyiJ1fxpUdR3km1OcMuZ+0TGP
 oIY46+4yjqv/YtmFICmRiqgyso874gwEQhmNGWaJSQKlOcy8MkCOqJAxfBPhgG8kiNTiiQUAZVd
 Sa9v11HKZPCT8jHadaO3mzV+XC09ZwJylBQ4nbvXaV9XOfqoY8WMeEvsIcruPBxboa7U=
X-Received: by 2002:a17:90b:57c5:b0:3ab:9f89:e1b3 with SMTP id
 98e67ed59e1d1-3ae580dded9mr4420716a91.40.1793292455884; 
 Thu, 29 Oct 2026 09:47:35 -0700 (PDT)
Received: from ?IPv6:2605:59c1:38c:400:82ee:73ff:fe41:9a02?
 ([2605:59c1:38c:400:82ee:73ff:fe41:9a02])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9583c1sm5285959a91.10.2026.10.29.09.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:47:35 -0700 (PDT)
Message-ID: <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Matt Vollrath <tactii@gmail.com>, intel-wired-lan@lists.osuosl.org, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Andre Brait
 <andrebrait@gmail.com>, stable@vger.kernel.org
Date: Thu, 29 Oct 2026 09:47:34 -0700
In-Reply-To: <20261028170239.28606-1-tactii@gmail.com>
References: <20261028170239.28606-1-tactii@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Nov 2026 22:32:41 +0000
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> When an skb arrives at the driver and the header length exceeds the u8
> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
> are sent to the card. If TSO is enabled, some header lengths will cause
> the card to hang.
>=20
> This was reproduced on an I218-V with an unprivileged Python script.

Can you elaborate on what the script did to trigger this? I am
wondering if it can even get there with a valid frame supported by the
interface since most of these e1000e parts don't support tunnels and
such.

Also did it have separate cases for the CSUM vs the GSO? I would
suspect this is more a CSUM issue than a GSO issue.

> Fix it by disabling GSO and checksum offload when the header length (and
> checksum offset) would exceed the field widths. Compensate for a
> software-inserted VLAN tag.
>=20
> Because of a quirk in the ordering of ndo_features_check, the skb's
> transport_header field may be stale. If the skb carries
> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
> no reliable interface, so don't offload it.
>=20
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently f=
or ICH9 devices only)")

I am pretty sure this Fixes tag is bogus. This is the introduction of
the e1000e driver which was in 2007. The ndo_features_check didn't
exist until 2014 sometime after that if I am not mistaken.

Much of the complexity that enabled frames to build up massive headers
wasn't until much later when the network tunnels and OVS started being
added.

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index 6f85dab5c55c5..370776657d100 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *n=
etdev,
>  	return 1;
>  }
> =20
> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> +					      struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	/* Do not offload packets whose header lengths exceed the u8 fields
> +	 * in the descriptor.
> +	 */
> +	unsigned int hdr_len =3D 0;
> +
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		const struct tcphdr *th =3D (const void *)skb_checksum_start(skb);
> +
> +		hdr_len =3D skb_checksum_start_offset(skb);
> +		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> +			hdr_len +=3D __tcp_hdrlen(th);
> +		else
> +			hdr_len +=3D skb->csum_offset;
> +	} else if (skb_is_gso(skb)) {
> +		/* Work around untrustworthy header offsets in this case. */
> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +	}

Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
the frame must not be TCP/UDP GSO since for those normally the checksum
and offsets should be populated. Have you identified cases where we are
seeing TCP/UDP GSO w/o the checksum being set up?

From what I can tell it looks like the only valid cases for it not to
be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
anyway.

> +
> +	if (skb_vlan_tag_present(skb) &&
> +	    !vlan_hw_offload_capable(features, skb->vlan_proto))
> +		hdr_len +=3D VLAN_HLEN;
> +
> +	if (hdr_len > U8_MAX)
> +		features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +
> +	return features;
> +}
> +
>  static const struct net_device_ops e1000e_netdev_ops =3D {
>  	.ndo_open		=3D e1000e_open,
>  	.ndo_stop		=3D e1000e_close,
> @@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_op=
s =3D {
>  #endif
>  	.ndo_set_features	=3D e1000_set_features,
>  	.ndo_fix_features	=3D e1000_fix_features,
> -	.ndo_features_check	=3D passthru_features_check,
> +	.ndo_features_check	=3D e1000_features_check,
>  	.ndo_hwtstamp_get	=3D e1000e_hwtstamp_get,
>  	.ndo_hwtstamp_set	=3D e1000e_hwtstamp_set,
>  };
>=20
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
