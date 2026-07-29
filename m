Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61048C53219
	for <intel-wired-lan@archiver.kernel.org>; Wed, 29 Jul 2026 16:08:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1113480B39;
	Wed, 29 Jul 2026 16:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sv3zxNE5B9yH; Wed, 29 Jul 2026 16:08:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0F4280ADE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785341326;
	bh=xpR48eIXR1Ci0/Y8C1oaWZVWu8i3+nXBnNEaQ1vsjLQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l2uc4XoXpihwVRdPEK1Tvcr7xDQBxcWYOcA22KlD0iResdqBrKmeFnJ8jRbbUUnx4
	 pOCLbct5nWoLaU+05Wpzu7a67oJy5yFmHUJWeX5Z+HoghI617s4rd3KJb1Mj2mIePz
	 uMAg0wWtiVDxieyxvVwndd6YQdEnNkg59KclVWq1JOxCzPWHL2+0htbHTppaHC+AY3
	 ayIl1616a4Ros4yaG2ZNZx/m7YQ+3F5jBXdkLuDuKtULV8WfSj3S8yZUmX2+hYOClb
	 U3RrQ0rCHCfHjNakne4Oka6qHThYk6hvdw7jUwrvncGUw8GvjJiLNOEmE2lMkhs2bJ
	 SxaSGX4L8ck+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0F4280ADE;
	Wed, 29 Jul 2026 16:08:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88CEE194
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 16:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A36F4063B
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 16:08:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRTaIh3D7_EG for <intel-wired-lan@lists.osuosl.org>;
 Wed, 29 Jul 2026 16:08:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::9;
 helo=mail-pj2-x09.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 7C37E402A7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C37E402A7
Received: from mail-pj2-x09.google.com (mail-pj2-x09.google.com
 [IPv6:2607:f8b0:4864:39::9])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C37E402A7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 16:08:44 +0000 (UTC)
Received: by mail-pj2-x09.google.com with SMTP id
 98e67ed59e1d1-38eca9b7114so526644a91.1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 29 Jul 2026 09:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785341323; x=1785946123;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xpR48eIXR1Ci0/Y8C1oaWZVWu8i3+nXBnNEaQ1vsjLQ=;
 b=PZPtA5Vi66uhayfeLoqoZN+KuDVnj4f+tlJbu2PdVtib2VNc7ZwbjTfExbxtP+xQbj
 se4r2owg7zizvmr6mK93eb8L6qGZPbQuhp14eZWLJJh5HmBQJNNKkkt6udThIZXeiMcP
 5pL1jyfZL8/RZ9odepR+Gr/Ib0WGnoLpnzBVfrs1MVDQ576anTExwryG/P56KLNmR2PA
 2tV35bgE6LPzFQSpQdyPXPUeldRCwRoDGIt2Fz3IfbWusxNuZv7II+Yiw3QGpz+djUod
 LhN+REikdOLPfMGpS5B9NxmQpbqiubMXS/Ggje+BDdTO4OR+ylsNlWcc+V6UcgUYw7AA
 Wzew==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxWSALf3+Z73aEpotZwSSxhoAjZawbpHTf3BZbCWS65kw/Q7mviJXA+zLHu+nOiNByfqc8TaTssMnbQRB2N80=@lists.osuosl.org
X-Gm-Message-State: AOJu0Yyk30tOPhM06ENxqLZ3YlsZX23cB/OTQJDj+u9cK3/jf/P4WAEa
 sdGTueR9xJDpNSZ2b9LYdMjB6iIeSg/FThLvxVvk3lHxLmP/ayeDboHz
X-Gm-Gg: AR+sD10LOnOegT+jzUaBRHw/Mr6CjAOu1WMeXYBbb+ih3HQW6TaUDFDD28Dda+6eCC/
 FZam8OltN+rufMZF/pAPr84zaOXa9PfC/eoCRcbz+z8B6R3qXwkmeWfBItZYfQ4egOnGo3sSb+K
 qgzSIn4+u7VnfHoFDOQ5SYHM9RL7t4LHWb47EHI5Rhufrx2Yrsg1MVIUsyYSGTem39paDyOo9G5
 GD16psigpXUu/7HybbGeob2waM1yp7g7grNuEGgNNf/B8uy1r7BSiWQtqgdm1YBPinw8CYCetrM
 IeP5L7tBSQI5RF31TKnhGHQLbVJIreNe7cu6IM6ebvFskPbqPlWCpG+4d/N8MQW4aqo/VR6mTRK
 v9Vs8r0deu7a8syCmCbpaFPYHxKdI60MAO7dI5fmHT/zBwB4QHcZyd3qsy4lNW7uRqf1nB5yNFm
 S/73yBeOg7vbZolRRKWXw5HV0GDDpEqDJR/jNtYvZ1R7fI9W3+6uUwvw==
