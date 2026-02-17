Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C0EE68152
	for <intel-wired-lan@archiver.kernel.org>; Tue, 17 Feb 2026 09:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60E4D60AB7;
	Tue, 17 Feb 2026 09:17:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H2iDCzQLPNBu; Tue, 17 Feb 2026 09:17:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8D0E760AF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771319873;
	bh=oIPOfVE6rGYik7uwxJxYi5ddN5nDD55QRwQSnKzQRiw=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EWUxDKJZcKIyP6ahKyO5L9oZqPmfeNeDbs28T4muSTYwKmxQqgUXTsNA8mI8UmUcV
	 yH8mb+TbaZnT5hzAzOGNPHTGIGRrU5q1VY1y8TCKFF+0LIFFerYPL0ORWWc+Om9Uei
	 ZanLQ7PXfywI/uf92sAPvckJkbzKIv7XKG6ZdzMl8iwhvjOaKuVsi79EJKdXvx9vwv
	 /3/5JseRB6xAu7pdbunPEFJlgg9W9SIYNVl+pc3yRFE4xMnkVjumZxZ/V3BsPnQjH4
	 AqG6RUxFnxXPrI1WVvPHWkItNI+MIN4ZztAukKalW3sOsYUF3i38rqlXqR6CIdeEed
	 v5RzOWrX7U8mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D0E760AF9;
	Tue, 17 Feb 2026 09:17:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 018D5206
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 09:17:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1A0260AF9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 09:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7dPV17T2C7VI for <intel-wired-lan@lists.osuosl.org>;
 Tue, 17 Feb 2026 09:17:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=bot+bpf-ci@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DBAFB60AB7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DBAFB60AB7
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DBAFB60AB7
 for <intel-wired-lan@lists.osuosl.org>; Tue, 17 Feb 2026 09:17:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E4E4460128;
 Tue, 17 Feb 2026 09:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167F4C4CEF7;
 Tue, 17 Feb 2026 09:17:48 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============2605647824317503671=="
MIME-Version: 1.0
Message-Id: <2f8cd0a2da03a180287cb70d1f399cfaf80f8c32983605f1716806bf3fe83e7e@mail.kernel.org>
In-Reply-To: <20260217-bpf-xdp-meta-rxcksum-v3-4-30024c50ba71@kernel.org>
References: <20260217-bpf-xdp-meta-rxcksum-v3-4-30024c50ba71@kernel.org>
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
 aleksandr.loktionov@intel.com, lorenzo@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
Date: Tue, 17 Feb 2026 09:17:48 +0000 (UTC)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771319868;
 bh=VD1W6Yh8O0HczIuc809B8SdiqAX3gxVye/bDQIHDEYA=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=NilVoq0jUGjdtQEohI0ld8tCcQ66gDq2r5k2x1mVbRJpyBy9oDH6Jc9zv4NhD0KxC
 s6kYqYc8OelFCQstpcUQ27bT3Vi7NJNobzFjqX/XOAKNqIdFGr80Q+WucTsiMvuJR8
 fe5hSGXxnUZVOCrk3f3cDwPrkpwDLPPeuYPp10PbjGc0/kkn4Zj5d76g/plSpGUJvP
 E9/ce1tZeGWhbjOqvUkKISPqRIZgS3vqF3Mudue/KOpkJfZk6JHrRbUt/Jt38If4np
 Aumit0zQTm6LwUOxapKsyp+gBoHcP/uHEn9MPYBjTC/tEk9nalkYKiBs0aRjsL+zlQ
 zuBpKBRm4bdkw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=NilVoq0j
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v3 4/5] selftests/bpf: Add
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

--===============2605647824317503671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/selftests/bpf/xdp_metadata.h
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h

[ ... ]

> +	struct {
> +		__u8 ip_summed;
> +		__u32 cksum_meta;
> +	};

The ip_summed field is __u8 (1 byte), but bpf_xdp_metadata_rx_checksum()
takes an enum xdp_checksum * argument, which is 4 bytes.

In the BPF program:

> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c

[ ... ]

> +	bpf_xdp_metadata_rx_checksum(ctx,
> +				     (enum xdp_checksum *)&meta->ip_summed,
> +				     &meta->cksum_meta);

The cast here passes a pointer to a 1-byte field where the kfunc will
perform a 4-byte store.  On little-endian this happens to work because
the value lands in the low byte and the remaining 3 bytes go into struct
padding.

On big-endian, the value would be stored in the high byte, so reading
back ip_summed as __u8 would yield 0 for any checksum result.

For comparison, the other metadata fields match their kfunc argument
sizes: rx_hash is __u32 matching u32 *, and rx_hash_type is __u32
matching enum xdp_rss_hash_type *.

Should ip_summed be __u32 (or enum xdp_checksum) to match the kfunc
signature and avoid the cast?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22091902298

AI-authorship-score: low
AI-authorship-explanation: Code and commit message follow established kernel selftest patterns consistent with a known contributor, and the type choice reflects human engineering judgment.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Type size mismatch in selftest code where a __u8 field is cast to enum xdp_checksum * (4 bytes) for a kfunc call, causing incorrect behavior on big-endian architectures.

--===============2605647824317503671==--
