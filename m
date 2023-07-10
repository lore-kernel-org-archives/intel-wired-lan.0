Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22338EB64D9
	for <intel-wired-lan@archiver.kernel.org>; Mon, 10 Jul 2023 08:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7AAA40300;
	Mon, 10 Jul 2023 08:13:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7AAA40300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1688976805;
	bh=VmFWFiGpyA2rIJ4u5nsaxANKG7FIsbTaWV4bwdpEQI0=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JVJU9bEgw0RdW0Fkn65NjolBAib/DpEk0wrujuNP4UO39Cfsv3ImiAnMAuDqrmV2s
	 RLOrfzL+qYUr6B3NAadvOMQGXgRwGXUazdMmqb+aKDl9TgmU7XP6E/Ua1MsOONXb2h
	 vUBfcQ5Eiq1M4qn8hNz7J1+HhFFOAiZZvO+BT3fXJbmWYJstA0Ohh7LoD6IpVpGywX
	 IbOjAVhNeltcjPp60HpoAVY5kbKaEuC59wyI24OzNX1NweqdCvTPvjGi/BzbABu+N4
	 ComYF4KFLse4PUR29xClgcB7BDAE72Vs5pbpcDsinH7zep4b5cyPQdX+AvDa4c0NFe
	 a1OGjBlPO3uEg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e9VzYcW8MtUI; Mon, 10 Jul 2023 08:13:24 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A6CC40327;
	Mon, 10 Jul 2023 08:13:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8A6CC40327
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id ACC2B1BF429
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jul 2023 08:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83623402C0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jul 2023 08:13:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83623402C0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vL9wX4F0tzS9 for <intel-wired-lan@lists.osuosl.org>;
 Mon, 10 Jul 2023 08:13:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 148CB402B3
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 148CB402B3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 10 Jul 2023 08:13:20 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE26D21E95;
 Mon, 10 Jul 2023 08:13:17 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AB4C13A05;
 Mon, 10 Jul 2023 08:13:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ULMlD529q2SGBwAAMHmgww
 (envelope-from <dkirjanov@suse.de>); Mon, 10 Jul 2023 08:13:17 +0000
Message-ID: <7a561aac-08c6-5a20-6254-82b2c2601d13@suse.de>
Date: Mon, 10 Jul 2023 11:13:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Yu Hao <yhao016@ucr.edu>, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <CA+UBctC57Lx=8Eh6P51cVz+cyb02GE_B-dWnYhffWoc-nm7v6Q@mail.gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_rsa; 
 t=1688976797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Qf7yQhkpIDFSE/7LQCLIc2ZQ8OuhBKadYzy9Ww5b4=;
 b=vZw/xNLiNv8xBtbYQWSKrAUI54ZT+td8vCMhypzL7tgvJIhOWqEdXcPd4iydz83MHCyYiI
 qYs6AedS0JYx4W4SzzvDdIsqb4X77iKtjvFzXWGB1iSWVdH/ekiPbFiQ9eqN16x9pxmNgn
 iXnXjQQPbFLZ5xDPy512COTLCJoZzQY=
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=suse.de; s=susede2_ed25519; t=1688976797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8Qf7yQhkpIDFSE/7LQCLIc2ZQ8OuhBKadYzy9Ww5b4=;
 b=zZYoyHi7O1KjDjFi+PlQntA6HC9pudWQ/H72oH5oG/cR1Av+v8ja0g1neTk5cUrsO+pP8g
 gxLPvVh3RDLyc5Cw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=vZw/xNLi; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zZYoyHi7
Subject: Re: [Intel-wired-lan] [PATCH] ethernet: e1000e: Fix possible uninit
 bug
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>



On 7/5/23 03:10, Yu Hao wrote:
> The variable phy_data should be initialized in function e1e_rphy.
> However, there is not return value check, which means there is a
> possible uninit read later for the variable.
> 
> Signed-off-by: Yu Hao <yhao016@ucr.edu>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 771a3c909c45..455af5e55cc6 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6910,8 +6910,11 @@ static int __e1000_resume(struct pci_dev *pdev)
>     /* report the system wakeup cause from S3/S4 */
>     if (adapter->flags2 & FLAG2_HAS_PHY_WAKEUP) {
>         u16 phy_data;
> +       s32 ret_val;
> 
> -       e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> +       ret_val = e1e_rphy(&adapter->hw, BM_WUS, &phy_data);
> +       if (ret_val)
> +           return ret_val;
>         if (phy_data) {
>             e_info("PHY Wakeup cause - %s\n",
>                    phy_data & E1000_WUS_EX ? "Unicast Packet" :

the same case appears in other places in the driver like e1000_setup_rctl()

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
