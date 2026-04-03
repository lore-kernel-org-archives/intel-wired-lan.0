Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF26E85367
	for <intel-wired-lan@archiver.kernel.org>; Fri,  3 Apr 2026 13:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 001B460A43;
	Fri,  3 Apr 2026 13:32:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jFhcYHmEc9Hv; Fri,  3 Apr 2026 13:31:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D47C160A3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1775223119;
	bh=rMRche1TjGKGDM/gw1Bt1qwAJf1fmDRQ6ER5qTYhAAo=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hip25o2hB/PaKeWR/SIf5uaMwul7JIyBWh4ef6i69X+VjEoze8P29FJwe7vUOVMTJ
	 F6/gQ1XE4QZQ5Og1r9EsqGjm7n9Clb8bIPN6gNYWCAGdNBuQt7xDW8HfRzh3w+iGpn
	 vGCwkeaqHOcTAtWsvVVOxFlTw+KNpjLIfmsM8ODCcpUPx0b9/RA70K1NVyjRb6GaLx
	 AWmJHHKPqmKMcu08Gw5kW1/GSft/H9LdVaQWVf0YAsTvnk92bac29+wpNVhtl5iwG6
	 rd3c5n1rYHCV8gc71zdzwQ1xoJQM6Or/SHFcOppxv/R9xwpOXVFgW9cB2TU0FHV/p5
	 DnhZGFB53FYDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D47C160A3E;
	Fri,  3 Apr 2026 13:31:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C9CB22CC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:31:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB5D6402EB
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:31:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Ph_NYVAhbDG for <intel-wired-lan@lists.osuosl.org>;
 Fri,  3 Apr 2026 13:31:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 23E0A4003D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 23E0A4003D
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23E0A4003D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  3 Apr 2026 13:31:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 21DC460008;
 Fri,  3 Apr 2026 13:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84E1C4CEF7;
 Fri,  3 Apr 2026 13:31:54 +0000 (UTC)
Date: Fri, 3 Apr 2026 14:31:52 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260403133152.GC113102@horms.kernel.org>
References: <20260327073046.134085-1-aleksandr.loktionov@intel.com>
 <20260327073046.134085-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327073046.134085-3-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1775223115;
 bh=f+FPwYUmQsv8W+rNwDj/HraJ56DYasUUBfwEcEVRSuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UI+QdltdOkB4RPobugji1w+yk2S7QVQpn3xp0RzqDUgFypF2jdk/odxZPmP4IvlJG
 AtR188GhlcKCni4pg2yBbe8JKMS2mqgSEPeJYSTxnRlSAxMzHUoTaTfwOnD36iat6w
 Ro1H8xWKcCr9wzRlKMoFBEcsU9xx4asgiBeO1evqG0IHZbGIKh1EDt6p6xUAta04ev
 zbqR6FnA0+r2AqvC3VfDFRVMl95PPzZDTj5Gsk65qeg9x8lCN4vb3VvZO+3d5mZqKF
 I3v2/vjewadm1mSwYcvtFZpoGbmkgYiW0dQ7PcsmbVEcO+9r02b1bIWSBeA+GZrQhQ
 h+80FIBBeTs/A==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UI+Qdltd
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ixgbe: clean up adaptive
 interrupt moderation algorithm
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

On Fri, Mar 27, 2026 at 08:30:37AM +0100, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Improve the adaptive interrupt throttle (ITR) algorithm in several ways:
> 
>  - Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us (12K interrupts/s
>    minimum in bulk mode) to prevent RX starvation in full-blown bulk
>    scenarios.
> 
>  - Add ixgbe_container_is_rx() helper to split the Rx vs Tx logic in
>    ixgbe_update_itr(); Rx uses a latency-favouring path for small bursts
>    (< 24 packets and < 12112 bytes), targeting 8x throughput growth per
>    step.
> 
>  - Limit the ITR decrease in latency mode to at most 2 us per update so
>    ACK workloads do not overdrive the moderation and starve TCP senders.
> 
>  - Add IXGBE_ITR_ADAPTIVE_MASK_USECS (= IXGBE_ITR_ADAPTIVE_LATENCY - 1
>    = 0x7F) to mask out the mode flag bit 7 in ixgbe_set_itr(), replacing
>    the open-coded ~IXGBE_ITR_ADAPTIVE_LATENCY.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch is doing 4 things.
Please split it up.

...
