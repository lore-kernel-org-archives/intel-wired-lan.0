Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33824606A31A
	for <intel-wired-lan@archiver.kernel.org>; Mon, 23 Nov 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=r/aZlEET;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g61rtSa3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F80C40531;
	Mon, 23 Nov 2026 08:40:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HLPNW_xp_Xp4; Mon, 23 Nov 2026 08:40:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 133A54053A
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795423255;
	b=ZBDzl+DtEC1Hlgl89yT0T8HrpliSLENF1gbdG4lyZBzrrX1JAv2ViLd7Az+WrMkQMGHu
	 +xMUwU0BCRvnbE+mdsG6kNq6JV7ZlO9MJblaZSIkxRuQoG7adErpHK19jBQosAM3aC7eF
	 BYA3WyjyBZcU6PDdWX+aoPZtj3bG8BQryThibkVbDznPwFjr5IpaE/4BH4E1zkowYnQTw
	 Ow57QLA9ceVuiUAUHDQyjaCTn00PfPpXTUij9v13f4VZS6QwRHbANWrVIEhcrrBlDbnuY
	 OumOTkxcr0Dwa/JUmju3zq5OijP67pnpF3QHSdjfY7o5GaUhnJ23Bgn91VwlvADN9Ag==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795423255;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=MynDxKrid/QCYt14OwnxA0MpxO30DpTyUBr7ZjLJt1M=;
	b=VZVCjTLS636jTv9mB93KiHMPmZ4lx4aFQCBwboulG6yEnqj3pdkZlqLoWbLnvQS71wHZ
	 GsoesvvLxOM0oPvXsi7BzShUibYyEsNw5iafuBn0WDqCNZdoGG+8p4CC1SA1yc+8aF+xy
	 Vvzez8lm0OjhnPSjb8bib/EdyErwXrDyfCcER41PdcTDkS9dhTwqUzXzAPlQEhzX14XxH
	 2TJRUVgXksJcmm9EkC9+3Y3kvT7uRfBDav/EPWyVy1eTNrgy2ljdZFuZ2K7Sjcighf5ME
	 2HVFWzkDVJaR3UBQw9ePPT6skP3Y8hB8YCREMsU26e8lQRRXStlraAU2JBsgSkj3cCQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795423255;
	bh=MynDxKrid/QCYt14OwnxA0MpxO30DpTyUBr7ZjLJt1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r/aZlEETtsbNxLFbaiWQncNxOH96tWMVA5ozTd7GnHHWAQQ37PUhyOox6ymrj3uLs
	 4jLtNOfmnEmbnB0vkZPTQbm1VDKMrggUb7cqcmug8S4hUbbVPqClxRySOfTpr4qnKQ
	 vxyihwbtDgYaDZzp6vjeeiH5qtITFlfeS5HJT2vsbmwS2CUvxTp9xjqT64HreJcsvM
	 9NbjPi281llFBKbjpE+/0vRtO1ODMhP0rNqkWNfNInvxnUTK5oDsYqfqt1VvYdOjJI
	 piV8a5hr8D0Qv5hUT0qPutXIN/VRe8w3Nh2QtJ6LcXgzuwoF3Mq2QIDQ7Up9mHVA6i
	 fiUb5IDBfy0pQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 133A54053A;
	Mon, 23 Nov 2026 08:40:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B15E21AB
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 08:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D81D60697
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 08:40:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HlV6CgAZFS_O for <intel-wired-lan@lists.osuosl.org>;
 Mon, 23 Nov 2026 08:40:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9B9D760651
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=magnus.karlsson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=g61rtSa3
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B9D760651
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 08:40:51 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3b0d0b80fb9so1658314a91.1
 for <intel-wired-lan@lists.osuosl.org>; Mon, 23 Nov 2026 00:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795423250; x=1796028050; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MynDxKrid/QCYt14OwnxA0MpxO30DpTyUBr7ZjLJt1M=;
 b=g61rtSa34OdM4fC9629UHVoAaq62K8xfgovdFrLxN5Ra81mQu8l6/Kuee7nbuIrpXV
 DQuCuIG1Ut1gBZIlsrrWnk65U9v5lVwpuogMDH8f+Z7qy5dPyYsYUyUAlfH8c7FFl3YI
 XxoyNhJ/hXtfJ0vnpHO/V2/HsBb1S6Z/KPHHnQ09Ux3dXqyVvSvAAfAvTXb0dYmJGG88
 q/jFJRMLkU4WRf+yqVPBRcoJr2Aj/OF0RGogn3zUdj6fpHJrQoJNzmtaDQik/eeVTKVy
 9MCUmI0FEiCCPC8zbwvgYKB38vZ54QIg8C+lY7Xvz7nQYaRSrHkJSW6rzk5F8wN8+xwV
 0Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795423250; x=1796028050;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MynDxKrid/QCYt14OwnxA0MpxO30DpTyUBr7ZjLJt1M=;
 b=VHJrkzIqnf1w7E9hghNO/kza6vfgMJSlieXUAWMTEPdyojbiovk7TqwANnrU64ffOa
 +Q5so4tdqCr/sY7CbSR4qTBOWRQIGDiczIaZqKrLn3oqsmpuaE+G72mQwg5+Qa3Rrkgz
 ijBPup62e2h6T6ddEsQqX8Y1VDtj0i4h3tyCZ8Vpnyguz1mcN39mu0RYVqFxaEOnBdeP
 NPzmQUuNqcg5HSLX1hc+5x5aCq3lleFRrV6mrUR3jGXU7/klbNn4yV2xwZ6GNy+aVHCc
 8Q4ZoVUMjqVWRGPrtcQAsIEVxiQAAxyLuXty8pRBPH6RTy3550tQDcrKZXu/2MCLKaj8
 3uXA==
