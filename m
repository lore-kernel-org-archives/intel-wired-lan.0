Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BC5C5B572
	for <intel-wired-lan@archiver.kernel.org>; Thu, 13 Aug 2026 13:41:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19928810F9;
	Thu, 13 Aug 2026 13:41:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aTEOyrV5Gkmu; Thu, 13 Aug 2026 13:41:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D9238128A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786628476;
	bh=9EE/BH3UiuwcrIxxvRbbgXCdLnjpoDTMD4n+FkY/R8o=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dL4IB3DVP9Fg8GyUbHZ47QWb8J/2QYiFPm/GMfT2rp+gCZnLzTucD0fCyfJQj1gbe
	 ryQdN76rwuQv9EGTbITl2ZJr9EcM9snnDPmMdKmi+EzdB9fdvSjPMgiil3+JIp9F8j
	 U2Mps0Ugm73b3cq0xfuWoFQOS3u4mRfG0PlyIFeYcchyPHUuHpuZm/XURh8fPh+n2F
	 OXCqF+BRl3x7GQqg8JzA6ZzG4Trn9iXTTXm59xzK3yVyNOgcFlIgFzrPlNcCOQxB7f
	 o0sgSBkoN1SPkNvUUIyCPjbYd/o28kAGHQpxPE7EIJh5RZHMj0w6nBaxtD8DDjY1Se
	 jFVxka2NBVveQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D9238128A;
	Thu, 13 Aug 2026 13:41:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BAC83A4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 13:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 246004085B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 13:41:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C41XQ4lwK8ZH for <intel-wired-lan@lists.osuosl.org>;
 Thu, 13 Aug 2026 13:41:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4634740827
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4634740827
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4634740827
 for <intel-wired-lan@lists.osuosl.org>; Thu, 13 Aug 2026 13:41:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 586A160A9E;
 Thu, 13 Aug 2026 13:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB4C1F000E9;
 Thu, 13 Aug 2026 13:41:09 +0000 (UTC)
Date: Thu, 13 Aug 2026 14:41:08 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, joshua.a.hay@intel.com
Message-ID: <20260813134108.GC265046@horms.kernel.org>
References: <20260811171751.22165-1-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811171751.22165-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786628472;
 bh=9EE/BH3UiuwcrIxxvRbbgXCdLnjpoDTMD4n+FkY/R8o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BfACpuDe5G8qX7sXQsqAK7gc+rT3WtYryujv1ByOx0sFeKgZRL2D/yRcGBOrClB2E
 qmTY4WFCODY/ZB5YoXB6bHsdjpWpJgTlprQiwb5LcQs/BFsHcUpMSoGqJ1LEBfHbH4
 FhMhPSz7/IyNzTNoiioswWH54ID3Df+3jvBKBQL+mcdW7dyl4QMuRfQ0mEDZyIyGJZ
 Ri3rljowrqmzPDI2go1esnXjSWiM1aF+qIt5bkLBiUkuyXEHwF5vi39ANePS50U2Wj
 fJTntFGeCDVKeMTFMz6ADvV6Ebo9chsxYK2tIKNuVheNts1xTS9ICFtRwtVCQrtVF1
 YvVp32Y1IpMcA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BfACpuDe
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix possible race on
 remove during a reset
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

On Tue, Aug 11, 2026 at 10:17:51AM -0700, Emil Tantilov wrote:
> Reset and remove can race, leaving NAPI registered and enabled:
> 
> modprobe idpf& sleep 1; ip link set eth0 up& rmmod idpf
> 
> [145561.805104] WARNING: net/core/dev.c:7699 at __netif_napi_del_locked+0x11a/0x130, CPU#30: rmmod/22393
> ...
> [145561.810238] RIP: 0010:__netif_napi_del_locked+0x11a/0x130
> ...
> [145561.817678] Call Trace:
> [145561.818125]  <TASK>
> [145561.818653]  free_netdev+0x110/0x2a0
> [145561.819109]  idpf_vport_dealloc+0x452/0x460 [idpf]
> [145561.819668]  ? enable_work+0x9f/0x100
> [145561.820133]  idpf_deinit_task+0x51/0x70 [idpf]
> [145561.820694]  idpf_vc_core_deinit+0x32/0x170 [idpf]
> [145561.821193]  idpf_remove+0x40/0x200 [idpf]
> [145561.821667]  pci_device_remove+0x40/0xa0
> [145561.822132]  device_release_driver_internal+0x1a9/0x210
> [145561.822691]  driver_detach+0x4b/0x90
> [145561.823161]  bus_remove_driver+0x70/0x100
> [145561.823721]  pci_unregister_driver+0x2e/0xb0
> [145561.824207]  __do_sys_delete_module.constprop.0+0x190/0x2e0
> [145561.824715]  ? kmem_cache_free+0x312/0x550
> [145561.825213]  do_syscall_64+0xc8/0x6b0
> [145561.825709]  ? clear_bhb_loop+0x30/0x80
> [145561.826216]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [145561.826602] RIP: 0033:0x7fe628130beb
> 
> Make sure to call idpf_vport_stop() in idpf_stop(), irrespective of the
> IDPF_REMOVE_IN_PROG state, to allow a reset racing with remove to tear
> down NAPI in idpf_detach_and_close(), which runs under RTNL lock.
> 
> Fixes: 2e281e1155fc ("idpf: detach and close netdevs while handling a reset")
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

