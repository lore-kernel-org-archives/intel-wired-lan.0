Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DDFC433FE
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Oct 2022 18:40:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 475614089F;
	Wed,  5 Oct 2022 18:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 475614089F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664995229;
	bh=D2M2PcN1ehbEi2jS8633UW/FKFWMwfo1YzgD6t2vDPg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=e0YEBUUmI7HeE0HmG1N7p/AcJLkYJOP+q2lIYjNE1DBVX+t37wE+yx3nx7LoU48lV
	 zbVJQgQRIEhI4LVGIHBNcFL50HG6jm8dcH+kc7uGFDl/IcQyQHc8oyBbgxEGULlS+V
	 UWK5Uu0kwCq69C60+vcxznbKL5rANFLM+lEBCvf/LqraiQISgpeRXSkx89YiBfkb9c
	 i5SIq8iz+fXDDseeTjIh4D72/IW6J3W9JJHdGhf2THUwL4CvyUy2Q9IATwc7NtFO9s
	 RlmrgPqLUIHCQxDydKY39O4986nMct7qudiTVahjBHcJpxrzwIeR6bR4O1OCHYkoRZ
	 6xHwSyph3jBTg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuhcWb1Nk9Kg; Wed,  5 Oct 2022 18:40:28 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7767409F3;
	Wed,  5 Oct 2022 18:40:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7767409F3
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id DA7031BF23C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 18:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1B8740232
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 18:40:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1B8740232
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XQ3ju6fn8a9v for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Oct 2022 18:40:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFA8940142
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFA8940142
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 18:40:25 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 t10-20020a17090a4e4a00b0020af4bcae10so1748804pjl.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 05 Oct 2022 11:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date;
 bh=dB/mLDPvddSrAOBjDKTbLlR3uh0ZH57qh/dtZrjjag8=;
 b=EJqR13jOAAa4v7nrt5yTEjj7XUBcDW3EX6UNXxAioGMOhSA7p53U9eEEH3UAYqgbUX
 pdVL3kH412cFJUwfy0pf1GiZr8aywcOvqF9tyBOY5eaQQ7oK0Sl7qKMX6QZ5c7qL9jem
 QCilWiW5hZlpmtDKRCtynoZfLagdF/zaU9P7BfnXMNOJMrEupr+bRl8ZyoQ52e0Xx6uW
 jzP+R+djoWtsoyerI58CRxY0dRtZzjLTaRf+aZs7lFposPB3hZUk4YAiynOexMoeewET
 POTIvrA1R2q8e6W2vcmwcZ3DEUTAJD8oyY7OuQ2iMhJNerd+lFBJHXqNbpV8Qu9qgDSL
 Ya0A==
X-Gm-Message-State: ACrzQf3eqt3uf/8FNX6M03o/up/x8rsYumWN61wNHxhXZHpCFeiGC5KY
 kcawrBmfZP7UzIQeEv9ej2sh0A==
X-Google-Smtp-Source: AMsMyM7gwXg6Gwz4+ig5i+7VvjMOLYrh5xTxKqZzZpNNN8dTdPMmCkAEsKOWi7nPRryVxYIfXVB1Zw==
X-Received: by 2002:a17:902:b693:b0:178:5fa6:4b3 with SMTP id
 c19-20020a170902b69300b001785fa604b3mr712778pls.63.1664995225034; 
 Wed, 05 Oct 2022 11:40:25 -0700 (PDT)
Received: from fastly.com (c-73-223-190-181.hsd1.ca.comcast.net.
 [73.223.190.181]) by smtp.gmail.com with ESMTPSA id
 b9-20020a630c09000000b00434e1d3b2ecsm45380pgl.79.2022.10.05.11.40.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Oct 2022 11:40:24 -0700 (PDT)
Date: Wed, 5 Oct 2022 11:40:22 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20221005184021.GA15277@fastly.com>
References: <1664958703-4224-1-git-send-email-jdamato@fastly.com>
 <1664958703-4224-2-git-send-email-jdamato@fastly.com>
 <Yz1chBm4F8vJPkl2@boxer> <20221005170019.GA6629@fastly.com>
 <aab58471-096d-db50-36f2-493a14e0e6da@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aab58471-096d-db50-36f2-493a14e0e6da@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
 bh=dB/mLDPvddSrAOBjDKTbLlR3uh0ZH57qh/dtZrjjag8=;
 b=HPh3rH28cH1ISMMyraM/Zk/HU3Vf4F4itg1n1ginrO9IEW808laa6i4YjatABM4XsD
 /yzJvBou5oGm2E2bU8DgudA+2IwhTFXaTVtRmmtyBB6YTcssDXqvlxLB6BN+GJhIa+/W
 79pekj24nQTZhhGy0Xl2SR3IEe4PQCrz+SwEA=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com
 header.a=rsa-sha256 header.s=google header.b=HPh3rH28