X-Forwarded-Encrypted: i=1;
 AL+hErG6K+Kfuc1BFG2EMtf9lXcnrNqPbNkkwtbVU9GC0beSNuxOzoacbFLZRMY+DUxLVaa5OvaPTuNek+gMf7z9B/4=@lists.osuosl.org
X-Gm-Message-State: APuU4Z+1nLGQg4TrrYTZqsMeqHYRZ3yJWDRgtKlNSkI+cOjR5aS+9+vG
 HUl7tplI+KIr6B4d3hpGWEFkND0DzD1AAgcYDnc0YWtcz+bR31CCzaFXSePfAhrMavpGxjp3H+7
 ZLE6cqbZnSzqDy6Uj+Z7SPyKTCyw7wZM=
X-Gm-Gg: AZFdTZcZf8M1l3/l1TBhGuXleU1H8OrzMz0qiaVKjwIZoDzSjd+5bj4oLPZx5ZXbMvs
 0igzbW4kS8Y/CJ04XSiedr+DY4p93SwAPxFD6Zl7dWkylxNKO4iTF8Q0YTaMmai/1YcCdqEaja/
 rGRoLlIO1DPecEme4sqSiWnbzf/IRHY5Z/Cwvur1URBUOZKPYv/wB2PLjoySkZaJXote31Xq/IA
 +CVaivC9uIzDsrcwhpMIJW87gwlyBEMddPO7vo03YSMpQHuUtcqbFHObpG2cjOaxRibXDAM5kQx
 su6RQsvU6YA2VNzG/GeEjdET16GRVStbICo4Tqm1ZHG3eBR6SFFG4IE29sdo2iiMfUGl2xXrrkg
 bUHDhOUWuqkANzZGhfoLV6lkhCSHwxvNe7nVTV6Q=
X-Received: by 2002:a17:90b:3d4d:b0:3b3:b636:763c with SMTP id
 98e67ed59e1d1-3b41c8fe33bmr10343640a91.22.1795423250052; Mon, 23 Nov 2026
 00:40:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261119165340.1071525-1-magnus.karlsson@intel.com>
 <20261119165340.1071525-4-magnus.karlsson@intel.com> <awBXmCqkMKxsc+9i@boxer>
