Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B32CD37AC
	for <intel-wired-lan@archiver.kernel.org>; Thu, 14 May 2026 04:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60E7C60C0F;
	Thu, 14 May 2026 04:47:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lnl9GA8-laR9; Thu, 14 May 2026 04:47:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3B0E60C01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778734071;
	bh=3AyOL3ppd8xGJZ2KNy9mC12UjWrON94Yu0GePueZeeM=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fAbW270K4HnUmYIUtBQ2DAPZze1u4gJV03WDBa+2teKR++K20F+swYAIvEcV2eScx
	 0pphHN1GHLe0gTPxnKnaGG3nZXsFFu33GwuBYSdCSXOMMaWXWngyqODQ9HONo73S7V
	 c+IvbeDKYjG4l1t5cs2wf5BGL+umQZJy04J12723ir5Wlw9ATMNlxAMon9JRurDBbu
	 GSkH8Pc+CzrNq+z9I32zqYPEM32qXlisdVo5KpIikhz2WFL4vD0LwTPbp2cfxSjet2
	 V59YRzRWseeTyNOF74xYwTqOzaRHgucMnB8XXpw4MGwCsl1c9LNU0eRucHYVYPxB/g
	 KCDwIofwlz+Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B0E60C01;
	Thu, 14 May 2026 04:47:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 74B1637D
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 May 2026 04:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 51F1C60C01
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 May 2026 04:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GKNpBPEWbZ2Z for <intel-wired-lan@lists.osuosl.org>;
 Thu, 14 May 2026 04:47:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=171.64.64.25;
 helo=smtp1.cs.stanford.edu; envelope-from=ouster@cs.stanford.edu;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5849E60BFD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5849E60BFD
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5849E60BFD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 May 2026 04:47:48 +0000 (UTC)
Received: from mail-yx1-f54.google.com ([74.125.224.54]:57441)
 by smtp1.cs.Stanford.EDU with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <ouster@cs.stanford.edu>) id 1wNNz9-0002tE-CX
 for intel-wired-lan@lists.osuosl.org; Wed, 13 May 2026 21:47:48 -0700
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-651bc83e74aso8817271d50.2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 13 May 2026 21:47:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ9D4decvSExrvxr7g41KTA74K8+7cIMCkaIZwjzmPAefmjeejwjZlyEUqs597xromE/rfIyYORHuRQ67AeeoQE=@lists.osuosl.org
X-Gm-Message-State: AOJu0YzgjJ/7H6ylmc8/xTjrjUY5+Wck0EkykHNL3peVj2NnaMwJZ1bE
 9ZS10WquyJm3EHPyy9Mka7Nn0zP2EZ9ueccb/xgVEeTBotrsIXL5Mz2+5ArzW4bd5pTqceOUK8Y
 dNQ+IheObMoifd6LLp3pL5nrMeYlSY9w=
X-Received: by 2002:a05:690c:c117:b0:7bd:ac4d:bf5b with SMTP id
 00721157ae682-7c6dc7c118fmr52576797b3.44.1778734066710; Wed, 13 May 2026
 21:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260512181953.1689-1-ouster@cs.stanford.edu>
 <20260513100732.499e3f49@pumpkin>
 <CAGXJAmzK+56DHnitD1g263mPSgWg9jZyq2z6R+vd8bV_c4ZbuQ@mail.gmail.com>
 <20260513214927.17a8dd45@pumpkin>
In-Reply-To: <20260513214927.17a8dd45@pumpkin>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Wed, 13 May 2026 21:47:11 -0700
X-Gmail-Original-Message-ID: <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
X-Gm-Features: AVHnY4I7VDZMqDYm3BEU1IYOkcNt_oCLDdDfb41-kNLISPv5uzgLWbSydLqU5ug
Message-ID: <CAGXJAmx4LaVv=QJ=SanvF6iayJ8+SiLyUqht+jMxouXPX=54-g@mail.gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: stable@vger.kernel.org, anthony.l.nguyen@intel.com, 
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com, 
 netdev@vger.kernel.org, jacob.e.keller@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Scan-Signature: ae7d61d5ad21aa0d569d6b6c8168eb46
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; 
 d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3AyOL3ppd8xGJZ2KNy9mC12UjWrON94Yu0GePueZeeM=; t=1778734069; x=1779598069; 
 b=o/ZoP4z9i460pY3yekYiTJU/AIqAzi3no1YrulJpaV8yCrXPpLOpZgFczcHxgolez3T0rxBCP9q
 m1S1mPcnRZZst9vuvstTS8atxbt4lm6N1r9e1oI3gPtbDBGoy86xcw1idIHsrsFSYStZfhkyn57N3
 7fE1W1fq+ucNjIMCY4KhB/bg25RYkw6+NU+elNvq8fHyph2c3ykDa+4XmSRILnOfuouChm1RKpw2F
 6V/ufxdaZj67CFzk/YOCz1VJ8+UEpVKjIVv85pxrDZSwqUrVoyMEfYTMtpOM0O1sBGYRC6o+tUSKk
 BFp0dmqmUpL2huC/yJTsfctvKua7r3pTz2Ug==;
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=cs.stanford.edu
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=cs.stanford.edu header.i=@cs.stanford.edu
 header.a=rsa-sha256 header.s=cs2308 header.b=o/ZoP4z9
