Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C71F419BA
	for <intel-wired-lan@archiver.kernel.org>; Wed, 15 Apr 2026 13:53:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB57342B1F;
	Wed, 15 Apr 2026 13:53:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FSXqFyjXTBrg; Wed, 15 Apr 2026 13:53:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0BF242B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776261202;
	bh=dVpNpxBkTcO/4l2fBBfiJeNf3RCFJaEWOpdd6iSc9NQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N7AmjJDiO/Y8FAdEy7U4KwsupzMWRW+l/x+d/G4DhuGRkaeueNCJrOyBb9avP2d5h
	 xqLAEX0nvPftZ7hFGXtiJMFJn+/noyEhHblgJDmx6+42qnH3+ndeZdnTsdeAgYs/jl
	 zw4vPO0pw6uKvpEAct/Wi/J9DxywU2b+DPTj4luuB1KX9llcnV71ZMM+nTtllB8YgA
	 5XuV15n/IGJyrbrxJa8B1fKIIOC/j+Yjao/kogBFWRenFKx7uoB1CPN0sJR4DYG/1S
	 6EGdl/lrg+POMLH3SBsFkoQUMnROdlySWEnMz63tvO3T1kqUJa/o9z7B5eLeKbl/wN
	 7vrU2l3Y3rqKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0BF242B1B;
	Wed, 15 Apr 2026 13:53:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 76B20237
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 13:53:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5CBBB853AD
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 13:53:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nLQ5Md66VEUK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 15 Apr 2026 13:53:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BB5A6853B5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB5A6853B5
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB5A6853B5
 for <intel-wired-lan@lists.osuosl.org>; Wed, 15 Apr 2026 13:53:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DEFED600AE;
 Wed, 15 Apr 2026 13:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771BCC19424;
 Wed, 15 Apr 2026 13:53:17 +0000 (UTC)
Date: Wed, 15 Apr 2026 14:53:15 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Kiran Patil <kiran.patil@intel.com>
Message-ID: <20260415135315.GK772670@horms.kernel.org>
References: <20260413073035.4082204-1-aleksandr.loktionov@intel.com>
 <20260413073035.4082204-6-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413073035.4082204-6-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1776261198;
 bh=RCRSadFhOAVPdCR4RHEUrMdSFUtCXm2C/VxKppUJ1dM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lR6N8cDOLY8BNji8pLn5aJnDiu0FUqYZcSoBwLclSgUQIKBUeCqG4+l8b9AVwSfxu
 VyF39jGBl3fkwI4E+zZ2dm1XLv3wU6+esDspW4Hbh7AmndYCWB7CmRVRbGGFzJ7Qs/
 OwBoPtaCLvAZDe3fcQLyX6KmXGyFNJtSDNSaAgwFmC6/QWCfLZmuHnk/LT4q3WFa8+
 9RXWt0CdYuUv45esrtyb4GQtqSZD2+dYW77PrWXrgIkBs6O6WaJZMOH9yXbl0164O+
 RhBy0NxeCzR/HoXCmCv9M+MFOJc2qc92Oc7Gu3G8LSc9m9dIMuqqpspk7OLLLMG8+p
 Apm0VmFgQMQvA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=lR6N8cDO
Subject: Re: [Intel-wired-lan] [PATCH iwl-net 5/5] iavf: return 0 when TC
 flower filter not found after qdisc teardown
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

On Mon, Apr 13, 2026 at 09:30:35AM +0200, Aleksandr Loktionov wrote:
> From: Kiran Patil <kiran.patil@intel.com>
> 
> When an egress qdisc is destroyed, the driver proactively deletes all
> associated cloud filters to prevent stale hardware state, decrementing
> num_cloud_filters to zero in the process.
> 
> The kernel netdev layer is unaware of this implicit cleanup and may
> still try to delete the same filters individually. If the filter is
> not found in the driver's list and num_cloud_filters is already zero,
> return 0 instead of -EINVAL to avoid confusing upper layers that
> believe the filter is still offloaded in hardware.
> 
> Fixes: 0075fa0fadd0 ("i40evf: Add support to apply cloud filters")
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

Sashiko has some comments on this function - which do not
seem related to the logic this patch touches.

I'd encourage you to take a look at some point as a follow-up activity.

...
