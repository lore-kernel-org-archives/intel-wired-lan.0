Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C4CC7EE30
	for <intel-wired-lan@archiver.kernel.org>; Wed, 25 Jun 2025 09:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 747E98088A;
	Wed, 25 Jun 2025 09:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xz71vWr1-xxL; Wed, 25 Jun 2025 09:07:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD32B808A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1750842461;
	bh=CeZRzXdZoMR9dOPp6SJFAOhx7KSF0NkuqOTvDLvm/zM=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=pclKYj2s7YlSEbF99uRpf+dZJRKtb18pxh4tKInjc4AB4Znm0ztArgdFzVhi9rF8D
	 FRLtQO6xq1LBMfMv21C9xt3ST5WWCnocvqSfhr/7SU2kd6zdAqh8fFihpoONZpUiIE
	 eLvVNLLjaCxqcZSbygdNPltXRvMFTgOrEOxcuhYWDfABVF2/g6cCVEkxK7V9UuRDY4
	 MVOlwXA5Yzad8xBtrk5PEYVXvPt2pm+uUBvPe2zetldzw3LxcDU6Vxrw09PENlujGi
	 kw18x4yNE/ggyzSFcOEFLomvWrHPMvtoo8fdrPmgjsVmjpuEu2Qul2Tar4FfYB2xwH
	 //m9+WuHSNIMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD32B808A9;
	Wed, 25 Jun 2025 09:07:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70FC4154
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Jun 2025 09:07:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5704E60E50
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Jun 2025 09:07:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rI5mIBC_iy40 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 25 Jun 2025 09:07:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B978E60E14
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B978E60E14
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B978E60E14
 for <intel-wired-lan@lists.osuosl.org>; Wed, 25 Jun 2025 09:07:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1D8585C5B8D;
 Wed, 25 Jun 2025 09:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E4BC4CEEA;
 Wed, 25 Jun 2025 09:07:36 +0000 (UTC)
Date: Wed, 25 Jun 2025 10:07:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Message-ID: <20250625090734.GJ1562@horms.kernel.org>
References: <c856f16e6ab37286733174c0fcf12bc72b677096.1750807588.git.jamie.bainbridge@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c856f16e6ab37286733174c0fcf12bc72b677096.1750807588.git.jamie.bainbridge@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1750842459;
 bh=Wm/Qm170JnmvLoFVbqubHllu4LDDa//IX18AMk/c+g8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eUztFy2hS2wfsb8j77f2PVF4wB4X8iJeV6TVrk5esjbRwDb2d/nWAX7Qvgkencf+1
 LkOqcqQP36WgokaH0Rb4nb4VZPiyuLCttGVkE2+M9N07PTbboioekupa0qE8jXdssk
 ZWgLsKI4swkfWT0iGJpXtkppL87YR/otVdn740n9gKoumV1qt1v3gw5nqZqxJW5NMj
 oDKnzlGgCl7lJRkPWW7Cm+YretQ4cBy+ynGytnSY/GiKqs5QXvE5BthcpKF01dyyy3
 EJDVL6rAeK3loyeOgI500rxCGxYwH3DzNyak48FD9mGzmqPI6NqObJF/wlirXSqxCG
 PABnRRg0crxdQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=eUztFy2h
Subject: Re: [Intel-wired-lan] [PATCH v2 net] i40e: When removing VF MAC
 filters, only check PF-set MAC
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
Cc: Ivan Vecera <ivecera@redhat.com>, Brett Creeley <brett.creeley@amd.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Jun 25, 2025 at 09:29:18AM +1000, Jamie Bainbridge wrote:
> When the PF is processing an Admin Queue message to delete a VF's MACs
> from the MAC filter, we currently check if the PF set the MAC and if
> the VF is trusted.
> 
> This results in undesirable behaviour, where if a trusted VF with a
> PF-set MAC sets itself down (which sends an AQ message to delete the
> VF's MAC filters) then the VF MAC is erased from the interface.
> 
> This results in the VF losing its PF-set MAC which should not happen.
> 
> There is no need to check for trust at all, because an untrusted VF
> cannot change its own MAC. The only check needed is whether the PF set
> the MAC. If the PF set the MAC, then don't erase the MAC on link-down.
> 
> Resolve this by changing the deletion check only for PF-set MAC.
> 
> (the out-of-tree driver has also intentionally removed the check for VF
> trust here with OOT driver version 2.26.8, this changes the Linux kernel
> driver behaviour and comment to match the OOT driver behaviour)
> 
> Fixes: ea2a1cfc3b201 ("i40e: Fix VF MAC filter removal")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> ---
> v2: Reword commit message as suggested by Simon Horman.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>
