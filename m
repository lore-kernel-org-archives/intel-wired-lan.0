Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0219DD3E1BD
	for <intel-wired-lan@archiver.kernel.org>; Sat, 19 Oct 2024 08:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95BD2408AE;
	Sat, 19 Oct 2024 08:12:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2JJZkbWSA1h; Sat, 19 Oct 2024 08:12:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5207408A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729325520;
	bh=s42zsi8xaQr/uG/Cm7zGOukJcPyq8n5TawwDq6xUag0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i2KbmbIr5iU/lBHwcN4mNfispaxe+X0nCsA7Z5mPddwwcn5kX9IVOmMHYxX9Bkmd0
	 snCcqU9x/wkzTn65ExEz0DCVt9QaRH+Izox4IJr8MrppnS3SVJeplHUDGHf4ouYs/w
	 mTqqoD0nOFm/7Ns//QQCw6GJkMY3yTAuHilBZbyluFq/PggO7pBM4OXxrCyLFF4I5t
	 Ql4HlPO4R0OKblRbzv72sFYWi74hIj/NT0iKL/1Z+PVoZrAzhAgH792tjxPhNREwv2
	 RGkz2olqiNDGpZRglIxshq6xjv84dWJMl9Nh+fa3w1o+uWzyxV5Bv5E3u/mI/M0f3p
	 fFXuYTnz94uww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B5207408A0;
	Sat, 19 Oct 2024 08:12:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 90BFD27D7
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Oct 2024 08:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AE2E408A9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Oct 2024 08:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id phv0u9FK8aNI for <intel-wired-lan@lists.osuosl.org>;
 Sat, 19 Oct 2024 08:11:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=147.75.193.91;
 helo=nyc.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6AC57403A5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6AC57403A5
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AC57403A5
 for <intel-wired-lan@lists.osuosl.org>; Sat, 19 Oct 2024 08:11:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 8F3DEA402DC;
 Sat, 19 Oct 2024 08:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E1DC4CEC5;
 Sat, 19 Oct 2024 08:11:54 +0000 (UTC)
Date: Sat, 19 Oct 2024 09:11:52 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 brett.creeley@amd.com, mateusz.polchlopek@intel.com
Message-ID: <20241019081152.GH1697@kernel.org>
References: <20241017070816.189630-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017070816.189630-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729325516;
 bh=QmK0ulrEPKUfiR3BuJg+I7mX6gD2ELUneUo+Z2GLeqE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BVOPbAfpee01UvI712jROprLeQKgwR05F/bIXLFNs2dtDxmGi3PE5E2toswXowAn2
 6mtFhx3NUHvY9DehFnDzId3VfdGaOH4cpHOulCjZkPmVlYHxwzMFbZUVefyIAsFRPK
 3Npo1XWQM06UNh5UcvPPXk6tCOmrLkGH7GUpOHEn0wN4EVkps66mTRMTxAiIGalulZ
 nSHgJa2NIOYI+5/oo/DTipPc4e7A2Y4DXFTKisjip9MS/yScepP5IIRXfFqWyr6+XG
 3v1EERhLxMwIBr0S9FjRsTCPlC6+yorfe7srW1e76tqKEvmYgcaBnXltf3tPVQ+MtQ
 ZnrB5Pv5iFz8g==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=BVOPbAfp
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: only allow Tx promiscuous
 for multicast
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

On Thu, Oct 17, 2024 at 09:08:16AM +0200, Michal Swiatkowski wrote:
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when any VF is trusted and true promiscuous mode is enabled on
> the PF, the VF will receive all unicast traffic directed to the device's
> internal switch. This includes traffic external to the NIC and also from
> other VSI (i.e. VFs). This does not match the expected behavior as
> unicast traffic should only be visible from external sources in this
> case. Disable the Tx promiscuous mode bits for unicast promiscuous mode.
> 
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

