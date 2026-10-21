Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459CD606A33D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Oct 2026 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=JjfwxUmG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=epYyEUIG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D0A06074D;
	Wed, 21 Oct 2026 12:31:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sdxHzJh-QDAN; Wed, 21 Oct 2026 12:31:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11746607E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792585918;
	b=Y/sEr5gmLLrfp/kt+TSUdB2IiGDffn8xG2qOQZxFCSbln3b8qpgkG52DIlacXQG+xoSK
	 sxlnovZ/N1Qf6/Pbs/9D+sJ8YV+6mgkAKpVAETyNPkzzKqaEAIcpUrOJrwJ1qX6Tkv66R
	 5JG1fgCAJQUSAbsCZW/X3lK7fEL+6mEvWtEZLRn19wMziMpEHFZkd9fiVsF1jmub4IPRe
	 9GuU4wR1fwwmOAVXITTNMJWzZQKcqMemquL4WE7svKQvrQTnxqKG83fPSxYcI+Ry5Wc44
	 WN4etO2J675FtZCWCUH576MePYPM4LcmnV41qJFTD5QNXXACAhkBfqkl4B4dtiYyVsg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792585918;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DvokbbwgUedu+R/7T0+nvoQgtbpEqoqXXbDX6qN/PMY=;
	b=h3u5gpesakag/3jNTU+0Vqfb4rbYnXM4EDu/pa9Xg0MUcCRFK8UGZOwj+JR2vvlO8zVg
	 gtUVGKIX17TYGylYeK6mJcqAHz8md6n4N7tyRoUJPY6kMHj/g7k7NfLG3pwwmh6briGpN
	 Jz96rvlnMFyZrvsjMTZ6SgFSdCtjsUBEKtf7Qmv21XZzv/CY73L167XkvPiuLBsoi+C7j
	 kzTjZ46OZiSELhS5dnX/zsX+AOLkKPfQo9uNPh+BYwCAuAUyTf4cwjSmg2W1ntOuCPVJN
	 96WMfb0q9mU+WWBEh/9+vQs2v23zGu7OKsKRD1MqQipIx3WrsUDNIdg5oSyaug0Bl9A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792585918;
	bh=DvokbbwgUedu+R/7T0+nvoQgtbpEqoqXXbDX6qN/PMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JjfwxUmGeLOoWsMx11nK2NSnoltEr+c4UDB8/RUggzSwiCNESENgjdI6kZZhSQ6rp
	 ErOyn3Be8nifUhAGaTN5Z3BBgOVpSjr7TGDAWKD2ZnGlLkan6gBLyS2/UwfokG8nn2
	 FzIhOxa3ChY/67GtlI9D05F1Rcr0uDxQeo/JkbEoBJxk1irjSVmBC5rYDlQHEQIbFp
	 aRcmOGEM6V0ntu71GkW4xtw82I8VnMzVRAsNPwa3XHPGCBnVi4olc/WiILmwdOuUwg
	 IJYyPAwilchwfK+tkuN6zSqy4VUJzeBglgcZWjni6KOc67LPqNZ7+hqu2SukC6RDXl
	 98S38W73C5h+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11746607E4;
	Wed, 21 Oct 2026 12:31:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E2CC723A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D4CC0407E8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:31:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gVbkfiKqITp1 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Oct 2026 12:31:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B95F3407D2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792585914;
 b=DFXR+xakQm1W5ZWEMbKQqj91IIrQmynhCjOehuDOZL2FUizqw2TAfRJ2kUeTgIRBCM/q
 exFsqEuL9jrCHv+KPw5RmTBHyshIqKX+VXVfgCLW0bNYdW6a+IAE5C5JF3aLRF4mqejPU
 4PAz45CN6tpvCIjZBLfGucegbfx06pVncWiOI+nRdqZhPK/XPwYDAQXY/rPgKGz0Gl7wH
 /piCad51SbL9LtT9es8oG7Y/HsxcKkMoSetrMAz2cMJ7tf2DbIoULaAywMXbV/OHat3cx
 uMAZ5K+R5cKUfU8DpSwwZOs1Tht4QXwI/HNdO8zt3MuGmdg+n+B5o5ht6dU0Ds7LKfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792585914;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=DvokbbwgUedu+R/7T0+nvoQgtbpEqoqXXbDX6qN/PMY=;
 b=s3iGC/yHowGNNPA843obGaUtUsyOZE93gXhuTGES9plfE9ITmFoe8tfhYBwpvBns4QgE
 9BRqBTUpYJvdfLHyhzPcUeUdaJ8L2zTyUtP+DLt6CqbjDI6nSEt027Kgwcv/qxAWcjNXo
 Or5CDZ56d0CRYhdqRByYs3C6/cY+LCgrxzcBOuBQ5FlZDdZi3HAi6WZ5UJL4hX3hBArte
 eX3Y5e6VaFYC/cR2OOZuRVtjFWGB6kk+xdF/ZphObyUiMe+dwirV7FspVvXlWdPPvNCyK
 Qeb0JIc5ATvWl7IAY7cFOn+xqpijdQ2gQEGYbnZfTVBjFxOfli55SEWtWEKbMABl0nQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=epYyEUIG; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=bjorn@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=epYyEUIG
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B95F3407D2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Oct 2026 12:31:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE6A543EDA;
 Wed, 21 Oct 2026 12:31:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6B61F000C5;
 Wed, 21 Oct 2026 12:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792585913;
 bh=DvokbbwgUedu+R/7T0+nvoQgtbpEqoqXXbDX6qN/PMY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=epYyEUIG4tu03eofkyY8ffP5iSgRwFlbkSzO7dMBI03AkEcjJ3sjmXW4w1pbNGMM2
 8Ul5Zs3wpcQ+hemNNGjErsL4dZWW45c+X+09BatBwRn1vVyv+tsHYNvlhwl0dLobmN
 LLn29m6l0VzaE1JgUW+KfYS1V/02xpsmZfeoMmx0wZXcVoIavS49RWvecoWP7rvFN9
 pLl7naO3NIyEZlV8iUqk78Eo0v5uUDACB6o4lSoOXS7/G37RlfJXB2Ph9x/hgm/3z8
 yLuhQExrFmg/CtxYYo230oix1ktpUmMxK1Re7lEElkr4RGTccb4eupZCGec9DDtMBF
 G/Vwv62Ls+Ehw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Marcin Knap <Marcin.Knap@vecima.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>,
 Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, "jtollet@cisco.com" <jtollet@cisco.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is full
