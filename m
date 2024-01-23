Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2439DC47258
	for <intel-wired-lan@archiver.kernel.org>; Tue, 23 Jan 2024 17:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5B1440414;
	Tue, 23 Jan 2024 17:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5B1440414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706029639;
	bh=YYP3lV+I7wKiAAuWHnQM4MJY8WojS2IgTThn4HtRoXE=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XizQYbav06KqQNIeKIx41xU51NtyL65qUYKHeLZnXkgHIRIpjj0lcsGsjuYj0hkh+
	 8/wqjuwWtxUhDkeXf2rgockqXu9zLAg25bttA0/DuyX7aU4iZ0t3nAM/JVa3QtT6ua
	 FcjV4L67QDZBnB9gIf8NJz+smmODfEJPSatVUKhuEV6sxxmOy/6I7AQ0tuhIGWptzc
	 N1zfhcILWLxRKAO2pBo3rSOVr4QgACsI0yBjFHcvjIntaDbwpQ85pkoxorCynnWvPP
	 bbR4PkTfpHQTzv7NmEh/S4AwgE6vxohRMz6KeEidSFqtWjMN6u8ijF5F5/fe4Qxo3J
	 BA0SFdT43rGsA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lqpjCL1zEv_1; Tue, 23 Jan 2024 17:07:19 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C365B40491;
	Tue, 23 Jan 2024 17:07:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C365B40491
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 341E31BF3AE
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 17:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0B01640414
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 17:07:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B01640414
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dm4-tq5KXLBk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 23 Jan 2024 17:07:16 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 381BA403FB
 for <intel-wired-lan@lists.osuosl.org>; Tue, 23 Jan 2024 17:07:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 381BA403FB
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6B7F161C0A;
 Tue, 23 Jan 2024 17:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFD7C433F1;
 Tue, 23 Jan 2024 17:07:13 +0000 (UTC)
Date: Tue, 23 Jan 2024 17:07:11 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Message-ID: <20240123170711.GL254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-7-karol.kolacinski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-7-karol.kolacinski@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1706029635;
 bh=wpbM9x7x1JCmm5dR/KOBtftHAc6l/wBK2x9iHxRpaRw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sh1gGDQNxukoNdgoRrl8bGFO1xwzQczRNhj93Uf7HbdHR+DsOORXnk3A3o6B3Zisj
 1gkP5TefdckfqOUDr1L0+sVXxXptBo6WFRZth2cW02RjdZ4KrvYeJnDUli4uG2ymHH
 VtXLRehJFEXBlY/JoCcvWpnfl+BO/P+VeNoOzJQKmO8QENcewp9OUbA5IgoU350BC6
 wZxW6VvQw//iApftxJr6ah8Kml8+2iOBieLbpVoJdBG2o3eNaCJ3ZiLxU/9Dxr0Mfg
 PtdiqPqXCzsSB3s7ZTHRIe1q7o7zJDbE893L0RRwePneF2vDAxsinsuRmYWrr7dqhu
 8OioapS3WSLjA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=sh1gGDQN
Subject: Re: [Intel-wired-lan] [PATCH v7 iwl-next 6/7] ice: factor out
 ice_ptp_rebuild_owner()
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
 jesse.brandeburg@intel.com
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Jan 23, 2024 at 11:51:30AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_reset() function uses a goto to skip past clock owner
> operations if performing a PF reset or if the device is not the clock
> owner. This is a bit confusing. Factor this out into
> ice_ptp_rebuild_owner() instead.
> 
> The ice_ptp_reset() function is called by ice_rebuild() to restore PTP
> functionality after a device reset. Follow the convention set by the
> ice_main.c file and rename this function to ice_ptp_rebuild(), in the
> same way that we have ice_prepare_for_reset() and
> ice_ptp_prepare_for_reset().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

