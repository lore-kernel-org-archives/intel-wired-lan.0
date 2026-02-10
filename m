Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61528ECD6CD
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Feb 2026 16:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2D8A561100;
	Wed, 11 Feb 2026 16:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VhyTTXS9zrJ9; Wed, 11 Feb 2026 16:40:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 604EE60B54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770828008;
	bh=/Z89kjNIWY0VINr+vZGPHeTTZHc/93JV5sVKb4+gpko=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCLs5rsSTVvf+5oVY6YL66UuBak9fCdEns1C9wMCCtWYQFLj8d119nBI9kDNcJo4G
	 SvKzEatyOrcygbTOYATM3UcdodWj7dOqmjNPoXlYWdOx97BiQkck38AeOadpyN3i7u
	 WsAWp5c6YHKGpotpf66BfNaClmfJO6OOxmoMmTGivUH/h8czgTt9evsctDL5sGZSCQ
	 Clj7INx0KDTXkssowpOjiAsGDIzJVI88zMsBCKuJ1uh8ltDowN74M/6tDyZ5B9JxYc
	 QcvPRwADHQoJPHrXkM/Ncbqe6BkpBX6I7zei/Dl3oGSHcyeJHeNFoWNxEDjDX31uTu
	 BNP2LeHByOhZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 604EE60B54;
	Wed, 11 Feb 2026 16:40:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0188341
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7EC34411C8
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:55:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x0EGgalVxMI0 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 17:55:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 942B2411AD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 942B2411AD
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 942B2411AD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 17:55:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D18D444E9;
 Tue, 10 Feb 2026 17:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E45DC116C6;
 Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============7295902335523839857=="
MIME-Version: 1.0
Message-Id: <8d3fe8a5425f2e6af5a75f8d1a26d1b460719b1e904b6e1499747ca479b73832@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-4-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-4-e5d55caa0541@kernel.org>
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
Date: Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:40:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770746102;
 bh=oakjD26/4tkGvWqhilxMCc4hiHX5ft4jQ4Iq6CfC8Ok=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=IV5HWXkc/FCiRpLej35EorMs268YVetMhHEcMuM8RZrQDwNon4ujlVriIsWMItPQO
 EqpPqMEeYxMCD6O4YFIrEvdJEAaFfqIGPwZOjfLqaxtmbteFvtM06iSeex9Dz5XBgO
 eId3ASq6UbrOQNwrEjse/Tdi30l18VlSWm7BlPWh5mf4t33MAhtXT3IbgjW51LF+r9
 vzEBdcZkI3eZTjdO3Q29eABxls3qZxt/DDPJl5+t8fLfEvnhAh5SbzAkjEx5m1VN5S
 rM53+ku47GAnrwJMK4bvWMODcdVtJF+2hO0GTGelBaK5cYQfywiYVchoItLmFSR3p/
 OS8Eizj1vbL9A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=IV5HWXkc
Subject: Re: [Intel-wired-lan] [PATCH bpf-next 4/5] selftests/bpf: Add
 selftest support for bpf_xdp_metadata_rx_checksum
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

--===============7295902335523839857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index 09bb8a038d52..ef6a5584a187 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c

[ ... ]

> @@ -98,6 +98,7 @@ int rx(struct xdp_md *ctx)
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
>  	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
>  				     &meta->rx_vlan_tci);
> +	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum_meta);

Is there a missing extern declaration for bpf_xdp_metadata_rx_checksum()?
The other kfuncs used in this file have extern declarations with __ksym:

extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
                                         __u64 *timestamp) __ksym;
extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
                                    enum xdp_rss_hash_type *rss_type) __ksym;
extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
                                        __be16 *vlan_proto,
                                        __u16 *vlan_tci) __ksym;

Without a similar declaration for bpf_xdp_metadata_rx_checksum(), the BPF
program may fail to compile or link.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The code follows standard BPF selftest patterns and appears to be written by a domain expert familiar with XDP metadata kfuncs.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Missing extern declaration for bpf_xdp_metadata_rx_checksum kfunc will cause BPF program build failure.

--===============7295902335523839857==--
