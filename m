Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC729CD5BB1
	for <intel-wired-lan@archiver.kernel.org>; Fri, 22 May 2026 08:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8C402429B8;
	Fri, 22 May 2026 08:35:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Izp_un4ohGf6; Fri, 22 May 2026 08:35:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DF5DD428D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779438924;
	bh=JoM/uClrQl+2MRZinFsOHtBmLH1eKT3bd0enlbi9aRY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o55IBJFrMRi88elwOyKq+IntAc/7lfabJwah73PTib/wZmuQLKQmFJ8vHklyKRUgO
	 ETYhBmSJZWMcyPwlQ/nG31KxVlDdAJU0SJ7XVxXfP/umSyrCf/OhCZibc1RAqmBWAc
	 WMmN2/O/mPwgBYhYFC/guKqa7SjQGD+J1+I7zGr2tEAGBXTv1Kl4hsGlLDq9InuN9F
	 QXZe7NigLYXB+F81t15ZmB5fIe0NmQjMCudfrtaZsjJjYDyefQWwbSl1EK7RMn1qDs
	 CbSXDAmm1XG1zSdgqigZ0vvhSOZSFQ2oJoTpdh92I4tbp1McR+vFj1HOrkivXAfbrR
	 2ncVhyIDBiFoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF5DD428D6;
	Fri, 22 May 2026 08:35:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 48F5D265
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 08:35:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A0FE85353
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 08:35:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQBUKMdhAj0R for <intel-wired-lan@lists.osuosl.org>;
 Fri, 22 May 2026 08:35:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4E31385351
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4E31385351
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4E31385351
 for <intel-wired-lan@lists.osuosl.org>; Fri, 22 May 2026 08:35:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D12C860138;
 Fri, 22 May 2026 08:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C792E1F000E9;
 Fri, 22 May 2026 08:35:18 +0000 (UTC)
Date: Fri, 22 May 2026 09:35:16 +0100
From: Simon Horman <horms@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 magnus.karlsson@intel.com, kuba@kernel.org, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, jacob.e.keller@intel.com,
 Sunitha Mekala <sunithax.d.mekala@intel.com>
Message-ID: <20260522083516.GH1506108@horms.kernel.org>
References: <20260519105637.839438-1-maciej.fijalkowski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519105637.839438-1-maciej.fijalkowski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779438920;
 bh=JoM/uClrQl+2MRZinFsOHtBmLH1eKT3bd0enlbi9aRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=c1K5dVotxN+kvD2QRcHywC3QMDJryMa3IF96pTlLSzJtMPiHJzqP3tq53QoGcF0tM
 +sTkOq3xVOMmm2QYxL9hbP7m7UC+fx649XFdhj76rJ37W9rj+PkhMOe1qHj413hWju
 6FSagutMcXPu6ibeE+MAlx7MDZb5NcdLuG2sJsd9zVnGCC6w3y53HALI8SiGg0rwH6
 Jmm0S/bTIne/zjIVxnjNj+AVFH1deGtY8K3vEDZv2uJsaxpM3mldrG24I3K/JT6TkB
 OYcyekqCCwLeN2LSshpEZgQ6jJIjH3L2J/jsQbTuBSE93Q+SOtDIWYJz/cmNDg94kq
 WGQ5Grs0dWupg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=c1K5dVot
Subject: Re: [Intel-wired-lan] [PATCH v3 iwl-net] i40e: keep q_vectors array
 in sync with channel count changes
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

On Tue, May 19, 2026 at 12:56:38PM +0200, Maciej Fijalkowski wrote:
> For the main VSI, i40e_set_num_rings_in_vsi() always derives
> num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
> the user requested channel count in vsi->req_queue_pairs and the queue
> setup path uses that value for the effective number of queue pairs.
> 
> This leaves queue and vector counts out of sync after shrinking channel
> count via ethtool -L. The active queue configuration is reduced, but the
> VSI still keeps the full PF-sized q_vector topology.
> 
> That mismatch breaks reconfiguration flows which rely on vector/NAPI
> state matching the effective channel configuration. In particular,
> toggling /sys/class/net/<dev>/threaded after reducing the channel count
> can hang, and later channel-count changes can fail because VSI reinit
> does not rebuild q_vectors to match the new vector count.
> 
> Fix this by making the main VSI num_q_vectors follow the effective
> requested channel count, capped by the available MSI-X vectors. Update
> i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
> vector topology is refreshed together with the ring arrays when channel
> count changes.
> 
> Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
> retains its full queue capacity.
> 
> Selftest napi_threaded.py was originally used when Jakub reported hang
> on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
> i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
> identity and threaded settings survive q_vector reallocation across
> channel-count changes. This is achieved by using netif_napi_add_config()
> when configuring q_vectors.
> 
> $ export NETIF=ens259f1np1
> $ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
> TAP version 13
> 1..3
> ok 1 napi_threaded.napi_init
> ok 2 napi_threaded.change_num_queues
> ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
> Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
> Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
> v3:
> - address UAF when ring arrays where freed before q_vector's ring
>   containers (Sashiko, Jacob)
> - remove bool params from alloc/free array routines (Simon)
> v2:
> - NULL vsi->tx_rings in i40e_vsi_alloc_arrays() (Sashiko)

I notice that there is an AI review of this patch available on sashiko.dev.
However, I believe that flags a pre-existing problem that is orthogonal to
this patch. o I do no think that review should block progress of this
patch but rather be looked at in the context of possible follow-up.