Subject: Re: [Intel-wired-lan] [PATCH net v3] ice: fix packet corruption due
 to extraneous page flip
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

On Wed, May 13, 2026 at 1:49=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 13 May 2026 09:28:40 -0700
> John Ousterhout <ouster@cs.stanford.edu> wrote:
>
> > On Wed, May 13, 2026 at 2:07=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 12 May 2026 11:19:53 -0700
> > > John Ousterhout <ouster@cs.stanford.edu> wrote:
> > >
> > > > Consider the following sequence of events:
> > > > * The bottom half of a buffer page is filled with data from
> > > >   packet A. The page has a net reference count (reference count
> > > >   - bias) of 1. The page is returned to the NIC, flipped to
> > > >   use the top half.
> > > > * Before the reference on the page is released, the NIC returns
> > > >   the page with no data in it ('size' is zero in ice_clean_rx_irq).
> > > >   In this case the bias does not get decremented. The page still
> > > >   has a net reference count of 1, so it gets returned to the NIC.
> > > >   However, ice_put_rx_mbuf flipped the page so that the bottom
> > > >   half is active.
> > > > * If the NIC stores another packet in the page before packet A
> > > >   has released its reference, the data in packet A will be
> > > >   overwritten with data from the new packet.
> > > > * Unfortunately zero-length buffers occur frequently: they seem
> > > >   to occur whenever a packet uses every available byte in a
> > > >   buffer, ending precisely at the end of the buffer. When this
> > > >   happens the NIC seems to generate an extra zero-length
> > > >   buffer.
> > > > The fix is for ice_put_rx_mbuf not to flip pages that have a
> > > > size of 0.
> > >
> > > How is this different from packet B (in the top half) being
> > > freed before packet A (in the bottom half)?
> >
> > I'm not sure exactly what you're referring to here. Are you asking
> > about a situation where both halves of the page get filled with packet
> > data and then the second half to be filled is the first to be freed? I
> > believe that the ICE driver abandons a page if both halves are ever
> > occupied simultaneously; the page will be returned to the system once
> > both halves have dropped their references. Thus it doesn't matter
> > which half is freed first.
>
> That is what I was thinking, seems like the logic is over complicated.
>
> If you need to put 4k pages into some kind of iommu rather than 2k buffer=
s
> (to contain 1536 byte ethernet packets) then I'd have thought you'd
> initially put both halves into adjacent tx ring entries.
> If a rx buffer is discarded (eg a zero length fragment or a CRC error,
> or even 'copy break' for short packets) then, as an optimisation,
> you could reuse the buffer for another receive.
> The same could be done if the page is freed by an application.
>
> However it sounds like it doesn't use the 2nd half until the first
> completes - otherwise you'd never 'flip' to make the other half
> active.
>
> Thinks...
> By only putting half of each 4k 'page' into the rx ring the code
> will usually save (expensive) iommu setup in the (probably) normal
> case where the buffers are freed 'reasonably quickly'.
> But that really requires a 'free/with_nic/busy' state for each half
> rather then trying to guess from a reference count.
>
> But if the low-level code is recycling the rx buffer (for any reason)
> it wants to use the same buffer.
>
> The ethernet driver I wrote (a long time ago, early 90s) allocated
> 64k as 128 512byte buffers and did an aligned word-sized copy of
> every receive frame - most frames were in contiguous memory.
> The simplicity of it made up for the cost of the copy, especially
> since that was an iommu system.

I'm not here to defend the logic (and it has been replaced with
something that is probably simpler and more efficient); I'm just
suggesting a bug fix for the stable releases that still have this
logic.

-John-
