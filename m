Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C4BC4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Nov 2022 17:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 764918140B;
	Thu, 17 Nov 2022 17:38:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 764918140B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668706737;
	bh=V+Wt7dqRXdN/qrkXMJzd/c47qwCPpukD5b2nwD0RRA0=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QcgzeMfk4nFhfiDGBsVp18RbiC/sjJYcDuCfhNAHkV/amXneF4qCxZUzfcygLTQKk
	 K17Dxm9i4eAiILfxLVkaxfT21OPfWd1u2LaeZOZoY3fuR+J8ZHxIv8d60OQ6j6iAi+
	 anYL4FhlvQLvjdMhIPi7tp8lKL5F3FCXeu9XjbOBB8EMsvxwcAq7Hk53wW4nSdur5U
	 MNPELLB2JOi+AOaiwAalkywqGqyyc9fWYORhaC/85HKji4mHbcOgTcL0f5bh/QrX3B
	 QszLbBBqpoEli1RGvXHYzQ+rZHuYItfuwG+xgIe4PA1HbydtS0QLex4nM5QknluoV3
	 OPKcci7zdMhJA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Go0fJJUDzOr7; Thu, 17 Nov 2022 17:38:56 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 742FE81428;
	Thu, 17 Nov 2022 17:38:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 742FE81428
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 48FB21BF401
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Nov 2022 17:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1F7D1403AA
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Nov 2022 17:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F7D1403AA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3c4pc4-eBtp for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Nov 2022 17:38:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B860401F8
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B860401F8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Nov 2022 17:38:54 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 47D21621C4;
 Thu, 17 Nov 2022 17:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1354C433C1;
 Thu, 17 Nov 2022 17:38:51 +0000 (UTC)
Date: Thu, 17 Nov 2022 19:38:48 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Message-ID: <Y3ZxqAq3bR7jYc3H@unreal>
References: <Y3OCHLiCzOUKLlHa@unreal> <Y3OcAJBfzgggVll9@localhost.localdomain>
 <Y3PS9e9MJEZo++z5@unreal>
 <be2954f2-e09c-d2ef-c84a-67b8e6fc3967@intel.com>
 <Y3R9iAMtkk8zGyaC@unreal> <Y3TR1At4In5Q98OG@localhost.localdomain>
 <Y3UlD499Yxj77vh3@unreal> <Y3YWkT/lMmYU5T+3@localhost.localdomain>
 <Y3Ye4kwmtPrl33VW@unreal> <Y3Y5phsWzatdnwok@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3Y5phsWzatdnwok@localhost.localdomain>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1668706732;
 bh=fNyi35WylNrbKyWDiB2SrAEFPV26ngVAbGKAt0nDGkU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RCurv50iX8m02jRnW3roTKqoSdga15iVx9dufpWsALaoxkhwTLzKbxVhMrDrBLr/Q
 IbEbqTHFosjLtlnI03uflSbDKWq7SwRxKUSUNsVYPltDol77N0TYzZi5Ns/rAWmPLe
 XqcThhdSaFapgUD4XwD3bLphOwDIpl5mA0MqpPbUMeIy6ikpKLVitT/ecxkJzTivt8
 /PLG4zGb2mGonP2E7gPbApYhBOzfG0OjeKRtBTIAbRpppkYsSrFXOWPu5PwmOyZQOh
 LSkvg71vo5fKfmxADjdYezB/zJNVBGIlGJYoxq2+QpsyLTSgK4oJO7isX9IPqYzsLo
 073f58LoAsMyw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=RCurv50i
Subject: Re: [Intel-wired-lan] [PATCH net-next 00/13] resource management
 using devlink reload
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
Cc: jiri@nvidia.com, leszek.kaliszczuk@intel.com, przemyslaw.kitszel@intel.com,
 edumazet@google.com, mustafa.ismail@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, shiraz.saleem@intel.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Nov 17, 2022 at 02:39:50PM +0100, Michal Swiatkowski wrote:
> On Thu, Nov 17, 2022 at 01:45:38PM +0200, Leon Romanovsky wrote:
> > On Thu, Nov 17, 2022 at 12:10:21PM +0100, Michal Swiatkowski wrote:
> > > On Wed, Nov 16, 2022 at 07:59:43PM +0200, Leon Romanovsky wrote:
> > > > On Wed, Nov 16, 2022 at 01:04:36PM +0100, Michal Swiatkowski wrote:
> > > > > On Wed, Nov 16, 2022 at 08:04:56AM +0200, Leon Romanovsky wrote:
> > > > > > On Tue, Nov 15, 2022 at 07:59:06PM -0600, Samudrala, Sridhar wrote:
> > > > > > > On 11/15/2022 11:57 AM, Leon Romanovsky wrote:

<...>

> 
> Thanks for clarification.
> In summary, if this is really violation of PCI spec we for sure will
> have to fix that and resource managment implemented in this patchset
> will not make sense (as config for PF MSI-X amount will have to happen
> in FW).
> 
> If it isn't, is it still NACK from You? I mean, if we implement the
> devlink resources managment (maybe not generic one, only define in ice)
> and sysfs for setting VF MSI-X, will You be ok with that? Or using
> devlink to manage MSI-X resources isn't in general good solution?

NACK/ACK question is not for me, it is not my decision :)

I don't think that management of PCI specific parameters in devlink is
right idea. PCI has his own subsystem with rules and assumptions, netdev
shouldn't mangle them. In MSI-X case, this even more troublesome as users
sees these values through lspci without driver attached to it.

For example (very popular case), users creates VFs, unbinds driver from
all functions (PF and VFs) and pass them to VMs (bind to vfio driver).

Your solution being in wrong layer won't work there.

Thanks
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
