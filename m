Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF2606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=P1Z2gBL0;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MOwF+Umb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8530360A9A;
	Fri, 30 Oct 2026 04:54:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZCIoEL93flrX; Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9AC4860667
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793336047;
	b=cn7jtjQl47BrkI/osZRFZjQ3V9e596zQY43IIR446SUj4yieWXxraNuO9i6rhhlT1H07
	 q/chO9cJtBehSELDy1uKxnzo2iKP/5y5r20QM0oca7jzFEOSq76K2ath7IIBVUjZooMvS
	 FHmGBlzzK5OTNIdFuaA53JNdBvU4HJg1t7AsDMIx9Qhp9lKJ0zBVHH0vDLeP702lHGriX
	 gk+pSM1mphntmyo80KhNXclqh+kcHvec20uzDdK0fNIP+33q83Fo/v270LrHk2seugflB
	 DiqXuHpgPSbZmUcBBGmbK/D+JcwB/kTNH8/w7z4xff+ETlwm4hjgCx+L0istka3z/+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793336047;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=JRdsfpJ2IqxmA70DTVEZFY/7+VSmFcTF4f9qYMGtPIg=;
	b=ikd4Fo5tYkwZJC8HLL/F3AfdVFjn8i24cQC7HQfUM2C61qAW3Al9t4Xi324/U5KXQIg9
	 A8XnPZ0yN8NvIaV+I4xfNrIsItxNWosM49kVPueSJwGaMBdHKcI75VhEGX64AIlhi5fuM
	 W0RmAdEmvpOWE8HbLAHdHxC91FrOEETFHtVRjphWWfkw/UIjmYrQE1R8tqa7MUe2biq51
	 UUqAGpGU2mPEkhsAWaDxvHWE+ZXqjAqNz8+5QZb+Uu6L1vn+DSh2R0GKKzlA6Jp07C+lO
	 ZaLRLkG9l4sz1y/TrZRftX9sguEDhZ0zMq0OjmWXytyFQHTbi36jN+7921e0YfMrOnQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793336047;
	bh=JRdsfpJ2IqxmA70DTVEZFY/7+VSmFcTF4f9qYMGtPIg=;
	h=From:Subject:To:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=P1Z2gBL0e+HZhz6a6U8D4lzZbcveRRLJ1mdVC15YvELGismADxgaAXu4HuVA9ZCJX
	 TJXlD3mm9zH5iL+1VGMKwZFB+YVUsyZ9AEwobMMLXMNujt+bSwGpSle3aB07BlEzqH
	 we+eLZGUAW2ukeZSKqNIobcPnDJZa6y3J7jf6443HxgfPTH6tNPha4r54xGq1u4Xht
	 egSgSIIE2StV+R5rD0NJQQSK8+HiuepbcS1mHLl5wkK9XhKH983nOEmcng/oTCgKM/
	 qEce4wqeph5079/VT8TRguFs12hs++4At7vCDKfalp9uLF4nz6Wft1V5immVSiHJBU
	 lzfO2Qg3HhUag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9AC4860667;
	Fri, 30 Oct 2026 04:54:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF46FD38
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0F0A40A68
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9SoFLmz_T6HT for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 04:54:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 801D840A6E
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793336044;
 b=MmZo9rvR0DZVV+JWv7Nao9N2wOxJfT7XY+uvOcQJXg6u1FNxQpOh/6sRc3+ydTCZp9Nq
 m+KAxlHumjMFRl6y67iaXKdVIxaBRBTQ/eYCkAKmsI+Pgeh7w7mhs4SrvHr9/kth88QgM
 PqM2SgTlAwScM+yOKRddkeXI7yFS5Y8rZ+oR3MHPCOMvVF6DCz3QlI4UkFwGbMYl5fvj5
 98xcYZ5p20KygeTHEISIOjpocieFKtnJV/N0xXGBu17SFcaGF/Wsj6U9UYne/cs957itR
 9/5icZvW7Ewo70a6ZRZSePHggAZDOUduqrgQZl4o3rOeiJG36bQYDNVpwz9lavD1NJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793336044;
 h=Received-SPF:Received:Received:DKIM-Signature:Message-ID:From:
 Subject:Reply-To:To:In-Reply-To:References:Content-Type:
 Content-Transfer-Encoding:Date;
 bh=JRdsfpJ2IqxmA70DTVEZFY/7+VSmFcTF4f9qYMGtPIg=;
 b=P3aNzKdpPEFo6zfdh3P+BukzKn1/z6Ijpgsclt7bfzy/RdemFGvJpPI98EMMJKKyi67e
 u97SGm3iKcJpwkHTbyLFz/7eOK2eylp9C/r3VUzQJ+KlTYIUQBmf07Gi3lwgsRUhXJ4Xy
 TLYBbEDxGeK8LSjAxSP0Gxn6ZyBA4+WNIJRxgrV1opPP0weloDPgs5zNrrYz5cVaOFGv1
 PNHuRwZaN88iRhmgoOy2ndKt1oKLu5bdu1I+mixWkg8skbYQqKUuMR61RzZvint2PIfN6
 3PFIPfku9PrL3OCraQpN8AdkhzCf813unajbbDhakNlZ/UptOYSdLb+s/q3M5kWoWGA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MOwF+Umb; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=MOwF+Umb
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 801D840A6E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 04:54:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 00F0E600DA;
 Fri, 30 Oct 2026 04:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CA41F000C1;
 Fri, 30 Oct 2026 04:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793336042;
 bh=JRdsfpJ2IqxmA70DTVEZFY/7+VSmFcTF4f9qYMGtPIg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=MOwF+UmbfUlutLb7FP/KK8gX2TLqBXS7zCHESWoxQ5JPxOIF2FrYkxYygmaYMUxv9
 mbs8UhUGy1B0Gm1FensBMWl2/RaLms285B3k3sF8FKO/ZlwFlzuwYl4VCS+tq/e0xy
 Ssn6OHaol+/6/80aR90cH+2gJ8TmL8XAIgGSkg+GGY3NqOPNTooP8NHoKlLrV0wOyp
 NcsoysExca/x7XcnRys2HvSC8Ih9CJHg71HsfeEVKYUUGG7PTcBF5aEc0pUDytTahz
 iQ+4bitSFBCbtBl3uSU7qvl6WT95Ty+nXkwa2NIG8Xu479Aa4CXEVlsPMPAf/0mxr3
 s5F9IGpXVVzKg==
