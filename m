Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321B4FEC0EB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Mar 2026 18:16:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0523783BA3;
	Tue, 24 Mar 2026 18:16:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwbnEzc_GnDj; Tue, 24 Mar 2026 18:16:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B67F483BA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774376178;
	bh=Oe4Nzi0nJ8CpcY1D5JkdAdBmF1KZrrOvgCJwdyFxEjk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kRFOTKPVj2Vr8NYWLR8QFx5OWSc/qYBtsyG6Y3w7HHhvXBV4FE9r9WHa5cgBwLPlp
	 Vm6RTbxTG5fWn8z0DsaGf/T32WPCrNoSaPOLGbWe0TDEvQc1a6SVwzopUGUaGwHC4R
	 xvQDowSwINDnvdPtH3OIUAc6+WBWNfCQQqSL7PMTktflwpNDXsHhQr/Z3y+JV5o2tH
	 CxWprOrtgLhmaUy9Kck7d+55Ad0qgJr7n8CUFxNFZewO1dmqB0IWvdKrZLUYGeEWju
	 WLVRMnrjrgDhFiZfY6sQToSwzas1KZkbozLXkoVb4Y42pBWgKauFQ6g7cb1al+wJ30
	 Qap3ux6/b+NVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B67F483BA0;
	Tue, 24 Mar 2026 18:16:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7851353
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 18:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACD244111A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 18:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WyPJ_U43gN7p for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Mar 2026 18:16:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A408741085
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A408741085
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A408741085
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 18:16:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3FB4F4075A;
 Tue, 24 Mar 2026 18:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D2AC19424;
 Tue, 24 Mar 2026 18:16:14 +0000 (UTC)
Date: Tue, 24 Mar 2026 18:16:12 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Paul Greenwalt <paul.greenwalt@intel.com>
Message-ID: <20260324181612.GE111839@horms.kernel.org>
References: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323085840.3272274-1-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1774376176;
 bh=N4wYF65jbJz3YOdMBQKu7J7Y5hKyKxHEkJXVzXlvoVI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jJB3bye2h3s1vjT2Zi3+vlWVS2Cq/y2fhHhZK/FOwozhQLzhyQWhB0tQ4cmNYQno3
 olyxRlc2jKM0YFQ8OadKmrx8XKgMXqWCQd3wrXOxA7Cv34/CvInMKgaFkyYnc5JFSU
 5btIx/QlxX3nF2PRAhR0+52iIVZKdfKq/ASu1MMuzoVA/3xmoJZoRTPMyOsvorVMLL
 TDvvcFvbd8ntCCXz8mIoZsZ0bADqEjhjDg3Vdn6dQkdOhVbyahdz27okT0VuOjQmcn
 BBXj/rQRhiMMgmzfoiW5RX30pHpkuGL1WMF1eo889MMhrdpHZme41N4DIKZJD2RDV/
 7JZ3HDia1kkNA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jJB3bye2
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] ice: update
 ice_link_mode_str_high() with 200G
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

On Mon, Mar 23, 2026 at 09:58:40AM +0100, Aleksandr Loktionov wrote:
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Update ice_link_mode_str_high() with strings for 200G PHY types.
> Without these entries the ice_dump_phy_type() debug helper prints
> nothing for phy_type_high bits [5..15], covering all 200G and
> 400GBASE-FR8 PHY types supported by E825C hardware.
> 
> Also add the corresponding ICE_PHY_TYPE_HIGH_* bit definitions for
> indices 13-15 (200G_AUI8_AOC_ACC, 200G_AUI8, 400GBASE_FR8) that were
> missing from ice_adminq_cmd.h, and update ICE_PHY_TYPE_HIGH_MAX_INDEX
> from 12 to 15.  Without these definitions ice_get_phy_type_high() would
> stop iterating at index 12, leaving the new PHY types invisible to all
> code that bounds-checks against MAX_INDEX.
> 
> Fixes: none (new hardware support)

AFAIK this is not a valid Fixes tag.
If it's not a fix, please simply omit the tag.
If you want to say something about why then use free form text.

> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 update ICE_PHY_TYPE_HIGH_MAX_INDEX 

...
