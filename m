Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3D606A32C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 30 Oct 2026 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=32XW0TzE;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QjMA/2B8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2076810E6;
	Fri, 30 Oct 2026 08:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yP821rKDu56Y; Fri, 30 Oct 2026 08:47:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED0B8810EA
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793350077;
	b=H04m+kRwzQgCGZsnbtX7ckceXv0aRXZvs4//7ydIMI3NzJsJojaSiLBlIHJGiHnFicAN
	 6z2Lg3e3Q41G6wXen73z0TzbiJzr6E9L5JJhHlgwkN/yv3bPy9+qywMageaEYyUQRce8I
	 +UOrpX0kR25BYt7PffjhqbAJ/ohX2QVGIjM6BsBH0VwHeagWUaE/C5njkdZNHRQoioTit
	 VcjgmDz1fKUL+QACWeqq9NNyUMR0Kc5afYA0fASgn/dlC8HtDMyXcFANR8dRJdUwEvkbc
	 XJUvtPwy6NF8JE4gqHHhkC7OEj11yXdRnmUC3kOTsLvEX0PGFDj95mnyqM6Xfo7aPVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793350077;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KrD/LT25yUr4hzgtq3ozTYQoswHyYhMKqnTj9MrA7yQ=;
	b=j+HAew4xxFMLSv5WM5zXXYaFbvyiswGDshWbKOPUlg7YjvRlgR9gI3uODLeLcx3TmKm6
	 /TROD1DLV9xQx9smFFz3O11utEXqWCrkjWe4hHmjoocksBitxiopfIb69N0jMyRQyT5cr
	 hNzPHYvmsNwcXaWQD5Ctl3Y3k6dCbyqiH8WosxVR14d15jM2z7v1vCOwb12z6lTItreS1
	 jt+zfuTeKWYxtZvVic4+hBd0BgFhM0IEX6vsRR6ZR79egLIx2YxI5xIJJ7d+5HTe+XlJk
	 oif/jrLnfzNquoWIUKcQd+ZzBJafTxDoaEjuWWAPETsexWNVsFaHMLAja+xJ5Zc8ihQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793350077;
	bh=KrD/LT25yUr4hzgtq3ozTYQoswHyYhMKqnTj9MrA7yQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=32XW0TzE9LjlVpynTTw3FpTgO11iiM76sXU2VLdqon/FJNYMG3xn9TODUcLcTuCmO
	 IC5FkwEaWFzuLbyfc5F6Vra9Jn6qe8x2mU291/gKeTlLG3WxjVzUR+Nttym4U1W0vf
	 PtxX6uASlOGGUJDXAEXC0Tprc4YOPXVArbGUXhq2xVfChOXGdswNx5Syab+XFaRLe9
	 5L3r6Cd3pnUjwcbZUVNefrkJ1hlZJy8WaXHpMtqAc2FBSlWe3Bw2jWzopd64ulF52D
	 w+UJ8+a6PBWe8u1Skyq4I6d4rHMeprNP05OHyZA4e0psSbiuUeTvBGQr36wSLqK7nQ
	 SIYbJPavC/T+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED0B8810EA;
	Fri, 30 Oct 2026 08:47:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 89945473
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 08:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A93040AAB
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 08:47:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id loCzjn0yMVbn for <intel-wired-lan@lists.osuosl.org>;
 Fri, 30 Oct 2026 08:47:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6209B40A91
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793350074;
 b=UBkBTPtggBFkbzPQCgm0fogvoeFv5dkRNPgt2sOHIXymG8iBAjQMvDibHmMi5xBpY04T
 0c7SybhX2jIVGPRoTF4jYGFrEt/z4m59vnZM3uqjJSDY4pyFH46SchRzg1G6fdKtP+az5
 Z8+J3VL8jBfSY+WH6ljDe6XQm0MBRyWJTIzBfCn7YadKVUY8UOZSYTeuvicWLeREBrvZG
 xEZPqxCJz47vwL2zt6moP8gZX8hIKKu5o201/sMPfHyE7/kv3N1KZ0FdUnbl59SMpK0hU
 fspsRN1GC3LlUIqMdohSy9PnpHvRQw/HQr1hGN7ogU4J1Q4OxbkQoH0DkXFlqyzzSRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793350074;
 h=Received-SPF:Received:Received:DKIM-Signature:Content-Type:
 MIME-Version:Message-Id:In-Reply-To:References:Subject:From:To:Cc:
 Date; bh=KrD/LT25yUr4hzgtq3ozTYQoswHyYhMKqnTj9MrA7yQ=;
 b=aFOsgokCQWDxM6l/uJI64r3+dIdSQbxDaePYKH4vctb6V5nc8eUp5uqZyUozxuMgxh6O
 f4xlCjYco1Oja1enMWMzXwaY9VA88pmyhWDFVmG5L6h4jL5dvsdep+u4ZTPN3gFs6w55r
 SSXkmQndk3ZHlP249sT0nZLlW97iM9vg5TKTYtlV0jHjutKbH8BKh+WVeviesKpCmiwdL
 9cKAdrHVXFyb/vWCkEdJ8X+JUnkT4Ep1h6J9ijFUR1d0cW6Cqk+9ZIlKATTbLc399IX2N
 wTIj6b09/CsQL8QhMOp8T11beHWbw+68yR40+Luq9fwYB2PTuRQwJXlj8VJTVnHuFLQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="QjMA/2B8"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=QjMA/2B8
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6209B40A91
 for <intel-wired-lan@lists.osuosl.org>; Fri, 30 Oct 2026 08:47:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E2C960619;
 Fri, 30 Oct 2026 08:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8B01F000C1;
 Fri, 30 Oct 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793350072;
 bh=KrD/LT25yUr4hzgtq3ozTYQoswHyYhMKqnTj9MrA7yQ=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date;
 b=QjMA/2B8CZscQfaFu/WT/U6Y2M4NWtO4+THO4uTPFwCSiZ1smfQcK0uUxM4zrg9Vb
 LqswBte6CIMZ2ITHE67rlkTTB33tqXHR1JIa9KsVGLgxQd5EFYsQMyX+iFqGQLT/qe
 /giQal94WXwHFMPz28VqsVj/Bu1RG8X0FwmqEsYZe1h5Cb93gu9P5KmZ5B79A4FimV
 24IF9UBSwNFykEF1OSWahsjUocfMdi/tzsrj8DxUgIkVritNttSW5oBlqb5X7q5UK2
 doJVCkexnpQ/EQ4EJKCTaBSj/5CVv6fbThRkmpbjyUrY7X85S/84vYPTxrOtk4Y1F5
 9L1CdTdw7Oh6g==
