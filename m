Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2E1CA101F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 12 Sep 2025 09:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7565E60BC4;
	Fri, 12 Sep 2025 09:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S9IVj1U24OFV; Fri, 12 Sep 2025 09:03:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B056D60BA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1757667827;
	bh=n9ueZOMw6Vxto3y5ge1MHZXRiwfqrfGjpu1eCXci/uE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=gaJhhIWuBzE5seBgoBnik3vMuUqV2Uo1XbhAoQIZTNuEmz6Iw6xNXkh44B2c1S6cx
	 6s38Vq8Yn3i8Jm4ACuN2hH+XPlXdIXv6fzjbDef0axca/wyToMiwElGs1y1OcieHBJ
	 iiI9PvYqrrWKkiDKR+xmqCjmSJhIqBeYoagQ8FIEfB/1cqBOOaaFHFEv8V9RdbmE7H
	 tPOqn9HypcbfPxMLVsKSfN/Ode/4jcViL4JNR3oTLEpTxJKVbhE1T5/4CGYfSahGmq
	 nJz5xjlbcHG9zGPyDJoTSJx9aENoRBFkaspfNSV0Z7i6kjnMfSfLpcfLR/eruXjSuq
	 J6SbgblLb6jXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B056D60BA4;
	Fri, 12 Sep 2025 09:03:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AA4CF12D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Sep 2025 09:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 91801821F9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Sep 2025 09:03:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jBn3mmY3D4OH for <intel-wired-lan@lists.osuosl.org>;
 Fri, 12 Sep 2025 09:03:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A93C5821F3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A93C5821F3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A93C5821F3
 for <intel-wired-lan@lists.osuosl.org>; Fri, 12 Sep 2025 09:03:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BE8DB6021D;
 Fri, 12 Sep 2025 09:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE52C4CEF1;
 Fri, 12 Sep 2025 09:03:42 +0000 (UTC)
Date: Fri, 12 Sep 2025 10:03:40 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20250912090340.GX30363@horms.kernel.org>
References: <20250829101809.1022945-1-aleksandr.loktionov@intel.com>
 <20250829101809.1022945-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829101809.1022945-5-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1757667824;
 bh=1dlRF1lAOSU3YZtQCMpzSHMErit4Ewn4JofzJYeYRKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G+FbYwUdWvxlSYV5YjgQM4Fbkz+6DzZX1dObtnZ6+HYXuI25jsyzevcM7g0DD8EJv
 qzSdoEVH/9PB4Lwt4vZXObPmpf52gqol1rm2w/9MOMStNrHZ31yXqgWuoBDo4R9NUR
 +9rPf5yw1nOm3KAyxl4NH+VVoqBrKzxMvk6MX8hozXOiWK4J6xq0ni8P25d2c7SdeO
 dckIrgWsVWDyV1QE8tu2FBbDm0GhmkUtUSRlxnY8Otrss6D1rRqpZEaKxhq0nbDaQo
 vajtLB+nMojncho+gJeLxwVy9uOF4/VeCI0+2jrIhB2afYY+J02ccfValADQbeChH+
 hG1WFI7FXT9Zw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=G+FbYwUd
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 4/5] ice: Extend PTYPE
 bitmap coverage for GTP encapsulated flows
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
Cc: Dan Nowlin <dan.nowlin@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Qi Zhang <qi.z.zhang@intel.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Aug 29, 2025 at 10:18:07AM +0000, Aleksandr Loktionov wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Consolidate updates to the Protocol Type (PTYPE) bitmap definitions
> across multiple flow types in the Intel ICE driver to support GTP
> (GPRS Tunneling Protocol) encapsulated traffic.
> 
> Enable improved Receive Side Scaling (RSS) configuration for both user
> and control plane GTP flows.
> 
> Cover a wide range of protocol and encapsulation scenarios, including:
>  - MAC OFOS and IL
>  - IPv4 and IPv6 (OFOS, IL, ALL, no-L4)
>  - TCP, SCTP, ICMP
>  - GRE OF
>  - GTPC (control plane)
> 
> Expand the PTYPE bitmap entries to improve classification and
> distribution of GTP traffic across multiple queues, enhancing
> performance and scalability in mobile network environments.
> 
> Co-developed-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Co-developed-by: Jie Wang <jie1x.wang@intel.com>
> Signed-off-by: Jie Wang <jie1x.wang@intel.com>
> Co-developed-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

