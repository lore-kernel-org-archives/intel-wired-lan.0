Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E369CAC587
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Sep 2025 17:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 504B241367;
	Thu, 11 Sep 2025 17:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MDApm-xn2574; Thu, 11 Sep 2025 17:06:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A535640EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1757610392;
	bh=3wxm6rMWFFw0fByxA8iNAOCKZsg2C/dcyNhUCWNukiM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jMH++1grScDDKwv2lsGT15qgA2p/0Y6UjfshcgwAGStanOM80RYjh/2mEAcgC4ruu
	 QVYb/x96yq507TwRHtTARulfuPiXViatQxwiK47SYzSCurXlKrXnSp7NgfzXI5eEvq
	 B00yrxPymdXIdcG1wjQnkMJt0VEE0ODRpgtTvyHwRd4ebcjy9068mz3wBcTft0M/yD
	 1wfNNxKRFZf/miQyT6luMsgVjHpAV38FksmGz8hXCkOC9jZwEZzxGcWvgBmHZrYrOm
	 Qupn0jdKmZiNZ0EqPIg2p+tRqaUjM0BCxrhDJeMxqd8DjxEDYSKz9GDZMiYPaCg4FH
	 FjRKUp3cd1RQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A535640EFE;
	Thu, 11 Sep 2025 17:06:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F103443
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Sep 2025 17:06:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47E9483DDA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Sep 2025 17:06:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gxc-fUqDcpA2 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Sep 2025 17:06:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A0F0983DA3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0F0983DA3
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0F0983DA3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Sep 2025 17:06:30 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CAB71601E5;
 Thu, 11 Sep 2025 17:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59306C4CEF0;
 Thu, 11 Sep 2025 17:06:27 +0000 (UTC)
Date: Thu, 11 Sep 2025 18:06:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Message-ID: <20250911170625.GQ30363@horms.kernel.org>
References: <20250910060108.126427-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910060108.126427-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1757610388;
 bh=tPhsK+qMBOKVRIOZUkZoLliEDrpfKbzruuBj587DFVA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WDs6pDfiOQ2sWYDtKNZW6ODvFdK++JfXXAXDbTZnUznBJYmUO+GwLxRsjgyey7Qc+
 3LsZs2kxB9gvn8OPhSh0bqOhFWyZ9EBTuXm/qTQhLFWI6LtCZoYJeGR0DbTGuU+y3x
 R8BK5RruCNS/jB+U5xPsn5PyHlCyf34yEkoJwZ6C8GDimQsFgmxwvpBliZw3mhDOXc
 Eg5X/kjKTS4nXiCmZpNFgVNDMBGxgVpqMNb7Z+4frR3xDvp3bnVbBwzG1sdEWn6ed2
 jT90++7iXS1uE7dkx/iEi5F4cMHCilaLYPcNumwg2PrpdC28X6pl30dKatD1gGP07w
 Sd9KtHQCAiDTg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=WDs6pDfi
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1] ixgbevf: fix proper type
 for error code in ixgbevf_resume()
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

On Wed, Sep 10, 2025 at 06:01:08AM +0000, Aleksandr Loktionov wrote:
> The variable 'err' in ixgbevf_resume() is used to store the return value
> of different functions, which return an int. Currently, 'err' is
> declared as u32, which is semantically incorrect and misleading.
> 
> In the Linux kernel, u32 is typically reserved for fixed-width data
> used in hardware interfaces or protocol structures. Using it for a
> generic error code may confuse reviewers or developers into thinking
> the value is hardware-related or size-constrained.
> 
> Replace u32 with int to reflect the actual usage and improve code
> clarity and semantic correctness.
> 
> No functional change.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

