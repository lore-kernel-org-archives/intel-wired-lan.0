Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932A5C4332F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Nov 2022 09:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2D77E400B8;
	Thu, 17 Nov 2022 09:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2D77E400B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1668677295;
	bh=zL/6+qtBbgJ9MP4FmiXEfHDYjdeb88Ol/ST2D3r46ag=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=9asrw93zF8O/3S/LqTH5U1KcdOknzUAhYSIpwZNQk4Spg4BzfoJYfFbj59nmKhJvF
	 wHCM4BjbcyIhP5wiR1utseMXDJGsEIMqkB6aITajwC/8uQrd21MLBUr746t6ki1q5Z
	 pPPI2boe8xrB34uXEM0ofgMRZIgKm8QDAuzjnrnEe4Oih5MTIW9lFmgqfENK0CJ55Y
	 I1zKgCiG5TJYki2f6D6PDysKg1ZnkSWFSu8w3WxK9E4iKzVcgmpSpKm2cUh+t1NC9R
	 aNhgl6sVLYsbYTF2LvBpnfOgI+/6M0gbuCYFIlhsAqj04UB2i1v0VS1NQ1rSsPgDFq
	 9KllAwNgvKpkw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UyxDszDLpj2p; Thu, 17 Nov 2022 09:28:14 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 214A840135;
	Thu, 17 Nov 2022 09:28:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 214A840135
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 7890A1BF420
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Nov 2022 09:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5003360B38
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Nov 2022 09:28:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5003360B38
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spbFuymvcZ4E for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Nov 2022 09:28:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9359860AFD
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9359860AFD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Nov 2022 09:28:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7E98A6213E;
 Thu, 17 Nov 2022 09:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D10EC433D6;
 Thu, 17 Nov 2022 09:28:09 +0000 (UTC)
Date: Thu, 17 Nov 2022 11:28:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shang XiaoJing <shangxiaojing@huawei.com>
Message-ID: <Y3X+pfOrzs8ixfN8@unreal>
References: <20221116012725.13707-1-shangxiaojing@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221116012725.13707-1-shangxiaojing@huawei.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1668677289;
 bh=Oex1I4PJC33uMiV0mNtJNYONNRm/L2AyQ8IgLlbY8cc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tl1vMeITZNyPKTp99sn0HF9atzlO/RoeiCZRFbM4GR0dlx9/9vAPxD4fkJdqpKJC+
 KYvPGd0vdPwBq97tnybf75m2PhGXA8qAEH6FBfe1RgbLmC2msFoxuGiFlsSLL2HOC1
 w0vt18XmuovJVawukxGNGV4K/M+i7vrxHlqYwvSf06/20zp9WZeZ7lVHxbujh4Ux1+
 Z1i2znkmxI2PH9fNej/vaTpuKFGa8AdMpllMeFCr6ycaE5KE7lG/2zjepdwrKmiqe5
 DCuRAHPByGROdyHh6LgjXisV+IgK9Xxe830Pp9YO/dtxZ3egohEE19i9YRQeX9XyLI
 5wPLEWELUZcpA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tl1vMeIT
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: Fix error handling in
 i40e_init_module()
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
Cc: intel-wired-lan@lists.osuosl.org, shannon.nelson@intel.com,
 edumazet@google.com, jeffrey.t.kirsher@intel.com, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Wed, Nov 16, 2022 at 09:27:25AM +0800, Shang XiaoJing wrote:
> i40e_init_module() won't free the debugfs directory created by
> i40e_dbg_init() when pci_register_driver() failed. Add fail path to
> call i40e_dbg_exit() to remove the debugfs entries to prevent the bug.
> 
> i40e: Intel(R) Ethernet Connection XL710 Network Driver
> i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> debugfs: Directory 'i40e' with parent '/' already present!
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
> changes in v2:
> - destroy the workqueue in fail path too.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 

The subject line should indicate the target branch and needs
to be [PATCH net v2] ....

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