Subject: Re: [Intel-wired-lan] [next-queue 1/3] i40e: Store the irq number
 in i40e_q_vector
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, kuba@kernel.org,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Oct 05, 2022 at 11:25:32AM -0700, Jesse Brandeburg wrote:
> On 10/5/2022 10:00 AM, Joe Damato wrote:
> >On Wed, Oct 05, 2022 at 12:29:24PM +0200, Maciej Fijalkowski wrote:
> >>On Wed, Oct 05, 2022 at 01:31:41AM -0700, Joe Damato wrote:
> >>>Make it easy to figure out the IRQ number for a particular i40e_q_vector by
> >>>storing the assigned IRQ in the structure itself.
> >>>
> >>>Signed-off-by: Joe Damato <jdamato@fastly.com>
> >>>---
> >>>  drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
> >>>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
> >>>  2 files changed, 2 insertions(+)
> >>>
> >>>diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> >>>index 9926c4e..8e1f395 100644
> >>>--- a/drivers/net/ethernet/intel/i40e/i40e.h
> >>>+++ b/drivers/net/ethernet/intel/i40e/i40e.h
> >>>@@ -992,6 +992,7 @@ struct i40e_q_vector {
> >>>  	struct rcu_head rcu;	/* to avoid race with update stats on free */
> >>>  	char name[I40E_INT_NAME_STR_LEN];
> >>>  	bool arm_wb_state;
> >>>+	int irq_num;		/* IRQ assigned to this q_vector */
> >>
> >>This struct looks like a mess in terms of members order. Can you check
> >>with pahole how your patch affects the layout of it? Maybe while at it you
> >>could pack it in a better way?
> >
> >OK, sure. I used pahole and asked it to reorganize the struct members,
> >which saves 24 bytes.
> 
> Hi Joe, thanks for your patches,
> 
> Saving 24 bytes is admirable, but these structures are generally optimized
> in access pattern order (most used at the top) and not so much for "packing
> efficiency" especially since it has that alignment directive at the bottom
> which causes each struct to start at it's own cacheline anyway.
> 
> 
> >
> >I'll update this commit to include the following reorganization in the v2 of
> >this set:
> >
> >$ pahole -R -C i40e_q_vector i40e.ko
> >
> >struct i40e_q_vector {
> >	struct i40e_vsi *          vsi;                  /*     0     8 */
> >	u16                        v_idx;                /*     8     2 */
> >	u16                        reg_idx;              /*    10     2 */
> >	u8                         num_ringpairs;        /*    12     1 */
> >	u8                         itr_countdown;        /*    13     1 */
> >	bool                       arm_wb_state;         /*    14     1 */
> >
> >	/* XXX 1 byte hole, try to pack */
> >
> >	struct napi_struct         napi;                 /*    16   400 */
> >	/* --- cacheline 6 boundary (384 bytes) was 32 bytes ago --- */
> >	struct i40e_ring_container rx;                   /*   416    32 */
> >	/* --- cacheline 7 boundary (448 bytes) --- */
> >	struct i40e_ring_container tx;                   /*   448    32 */
> >	cpumask_t                  affinity_mask;        /*   480    24 */
> >	struct irq_affinity_notify affinity_notify;      /*   504    56 */
> >	/* --- cacheline 8 boundary (512 bytes) was 48 bytes ago --- */
> >	struct callback_head       rcu;                  /*   560    16 */
> >	/* --- cacheline 9 boundary (576 bytes) --- */
> >	char                       name[32];             /*   576    32 */
> >
> >	/* XXX 4 bytes hole, try to pack */
> >
> >	int                        irq_num;              /*   612     4 */
> 
> The right spot for this debug item is at the end of the struct, so that part
> is good.
> 
> >
> >	/* size: 616, cachelines: 10, members: 14 */
> >	/* sum members: 611, holes: 2, sum holes: 5 */
> >	/* last cacheline: 40 bytes */
> >};   /* saved 24 bytes! */
> 
> I'd prefer it if you don't do two things at once in a single patch (add
> members / reorganize).
> 
> I know Maciej said this is a mess and I kind of agree with him, but I'm not
> sure it's a priority for your patch set to fix it now, especially since
> you're trying to add a debugging assist, and not performance tuning the
> code.
> 
> If you're really wanting to reorganize these structs I'd prefer a bit more
> diligent effort to prove no inadvertent side effects (like maybe by turning
> up the interrupt rate and looking at perf data while receiving 512 byte
> packets. The rate should remain the same (or better) and the number of cache
> misses on these structs should remain roughly the same. Maybe a seperate
> patch series?

I honestly did think that reorganizing the struct was probably out of scope
of this change, so if you agree so I'll drop this change from the v2 and
keep the original which adds irq_num to the end of the struct.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