X-Received: by 2002:a17:90b:4ed0:b0:37f:fb1d:63fa with SMTP id
 98e67ed59e1d1-38f6a373a5amr7799688a91.15.1785341323530; 
 Wed, 29 Jul 2026 09:08:43 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:41::])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f64111008sm2958119a91.2.2026.07.29.09.08.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 09:08:42 -0700 (PDT)
Date: Wed, 29 Jul 2026 09:08:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 tariqt@nvidia.com, 
 mbloch@nvidia.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
 john.fastabend@gmail.com, sdf@fomichev.me, maxime.chevallier@bootlin.com, 
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 aleksander.lobakin@intel.com, 
 horms@kernel.org, magnus.karlsson@intel.com, witu@nvidia.com, 
 alice.kernel@fastmail.im, dtatulea@nvidia.com, yoong.siang.song@intel.com, 
 martin.lau@kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, leon@kernel.org,
 AutonomousCodeSecurity@microsoft.com, 
 "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Message-ID: <amolBkuwEasuthzu@devvm7509.cco0.facebook.com>
References: <20260727161959.885642-1-sdf@fomichev.me> <amnKVlHTITILY8H8@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <amnKVlHTITILY8H8@boxer>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785341323; x=1785946123; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xpR48eIXR1Ci0/Y8C1oaWZVWu8i3+nXBnNEaQ1vsjLQ=;
 b=F/otb41x8Z8J8Cg15jPm2VLK+bgyFZFlhx+Zji9mBFh0n9Pthc+EtyYtbNIYE2fAMk
 Fmh3X8tKjCuUktqjKbIzvZUQzMcDvkJhELr1MUX+YfNaAkL9um1ijnfbVaDqPJoav1nD
 E/D2evMDAgGzr885EZyWXwjbJs3gW1rjJzYfbQHLEoaUO2hP+YdzpRKQD3TKJcljfE8P
 T6inCI0VGvPj5y4I8czzhVV0OcH+MIxsGe3rD87Ew+InYNIqJ3FpmTu5JV9DvbjwCwRX
 5k697iV2VhxoC2Sy6+pKPK9eL4AA9eCCzs4X/oDsibACLgY4sMwG9Vn1sLyrCEjQgkz6
 +Rmw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=F/otb41x
Subject: Re: [Intel-wired-lan] [PATCH net 0/6] xsk: harden TX metadata
 validation against races
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

On 07/29, Maciej Fijalkowski wrote:
> On Mon, Jul 27, 2026 at 09:19:53AM -0700, Stanislav Fomichev wrote:
> > Cen Zhang reported a KASAN out-of-bounds read when AF_XDP is configured
> > with a TX metadata area smaller than struct xsk_tx_metadata. The metadata
> > is also shared with user space, so reading its flags more than once can
> > produce inconsistent validation and processing decisions.
> > 
> > Require enough space for the flags and one request field, validate the
> > launch-time field against the configured metadata length, and use one
> > snapshot of the flags while processing each request. Carry the validated
> > decision through completion handling so later user-space changes cannot
> > enable an unrequested completion timestamp.
> 
> Stan,
> 
> I'm taking week off and I see one sashiko-reported issue which is not a
> pre-existing one. Hope you could clarify it and unless no one picks the
> review of this set i'll get back at it next week.

Went through the issues, I don't think it found anything interesting.
Everything is pre-existing, but still worth addressing, will send
those fixes separately.

> >  static inline struct xsk_tx_metadata *
> >  __xsk_buff_get_metadata(const struct xsk_buff_pool *pool, void *data)
> >  {
> >  	struct xsk_tx_metadata *meta;
> > +	u64 flags;
> >  
> >  	if (!pool->tx_metadata_len)
> >  		return NULL;
> >  
> >  	meta = data - pool->tx_metadata_len;
> > -	if (unlikely(!xsk_buff_valid_tx_metadata(meta)))
> > +	if (unlikely(!xsk_buff_valid_tx_metadata(pool, meta, &flags)))
> >  		return NULL; /* no way to signal the error to the user */
> >  
> >  	return meta;
> The snapshotted flags are validated for size compliance in
> xsk_buff_valid_tx_metadata() but then discarded, returning the
> un-snapshotted user memory pointer (meta) to the driver.
> Later in the zero-copy driver path, xsk_tx_metadata_request() re-reads
> meta->flags directly from user memory:
> include/net/xdp_sock.h:xsk_tx_metadata_request() {
>     ...
>     if (meta->flags & XDP_TXMD_FLAGS_LAUNCH_TIME)
>         ops->tmo_request_launch_time(meta->request.launch_time, priv);
>     ...
> }
> Does this create a Time-of-Check to Time-of-Use (TOCTOU) race condition in
> the zero-copy TX metadata validation where userspace can concurrently enable
> launch time after the size validation?

For this, yes, it is explained in the commit message:

  Note that only xsk_skb_metadata is properly using the flags,
  __xsk_buff_get_metadata ignores them. Next commits address that.

And eventually addressed in "[PATCH net 6/6] xsk: validate metadata when
processing requests". Couldn't find a less confusing way to split the
patches..
