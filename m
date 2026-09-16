Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505E9C982C3
	for <intel-wired-lan@archiver.kernel.org>; Wed, 16 Sep 2026 14:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F41BF40729;
	Wed, 16 Sep 2026 14:41:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e-6vvobPRTlM; Wed, 16 Sep 2026 14:41:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 58CD34072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789569707;
	b=YrN3MxOuNbuRmx/QaIyyz28+MkT6JQFHxJ4t20JcHOUEFcLqOfEpVClmrZlRb8/xDumc
	 il2TdUmzU9s64xXJ6ziWlmMg4aR1eAQorWJZXE+zqsYDe9Pn8wKJTqlalYUo66r14q2/l
	 tRCSXIF3Aj3ClGYbkWmUvldFdBThsCwKxR2L+qdKLYp8V5XbF0M8eE7wnyNShXULhTgDz
	 kdVtu7sVr9yEnsC8Xbiq0RAkBEL91cXn/TOa0oMDCxCTwOmXuXvyKuiHSthYfjt88ie/W
	 Hu2DRiNYC72Sw4xALX1dLxVrCa1s7N4u6CgkX5+Sw4ZXmHdm45bVijp3sOv9+4wH8gg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789569707;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JMZc6BTWU0VD/eixJdALpvzLlqy4CkXpMmg9ILvfmgY=;
	b=OeJebPCS+5HktgIacEmsszNJqC/H1jUl5XDMM79zXCVJbpU5XH5SjnX8dUVBpYzY8VdG
	 OJUTx3gNfU6P67Ch6jWQJIlEyJ2iWgLkSD4zaHHCdBPCb2L38qZnj4ag0ZS9UY4qhUsw1
	 LB5rfpdBXVywIEeod0CTzztzrss5QoF2Lrdk4+SMp9+yS6i3d3XgmtVkSHExXVkZkL8uc
	 COUBJWrWB52N8SGTTs4Cy5kOHksC0yrIuwPXPkHrwcVk7WfXOQKHk8/6u8BHcs3sSfZe1
	 +JQvcCcwRQEgUlxRniqejPTcdlilDYqAZ5kEkcCy8fEd4/CXJKJuxy+RHXaZIpee9jw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TjItntIL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789569707;
	bh=JMZc6BTWU0VD/eixJdALpvzLlqy4CkXpMmg9ILvfmgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=9Kb1tTOwjOAQVxUJ5BC2pF9j7u0JhIHklzWC4k0BvsbgeNHvAK8wk0YLRMWdg54Dl
	 uKUD5DgAyTBt2rHe1H/v278f4BhSw+z/G4Ae8yGRdeM3Xym1KLQZXOJnSHOgfG51jm
	 +xFu/kGlo4m5SjW8SXWyqu6p1vPrhuQi3zxc0QDUvUL7PisMKQijuXr8O2WyGuuw9A
	 fnkkbCSB7hqeBIMnUuaSxYOO4HpDY3f+2WNpo7aPTT+MHYnU9KVXp5VksZj0w+UC6k
	 oBz2O+VkJZjI5ksnbt6fDNsTGwHLuQKVlwzUJNrM72KJc1LNRrbZ/VulxZ/yKzRXRn
	 F5w6udXV4Ic2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58CD34072F;
	Wed, 16 Sep 2026 14:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFAE1DD7
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93FCA4072F
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8GKbpvgGJyft for <intel-wired-lan@lists.osuosl.org>;
 Wed, 16 Sep 2026 14:41:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0425E40729
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789569705;
 b=P3zoDq9TUuypkEavgDmwBwe8ad7Pw6mj8t+AMVqi//jy4uBdlVzAwNcCQ1f8AZkCiUIL
 BXU+0C0kkgdlN2Q/nrYxn7SbqODL+vE3UP/HtDpZ4yVVIFKKUDubVq2UAmLSWd6MKa0s1
 JpOh9DBLadHTVtKeblsjMN5V/k24tbO2gVgsZFHNGdEF1DKygDMLOhD1SSsyiGLIF7k1s
 s6s3XSQ825IXrLg8tKGos53Qao0FM6uLJvMGAVs9H6KI91cHUXxuec1LtKRmsCC995qPG
 NkMpUCt57cY50YK9mArlkhJbKM++JX0Bt/MzL1M74eIrRWPL+ILHjEiJ5KluCw/5eMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789569705;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=JMZc6BTWU0VD/eixJdALpvzLlqy4CkXpMmg9ILvfmgY=;
 b=HQ2xbJQ0MyJyIkP3qg0sAd/Q+4GYDg6SwjtU5zu0cDlJg7DfGEGFQXSDxN0yRps+zb1I
 ajWSqKXK12u445OwgGIeko3ywfj1TyEP79W6rz9UPyDmdBrmCGQdVRhV/RJpo768V/d3p
 evY0f2Wpltbd0igdxYL2pRQK98jGYQulc8nRWDhD5+QJqD3y1h2VG5zN9coE8d3FiSY4V
 ABZzZBFC2N4zD28r0gFKmbFyEJ0nWKFKUkFyq+E3nZqHqwIUEQRHfYAAzcQfDo9R/dMzB
 Gb2cFR5hIoacrKBlr4xyTN++LIvLSFBxJ0uGOQkaIXLCdB0BhNTQoEzrI7Xu0dPGFbw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=TjItntIL; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=TjItntIL
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0425E40729
 for <intel-wired-lan@lists.osuosl.org>; Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5E6C740126;
 Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0184F1F000FF;
 Wed, 16 Sep 2026 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569704;
 bh=JMZc6BTWU0VD/eixJdALpvzLlqy4CkXpMmg9ILvfmgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TjItntILXQLRK9sHIRtjWKrQW/zMcQCa43dRQSXmX/GfP4mY4aANGyo20d7d/N+6y
 ZvBB4OgT1RStoynml/jm1JWrwUt6OoijgWNUwjoMmJABpyBw2Zsid1mWhLJBT9hJdN
 /2Cm7aySX/34OJQTDGsyUO7DXIhQRSvs2HjJP9KHnRi5+kYO/7xi7QmHpcN7aW5qTM
 bR1I4iTST7TuwKKqwb7AqGSJuTXhclkTPAjcuocXpROwyADcGcxrKNQZAXlYsSczGM
 IiVG7XmI7RoaMwT4lrsBVUhbs7fI7RCP767k5XgRnYbgWKE8SWYxXBOQO981l8j/YX
 PaWq3Joilm9mQ==
