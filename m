Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB06AC4345F
	for <intel-wired-lan@archiver.kernel.org>; Mon,  6 May 2024 08:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCB2B40638;
	Mon,  6 May 2024 08:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VlMZOy3P-MrA; Mon,  6 May 2024 08:44:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.34; helo=ash.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9153140543
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1714985059;
	bh=Rxd2V1jhcezfBVFCrtUMkisPItX3bopxaNY+q+OQ/5k=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=8yK8zVs21lF+PHF3gx5XcOKkcRPgeR071hHEmW0b+TX/6TXunsBBew8AgvFwtemC0
	 PE9eajZ4xGl6V4aepkp190I8BPj4KP+oqOtz+NljUR+u4HJRnRqpYam1fTpFgwfeCd
	 BAPvVUs+qs4d1g3me3RTBKp+vfj6/mGz5kZbs2C93Cu00atJLAz1otkj7p6EuxJrOO
	 lhqRlbaH0274OsZ5Ee1arz7QaVvtbtr5E8A1VdT2lGkRLz4i9t5BLli27a9Q0DkGEV
	 qgVQ5UHCjUGxE1Q8JkUzOsToYIaOZ2meeI8aZOMVdSE2eha1NgTMuguO0e5bn/T1Xd
	 5lamnI/VSi5WA==
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9153140543;
	Mon,  6 May 2024 08:44:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 302E11BF38A
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 May 2024 08:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1A617402D9
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 May 2024 08:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xrmzdiVTQpQk for <intel-wired-lan@lists.osuosl.org>;
 Mon,  6 May 2024 08:44:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.104.135.124;
 helo=mail1.fiberby.net; envelope-from=ast@fiberby.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 25635402D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25635402D8
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 25635402D8
 for <intel-wired-lan@lists.osuosl.org>; Mon,  6 May 2024 08:44:15 +0000 (UTC)
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
 by mail1.fiberby.net (Postfix) with ESMTPSA id 13B00600A2;
 Mon,  6 May 2024 08:44:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by x201s (Postfix) with ESMTP id 3F41820146D;
 Mon, 06 May 2024 08:44:03 +0000 (UTC)
Message-ID: <7cf42f1b-d7e2-4957-bee9-e875c61d19e2@fiberby.net>
Date: Mon, 6 May 2024 08:44:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
References: <20240416144320.15300-1-ast@fiberby.net>
 <PH0PR11MB5013807F66C976477212B27C961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <PH0PR11MB5013807F66C976477212B27C961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=fiberby.net; s=202008; t=1714985052;
 bh=TjbpkkZ794tR7dnJwl4XSmaecxKfYD4Yj3mozjWLP7A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SD98I92zttS3zulSx8ejP2fSeKAcPByx/Tk9hNJtL/s8/JxxsT9KejIppr9a5m7Yi
 q4xX/FaXcc5L19iCg/oqS7fJpmRqGtI8je3AHnkBNeodjQJhYHHMNdWPZY2LFUijAC
 GCiH38AaP6z/jTb8hJTyDKGFl4ARvMyDufooc6K+tWFjstlSNJ9nz6FXLxqI6bBreG
 wJWpyAjxDnr/Nv09mimFV8ty4WhZhA9ScIIFm+GoU6Z6ovWeGSNS4lqnQwTikRJ8yG
 jw3BHiNUjRk+hxhm2t/ntRXjJblVyKI/+WoEjqMbObzi4BryiVzynDa65pQFOgAPml
 AAx4rdg/dPNnA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=fiberby.net
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=fiberby.net header.i=@fiberby.net header.a=rsa-sha256
 header.s=202008 header.b=SD98I92z
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: flower: validate
 control flags
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Sujai,

Thank you for testing.

On 5/6/24 5:32 AM, Buvaneswaran, Sujai wrote:
> HW offload is not supported on the i40e interface. This patch cannot be tested on i40e interface.

To me it looks like it's supported (otherwise there is a lot of dead flower code in i40e_main.c),
although it's a bit limited in functionality, and is called "cloud filters".

static const struct net_device_ops i40e_netdev_ops = {
	[...]
	.ndo_setup_tc           = __i40e_setup_tc,
	[...]
};

There is a path from __i40e_setup_tc() to i40e_parse_cls_flower(),
so it should be possible to test this patch.

Most of the gatekeeping is in i40e_configure_clsflower().

I think you should be able to get past the gatekeeping with this:

ethtool -K $iface ntuple off
ethtool -K $iface hw-tc-offload on
tc qdisc add dev $iface ingress
tc filter add dev $iface protocol ip parent ffff: prio 1 flower dst_mac 3c:fd:fe:a0:d6:70 ip_flags frag skip_sw hw_tc 1

The above filter is based on the first example in:
   [jkirsher/next-queue PATCH v5 6/6] i40e: Enable cloud filters via tc-flower
   https://lore.kernel.org/netdev/150909696126.48377.794676088838721605.stgit@anamdev.jf.intel.com/

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541
