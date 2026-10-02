Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8402CCA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 303536069A;
	Fri,  2 Oct 2026 13:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qhLEYppZYiL; Fri,  2 Oct 2026 13:28:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 64393607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790947699;
	b=mQ7kAPIV/jwkPF8A1BmBnmJoosO/wkV+ZqBiP8Kk9o/LXs7Qj5rUp5Ix4zWWvQJAZham
	 kqqPwFna+CorD+y2paJdRIyDFzN7ZmcCu3lAOTQNOoYtDbIPqMo98qZoFaSMG3Yp+pc7s
	 3BwGZxgmUfOc4vMAFcy+NGBxb2qzzteJc7oCXBrgcVKSHEfXiA72Rug/UfwZzPrGBoBJB
	 IlzDIWdXRg9c/STTqSaliQL8OldbLYSgF3i8VlwfTZgqZTkK8aRJd7h9eqA8ZZlS4A2+c
	 CwoojvE1VQKnDY8rKzYDqYVtpJi0iofITI4Z6AhYJWf7cnvhGHd2GK0t7gwI0DtUjfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790947699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=lMZIdpOmHFk15d8aqFi3eoOlRYxwx0M+jcvhN7YnOJQ=;
	b=Yr/z5/k++LdR1/YvlToaHMBOfKXjfkdOT5Q3+Ca9GhqeUWrh2Q1RY0H24slVZn3jzyao
	 EP6ZMOR6sKAcRI+8mXwCG+9wHJsCs4D6Mwo7tGflLuLYBeNwxF4Jov7z5DJYiXMIJ4XMv
	 DO4YjP+8O8cd/NfSDyxnZXs5DwmaSmnAM/lF2nrmoTtzxaMbFfKORcjT1XXxffhIn13OM
	 EZlZYyISdk5uM16ZMxZee69xLszjcnHWC5ggJ07iAZHtYUftFTQ90XIRfgLUCEoQTkFW6
	 BzrNdJC1HbLZIO3FuUJxiyAy15sZ4B2KZl+w2aKEiqfM1DqkwTKXjDpkPTvyZCj4RuA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e4L/ke2k";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790947699;
	bh=lMZIdpOmHFk15d8aqFi3eoOlRYxwx0M+jcvhN7YnOJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=JH6I04ImvOFSDAjGjEqq3+j8DSn35NdDK+1xXjrJygU7et27t+CVAnPBlb92zLlr7
	 G1T5Fj+9OqMrtWixeeINym69fK6jreNt01a7ed6hsOKDJnJhag2R8ejXRH0y//xOS0
	 eIzfd7lA769URu9LmsYil46m2H18EZ6dt9+OC67cJieegiN6uTDOBIfj6I/rSOJRs3
	 3yZPNvwlveTdNUPHSG3iA37sx6Lis7MQit8vP9NaonOO5LFLAvCD7FpmwRMxtGUU4v
	 cZXmaKEClfuxxpQgpNRxInnXdFMvFQq6iL5eksF7Qy6qUANrFP6WE2+Y5wgkVtv5As
	 7kDX8JayNLmeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64393607F2;
	Fri,  2 Oct 2026 13:28:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3CB5282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D16C4607F2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:28:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfd1IFKuOU83 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:28:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DE3EF6069A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790947697;
 b=rwhmyqlRs1Srp4/Dn7GwBJz+1US1271cYsguC+q8sUqRFq4bjF1/9N9PF3BbPfYL4JRh
 7iLrdv6P9pFO9e8+HpVfsdFXq6YeBKHU1OuiIWE6ZjM5gwop41x3ozabdokYsmPOTxhdf
 Apon3QMcuRgaoQagoh1TlmTBpDEdAjQKbuRKBsIcAt8xuU9ciFRBac430FH5NZa+lYkKO
 VNz2/8Uu51sh84WEwQGSYgj3YIUSvbnYsk/tzqOr6UM3kTnos/bJy+ESpcMf1bwuEHX90
 Jl1aVufZY287sJvb+UjHZ3Yw+H5qmbjFeOktG5wxX2xQIIafVMoDT/boCtchlioDVcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790947697;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=lMZIdpOmHFk15d8aqFi3eoOlRYxwx0M+jcvhN7YnOJQ=;
 b=DWCqMSr53y3XWBxJw6rofyVtOMK+r3fS7jAKoa74CV7RtlTD6f+ywBv2hONND2ClHxIJ
 82pguFXHd6C2PDFoyyJJdesvoNHC0Z3UiOJ4sH6GHXfXZ5925/F+LoS22tkvSGIHahZr9
 ICcb/BijEBq3hknOxVCbWBqHXhdMcrQi2PlPhwrDi5MCqskLqu2cpYqrkdrGKg/CFQZvy
 cvR29tfjKaYDCWiy8CgdnKo0t1xMkAKwCOqVo6fsvEDAvAfm6k71cuyA1bwzeOHDga6CY
 rMm7YcaaIXNmfiLQFdZol3kDbh4VQfxFS88bBog44OqgksVkADSwWfWTbBtDLvMHung==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="e4L/ke2k"; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=e4L/ke2k
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DE3EF6069A
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:28:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31B34400BB;
 Fri,  2 Oct 2026 13:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A771F000FF;
 Fri,  2 Oct 2026 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790947696;
 bh=lMZIdpOmHFk15d8aqFi3eoOlRYxwx0M+jcvhN7YnOJQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e4L/ke2kWQIngCj6a5MIGTBgY3yBKVBMdA2bJeDMEPFnQnovHP03+n0djTL7k3Fu6
 tZlZq7KQCOQoaJhY3jGqI6afKKykHueJxoe4FGZMaupAlVBowMESzbCUpHhX0CSODG
 ItyH0lVOfn7134raTd+BYNFOHZ9uggce8qgFXbq1XmPgyWMPWp8pPrvHDJzFv6m+mR
 ngSGG2HQuxwnjBtYYVspWBGNPHqXkUqjvfaYKHo9qQiHXKV2DsyIP2S8FGYAblL2ei
 25cxwSckd//lEgZSkCf24x0sbQmqsFEuApEm7c5FS+XR5HrVscwOKx0p2lKJeGNvhs
 yyyOMVN+bcvoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
