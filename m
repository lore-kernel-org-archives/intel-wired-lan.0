Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84102C982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 16 Jan 2026 16:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A8CC82993;
	Fri, 16 Jan 2026 16:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vliazhel-YVr; Fri, 16 Jan 2026 16:26:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEDC582978
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1768580811;
	bh=uTNSUuysb6nDLRWNCzQf2cdw4c/lwIxBseFlOWDP2YE=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lDGHJgoxi4rctm67SlJ8hnX+Tm/2T0bIOUEOtKJlZDRQNZOyNd/XKLHCaVBHYUsDe
	 SWIz58NoJqDLqIHR6TAHtoJcxBgpo5yR2fyDQ8fJu9G6pyg/kQMxnJCAhamlXAWDQQ
	 g9bwTpZmc6yVSOnOhC9U7VshYfW/r45WZxnJglo9dI8z/QJyZ+85H0PsnzJPDBZJK9
	 5984nmyepPkpqODsmoe5vSssFG0Xgu91VWc1VCnMIknjGB++HJK4yK4X+RpwlhGhCj
	 m+9+OrxiU9lCGEjLHrc02H0L0UgUBDI1cUm4cxUtkSjuzHPMze4PBcBlTtxDyenJPl
	 VMJWqGGADwqZg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CEDC582978;
	Fri, 16 Jan 2026 16:26:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E90BF223
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Jan 2026 16:26:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D92DD607FE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Jan 2026 16:26:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apT39nfyjS4M for <intel-wired-lan@lists.osuosl.org>;
 Fri, 16 Jan 2026 16:26:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4D0B4607FD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D0B4607FD
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D0B4607FD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 16 Jan 2026 16:26:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 62EA644215;
 Fri, 16 Jan 2026 16:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380FCC116C6;
 Fri, 16 Jan 2026 16:26:47 +0000 (UTC)
Date: Fri, 16 Jan 2026 16:26:44 +0000
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <aWpmxMH5PxEpxKtC@horms.kernel.org>
References: <20260113180113.2478622-1-sreedevi.joshi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113180113.2478622-1-sreedevi.joshi@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1768580808;
 bh=H/MeD4ThwDgkLhQV8hx2BQbg6JkHZVSJTD8llU6KeIU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lRZai1hi5GnZ7o5B0YlQpG6n3Y2lVrXlZSP6eukJ8jhsgruXFoxluFAsb/E+lS3SG
 J3cYxlw2Xs5ZH8i29vqcZCDrEwo/quW000za2dDk1wIMG0CP/I5sWUNlP2hzOvR56J
 u8upsirQ6PfB+B9fxWgBbgKVIWZ/A/rrVEO/xWkwA8foNa3VXPCWoFFQrzih9WzdS7
 drcxze0RYqBI4po16pPM3/J7xhZZE4d6n+yI4pbVAL2q3rxJpPxu2E8xzzjjG/MA8f
 hxku5FYa7DLmzZ4hh8CXy3VKHJsXe/v00aql0VTPgC9L0ELQFk8gxTNwCO49UI3kjk
 b6YQuM5hzVFqg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=lRZai1hi
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: Fix flow rule delete
 failure due to invalid validation
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

On Tue, Jan 13, 2026 at 12:01:13PM -0600, Sreedevi Joshi wrote:
> When deleting a flow rule using "ethtool -N <dev> delete <location>",
> idpf_sideband_action_ena() incorrectly validates fsp->ring_cookie even
> though ethtool doesn't populate this field for delete operations. The
> uninitialized ring_cookie may randomly match RX_CLS_FLOW_DISC or
> RX_CLS_FLOW_WAKE, causing validation to fail and preventing legitimate
> rule deletions. Remove the unnecessary sideband action enable check and
> ring_cookie validation during delete operations since action validation
> is not required when removing existing rules.
> 
> Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks,

I agree with your analysis.
And that the problem was introduced by the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>
