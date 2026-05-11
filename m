Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AFFCD37B2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 11 May 2026 15:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E9DA410E4;
	Mon, 11 May 2026 15:27:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9czIFWBTg_my; Mon, 11 May 2026 15:27:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0DFA41162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778513250;
	bh=Q1/TlIFufS3xXQJ1WM5QpT7rFtcQBD9YePscGZ4EDYM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q3kiSvr8uxh2GkgQ85HVAQHfwatBvkIUsKu8AvWahacPwvex6+gW1XCVqmngR7yms
	 nGTI0zsZE5++pdS6Y4j9EzRit0OTv/z0acj0bgld5mTB78yzEqCcIeP0lGCoWsUAX3
	 gmK0FHjC/R1Boyl1y83dBtbrQrlwXIj2rbAzC2eMokfChws+F/YuAP7vMslzbs0iky
	 ygOlas+JjjrwqW7Qak+TBI2QRgnBk5SMzDHD96SYI3ByhQ4y7rRzDvpvsr3BZ8HY2Y
	 Dk55hteVe64kOlYomkhicBcC/GO8e23k5djDHffouTLpalwSiKJMRcj8ul6uTGaxu8
	 gkgegkxIxdfiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0DFA41162;
	Mon, 11 May 2026 15:27:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 57DB1272
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 15:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49F0041162
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 15:27:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uXTCCOUHIbCf for <intel-wired-lan@lists.osuosl.org>;
 Mon, 11 May 2026 15:27:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 87D45410E4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 87D45410E4
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87D45410E4
 for <intel-wired-lan@lists.osuosl.org>; Mon, 11 May 2026 15:27:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C21C842A85;
 Mon, 11 May 2026 15:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925AFC2BCB0;
 Mon, 11 May 2026 15:27:26 +0000 (UTC)
Date: Mon, 11 May 2026 16:27:24 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20260511152724.GA27589@horms.kernel.org>
References: <20260508031226.3601800-1-aleksandr.loktionov@intel.com>
 <20260508031226.3601800-2-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508031226.3601800-2-aleksandr.loktionov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1778513247;
 bh=lPTcpIsJwfOPf9wIvYhMTgk0EC/36bqpraey/F/PXmQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=boEklgmpUgjm3ZGvguW45hRvg6UioP/0VSQjV4B3/HCdc7YkGjfIOBXywZ7AhK3lS
 oDs/ruDkNRgfXKfuZGHL8eumdvEZHd1Dl3G+uYVTfDrZXf+FlQZ4NtJhEPTDxfCu0B
 8QLNPTPQoyfrNndjshQBoUj1Eu8uiEG1K8lVNQd+D3qZT/6V5OjqUIjlygMxbkHjro
 QoPUBsG25piHiTrRel07rlRAMrYqnLC6nMm89woYz5JSzWAKZCTnOh5CaRjU48qMDS
 zcZt8QxNmhVC2EO7vaGvfZHMhkFoitO/95Qm5wYC34wqVW17RTehPLr8PqV807TwKX
 GTLBC5VUaymkw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=boEklgmp
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/8] ixgbe: rename numa_node
 to node in struct ixgbe_q_vector
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

On Fri, May 08, 2026 at 05:12:19AM +0200, Aleksandr Loktionov wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The 'numa_node' field in struct ixgbe_q_vector shadows the 'numa_node'
> accessor for struct device, which triggers a sparse warning about
> shadowing a built-in object.  The stored value here is a plain NUMA
> node number, not a device attribute, so rename it to 'node' to avoid
> the shadow and keep the naming consistent with other Intel drivers.
> 
> Update all three usage sites in ixgbe_lib.c and ixgbe_main.c.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

