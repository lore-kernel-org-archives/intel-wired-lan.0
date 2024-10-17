Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E637FD2126D
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Oct 2024 09:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9366D608DD;
	Thu, 17 Oct 2024 09:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNDFpsrk4SQP; Thu, 17 Oct 2024 09:46:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B90ED608B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729158385;
	bh=MOEgPurlM+/ygTfkiic8gRQ1VNIykSKGXnENroR1yqw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fgTpBjh+stSDj1N7j98Z2KscmO1Y1si3MVJSq+cKaG74w4VMal9d+9Efz+uFVdmPD
	 6m06+bkK4QEQeGgBYUkEFbdN7BnMZTIA5JK+Jor0LRQ5ntkgONczlSPBAwxQFaLdQb
	 VOTVbPFzXxGhbBWl0fdFV4y987w4cPrmu8tq6NnIFDygXaIiC/TKtYkZlSKANeJxTc
	 L2GBRbonRcm3vGD9aW+Jes/gsNq6oE14DaRwY/zy/ZIKrFCHbv7OWpOKN3e//g5zqQ
	 EObEOi6vLre11S7mrJ2iJzRR14IAlabl9yF9h+pmHL4Ez8uX4cgj1Vjp+0H6nvv+1h
	 XAwMBCgVDjFPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B90ED608B4;
	Thu, 17 Oct 2024 09:46:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2221927EF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 09:46:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F18781135
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 09:46:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5TvHFuR5mZIx for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Oct 2024 09:46:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5582480E53
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5582480E53
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5582480E53
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Oct 2024 09:46:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1AE3C5C5E66;
 Thu, 17 Oct 2024 09:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE6C4CEC7;
 Thu, 17 Oct 2024 09:46:20 +0000 (UTC)
Date: Thu, 17 Oct 2024 10:46:18 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
 Jan Sokolowski <jan.sokolowski@intel.com>
Message-ID: <20241017094618.GA1697@kernel.org>
References: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
 <20241003141650.16524-3-piotr.kwapulinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003141650.16524-3-piotr.kwapulinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1729158382;
 bh=/wuOGEEvNYquRC66hYVt0oRxhuEpdfr1+7xxF1GTnqc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dL/1hkfVN+NhWJWq4AV53lWwhY8V+IAndQd/BOUyF2VPaEXIsqSQBpR5USlpAHRtc
 yejEOSNCzegSxi1+MC/jnA2OuKBFrOlWtcFjGXkTLDBMlqtjMTqvcJfa+y8sCSz8mt
 SCwnYnzpSQi7lO+SdQwQSkfdkIQSPEUg74Hp0X3uhB4mmshG68mrzBYd7HYcs5AQfu
 o4AE0GuSiXy9DOkodxTJP2ABThzgBp50V5GtFx70VouPstB8XfbKLhctN0ejN0DaaZ
 i+hgr6GjeTmZ3ZZNCPld3Zdrj5lT3olBTaDMgPCNLQm9q3Pxs9OYJ5EQ+gh06aXYy+
 NW1ORwBxR6saA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dL/1hkfV
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v9 2/7] ixgbe: Add support
 for E610 device capabilities detection
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

On Thu, Oct 03, 2024 at 04:16:45PM +0200, Piotr Kwapulinski wrote:
> Add low level support for E610 device capabilities detection. The
> capabilities are discovered via the Admin Command Interface. Discover the
> following capabilities:
> - function caps: vmdq, dcb, rss, rx/tx qs, msix, nvm, orom, reset
> - device caps: vsi, fdir, 1588
> - phy caps
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

