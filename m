Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8BEC021AD
	for <intel-wired-lan@archiver.kernel.org>; Tue, 18 Feb 2025 19:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4796B82A3B;
	Tue, 18 Feb 2025 19:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KbCEgtJ5JJTM; Tue, 18 Feb 2025 19:36:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABFF0829B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739907404;
	bh=aeTGgOEKBvaZhvdsY6z5m57jyYmYlnJ0RbEv9zITP0I=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fejl4hnxQgBtxUWmSxUy6zlMwpXT+MWTz/8XxHi2/na2Yur3XXKDEuXAocFGcVXRL
	 zWEgrVc0/O+k/pU/Jzq3l/jWx+OQsVfkZ+Qap+R4IY8RwD13xoAYpKX000bu7pL5X3
	 SCsmGEaJzbkHJom7pq3RWP/enjPBEmiWWyvqZmzgvnttcM66NNq/WQRL8TI4Er16m8
	 w9KZkNK2+JnlUSPYEL8LFQlEgf19K/PWi6gQ6IOP7Tkf59DopDZuu3Y0uJeaThKSlD
	 LoudfVJwZc5M9Kgsgc8NwDFgLNJ0xSv/H/k4cviosvtlYr/a5BrNBk0vaUfKFKnpjT
	 HPpg/aWwgJ7gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABFF0829B6;
	Tue, 18 Feb 2025 19:36:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0A6D9E05
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Feb 2025 19:36:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EC1F160E3F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Feb 2025 19:36:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uXd-xJjYRo5A for <intel-wired-lan@lists.osuosl.org>;
 Tue, 18 Feb 2025 19:36:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=139.178.84.217;
 helo=dfw.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4BDF960A9D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BDF960A9D
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4BDF960A9D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 18 Feb 2025 19:36:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4F0E65C59EB;
 Tue, 18 Feb 2025 19:35:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43858C4CEE2;
 Tue, 18 Feb 2025 19:36:36 +0000 (UTC)
Date: Tue, 18 Feb 2025 19:36:34 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
 przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
 anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com,
 pmenzel@molgen.mpg.de
Message-ID: <20250218193634.GI1615191@kernel.org>
References: <20250217090636.25113-1-michal.swiatkowski@linux.intel.com>
 <20250217090636.25113-3-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217090636.25113-3-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1739907398;
 bh=sE/fUARRNHyp59sxR3Q+zmGjFoVYdfhTn6es8kCpY+M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Rg3HruaQUZRaemXPdH7hU1+YsgDYCL49kSeh7PZxgTZruKMxIzlASQKxq9CVBmSK/
 69o5gw10U5eX1CXLZ6D8vWHvkrz7Tyeoz4jwJIOTwh4/sgX3aKrD3u+Wm7IGolHt4i
 DW/CWP0cY+sqHYzKPVy8HZrlL0OXqEjXtV25zNe/9YfryW9GVkSCC9PCfCq+AkGyJs
 C2bsOBXxazBJijAH0RmoXv+lPwy5Fe84au5SavsLAEHcReHwjPjJh2VnIOjciAz+cm
 LcYgjDQVw0cIzCANk1NDe3FtRBGn15DGfXWn6uIVad7+I0cKM7LWZjU29rAsbeyWAU
 /EMs2+ZgrTEKA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=Rg3HruaQ
Subject: Re: [Intel-wired-lan] [iwl-next v3 2/4] ixgbe: check for MDD events
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

On Mon, Feb 17, 2025 at 10:06:34AM +0100, Michal Swiatkowski wrote:
> From: Don Skidmore <donald.c.skidmore@intel.com>
> 
> When an event is detected it is logged and, for the time being, the
> queue is immediately re-enabled.  This is due to the lack of an API
> to the hypervisor so it could deal with it as it chooses.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