Message-ID: <sashiko-outbox-190396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 net-next 1/9] octeontx2-af: npc: cn20k: debugfs
 enhancements
To: "Ratheesh Kannoth" <rkannoth@marvell.com>, intel-wired-lan@lists.osuosl.org,
 linux-rdma@vger.kernel.org
In-Reply-To: <20260508034912.4082520-2-rkannoth@marvell.com>
References: <20260508034912.4082520-2-rkannoth@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:02 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] High-order kmalloc via single_open_size() will fail due to memor=
y fragmentation.
- [Low] Unnecessary acquisition of `stats_lock` in `npc_mcam_mismatch_show(=
)`.
- [Low] Unreachable dead code in `npc_mcam_dstats_show()` due to confusing =
logic.
--

commit 90a879ef1db5083da555645f4bdb9581acc62dc8
Author: Ratheesh Kannoth <rkannoth@marvell.com>

octeontx2-af: npc: cn20k: debugfs enhancements

This commit improves MCAM visibility and field debugging for CN20K NPC.
It extends the mcam_layout debugfs entry, adds a dstats entry to report
recently hit MCAM indices, and adds a mismatch entry to list allocated
but unmapped entries.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c b/=
drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> index 6f13296303cb5..9a4c2ea5b19e4 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/debugfs.c

[ ... ]

