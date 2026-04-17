Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB00FF436A8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 17 Apr 2026 14:12:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D92260DF4;
	Fri, 17 Apr 2026 14:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O1P1LeGd7GHX; Fri, 17 Apr 2026 14:12:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A5A860DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776435153;
	bh=ryoRaDaB74hTSk9z9i+CfUNNbIGWXuhFT7wWMRQ+Gj4=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IqYTQ6I+ki4tcHuj9okQsiD4YK1Vv6mhJKkppkSc28NCnaZQ6Y5oGBmF6DemSOo+z
	 +qlAsdL3HxZjzzskVig19Xbg6KjkRWcLZ69x4twf+GmBvPjDLtENrQFOCxpuvnAy07
	 Tic6Edp9Che0lVJLXImg90X+IVMfRODhVDZs3H4Mrmfx+J6gUag6reWz4RuNzt+jEJ
	 ICbSSyNj0ZxGLiWSRq06tKB6/OmD8rXWVy04C3/2lkjvX6VxHJbOfoLTzP31GEli12
	 UBhUrQUe7lQp86C0VWKnDgcweKmfUhX15YtwSxB3tfdlKfYhZAMJtLJFcSMyVZtgf1
	 6/lRPRdgcz3+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A5A860DEE;
	Fri, 17 Apr 2026 14:12:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A54D7396
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:12:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B67F401A2
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:12:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id miY4kDSjGtVs for <intel-wired-lan@lists.osuosl.org>;
 Fri, 17 Apr 2026 14:12:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E775940026
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E775940026
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E775940026
 for <intel-wired-lan@lists.osuosl.org>; Fri, 17 Apr 2026 14:12:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A510A60138;
 Fri, 17 Apr 2026 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AABB3C19425;
 Fri, 17 Apr 2026 14:12:28 +0000 (UTC)
Date: Fri, 17 Apr 2026 15:12:26 +0100
From: Simon Horman <horms@kernel.org>
To: Przemyslaw Korba <przemyslaw.korba@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260417141226.GF31784@horms.kernel.org>
References: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415102511.1560665-1-przemyslaw.korba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776435150;
 bh=LPMz+wvVSpzcjh14fUZJ2kJ+IffLKQsd9VxWmRRI0n8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ClTow22DVaBwTimMV8DHetTUvp7mCeucU4ZJ+VkxVMIi/zc2PY40S+L0YmAlftSXm
 ZGLWBqUpypDz/SYjedkVL43tIR9XvPdV8ekidacuL3XNtLJFmm8/22zPPCa14ir3bA
 Tvnf7wK/+XHQbPQzO1BKyFJlKskv8Js8QVCcqfVeffso5INtzLqvJMzBVcEYzUGa5o
 ii+z/yNloQF1ippW3VwmQot17MXnLjd/sQuzUVkNM1QzO9ySiXKmHCuser4ERoTwkR
 UQa/PXddFaArajmTQX3i1VHmzCtfhyJwo5aTEvYwaLASZnTJmxFMTMfILVyMOCE8eb
 sdZ/exf+9m6GA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ClTow22D
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] i40e: set
 supported_extts_flags for rising edge
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

On Wed, Apr 15, 2026 at 12:25:05PM +0200, Przemyslaw Korba wrote:
> The i40e driver always supported only rising edge detection, so
> advertise PTP_RISING_EDGE, and PTP_STRICT_FLAGS to ensure the
> PTP core properly validates user requests.
> 
> Fixes: 7c571ac57d9d ("net: ptp: introduce .supported_extts_flags to ptp_clock_info")
> Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

