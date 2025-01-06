Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5479E77188
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 Jan 2025 11:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E57140292;
	Mon,  6 Jan 2025 11:44:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6OwaIQ18bgGb; Mon,  6 Jan 2025 11:44:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 86778403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1736163890;
	bh=/rnZvSClUVBjADUzHI/StB/O7wsUfErz0ZWszdk2PyM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gKFbY+jCHQHcMgu7hnj0tkh53xfSbU0xpjZpcLdvL3aGEcDFeWsDdSBqmDsM4rJfy
	 uvszMnjrQpagfa0isW4P9cZe2a5m+M44lTW7CbJw1QxYrZ0destDV3I8BwoFWuxZTx
	 IZrw9Z6OCoHE/c6nJHEfjq2hhe7fd0peOZMITxfzj5G8UFCOBlT/maO9dERyEOSBrT
	 BX24dSSOox4R3KNAZDJoP+QyNkdbhNoFPoeh57ihCv+JP3DfNgf9d2jkwPrR+/b8dZ
	 2pIsfHbz1xdkpbEriHjbO7bcARChzfr7Wmor7J09moiocc0ESrLqdCQkGM3RxjtIp3
	 AHn6N70JlihAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86778403E1;
	Mon,  6 Jan 2025 11:44:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A6CA6B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 11:44:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B31B606D0
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 11:44:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b4rvwLQOhZPu for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 Jan 2025 11:44:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 77E8B6060B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77E8B6060B
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 77E8B6060B
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 Jan 2025 11:44:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 998005C5A69;
 Mon,  6 Jan 2025 11:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562FFC4CED2;
 Mon,  6 Jan 2025 11:44:44 +0000 (UTC)
Date: Mon, 6 Jan 2025 11:44:42 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <20250106114442.GG4068@kernel.org>
References: <20241221184247.118752-1-linux@treblig.org>
 <20241221184247.118752-7-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221184247.118752-7-linux@treblig.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1736163886;
 bh=p8ZDWepWXOpMQdpmbhwoN5XIWa27UXLvf90nj9ikbLI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TH4/xq7iJ862hAZnKtj45kq1IEvzaVa8mDvaUS+l2+UFm/Pd00t9pnIZLV1O2egvf
 hAV7EF9eJYgrLnGisuAuqwUpkWP4VZJ8A3aitL69FP2b5AVvvzlaDB6+KT+uyw9HQn
 ZgnsUpfA1CWcBlxEJYn36hJYGglO/SyosA98leGm5OMnK/Z53FIufJFkmrf4wYEn//
 pZ6aY5e4eyt3Qjept78Gj4CgtFAK4Bpuoo+UClcFE2OPfur+kRm0Zuu9iL1G3rGXfZ
 xJsJIbB6SCab2Q8Oqt8AMZg1BDXW4HRrKMjoKon6bNtHiY34NgTQWSkWIpuocaI+o2
 YIMkWx5r7SnBQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=TH4/xq7i
Subject: Re: [Intel-wired-lan] [RFC net-next 6/9] i40e: Remove unused
 i40e_del_filter
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

On Sat, Dec 21, 2024 at 06:42:44PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last use of i40e_del_filter() was removed in 2016 by
> commit 9569a9a4547d ("i40e: when adding or removing MAC filters, correctly
> handle VLANs")
> 
> Remove it.
> 
> Fix up a comment that referenced it.
> 
> Note: The __ version of this function is still used.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>

