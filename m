Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B07C54E58
	for <intel-wired-lan@archiver.kernel.org>; Mon, 18 Mar 2024 18:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 20DCB40AD2;
	Mon, 18 Mar 2024 18:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zOlwi96jAY7z; Mon, 18 Mar 2024 18:56:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6569740AC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1710788169;
	bh=duuddDut5vlrYRvIm1t6aLVZyhCGlTS0L2ycdkckqvg=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=I+YCH5V3YyrqX/sET3ZJXg9AGiqiWZPWxAdUdCnYZGocpOhj9yDYRAG00se4YNoZx
	 OV4fTzodwpcj4SxKAf/adfYAjyHCz07FFo/uHRuOKlAQjSept5vdWgr9qCebCxrDqX
	 8Lf1VfsAUsxpYR7Cr6LFef8W5IzpAunJo8ZVjM0n27qo7uY5UdQFKlG0iTkK2GyTWM
	 jRVaqXnk7Apq5bkk8z1O2o8zBjjcykj/PmteXjgCemMN7s36TU+etCAiJ0Of4gLQrt
	 oP4pjhp8dNHFulmFkYBK38HfoJV+Rz30fbSbuXB79QxZO24DoB3oBv66pSVrkLVFrf
	 m2OAHk50tP37Q==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6569740AC7;
	Mon, 18 Mar 2024 18:56:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 87E2E1BF2EC
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 18:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80D01402EF
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 18:56:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Oe5Z_4BPflvT for <intel-wired-lan@lists.osuosl.org>;
 Mon, 18 Mar 2024 18:56:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 28B41402D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28B41402D8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28B41402D8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 18 Mar 2024 18:56:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B5CF860C6F;
 Mon, 18 Mar 2024 18:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F01EC433F1;
 Mon, 18 Mar 2024 18:56:02 +0000 (UTC)
Date: Mon, 18 Mar 2024 18:55:59 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240318185559.GF1623@kernel.org>
References: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105259.2450-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1710788163;
 bh=kYvnPw14h8YwaEiRVbmaKUb01aCbhWa/d3miwMevjjY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PDmCrTskdIiTzZR1A9vrrHmKD2qUtg/MwBGgCcND7gvMiXbKsNPRDajX5L5J+Evvj
 c4NQDzAc1rOzd4sxeYQYX64MIl3ARqhxyMOcBh3TCK297FKAn7lr4O3LU2vNzIzS19
 CaBjqT8EEW6+0Ow7XxrcFb7Wa1ayZjRs82dsO6Kp3GXjoxQyY4LME+iUvdeal5Y9ae
 nd4gvC0kJtAA3qMUUXJ+XxEISdG1yejZCPUPjcmFedxmfqblQQfgmvVVeiM0c3wVut
 N0/8N8gEH54/3O+bsya6N+2rdYfuXSX9cgQ+dqrJf9PjdnKNbJqmpJU780Ui+BgKJI
 06QYZowBGDGzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PDmCrTsk
Subject: Re: [Intel-wired-lan] [iwl-net v1] ice: tc: do default match on all
 profiles
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
Cc: netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org, Michal Kubiak <michal.kubiak@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Mar 12, 2024 at 11:52:59AM +0100, Michal Swiatkowski wrote:
> A simple non-tunnel rule (e.g. matching only on destination MAC) in
> hardware will be hit only if the packet isn't a tunnel. In software
> execution of the same command, the rule will match both tunnel and
> non-tunnel packets.
> 
> Change the hardware behaviour to match tunnel and non-tunnel packets in
> this case. Do this by considering all profiles when adding non-tunnel rule
> (rule not added on tunnel, or not redirecting to tunnel).
> 
> Example command:
> tc filter add dev pf0 ingress protocol ip flower skip_sw action mirred \
> 	egress redirect dev pr0
> 
> It should match also tunneled packets, the same as command with skip_hw
> will do in software.
> 
> Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

