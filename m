Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7D2C4167B
	for <intel-wired-lan@archiver.kernel.org>; Thu, 14 Dec 2023 16:22:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D812061AB6;
	Thu, 14 Dec 2023 16:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D812061AB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702570961;
	bh=xpuWzDOEOihiNhSIj2aJhsRipdrRIDsA2Kh3CsZm3qs=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=cM5AGGpmlehFiTHO+EurrXlfe9KgY56JpCP41ErXuEXA0d9XYBH6sFxGZH/Liw+++
	 a2KHYjGGiMAziLbuh+LuqS0HA3NA6ceYkU6q1XXK1xyaoZL0TYefPCRfAgXdMcVL4N
	 qv2PizfwD9sRuKcEcB59ukb5DEwqL/PRGkxIEhdBy6Gg+0xsPd8aynSEh1IQdurlOB
	 7Qv2BlHmsJ5OVupDv3YZ2+ifFC8trqHuhe9bspobSvXYLQdzha46WnlNUdCr1GEv0f
	 9CcPOvNzTCoRxnP76Vo9b1gpCdt1jF2IauhYdHhC9oa16MgXVB+4H8aNvmZKyKOSH8
	 WNWGkGto3B2tQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jm9YvhMT-VUy; Thu, 14 Dec 2023 16:22:41 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id E937060F8D;
	Thu, 14 Dec 2023 16:22:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E937060F8D
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id A192A1BF27C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Dec 2023 16:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 751DF83BCE
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Dec 2023 16:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 751DF83BCE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id stCDKd8yBAJj for <intel-wired-lan@lists.osuosl.org>;
 Thu, 14 Dec 2023 16:22:37 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36AD283BC5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 14 Dec 2023 16:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36AD283BC5
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 1670462198;
 Thu, 14 Dec 2023 16:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15148C433C7;
 Thu, 14 Dec 2023 16:22:33 +0000 (UTC)
Date: Thu, 14 Dec 2023 16:22:31 +0000
From: Simon Horman <horms@kernel.org>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Message-ID: <20231214162231.GL5817@kernel.org>
References: <20231212092903.446491-1-larysa.zaremba@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231212092903.446491-1-larysa.zaremba@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702570955;
 bh=aQy0Dq+mR2qVRKVgMb5qRV1UZIcTop1MgbjzW9yIac4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=umTjqz6635ql1hmSw3+Fa3Y0NwskPdtWyrxGe74qhX00yw7dSBc5N/PyJlm4898P2
 68DqFKee8WKX16kypEZfJL42izpMYyqb1DyRc6cJH+3k4a67XfrvAjlS+H7wx5UG8R
 n9VbWh+3AYCasCY9v53uBknsvLra9d4beU7My0AXYCkJF2fu9HNITr4qAlqCMC974+
 EDYqfNZe2v5q0x2yQYbciB41zIVuHRIJeTqlsuG/llRQ7diLcfx+XLMydmFnb4kGjw
 2cA5H0reb0m0zU8TrXB2NX1TO4i2kfwtnSGtEnQ0snjpTeDuAvk1lyp+B7aG/vdvpq
 UXbWBy5f9s/Ng==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=umTjqz66
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: Fix PF with enabled XDP
 going no-carrier after reset
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
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, Dec 12, 2023 at 10:29:01AM +0100, Larysa Zaremba wrote:
> Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> functions") has refactored a bunch of code involved in PFR. In this
> process, TC queue number adjustment for XDP was lost. Bring it back.
> 
> Lack of such adjustment causes interface to go into no-carrier after a
> reset, if XDP program is attached, with the following message:
> 
> ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
> ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
> ice 0000:b1:00.0: PF VSI rebuild failed: -22
> ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> 
> Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
