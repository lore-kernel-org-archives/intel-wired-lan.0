Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F8606A31A
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vtKWKfa0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNUcEYxw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDFF660AAC;
	Fri, 30 Oct 2026 04:54:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pgdu-jcgXObC; Fri, 30 Oct 2026 04:54:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E09BD60A9A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336054;
	b=EdIoZpONWLzUffAd1HoHozZU2mQW4WC7Um8yLtNqVYW30Uvaqcj86dxiAGqjHHt+5dl1
	 FKcyNJgsRTQShoyhQMZMmDFyiWwiUTq+XDx0zlYxsAukdxE/3BrQGHXJieQ3HHyzxt6dn
	 VrqbE+gBNgHWwVuyHpGldfhmobPSbGUq4OtWLzd+Qlfk785OAke2z8fDV2xsjAjll181b
	 9steVcFtXKp8wUqlfGX+POyY/gjnr/httsD280Pbpz2/WNDx4xFbtsOoLER2uc455t2uV
	 oi+jC7nd+SbSe2VFF134/M7tfYE2bMz6FRd3SKoDorJjfxm0vChCSFfvaUtKeI4yDAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336054;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=cBex81e0yFizMSixzjyQPt2pLS5gx4uroBWLUxGmOvU=;
	b=VkX4tyP24LILBiM6xdXL7Z/fJTGNZ8fDfv5XT7mj1Yg+K4N4Fn9BidKq9py3boZCArMi
	 g85mqhvzFea/N1rkn6JQcshb6LfHoKXqa+k9FOjiSFiKWBtpqq/U+rMTN0NKb5ADNK2oa
	 G9xQM7XJKwky00IbO2hqUecFIEZNh51cUXhDBOhvc4YqNdjNZCsx+R9fM52m7xoDO3eNA
	 QFVwXICZJy2pEeQDkeDxkJRowHkI02uLiFRqsvdTkuV3HDYzFPXrq3tDygXUd+TgX6rzE
	 za0+3M/E+DcFqF2tx/ybdoFRrxQ+V++hmeL5uK0AZpIPM239KMkQ/i/N5O2TXXk5C/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336053;
	bh=cBex81e0yFizMSixzjyQPt2pLS5gx4uroBWLUxGmOvU=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=vtKWKfa0rvmRDs2OkT2lah6LcYXg7N2SQWy2Orz1+bG/0D1fTf7Lg8igP+Ms/lO+b
	 7dod1yhihJYwcoR7kGmLqeb9JXOqZZPnk/8dv3YoBJ3n3YjUxqBsnb1aekj7LKkAvO
	 nX1C1bL7qBNqzIxZ21P9stkYV1yWdMeJfvDPS6/sPBeC/x88AGWD4kZqkqDxLB1Zio
	 qCnoTkZZaFj36UeQoC/wdAuqNXaPXoT/rVch+WNEiiW1TMcUiOGWXbzd5guRMTkg0r
	 V9yOY6NTZknYO1x752cvc8+XysIXfijlWWBeGA4W0DEMYpqQljVqsVVFwshvr1mlKI
	 iJxUIxfdr5sOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E09BD60A9A;
	Fri, 30 Oct 2026 04:54:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67EC31DE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4AB0D810B8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S0x6rRt1e9ub for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E725810A8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336049;
 b=OoPTjamym/16NbnkYx0X+3bthjktlLO4EGPyz44YsLtqSTGjElKObXbQJIrSSxzp3ZA9
 8QsMpC9P+r1gGS+il4K0GB8Rb0Nmn+cuH3h9VMljbH7bLazYv8wQMao4nMf65/YqVyw+M
 mQkv+eaqqjnKKKuk3RmAXAygzE9HT/cZv3cW2m1pra+PvJfAdhk8lfSALe7J4s7yLjPb5
 DP2XkNH/LDQasYZ3mJVQdutnSTTJSnMr1Qm1MctpzFRO7Hu4+488jdKrf6aiClgFxQxbw
 Bh9abI17zq00I1RZvqlIUFbYSd6/w0e79c8JXwIRost5QsDp4AFMybkQ0biBFuaDakg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336049;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=cBex81e0yFizMSixzjyQPt2pLS5gx4uroBWLUxGmOvU=;
 b=ZJMwQ4UriTVFU0I2iLBoCUl+JAWQI79yO/egEHbmSCgczEw8cVO2v2gniKCpmQUalrS7
 zW094DGWF4OYfTpENgOPMnSTIW40khuve1geI/yzDLl3T9mhEThnBMGYb+oSyN7R7aZyJ
 Nm8rk8IP8Y7NGNPcDZ+T7PMQTHDYK02zAqIav6eIGIDZ3uil5W3Mn+c/Bp4mWENC2wkpB
 4u079Q4nF2JMfna0RFIGSjj0QVGQuadhZPGwzc8IH72ZvzqAGZkr8Y3GblLYPDktrL9eE
 luWnOkkvN9lBP0+I25timRXTdsAzjUIp7BKUN507koJYsAw2lvR+/9vlEouFf9/wR/A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FNUcEYxw; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FNUcEYxw
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E725810A8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B76B8600C8;
 Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C031F0093A;
 Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336047;
 bh=cBex81e0yFizMSixzjyQPt2pLS5gx4uroBWLUxGmOvU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FNUcEYxw4ovXOeWGvmFqM9CVlDR6BH3zr+vjgFhMT6IUk/X3B9GVLLWiy4LsavSED
 hSWtoW7ZKCgqh0K0Et60w6XxOP3XdM+XjUmm7/yHUMODWgsm6WqJ37xYiRjO5oPxsq
 3WQ+FYuo56w1AxeMVk+3kR/WH+NHx8co4JbSS0250YSqIJy8GwW8dW6eH/vxdvcrBX
 K6KWKJfot6pCZdxLTwq9V6A8ddKzq1l+FS66bZSkUaXgmhpJFL1JoN0xN1sfpenuzv
 MIFEKEau7lt5ZNS8KI90ux2W8hiTkmCL9xehjafDzi/VF0xyD+O/4v0GRuLONHUQXb
 UHRquo+9A8Whw==
