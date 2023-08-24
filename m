Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E99C6FA8F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 24 Aug 2023 14:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 003B882265;
	Thu, 24 Aug 2023 14:49:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 003B882265
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692888567;
	bh=XNB5s//vex+ilI15Shs2tosd/7bFF9Gzg9VYF3sBMQo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=UuqDhJf0QaiCq0Sp5vfJOCUWbImbUMiOV5OJmVgDm1AiXUstoOpIvCKxF7/j1pS0e
	 RSWuSqobH+iK8jnYBtFOqwkBDu16K+gOTEEG87drFY7dfdjaeHFW//E5F6g5f/9aED
	 8fL0jo0MUhYkYmdaY/+8YNf22dA3fJDlhmdRB9iApAv2oXeQZoZN64lFwHCEqDifUi
	 8Kuir8XkKd08TqYti3xn5UHwypbI7TccSzFrpqAvhW6xzPbAK/7HaJpO+8b09cQ9EZ
	 9yoyS/i5dnxD4XJDBShT2Nd4afR9IoYWArQY01larh+v1qqS+btemdriMwHXladMtU
	 +HxUhU6F1IMTw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uYYPfmTu18Cm; Thu, 24 Aug 2023 14:49:26 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B182813AB;
	Thu, 24 Aug 2023 14:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B182813AB
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 175641BF30C
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 14:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE32E41558
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 14:49:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EE32E41558
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WuCapK2E-sMm for <intel-wired-lan@lists.osuosl.org>;
 Thu, 24 Aug 2023 14:49:24 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 078A9404E0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 24 Aug 2023 14:49:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 078A9404E0
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DA1F2617F5;
 Thu, 24 Aug 2023 14:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34FF9C433C8;
 Thu, 24 Aug 2023 14:49:16 +0000 (UTC)
Date: Thu, 24 Aug 2023 16:49:07 +0200
From: Simon Horman <horms@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Message-ID: <20230824144907.GI3523530@kernel.org>
References: <20230823221537.816541-1-vadim.fedorenko@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230823221537.816541-1-vadim.fedorenko@linux.dev>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692888562;
 bh=JHO5XVOq1X6JltauUfgGpAsDE8mIiAO0JKHrq9w2P0Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rZEKa14a2pU3qdt6cIfXE0T6L6Jt2XAUlYGZg/NGIgjLhxfzULY+xbVl+xj+BVd8t
 3mKXVe+t82h4PkBYF6uZGU4jNNdFMCSUSZF+YbPiSITfQrLPIVbVlG1JscGSzLSQln
 kCOtDmgpuQ+0A4V2n97TTe7ZTMbIPSCwg3R0ggKW/vtvHaW2U9xJg8nnN+ZFMAi7q1
 IH62qNNeL831aguE44N9VkyLM9JuO0Bn44a0BcJH/tsOzBW3h5UGNWLZ54o8JuW7Hd
 szDC4nkcSW7nphXx8HELPuQXUnH7S+cxrmtc8OGNshDgSwS9itTyBS6VsTMjkcaHBs
 87xhZyOqjn1xA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=rZEKa14a
Subject: Re: [Intel-wired-lan] [PATCH net] ixgbe: fix timestamp
 configuration code
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
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Darin Miller <darin.j.miller@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Aug 23, 2023 at 11:15:37PM +0100, Vadim Fedorenko wrote:
> The commit in fixes introduced flags to control the status of hardware
> configuration while processing packets. At the same time another structure
> is used to provide configuration of timestamper to user-space applications.
> The way it was coded makes this structures go out of sync easily. The
> repro is easy for 82599 chips:
> 
> [root@hostname ~]# hwstamp_ctl -i eth0 -r 12 -t 1
> current settings:
> tx_type 0
> rx_filter 0
> new settings:
> tx_type 1
> rx_filter 12
> 
> The eth0 device is properly configured to timestamp any PTPv2 events.
> 
> [root@hostname ~]# hwstamp_ctl -i eth0 -r 1 -t 1
> current settings:
> tx_type 1
> rx_filter 12
> SIOCSHWTSTAMP failed: Numerical result out of range
> The requested time stamping mode is not supported by the hardware.
> 
> The error is properly returned because HW doesn't support all packets
> timestamping. But the adapter->flags is cleared of timestamp flags
> even though no HW configuration was done. From that point no RX timestamps
> are received by user-space application. But configuration shows good
> values:
> 
> [root@hostname ~]# hwstamp_ctl -i eth0
> current settings:
> tx_type 1
> rx_filter 12
> 
> Fix the issue by applying new flags only when the HW was actually
> configured.
> 
> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices")
> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
