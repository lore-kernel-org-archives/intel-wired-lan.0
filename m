Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35686C27C6E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 14 Jun 2024 10:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E29D6843EE;
	Fri, 14 Jun 2024 10:40:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3NvNQRXujc38; Fri, 14 Jun 2024 10:40:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 45A89843E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1718361630;
	bh=4mIJ563gKzAv6KkUZixlCJruNlBb3l+igQPRzp5nWtk=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nVis8/5FxTEnxN4CWwFlQfDttZ/y6MTD1lNB2IyVQxqJhgs89nGMvY7VL9nF5uHay
	 TnUOb21UQH0GieCpGg6Z868qhyqOlexmuNvxoqNvLhqYuJb2N8/QCgwQDF/b/kEaYE
	 T7+wsGJQyzKIAzDZKasF/8kKIoiCiUn79REsUSKZMqojCUxO6w8xYHYJjnuUswecj2
	 umPbVtFB6gh6/L1V0LfPFf0CftChVbd/rFIUuK3ryHGAz47sqOYLI3Aegq0sj4THZu
	 F3Dkjtl4Z5QkpDyy7aSejsLfW3r35mFrUh1zFBrvSaOVgDAsJHxCptn4Ode+ewtClW
	 DEoEx2FH/k40A==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45A89843E9;
	Fri, 14 Jun 2024 10:40:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 904371BF33E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D36A843E8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tERkmY6K5A6O for <intel-wired-lan@lists.osuosl.org>;
 Fri, 14 Jun 2024 10:40:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CD56E843E7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD56E843E7
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CD56E843E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 14 Jun 2024 10:40:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0B20861F0E;
 Fri, 14 Jun 2024 10:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014A3C4AF1D;
 Fri, 14 Jun 2024 10:40:24 +0000 (UTC)
Date: Fri, 14 Jun 2024 11:40:22 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Message-ID: <20240614104022.GD8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-2-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-2-jesse.brandeburg@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1718361626;
 bh=ideFO4/M7kKA58e4ofze6hWyuI7bXN54Y2r8g2Zu/AU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YxZ6zplCMdcJbuXAOPl614YWUninQEg9D96edlRimoWyN9fabjO5JdlPQwr91Vw9b
 B4zDH+PxogQLBZHvMT65Ww1rx+pZIG5900X48spIYQqi2jiJGmggUaJrhlhFGJ9GtO
 PzZNeLhzHYZsMLtWm5Pq1RMS8K6a4MTOYIbeWgwjp+0sInNCPASr5pxD3F8vjxyU52
 X67r8ouI1k4WXEAXo9QfcPLtAzxFJWhyPIgwatcpgndmkijMrKXFZs5FgrT+UJd7TC
 VNvqq3XPuLPGM/V9ykrLqGZcAncwpxYMFEFKUFOCvbL+tTQW2hIixn2/IcPIxyMurR
 +oRuD7L9u+3Lg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YxZ6zplC
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/5] net: docs: add
 missing features that can have stats
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
Cc: linux-doc@vger.kernel.org, netdev@vger.kernel.org, corbet@lwn.net,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jun 06, 2024 at 03:46:55PM -0700, Jesse Brandeburg wrote:
> While trying to figure out ethtool -I | --include-statistics, I noticed
> some docs got missed when implementing commit 0e9c127729be ("ethtool:
> add interface to read Tx hardware timestamping statistics").
> 
> Fix up the docs to match the kernel code, and while there, sort them in
> alphabetical order.
> 
> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