Message-ID: <sashiko-outbox-190403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 net-next 9/9] octeontx2-af: npc: cn20k: Allocate
 npc_priv and dstats dynamically.
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20260508034912.4082520-10-rkannoth@marvell.com>
References: <20260508034912.4082520-10-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:06 +0000
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Global file-scope pointers (`npc_priv` and `dstats`) are overw=
ritten by per-device dynamic allocations, leading to memory leaks and Use-A=
fter-Free crashes in multi-device systems.
- [High] Unconditional memory leak of `npc_priv` during the `npc_priv_init(=
)` error path.
- [High] Unconditional memory leak of `npc_priv` and all its allocations if=
 `npc_setup_mcam_section()` fails.
- [High] Missing NULL pointer checks for `npc_priv` in debugfs and asynchro=
nous handlers leads to NULL pointer dereferences.
- [High] Out-of-bounds array access due to unvalidated hardware geometry ex=
ceeding static array capacities.
- [High] Pre-existing memory leak of `defrag_lh` nodes during `npc_cn20k_de=
init()`.
- [High] Pre-existing out-of-bounds write in `npc_create_srch_order()` when=
 `num_subbanks` is 1.
--

commit dfbf4e512f9599787a56a7a0ecf88e54713d70e8
Author: Ratheesh Kannoth <rkannoth@marvell.com>
Subject: octeontx2-af: npc: cn20k: Allocate npc_priv and dstats dynamically.

