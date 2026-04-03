Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D72E7E37F
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 12:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5FD27608C4;
	Fri,  3 Apr 2026 12:28:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xMNbA5HcxvUx; Fri,  3 Apr 2026 12:28:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D64A8608D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775219313;
	bh=ZH8ZytRXdyFwyPojfULAQSMUQCklFBLMAatkOZCirnA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p6gV0gAgAlu/NxoLWjVj02uRM0mpDnvBHaBd+wg/KbdHOU5TkUgOuDxiRDuFMaq+t
	 9WIuuU8UJwJA9836g3AmKN6zg27+XHn4Ov1YPZ+RcVrvVrT2mOb0EM1xbCXVNtwFHU
	 jzSBBOl0qmB8L4YI9NZQRuh3X/dPuuU4SrhQicPE8IBrGqj+wyQM8b+ITM1XzQ02aY
	 w+y/92ygxaSjlUTvIJ/RBgbnsj9ciVchiawKRGMR/FYCxafrNqGA2eV44Yjc0nhN2J
	 1xLPj/qdmwTSOdWIteeo9tQOt7WWkoJEzd1mEryD+Gayuns45ooGw9qk1NktT6a1Vo
	 pK1ymYGLtS39w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D64A8608D8;
	Fri,  3 Apr 2026 12:28:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id E90BF2CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C552840DAB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:28:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Poydjxfe5oUO for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 12:28:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2714C40DA6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2714C40DA6
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2714C40DA6
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 12:28:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BE2D60008;
 Fri,  3 Apr 2026 12:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB730C4CEF7;
 Fri,  3 Apr 2026 12:28:29 +0000 (UTC)
Date: Fri, 3 Apr 2026 13:28:27 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Marcin Szycik <marcin.szycik@intel.com>
Message-ID: <20260403122827.GA85281@horms.kernel.org>
References: <20260327072332.130320-1-aleksandr.loktionov@intel.com>
 <20260327072332.130320-5-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327072332.130320-5-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775219310;
 bh=F8iAS6pGjjZT/iyWHDVcTqPA4wqEVTbdVw3IDnLF1gY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sbmE9LQfsSQmlOrk1+mqZopEkGj6UWlRErrTj/zoKIqPbXRnvOVtJoPvk889CM3dW
 K/I40NZC5kkc2UmIF9hR6uKWDoL2I36noxC86NJnHEPwSMuBOBREPiO6b663fIvvy5
 r8HyljcB/XAr05GemW855eifOOYWl9z27l/UiHAIzXncPBXJLo2MTDtQWS9WcdBBUK
 97Z2j1ppg18/H9Te41Kq49R+d4TfhHoaW8AA5e7B97phIsTImSRadc40I65fsXUKQE
 FcGs2rLBvhDfla91t++y1hfFo1qedsBPU8Sfe6VbRO18aKGI86IdpH2Iest4rJAuiN
 HE2pocYfAMkkw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sbmE9LQf
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix setting promisc mode
 while adding VID filter
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

On Fri, Mar 27, 2026 at 08:23:28AM +0100, Aleksandr Loktionov wrote:
> From: Marcin Szycik <marcin.szycik@intel.com>
> 
> There are at least two paths through which VSI promiscuous mode can be
> independently configured via ice_fltr_set_vsi_promisc():
> - ice_vlan_rx_add_vid() (netdev op)
> - ice_service_task() -> ... -> ice_set_promisc()
> 
> Both paths may try to program promiscuous mode concurrently. One such
> scenario is:
> 
> 1. Add ice netdev to bond
> 2. Add the bond netdev to bridge
> 3. ice netdev enters allmulticast mode (IFF_ALLMULTI)
> 4. Service task programs promisc mode filter
> 5. Bridge -> bond calls ice_vlan_rx_add_vid()
> 
> Crucially, ice_vlan_rx_add_vid() fails if ice_fltr_set_vsi_promisc()
> returns any error, including -EEXIST. This causes VLAN filtering setup
> to fail on the bond interface. ice_set_promisc() already handles -EEXIST
> correctly.
> 
> Fix by adding the same -EEXIST check to ice_vlan_rx_add_vid(): if the
> promisc filter is already programmed, continue without returning error.
> 
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marcin Szycik <marcin.szycik@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