Content-Type: multipart/mixed; boundary="===============2292663351581088568=="
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <36d13f061c48206a13e7a38cb846f4c71e0a15fcf0459ab56a2b01f67a57172e@mail.kernel.org>
In-Reply-To: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
References: <20261030-xsk-zc-rx-double-free-v2-1-cf01d4a9f3f7@vecima.com>
Subject: Re: [PATCH bpf v2] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
From: bot+bpf-ci@kernel.org
To: marcin.knap@vecima.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, sdf@fomichev.me,
 horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, jtollet@cisco.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, marcin.knap@vecima.com,
 joshwash@google.com, hramamurthy@google.com, sgoutham@marvell.com,
 gakula@marvell.com, rkannoth@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 mason@kernel.org, ihor.solodrai@linux.dev
Date: Fri, 30 Oct 2026 08:47:51 +0000 (UTC)
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2292663351581088568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xsk: Do not free ZC Rx buffer when the Rx ring is full

TL;DR: Commit message only: the code change looks correct, but the "freed
twice" claim seems inaccurate for drivers that free immediately (i40e, ice,
etc.); only deferred-release drivers like mlx5e are affected.

>     xsk: Do not free ZC Rx buffer when the Rx ring is full
>
>     When an XDP program redirects a zero-copy buffer to an XSK and the
>     socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns
>     -ENOBUFS to xdp_do_redirect().
>
>     A failed xdp_do_redirect() leaves the buffer owned by the caller, and
>     most drivers rely on that: mlx5e treats the failure as XDP_DROP and
>     releases the buffer when the Rx WQE is refilled, while i40e, ice,
>     ixgbe, igb, igc, stmmac, idpf and others free it themselves. The
>     buffer is therefore freed twice. It gets reused for another Rx
>     descriptor, the second free puts an in-use buffer back on the pool
>     free list, and the same UMEM frame is later handed to user space
>     twice. ixgbe and igb keep the buffer in the ring on their need_wakeup
>     -ENOBUFS (XDP_EXIT) path and run it through XDP again on the next poll,
>     after the core has freed it.
>
>     Leave the buffer with the caller on both the single-buffer and the
>     multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already
>     do. A few drivers relied on the core freeing the buffer, so make them
>     free it:
>
>     - i40e and ice consume the descriptor on XDP_EXIT without freeing it.
>     - gve DQO counts the redirect error without freeing the buffer.
>     - octeontx2 returns false on a failed redirect, so the caller goes on
>       to build an skb from the already freed buffer. Free the buffer and
>       report it as consumed instead.
>
>     Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP
>     zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up
>     with the Rx ring. With this change no duplicate frames were seen with
>     striding RQ on or off.
>
>     Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")
>     Signed-off-by: Marcin Knap <marcin.knap@vecima.com>

The changelog says that for i40e, ice, ixgbe, igb, igc, stmmac, idpf and the
others the buffer is "freed twice" and that "the second free puts an in-use
buffer back on the pool free list".  Is this accurate for those drivers?

All of them call xsk_buff_free() on the redirect failure path straight after
xdp_do_redirect() returns, before any xp_alloc() can run.  xp_free() starts
with:

    void xp_free(struct xdp_buff_xsk *xskb)
    {
        if (!list_empty(&xskb->list_node))
            return;
        ...

and the xsk_buff_free() from the old xsk_rcv_zc() err label has already put
list_node on pool->free_list.  So wouldn't the second free simply return
early here?

For a multi-buffer frame, xskb_list is already emptied by then, and the head
hits the same early return.

The corruption described seems to happen only where the second release comes
later, after the buffer may have been reallocated:

- mlx5e releases the buffer on WQE refill.
- ixgbe and igb keep the buffer in the ring on XDP_EXIT and run XDP on it
  again.
- dpaa2 calls dpaa2_eth_recycle_buf(), which hands the address back to the
  hardware pool while the buffer is also on free_list.
- octeontx2 builds an skb from the freed buffer.

The code change itself looks correct.  Could the changelog be reworded to
name the drivers with a deferred second release, or the reuse after free, as
the ones affected, instead of the drivers that free the buffer immediately?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41025962641
--===============2292663351581088568==--
