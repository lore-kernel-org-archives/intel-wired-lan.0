Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5361C25B78
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 May 2024 11:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82A0760E5E;
	Thu, 16 May 2024 11:59:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fIjJ6Kt6GDeI; Thu, 16 May 2024 11:59:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D343D60E55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1715860791;
	bh=lxraPJ0kQBmog9yFLBLs+AqSY5SM613d7GmJ1DY4YTY=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dx/g76qNrzHbxV46kuwCvF/mqen4JBayhbiL2QJveY+nU1YqkZL9L27So9vEiBa0R
	 4QlG0Ylpt4rFqPaOFPTJuG9jH5qtofl2ee3lKS2i3R9cqH0eEiBn1wlMESg3OPvbW9
	 1A+p+V6Y6dW7jsn81XXpl46uzhyc4NZXgV78Oy4+SDtGj+AMJUE8Bzsa3n8bZsWZff
	 sE9phgkjWJjgc3dZaKbsTMHOk2pmOdgcHB2hJldFqn6C/48ETlot9suItVbS6Qc21S
	 UOPm50e78ienJOq2dD89q/UFK/vFjpgtSZgDK12AccGkzwzjx+xHmuMP2yjAV5uonK
	 t4QB7i8JhfIzQ==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id D343D60E55;
	Thu, 16 May 2024 11:59:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id E508F1BF263
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 11:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFB1A409FF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 11:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vn-vqCCsUONJ for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 May 2024 11:59:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C0F9E40592
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0F9E40592
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0F9E40592
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 May 2024 11:59:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 88E716166F;
 Thu, 16 May 2024 11:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E48F8C113CC;
 Thu, 16 May 2024 11:59:44 +0000 (UTC)
Date: Thu, 16 May 2024 12:59:42 +0100
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20240516115942.GA443134@kernel.org>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-4-larysa.zaremba@intel.com>
 <20240516082713.GC179178@kernel.org>
 <ZkXxVp3hFvczWr8r@lzaremba-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkXxVp3hFvczWr8r@lzaremba-mobl.ger.corp.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1715860788;
 bh=jsj/eofNjP8sdAjFMeOlBKjV9ZvXIiu5BqPSaWoUy+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rtpd81Dvtk3pD15dyALA+g2al7nPqswFU22XDpkzZ3WGVh/vJgKYO4g6EjY9tt6r0
 5lXBu1sZVqF8RNiIX671IQH0GIDMsu1j+Txw8riCjWuly1WjfgoPAmtfFD+JrNekYW
 tN1mj5ak5CBe9RUmBjP0AZRrWsOXS09E7d+GTDeA7KbmO1AqeDHoS527s8rTC+mZKy
 K2udUbMesf7Vs+/dKbzCNf+q17xzRhNH0T9VTFvP4rg/q9n6D8wQ65Nu/mMT6XtugO
 hpUwwiqvkGTCzkzaEE/TE5cFgJ5LqMewNWWkj+3a9Yj6flq+6ODHn9Z1gj7fv13xKQ
 nsHotV+a1eSaQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rtpd81Dv
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 3/3] ice: map XDP queues to
 vectors in ice_vsi_map_rings_to_vectors()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: maciej.fijalkowski@intel.com, Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Magnus Karlsson <magnus.karlsson@gmail.com>, igor.bagnucki@intel.com,
 linux-kernel@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, May 16, 2024 at 01:43:18PM +0200, Larysa Zaremba wrote:
> On Thu, May 16, 2024 at 09:27:13AM +0100, Simon Horman wrote:
> > On Wed, May 15, 2024 at 06:02:16PM +0200, Larysa Zaremba wrote:
> > > ice_pf_dcb_recfg() re-maps queues to vectors with
> > > ice_vsi_map_rings_to_vectors(), which does not restore the previous
> > > state for XDP queues. This leads to no AF_XDP traffic after rebuild.
> > > 
> > > Map XDP queues to vectors in ice_vsi_map_rings_to_vectors().
> > > Also, move the code around, so XDP queues are mapped independently only
> > > through .ndo_bpf().
> > 
> > Hi Larysa,
> > 
> > I take it the last sentence refers to the placement of ice_map_xdp_rings()
> > in ice_prepare_xdp_rings() after rather than before the
> > (cfg_type == ICE_XDP_CFG_PART) condition.
> > 
> > If so, I see that it is a small change. But I do wonder if it is separate
> > from fixing the issue described in the first paragraph. And thus would
> > be better as a separate patch.
> 
> This is not neccessary for the fix to work, but I think this is intergral to
> making the change properly. I mean, before the change in the rebuild path we map
> XDP rings to vectors only once and after the change we do this only once, just
> previously it was in ice_prepare_xdp_rings() and now it is in
> ice_vsi_map_rings_to_vectors().
> 
> > 
> > Also, (I'm raising a separate issue :) breaking out logic into
> > ice_xdp_ring_from_qid() seems very nice.  But I wonder if this ought to be
> > part of a cleanup-patch for 'iwl' rather than a fixes patch for 'iwl-next'.
> >
> 
> I have separated this into a separate function, because 2 lines exceeded 80 
> characters, which is not in line with our current style for drivers.
> And I do not think that this small function creates any more additional 
> potentian applying problems for this patch. And the change is small enough to 
> see that the logic stays the same.
> 
> > OTOH, I do see that breaking out ice_map_xdp_rings() makes sense in the
> > context of this fix as the same logic is to be called in two places.
> > 
> > Splitting patches aside, the resulting code looks good to me.
> > 
> > ...

Hi Larysa,

Thanks for your explanation, this all seems reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