In-Reply-To: <awBXmCqkMKxsc+9i@boxer>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Mon, 23 Nov 2026 09:40:37 +0100
X-Gm-Features: Aa3M54oBkH_ENrrfQ7pjdOupCIsvkRlW2c49DBDOxlNAweG-hN4IiQ6PdMQeClo
Message-ID: <CAJ8uoz2tKthHN6MHUJoixtjzkGqJR0ukdJCWRG0_2_J11PN_uw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] xsk: ice: add USO zero-copy support
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@intel.com>, netdev@vger.kernel.org,
 sdf@fomichev.me, 
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
 horms@kernel.org, bjorn@kernel.org, kerneljasonxing@gmail.com, 
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 15:22, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Nov 19, 2026 at 05:53:38PM +0100, Magnus Karlsson wrote:
> > Add UDP Segmentation Offload (USO) for AF_XDP zero-copy and implement
> > it in the ice driver. Drivers advertise support with tmo_supports_uso,
> > which is reported to user space as the tx-uso-zc netdev XSK feature.
> >
> > The core exports xsk_tx_uso_parse() and xsk_tx_uso_prepare_headers() for
> > drivers, which snapshot, validate and prepare the packet header, and
> > xsk_tx_invalid_descs() for accounting dropped requests. Drivers without
> > tmo_supports_uso keep handling a USO request as invalid metadata, so
> > xsk_tx_metadata_request() ignores the packet's metadata. As in copy
> > mode, requests that produce more than one datagram also need
> > NETIF_F_GSO_UDP_L4 on the device.
> >
> > Packet headers are copied into kernel-owned memory before they are
> > validated and handed to the NIC, so that user space cannot change them
> > afterwards. ice keeps a DMA-mapped header slot for every two
> > descriptors of the XDP Tx ring, as a USO packet takes at least a
> > context and a header descriptor. The slots hold only header bytes and
> > are allocated page by page to avoid a large contiguous
> > allocation. They belong to the ring: they are allocated when a pool
> > that can carry USO requests is assigned to the ring, and freed with
> > the ring. They therefore follow XDP attach and detach, ring rebuilds
> > and netdev unregistration rather than the pool. Only the copied header
> > bytes are synced for the device. With fewer XDP rings than CPUs,
> > queues share XDP rings and would share their slots, so no slots are
> > allocated and USO requests are ignored for now, though support for
> > this could be added as a separate patch set in the future. tx-uso-zc
> > is still reported in this case, as documented. The slots are only
> > set up when an XDP program is attached. If they cannot be allocated
> > when a ring is reconfigured, the ring keeps its pool without USO and a
> > warning is logged, while a bind fails.
> >
> > When the slots exist, ice_xmit_zc() processes descriptors one packet
> > at a time. A USO packet gets a context and a header descriptor, then
> > shares the data-descriptor loop with ordinary packets. The Tx budget
> > reserves worst-case descriptors per packet. The per-packet path is used
> > for every pool with a Tx metadata area that can carry USO requests,
> > whether or not it sends them. Other pools keep the existing batched
> > fast path. Both paths share the budget, tail, stats and wakeup
> > handling. If the Tx ring cannot hold a maximum-size packet in this
> > worst case, such a packet could never be peeked and Tx would stall, so
> > no header slots are allocated, USO requests are ignored and a warning
> > is logged. The pool flag is not cleared, as the pool may still fall
> > back to copy mode. This is only possible when PAGE_SIZE is 64K and the
> > Tx ring is set to its minimum size.
> >
> > Packets that exceed the hardware limits are dropped and counted in
> > tx_invalid_descs through the new xsk_tx_invalid_descs() helper. Their
> > completions are deferred behind in-flight descriptors to keep the
> > completion ring in order. Packets without USO are dropped as well if
> > they would exceed the eight buffers, which is possible when chunks
> > larger than a data descriptor are split. A batch from the shared-umem
> > fallback can end inside a packet. That packet is dropped, and so is
> > its remainder in the next batch.
> >
> > On completion, a buffer of the existing fast path still stands for one
> > completion, so that path writes nothing to tx_buf[] and struct
> > ice_tx_buf keeps its size. Buffers of the USO path carry an explicit
> > completion count in a union with fields that zero-copy rings do not use.
> > USO header slots, deferred drops and buffers split into several
> > descriptors are tracked with a per-ring counter, so ordinary traffic
> > keeps the fast cleanup path. The header slot of a context descriptor is
> > found from its position in the ring.
> >
> > The descriptors are built with the descriptor builders that the
> > previous patch added for ice_tso().
> >
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > ---
> >  Documentation/netlink/specs/netdev.yaml       |   4 +
> >  Documentation/networking/xsk-tx-metadata.rst  |  47 +-
> >  drivers/net/ethernet/intel/ice/ice.h          |  10 +-
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +
> >  .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   1 +
> >  drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
> >  drivers/net/ethernet/intel/ice/ice_sf_eth.c   |   1 +
> >  drivers/net/ethernet/intel/ice/ice_txrx.c     |   3 +
> >  drivers/net/ethernet/intel/ice/ice_txrx.h     |  22 +-
> >  drivers/net/ethernet/intel/ice/ice_xsk.c      | 502 ++++++++++++++++--
> >  drivers/net/ethernet/intel/ice/ice_xsk.h      |  13 +
> >  include/net/xdp_sock.h                        |   5 +
> >  include/net/xdp_sock_drv.h                    |   6 +
> >  include/net/xsk_tx_uso.h                      |  20 +
> >  include/uapi/linux/if_xdp.h                   |   5 +-
> >  include/uapi/linux/netdev.h                   |   3 +
> >  net/core/netdev-genl.c                        |   2 +
> >  net/xdp/xsk.c                                 |  24 +
> >  net/xdp/xsk_buff_pool.c                       |   4 +-
> >  net/xdp/xsk_tx_uso.c                          |  97 ++++
> >  tools/include/uapi/linux/if_xdp.h             |   5 +-
> >  tools/include/uapi/linux/netdev.h             |   3 +
> >  22 files changed, 729 insertions(+), 51 deletions(-)
> >
>
> (...)
>
> >  struct ice_tx_ring {
> >       __cacheline_group_begin_aligned(read_mostly);
> >       void *desc;                     /* Descriptor ring memory */
> >       struct device *dev;             /* Used for DMA mapping */
> >       u8 __iomem *tail;
> >       struct ice_tx_buf *tx_buf;
> > +     struct ice_xsk_uso_page *xsk_uso_pages; /* USO header slots */
> > +     u16 xsk_uso_slot_stride;
> > +     u16 xsk_uso_slots_per_page;
> > +     u32 xsk_uso_nr_pages;
>
> this is 16 bytes added; how about making an union out of it with tstamp
> pointers? i think you are forbidding mixing USO with tstamping?

Correct, so I can create a union here.

> >
> >       struct ice_q_vector *q_vector;  /* Backreference to associated vector */
> >       struct net_device *netdev;      /* netdev ring maps to */
> > @@ -377,6 +395,8 @@ struct ice_tx_ring {
> >       u16 next_to_clean;
> >
> >       u16 xdp_tx_active;
> > +     u16 xsk_uso_active;
> > +     bool xsk_drain;                 /* drop XSk descriptors up to EOP */
> >       spinlock_t tx_lock;
> >       __cacheline_group_end_aligned(read_write);
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > index 0c1ce3e86a45..7fa1127480b6 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/unroll.h>
> >  #include <net/libeth/xdp.h>
> >  #include <net/xdp_sock_drv.h>
> > +#include <net/xsk_tx_uso.h>
> >  #include <net/xdp.h>
> >  #include "ice.h"
> >  #include "ice_base.h"
> > @@ -133,6 +134,22 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
> >       return 0;
> >  }
> >
> > +/* Worst-case HW descriptors per AF_XDP descriptor on the USO path: the data
> > + * split into maximum-size buffers plus a context and a header descriptor.
> > + */
> > +static u32 ice_xsk_uso_desc_cost(const struct xsk_buff_pool *pool)
> > +{
> > +     return DIV_ROUND_UP(pool->chunk_size, ICE_MAX_DATA_PER_TXD_ALIGNED) + 2;
> > +}
> > +
> > +/* The Tx budget must fit a maximum-size packet, or it is never peeked. */
> > +static bool ice_xsk_uso_ring_fits(const struct ice_vsi *vsi, u16 count,
> > +                               const struct xsk_buff_pool *pool)
> > +{
> > +     return (count - 1) / ice_xsk_uso_desc_cost(pool) >=
> > +            vsi->netdev->xdp_zc_max_segs;
> > +}
> > +
> >  /**
> >   * ice_xsk_pool_enable - enable a buffer pool region
> >   * @vsi: Current VSI
> > @@ -144,6 +161,7 @@ static int ice_xsk_pool_disable(struct ice_vsi *vsi, u16 qid)
> >  static int
> >  ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> >  {
> > +     struct ice_tx_ring *xdp_ring;
> >       int err;
> >
> >       if (vsi->type != ICE_VSI_PF && vsi->type != ICE_VSI_SF)
> > @@ -153,14 +171,129 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
> >           qid >= vsi->netdev->real_num_tx_queues)
> >               return -EINVAL;
> >
> > -     err = xsk_pool_dma_map(pool, ice_pf_to_dev(vsi->back),
> > -                            ICE_RX_DMA_ATTR);
> > -     if (err)
> > -             return err;
> > +     /* No header slots are allocated then, see ice_xsk_cfg_uso_slots(). The
> > +      * pool flag is left alone, as copy mode is a fallback if this fails.
> > +      */
> > +     if (pool->tx_metadata_len && pool->tx_uso_supported &&
> > +         !ice_xsk_uso_ring_fits(vsi, vsi->num_tx_desc, pool))
> > +             netdev_warn(vsi->netdev, "Tx ring too small for USO with %u byte chunks, USO requests on queue %u are ignored\n",
> > +                         pool->chunk_size, qid);
> > +
> > +     /* Allocate the header slots before the pool is DMA mapped and can be
> > +      * published to the rings, so that a failure leaves them without it.
> > +      * Without XDP, rx_ring->xdp_ring is stale, and the slots are allocated
> > +      * when the XDP rings are set up.
> > +      */
> > +     xdp_ring = ice_is_xdp_ena_vsi(vsi) ? vsi->rx_rings[qid]->xdp_ring : NULL;
> > +     if (xdp_ring) {
> > +             err = ice_xsk_cfg_uso_slots(xdp_ring, pool);
> > +             if (err)
> > +                     return err;
> > +     }
> > +
> > +     err = xsk_pool_dma_map(pool, ice_pf_to_dev(vsi->back), ICE_RX_DMA_ATTR);
> > +     if (err && xdp_ring)
> > +             ice_xsk_cfg_uso_slots(xdp_ring, NULL);
> > +     return err;
> > +}
> > +
> > +/**
> > + * ice_xsk_free_uso_slots - free the USO header slots of an XDP Tx ring
> > + * @ring: XDP Tx ring without outstanding descriptors
> > + */
> > +void ice_xsk_free_uso_slots(struct ice_tx_ring *ring)
> > +{
> > +     u32 i;
> > +
> > +     if (!ring->xsk_uso_pages)
> > +             return;
> > +
> > +     for (i = 0; i < ring->xsk_uso_nr_pages; i++) {
> > +             struct ice_xsk_uso_page *page = &ring->xsk_uso_pages[i];
> > +
> > +             if (page->addr)
> > +                     dma_free_noncoherent(ring->dev, PAGE_SIZE, page->addr,
> > +                                          page->dma, DMA_TO_DEVICE);
> > +     }
> > +     kfree(ring->xsk_uso_pages);
> > +     ring->xsk_uso_pages = NULL;
> > +     ring->xsk_uso_nr_pages = 0;
> > +     ring->xsk_uso_slots_per_page = 0;
> > +     ring->xsk_uso_slot_stride = 0;
> > +}
> > +
> > +/**
> > + * ice_xsk_cfg_uso_slots - match the USO header slots of a ring to its pool
> > + * @ring: XDP Tx ring without outstanding descriptors
> > + * @pool: buffer pool bound to the ring, or NULL
> > + *
> > + * Header slots are only needed when USO requests can be submitted. They
> > + * belong to the ring, one per two descriptors, and are freed with it. They
> > + * are allocated in single pages to avoid a large contiguous allocation.
> > + *
> > + * Return: 0 on success, -ENOMEM on allocation failure.
> > + */
> > +int ice_xsk_cfg_uso_slots(struct ice_tx_ring *ring, struct xsk_buff_pool *pool)
> > +{
> > +     u32 stride = ALIGN(NET_IP_ALIGN + XSK_TX_USO_MAX_HEADER,
> > +                        dma_get_cache_alignment());
> > +     u32 per_page = PAGE_SIZE / stride;
> > +     u32 nr_pages = DIV_ROUND_UP(ring->count / 2, per_page);
> > +     u32 i;
> > +
> > +     /* With fewer XDP rings than CPUs, queues share XDP rings and so would
> > +      * share their slots. USO requests are then ignored, as by drivers
> > +      * without USO support. The same goes for a Tx ring too small for a
> > +      * maximum-size USO packet.
> > +      */
> > +     if (!pool || !pool->tx_metadata_len || !pool->tx_uso_supported ||
> > +         ring->vsi->num_xdp_txq < num_possible_cpus() ||
> > +         !ice_xsk_uso_ring_fits(ring->vsi, ring->count, pool)) {
> > +             ice_xsk_free_uso_slots(ring);
> > +             return 0;
> > +     }
> > +     if (ring->xsk_uso_pages && ring->xsk_uso_nr_pages == nr_pages)
> > +             return 0;
> > +
> > +     ice_xsk_free_uso_slots(ring);
> > +     ring->xsk_uso_pages = kcalloc(nr_pages, sizeof(*ring->xsk_uso_pages),
> > +                                   GFP_KERNEL);
> > +     if (!ring->xsk_uso_pages)
> > +             return -ENOMEM;
> > +     ring->xsk_uso_nr_pages = nr_pages;
> > +
> > +     for (i = 0; i < nr_pages; i++) {
> > +             struct ice_xsk_uso_page *page = &ring->xsk_uso_pages[i];
> > +
> > +             page->addr = dma_alloc_noncoherent(ring->dev, PAGE_SIZE,
> > +                                                &page->dma, DMA_TO_DEVICE,
> > +                                                GFP_KERNEL);
> > +             if (!page->addr) {
> > +                     ice_xsk_free_uso_slots(ring);
> > +                     return -ENOMEM;
> > +             }
> > +     }
> > +     ring->xsk_uso_slot_stride = stride;
> > +     ring->xsk_uso_slots_per_page = per_page;
>
> do you really have to carry these within ring? This so you avoid repeated
> calculations i assume?

Correct. It is just for performance. Once I have made the other
changes I can benchmark again and see if this still makes sense.

> >
> >       return 0;
> >  }
> >
> > +/* Every USO packet takes a context and a header descriptor, so in-flight
> > + * context descriptors are never adjacent and, as the ring size is even, half
> > + * the context index is a unique header slot. Return the page and set the slot
> > + * offset within it.
> > + */
> > +static struct ice_xsk_uso_page *
> > +ice_xsk_uso_slot(const struct ice_tx_ring *ring, u16 ctx_idx, u32 *offset)
> > +{
> > +     u32 slot = ctx_idx >> 1;
> > +
> > +     *offset = slot % ring->xsk_uso_slots_per_page *
> > +               ring->xsk_uso_slot_stride;
> > +     return &ring->xsk_uso_pages[slot / ring->xsk_uso_slots_per_page];
> > +}
> > +
> >  /**
> >   * ice_realloc_rx_xdp_bufs - reallocate for either XSK or normal buffer
> >   * @rx_ring: Rx ring
> > @@ -354,6 +487,36 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
> >       return __ice_alloc_rx_bufs_zc(rx_ring, xsk_pool, leftover);
> >  }
> >
> > +static u32 ice_clean_xsk_buf(struct ice_tx_ring *ring, struct ice_tx_buf *buf)
> > +{
> > +     u32 completed = buf->xsk_completions;
> > +     struct ice_xsk_uso_page *page;
> > +     u32 offset;
> > +
> > +     switch (buf->type) {
> > +     case ICE_TX_BUF_EMPTY:
> > +             return 1;
> > +     case ICE_TX_BUF_XSK_TX:
> > +             xsk_buff_free(buf->xdp);
> > +             ring->xdp_tx_active--;
> > +             break;
> > +     case ICE_TX_BUF_XSK_USO:
> > +             page = ice_xsk_uso_slot(ring, buf - ring->tx_buf, &offset);
> > +             dma_sync_single_range_for_cpu(ring->dev, page->dma, offset,
> > +                                           ring->xsk_uso_slot_stride,
> > +                                           DMA_TO_DEVICE);
> > +             ring->xsk_uso_active--;
> > +             break;
> > +     case ICE_TX_BUF_XSK_DROP:
> > +             ring->xsk_uso_active--;
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +     buf->type = ICE_TX_BUF_EMPTY;
> > +     return completed;
> > +}
> > +
> >  /**
> >   * ice_clean_xdp_irq_zc - produce AF_XDP descriptors to CQ
> >   * @xdp_ring: XDP Tx ring
> > @@ -365,9 +528,8 @@ static u32 ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring,
> >       u16 ntc = xdp_ring->next_to_clean;
> >       struct ice_tx_desc *tx_desc;
> >       u16 cnt = xdp_ring->count;
> > -     struct ice_tx_buf *tx_buf;
> >       u16 completed_frames = 0;
> > -     u16 xsk_frames = 0;
> > +     u32 xsk_frames = 0;
> >       u16 last_rs;
> >       int i;
> >
> > @@ -384,22 +546,14 @@ static u32 ice_clean_xdp_irq_zc(struct ice_tx_ring *xdp_ring,
> >       if (!completed_frames)
> >               return 0;
> >
> > -     if (likely(!xdp_ring->xdp_tx_active)) {
> > +     if (likely(!xdp_ring->xsk_uso_active && !xdp_ring->xdp_tx_active)) {
> >               xsk_frames = completed_frames;
> >               goto skip;
> >       }
> >
> >       ntc = xdp_ring->next_to_clean;
> >       for (i = 0; i < completed_frames; i++) {
> > -             tx_buf = &xdp_ring->tx_buf[ntc];
> > -
> > -             if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
> > -                     tx_buf->type = ICE_TX_BUF_EMPTY;
> > -                     xsk_buff_free(tx_buf->xdp);
> > -                     xdp_ring->xdp_tx_active--;
> > -             } else {
> > -                     xsk_frames++;
> > -             }
> > +             xsk_frames += ice_clean_xsk_buf(xdp_ring, &xdp_ring->tx_buf[ntc]);
> >
> >               ntc++;
> >               if (ntc >= xdp_ring->count)
> > @@ -469,6 +623,7 @@ static int ice_xmit_xdp_tx_zc(struct xdp_buff *xdp,
> >
> >               tx_buf->xdp = xdp;
> >               tx_buf->type = ICE_TX_BUF_XSK_TX;
> > +             tx_buf->xsk_completions = 0;
> >               tx_desc->buf_addr = cpu_to_le64(dma);
> >               tx_desc->cmd_type_offset_bsz = ice_build_ctob(0, 0, size, 0);
> >               /* account for each xdp_buff from xsk_buff_pool */
> > @@ -791,6 +946,272 @@ static void ice_fill_tx_hw_ring(struct ice_tx_ring *xdp_ring,
> >               ice_xmit_pkt(xdp_ring, xsk_pool, &descs[i], total_bytes);
> >  }
> >
> > +static void ice_xsk_data_desc(struct ice_tx_ring *ring, dma_addr_t dma,
> > +                           u32 len, u32 cmd, u32 offset, u32 completions)
> > +{
> > +     struct ice_tx_desc *desc = ICE_TX_DESC(ring, ring->next_to_use);
> > +     struct ice_tx_buf *buf = &ring->tx_buf[ring->next_to_use];
> > +
> > +     buf->type = ICE_TX_BUF_XSK_DESC;
> > +     buf->xsk_completions = completions;
> > +     desc->buf_addr = cpu_to_le64(dma);
> > +     desc->cmd_type_offset_bsz = ice_build_ctob(cmd, offset, len, 0);
> > +     if (++ring->next_to_use == ring->count)
> > +             ring->next_to_use = 0;
> > +}
> > +
> > +/* Include the copied header in the eight-buffer limit for every wire segment. */
> > +static bool ice_xsk_uso_fits(const struct xdp_desc *descs, u32 nr,
> > +                          const struct xsk_tx_uso_info *uso)
>
> arghh this is easy to mix with ice_xsk_uso_ring_fits. could we somehow
> distinguish control vs data path?

