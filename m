Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B8A1099B30
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Mar 2026 20:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44C9F61BEB;
	Fri, 20 Mar 2026 20:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hx90SSMWTmYW; Fri, 20 Mar 2026 20:09:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 76BA361BEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774037340;
	bh=ZWlHL/9SY+A88RJnCLXjE71AQFo0f+gQQ8r/pgkrNFw=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JOHLFOpsWPY4yt0jMdiPqMQTgbtseS9XEQ5AJBkn44FN0qXyUh4fJBpwwUWSS2vdk
	 kYecBkVR/S64g9nZxahiZyaHRLW3djb0Ac+/Mqd5/YZ+95/NJPHPZqKXi4o33iDlvH
	 lcodOiOsCtjsAtbfYtggtGAgN8l+dokvzpv7JZvxz4pDjcfuVoFX+ckmFzlsr4i6kR
	 7eudjYpGh+0qurG2FcCrKPqRJsD7O4mccXiaJWl2MJLpX29CGLoUsMJsXrfU23S0ra
	 owuSUijsp/a5opellnAm85So4oM6kPBsIw1NIi/7DyxBvIFP2vzCtCQVazSQnbKHLK
	 LM58t/UoHFjqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76BA361BEA;
	Fri, 20 Mar 2026 20:09:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8997A25C
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 20:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7A75C61BEA
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 20:08:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vczS6yvapNv8 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Mar 2026 20:08:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DB61C61BE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB61C61BE9
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB61C61BE9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Mar 2026 20:08:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F602406DE;
 Fri, 20 Mar 2026 20:08:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D31C4CEF7;
 Fri, 20 Mar 2026 20:08:57 +0000 (UTC)
Date: Fri, 20 Mar 2026 20:08:54 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Message-ID: <20260320200854.GN74886@horms.kernel.org>
References: <20260320051034.425089-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320051034.425089-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774037338;
 bh=m6LT0aN+/E9/S9hT8eBDG6yPYtLtpFcuVjjFa5Ig2Bo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SLd5wO0KaUbxcNY1MaWGhpdnHu4C8b6nErXOfL7MA7NfKqYjIcK9mGwHKhVKQQc77
 Af3arZuOSWxUcAqB6ZQuKHQlGLx32lDQfxWOGe1bLxuM3P65l1Td63u33ThseOvEth
 2BHMNu1CPbP0ZsM82OJZbtmKFiwbfI6S1Fg43JGOxKsLwnxnf+7qEDg7lfAelcbH2Z
 G3h6UoLC+HEqu7brFhMxtvezUZOnFF3y7SEv530FM+vwt1ASBAcE1OHMAWaVr5M7x2
 z4JkHV2t3xAIWdCtOlhp7d9NuWLHhc6bH/wwxfpzBMBTnWKhXL49jAH3GgOxdOmdxe
 8h3pS5NmnM8cA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=SLd5wO0K
Subject: Re: [Intel-wired-lan] [PATCH net v1] ice: fix LLDP AQ filter
 fallback not working on E82x and E830 hardware
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

On Fri, Mar 20, 2026 at 06:10:34AM +0100, Aleksandr Loktionov wrote:
> Commit 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not
> necessary") restructured ice_vsi_cfg_sw_lldp() to first attempt a
> generic ethernet Rx filter and, on failure, fall back to the specialized
> LLDP filter control AQ command (0x0A0A) via ice_lldp_fltr_add_remove().
> This fallback is gated by ice_fw_supports_lldp_fltr_ctrl(), which only
> accepted E810, causing two distinct omissions.
> 
> E82x (ICE_MAC_GENERIC, e.g. E822/E823) support the same LLDP filter
> control AQ command with the same minimum firmware API version as E810
> (>= 1.7.1). On E82x systems where the generic ethernet LLDP Rx filter
> cannot be added, the AQ fallback silently returns -EOPNOTSUPP and the
> port is left with no LLDP Rx filter.
> 
> E830 has been supported since kernel 6.9 and implements the same AQ
> command but requires a higher minimum API version (>= 1.7.11). Starting
> with NVM 1.2 / FW 7.9.1, the generic ethernet LLDP Rx filter path is
> blocked on E830, making the AQ fallback the only viable option. With
> ice_fw_supports_lldp_fltr_ctrl() returning false for E830, no LLDP Rx
> filter is installed after a firmware-update-triggered reset (e.g. NVM
> 1.1->1.2 on an E830-CC in HPE DL380 Gen11), and the interface stays
> link-down with complete loss of network connectivity.
> 
> Replace the single-type if-chain with a switch on hw->mac_type so each
> family's version requirement is explicit. E810 and E82x share the 1.7.1
> constants; E830 gets its own 1.7.11 constants. The default branch returns
> false, covering any future MAC type that does not implement the command.
> 
> Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

