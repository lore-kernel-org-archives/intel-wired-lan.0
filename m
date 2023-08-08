Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D6BC001DB
	for <intel-wired-lan@archiver.kernel.org>; Tue,  8 Aug 2023 12:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C420A81F8B;
	Tue,  8 Aug 2023 12:51:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C420A81F8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1691499110;
	bh=cQt1UrmrMjREqW7Yq3bX4u2kcIoCRVa0P7dY+C5MBAg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=bE/Qv5yq6Q2yyx8CA0D8XDiIUZKUmxxXMstuanrF/yxXMMQVX1VO01U0rjQI38bH4
	 1OMPdW/GtdtWru9mphbB17ar9njNJUSs2xcqZAUsRivD4w1uQlxDV+7fpIM+5A1wzA
	 AGLhYlU2746J2Ij8KYJgKqIsu1nQ1dUqFC8epikeCthzxKdh//JOBKZXdQbROzVUty
	 B+vQUI1wuwRVA6qI7F/Hm88nj+TBwhh0OwsOtiCGGymGDnnUr7VJEaDK/eu3kISvv1
	 j3SDz4LL6sNj42L9w/hbOSn1GVGeBtzVv7BDyiTPnhXh2zMZXwPzZwy/7D7vTbiQmL
	 ZfAL7zxKPjitg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIFaXr3b8UC2; Tue,  8 Aug 2023 12:51:50 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id E642881F88;
	Tue,  8 Aug 2023 12:51:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E642881F88
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 951241BF5A7
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 12:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EBE040B64
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 12:51:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6EBE040B64
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8Bjj6CG7cHiv for <intel-wired-lan@lists.osuosl.org>;
 Tue,  8 Aug 2023 12:51:47 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D978640B3B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  8 Aug 2023 12:51:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D978640B3B
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 220526253B;
 Tue,  8 Aug 2023 12:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9815BC433C7;
 Tue,  8 Aug 2023 12:51:43 +0000 (UTC)
Date: Tue, 8 Aug 2023 14:51:41 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Message-ID: <ZNI6XSBM2ULz0CZM@vergenet.net>
References: <20230807094831.696626-1-poros@redhat.com>
 <20230807094831.696626-2-poros@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807094831.696626-2-poros@redhat.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1691499106;
 bh=czHewSu/ClbRoBJAOohHZjA2+Uw0usYmOLRzJpX+Gbs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QqCClGIeqYURWbJwbJ6UGvvGF1nj31U1Zj6RfvULDPR4ISd6EiPAw3ibb6fbOjIp0
 ze8z+VMY1X7Fd4SmiuGnxRwjqg71xm54CA1Dd/yyMTPKVk39X0Wt2PVpbYANWGYIA/
 3R6JliH2Msy0JfbNp6fhnLKQpqpTiOU2I4rrt4yVxaH5pZR8/brkRNkEGNGocoVYku
 Lwu/iNj1/fnR/tiSo6xo5mVwceepYwH4C+aUcQ1T4qH1fnkZRpU+plXFDTWlkM7j3y
 rju9ki2Z3awM2RHPAAUGhWz/XmWsmRlvti2jLd8AG5qxYwqSC9STIQh12W6dMYGVge
 VbulLnCCgWYig==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=QqCClGIe
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] Revert "ice: Fix ice VF reset
 during iavf initialization"
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
Cc: slawomirx.laba@intel.com, przemyslawx.patynowski@intel.com,
 kamil.maziarz@intel.com, netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 norbertx.zulinski@intel.com, dawidx.wesierski@intel.com, edumazet@google.com,
 anthony.l.nguyen@intel.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Aug 07, 2023 at 11:48:30AM +0200, Petr Oros wrote:
> This reverts commit 7255355a0636b4eff08d5e8139c77d98f151c4fc.
> 
> After this commit we are not able to attach VF to VM:
> virsh attach-interface v0 hostdev --managed 0000:41:01.0 --mac 52:52:52:52:52:52
> error: Failed to attach interface
> error: Cannot set interface MAC to 52:52:52:52:52:52 for ifname enp65s0f0np0 vf 0: Resource temporarily unavailable
> 
> ice_check_vf_ready_for_cfg() already contain waiting for reset.
> New condition in ice_check_vf_ready_for_reset() causing only problems.
> 
> Fixes: 7255355a0636 ("ice: Fix ice VF reset during iavf initialization")
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
