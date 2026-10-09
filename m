Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0D4CA9EBE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52CC381488;
	Fri,  9 Oct 2026 21:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BQor_TBJYFox; Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7D42F8146E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791579841;
	b=At+3+6u58I867LdNSvU5KDuKWiEIPhrYu0EfBrCOHSxA6V5xKmlGtntvbB1GH67lSpbO
	 YlFGmEsWR99vVoJHU51VVk1PHI09Dv3s3Nq2l6tEl6Fv91mGeO68p+v+DYu6fVSYkBu45
	 zNXmo6uAZAtqNHf3OujEJY4PBRu1BoYPu/gIYXXtm+WZBU20nm6B5KjDL3vSuVMkeq7ZR
	 AIXcAgcJH2/ZXwqw3itrjJh6kGHbP4Xx8FzoPXVWbZhY5MkN7fXOFPsLM/PmeXlqOfcC6
	 bW0tNlcuBktFHJqFmnhNjiekwHQPWMWa/ZhkpoFadU0VKCwSm3jkHwgu0kwczPuX8vQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791579841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=tDkbJya0VOTux8zWzYZ+roaaXeRR1oDgP+NpjT0Rpl0=;
	b=ScbBBWtwoBqg05GXiu/qQ/3cE81ejmnadBzwNVsfL19E7k47SY2JE98ue3lGse9fD4XL
	 CGK7bICIZtLI2j+VXXeJ3Nr65tsY1Hye0PbX566JNKCsVGasmC3t/YEo9iXYRTF646Wy6
	 EjI3qg+NvyKbWwHngWr+zLESgHpqsO+qnkkXU5c+W2nRqM5B310ZRJm8X8GXsgWkwRptD
	 XMwE5rKSM6NcXsJ9MbDI/BxAtPNviJlR7SU4Qx4ERH2SVJbKA/5W4fk+L9lUFUD4eOZJa
	 jj+dqBs5psa9qGBV20CIWlUIeNfmG5o9W8f67FIzYzinpeElWqBnUzH8t3rKRFFCIjg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791579841;
	bh=tDkbJya0VOTux8zWzYZ+roaaXeRR1oDgP+NpjT0Rpl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ANHUmesATxB/sirpdLUhuRW4yKibWDMRcbIKxhEwNOr6FbJaeH4hqxDhHybNRuBoi
	 a6p5GdBbR6iv9yel6KYn+Oy4UtF61VE8gq+/EAv6q8yU/ELkB3Vt/MyWePSBHqLKBI
	 T3RPOaTt5THBSVJ7hHFERXirinxIVlceueTx8sX7onsrM9iBP8itzvK4CllX+3CDWG
	 BQpddDaGoBBcWXCz2TKyaCiJ5MNSPOj9ffcsGCTOkBNLteAoB+Wob6eMP8+eMQeh6N
	 76Zo1f/XV3sqhCVXnYPyCSNI1Dz+6q3TPuE1GC6ey1NvEVv8ncz3WdJUgApGIrY2fT
	 PUdKtkdiQEDpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D42F8146E;
	Fri,  9 Oct 2026 21:04:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C9A251DE
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5ECA606F8
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:03:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AfurOpt4sOCQ for <intel-wired-lan@lists.osuosl.org>;
 Fri,  9 Oct 2026 21:03:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B09F66067C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791579838;
 b=fjAGnsKJa6k84fgf+pAE9sdur3cB6BN63WrjcbgJrPFvhgsiEwJw/7OswirfIMKXj2hm
 jZR+mY5gDbvpTyrmRTotpSn1EIAbawWQohAleDB6bnUAHg5NIKaJOWOrIN9NcpQXTO6m9
 sSJTEMgZhXzQD7gSNfKSxxvVyExFAieHRy/n89moy0qF8niFfJ3RQbEuuvfZEJLTKj3jV
 edTH85qQ+sRKfiENMJO5pn+qsUvXaCIpqCoABz0i8IOnGOSCBVup10fUT5POvVgylitaQ
 BZMVbGQDYFUXpYTBVJjDZPHyFePajjNtBaOwVT/dfqr/1jJTNrgpqxBUSJNNVspQo9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791579838;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=tDkbJya0VOTux8zWzYZ+roaaXeRR1oDgP+NpjT0Rpl0=;
 b=g6Yvyjed3XENSWwKZI8VihOoYyQkpajwrLQ296YdE2xfz9H316qcXglpABuI/8OYUtkJ
 AoarRvw/GlYcEeYnXKEaIom0b5fp5v3AIYhMbGx4VXa8NdQp98NGrJooEyHLqp00lHE0n
 KNFpKsQNak/K/oR96HKlgRHmWKMOqaIPM1uDLC82eDXdfSjyLATporTixhHtrlU1a57Ao
 /yZ91pGFrAW8bgw1q7sI1pu1dtub8W4I9tbaj50hDzxn04pmPUp+9gObj2TXYXW/tfxAz
 YwfFIHALgdsXGNxl5FeGhaVBAVYmkd1y5IAixzo20JkWmwjVSdrmWQ0SjuWeNyYT78Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kgOOfxIS; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kgOOfxIS
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B09F66067C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  9 Oct 2026 21:03:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9977243FA1;
 Fri,  9 Oct 2026 21:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C31F00893;
 Fri,  9 Oct 2026 21:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791579837;
 bh=tDkbJya0VOTux8zWzYZ+roaaXeRR1oDgP+NpjT0Rpl0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kgOOfxIS6NX3uvcJdD26yfroyQf+tfOjpaeOENVNuo1NVGCV4cFqu1PHxe9ptipme
 BuzwJNC+AmxJOlwPraJOK9zr5RP77PjDAgwsf+feoeWkxzYS3+NlayrCn7D9ygreoG
 qMacb2QHQs/iYM53UrcC5+JR1CrFQlteN9YEdRRW2GKgOfBMJ/rasf1UzUlO+5Y46N
 TBqroLHRbGfhTLx6wpkwuL/AJPT9E9X/tlr4lVd3fprpiYjcWXeDnG2diRRtDG8Jfp
 hNCXya3jqfyu/C7AcIdMDbRuYvE/pXJKDI5dKVGmpsEwSFSWpMSVsZnaBzYN21TYZk
 JUy8vpNFIneAA==
