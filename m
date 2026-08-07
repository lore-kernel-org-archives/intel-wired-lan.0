Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA771C5AC7A
	for <intel-wired-lan@archiver.kernel.org>; Fri,  7 Aug 2026 01:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51D3D605CF;
	Fri,  7 Aug 2026 01:18:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vys-oRtItfI1; Fri,  7 Aug 2026 01:18:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 746B6607F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786065522;
	bh=hOxpWXKVFJ3URm3uZriLzHf088tykABB1pdbe8MixXM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oLVckzSDb14Bw4fvdw6Cc2hn5cZe0KHEIz0c4/GVMYTf3vLl0I3eoMwuZ+Rk50IXj
	 g1N994bem7pjNyYwytlEUFlivp+d2cuTXW6Fpl9sFDsK63WQXCUmM8oiy6mzuiEIka
	 XcnXoMFUj4IvVtKWgZJaGxRu4Khr/ZUeorc7R39RaVYlRJiPbZ/tlb9WzcANmtsI6z
	 t/J+PFVNuWomu/zb0u8D7ba9PqdWdgRq/LyeBtqfBrxiMSXtOe4ADi2k4YdPZ8DO2C
	 YpLTSEQf4tGsabkTHnAdTdBmY0QygFuvfdT340lS7zHrGfprFFwXIhTK0+GJaiJfue
	 KYeEdHNghhZGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 746B6607F3;
	Fri,  7 Aug 2026 01:18:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A3FC02B6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 01:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98D33607F3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 01:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pTnvQatEkyO1 for <intel-wired-lan@lists.osuosl.org>;
 Fri,  7 Aug 2026 01:18:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D757605CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D757605CF
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D757605CF
 for <intel-wired-lan@lists.osuosl.org>; Fri,  7 Aug 2026 01:18:40 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81f36179d72so43535247b3.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 06 Aug 2026 18:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786065519; x=1786670319;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hOxpWXKVFJ3URm3uZriLzHf088tykABB1pdbe8MixXM=;
 b=F79Lv1rQkkWMj8iEQeL8HoGeRraMjrWDviXFYWYD8zGuChwAy2dqOrtpBiMcwlicWb
 2Zk/cK5C/891C+igMD1fRpj5MuU1TD4yStxxP0AjK/IwY+lVH9uHxAs/l1FRse8GmBym
 d3Vp6dZVnNwk7fFPIxXh95ZhTLGIqHtjbUcp5Z+KGDkb4f2wK3Iq3aBpGOwMxBPJ0dqT
 yrJWWfAWELqfqo6bPitd246q62KDSO1tgpMoAXPiJ93Ph5esQiEDjlSDLYenlsQfinWS
 p7Yu/7hk41ugeH5Rgfmhx244yFhbPZGUYcwTR7yawPKLretSYwuPtnujVOzCBsW3eLXb
 uljg==
X-Gm-Message-State: AOJu0YwbqVURcGulQDGlpJABCFEBDFQ5BG4Yw9nLlTHw350wgc8C3hc3
 IzO1aaqznK0GuiRlE11dWWmMRQK4mbtA27WhJtrnINL2W/i+mgICaZdM
X-Gm-Gg: AR+sD12bfZEmDL1cDyMELxgiueBpOFoTjw/Q1jSfOQONfEGFOOD4XJ3M22EtU0RXmwK
 e0aOYJVN0BmchKuQVRk9pn5BtZhOU79iITPWPHsVbvAyO6mkAhqRoKyzGm1QsMtKr0zKwC5Kuuh
 f4KCz25jY06ni3HVbrnwhljPZhUX4jwMLW5m9qNA9trOfT/5Mv3kv4Ab6Co6jntd6jL1h8RbN9b
 NrrxqV5D2ISbc5KxvSA92v4rQxxNh1MJ3b1JvGy9CaRGYYI9AoCM5a9Ry8mI9XQdb5VQ0YzoJVg
 LsLyO+kZgdjrAZN3gJ9WUPeyADvfis26PDoSUv3JbJA9uLx3RwAByHq1Zzyugec9XFj+DFu1y5R
 cREYQ3bAVIWhwXNqe7HYHD9sh2Ur7mBlQqOTwOxmuT2Ozy9BZCEgz1/ez8CwkRA6CYZeaXL9QZ/
 m8NNWmAQ84vuvfdTT0eqR4whp6dVbeOyRSuo9rWxJ3eUjX3VdZ7bhqck3eknhA4INuHqGm4NTMg
 6svBkGnXbeylCcHugay1HvwiNIVlXf8aKan
