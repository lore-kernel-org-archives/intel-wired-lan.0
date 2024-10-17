Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC8BD21269
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Oct 2024 09:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B63C5405E3;
	Thu, 17 Oct 2024 09:46:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JetNYtx1sgJG; Thu, 17 Oct 2024 09:46:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAF0A406D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729158414;
	bh=VyFtvxjT+7VvKSD66qVgI5RRIM42vbXmX73sHwf3oHQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gP+kKjkVZt2rLTSaovi8MZHnBhPPYZmVagXMjYDKzWsoFWCszYqaYqL+WEZMWKCmQ
	 4Fnu4JmMXuqjgkXoWnHE2O1IjmUfo0QNJILLhwoPV55JI5K/7utLy8wfF62WhxDx1U
	 yZ1MTBWb6AbDeyMxLUWoEfgzYjzWe6DomTHXfyaFEezikwh9C6lXw7xYZmFULpUq1e
	 56/ENU/wA0w61vop6rXSCSWOvcCxcrUtBK9oX25mmBVSJm1gb9KL5wXbRm5I0e4QHp
	 4K+sS9WXJveP890TYe42pWLWkNgZ3mJRGhMXmsc8GXg+9VAXDqSQKz1BufEuncHdrc
	 +1mAhB8iPrcow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAF0A406D2;
	Thu, 17 Oct 2024 09:46:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9430C27EF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 09:46:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8149B405E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 09:46:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 082ReTjWvyAT for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Oct 2024 09:46:52 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9D9D64066C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D9D64066C
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D9D64066C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 09:46:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 720EA5C5613;
 Thu, 17 Oct 2024 09:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEEC4CEC3;
 Thu, 17 Oct 2024 09:46:50 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:46:48 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Jan Glaza <jan.glaza@intel.com>
Message-ID: <20241017094648.GB1697@kernel.org>
References: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
 <20241003141650.16524-4-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141650.16524-4-piotr.kwapulinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729158411;
 bh=1l8hI66BGVLNc+0kzZVbfU84Dxmxiv7JAX14gknBPXM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RunjBtwWZFKjU4cpcc9GYOC/09k2DNOxKoHJD9jCr9kEz41PwnOYc7wOlRddVBdCx
 ZkEpiCBJBp/TPoZeGvh4TRChbDhbJ3SY1l1Nk5UXutK7Z7/Vl10OgiJYa0usulGww/
 HBJa35cgjuxF7JnpBmKODqbs6gvX9jleRHUlUj1i66zLu8Y4ZKfQamUtvWLfAobyZg
 6k68fpLag9s7qlWUBFxg2SoOhz2f5tmiZk83nsH6Swd2QdsNKCJaQbZBvSZ3DNkGK2
 3MSB6Yj4GnB2DA6QgNtOAey5zGazu6J38FLX9akjiiUiuFVHBECkSiAkag2AZvvLXA
 Vmk2qS+nUqvrg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RunjBtwW
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v9 3/7] ixgbe: Add link
 management support for E610 device
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

On Thu, Oct 03, 2024 at 04:16:46PM +0200, Piotr Kwapulinski wrote:
> Add low level link management support for E610 device. Link management
> operations are handled via the Admin Command Interface. Add the following
> link management operations:
> - get link capabilities
> - set up link
> - get media type
> - get link status, link status events
> - link power management
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

