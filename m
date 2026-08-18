Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB52BC5DF81
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Aug 2026 18:19:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 878E9810B7;
	Tue, 18 Aug 2026 18:19:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvQKlFehONVe; Tue, 18 Aug 2026 18:19:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7687881008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787077187;
	bh=ETkdxpF0tWteog/KgiT1FsO7wpghpPcJQS69iR4Nkr4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oGDZhCQdsEsUDcK74LDvs04TmHG04PFww5Xhne7T8q6dopXL/4E1HaYP8ffXK26GH
	 lZxUf+G2wq29D/gC7+pKvt3x3dI7MvVYHTSRdgi1lW5e4CC8leTFagmSDVfDahNYbC
	 Q78m/1jsikZ2eyQG2X0fBK3gWtV0v4cwKERFaju2cDfKwTxXD40H9xmmFcRnhqyId4
	 CjxmqdZSEBvh68EFkjkaedOyzQQnIc36tDyTJ6l8F9uzZNQ9CZQzP9g9XXJzkoMYun
	 XwlVyPW7OoZ5uNdFbYBJDsjP/zaCIpX91V/2hMCkns9JJJRWMwTk64MH3igWBjmlAg
	 96lR5D6fgGY1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7687881008;
	Tue, 18 Aug 2026 18:19:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B496F2FD
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 18:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B217040094
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 18:19:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ixqb1nz_T6dS for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Aug 2026 18:19:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0E6E540168
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E6E540168
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Sux8edeC
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0E6E540168
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Aug 2026 18:19:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A778601DE;
 Tue, 18 Aug 2026 18:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5101F000E9;
 Tue, 18 Aug 2026 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787077183;
 bh=ETkdxpF0tWteog/KgiT1FsO7wpghpPcJQS69iR4Nkr4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Sux8edeCFCaJcTjEbYr3gqRoxfK1jSE1/+SPmVdBg0gfzcEYZv7X8zVv+9UEiGGpT
 3vhTFsYy4zlxy9/PdHazRIEdqv0cERm2YiN0kz1mjdr8k/Yy9CMgSQVGe2vZ99nmqE
 cIZpn4lk0O66W3g/6exvx/aQOCx+UUTj4sw9uGR7bIiONOE2c1c98oNfrmtU0Y/Yi+
 mcynAMzj1tH97qegngbomLgMtsNYL26DoBRuluoSfdf8x5GHodQUeZu7fI6YR958Uc
 WkHBjqnw5A88hJF+4GOHo7AcoXBZS8mdA39P7lYnSn/qKNQq4n0n/WXIikyAqZ3f3p
 h5ey7nS4LrDqA==
Date: Tue, 18 Aug 2026 11:19:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, horms@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 witu@nvidia.com, martin.lau@kernel.org, yoong.siang.song@intel.com,
 rohan.g.thomas@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, leon@kernel.org
Message-ID: <20260818111940.2e280a6b@kernel.org>
In-Reply-To: <aoSOau3NuHTLLxnL@devvm7509.cco0.facebook.com>
References: <20260813190800.222527-4-sdf@fomichev.me>
 <20260818162442.3980697-1-kuba@kernel.org>
 <aoSOau3NuHTLLxnL@devvm7509.cco0.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Intel-wired-lan] [PATCH net v2 3/3] net: stmmac: skip
 queueMaxSDU check for AF_XDP
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

On Tue, 18 Aug 2026 10:03:16 -0700 Stanislav Fomichev wrote:
> > Was completing the reserved descriptor considered instead of removing the
> > check, i.e. keeping the length test and doing:
> > 
> > 	if (priv->est && priv->est->enable &&
> > 	    priv->est->max_sdu[queue] &&
> > 	    xdp_desc.len > priv->est->max_sdu[queue]) {
> > 		priv->xstats.max_sdu_txq_drop[queue]++;
> > 		xsk_tx_completed(pool, 1);
> > 		continue;
> > 	}
> > 
> > That would fix the ring accounting without dropping the enforcement.  
> 
> Don't think this suggestion would work. xsk_tx_completed(1) will complete
> the first queued entry, no the current rejected one (completions are in order).
> 
> If it's not convincing, I can repost only patches 1 and 2. Or if it sounds
> reasonable, can try to explain that part in the description.

Hm, I see. No strong preference but I'd probably just add a comment
above the checks saying that we are leaking there semi-intentionally
because it's an application error to send packets HW/schedule can't
handle. We expect user to fix their app. IOW if we can't handle this
well I think it's better to wedge the SW and bump the drop counter
for visibility, than risk HW silently misbehaving.
