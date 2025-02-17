Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDBEC021A9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 17 Feb 2025 16:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C86B60A7D;
	Mon, 17 Feb 2025 16:17:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P71k30bqZeDI; Mon, 17 Feb 2025 16:17:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A07560675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1739809032;
	bh=hgJk8c9gI577dnH0u+BuUFft5fgX3jdtDDKFtBimGb8=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpvpCcA7zvBtbbT8RYN00OdNymvAOct6uTCdiG2KTR4CDHdAQ67ybX9/Z3aQhOTS4
	 dGASu2rIEYDu992nTH9c+9ifPjnkwoKh6L9fjuWRFzHkFTRd65WiwTm/cJtwf2dzr/
	 sjxawlK5bJu63C2vQ7SjpZcDrvoLpJ4vT7X2xR4CRBsKYUlLHSJs3SOl8jysvR0zfo
	 uRPEoY7RjYJXiDg/NljYWDbFrwvY+2p5LF4Z3pLATI9fgN99DHCIXLsQAU8hFAfwJz
	 OKsI/m/gt1Drp2/xrdXzd9XNhnSp9gdG3+mO8K+ilVdIVU98TCPsuRMNEU0clKiK0r
	 oEeA/U8MUCxog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A07560675;
	Mon, 17 Feb 2025 16:17:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5FDD4C8
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Feb 2025 16:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F7A14083B
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Feb 2025 16:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A5JBY4gQD8WW for <intel-wired-lan@lists.osuosl.org>;
 Mon, 17 Feb 2025 16:17:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 65D6B4081C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 65D6B4081C
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 65D6B4081C
 for <intel-wired-lan@lists.osuosl.org>; Mon, 17 Feb 2025 16:17:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 13EA6A40BF0;
 Mon, 17 Feb 2025 16:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FDFCC4CED1;
 Mon, 17 Feb 2025 16:17:05 +0000 (UTC)
Date: Mon, 17 Feb 2025 16:17:03 +0000
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, madhu.chittim@intel.com, przemyslaw.kitszel@intel.com
Message-ID: <20250217161703.GO1615191@kernel.org>
References: <20250214171816.30562-1-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214171816.30562-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1739809027;
 bh=dbN+k2q6EShMVUAh4Ch1jkSdAxdn32s4LBsHWf0F1dM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W6ZT7Owl77PCw1wceouhGsK6E/A95VPA5IbW0E/cpdtIX5vm6RxC8p5246AACe7Ay
 wSzwHzHULZEk3fQ3/8PaYZBuxui6x8tx+dGLcrFZMM327nJY6Gin7rkzh3WGWMdOBQ
 OkE+jvLxVEeN+fYwT/9WQGX5qTVUXk9qAbswIopCdfam0PkYc3xwiiZ2acKm5g2ETw
 P6MEkkh0+mVdI+78Bi0AxO3ShmlGRytI3Z1i+L8Dr5cIBnadqRX79vvpISRbc24tok
 JNZL4R//bAfbNoie4gko94pI3fHsUmuQhNREMOoVCKHyPnsgGd9Env2V2zRKavsQga
 kiroYxa3LSsvQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=W6ZT7Owl
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: check error for
 register_netdev() on init
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

On Fri, Feb 14, 2025 at 09:18:16AM -0800, Emil Tantilov wrote:
> Current init logic ignores the error code from register_netdev(),
> which will cause WARN_ON() on attempt to unregister it, if there was one,
> and there is no info for the user that the creation of the netdev failed.
> 
> WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
> ...
> [ 3707.563641]  unregister_netdev+0x1c/0x30
> [ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
> [ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
> [ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
> [ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
> [ 3707.563769]  pci_device_remove+0xab/0x1e0
> [ 3707.563786]  device_release_driver_internal+0x371/0x530
> [ 3707.563803]  driver_detach+0xbf/0x180
> [ 3707.563816]  bus_remove_driver+0x11b/0x2a0
> [ 3707.563829]  pci_unregister_driver+0x2a/0x250
> 
> Introduce an error check and log the vport number and error code.
> On removal make sure to check VPORT_REG_NETDEV flag prior to calling
> unregister and free on the netdev.
> 
> Add local variables for idx, vport_config and netdev for readability.
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
> Changelog:
> v2:
> - Refactored a bit to avoid >80 char lines.
> - Changed the netdev and flag check to allow for early continue in the
>   max_vports loop, which also helps to reduce the identation.
> 
> v1:
> https://lore.kernel.org/intel-wired-lan/20250211023851.21090-1-emil.s.tantilov@intel.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

