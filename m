Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2F6C44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 22:25:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E827B80E0E;
	Wed, 15 Jul 2026 22:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id klZYYVhZVr5A; Wed, 15 Jul 2026 22:25:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 303C380E13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784154303;
	bh=K68CSxTCGAzi7nRLVNdLS1+FYuDfWJYdurucXyw0L8E=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YZ1ZozssJruumZ5RtlsXvwHHKyR8n/Zw5RnalCCxHTiYjoN3HBh3YKectX5HC8Hkf
	 GVr2CohA7oHUhzw628mGUFHhoS9fuJiQ18fs34ZUmci83CZuccFLvnqEQZawqRFkdT
	 T2GEzCbVbcdVyVwx2EO8QGHjjdM6L+aAaSrfYjnU4LqmjahwT4Ty9ZFWJI8onO8jT2
	 FFuOZssvAf6b+14wG0erOxrvd9AquvNtZ3/hN9M9k7y6LAH4FIKfBbpaC4SKgDJoR+
	 eqb/3bSfT+43a5QsNujUmIdKQcyNIyvP4bE7sbXV0DaL2D8qJHQzjzVBF7bn9fHvR8
	 D+iGBVZFEEMkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 303C380E13;
	Wed, 15 Jul 2026 22:25:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 527FF320
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 22:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3807E80E11
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 22:25:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AwQ7HYhlUFp8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 22:25:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 41F9B80DFF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41F9B80DFF
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41F9B80DFF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 22:25:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14D6D6001D;
 Wed, 15 Jul 2026 22:25:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAE31F000E9;
 Wed, 15 Jul 2026 22:24:59 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============0392436415614422320=="
MIME-Version: 1.0
Message-Id: <53cafe8dbb89d70b7aa626bd4819f513026da6764d8e00e0346ef6e2225a60b5@mail.kernel.org>
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-1-623d5c0d0ab7@kernel.org>
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 maciej.fijalkowski@intel.com, corbet@lwn.net, skhan@linuxfoundation.org,
 memxor@gmail.com, emil@etsalapatis.com
Cc: deliran@verdict.gg, jakub@cloudflare.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 aleksandr.loktionov@intel.com, lorenzo@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Wed, 15 Jul 2026 22:24:59 +0000 (UTC)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1784154299;
 bh=K68CSxTCGAzi7nRLVNdLS1+FYuDfWJYdurucXyw0L8E=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=DqgWX7BX4lPLnk3/5P4HRDPA6l6kqseUgXn6bX2/GO5ELsXAl4U6AfeG/rucAGeow
 F7umQJs5FgmDgACEU1t60gedLSKlDVQZgEK6cNuLXQOzUDQeT5kgu/mmfp3hIpGZHF
 jlT0VeybqnVLvzGV9LfMNa/bNqoTbxM390yT5KzcsziYQr4NuMxaW6kRBenUt3g3Gw
 DrQ2Zn62D4AftaH4dOL6Kb/oB6YvZFnXRJpMr7Yygw5KiSWD8VA7LYoMRrWToMYOWp
 9jQUvTJH9aYQgWfZQbzXpug16PENWyvtXDJC91AtiqbJJhWVAQ+OTTTAf/yZC5Wkod
 Y4LcHIvrBRecg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DqgWX7BX
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v5 1/8] netlink: specs: add
 XDP RX checksum capability to XDP metadata specs
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

--===============0392436415614422320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index 9890a30584ba..9bcaa423ad17 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -961,6 +961,38 @@ __bpf_kfunc int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
>  	return -EOPNOTSUPP;
>  }
>
> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer to a bitmask indicating available checksums.
> + * @cksum: Return value pointer indicating the hw checksum value.
> + * @cksum_level: Return value pointer indicating the checksum level result.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + * ``XDP_CHECKSUM_COMPLETE`` | ``XDP_CHECKSUM_UNNECESSARY``
> + *
> + * In case of success, ``cksum`` contains the checksum value calculated by the
> + * NIC. ``cksum`` is valid only if ``XDP_CHECKSUM_COMPLETE`` is set in
> + * ``ip_summed``. ``cksum_level`` contains the checksum level reported by the
> + * hw. ``cksum_level`` can be considered valid only if
> + * ``XDP_CHECKSUM_UNNECESSARY`` is set in ``ip_summed``.

Earlier review of this series raised the case where the NIC reports
COMPLETE or UNNECESSARY, the XDP program then modifies the packet and
returns XDP_PASS.  In that situation the reported checksum is stale.

It was noted on the list that drivers today do not invalidate the
checksum in this case, they only stop reporting COMPLETE while an XDP
program is attached.

Would it help to document that expected driver behavior here (how it
works today versus what is expected), and possibly add a kselftest that
checks it?  If this is handled in a later patch of the series, please
disregard.

> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-checksum available for this frame
> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     enum xdp_checksum *ip_summed,
> +					     u32 *cksum, u8 *cksum_level)
> +{
> +	return -EOPNOTSUPP;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29453967825
--===============0392436415614422320==--