This commit modifies the npc_priv and dstats structures to be dynamically
allocated instead of file-scope statics. It handles initialization and
teardown of these allocations and updates usages across the code paths.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/=
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> index 9a4c2ea5b19e4..15af7b0ccea64 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
[ ... ]
> -static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] =
=3D {};
> +static u64 (*dstats)[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANK=
S];
[ ... ]
> @@ -396,6 +396,10 @@ int npc_cn20k_debugfs_init(struct rvu *rvu)
>  	debugfs_create_file("vidx2idx", 0444, rvu->rvu_dbg.npc,
>  			    npc_priv, &npc_vidx2idx_map_fops);
> =20
> +	dstats =3D devm_kzalloc(rvu->dev, sizeof(*dstats), GFP_KERNEL);
> +	if (!dstats)
> +		return -ENOMEM;
> +

Since dstats is a file-scoped static pointer, will it be overwritten if
multiple RVU PCI devices are probed on the same system?

It looks like devm_kzalloc ties the allocation to a specific device. If that
device is unbound, the devres framework will automatically free the memory.
Could this leave the global pointer dangling and cause a use-after-free for
any remaining active devices that try to access the debugfs file?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> index 15b3f29d60ee9..ea8fc43df0902 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
> @@ -16,9 +16,7 @@
>  #include "cn20k/reg.h"
>  #include "rvu_npc_fs.h"
> =20
> -static struct npc_priv_t npc_priv =3D {
> -	.num_banks =3D MAX_NUM_BANKS,
> -};
> +static struct npc_priv_t *npc_priv;

Similarly, since npc_priv is also a file-scoped global pointer, could probi=
ng
multiple devices cause previous allocations to be overwritten and leaked?
Should this per-device state be stored within a device-specific context
structure instead of a global pointer?

[ ... ]
> @@ -4185,8 +4183,8 @@ int rvu_mbox_handler_npc_get_pfl_info(struct rvu *r=
vu, struct msg_req *req,
>  		return -EOPNOTSUPP;
>  	}
> =20
> -	rsp->kw_type =3D npc_priv.kw;
> -	rsp->x4_slots =3D npc_priv.bank_depth;
> +	rsp->kw_type =3D npc_priv->kw;
> +	rsp->x4_slots =3D npc_priv->bank_depth;
>  	return 0;
>  }

If a Virtual Function sends a mailbox message before initialization is
complete or after teardown, could npc_priv be NULL here? Does this handler
need a NULL pointer check to prevent a crash?

[ ... ]
> @@ -4599,34 +4597,40 @@ static int npc_priv_init(struct rvu *rvu)
>  		return -EINVAL;
>  	}
> =20
> -	npc_priv.num_subbanks =3D num_subbanks;
> +	npc_priv =3D kcalloc(1, sizeof(*npc_priv), GFP_KERNEL);
> +	if (!npc_priv)
> +		return -ENOMEM;
> +
> +	npc_priv->num_banks =3D num_banks;
> +
> +	npc_priv->num_subbanks =3D num_subbanks;
> =20
>  	subbank_depth =3D	bank_depth / num_subbanks;
> =20
> -	npc_priv.bank_depth =3D bank_depth;
> -	npc_priv.subbank_depth =3D subbank_depth;
> +	npc_priv->bank_depth =3D bank_depth;
> +	npc_priv->subbank_depth =3D subbank_depth;
> =20
>  	/* Get kex configured key size */
>  	cfg =3D rvu_read64(rvu, blkaddr, NPC_AF_INTFX_KEX_CFG(0));
> -	npc_priv.kw =3D FIELD_GET(GENMASK_ULL(34, 32), cfg);
> +	npc_priv->kw =3D FIELD_GET(GENMASK_ULL(34, 32), cfg);
> =20
>  	dev_info(rvu->dev,
>  		 "banks=3D%u depth=3D%u, subbanks=3D%u depth=3D%u, key type=3D%s\n",
>  		 num_banks, bank_depth, num_subbanks, subbank_depth,
> -		 npc_kw_name[npc_priv.kw]);
> +		 npc_kw_name[npc_priv->kw]);
> =20
> -	npc_priv.sb =3D kcalloc(num_subbanks, sizeof(struct npc_subbank),
> -			      GFP_KERNEL);
> -	if (!npc_priv.sb)
> +	npc_priv->sb =3D kcalloc(num_subbanks, sizeof(struct npc_subbank),
> +			       GFP_KERNEL);
> +	if (!npc_priv->sb)
>  		return -ENOMEM;

