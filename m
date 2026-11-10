Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96966606A321
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 04:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=qbkRwVF+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4rRzF5+
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67CC3407C7;
	Tue, 10 Nov 2026 04:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RA6Vu8AdtRh6; Tue, 10 Nov 2026 04:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B5B7740762
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794284607;
	b=HAIYVnnUK1IuE0kThBY44ejIs01S7ZpATjz9m70AM+oxt0vvVfaeS1JXmIyugl0egtx1
	 ubpk00w++5WfveESTsCXw+o2u2cOthj1DQrt9OV+5d1o+JE+9YDzXdeLUbGcfsa/OdBX7
	 HezXi6NgXIYcFXkVEEJCtL+C0rYJVY/22awxDrXAH5HhC8zRDfGvMe4lfQCIGIIt8MmDz
	 IODeH7YBdm1ZeiMRr3Yj+EUxaZ0hr+Is5O0xqUpb78AagSLGaY2N4gCUmeKb1a9DgzLo9
	 7bQM7zLq8VasxxiDMFauttw1nPn4+l0lOJ+I2CCu4yQC2mzObvidVG9WgPZNkgWOJPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794284607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=FOCp646UUau/69UiSJ9TTbSvbP6+h/P178s1upowjCo=;
	b=RiXtXSt11VFQohfLroYogDyRdVFh1/Zb47FIwhufhefGRFKbyj9E/wdjutHgwOE0sUYV
	 k0ZbIxVdcRotxmXHYRkjKWarufIdEIYVtY+eTDwmK3j8Bml7CzpKCU7n40TbIEXBa11dP
	 j8Reg7C8pUOqUE08nmqFILLlyX7OGEfhjH2sHeKSaZcNM3IFoIU+x1jYCrg5YZImR+Uri
	 JPrdCrFPi2xjgb9c9v7I+2GZbg53vVPBypDbKayppchBLDDyUyp9wI7Rnx1fSfKuzFF+t
	 2N0FjqlryiVhJvMam/szn1kR+iPe/cxIphhPRpMPD4vVkE+nj0WoAVMAvL3GCBZVvUw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794284607;
	bh=FOCp646UUau/69UiSJ9TTbSvbP6+h/P178s1upowjCo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=qbkRwVF+roto7Dn1xsroLSEvNN8S53iYVIZRAm0/z67B/P0J7jd+wx6brRQUe3vyU
	 sHxqrtoILTxondLktIXrvjXuCSe/TkSr5z2rlDogWWAfHqRwzWC9t5IhfuREqaJWO1
	 GsfP1J6D5MNXkx8z/Z48dJyaqzT6hamBXPOktl5yvKJTbYuYsu0lPYxVHehtmH9h2T
	 AuCjrR8bxHGRDEEaRca7odJBO/79j5UnAhIgWLM/JqbZTRPDnyCMxm4LizRHVQFYUr
	 tfGPmSElKvNVW2pOJ0j0lBYp5sYqRnc3/RF7idkkHPhcMltZF/ZBSfb/P6I7cHxyGM
	 NGPCDbMNGQ+CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5B7740762;
	Tue, 10 Nov 2026 04:23:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 34BAB31F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C3664008C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:23:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sst-V5qDF0an for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 04:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 375F540061
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=O4rRzF5+
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 375F540061
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 04:23:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A3F361DF0;
 Tue, 10 Nov 2026 04:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D051F0089F;
 Tue, 10 Nov 2026 04:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794284602;
 bh=FOCp646UUau/69UiSJ9TTbSvbP6+h/P178s1upowjCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O4rRzF5+Qkzd2jxK+Zvt102FP9LqDztfp8EI51wc8rCOkQsMeLTVKDbApLtvAqVy4
 3WuJetaFqvf/PgBqlxoOEbjieLxhXitm6weCYXQD1m+KReU3oeQuc3WZFnLgDPHVUx
 44Lfur2Mr4NtRrlU6CPCwkntq4nNndNyhFEKTnSJhIVKl1UCv9mB1FXgx1ThPfWn5s
 gOC/6ikErZP7z80cxxzRg3E4I3sHO+kHJSYTuEf9mMk2mrq91ZApyywPfsDQNiL07f
 ZHMsj4xl4T6iQhH7Bki3Q+qP0MKBoiN5GIN+RHRkSXLb8qNb47z9seJ6j++gjH4DT2
 AA+doALhlfVcw==
Message-ID: <sashiko-outbox-206188@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 11/15] ice: set skb RX metadata from the skb
 core extension area of xdp_buff
To: "Tianyi Gao" <tianyi@cloudflare.com>, bpf@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:23:22 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] ice: invalid page dereference and page leak in
  ice_clean_rx_irq() [1]
--

commit ba151a63223661db4511ce1634b36c26afe91c8f
Author: Tianyi Gao <tianyi@cloudflare.com>

ice: set skb RX metadata from the skb core extension area of xdp_buff

This commit populates skb RX metadata from the xdp_buff skb core extension
area on XDP_PASS in the ice driver and exports xdp_skb_ext_to_skb().

> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethe=
rnet/intel/ice/ice_txrx.c
> index a2c7c4962882d..06a1a5fdc43b7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
[ ... ]
> @@ -1041,6 +1042,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_=
ring, int budget)
>  		continue;
> =20
>  construct_skb:
> +		ext =3D xdp_buff_skb_ext(&xdp->base);
>  		skb =3D xdp_build_skb_from_buff(&xdp->base);
>  		xdp->data =3D NULL;

[Severity: Critical]
This problem wasn't introduced by this patch, but clearing xdp->data before
checking whether xdp_build_skb_from_buff() succeeded causes an invalid page
dereference and leaks the head buffer [1] when skb allocation fails:

drivers/net/ethernet/intel/ice/ice_txrx.c:ice_clean_rx_irq() {
	...
construct_skb:
		ext =3D xdp_buff_skb_ext(&xdp->base);
		skb =3D xdp_build_skb_from_buff(&xdp->base);
		xdp->data =3D NULL;

		/* exit if we failed to retrieve a buffer */
		if (!skb) {
			libeth_xdp_return_buff_slow(xdp);
	...
}

When napi_build_skb() fails inside xdp_build_skb_from_buff(), it returns
NULL without freeing the page_pool buffers attached to xdp. Because
xdp->data is already set to NULL, libeth_xdp_return_buff_slow() passes NULL
to libeth_xdp_return_va(), which translates NULL via virt_to_netmem() and
dereferences an invalid page pointer while leaking the head page.

Should xdp->data =3D NULL be moved after the !skb check (since
__libeth_xdp_return_buff() already clears xdp->data on the failure path)?

[1] https://sashiko.dev/#/bug/linux-d6eb94b5-df62-4b78-9f73-358fdd002a0c

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794281983.gi=
t.tianyi@cloudflare.com?part=3D11