Date: Wed, 16 Sep 2026 15:41:40 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 2/4] ixgbe: add ixgbe_container_is_rx() helper
 and refine RX adaptive ITR
Message-ID: <20260916144140.GN51261@horms.kernel.org>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
 <20260915125538.3975870-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125538.3975870-3-aleksandr.loktionov@intel.com>
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

On Tue, Sep 15, 2026 at 02:55:36PM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Add an ixgbe_container_is_rx() helper to cleanly distinguish RX from TX
> ring containers inside ixgbe_update_itr().
> 
> Refine the RX-specific latency-detection path:
> 
>  - Replace the shared "packets < 4 or bytes < 9000" threshold with an
>    RX-specific check of "1..23 packets and bytes < 12112".  When that
>    condition holds, target 8x the observed byte count in the next
>    interval by computing avg_wire_size = (bytes + packets * 24) * 2,
>    clamped to [2560, 12800], and jumping directly to the speed-based
>    ITR calculation.  This provides finer-grained control over low-rate
>    RX latency workloads without affecting TX.
> 
>  - Remove the separate "no packets" special-case block.  When packets
>    is 0 it falls into the "< 48" branch.  The mode-tracking logic in
>    that branch is extended: fewer than 8 packets forces latency mode;
>    8..47 packets preserves the current mode.  This replaces the old
>    unconditional "add LATENCY flag from ring_container->itr" carried
>    over from the removed block.
> 
>  - Remove the adjust_by_size label and the associated "halve
>    avg_wire_size in latency mode" step.  The Rx latency path now
>    pre-calculates avg_wire_size independently and the bulk path no
>    longer needs the halving to compensate for incorrect thresholds.
>    Rename the jump target to adjust_for_speed to reflect its purpose.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

