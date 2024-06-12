Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F3BC27C75
	for <intel-wired-lan@archiver.kernel.org>; Wed, 12 Jun 2024 20:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A21A740025;
	Wed, 12 Jun 2024 20:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcAGhzbsQA0L; Wed, 12 Jun 2024 20:55:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AF50040135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718225741;
	bh=XmhdQOTe8qhV+aotUJxcaR5uNt4IbHxKXp2lAxtKbI4=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nNlSlHb97avw2Jf3UMDMycn9oZaHWTecfdrQ20ANrrvtiORsNeXQjaeeSKFUdNJRD
	 Nz1mCqzcd2MGKSMAw7jm+L80H/Y0AowsnLEgF5ShCIdahhMNaB7zFzJ/AuTGPeMY7X
	 iEAEd2xj3oGM451GXWwPLNNQO9R2KiduSdq4Os3lo9KWuFohgj7EBV1iSEAu/WeaKi
	 lCQIvj4Ve7h5mlXeNr5k6ARAhmHEWGn2WmWgdhibUQYHvhxUMaRK+/HczH2RIaWIDv
	 zcBu1o0phVxVSu4XECWPyT4mO4WECyjw4BWrBlHZNSxOakw9vJMDtcQbX1uJpDjHvO
	 MAzoQ38nHix9Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF50040135;
	Wed, 12 Jun 2024 20:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 15C491BF3A9
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 20:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0252F60B13
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 20:55:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4q8s2AG23Jvi for <intel-wired-lan@lists.osuosl.org>;
 Wed, 12 Jun 2024 20:55:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5A6CB60796
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A6CB60796
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A6CB60796
 for <intel-wired-lan@lists.osuosl.org>; Wed, 12 Jun 2024 20:55:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 3151561763;
 Wed, 12 Jun 2024 20:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895BFC116B1;
 Wed, 12 Jun 2024 20:55:37 +0000 (UTC)
Date: Wed, 12 Jun 2024 13:55:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Message-ID: <20240612135536.08c2eb34@kernel.org>
In-Reply-To: <8aa33911-5e34-4a03-90de-81f42648ab5d@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-2-aleksander.lobakin@intel.com>
 <20240529183409.29a914c2@kernel.org>
 <8aa33911-5e34-4a03-90de-81f42648ab5d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718225737;
 bh=v1P+P+YFwm6yIg5m6hXLMue0W7Ky6KUxstxWP05Zhqk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=huobXJrg2rfoU2egffD+9hL2uwCgqgJoBhTG4J9RkBp8PdS0klDO8N6Ap3uSb/Dqb
 cW38+BySrYAv+wsgjf1dKGICUM5/EBTxOPaNZ7+ExnWeXuMkIVA8H6cJEk8k3omvTz
 zMbGmdqchem6df/E8jwoxh3jKD4A5MYSIkISfw+/Opw9EydULEIM01v/wEjHhwvjBq
 enZRb8H0h6XlbkDgWjZCsnKqMZ0EKewe25Ef/5rDPK6CihMDf8F4pr7vu8tRXwrbG3
 t6MPLKd5hWWKdce1AfAVmuzcyVSXaN6EZTOLABA4B5kDwQYXG+iFSm4NGrChzVxy/0
 nEChTUmDgMKtA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=huobXJrg
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 01/12] libeth: add cacheline
 / struct alignment helpers
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
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, intel-wired-lan@lists.osuosl.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, 12 Jun 2024 12:07:05 +0200 Przemek Kitszel wrote:
> Given that it will be a generic solution (would fix the [1] above),
> and be also easier to use, like:
> 
>   CACHELINE_STRUCT_GROUP(idpf_q_vector,
> 	CACHELINE_STRUCT_GROUP_RD(/* read mostly */
> 		struct idpf_vport *vport;
> 		u16 num_rxq;
> 		u16 num_txq;
> 		u16 num_bufq;
> 		u16 num_complq;
> 		struct idpf_rx_queue **rx;
> 		struct idpf_tx_queue **tx;
> 		struct idpf_buf_queue **bufq;
> 		struct idpf_compl_queue **complq;
> 		struct idpf_intr_reg intr_reg;
> 	),
> 	CACHELINE_STRUCT_GROUP_RW(
> 		struct napi_struct napi;
> 		u16 total_events;
> 		struct dim tx_dim;
> 		u16 tx_itr_value;
> 		bool tx_intr_mode;
> 		u32 tx_itr_idx;
> 		struct dim rx_dim;
> 		u16 rx_itr_value;
> 		bool rx_intr_mode;
> 		u32 rx_itr_idx;
> 	),
> 	CACHELINE_STRUCT_GROUP_COLD(
> 		u16 v_idx;
> 		cpumask_var_t affinity_mask;
> 	)
> );
> 
> Note that those three inner macros have distinct meaningful names not to
> have this working, but to aid human reader, then checkpatch/check-kdoc.
> Technically could be all the same CACHELINE_GROUP().
> 
> I'm not sure if (at most) 3 cacheline groups are fine for the general
> case, but it would be best to have just one variant of the
> CACHELINE_STRUCT_GROUP(), perhaps as a vararg.

I almost want to CC Linus on this because I think it's mostly about
personal preferences. I dislike the struct_group()-style macros. They
don't scale (imagine having to define two partially overlapping groups)
and don't look like C to my eyes. Kees really had to do this for his
memory safety work because we need to communicate a "real struct" type
to the compiler, but if you're just doing this so fail the build and
make the developer stop to think - it's not worth the ugliness.

Can we not extend __cacheline_group_begin() and __cacheline_group_end()
-style markings?
