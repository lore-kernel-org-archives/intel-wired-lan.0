Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139E9CA6004
	for <intel-wired-lan@archiver.kernel.org>; Sat, 10 Oct 2026 12:16:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1B64812C2;
	Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iLGcIFGdQj6s; Sat, 10 Oct 2026 12:16:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E8D5B81328
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791634569;
	b=oJmBejV2vkcG3cEeZ6mIJEKHp1WniHefk92+i5t+fbNw35uCcDBQFSY+fvdevfN9CP3v
	 Fq66Rmiamp9OSy8BvmBlNu7rqVOp6kNe9V7ETFomilRKqMq+6rFixpgp19KT19z7apza8
	 a2h82q98LFE4WIZKbTkC91Sbz8cL8hDsLYrlwuMbzVL/tpADPE5L2P+yYws7CAS4KgUjz
	 v8BT3djkXcaVTl20pPTvKQRmSoRdvAeFI+7MbSIAJgJlsA2p8tdQiQBmWwiP/5eIQFRaR
	 mlhZikYuQPu4uKRJnBbiTuhfeh1bKrsNJ8EJBrNlK6U0+buppoSExxLfzEavo7VVoNQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791634569;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=+9IYEx+BguKyLrdquehLmmxg4IjSZ8rPmUmqFszTdN8=;
	b=H3JvBUp6ihtvGreKpzSgvQH+FG1HB3Bw4/T/rWpo7n7YjLD8SK9LJOyytro9Zxn3etFy
	 pzFQ3PJwc6duywgeCHUm+7LkoFttqXVwiP89BnnbUERt76za36SxzfEW6/swGEOP6GwU0
	 Vw06wvgPlj1qtHBe/IebAb4zaU+V2TfN4ae7VjicQkWZ7Kpz6w6ZEOKTW6F6egehhrGGt
	 HuSsUl60Ls/nKekRFWTmr5k/esuwURh/2NrrsvYBpsh6IiPkFUbNmFfdxK9jLrhJQNNx0
	 YWlKYspwLqUwdDhGTL0lXJ+20enUyAvBwtaJ5DZyLQJF2i4GxOI4RbVlPxbfb6jQQLQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791634569;
	bh=+9IYEx+BguKyLrdquehLmmxg4IjSZ8rPmUmqFszTdN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=orF1J4dShCV+WamJcOF+7aQgcBgVerNi1bop24KCevzaDKDtdqoA2BxejdLauqHeu
	 SR6FgQouZmTXcQ8PIXd4/V5RE+CTSDHq20OZCEI9W8Z77ESqPoRMYXXPr7ND4ay3Sg
	 k7eqqnBP6Yd8pIdCvpJSEzOluMdCufa59cn47QTGw8FLLm6mK0nJ+bTS11oFRZGHLX
	 t19DHbHdwtEiKcKuZd+/nAfTQ0jsuLvmehrxCXHswiHGS+fYp7eKjTPeAbV5yxIffY
	 F/GnDavYXI3AyBTBrSnnb3ZmNjkTWO1a8wXMGEt07CiCMi+6Y98+hv41cxhyR7elC0
	 YJ2/m/XkRbFzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8D5B81328;
	Sat, 10 Oct 2026 12:16:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FB0A22B
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 35C7A60629
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nsbId4rP4G4D for <intel-wired-lan@lists.osuosl.org>;
 Sat, 10 Oct 2026 12:16:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 49E1660663
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791634566;
 b=K14j2qcy/1rpVpndJwoRacw013UnfsHiTGzFnEN2sL6W2k357BbsaaQSrpKGfOkHl9dL
 5K/LBCXRnzlBDqDeCUz+g8XiJpaxuPX0WLFvwDmHRxw07kaiXSR9cZKaEGb6FlOYf+fg2
 WOqluxqCSmtaK4SQ7IhXOn0+bW75JLvE0li5agz4Id/rQR/23DtTdfZ5WKOLu6EHBdvqm
 dRnsJsukCAlOCgxw79R6yg4YHWrEL8ANS+b/v2mN+ssImH0A7T2Xc34K9OWL1wZKTwVq3
 DEAuMDfwT3p7D27UWFTX4245fRxhDr77KPZOkSijMVUn5ghlWQwmWe+vJnwHmoFpgeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791634566;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:Cc:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=+9IYEx+BguKyLrdquehLmmxg4IjSZ8rPmUmqFszTdN8=;
 b=EtHZFyZNKZ1myAgVsj83M6qsZqaBButxCAzKLykwOOpguIM7HnE9TFujnIVLlZ1tIowe
 YrNWIfF3ogq0ZkDxjOQBdSy0KR7I1uHSIJGS0zWgCfrI9hgc//1YNkKRkvudIhX53cYR2
 xSuyxMDfeshuCWVxnvGjK3H7DjU6VhjN37D0bhODrx4OKfm77QlR9DnaVfKPVllFJNrgJ
 7fMOSwmxsRhQxuZF16Ect5I8c0KGL9XfbHwHUfDYh807z1nGkHswzZ8Azk/UjfiKvEw4i
 XmKTVVSo3WGxfkQGf7ztE9rAG0+mLC+bbAE+nuG2en8V940LQ0MIa7rv7ywgHJwBaMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n2n1PIA0; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=n2n1PIA0
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 49E1660663
 for <intel-wired-lan@lists.osuosl.org>; Sat, 10 Oct 2026 12:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D34942E99;
 Sat, 10 Oct 2026 12:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473D41F000FF;
 Sat, 10 Oct 2026 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791634565;
 bh=+9IYEx+BguKyLrdquehLmmxg4IjSZ8rPmUmqFszTdN8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=n2n1PIA0Uc0bMg8tNFXg3m13QTePHtgzqW++n4ua/m9R0by4jIDoxUjUa+VWACuZK
 dJK8q8if568BRKo7IJzcX8NSEjzvLZJg+UF4yPhsOgea5gXCGfFjzbn3B0nvRiqgZn
 2vfC08y5l29AzrIfTqkHNxDWMxUrIXzT3kDSOKQjpAn6UAgTGPBc7mD3glxPCTDYLN
 v66i9NSCiLi4YK9rq6KCH3tOW8CB38ig1hJzFz4qZ+yYBmVV1iFfd2QlBafTdRKj2q
 BJHqfa2uhoLnHulqTGSnxUlG81c3oD093Nscf2aiFNUJ4GLJ5AKJlBIk2MqTWCUVHs
 9eLNL1sOvWzEA==