To: "Petr Oros" <poros@redhat.com>
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 13:28:15 +0000
Message-Id: <20261002132815.D3A771F000FF@smtp.kernel.org>
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
- [High] ice: Use-After-Free in ice_setup_mc_magic_wake() during concurrent=
 devlink reload
--

commit 6cf8b519dd4de7f3996192dbff4ffe7afc4d34f8
Author: Petr Oros <poros@redhat.com>

ice: program multicast magic wake before tearing down the main VSI

This commit moves the ice_setup_mc_magic_wake() call earlier in ice_remove()
before device structures are torn down. It fixes an issue where WoL magic
packet wake was not set up correctly because it was being called after
ice_deinit().

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index b121faa345c1a..857ba7d92b140 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5465,6 +5465,8 @@ static void ice_remove(struct pci_dev *pdev)
>  	if (!ice_is_safe_mode(pf))
>  		ice_remove_arfs(pf);
> =20
> +	ice_setup_mc_magic_wake(pf);
> +
>  	devl_lock(priv_to_devlink(pf));

[Severity: High]
By moving ice_setup_mc_magic_wake() outside of devl_lock(), is it exposed to
concurrent devlink operations like reload?

If a devlink reload operation executes concurrently with the driver's remov=
al
routine when Wake-on-LAN is enabled, the reload can call ice_unload() and
ice_decfg_netdev(). This unregisters and frees the netdev.

When ice_setup_mc_magic_wake() runs unprotected by the devlink lock, can it
experience a use-after-free when attempting to read the freed netdev's MAC
address?

drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_mc_magic_wake() {
    ...
	if (vsi->netdev)
		ether_addr_copy(mac_addr, vsi->netdev->dev_addr);
    ...
}

Would it be safer to place the ice_setup_mc_magic_wake() call after acquiri=
ng
the devlink lock?

>  	ice_dealloc_all_dynamic_ports(pf);
>  	ice_deinit_devlink(pf);
> @@ -5475,7 +5477,6 @@ static void ice_remove(struct pci_dev *pdev)
>  	ice_deinit(pf);
>  	ice_vsi_release_all(pf);
> =20
> -	ice_setup_mc_magic_wake(pf);
>  	ice_set_wake(pf);
> =20
>  	ice_adapter_put(pdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002130752.2597=
259-1-poros@redhat.com?part=3D9