I will come up with a better name.

> > +{
> > +     u16 network_offset = uso->metadata.request.network_offset;
> > +     u16 transport_offset = uso->metadata.request.csum_start;
> > +     u16 gso_size = uso->metadata.request.gso_size;
> > +     u32 remaining = gso_size, buffers = 1, i;
> > +
> > +     /* The core does not know the width of the descriptor length fields. */
> > +     if (!ice_tx_hdr_lens_ok(network_offset,
> > +                             transport_offset - network_offset) ||
> > +         (uso->gso_segs > 1 &&
> > +          (gso_size < ICE_TXD_CTX_MIN_MSS || gso_size > ICE_TXD_CTX_MAX_MSS)))
> > +             return false;
> > +
> > +     for (i = 0; i < nr; i++) {
> > +             u32 len = descs[i].len - (i ? 0 : uso->header_len);
> > +
> > +             while (len) {
> > +                     u32 chunk = min_t(u32, len, ICE_MAX_DATA_PER_TXD_ALIGNED);
> > +                     u32 left = chunk;
> > +
> > +                     len -= chunk;
> > +                     while (left) {
> > +                             u32 bytes = min(left, remaining);
> > +
> > +                             if (++buffers > ICE_MAX_BUF_TXD)
> > +                                     return false;
> > +                             left -= bytes;
> > +                             remaining -= bytes;
> > +                             if (!remaining) {
> > +                                     remaining = gso_size;
> > +                                     buffers = 1;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +     return true;
> > +}
> > +
> > +/* A buffer longer than one data descriptor is split, so a packet without USO
> > + * can then need more data descriptors than the hardware allows.
> > + */
> > +static bool ice_xsk_bufs_fit(const struct xsk_buff_pool *pool,
> > +                          const struct xdp_desc *descs, u32 nr)
> > +{
> > +     u32 buffers = 0, i;
> > +
> > +     if (likely(pool->chunk_size <= ICE_MAX_DATA_PER_TXD_ALIGNED))
> > +             return true;
> > +     for (i = 0; i < nr; i++)
> > +             buffers += DIV_ROUND_UP(descs[i].len,
> > +                                     ICE_MAX_DATA_PER_TXD_ALIGNED);
> > +     return buffers <= ICE_MAX_BUF_TXD;
> > +}
> > +
> > +/* Write the context and header descriptors of a USO packet and return the
> > + * command and offset fields for its payload descriptors.
> > + */
> > +static int ice_xsk_xmit_uso_hdr(struct ice_tx_ring *ring,
> > +                             const struct xdp_desc *descs, u32 nr,
> > +                             const struct xsk_tx_uso_info *info, u32 *cmd,
> > +                             u32 *offset)
> > +{
> > +     const struct xsk_tx_metadata *meta = &info->metadata;
> > +     u16 slot_idx = ring->next_to_use;
> > +     u64 qw1 = ICE_TX_DESC_DTYPE_CTX;
> > +     struct ice_xsk_uso_page *page;
> > +     struct ice_tx_ctx_desc *ctx;
> > +     struct ice_tx_buf *buf;
> > +     dma_addr_t header_dma;
> > +     u32 slot_offset;
> > +     bool eop;
> > +
> > +     if (!ice_xsk_uso_fits(descs, nr, info))
> > +             return -EOPNOTSUPP;
> > +
> > +     page = ice_xsk_uso_slot(ring, slot_idx, &slot_offset);
> > +     header_dma = page->dma + slot_offset + NET_IP_ALIGN;
> > +
> > +     xsk_tx_uso_prepare_headers(info, page->addr + slot_offset + NET_IP_ALIGN);
> > +     dma_sync_single_range_for_device(ring->dev, page->dma, slot_offset,
> > +                                      NET_IP_ALIGN + info->header_len,
> > +                                      DMA_TO_DEVICE);
> > +
> > +     *cmd = ICE_TX_DESC_CMD_L4T_EOFT_UDP;
> > +     if (info->protocol == htons(ETH_P_IP))
> > +             *cmd |= info->gso_segs > 1 ? ICE_TX_DESC_CMD_IIPT_IPV4_CSUM :
> > +                                       ICE_TX_DESC_CMD_IIPT_IPV4;
> > +     else
> > +             *cmd |= ICE_TX_DESC_CMD_IIPT_IPV6;
> > +     *offset = ice_build_tx_desc_offset(meta->request.network_offset,
> > +                                        meta->request.csum_start -
> > +                                        meta->request.network_offset,
> > +                                        sizeof(struct udphdr));
> > +
> > +     /* The context owns the header until the whole submitted batch completes. */
> > +     buf = &ring->tx_buf[slot_idx];
> > +     buf->type = ICE_TX_BUF_XSK_USO;
> > +     buf->xsk_completions = 0;
> > +     ring->xsk_uso_active++;
> > +
> > +     if (info->gso_segs > 1)
> > +             qw1 |= ice_build_tso_ctx_qw1(info->len - info->header_len,
> > +                                          meta->request.gso_size);
> > +     ctx = (struct ice_tx_ctx_desc *)ICE_TX_DESC(ring, slot_idx);
> > +     memset(ctx, 0, sizeof(*ctx));
> > +     ctx->qw1 = cpu_to_le64(qw1);
> > +     if (++ring->next_to_use == ring->count)
> > +             ring->next_to_use = 0;
> > +
> > +     eop = info->len == info->header_len;
> > +     ice_xsk_data_desc(ring, header_dma, info->header_len,
> > +                       *cmd | (eop ? ICE_TX_DESC_CMD_EOP : 0), *offset,
> > +                       eop ? nr : 0);
> > +     return 0;
> > +}
> > +
> > +/* Write the data descriptors of a packet, skipping its first @skip bytes. */
> > +static void ice_xsk_xmit_descs(struct ice_tx_ring *ring,
> > +                            struct xsk_buff_pool *pool,
> > +                            const struct xdp_desc *descs, u32 nr, u32 skip,
> > +                            u32 cmd, u32 offset)
> > +{
> > +     bool split = false;
> > +     u32 i;
> > +
> > +     for (i = 0; i < nr; i++, skip = 0) {
> > +             u32 len = descs[i].len - skip;
> > +             dma_addr_t dma;
> > +
> > +             if (!len)
> > +                     continue;
> > +             dma = xsk_buff_raw_get_dma(pool, descs[i].addr) + skip;
> > +             xsk_buff_raw_dma_sync_for_device(pool, dma, len);
> > +             while (len) {
> > +                     u32 chunk = min_t(u32, len, ICE_MAX_DATA_PER_TXD_ALIGNED);
> > +                     bool eop = i == nr - 1 && len == chunk;
> > +
> > +                     split |= len > chunk;
> > +                     ice_xsk_data_desc(ring, dma, chunk,
> > +                                       cmd | (eop ? ICE_TX_DESC_CMD_EOP : 0),
> > +                                       offset, eop ? nr : 0);
> > +                     dma += chunk;
> > +                     len -= chunk;
> > +             }
> > +     }
> > +     /* Split buffers break the one-completion-per-descriptor cleanup
> > +      * shortcut, so make the cleanup walk this packet.
> > +      */
> > +     if (unlikely(split)) {
> > +             u16 last = ring->next_to_use ? ring->next_to_use - 1 : ring->count - 1;
> > +
> > +             ring->tx_buf[last].type = ICE_TX_BUF_XSK_DROP;
> > +             ring->xsk_uso_active++;
> > +     }
> > +}
> > +
> > +static void ice_xsk_drop_packet(struct ice_tx_ring *ring,
> > +                             struct xsk_buff_pool *pool, u32 nr)
> > +{
> > +     xsk_tx_invalid_descs(pool, nr);
> > +     /* Completion queue entries are published in submission order, so a
> > +      * dropped packet must not be completed ahead of descriptors still in
> > +      * flight. The ring always keeps one descriptor unused, so equal
> > +      * indices mean that nothing is outstanding.
> > +      */
> > +     if (ring->next_to_use != ring->next_to_clean) {
> > +             u16 last = ring->next_to_use ? ring->next_to_use - 1 : ring->count - 1;
> > +             struct ice_tx_buf *buf = &ring->tx_buf[last];
> > +
> > +             /* XSK_TX buffers already force the slow cleanup path. */
> > +             if (buf->type == ICE_TX_BUF_EMPTY) {
> > +                     buf->xsk_completions = 1;
> > +                     buf->type = ICE_TX_BUF_XSK_DROP;
> > +                     ring->xsk_uso_active++;
> > +             } else if (buf->type == ICE_TX_BUF_XSK_DESC) {
> > +                     buf->type = ICE_TX_BUF_XSK_DROP;
> > +                     ring->xsk_uso_active++;
> > +             }
> > +             buf->xsk_completions += nr;
> > +     } else {
> > +             xsk_tx_completed(pool, nr);
> > +     }
> > +}
> > +
> > +/* Returns the number of packets queued on the ring. */
> > +static u32 ice_xmit_zc_metadata(struct ice_tx_ring *ring, struct xsk_buff_pool *pool,
> > +                             u32 count, unsigned int *total_bytes)
> > +{
> > +     struct xdp_desc *descs = pool->tx_descs;
> > +     u32 i = 0, packets = 0;
> > +
> > +     /* Drop the rest of a packet whose start was dropped in an earlier batch. */
> > +     if (unlikely(ring->xsk_drain)) {
> > +             while (i < count && ring->xsk_drain)
> > +                     ring->xsk_drain = !xsk_is_eop_desc(&descs[i++]);
> > +             ice_xsk_drop_packet(ring, pool, i);
> > +     }
> > +
> > +     while (i < count) {
> > +             u32 cmd = 0, offset = 0, skip = 0, slot_offset;
> > +             u32 len = descs[i].len, nr = 1;
> > +             struct ice_xsk_uso_page *page;
> > +             struct xsk_tx_uso_info info;
> > +             int uso;
> > +
> > +             while (!xsk_is_eop_desc(&descs[i + nr - 1]) && i + nr < count)
> > +                     len += descs[i + nr++].len;
> > +             /* The shared-umem fallback can end a batch inside a packet. */
>
> No, it can not... or at least the intent was not to. the shared umem
> fallback has been written in a way that it also calls
> xskq_cons_read_desc_batch() which is supposed *not* to expose incomplete
> multi-buffer packet.
>
> Is that a special case where you don't set XDP_USE_SG but packets are not
> linear due to USO, or what?
>
> I wouldn't like to propagate the draining disease down to drivers. We've
> put enough of convoluted code onto layer above, let us address it there if
> there's something missing?

You are right. This should not be here in the driver. I will fix it in
the core instead.

At some point we really need to simplify the skb multi-buffer path.
Always gives me a headache.

> I'm gonna cut the review here and keep the comments I had so far.
>
> > +             if (unlikely(!xsk_is_eop_desc(&descs[i + nr - 1]))) {
> > +                     ice_xsk_drop_packet(ring, pool, nr);
> > +                     ring->xsk_drain = true;
> > +                     break;
> > +             }
> > +             page = ice_xsk_uso_slot(ring, ring->next_to_use, &slot_offset);
> > +             uso = xsk_tx_uso_parse(pool, &descs[i], nr, &info,
> > +                                    page->addr + slot_offset + NET_IP_ALIGN);
> > +             if (uso < 0 || (!uso && !ice_xsk_bufs_fit(pool, &descs[i], nr)) ||
> > +                 (uso && ice_xsk_xmit_uso_hdr(ring, &descs[i], nr, &info,
> > +                                              &cmd, &offset))) {
> > +                     ice_xsk_drop_packet(ring, pool, nr);
> > +                     i += nr;
> > +                     continue;
> > +             }
> > +             if (uso) {
> > +                     skip = info.header_len;
> > +                     *total_bytes += (info.gso_segs - 1) * skip;
> > +                     packets += info.gso_segs - 1;
> > +             }
> > +             ice_xsk_xmit_descs(ring, pool, &descs[i], nr, skip, cmd, offset);
> > +             *total_bytes += len;
> > +             packets++;
> > +             i += nr;
> > +     }
> > +     return packets;
> > +}
> > +
> > +/**
> > + * ice_xsk_setup_metadata - register AF_XDP Tx metadata operations
> > + * @netdev: net_device
> > + */
> > +void ice_xsk_setup_metadata(struct net_device *netdev)
> > +{
> > +     static const struct xsk_tx_metadata_ops ops = {
> > +             .tmo_supports_uso = true,
> > +     };
> > +
> > +     netdev->xsk_tx_metadata_ops = &ops;
> > +}
> > +
> >  /**
> >   * ice_xmit_zc - take entries from XSK Tx ring and place them onto HW Tx ring
> >   * @xdp_ring: XDP ring to produce the HW Tx descriptors on
> > @@ -801,9 +1222,9 @@ static void ice_fill_tx_hw_ring(struct ice_tx_ring *xdp_ring,
> >  bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool)
> >  {
> >       struct xdp_desc *descs = xsk_pool->tx_descs;
> > -     u32 nb_pkts, nb_processed = 0;
> > +     u32 nb_pkts, nb_processed = 0, packets;
> >       unsigned int total_bytes = 0;
> > -     int budget;
> > +     u32 budget, cost = 1;
> >
> >       ice_clean_xdp_irq_zc(xdp_ring, xsk_pool);
> >
> > @@ -811,26 +1232,38 @@ bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool)
> >           !netif_running(xdp_ring->vsi->netdev))
> >               return true;
> >
> > -     budget = ICE_DESC_UNUSED(xdp_ring);
> > -     budget = min_t(u16, budget, ICE_RING_QUARTER(xdp_ring));
> > +     /* Reserve worst-case descriptors for each potential USO packet. */
> > +     if (xdp_ring->xsk_uso_pages)
> > +             cost = ice_xsk_uso_desc_cost(xsk_pool);
> > +     budget = min_t(u32, ICE_DESC_UNUSED(xdp_ring) / cost,
> > +                    ICE_RING_QUARTER(xdp_ring));
> >
> >       nb_pkts = xsk_tx_peek_release_desc_batch(xsk_pool, budget);
> >       if (!nb_pkts)
> >               return true;
> >
> > -     if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
> > -             nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> > -             ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_processed,
> > -                                 &total_bytes);
> > -             xdp_ring->next_to_use = 0;
> > -     }
> > +     if (xdp_ring->xsk_uso_pages) {
> > +             packets = ice_xmit_zc_metadata(xdp_ring, xsk_pool, nb_pkts,
>
> nit: could we stick to 'pkts'
>
> > +                                            &total_bytes);
> > +     } else {
> > +             if (xdp_ring->next_to_use + nb_pkts >= xdp_ring->count) {
> > +                     nb_processed = xdp_ring->count - xdp_ring->next_to_use;
> > +                     ice_fill_tx_hw_ring(xdp_ring, xsk_pool, descs, nb_processed,
> > +                                         &total_bytes);
> > +                     xdp_ring->next_to_use = 0;
> > +             }
> >
> > -     ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
> > -                         nb_pkts - nb_processed, &total_bytes);
> > +             ice_fill_tx_hw_ring(xdp_ring, xsk_pool, &descs[nb_processed],
> > +                                 nb_pkts - nb_processed, &total_bytes);
> > +             packets = nb_pkts;
> > +     }
> >
> > -     ice_set_rs_bit(xdp_ring);
> > -     ice_xdp_ring_update_tail(xdp_ring);
> > -     ice_update_tx_ring_stats(xdp_ring, nb_pkts, total_bytes);
> > +     /* Metadata packets may all have been dropped. */
> > +     if (packets) {
> > +             ice_set_rs_bit(xdp_ring);
> > +             ice_xdp_ring_update_tail(xdp_ring);
> > +             ice_update_tx_ring_stats(xdp_ring, packets, total_bytes);
> > +     }
> >
> >       if (xsk_uses_need_wakeup(xsk_pool))
> >               xsk_set_tx_need_wakeup(xsk_pool);
> > @@ -939,12 +1372,7 @@ void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring)
> >       while (ntc != ntu) {
> >               struct ice_tx_buf *tx_buf = &xdp_ring->tx_buf[ntc];
> >
> > -             if (tx_buf->type == ICE_TX_BUF_XSK_TX) {
> > -                     tx_buf->type = ICE_TX_BUF_EMPTY;
> > -                     xsk_buff_free(tx_buf->xdp);
> > -             } else {
> > -                     xsk_frames++;
> > -             }
> > +             xsk_frames += ice_clean_xsk_buf(xdp_ring, tx_buf);
> >
> >               ntc++;
> >               if (ntc >= xdp_ring->count)
>
> I think we could pull out core enablement for zc uso out of this patch
> maybe?

What do you mean with "core" here? Core as in AF_XDP core, or
preparatory stuff to the ice driver?
