Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E10ECD6CE
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Feb 2026 16:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 407698104C;
	Wed, 11 Feb 2026 16:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LJ0GnDocIBPU; Wed, 11 Feb 2026 16:40:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B19F381003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770828007;
	bh=YpXiaYnVmqNwidZkJEnmtG0TR4avoOOBSxThfNjSxd0=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DdvZT7oHpHtGuVvZtzup/RwIwAA7Vjn80NY0v7KfZWtgDG+izezSrFMwrtVAXqgpT
	 kEnXBFInmCsp2BPgFjP1GwZLfXS5W/qCN5cwUteYDsplz9h08Co9GvJz/uwgJqtgel
	 XZDE4jgwz+QlrvMPzYOwBD01Xtp71mTPtQjT9wxVgh6ypmQM270CGvaj0uhu9oM8/5
	 PLWnE897UE5ovatlOF4HBi3NdAvRKyrrZtu1cz2XlFq2I1BwwkCoG61qO/YOOw0dYA
	 xMIJyppinwUdrnAMc0I9WLXjRqbZ/22jbqjSDaUuiLgNx+lrr6PO2ceQi+lLr4ic20
	 WQ0MoRRUTDwEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B19F381003;
	Wed, 11 Feb 2026 16:40:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74D4F2EF
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 56E2660C17
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJQGlPtRWztb for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 17:55:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7B1BC60B5A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B1BC60B5A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B1BC60B5A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:55:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1F5074091D;
 Tue, 10 Feb 2026 17:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B82C116C6;
 Tue, 10 Feb 2026 17:54:59 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============0303600655882961055=="
MIME-Version: 1.0
Message-Id: <dd3b3afa8e6e8b17cf8ee8b20afd776ee37341ecefedfc1e921a8171bae29cee@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-5-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-5-e5d55caa0541@kernel.org>
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
Date: Tue, 10 Feb 2026 17:54:59 +0000 (UTC)
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:40:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770746100;
 bh=1LMuUcwE1wyJRGlh8WvdZKXrTG99TlMZf6rQ/9HEioY=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=rjpSXJC1JmdOiDmWcR4D9NYq0bDPcFfqRldKoNI0qo5lSCr2gCHBonjiRmEve4b9I
 izaJSEMN6WOKT4o2P/VuRs/ThZvqbLEfUHeXRDPcxXFh14rsi+3BvuEuS+i1mf0zEl
 5rIgZWUPJpHs34mxL71ktuBrNB5EhQw3pWSHgwZoV6BMmAwV5HlRjiVxMZxuOdqXTu
 yk3XDXot+mqftV5JR38GqFOyayAYVJn6fK/fbw9M2MxCqEGtE79g+yHECytKILajTH
 LVwCWBlEFKGrB3pJPmtrsCuOPh5aQtFNKBDnRIz0r/D4ikuNLTy0a69KB05DN5VHnS
 32N1Gt9gURdgg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rjpSXJC1
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 5/5] selftests/bpf: Add
 bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
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

--===============0303600655882961055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

This isn't a bug, but there's a typo in the subject line - "xdp_hw_metadat"
should be "xdp_hw_metadata".

> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c

[ ... ]

> +	if (meta->hint_valid & XDP_META_FIELD_CHECKSUM)
> +		print_rx_cksum(meta->ip_summed, meta->cksum_meta);
> +	else
> +		printf("No rx_chsum, err=%d\n", meta->rx_cksum_err);
                    ^^^^^^^^

Should "rx_chsum" be "rx_checksum"?  The other error messages in this
function use the full field names: "rx_hash", "rx_timestamp",
"rx_vlan_tci".

> diff --git a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> --- a/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_hw_metadata.c

[ ... ]

> +	err = bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed,
> +					   &meta->cksum_meta);

The file declares extern __ksym for the other XDP metadata kfuncs:

    extern int bpf_xdp_metadata_rx_timestamp(...) __ksym;
    extern int bpf_xdp_metadata_rx_hash(...) __ksym;
    extern int bpf_xdp_metadata_rx_vlan_tag(...) __ksym;

Should bpf_xdp_metadata_rx_checksum have a matching extern declaration
for consistency?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The presence of typos and natural integration with existing kernel patterns suggest human authorship; no AI-like patterns detected.
issues-found: 3
issue-severity-score: low
issue-severity-explanation: Three minor issues found in test code: two typos (commit subject, error message) and a missing extern declaration for consistency.

--===============0303600655882961055==--