X-Received: by 2002:a05:690c:601:b0:81d:5155:213b with SMTP id
 00721157ae682-820223296bfmr123197047b3.14.1786065519098; 
 Thu, 06 Aug 2026 18:18:39 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-823f577c580sm1465037b3.27.2026.08.06.18.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 18:18:37 -0700 (PDT)
Date: Thu, 06 Aug 2026 21:18:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
In-Reply-To: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786065519; x=1786670319; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hOxpWXKVFJ3URm3uZriLzHf088tykABB1pdbe8MixXM=;
 b=ed5b1LbA6reQYOzM2ocquGuoEiM9CS8PUsp5Z+mOhiW+iWjraapSW21Wyp5dhHOIYT
 xZgYFQ4B9MR/n7+VcIk39yte5AlNGIEM5PJxvG8GQDLGsNyvy2KunQnsJfA659KXGRPO
 o5lbbdieOTB27BfdNJZxwiHpxq3mrUr+S7wgd+LX6eAF5e03mJdu7jwXOoCg4T0a1T/z
 RaBtm1PExFO1CneOLaJuUx+/Cb8zOeRuhjFMRRIDidBXYN4+Q80Vp8glT3G0ADJvQ7sY
 kLc9wergJE+MVGdg601JI+Lq7VkLNy1mQY1Ey2yVgI6qumM9J/kjC4t89g5rTFh56KYH
 AB7Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ed5b1LbA
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/6] hardware pacing
 offload
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

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Enable safe hardware pacing offload on a first device (idpf), plus support.
> 
> - Add rtnetlink support for admin control over the device feature
> - Add device support to the idpf driver
> 
> Besides the main feature, also
> 
> - Small optimization to FQ offload: avoid unnecessary ktime_.._get().
> - Expand so_txtime drv-net test with hw offload testcases.
> - Expand pktgen with txtime feature.
> 
> Details and detailed changelog in the individual patches.
> 
> High level changes:
>   v3 -> v4
>     - Replace ethtool API with rtnetlink
>     - Drop/defer pktgen patch: not essential
> 
> NOTE: the idpf patch will have a minor merge conflict with commit
> "idpf: add missing cpu_to_le32 in idpf_tx_splitq_build_flow_desc"
> (https://lore.kernel.org/netdev/20260803210707.1912217-1-willemdebruijn.kernel@gmail.com/).
> I expect that this series will need another revision, at which point
> that fix will have made its way to net-next. There is also a fix to
> so_txtime.py outstanding, but that is structured so that these do not
> conflict.
> 
> v3: https://lore.kernel.org/netdev/20260726202902.760552-1-willemdebruijn.kernel@gmail.com/
> v2: https://lore.kernel.org/netdev/20260722204454.3234605-1-willemdebruijn.kernel@gmail.com/
> v1: https://lore.kernel.org/netdev/20260706133433.3142805-1-willemdebruijn.kernel@gmail.com/
> 
> Willem de Bruijn (6):
>   net: rtnetlink: add pacing_offload_horizon attribute to net_device
>   net_sched: sch_fq: clear past skb->tstamp if offloading pacing
>   idpf: support pacing offload
>   selftests: drv-net: refactor so_txtime errqueue handling
>   selftests: drv-net: in so_txtime tell apart sw from hw pacing
>   selftests: drv-net: extend so_txtime with hw offload
> 
>  Documentation/netlink/specs/rt-link.yaml      |   6 +
>  .../networking/net_cachelines/net_device.rst  |   3 +-
>  drivers/net/ethernet/intel/idpf/idpf.h        |   1 +
>  drivers/net/ethernet/intel/idpf/idpf_lib.c    |   3 +
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  70 +++++++-
>  drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   2 +
>  .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  56 ++++++-
>  drivers/net/ethernet/intel/idpf/virtchnl2.h   |  10 ++
>  include/linux/netdevice.h                     |   4 +-
>  include/linux/skbuff.h                        |  17 +-
>  include/uapi/linux/if_link.h                  |   1 +
>  net/core/rtnetlink.c                          |  21 +++
>  net/sched/sch_fq.c                            |  19 ++-
>  .../testing/selftests/drivers/net/so_txtime.c | 157 +++++++++++++-----
>  .../selftests/drivers/net/so_txtime.py        |  75 ++++++++-
>  15 files changed, 385 insertions(+), 60 deletions(-)

This was intended to have a wider audience list. Will address in v5.