Message-ID: <sashiko-outbox-166069@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 04/10] net: niu: check for failure when
 pulling in the RX header
To: "Josef Bacik" <josef@toxicpanda.com>
Cc: intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-4-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
 <20261008-b4-pskb-pull-tail-drivers-v2-4-8f2bd9bee138@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 21:03:56 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: niu: BUG() in eth_type_trans due to insufficient pskb_may_pul=
l length
--

commit 19ab5666684c0028709e6a0efad246e9460b1000
Author: Josef Bacik <josef@toxicpanda.com>

net: niu: check for failure when pulling in the RX header

This commit replaces __pskb_pull_tail() with pskb_may_pull() in
niu_process_rx_pkt() and adds error handling. If pulling the header fails,
the packet is dropped instead of crashing.

> diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/ni=
u.c
> index c74a97fe54641..d1c0e868004d1 100644
> --- a/drivers/net/ethernet/sun/niu.c
> +++ b/drivers/net/ethernet/sun/niu.c
> @@ -3488,7 +3488,11 @@ static int niu_process_rx_pkt(struct napi_struct *=
napi, struct niu *np,
> =20
>  	len +=3D sizeof(*rh);
>  	len =3D min_t(int, len, sizeof(*rh) + VLAN_ETH_HLEN);
> -	__pskb_pull_tail(skb, len);
> +	if (unlikely(!pskb_may_pull(skb, len))) {

[Severity: High]
Is it possible for a malformed hardware descriptor to provide a small
RCR_ENTRY_L2_LEN, resulting in a BUG_ON assertion in __skb_pull() later
when eth_type_trans() is called?

If the hardware reports an unusually small RCR_ENTRY_L2_LEN (e.g. 4 bytes),
then len evaluates to 12. pskb_may_pull(skb, 12) would only ensure 12 bytes
in the linear area.

Later in this function, skb_pull(skb, sizeof(*rh)) consumes the 8-byte
hardware header, leaving 4 linear bytes. The packet is then passed to
eth_type_trans(), which attempts to pull ETH_HLEN (14) bytes:

drivers/net/ethernet/sun/niu.c:niu_process_rx_pkt() {
    ...
    skb_pull(skb, sizeof(*rh));
    ...
    skb->protocol =3D eth_type_trans(skb, np->dev);
    ...
}

If the total skb->len is greater than 14 due to fragments, __skb_pull()
will execute and subtract 14 from skb->len. This could drop skb->len below
skb->data_len and trigger a BUG_ON(skb->len < skb->data_len) in __skb_pull(=
).

Should pskb_may_pull() ensure at least sizeof(*rh) + ETH_HLEN bytes to
protect the downstream eth_type_trans() call?

> +		rp->rx_dropped++;
> +		kfree_skb(skb);
> +		return num_rcr;
> +	}
> =20
>  	rh =3D (struct rx_pkt_hdr1 *) skb->data;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-pskb-pu=
ll-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com?part=3D4
