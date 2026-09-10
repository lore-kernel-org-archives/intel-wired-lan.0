Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00DADC79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 17:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4A1640822;
	Thu, 10 Sep 2026 17:14:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QXpLqbmX7d27; Thu, 10 Sep 2026 17:14:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B83D540857
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789060485;
	b=jStCUavxf6gdV/zHlUOm48f2zudDmJ/39omChH7aueUuGpDEe0yyt2TBvhWoC04tKWi9
	 1kV37wRTI6y9uRWR4Kcv9Vc6qS7t6lxeWCFqRHefv8TA2bVOOLyb5NqiOsfgwU7+zH4QL
	 vuFa0TZu2R5b8VpRVHSf9H4qx7WfN0uWuhQoBdpFoAcr5UMn51SrQxg5gRIoALOqF4jZT
	 ladq/c7MzBXQUmfJJyFrL/9ubInLr1iyzwMd7gWVjdIpSJEM2h5h4b8I8BU6sSB65ywVy
	 MBtVst39Zo/n23+ZOGs7rORemStS+kMoE/59EmmYlmQdNm4vR6hec3FKmz7Z6OAMDMA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789060485;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
	b=QoNKsN2Fq7gazGx8CrJkzRlsrtkx+8M+Z6Dnc4hAmDZip2atMSa4Hac1CT/Jkg5Vyyyd
	 ncFGxWw2L8EkNl+WNpZL6iMjW+KkFyVTocMT86AfoAS2mTZdaT9BF0Rzl9/yHa9wyq7xV
	 H64W84GJ6m+77/kUBKBkuil9k++kzaSlL93TpZ3lvOobrQ4q2fJHREoN8ncb4Stc1zlAM
	 2kiX6e5S1wNJzXHFXyjFhO77RdDt6Y5k+zPjYZZlW63+5BpWyE5ynqCd9x5UCoYo4e+cc
	 zBpclT/yVW0EgarzJ7jBMZIjaniLwrh6IGWBuqZLXR1roDzeqBHtZ3taAr6daKnF2PQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789060485;
	bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oF1qwii2FYKjN0gD6HQLcOuod6TyBqsQTcN7b5q42OA8m5KvvtjkYms9YVVFRnqPd
	 q376Ai9x1C8H2SvC0QNi7PIp1UUhHNcX3rU1VeSy9ERl9OQ4T8xZSRl/CT78QQWRlQ
	 bfKEbbE9MmP9GsDq96IX8iKwwNsABF3dRmdntI2tIbh7eAe02mYcl1CjsWdITzKSxH
	 knhPQcSNEpgoc1Re05sEJH/0c4mFOwHVaWYO7eAmi5Jd9H75OvowyJKEM5osBU9FRg
	 nrMHESXqJqtRA7NduP38VB3D4VEc9VsEkikFcH0JNHxE/TRJG9RUNqUHHpgGTH2E2M
	 n08W6xfs/3c+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B83D540857;
	Thu, 10 Sep 2026 17:14:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 641D849D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 55C3A40219
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:14:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 495Io9s-2yE0 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 17:14:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3A0FE40210
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789060482;
 b=IG0ODzZC+/7BiGCIsn0cQ0+DYW6LMZTAyiY8ezUpC+tWLES2dDG17XhQcY6RU75Bj09e
 UApHazmM42tbtdMxzZMjDwFOPUkYiPG8eax0+6A6na480cO2Ed4c7rZFe3CX8ssNNnJKR
 ciqugjkrYiMixN6eC6OsHcq26CgvHqwEmLVaf/I0ei+sIvRXdeXadCinbqHhiwpiX9o9c
 qzo7sXb00/6C2xBp+5zK+lLyCdQHpAf1TmDSF6PO/lPdmEmfUzj299LGMMEON34QWU47U
 O5aSbY8yGql9t2tnJ3DnhGAi83/Ag4IksWN5hMkNHxBcer5Rhq/VcFA5ELoX3TtdrUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789060482;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
 b=gDyGKEh/dynAmUIxWgqMkJxLTo00fQAOTB0dVuuSOklcvFne2XQsZu6TP9yNdyeG+cWc
 /HqroQOYQ3/pRfp4wFDAfNawVmMgE1NaJVE9Ha/qOGBfBl/fNZjyJ1PYnj4kULC28zoTr
 X+WXE3h5wt6u/v8iOr8Nl9VlMWDvfwYF/gIDicgrbnS6OHWiZ8pxO5vcBATiz7G1zuoWP
 rpWWmCWdvoSVNa3ZeHaKk5hT5eVY5ZzqxxBOriOlp2D7/AwowOPff7SKauvDxDSeqZuS6
 qeKGWA4rObYncBs8vlElhK363yAYrbjBZHvJDB+oUDzcZhkVACst+qWkma4vHR+92sA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=bM66RXoM; 
 arc=none smtp.remote-ip="2607:f8b0:4864:41::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::10; helo=mail-yx2-x10.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=bM66RXoM
