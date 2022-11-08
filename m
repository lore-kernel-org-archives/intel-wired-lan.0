Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF78C433FE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Nov 2022 03:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5009260797;
	Tue,  8 Nov 2022 03:55:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5009260797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1667879736;
	bh=01CqHuQQ4Wy9tMnk4sv/+QVUJKuxKsCO16KXlQApEhA=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=JurFo4KiI6qKT44rvqjmzQwUc7HWQ3InIudlhFlqla8oGZRPYFjiHPtkjrwuzqpfB
	 85Au2Ym7nXI1uO9mEgBLg/VcwW29ghG4WVKrmjoz81KEW1UqhTDxLVHDrsv/q5zlJ4
	 KDHPW9jeckg5eRHC+zG+mTE0cf7lJwxCJUdUK2cps7gV7tTQ7j/BdZ1h8v+rjRH4s7
	 V3Zy3bM06b07Hhtaph5qF5XRJ5E71R77rg+RHymbukv3HBQjlOyJDO5szjqD5kRbGs
	 FI6H4qSZa9AGyTaEut1Pk3OALm8RpfZiOIibkc9QwNXJXPTXzvtk2GKPVO+d9fNAJc
	 S3VQLkFjAZN2w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VVaGwT_mOZUm; Tue,  8 Nov 2022 03:55:35 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EEEF60881;
	Tue,  8 Nov 2022 03:55:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EEEF60881
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 65CA61BF390
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Nov 2022 03:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37294408AF
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Nov 2022 03:55:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37294408AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t2neSRQjGahN for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Nov 2022 03:55:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0CC64013B
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0CC64013B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Nov 2022 03:55:32 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C40E9B8188B;
 Tue,  8 Nov 2022 03:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00169C433D6;
 Tue,  8 Nov 2022 03:55:27 +0000 (UTC)
Date: Mon, 7 Nov 2022 19:55:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20221107195526.5ef1262e@kernel.org>
In-Reply-To: <c051fa25-6047-0efb-7049-be08f566d1fb@intel.com>
References: <20221104205414.2354973-1-anthony.l.nguyen@intel.com>
 <20221104205414.2354973-6-anthony.l.nguyen@intel.com>
 <Y2itqqGQm6uZ/2Wf@unreal>
 <DM5PR11MB1324FDF4D4399A6A99727B5EC13C9@DM5PR11MB1324.namprd11.prod.outlook.com>
 <Y2lEK4CMdCyEMBLf@unreal>
 <c051fa25-6047-0efb-7049-be08f566d1fb@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1667879728;
 bh=jfSoGwo546XyLcE1uccBGS6De2TD0dAjfZXKPspZBdw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=aGhgILqCEVDt6EWAqsWWrysxlK7H3uEVANEME1KqxgLcyUWVKiSULyjZEfKMDrru6
 nUqYggNQAFBr9K4aqvyBpj2ZwL9hUtJsIxx2c1xsLgORGt/XJSYbI7Tyc2cnxR3woq
 N9IDKbzXcrFUnNnxyC3YD00hIXyPi9Y01dcJekwb6Fj170uYm1dmxnP0jCf7c7yqbC
 9G6cZMjSu/2e0jpdqsw3AuUhSJOUsjvhbFWzJEm9DPyLQUpJ/0r2kaGYIZAP1kHvjV
 5MhhTVlY4lQnetAICBBGWGrKVYTaaxBlBTHhWaXCAFqYvsNVA6PD3wz+H1Q7hUhTVY
 lRPbM88bxF7ag==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=aGhgILqC
Subject: Re: [Intel-wired-lan] [PATCH net-next 5/6] igb: Do not free
 q_vector unless new one was allocated
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
Cc: Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Ruhl,
 Michael J" <michael.j.ruhl@intel.com>,
 "edumazet@google.com" <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 7 Nov 2022 10:35:14 -0800 Jacob Keller wrote:
> > I understand the issue what you are trying to solve, I just don't
> > understand your RCU code. I would expect calls to rcu_dereference()
> > in order to get q_vector and rcu_assign_pointer() to clear
> > adapter->q_vector[v_idx], but igb has none.
> 
> the uses of kfree_rcu were introduced by 5536d2102a2d ("igb: Combine 
> q_vector and ring allocation into a single function")
> 
> The commit doesn't mention switching from kfree to kfree_rcu and I 
> suspect that the igb driver is not actually really using RCU semantics 
> properly.
> 
> The closest explanation is that the get_stats64 function might be 
> accessing the ring and thus needs the RCU grace period.. but I think 
> you're right in that we're missing the necessary RCU access macros.

Alright, expecting a follow up for this.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
