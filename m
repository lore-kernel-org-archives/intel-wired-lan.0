Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15AC44507
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Jul 2026 08:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 960546063F;
	Wed, 15 Jul 2026 08:32:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U2-pNlwWiPJQ; Wed, 15 Jul 2026 08:32:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B3A4360640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784104347;
	bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YQhivIrcpzoW1dPSuIMoEiUUxXpW4v6LlqoASMQeHytBxSjuxqScthtM7ijCeZ22D
	 khjGWPuvwsmCQ6dyG+aZSnlTuFARswkwKJDMAW7xt3S07l6kqAwC99SV6lg68g+dQz
	 fhuVCltYu7+2Jfw89g5TFzNil0HVUPPVFxs4wYbqr/LlH3qkMMogWyMuIYod7Hylmv
	 QQlhYaUiM3UB2HoDpozRl/JaQ8fK5RRbg4pTdCNbrCYfEfs276l66gKIotqmFYTfj0
	 oCMs/Hu/PclkGTusqLmrhd1zI88HZGETJeEMOtcPazv9LjbRe1skOna5tq/5JlS+dv
	 poSQxxaR/PWxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3A4360640;
	Wed, 15 Jul 2026 08:32:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBCF6203
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CDF5D60640
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:32:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MVr2L8NijxSY for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Jul 2026 08:32:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::;
 helo=mail-pj2-x00.google.com; envelope-from=sdf.kernel@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 05A046063F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 05A046063F
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05A046063F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 08:32:25 +0000 (UTC)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7a345f51so35344495ad.0
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Jul 2026 01:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784104345; x=1784709145;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
 b=HTGDmngY+yGSymQq5xIYJwbpkj2dU6Lg1Co/pY8ljJrA+YfquWBleezIssNGTXT1kS
 ZxemCRUkpf3Vghw45X7V6g7baGTElsR6OchlfLWYgGKR8pOChWg1eo1HdLeejapmvWrV
 yI6LbftQg1DOYZwN4QT8APkEn2SaDCYGdG7BQ+s5BF4K2oETGRxblOPBm44kVNQXDlHJ
 Gm8sluF8bRMyZXvH8imlgSZXv+5RH+pjbGK8bvNt/VkaIo+to3UrRWXIR03rnpENXkne
 xYtHKeQAMXGYC51zIuHqUvboddq8A1Qoc+Wejh8FWin0dUTwVAyehiIzLkvpegdR9E9n
 NJDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqIhuW2zZ8g1Iu7tSZWd70zx61WRSMyKm+rWqi9LwlyA3Ujl4WgDGHgg1ytLTFtbSSnh3RQzjg807mSLSEyzZs=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzN+G29vO/KGHHjZxQg93xT/IUydWw1GvJogGKPOmUsKAltdqJT
 bt+4AdF9nxeeLLR1173anwQ8JYjksRlsdHWO/1u5T21Es8B44PLkWk5S
X-Gm-Gg: AfdE7cmj0drLGo1AbSIxXxgr8nuLkeYAaMbqKNJiNql3Mxfy2xBj3pvxKweYRfWcoEB
 ixIm9UbObEpdZLTNZvyP2ua0rHnoyz21AguzmyWbE51mryiXLIvltArYu+OehheYnHduHuay+jc
 +VZrF51ybuXWVOTZSi0dcVsqewYNv7+nLJYd5s7uLP3GSuKxQ9pj6WqcfbTNpDHnxQhI2PXIzjq
 kZtP4n1xgTVT+pSmhrZpdE75jQe9OKJHkrHpdiWX9blsu1UX/Q5mvXlhqO71GyY6G42eVT+BRat
 G5cAmYkEvsxqQmC6TL7uMpaI/PV+djARmtwhKomz2hZlbc6d6IngfBE0i17qfoeU9yYOMl31FZI
 1wiIj8k28ZbWnDb4qmXG9hk9C7xwWbXmZme3h9nhhm6TSS83qCekupA+dLkhyUs3A25G0B+oe0e
 Y1r8QY
X-Received: by 2002:a17:902:d4c7:b0:2cc:6817:d9b1 with SMTP id
 d9443c01a7336-2cf03df6a24mr15483195ad.41.1784104344760; 
 Wed, 15 Jul 2026 01:32:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb75fsm129307865ad.8.2026.07.15.01.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 01:32:24 -0700 (PDT)
