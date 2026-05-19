Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF8DCD4F54
	for <intel-wired-lan@archiver.kernel.org>; Tue, 19 May 2026 19:46:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 526D481B6D;
	Tue, 19 May 2026 19:46:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KMjTqgzf90Wc; Tue, 19 May 2026 19:46:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7011B81B69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1779219971;
	bh=9/gISngu1YBPhlTCpjdF9NeYFRX29qtCBzl2K8u7rMA=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IEpaSThcxm0kf0oIIP0XjqL8aS3HsKiihkpXJFNGlvRk7bzJt0KBwF0aqODModnt+
	 qEVDXdcZcemO2fg5wefsCqnXYYdsUTvQsftH+omOWv3yuIa68Xg/xpJgVJFF/Qp0Cr
	 euIbeVdJBC02Ki0RmUiadyGC6tS7rd8t2+SO4ii2FI1QUUMnkTbYoCIvFU5gEQ7sR/
	 FuMXBVThSzFTdUD3GCYNAl1GyLa6ZxSnkZCJJuHYuCnQ18eCMnptU6jnYQG/ujr4uq
	 wkwGhhrJuGCPIwB4XO7m0H6FEdpOncVlJgvUivRWkIsNV7Xqmlax7hzYmbAqBmgw8J
	 KMxD3a3ZCdjPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7011B81B69;
	Tue, 19 May 2026 19:46:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2A211B2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 May 2026 19:46:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3F1F404D3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 May 2026 19:46:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7aRYOtFLg-ih for <intel-wired-lan@lists.osuosl.org>;
 Tue, 19 May 2026 19:46:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 330B14008E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 330B14008E
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 330B14008E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 19 May 2026 19:46:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E9AD460216;
 Tue, 19 May 2026 19:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2281F000E9;
 Tue, 19 May 2026 19:46:05 +0000 (UTC)
Date: Tue, 19 May 2026 20:46:02 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Wilczynski <michal.wilczynski@intel.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <20260519194602.GK98116@horms.kernel.org>
References: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514-jk-fix-missing-xa-destroy-v1-1-de437bf52347@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1779219966;
 bh=9/gISngu1YBPhlTCpjdF9NeYFRX29qtCBzl2K8u7rMA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=B9as5wuaORLXiWK4cLkWHmh5uPzJYl+P8FtQ2E1SQffGs6a0SzEn6BHGjiRf65qif
 lpj/RKDO+K/77WnitPgMAJMyTDPHgmUJh9ToHgZjjG7fDvYc/A7freDBX/NSuEi2LW
 EMzcq4uma7zQLPsWsmdfw0OJOBZnNjQ7sHboJCjG0kn/Amk8eA40PERiCjsft5EEYh
 LGmumH61snkjbrhri52tzT1wzyKMxwAwGA+w+URk1Lr3qhJj3gRe7y0FvSyaZZwjez
 LlRkM6KA3fnZQdI84YA+LDbjGhWLr8qiy1lUAXgvf53Uns4JJcSc8Mi6x6GwAlUV34
 ruD1Oc3TqNORQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=B9as5wua
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ice: add missing xa_destroy
 for sched_node_ids
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

On Thu, May 14, 2026 at 09:55:21AM -0700, Jacob Keller wrote:
> Commit 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
> added a sched_node_ids xarray to the port info structure, but never called
> xa_destroy on it.
> 
> Since xarrays can allocate internal memory, this can result in a memory
> leak even if every element in the xarray has been removed.
> 
> Add a call to xa_destroy the structure during ice_deinit_hw(), and one to
> the unrolling cleanup path during errors in ice_init_hw(). While here,
> remove the overly verbose comment explaining the nature of the
> sched_node_ids xarray.
> 
> This was caught by Sashiko during development of unrelated code.
> 
> Fixes: 16dfa49406bc ("ice: Introduce new parameters in ice_sched_node")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

