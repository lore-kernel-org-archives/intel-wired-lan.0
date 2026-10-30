Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324E606A321
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=xqSig5pj;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XazF95TF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052CE60AA4;
	Fri, 30 Oct 2026 04:53:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDS2iDZKUzis; Fri, 30 Oct 2026 04:53:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 37B5D60A9D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336030;
	b=NE/MeObUe8qr9WOK+Y7qNtcUGpHkphe4pPzmnNFoHDTStWqbS2KuzGL8mdPomTo+M8BU
	 4PcpqUPtg/gYeujs7mg72sCQVHTS8qBi93OzFHrHDXxrWfzC22cGkKTeXFBj/uR1N316+
	 6+ccnBqTGsZ1DUAKL341e0BYzDPfO5AJ1EHojgcOGHsHZz8Q9w3YxydbHmo7BoweOZLdB
	 EFa4Tk+0VDJyPU0DzswzFbdry/JWVuABf60LDuXfo4cGXm3ze1r3pZCL/dxxUK7lb9sz3
	 U3wCGcok7s+JF9Pgu5dfflTKGuRcBM8KwTFnDhovq74cQnFYbaqmkGGt7d1+ARey4mw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336030;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=N7Q7nE6qjU6gMqqBtzhUD4/bOBQxK7M4+pmcfP33ye0=;
	b=jJ4/sNrcD2YajIRamFjv2tQwKGycYrdZ1xB4EAMCZZIzSB4V2/0gdWW+zipNpeIGv54Q
	 agAtCerPXVAu9xgb6R4y04GTGJuWHDI3l7WliKdPYMUDi8Lh42cK3mFEXmbHqizPFB9UU
	 niavVRpectEZRN4je7ayl4ziKannBBFeaDZm0AyEeVXmYIL9PHF1XOT+7KDcAqBQZTJtC
	 DoWTGF/x+0NsL4jgT6kah8exDSUn+0nJsHi9Wj2nxK3ciVr+AhI8f6gPePvMTwygbB7BB
	 UbbjCe4oYMqHVeZ5PSIffSP2FDQh5gSb93YyK1FvmCdeAe674oTSrtDR5WGnECLGtnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336030;
	bh=N7Q7nE6qjU6gMqqBtzhUD4/bOBQxK7M4+pmcfP33ye0=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=xqSig5pjF5lNQ81FdTXNg63z6dA3/fsWr95qpw20d4o3H16DNOwkDjHf7Q12zi4hL
	 H74kxNGk8S6AIU7frZXV/I6Koh1H4VAZbscBZtmEASmGdekw71/JZ+gu8g+UDm4ND3
	 1phQhZhfbUYJBHDv8NZnIcAlGkvAfl96uFovdx88WbApLrbz2r1z3/kIrQFhpSvOBZ
	 2J5e5/dOHP5Mns9AOpYhv/rmNDmKyXETQry5EPZTpNA7Km7uahI8EsRmuG6ig4lnSH
	 SZBgkhZnkSdM4sPVUO27N4LqtD8wakt55RuIX7VS4XW8ghP2GOXU2MGyAIngw0ejkJ
	 0RY48KUTrwBBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B5D60A9D;
	Fri, 30 Oct 2026 04:53:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 43F9FD38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 419BD4051A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:53:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7BshxjhizNch for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:53:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 45F50402F6
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336028;
 b=fAy77xLXfPuOWShKv3QixRqAdhUY9igbKxbHJSpCQcqMxEBwuvnNqssirJwPQADS0IQT
 UFvajikqPdnFoeb0LaMwpkeW2tB4p3+F1uhtCs9OFb1k5Kn1X+OnjLywhgdB5BR+TkP/A
 j6CgHKxCDwfNkFh+n/cS2faZjJsBKdjAvUn+QyViLkIXBfbSA/rRSqwvjc9JdgqLnRiIo
 h0YmIfsMd/dO/9l8uh95i38Pil+nWpWSEBtmM7v5DNV2zcd2TpKk6dl6w1d4phDx5K34D
 aFlm3xSLQZgVwsTcjo50V4U1drGneoYK2sne8DcjosWfxOStZk4iaquokuqGDPEMCvA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336028;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=N7Q7nE6qjU6gMqqBtzhUD4/bOBQxK7M4+pmcfP33ye0=;
 b=q2/1m2TRZnjCznVgFjuuJn84LjhSnldST1EsxQ4CGg7LBtT2mV5/RVcQkMKr+08r3pcW
 UnSaeHwvy+WJatyxIog/yvJiSisMah0GwntkPYG6oJIQgNzCPzAJCfmZ5lVYDDJAiUAtw
 B0PYFK1fTa5XsYARTCRwylkNhaozxob3P33OaS2iybneDi49o3HLBs5H1RBpKZcSthE8d
 biNvbqNFFUkmlRGpyQCi79RZOUtBUGYbv/iA/Iy6uWXtH6CCbAz0HVrlVDJ+7GEpm/1wK
 BXij6KYCym2AK1jZh1VtAap3p+xMJ88RVKy4H9rjKG2LSeOGut4jCjE+gQopVV3EBfg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XazF95TF; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XazF95TF
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45F50402F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:53:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 159D2605C4;
 Fri, 30 Oct 2026 04:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AF31F000C1;
 Fri, 30 Oct 2026 04:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336025;
 bh=N7Q7nE6qjU6gMqqBtzhUD4/bOBQxK7M4+pmcfP33ye0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=XazF95TFN4Ugome9BjkotSxq1uOXRjrbbKXtCaYeWoI2fiz1suM+hofX1Ms/2P/06
 qZNTjgRcCocJUvU+SylocEzXsxlTLBACRoBxHnYL7el9dbqnIdlIsHD5iz3lbcHEjn
 NWM/gGbk3fA1tEfu3RC+/l3mBi6eJ/rnp2riuQtennKbipbxrTdqdSD0gqy3WGMVGA
 UQiQqcOswablwqrKXuvMrPUk6nMhcdB4LtfMqkOqod9UFdb7uDuOzM3HmG8NdvJacC
 PVfQBTZQudW9RG0hhX4qyA4B6QkMgad1hYf9DYBqv/IWnSv1E7CsIKqoOlyFZJcGH0
 euFwXXugBE8DQ==
