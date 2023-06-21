Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB1AEB64D7
	for <intel-wired-lan@archiver.kernel.org>; Wed, 21 Jun 2023 02:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8F9C060761;
	Wed, 21 Jun 2023 02:19:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F9C060761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687313953;
	bh=5E47npQdSHyz/dhWRtFGjSnOavx+m34k+Ge1GCIrnnk=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=XhCCrGPDKe5F2VbnsQxoSY1UXFuJ/sn6NAMrMYkxMXuiwjVGP0olQrGTdwADiqdif
	 HOc1v2atPWa78tc5caEfQLnNuKXi5SgA4Kem8qgWC6D7Z27DDvUWssRAxCOEEYoq7G
	 yqzEgq1I0NzNVfzoSpuWb1bGJIGnmKzBlAqO0Af3pJ/yzhM45zOaJVB7ceyQOqwrE1
	 xDcFBrNWc1Ndgp0tJM+XS2pwcyoDiO/QcY2ABgHIGkm84AO7hkWTwVRAKzpDEahpUE
	 gewD542YbIX9eRv/hmfbd0++Bn0wVlVeUq9RbTwETjWoAG74T+/Z5tzfqOEsb/JsiN
	 aRpetaxnu8ZoQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Al_9W0KBPuIh; Wed, 21 Jun 2023 02:19:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FD1D60ABE;
	Wed, 21 Jun 2023 02:19:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7FD1D60ABE
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 08F191BF3DF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jun 2023 02:19:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D4F204046A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jun 2023 02:19:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D4F204046A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xE9XPTq7YP5o for <intel-wired-lan@lists.osuosl.org>;
 Wed, 21 Jun 2023 02:19:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1853640119
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1853640119
 for <intel-wired-lan@lists.osuosl.org>; Wed, 21 Jun 2023 02:19:10 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EB10C61382;
 Wed, 21 Jun 2023 02:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B465C433C8;
 Wed, 21 Jun 2023 02:19:08 +0000 (UTC)
Date: Tue, 20 Jun 2023 19:19:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dave Ertman <david.m.ertman@intel.com>
Message-ID: <20230620191907.3a812399@kernel.org>
In-Reply-To: <20230620221854.848606-1-david.m.ertman@intel.com>
References: <20230620221854.848606-1-david.m.ertman@intel.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1687313948;
 bh=p8Q8r4aZhiSiJbdIqmN/Pz1WZl07k8vqIfS3U6C+MPE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=L2w0Kpopcb8BCSVb/gO9i9A9Uc8cNEQfhQ4HzzDZDnu4kg2w7SRCU8sPm8GnUohHb
 IyskLgwHtapceBiUkHmFLd9KIraQWVeiE2axQiMl9ngj9lJtGuCVqANrVuj0fG0v31
 SUA5YgB3N3xPQqQl0Uzz3PEU1PMNqzpJJKyLhTyn2rpWkIauPtq/LhJFlWykmxNXo4
 pQqwEpQMLscQI4pUaSOjcACr2bL9nJ4daIm9inSy4KHvSRDacs2KJg6DWqWWVAF8Ks
 WZmC7/8NmTbPadehe3Wb60XiFK7k2pzb5uqYMZ7qEBn05cSowvEe1uslgkLNSl42NF
 DGrpmfvabpXcA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=L2w0Kpop
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v6 00/10] Implement support
 for SRIOV + LAG
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
Cc: bcreeley@amd.com, daniel.machon@microchip.com, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, simon.horman@corigine.com,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 20 Jun 2023 15:18:44 -0700 Dave Ertman wrote:
> Implement support for SRIOV VF's on interfaces that are in an
> aggregate interface.
> 
> The first interface added into the aggregate will be flagged as
> the primary interface, and this primary interface will be
> responsible for managing the VF's resources.  VF's created on the
> primary are the only VFs that will be supported on the aggregate.
> Only Active-Backup mode will be supported and only aggregates whose
> primary interface is in switchdev mode will be supported.

If you're CCing netdev you need to obey netdev rules:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review

You have sent two version of this today (and there weren't even 
any replies).
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
