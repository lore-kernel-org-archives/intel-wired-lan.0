Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F1CCAC5BB
	for <intel-wired-lan@archiver.kernel.org>; Wed,  1 Oct 2025 15:44:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB853613C6;
	Wed,  1 Oct 2025 15:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iu95u-HW6Hzv; Wed,  1 Oct 2025 15:44:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A65D613C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1759333441;
	bh=eedb72hMnhvc9XxbgF6CkpnlxOJY6N1WniGFYTAtBT0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=6R0Y8JOSClNX/KlaiOVgHEDrAkI5wDPOhXn3IkXVSlanESjlXDNc09ii3b5zhHG04
	 fvmsH10B0DIMWEeZgobDL7sZDGjb85cgLXn7XuVTGW9lrBblizV0zX9MUwg416B3TY
	 TrKChZ5nyypOA30nNdd69ZIXXlAQqKlPICiPRL7ZEE7JsLvGANOSq6WW/5jNUv4PNT
	 QDDgiFx4azQKicpPmA9XwGHTMSYBg8tTbUOZJb888WyXWK+fGqZAHvGXQjZ6t0hUK1
	 4kXjSu/OFCAXdVPEHMWvzydc2fAzuQQ1nCrM3fmjWUbzIEoEVnCMH2Z/NZglKeawZe
	 AhEDWpBE8gC4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A65D613C0;
	Wed,  1 Oct 2025 15:44:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0909693C
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Oct 2025 15:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EED99410EB
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Oct 2025 15:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R6b-zdvZq0f9 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  1 Oct 2025 15:43:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 64EA84105A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64EA84105A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 64EA84105A
 for <intel-wired-lan@lists.osuosl.org>; Wed,  1 Oct 2025 15:43:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C1474386F;
 Wed,  1 Oct 2025 15:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED794C4CEF1;
 Wed,  1 Oct 2025 15:43:56 +0000 (UTC)
Date: Wed, 1 Oct 2025 16:43:54 +0100
From: Simon Horman <horms@kernel.org>
To: Sreedevi Joshi <sreedevi.joshi@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <aN1MOnqvkl7nZxZ7@horms.kernel.org>
References: <20250930212352.2263907-1-sreedevi.joshi@intel.com>
 <20250930212352.2263907-2-sreedevi.joshi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930212352.2263907-2-sreedevi.joshi@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1759333438;
 bh=0FjaBLp0dpdaIUjdsYa5N7xObF6Jj6Zej+/l9PeTTFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QUo/NYvy4edVIFlngPRGMBTo3I/nXh1GHvulMs54p+zyrbtN+QV9WepZZuTVwX7cn
 gOa4X09GobHbSZf0FtxcPjGSGahRJIydO2CNrV2UYLd+DHyaWNBBIVzYC8/gujcPEg
 0wwoEfLuwv/BcDnON143SFR2h+2qi++dy88wdSnZDSDU1zhmkYExpASY0D6BsBDbXq
 qEPWdVx/pSVLNeDQ09m8nNPM5WUJxt+fgK6hww1etRDCdFbmdaEIgEiU2xRUFQ9Q2j
 1shDXHrTDz39BnY66gsXvhW6MrAIlF6w5Q1LF/fZJAatkn7c3wauI0S/MRgWxAiEio
 4ZjwYJhdbE/Tg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QUo/NYvy
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net 1/2] idpf: fix memory leak
 of flow steer list on rmmod
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

On Tue, Sep 30, 2025 at 04:23:51PM -0500, Sreedevi Joshi wrote:
> The flow steering list maintains entries that are added and removed as
> ethtool creates and deletes flow steering rules. Module removal with active
> entries causes memory leak as the list is not properly cleaned up.
> 
> Prevent this by iterating through the remaining entries in the list and
> freeing the associated memory during module removal. Add a spinlock
> (flow_steer_list_lock) to protect the list access from multiple threads.
> 
> Fixes: ada3e24b84a0 ("idpf: add flow steering support")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