Received: from mail-yx2-x10.google.com (mail-yx2-x10.google.com
 [IPv6:2607:f8b0:4864:41::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A0FE40210
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:14:41 +0000 (UTC)
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d46e4cdcdso29239267b3.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 10:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789060478; x=1789665278; darn=lists.osuosl.org;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
 b=bM66RXoM+Knwy9kszX0kXNYzMR2RD+nLi8z/jNULOa17Y2l4dn9ZpCIGn1e5bBfQu2
 5HI+9DVD/frs+vUNQS6qN80XfCxU5BIg8fild4dQddg27ZLWFrkVww93U4/pOTj5+OhP
 qmSrHGeX185jviZWi7Vd6+kalrcu2HViCIuOT3cuW/4Dau5pQTjusK9ZdbX+ia9VEqg0
 N55AFn08dTCo4Ui0WcgKjpKa8PNbHI979YSnIsz0IeN/NBU8PhMKJhYxZUmKqKT4wMEe
 ubOu3AWgpeVxRXkFbWigSlFhkcI4bSY1eF7lJh6V05cyb63UpyJC9EwWFdQ3oSoVgiEY
 U63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789060478; x=1789665278;
 h=content-transfer-encoding:content-type:mime-version:subject
 :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
 b=VhyseUbofxYWxYJu+6jt3Du055LfInt//pAt9hi1ENI68NOXkUp83Kse/aUMHMA6Cy
 i63duYzlwrLFx/PZW/xBs28WbHz/L2500avS1ALIpYmq1swzhoLry4kpvnOTyNUgbVlf
 12xoB/VeHUkNeZhumEYaRZdgyeSn2rulLIBqxUZ+kRdPaCOSwelti9M/6j75BlINV0qG
 xYgIjLFzFogJDs2RBeVjstPznDMyJgNfonq294zTdBzQAqJxXzYeS+trWaSI0/NtiDu8
 ssXpjlaxsKG9xki6caVncaWDFi35S5AYOsLNzGjJF2zSQqCA/hOubW5vESqHf9c/Q9ly
 QSOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1389IodGKEmloF/NNoUE1YwxcHzAGMFeJDUPEpa/pU6/aXIweXow8DHd2XnS49Hzb7MpTcoEy54V9A+4mTrM=@lists.osuosl.org
X-Gm-Message-State: AFuF++l9Ge8SLyYUVzoGV+QCdcF8evLHWKXdGszaxkmF7X1L+6MLM7mC
 2032M6JyvQUVntIjuNKm583YhTVuz5SDCatrSS90Z836m25NKyTprdxr
X-Gm-Gg: AYBFou1PufqAvAsO3PUDTY28grYLffUWuo24/yMdZoTIV7ZPb4ceZ4OZsoBT8mHdY6W
 +aPwkYwi46msPHMOoV3VIDfv0vkdwqgWHOAva87Qnp0AmhxBWtQLbA7r2g+uCWLDnwb3C+x34Ve
 biMzAE0urFgLAIDztwTwfJTadtZJUO2Ku3ntrY9z5pa6zhgNyJ/YPzkISZZzO9x2r/3xQvZHg6q
 yNk5L6lQ0uUtzrIJvuWyczNCzNpj24XNKCZ6R4IK6Hv/uSji1xDTBOUI30BLGHFgtRovCjrJ7qC
 Xe7/hUWQPSAgY9db3QbDfQdgqlJwqWKccRTSQBhYYBaFFUhuAr5HcLkkrmKQP77x1vFeWL1Znq2
 IcxZTq00Q2xrhIdz7h3iByBQ+H2Joht7oViDu36hh4hMaJnuaB76bG8+Wuj474FWu4AtOZPRmNN
 os1sq7k7elTIySx6Q9KogMdrESPdM3uwupfqUvjL9Yb/3GF54899aj1I734ZqoWyySr4Z7kHuZU
 nlRaBAeVTa2ZRctZriJdcyhCvfm28+68VAfSXeY6acUSwblPBqx
X-Received: by 2002:a05:690c:d94:b0:854:27c3:5cd8 with SMTP id
 00721157ae682-884b387a6ecmr939577b3.27.1789060478657; 
 Thu, 10 Sep 2026 10:14:38 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com.
 [34.85.207.234]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-88487ea6026sm2255367b3.32.2026.09.10.10.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:14:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:14:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 Willem de Bruijn <willemb@google.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "Hay, Joshua A" <joshua.a.hay@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Message-ID: <willemdebruijn.kernel.2baa66372628@gmail.com>
In-Reply-To: <IA3PR11MB8986BD23939D98382AAC3971E5B22@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
 <IA3PR11MB8986BD23939D98382AAC3971E5B22@IA3PR11MB8986.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v8 3/6] idpf: support pacing offload
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
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

Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Sent: Wednesday, September 2, 2026 8:17 PM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; kuba@kernel.org; edumazet@google.com;
> > pabeni@redhat.com; horms@kernel.org; andrew+netdev@lunn.ch; Willem de
> > Bruijn <willemb@google.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> > <joshua.a.hay@intel.com>; intel-wired-lan@lists.osuosl.org
> > Subject: [PATCH net-next v8 3/6] idpf: support pacing offload
> > 
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > If skb->tstamp is in the future, program this future delivery txtime
> > in the transmit descriptor.
> > 
> > TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> > the FQ offload_horizon is configured. But device support for pacing
> > offload must be more robust: it can also be reached through SO_TXTIME.
> > 
> > Bounds check txtime. Only packets with timestamp between now and the
> > horizon (pacing_offload_horizon) are offloaded.
> > 
> > Negotiate the feature with the device using virtchnl. Support is
> > conditional on
> > - splitq mode, where tx and tx completion queues are separate, so
> >   completions can be returned out of order.
> > - flow scheduling mode, where completions can arrive out of order.
> > - PTP to ensure the NIC clock is synced to CLOCK_TAI.
> > 
> > These features are negotiated per adapter, but expect all vports to
> > uniformly request splitq (req_[rt]x_splitq) and flow scheduling
> > (flow_sch_en) when available.
> > 
> > Do not explicitly check all preconditions. Trust the firmware to only
> > advertise EDT when all are met. In general, firmware response is
> > trusted to be correct. If not, EDT would be the least of the worries.
> > In particular, granularity is trusted to be a power of two. And
> > time_horizon_ns is a range expressible given the chosen granularity.
> > 
> > Packets beyond the horizon are sent immediately with the overflow bit
> > set.
> > 
> > On device reset, dev->pacing_offload_horizon, fq offload_horizon and
> > granularity are not re-negotiated. It is safe to assume that firmware
> > does not change these EDT capabilities across resets.
> > 
> > Must not be called from netpoll due to ktime_get. But netpoll does not
> > generate packets with EDT, so no explicit test is needed.
> > 
> > Do not fail device initialization on EDT init error. Log an error, but
> > continue without EDT, similar to PTP.
> > 
> > Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Cc: Joshua A Hay <joshua.a.hay@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> > ---
> > 
> > Changes
> >   v7 -> v8
> >     - remove unused variable np in idpf_tx_splitq_set_txtime
> >   v6 -> v7
> >     - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
> >     - only set horizon if splitq with flow scheduling
> >     - fail on illegal granularity 0, rather than use hardcoded default
> >     - zero edt_caps on negotation error, in case of call after reset
> negotation -> negotiation

Fixed
 
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks for the review Aleksandr!

I did not keep the Reviewed-by as sticky, because the patch saw some
changes in v9. 

https://lore.kernel.org/netdev/20260910171131.2532487-5-willemdebruijn.kernel@gmail.com/T/#u