If the allocation for npc_priv->sb fails and returns -ENOMEM, does this leak
the newly allocated npc_priv structure? Should there be a cleanup path here=
 to
free npc_priv?

This isn't a bug introduced by your patch, but in this same file under
npc_create_srch_order():

static int npc_create_srch_order(int cnt)
{
        ...
        for (int i =3D 0; i < cnt; i +=3D 2) {
                subbank_srch_order[i] =3D cnt / 2 - val - 1;
                subbank_srch_order[i + 1] =3D cnt / 2 + 1 + val;
                val++;
        }
        ...
}

If the hardware reports num_subbanks as 1, cnt is 1, and the loop executes
once. Could this cause an out-of-bounds write to subbank_srch_order[1] since
the array size is only 1?

[ ... ]
> @@ -4674,25 +4680,30 @@ void npc_cn20k_deinit(struct rvu *rvu)
>  {
>  	int i;
> =20
> -	xa_destroy(&npc_priv.xa_sb_used);
> -	xa_destroy(&npc_priv.xa_sb_free);
> -	xa_destroy(&npc_priv.xa_idx2pf_map);
> -	xa_destroy(&npc_priv.xa_pf_map);
> -	xa_destroy(&npc_priv.xa_pf2dfl_rmap);
> -	xa_destroy(&npc_priv.xa_idx2vidx_map);
> -	xa_destroy(&npc_priv.xa_vidx2idx_map);
> +	if (!npc_priv)
> +		return;
> +
> +	xa_destroy(&npc_priv->xa_sb_used);
[ ... ]
> +	kfree(npc_priv);
> +	npc_priv =3D NULL;
>  }

This might be a pre-existing issue, but during teardown in npc_cn20k_deinit=
(),
does the defrag_lh list need to be cleared? The list appears to contain
dynamically allocated npc_defrag_show_node structures, and they might be
leaked if they are still present when npc_priv is freed.

[ ... ]
> @@ -4730,7 +4741,5 @@ int npc_cn20k_init(struct rvu *rvu)
>  		return err;
>  	}
> =20
> -	npc_priv.init_done =3D true;
> -
>  	return 0;
>  }

Looking at the earlier part of npc_cn20k_init():

int npc_cn20k_init(struct rvu *rvu)
{
        err =3D npc_priv_init(rvu);
        if (err) { ... }

        err =3D npc_setup_mcam_section(rvu, NPC_MCAM_KEY_X2);
        if (err) {
                dev_err(rvu->dev, "%s: mcam section configuration failure\n=
",
                        __func__);
                return err;
        }
        ...
}

If npc_setup_mcam_section() fails, it returns the error without calling
npc_cn20k_deinit(). Does this leak the npc_priv structure and all of its
internal allocations?

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h b/driv=
ers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> index bf030e40fbf96..ee0bbeba7f259 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.h
> @@ -191,7 +191,7 @@ struct npc_defrag_show_node {
>   */
>  struct npc_priv_t {
>  	int bank_depth;
> -	const int num_banks;
> +	int num_banks;
>  	int num_subbanks;
>  	int subbank_depth;
>  	DECLARE_BITMAP(en_map, MAX_NUM_BANKS *

Since num_banks and bank_depth are now dynamically read from hardware rather
than using strict compile-time constants, is it possible for a device to
advertise geometry larger than the static sizes used for en_map and dstats
(MAX_NUM_BANKS, etc.)?

Could this cause out-of-bounds reads and writes when accessing those
structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508034912.4082=
520-1-rkannoth@marvell.com?part=3D9
