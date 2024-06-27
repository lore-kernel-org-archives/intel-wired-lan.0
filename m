Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A9BC2BD09
	for <intel-wired-lan@archiver.kernel.org>; Thu, 27 Jun 2024 10:29:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B74C410C4;
	Thu, 27 Jun 2024 10:29:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SL_nM-HISEuR; Thu, 27 Jun 2024 10:29:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 969C4410C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1719484171;
	bh=eHS7LFr3ygxN65FrABNXFVX0HTmvBqnyxGGQC1nxfUk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=HpcTkZzle6J1Oxe4Wov0JSr0r4irbzmWfT7u8iG9p8tpYP7uYctNkCc47S69P4r7i
	 V0fdRSTnt2x+Py+H6jfIwMeC1MK4wnKJs0Bd9hycftkLszru8iaJBC73JD79uKDigL
	 NsIx+vDpBSfe/rYVXziiX4zE0Qx5l9TdTx/oeeQzjIDCMxdNBwZpGA0mAY0oHOk19p
	 YQFsxAcaB/2294UdAMdun3Q4fcExEGh1y4vpazoBIhQa2vLwvj3Rip5JM207ZWQMtQ
	 rN6ScNspS/BsZVY2PNf/jw9qRgD3aWYXQxRM7DI/ELieuOaIw1YbCFcdqooC0s30we
	 8MPCXhDacSHPg==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 969C4410C6;
	Thu, 27 Jun 2024 10:29:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id AF09F1BF977
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 10:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9AB4A41AA1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 10:29:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ovgSlDWL1vf for <intel-wired-lan@lists.osuosl.org>;
 Thu, 27 Jun 2024 10:29:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A6B2041A92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6B2041A92
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6B2041A92
 for <intel-wired-lan@lists.osuosl.org>; Thu, 27 Jun 2024 10:29:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 64B5961E16;
 Thu, 27 Jun 2024 10:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C9AC32786;
 Thu, 27 Jun 2024 10:29:25 +0000 (UTC)
Date: Thu, 27 Jun 2024 11:29:23 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <20240627102923.GE3104@kernel.org>
References: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624080510.19479-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1719484167;
 bh=B6qLxuM0d2P3IdWwCmCeueHLfRQ5hCafTkG1Z8S5GUs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S1tWa1LIsJ2whl8aNX46uMj0ohEv/5SehBNcAO10Hut537l9b+lj5RLx4o/lErS2n
 BBFOErFdh0oP5YU+YryMquGFHk7yTHhjv6ivYVNY9pk9WIMPLWcvEzhbnS7TUTIPZK
 wFQCX2QPgKbK8ivimn2yIwCiz6yb7DHYkH82pb6n+vpEw8TKhC3wr6ZkNm6MVq2UKX
 EBEqzI4L/GJZQ6yiKOz9UtdUpNBjI77f77x3L1IgPKW1XFXyP309yC/JfJawzEFqoo
 mSFeIkrDvJ7/qy1Y7hKkcTVW9LPDnpfEgUbwZJwZTt2muosc62Gjl6qSLbjlTBv/s8
 g7jrrA/LWzHUQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=S1tWa1LI
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: remove eswitch rebuild
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
Cc: Wojciech.Drewek@intel.com, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, Jun 24, 2024 at 10:05:10AM +0200, Michal Swiatkowski wrote:
> Since the port representors are added one by one there is no need to do
> eswitch rebuild. Each port representor is detached and attached in VF
> reset path.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