Message-ID: <sashiko-outbox-190345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net v1 2/2] ice: use NETIF_F_HW_CSUM instead of IP/IPV6
To: "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
In-Reply-To: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
References: <20260428070647.777141-3-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:53:45 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Replacing NETIF_F_IPV6_CSUM with NETIF_F_HW_CSUM bypasses the =
kernel's software checksum fallback for IPv6 extension headers, causing har=
dware to silently corrupt checksums.
- [High] Advertising NETIF_F_HW_CSUM forces the kernel to offload checksums=
 for non-IP protocols, which the driver's Tx path unconditionally drops.
- [High] Unconditionally advertising NETIF_F_HW_CSUM forces non-TCP/UDP/SCT=
P packets into a buggy software fallback in the driver's Tx hot path that i=
gnores errors, leading to silently corrupted packets.
--

commit f1566dd32ecb941ad20b193c17ecae7df05ca815
Author: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

ice: use NETIF_F_HW_CSUM instead of IP/IPV6

This commit replaces the IP and IPV6 checksum offload flags with HW_CSUM
in the ice driver to allow hardware checksumming for IPv6 packets with
extension headers. It also removes the mutual exclusivity check between
TSO and GCS.

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 5f92377d4dfc..33f252a6a22f 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -3491,9 +3491,8 @@ void ice_set_netdev_features(struct net_device *net=
dev)
>  			NETIF_F_RXHASH;
> =20
>  	csumo_features =3D NETIF_F_RXCSUM	  |
> -			 NETIF_F_IP_CSUM  |
>  			 NETIF_F_SCTP_CRC |
> -			 NETIF_F_IPV6_CSUM;
> +			 NETIF_F_HW_CSUM;

By advertising NETIF_F_HW_CSUM, the network stack assumes the driver can ha=
ndle
checksums for any protocol and passes non-IP packets (e.g., from AF_PACKET
injected frames) to the driver with CHECKSUM_PARTIAL.

Since ice_tx_csum() strictly parses the L3 header and expects IPv4 or IPv6,
returning -1 for other protocols, will this regression cause non-IP packets=
 to
be silently dropped instead of falling back to software checksums in the ke=
rnel?

Additionally, skb_csum_hwoffload_help() relies on NETIF_F_IPV6_CSUM to
safely fall back to software checksums when IPv6 extension headers are
present.

Does using NETIF_F_HW_CSUM bypass this safeguard, potentially causing
legacy hardware (like E810) or E830 without GCS descriptors to compute
incorrect pseudo-headers and silently corrupt IPv6 packets with extension
headers?

Finally, for protocols other than TCP, UDP, or SCTP, the driver falls back =
to
calling skb_checksum_help(skb) in the default case of ice_tx_csum().

However, the driver appears to ignore the return value of skb_checksum_help=
().

If skb_checksum_help() fails (e.g., due to -ENOMEM during pskb_expand_head(=
)),
could this result in the packet being transmitted with an uncomputed checks=
um?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428070647.7771=
41-1-michal.swiatkowski@linux.intel.com?part=3D2