> +#define DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(__name, __size)		\
> +static int __name ## _open(struct inode *inode, struct file *file)		\
> +{										\
> +	return single_open_size(file, __name ## _show, inode->i_private,	\
> +				__size);					\
> +}										\
> +__OCTEONTX2_DEBUGFS_ATTRIBUTE_FOPS(__name)
> +
> +static DEFINE_MUTEX(stats_lock);
> +
> +static u64 dstats[MAX_NUM_BANKS][MAX_SUBBANK_DEPTH * MAX_NUM_SUB_BANKS] =
=3D {};
> +static int npc_mcam_dstats_show(struct seq_file *s, void *unused)
> +{

[ ... ]

> +			if (!stats)
> +				continue;
> +			if (stats =3D=3D dstats[bank][idx])
> +				continue;
> +
> +			if (stats < dstats[bank][idx])
> +				dstats[bank][idx] =3D 0;
> +
> +			pf =3D 0xFFFF;
> +			map =3D xa_load(&npc_priv->xa_idx2pf_map, mcam_idx);
> +			if (map)
> +				pf =3D xa_to_value(map);
> +
> +			if (stats > dstats[bank][idx])
> +				delta =3D stats - dstats[bank][idx];
> +			else
> +				delta =3D stats;

Is this else block reachable?

The loop previously skips to the next iteration if stats =3D=3D dstats[bank=
][idx].
If stats < dstats[bank][idx], the code sets dstats[bank][idx] to 0. Since
stats is also checked to be non-zero earlier, stats will always be strictly
greater than dstats[bank][idx] by the time it reaches this condition.

> +
> +			snprintf(buff, sizeof(buff), "%u\t%#04x\t%llu\n",
> +				 mcam_idx, pf, delta);
> +			seq_puts(s, buff);
> +
> +			dstats[bank][idx] =3D stats;
> +		}
> +	}
> +
> +	mutex_unlock(&stats_lock);
> +	return 0;
> +}
> +
> +/*  "%u\t%#04x\t%llu\n" needs less than 64 characters to print */
> +#define TOTAL_SZ (MAX_NUM_BANKS * MAX_NUM_SUB_BANKS * MAX_SUBBANK_DEPTH =
* 64)
> +DEFINE_OCTEONTX2_DEBUGFS_ATTRIBUTE_WITH_SIZE(npc_mcam_dstats, TOTAL_SZ);

Will this single_open_size() allocation reliably succeed on a running syste=
m?

Because single_open_size() uses kmalloc(), it requires a physically
contiguous memory block. TOTAL_SZ is the product of multiple maximum
hardware limits, which can be hundreds of kilobytes. This could result
in a high-order allocation that fails with an out of memory error due to
fragmentation.

Would standard seq_open() be safer here, as it allows the buffer to grow
dynamically using kvmalloc()?

> +
> +static int npc_mcam_mismatch_show(struct seq_file *s, void *unused)
> +{
> +	struct npc_priv_t *npc_priv;
> +	struct npc_subbank *sb;
> +	int mcam_idx, sb_off;
> +	struct rvu *rvu;
> +	char buff[64];
> +	void *map;
> +	int rc;
> +
> +	npc_priv =3D npc_priv_get();
> +	rvu =3D s->private;
> +
> +	seq_puts(s, "index\tsb idx\tkw type\n");
> +	mutex_lock(&stats_lock);

Does this function need to acquire stats_lock?

The stats_lock mutex protects the static dstats array during dstats_show.
This loop only reads npc_priv->en_map (which is manipulated safely via
atomic bitops) and xa_idx2pf_map (which uses internal XArray RCU for safe
lookups). It does not appear to access dstats or any other shared state
that requires this mutex.

> +	for (int bank =3D npc_priv->num_banks - 1; bank >=3D 0; bank--) {
> +		for (int idx =3D npc_priv->bank_depth - 1; idx >=3D 0; idx--) {
> +			mcam_idx =3D bank * npc_priv->bank_depth + idx;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260508034912.4082=
520-1-rkannoth@marvell.com?part=3D1