In-Reply-To: <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <atddQ8qN/R1tU1fk@boxer>
 <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Date: Wed, 21 Oct 2026 14:31:50 +0200
Message-ID: <87ld7r6xqh.fsf@all.your.base.are.belong.to.us>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marcin Knap <Marcin.Knap@vecima.com> writes:

> On Tue, Oct 20, 2026 at 07:00:47AM +0000, Maciej Fijalkowski wrote:
>
>> Please don't top-post on MLs and configure your mail client to wrap your
>> lines. Kernel people get triggered by this :P
>
> Sorry for that, I was trying but not good enough...=20
> cannot setup this on web outlook and I have blocked every other client.
>
>> ZC drivers are supposed to break processing and yield cpu to
>> application when xsk rxq gets full. We didn't want to expose
>> particular packet multiple times to XDP progs as that might confuse
>> internal logic of progs. Therefore we drop the packet in the core and
>> let driver side know about this via ENOBUFS return value.
>
> Thanks, that explains it and it makes sense to me.=20
> I will drop the core change and fix the
> drivers that free the buffer again after -ENOBUFS instead.
>
>> Marcin, could you re-iterate why Jerome's fixes were not enough for
>> you?
>
> This is how I understand this but I don't know this code well and I can be
> wrong.
> Jerome's patches stop mlx5e from releasing the same WQE buffer twice
> when a refill is retried. They don't cover the case where the core
> has already freed the buffer on -ENOBUFS. mlx5e_xdp_handle() treats
> the failed redirect as XDP_DROP, skip-release isn't set, and the
> buffer is released again when its slot is refilled.
>
> xp_free() only catches this if the buffer is still on the free list.
> The free list is LIFO and refill allocates replacement buffers in
> bulk, so the buffer freed by the core is usually handed to another
> WQE before its old slot is refilled. The second free then puts a
> buffer that is still in use back on the free list, and the same UMEM
> frame is later published twice.
>
>> Would also be nice to align mlx-5 to -ENOBUFS case.
>
> Will do, I have potential mlx5 fix (this was my workaround).
>
> I did quick analysis with AI tool and it sounds like all drivers have=20
> similar problem and they don't handle -ENOBUFS correctly except=20
> Intel drivers needs_wakup path. Given that, would you prefer the driver=20
> fixes, or do you have any other ideas?

Marcin, FWIW, we'll discuss this topic on the office hours today [1].
Feel free to join! I added a link with suggested wording for a future
doc [2], and asked an LLM to audit the drivers [3].

Bj=C3=B6rn

[1] https://lore.kernel.org/netdev/aqPxxX9MeGmAqGy6@boxer/
[2] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2
[3] https://gist.github.com/fb-bjorn/181786547c4dd8182ba09e23cf394dbe
