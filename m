Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4CF0C48291
	for <intel-wired-lan@archiver.kernel.org>; Mon,  5 Feb 2024 11:13:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 75A6C40108;
	Mon,  5 Feb 2024 11:13:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 75A6C40108
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1707131635;
	bh=4AZxYmqwaymIsc6yDoQXabBaBGDCzn/70UsTw1vrbFc=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=GRagElrEed2B1BKF971hpNd6dodVa3nXiMVPfNFcXQZx4PJZaAVoLYKqOCX35H05G
	 MZl92RUgipYi9OM1kmk+f9KG4rCsxEXaPmj8U8HlnOoiaHWhXHcSIcpqf7xzbpoFwS
	 rvRTbJ8L5i/4dyafA1oMIyNsjey6+VpsC70LONl6X6xDdWYelwFbylKm11aSBkm11o
	 TVREhfP1IA5rKfwAJR8SXH74rl/s0EBijLB1JUGHHtimMxYtZVJmDwaDT+zp7QwqOB
	 2JZnqu98LIq2q/FhYcH3OmPyDVwpCxQRe4GghdJuJjr99Dc6DEbDr7Ejo35VeT/ymD
	 FLcyslXkXISDg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P-RSPWbXNfDj; Mon,  5 Feb 2024 11:13:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 27EEA40168;
	Mon,  5 Feb 2024 11:13:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27EEA40168
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 9F17B1BF281
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 11:13:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8504981E98
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 11:13:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8504981E98
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRT1KYYZII4h for <intel-wired-lan@lists.osuosl.org>;
 Mon,  5 Feb 2024 11:13:51 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BED9181E86
 for <intel-wired-lan@lists.osuosl.org>; Mon,  5 Feb 2024 11:13:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BED9181E86
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 05B3860FF0;
 Mon,  5 Feb 2024 11:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF37C433F1;
 Mon,  5 Feb 2024 11:13:49 +0000 (UTC)
Date: Mon, 5 Feb 2024 11:13:47 +0000
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Message-ID: <20240205111347.GI960600@kernel.org>
References: <20240201154219.607338-1-maciej.fijalkowski@intel.com>
 <20240201154219.607338-3-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201154219.607338-3-maciej.fijalkowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1707131630;
 bh=4C6OaP/da9oAYOAJ5UNQpdN/3f2Bh3PxhZQD9fptMIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fDxROHG3q1HVAt47x/8I9P0mDDaOXFruXTQ1JghIJOh5m0mHSA6WJ6bPjEDcqCbmd
 BVhkDU1XdodR2VfwgCwIn/6KtiQV7EZgAjpHHtPKO6ej7m39oisjSInYURFExU+FeG
 zaUxzokuJUiZV2ywGhIo30B7o3uOrqcjfNXSvZvzXKhlqDZa0U4aHvMw/lX2Ck/Jxb
 CQuI5tLWPq3uyQyuMcqiFp6oefg304IqcYJKR3T7+8X5vdbL36fqz1YdOODAHAQ42N
 VZi+tp8YU3VrZR0ESBRqd6rFZYCXxa3RxHbrztIeCYcZ/VTMme8QpTglwRDL2p1NDz
 vXq18fVnkc0JQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=fDxROHG3
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 2/2] i40e: take into account
 XDP Tx queues when stopping rings
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
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, Seth Forshee <sforshee@kernel.org>,
 magnus.karlsson@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Feb 01, 2024 at 04:42:19PM +0100, Maciej Fijalkowski wrote:
> Seth reported that on his side XDP traffic can not survive a round of
> down/up against i40e interface. Dmesg output was telling us that we were
> not able to disable the very first XDP ring. That was due to the fact
> that in i40e_vsi_stop_rings() in a pre-work that is done before calling
> i40e_vsi_wait_queues_disabled(), XDP Tx queues were not taken into the
> account.
> 
> To fix this, let us distinguish between Rx and Tx queue boundaries and
> take into the account XDP queues for Tx side.
> 
> Reported-by: Seth Forshee <sforshee@kernel.org>
> Closes: https://lore.kernel.org/netdev/ZbkE7Ep1N1Ou17sA@do-x1extreme/
> Fixes: 65662a8dcdd0 ("i40e: Fix logic of disabling queues")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