Message-ID: <sashiko-outbox-166496@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 02/14] ice: use shared devlink to store
 ice_adapters instead of custom xarray
To: "Przemek Kitszel" <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261009121433.30347-3-przemyslaw.kitszel@intel.com>
References: <20261009121433.30347-1-przemyslaw.kitszel@intel.com>
 <20261009121433.30347-3-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 12:16:04 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ice: DMA UAF due to missing control queue teardown in recovery mode
- [High] ice: NULL pointer deref in ice_adapter_put() on recovery mode tear=
down
--

commit 298f011950fb287bfb913324af33c969b5683c8d
Author: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: ice: use shared devlink to store ice_adapters instead of custom xa=
rray

This commit refactors the storage and deduplication logic for ice_adapters
by moving it to a shared devlink instance. It replaces the custom xarray
implementation with nested devlink instances for PF devices.

Link: https://lore.kernel.org/all/20260312100407.551173-1-jiri@resnulli.us

> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethe=
rnet/intel/ice/ice_main.c
> index 454fba07d4ecc..6373cd5ac2884 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c

[ ... ]

> @@ -4946,7 +4946,12 @@ static int ice_init_devlink(struct ice_pf *pf)
>  		return err;
> =20
>  	ice_devlink_init_regions(pf);
> -	ice_devlink_register(pf);
> +	err =3D ice_devlink_register(pf);
> +	if (err) {
> +		ice_devlink_destroy_regions(pf);
> +		ice_devlink_unregister_params(pf);
> +		return err;
> +	}

[Severity: High]
Can this new error path lead to a DMA use-after-free regression in recovery
mode?

In ice_probe_recovery_mode(), the hardware control queues are created via
ice_create_all_ctrlq(), which allocates DMA memory using devres. If
ice_init_devlink() fails and returns an error here, the function exits
without calling ice_destroy_all_ctrlq().

The devres framework will unmap and free the DMA memory upon probe failure,
but the hardware ATQ/ARQ registers might still point to those freed
physical addresses since the queues were never gracefully disabled. Could
this allow the active device to continue performing DMA operations on freed
memory?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/e=
thernet/intel/ice/ice_adapter.c
> index 2dc3629d6d0f6..c6301341ccaef 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c

[ ... ]

> @@ -93,59 +80,37 @@ static void ice_adapter_free(struct ice_adapter *adap=
ter)

[ ... ]

> -void ice_adapter_put(struct pci_dev *pdev)
> +void ice_adapter_put(struct ice_adapter *adapter)
>  {
> -	struct ice_adapter *adapter;
> -	unsigned long index;
> -
> -	index =3D ice_adapter_xa_index(pdev);
> -	scoped_guard(mutex, &ice_adapters_mutex) {
> -		adapter =3D xa_load(&ice_adapters, index);
> -		if (WARN_ON(!adapter))
> -			return;
> -		if (!refcount_dec_and_test(&adapter->refcount))
> -			return;
> -
> -		WARN_ON(xa_erase(&ice_adapters, index) !=3D adapter);
> -	}
> -	ice_adapter_free(adapter);
> +	devlink_shd_put(adapter->devlink);
>  }

[Severity: High]
Will this trigger a NULL pointer dereference regression if the driver is
probed in recovery mode?

If the driver probes in recovery mode, pf->adapter is never allocated and
remains NULL. During ice_remove(), the code checks
ice_is_recovery_mode(&pf->hw) to determine if it should perform a
recovery-mode early return or a full teardown.

Since ice_is_recovery_mode() reads a live volatile hardware register, if
the firmware clears this bit after probe, the check bypasses the early
return and falls through to normal teardown:

drivers/net/ethernet/intel/ice/ice_main.c:ice_remove() {
    ...
    ice_adapter_put(pf->adapter);
    ice_deinit_hw(&pf->hw);
    ...
}

The previous xarray lookup safely returned early on NULL, but the new code
unconditionally dereferences adapter->devlink. Will this crash on driver
unload or device unbind when transitioning out of recovery mode?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009121433.3034=
7-1-przemyslaw.kitszel@intel.com?part=3D2
