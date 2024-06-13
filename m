Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C99C27C53
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Jun 2024 01:04:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40B1E605A9;
	Thu, 13 Jun 2024 01:04:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id crGOyGBgWUYd; Thu, 13 Jun 2024 01:04:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9493C608BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718240668;
	bh=fmRp+5xqoY4gkQ65+oAOquAeLeWsDhV1fX5+r8uwasM=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=f0JZgmYQZKTzFY8u2HjTyx+pgkG7uVFCEw41H6uJG3F5skxxLQ48WcLtSLQhniGXk
	 6MWVBm0l5xfkCIt7jaRe+VsGc5xhFWQ9CqtcIBATN+Wd7bg7zMqPnMTx8fweaEjoFt
	 8A7DRn1G6nkQKZeiJjAM3TMI7xRlid3gi32l+2rcTTbsqeo47Rzx8CgA6RPh2qU0u7
	 42ADuRLTaII6ZC3qhIuu1jOirTGNNR4YkyEpgFTWYD9QQBXxI7NPGPa/Xb8gVYLpGi
	 vaC9y5JvgSxh6cZEO2Xgjq4uBiwojd8DqJy50HWCzdMtzkYetDt8yT5M8ZO5PHVlxp
	 yLAbFqZOiRhBw==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9493C608BE;
	Thu, 13 Jun 2024 01:04:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 004CC1BF362
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jun 2024 01:04:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E15F640477
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jun 2024 01:04:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nC0FAaSBofPh for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Jun 2024 01:04:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=145.40.73.55;
 helo=sin.source.kernel.org; envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E812740015
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E812740015
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E812740015
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Jun 2024 01:04:25 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 26688CE1D44;
 Thu, 13 Jun 2024 01:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF86DC116B1;
 Thu, 13 Jun 2024 01:04:19 +0000 (UTC)
Date: Wed, 12 Jun 2024 18:04:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?= <ast@fiberby.net>
Message-ID: <20240612180419.391f584d@kernel.org>
In-Reply-To: <20240609173358.193178-1-ast@fiberby.net>
References: <20240609173358.193178-1-ast@fiberby.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718240660;
 bh=mUqdzlE2YgruqKLE1C3H5e4Ue5/0C4g77p2kLBoVhBQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=hkjYSL7aymQsKlAzq6Yed36s96sUhKIrGVugQoUZuBakuqy5MAFwMb9wDNXMy/8dk
 ACR/+jWtdDJu4jjEWklpD+2sovBrpkY5/eODSIi6kfyWz1nli+JOxE6wnCctmEFWeO
 P7AxEm7W6DW2X0F/fKIMb42o3P8ng7mledOqjOSE9uAdgtmBhgDnZQ/mVfkXuAGfVZ
 o3ufs+N3LwP7cUHVV4ENoAMn2SUtlp8fj0337DU8SoDxfUaBEq5y0Svneg2g95ypda
 4H7PQ/LRp3qqwbI/9f+7YKLgSJnCF65JdchVhtlas32NqbtfdnUW3dNtHpbEWdCkWV
 lT7lmYIFOYLig==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hkjYSL7a
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/5] net: flower: validate
 encapsulation control flags
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
Cc: Louis Peens <louis.peens@corigine.com>,
 Davide Caratti <dcaratti@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 linux-net-drivers@amd.com, netdev@vger.kernel.org, oss-drivers@corigine.com,
 Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
 Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, i.maximets@ovn.org,
 intel-wired-lan@lists.osuosl.org, Martin Habets <habetsm.xilinx@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, linux-rdma@vger.kernel.org
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Sun,  9 Jun 2024 17:33:50 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Now that all drivers properly rejects unsupported flower control flags
> used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
> checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.

Thanks for doing this work!
Do you have any more of such series left? Could we perhaps consider
recording the driver support somewhere in struct net_device and do=20
the rejecting in the core? That's much easier to extend when adding
new flags than updating all the drivers.
This series I think may not be a great first candidate as IIUC all
drivers would reject so the flag would be half-dead...
