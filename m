Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8820AEC8742
	for <intel-wired-lan@archiver.kernel.org>; Thu,  7 Sep 2023 15:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3449E82893;
	Thu,  7 Sep 2023 15:46:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3449E82893
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1694101605;
	bh=DvGuo6v05Qj1u0Gbae6Sd8+qDlPHiTZTvM0wxI85C8k=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UBARkWdVsY3rxnjHU5slJx0G5QPHtw56biaDVXhbryn3T1uwHW0pMgS/630Zf11ik
	 43MruF6R+/Uh4Hr0IwPb9Yxu1YU1lsnWJDYrAGTc4gvkczC1u+y9RKFyJyQWcMOHkv
	 84krS6EaVGCqaYJvhHMVwHuA/duohSn5bJq2eEv8UqhzPUQJbP8dduvhPjFjPoogRA
	 fymNUXyiESTXcfULNyNeHqpfwpLW4Ul5NwmbqCOVLtdXlXpZfMgsOTewIypbU7G1mZ
	 5CzF2qit8zwtHzcg4XsXrBBUbba95p9QfHDc1ZyjCgokfqBvHKgNz3vrla3p9IDcYN
	 Ogeg+SpZfNP6w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JbGqtRwSH_90; Thu,  7 Sep 2023 15:46:44 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C7B683F5C;
	Thu,  7 Sep 2023 15:46:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C7B683F5C
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id D91F71BF2CC
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 15:31:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B056F4024C
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 15:31:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B056F4024C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MJg--oi6MA32 for <intel-wired-lan@lists.osuosl.org>;
 Thu,  7 Sep 2023 15:31:33 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52D5A40155
 for <intel-wired-lan@lists.osuosl.org>; Thu,  7 Sep 2023 15:31:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52D5A40155
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2DF9561232;
 Thu,  7 Sep 2023 15:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D352C4339A;
 Thu,  7 Sep 2023 15:31:29 +0000 (UTC)
Date: Thu, 7 Sep 2023 17:31:26 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Message-ID: <20230907153126.GI434333@kernel.org>
References: <20230907150251.224931-1-poros@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230907150251.224931-1-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1694100691;
 bh=76rEwfE/uTJS8ezcSl7+Wi3KuWBqHArCGxvgwyT7MEk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bRJ2pEom4OLSlDgiZnthU1HnTzpGSYXMHsgk2WtPSuO1ZGspi0pf2HMsPMv6BpmTo
 +3cutUabz0foPK3TwOkE0fplhrEY9seCaRtJejmBEdDJ9+vX3wCmGYdINRQs6OWNeW
 CNiNezaeXHXsKjr/wz6+Ybcw2+wKqfG/gj2fTess9yB8XeXN8HHL+u0HrG9T+5kksx
 G+LvWEQBPBb+nobha+ZqDSLnmqHy3U/3ZB0gi3vhq5RtCWgcgdkMDAqyMUouuzGEaV
 CTY7D1f0cIRQBl+mNDuSudE+IRvYo5N8tGIGie9uGuH73bB+vmlYKO4uv/GeS2g7SL
 w0eaw79B2mY6Q==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bRJ2pEom
Subject: Re: [Intel-wired-lan] [PATCH net v2 1/2] iavf: add
 iavf_schedule_aq_request() helper
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
Cc: ivecera@redhat.com, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 linux-kernel@vger.kernel.org, edumazet@google.com, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Sep 07, 2023 at 05:02:50PM +0200, Petr Oros wrote:
> Add helper for set iavf aq request AVF_FLAG_AQ_* and immediately
> schedule watchdog_task. Helper will be used in cases where it is
> necessary to run aq requests asap
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