Date: Wed, 15 Jul 2026 01:32:16 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Vladimir Vdovin <deliran@verdict.gg>, 
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Message-ID: <aldE7W4T_ylUTLv5@devvm7509.cco0.facebook.com>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-2-deliran@verdict.gg>
 <alE8oBxkrak8n602@devvm7509.cco0.facebook.com>
 <alZtI782RGKb8y4Y@lore-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alZtI782RGKb8y4Y@lore-desk>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784104345; x=1784709145; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AvK4rlZieqdDEX/C3RF2OhSiSp9tIt5loVtN+a7NID8=;
 b=RF8eDm1Axub5DEdyA5mJ9mXQxSrSTb68B2Icq3GFC0DKWIKBmEq0mf5/c7A6cLFxki
 VlPRK8XVTNpiRZX3L8/X/IgAc0/BWQmtDuh0H9ywxaG7ENqmKYQi0luD4+6u6ErhKY2R
 4ufthn0A6v6SawRN4cTRRGIkNw6uAUN+oah7DQhqtPw6qPAJGxg6svQbu91HGAS8TvjP
 GuFrtVeaIQr13XJEsKn+umaB9ouVumYoQBxSLuhepsdgJRakFOuudjCxaVLx4QANFz+/
 tMG/+aaBq7Grxueu9qLE8W1XlAKojkeWLf91olDbZooYPFoJM8LP/Nx6+140PnVDdZM4
 Rj1w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RF8eDm1A
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v4 1/6] netlink: specs: Add
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

On 07/14, Lorenzo Bianconi wrote:
> > On 07/08, Vladimir Vdovin wrote:
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > 
> > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > checksum will be use by devices capable of exposing receive checksum
> > > result via bpf_xdp_metadata_rx_checksum().
> > > Moreover, introduce xmo_rx_checksum netdev callback in order to allow
> > > the eBPF program bound to the device to retrieve the RX checksum result
> > > computed by the hw NIC and reported via DMA descriptors.
> > > 
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> > > ---
> > >  Documentation/netlink/specs/netdev.yaml |  5 ++++
> > >  include/net/xdp.h                       | 18 ++++++++++++++
> > >  include/uapi/linux/netdev.h             |  3 +++
> > >  net/core/xdp.c                          | 32 +++++++++++++++++++++++++
> > >  tools/include/uapi/linux/netdev.h       |  3 +++
> > >  5 files changed, 61 insertions(+)
> > > 
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index 5f143da7458c..6d0d90d3a614 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -61,6 +61,11 @@ definitions:
> > >          doc: |
> > >            Device is capable of exposing receive packet VLAN tag via
> > >            bpf_xdp_metadata_rx_vlan_tag().
> > > +      -
> > > +        name: checksum
> > > +        doc: |
> > > +          Device is capable of exposing receive checksum result via
> > > +          bpf_xdp_metadata_rx_checksum().
> > >    -
> > >      type: flags
> > >      name: xsk-flags
> > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > index aa742f413c35..e255ff786131 100644
> > > --- a/include/net/xdp.h
> > > +++ b/include/net/xdp.h
> > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > >  			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > >  			   bpf_xdp_metadata_rx_vlan_tag, \
> > >  			   xmo_rx_vlan_tag) \
> > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > +			   bpf_xdp_metadata_rx_checksum, \
> > > +			   xmo_rx_checksum)
> > >  
> > >  enum xdp_rx_metadata {
> > >  #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > @@ -643,12 +647,26 @@ enum xdp_rss_hash_type {
> > >  	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > >  };
> > 
> > [..]
> >  
> > > +/* Please note the driver is required to invalidate the checksum if the NIC
> > > + * reports CHECKSUM_UNNECESSARY or CHECKSUM_COMPLETE and the eBPF program
> > > + * modifies the packet since it can change some fields validated by the
> > > + * checksum.
> > > + */
> > 
> > Sorry, a bit confused about this part. IIUC this is in response to this
> > discussion https://lore.kernel.org/bpf/aaLYfWnuuf_ne72u@lore-desk/ ?
> > 
> > Looking at a few drivers:
> > - bnxt (bnxt_rx_pkt) does UNNECESSARY - ok
> > - mlx5 (mlx5e_handle_csum) does UNNECESSARY and skips COMPLETE if there is
> >   bpf prog attached
> > - fbnic (fbnic_rx_csum) - can do COMPLETE even with xdp attached?
> > - gve (gve_rx) - can do COMPLETE even with xdp attached?
> > 
> > So none of the drivers invalidate anything (and nether the bpf machinery), some
> > choose to (correctly?) not report COMPLETE when there is XDP. So was the
> > discussion about documenting this and giving some guidance? This probably
> > belongs to that `DOC: skb checksums` section of include/linux/skbuff.h?
> 
> Hi Stanislav,
> 
> re-reading the previous upstream discussion, I guess we should just document the
> expected driver behaviour (invalidate the cksum for both COMPLETE and
> UNNECESSARY cases when the XDP program running on the NIC returns XDP_PASS) and
> add a given kselftest for it. Agree?

Yes, let's have something a bit more detailed about how it works right now
vs the expectation.

By my point is: the comment in this patch also seems wrong? We do not seem
to invalidate the csum, we just disable COMPLETE when there is a xdp program
attached (or I'm missing something).
