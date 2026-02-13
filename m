Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C657EEDF176
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 16:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65F5041DA6;
	Fri, 13 Feb 2026 16:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJaxs7UMBDx2; Fri, 13 Feb 2026 16:00:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AD25441DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770998406;
	bh=X2hWEHD4qBw6h0mne4GJz9DJL66RsxRb2Jyry1yzxCk=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D6HVvl9wCWMeUULNgdrABOe6+cGwRZh1ueqnYK1mRZcO30vadFW1TDCwKenxqKG8j
	 rnK7QFRWUMdXLtv9SQCIpGenPD6Nn0GX20aK1SJQO1Td8mObbuY3WXXDRLyTTn7SwW
	 CjcRYvsNuUE5x4LuUefjvPP6YrXbVFHm+cdROgA747HZ9dy18bM+BXtpqcA8XXC7dz
	 NWJLFQwNooUs3yHu28rsDoc4NWZ8xROb8h9m3Z5ZxbRA4sF5BGD41DkX+oGJeifMKQ
	 uCynFoTN+6V5vrJBjIPbD/Zrh320hbcUlXoc7v8bGqvQPFAMV4s07Xj+zcnZCO2awq
	 X1j9pZY5GO3/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD25441DA5;
	Fri, 13 Feb 2026 16:00:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7383255
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 16:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E121481FD6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 16:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K8I3xP3Nxq6W for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 16:00:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2D7D981EC8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D7D981EC8
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2D7D981EC8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 16:00:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D90B438C8;
 Fri, 13 Feb 2026 16:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB3CC116C6;
 Fri, 13 Feb 2026 16:00:03 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============8899739924151597861=="
MIME-Version: 1.0
Message-Id: <72f306ad97f0194172e87121cacbf50a40a9110f002e295a23630b6a3e68ff09@mail.kernel.org>
In-Reply-To: <20260213-bpf-xdp-meta-rxcksum-v2-1-a82c4802afbe@kernel.org>
References: <20260213-bpf-xdp-meta-rxcksum-v2-1-a82c4802afbe@kernel.org>
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 lorenzo@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 16:00:03 +0000 (UTC)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770998404;
 bh=htj5CG4XbCYS2OBEp+fFy3//ixph86NvzHpZtlK6GQQ=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=PO6qpfobnSGAdk5XoP2L4ve2cC7Zh5Wy7K7Wmdk+3PRTmW8WAajrsjjBh4pWvnfVv
 3KsFzXhjYuzkvrKhDcihTH1zf41Aq+mHCe9MzdGusSnn/oYxI2hHhs6zn4YijNmyCe
 N9bNe1fnulUAeaeIXxWGZwfPcP/rh2a+PWqFFJ9Ds5kOKfG55IMcL1idJqGBAI2SNs
 oIH1mDsnm7YKskJQdZkR8HeGtTbUZylkQNIPztLDRcW9wL8PLejA/Zpx6kz7eQy8Q2
 K5xeBlj9aT9VdXxsDfrELCMKpnnqI4327uh0CL2CtTVeAeRnQqKXxLePre1FWofSx5
 me940Cvtj3aOQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=PO6qpfob
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v2 1/5] netlink: specs: Add
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

--===============8899739924151597861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> eBPF program bounded to the device to retrieve the RX checksum result

This isn't a bug, but "in order allow" should be "in order to allow",
and "bounded" should be "bound".

> diff --git a/net/core/xdp.c b/net/core/xdp.c
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c

[ ... ]

> +/**
> + * bpf_xdp_metadata_rx_checksum - Read XDP frame RX checksum.
> + * @ctx: XDP context pointer.
> + * @ip_summed: Return value pointer indicating checksum result.
> + * @cksum_meta: Return value pointer indicating checksum result metadata.
> + *
> + * In case of success, ``ip_summed`` is set to the RX checksum result. Possible
> + * values are:
> + * ``XDP_CHECKSUM_NONE``
> + * ``XDP_CHECKSUM_UNNECESSARY``
> + * ``XDP_CHECKSUM_COMPLETE``
> + *
> + * In case of success, ``cksum_meta`` contains the hw computed checksum value
> + * for ``XDP_CHECKSUM_COMPLETE`` or the ``csum_level`` for
> + * ``XDP_CHECKSUM_UNNECESSARY``. It is set to 0 for ``XDP_CHECKSUM_NONE``
> + *
> + * Return:
> + * * Returns 0 on success or ``-errno`` on error.
> + * * ``-EOPNOTSUPP`` : means device driver does not implement kfunc
> + * * ``-ENODATA``    : means no RX-timestamp available for this frame
                                      ^^^^^^^^^^^^

Should this say "RX-checksum" instead of "RX-timestamp"? This looks
like it was copied from bpf_xdp_metadata_rx_timestamp().

> + */
> +__bpf_kfunc int bpf_xdp_metadata_rx_checksum(const struct xdp_md *ctx,
> +					     enum xdp_checksum *ip_summed,
> +					     u32 *cksum_meta)
> +{
> +	return -EOPNOTSUPP;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21992879200

AI-authorship-score: low
AI-authorship-explanation: Grammar mistakes and copy-paste error in kdoc are characteristic of human authorship by a non-native English speaker; Lorenzo Bianconi is an established kernel contributor.
issues-found: 2
issue-severity-score: low
issue-severity-explanation: Both issues are documentation errors: a copy-paste error in the kdoc (-ENODATA description says RX-timestamp instead of RX-checksum) and commit message grammar mistakes; neither affects runtime behavior.

--===============8899739924151597861==--
