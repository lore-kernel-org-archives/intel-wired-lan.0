Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBA8EB64DB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 20 Jun 2023 15:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 017E960888;
	Tue, 20 Jun 2023 15:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 017E960888
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1687276765;
	bh=oB1KTzj05j3qMIsBC70Z/iPC6tugo4DosTJ29SNi27k=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=44FMQyoaPxJr8plHsII5s8fURbcomZoh5/2qadWrdr/j0sXLZ8hiQEaq0mWA1jm0j
	 d/YsVBXmdVBlqSLt17NM+mU+pp2VBYdjAff33TrD3ldJbEZaRiFNFhCQw2PncDqO8+
	 sd0U1FUseYcU4XGMEgKmXZbpbaeF6sNk/Jf1tTqyKa5h7v+b8SwutFXtzu5WNrJIkl
	 FkSEDNmfNAjFlDxKmm5prmJ60aZNgfCQmp6bkG81/IhlS97Cb3Vj1FfAesLVbH1PDi
	 f6kQkPVRkwb1sNJzdRcWuvsZ+29dSfwanf6pFXfJJC8XBkFAH94c0q3JD/ulBRnWGO
	 OUMI9mAYjE65w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0u59cJPbWWoS; Tue, 20 Jun 2023 15:59:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14CED60EAB;
	Tue, 20 Jun 2023 15:59:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14CED60EAB
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 98E771BF291
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jun 2023 15:59:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64DC841B81
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jun 2023 15:59:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64DC841B81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LtoIf1THucDu for <intel-wired-lan@lists.osuosl.org>;
 Tue, 20 Jun 2023 15:59:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8383441B80
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8383441B80
 for <intel-wired-lan@lists.osuosl.org>; Tue, 20 Jun 2023 15:59:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B38C6612F4;
 Tue, 20 Jun 2023 15:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32D0C433C9;
 Tue, 20 Jun 2023 15:59:19 +0000 (UTC)
Date: Tue, 20 Jun 2023 08:59:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Message-ID: <20230620085919.497c3a03@kernel.org>
In-Reply-To: <17cc8e10-3b54-7bb7-6245-eba11d049034@nvidia.com>
References: <20230613122420.855486-1-piotrx.gardocki@intel.com>
 <20230613122420.855486-2-piotrx.gardocki@intel.com>
 <c29c346a-9465-c3cc-1045-272c4eb26c65@nvidia.com>
 <18b2b4a1-60b8-164f-ea31-5744950e138d@intel.com>
 <17cc8e10-3b54-7bb7-6245-eba11d049034@nvidia.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1687276760;
 bh=JvRHHCpfUHPT1y5nSv1lOHmoL4oYB3Bie6coQ1YCqpU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ndYk6tuBUkmB2QJsWkmzvNPun5kdhr3H5rNYk5bHzBbHPLqM42qe77Ibp1mG8kFBD
 /oCyNdI2rvv1fMqbvf4L+jHJZmhS/ZXvMwxL86d4YbsNYB4VzETENq538CU9NRm10H
 +yJpfpHaw2L0RkdPjuKfIR/bR2Yp3cmwnJFb14QwdktFq3toQ69lpJq1zcSAmBFM32
 PvEV6i/YZ1zMSoW2E1ACZONpekn0VByjNVkoewMyHGqjz1Rsgp4mS8ar6wHh8u8wTX
 cwXnlJOjBZwutDgk8mcyOWqQxwZBr4x/tZgiqz9vXD2uEFzks9jYnb8bt8vvUUOUO/
 RRHdpPInU+9Wg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=ndYk6tuB
Subject: Re: [Intel-wired-lan] [PATCH net-next v2 1/3] net: add check for
 current MAC address in dev_set_mac_address
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
Cc: pmenzel@molgen.mpg.de, netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 intel-wired-lan@lists.osuosl.org, przemyslaw.kitszel@intel.com,
 simon.horman@corigine.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Tue, 20 Jun 2023 13:42:14 +0300 Gal Pressman wrote:
> > I checked it, you're right. When the addr_assign_type is PERM or RANDOM
> > and user or some driver sets the same MAC address the type doesn't change
> > to NET_ADDR_SET. In my testing I didn't notice issues with that, but I'm
> > sure there are cases I didn't cover. Did you discover any useful cases
> > that broke after this patch or did you just notice it in code?  
> 
> This behavior change was caught in our regression tests.

Why was the regression test written this way?

I guess we won't flip it back to PERM if user sets a completely
different address temporarily and then back to PERM - so for consistency
going to SET even when the addr doesn't change may be reasonable.

Piotr, you'll need to send a new followup patch on top of net-next.
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
