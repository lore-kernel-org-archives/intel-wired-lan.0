Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1DFC5AD4E
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Aug 2026 09:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01E30405D2;
	Mon, 10 Aug 2026 09:57:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZoSv_fyBQej5; Mon, 10 Aug 2026 09:57:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3862F405CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1786355856;
	bh=KFvxri/LDQi9OgVtpNYWGk93NwcOPwTPoiDyWP3EJt0=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lB+j1o5O4FFHjCH90SR6ooHupREdzqTY/t4ZSlvsx3aTnCko/OHQJvox9CeitUBkJ
	 jo7rUsA6oeHbpwQvckTdYVPrUOC8KXNDKGRP80sUI6YcOYeffLrwUPedeejIBbit+L
	 fyMtkMVaIWLe8zorfKhSja0Uyj0s72Etsgi0H99UiG9OAtABPPfuc6o3No9x0Up+Xc
	 u8Kwy5DuPl4ULgkobSUEv6eYEPxKReApHNjtXC8w8k5sReHKgOCdrnK177slkWHfec
	 6UGrIsg1oo8ZbYsdPbiXxglRiElEhYJCM3injoW8p78nQcl2rLHVkaT3ss7BkmfnB3
	 0SeLPhqWNeT4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3862F405CB;
	Mon, 10 Aug 2026 09:57:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9FC0C198
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 09:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 85D62606AE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 09:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zI2SWcxlsnkQ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Aug 2026 09:57:34 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D0F8B605F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D0F8B605F5
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0F8B605F5
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Aug 2026 09:57:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0BEB60120;
 Mon, 10 Aug 2026 09:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DD61F000E9;
 Mon, 10 Aug 2026 09:57:31 +0000 (UTC)
Date: Mon, 10 Aug 2026 10:57:28 +0100
From: Simon Horman <horms@kernel.org>
To: Lukasz Czapnik <lukasz.czapnik@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Jakub Kaminski <jakub.kaminski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tomasz Lichwala <tomasz.lichwala@intel.com>
Message-ID: <20260810095728.GP51943@horms.kernel.org>
References: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806162458.2384818-1-lukasz.czapnik@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1786355852;
 bh=KFvxri/LDQi9OgVtpNYWGk93NwcOPwTPoiDyWP3EJt0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=S/rhad/QEwuEHbFWpOj6ilikdkndTjzK33GoJYXdiUcFbIk7zAvS6zSywarSbiYpA
 Zku87h4a6jz6Loc+Y3ws8ar1jG5d9Ble/Z+N4ONCjJPjh4wfjfXsGbNSXMYQzLvhJy
 f89JnNiGV7ilVaqzwy586KVUAhBUUJ/uSwiCSEHyOIuXeMv3AjMpQiMb5HfyCtkXDZ
 Dmc16yqbqYlcedHHEB0sbnQ+b1UmYo1Pbk7JQm5lacQmQYrmga3iojkAyhPTD8TUOj
 9IMHpExufZHaZsTn9hBFimmGwU1yuUuNE9oXOOQZuo8lo21lrSXGenQ0VkZBnhhVW5
 aknkQrevpppVA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S/rhad/Q
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] ice: Fix "Unknown bps"
 during link events
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

On Thu, Aug 06, 2026 at 06:24:58PM +0200, Lukasz Czapnik wrote:
> From: Jakub Kaminski <jakub.kaminski@intel.com>
> 
> The driver may display "NIC Link is up Unknown bps" messages during
> link state changes. This occurs when link status and link speed are
> read from different points in time.
> 
> The driver processes link events by receiving an asynchronous ARQ event
> from firmware containing link_up and link_speed values, then performing
> a synchronous AQ query via ice_update_link_info() which overwrites the
> phy.link_info structure, and finally calling ice_link_event() with a
> link_speed parameter while ice_print_link_msg() read link_speed from
> phy.link_info directly.
> 
> ice_print_link_msg() always read link_speed from the phy.link_info
> structure. This caused link status from the ARQ event to be combined
> with link_speed from the later AQ query, mixing information from two
> different points in time. When firmware state changed between these
> moments, inconsistent messages like "Link is up Unknown bps" appeared.
> 
> Add a link_speed parameter to ice_print_link_msg() to ensure link
> status and speed are always taken from the same source and point in
> time.
> 

Hi Lukasz,

Probably this can be addressed when the patch applied.
But I'll point out that git am will truncate the patch description
at this point due to the immediately following scissors ("---").

IOW, Fixes and the other tags should probably appear exactly here.
With the v2 information left below the scissors.

> ---
> 
> v2:
> Remove conditional assignement of local var link_up only during
> UP events. Cache state of both link_up and link_speed for every event.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
> 
> Fixes: c2a23e00613b ("ice: Refactor link event flow")
> Signed-off-by: Jakub Kaminski <jakub.kaminski@intel.com>
> Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Tomasz Lichwala <tomasz.lichwala@intel.com>

...
