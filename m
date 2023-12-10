Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F301C4167B
	for <intel-wired-lan@archiver.kernel.org>; Sun, 10 Dec 2023 11:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31F2C6104C;
	Sun, 10 Dec 2023 11:51:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31F2C6104C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1702209115;
	bh=H1xbwGralE7uxZjJ+33BnGe8vkY6EZCzQqRVDchOF2I=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=IPRI2/R5g9oEA87HHfp8S3X7H6aB0wCWkvB1UBt9d3RcLdz8p8KMNQeZv53wY1r2V
	 tIvgBYTXaNqZn5DAf+d99Uq2kef0NS6oOyGoeWuEi+jMlUn4NBOxj1w9VtHtzJrYA9
	 S471hEwtd3qCDYju1nA95QR66fY/g6SSElPsi6cHKvo+JLvz6PN7IXNmdVHQZ9ci78
	 ek23DO2TXHZgWdaw+F3ynNL78HDzFSVXdAeJDi49flsa4/+8ZEk8QcjkY0D91m7uKq
	 +/qsP4AlzZI0TUOlG9CpNtyvxl0HjJsyqRWcSTayBBQITW7wyXr9U2/Ut1szoeqJPV
	 pfd0tHBqlGXrA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qlQahsazN0kE; Sun, 10 Dec 2023 11:51:54 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id 39DFC6104E;
	Sun, 10 Dec 2023 11:51:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 39DFC6104E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D1BC61BF593
 for <intel-wired-lan@lists.osuosl.org>; Sun, 10 Dec 2023 11:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AB86382099
 for <intel-wired-lan@lists.osuosl.org>; Sun, 10 Dec 2023 11:51:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB86382099
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9gGjOv_ItJVT for <intel-wired-lan@lists.osuosl.org>;
 Sun, 10 Dec 2023 11:51:52 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 178CB8208A
 for <intel-wired-lan@lists.osuosl.org>; Sun, 10 Dec 2023 11:51:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 178CB8208A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C78E960C1E;
 Sun, 10 Dec 2023 11:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB93C433C7;
 Sun, 10 Dec 2023 11:51:48 +0000 (UTC)
Date: Sun, 10 Dec 2023 11:51:45 +0000
From: Simon Horman <horms@kernel.org>
To: Kurt Kanzenbach <kurt@linutronix.de>
Message-ID: <20231210115145.GJ5817@kernel.org>
References: <20231201075043.7822-1-kurt@linutronix.de>
 <20231201075043.7822-3-kurt@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231201075043.7822-3-kurt@linutronix.de>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1702209110;
 bh=8hTdvcrbcL4qIM6aKdbSw/ub3cwrRNRrsKXQOdmxI6E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DPxycj5O5P8obRqAFQ1tUfB/BjKIMpVQ3AwaD55Ua5e21OMrZVIcdcqnvvEvC2KLK
 asPtbqD+AIlhzC6JR+sbjBhTJSfhiu8+oaDT2sQWy6c1lshihVAJlZ0X1huMs/iuDJ
 qwDTeOQhuVvYWSh1xhXWVLd0oQqB3oi1IXjrfu1jPHYxcVHefsU76y8VoCRNKSlLuT
 tidBxjdSDzJAUs+OW+NAz7gltROlX+D+ZwDKXFj+kQmEmdlkpPsyGEQdiZJ1RaYyrc
 GZMihaMgnEF8EeZtalLTnglYRsUBVAcogVBVOpucgLcG8gMZ7p/lh77kQ5jVO3UPT0
 Jm4Uf3xGs27Ig==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DPxycj5O
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 2/2] igc: Check VLAN TCI
 mask
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
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 intel-wired-lan@lists.osuosl.org,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Dec 01, 2023 at 08:50:43AM +0100, Kurt Kanzenbach wrote:
> Currently the driver accepts VLAN TCI steering rules regardless of the
> configured mask. And things might fail silently or with confusing error
> messages to the user.
> 
> There are two ways to handle the VLAN TCI mask:
> 
>  1. Match on the PCP field using a VLAN prio filter
>  2. Match on complete TCI field using a flex filter
> 
> Therefore, add checks and code for that.
> 
> For instance the following rule is invalid and will be converted into a
> VLAN prio rule which is not correct:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
> |             action 1
> |Added rule with ID 61
> |root@host:~# ethtool --show-ntuple enp3s0
> |4 RX rings available
> |Total 1 rules
> |
> |Filter: 61
> |        Flow Type: Raw Ethernet
> |        Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Dest MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
> |        Ethertype: 0x0 mask: 0xFFFF
> |        VLAN EtherType: 0x0 mask: 0xffff
> |        VLAN: 0x1 mask: 0x1fff
> |        User-defined: 0x0 mask: 0xffffffffffffffff
> |        Action: Direct to queue 1
> 
> After:
> |root@host:~# ethtool -N enp3s0 flow-type ether vlan 0x0001 m 0xf000 \
> |             action 1
> |rmgr: Cannot insert RX class rule: Operation not supported
> 
> Fixes: 7991487ecb2d ("igc: Allow for Flex Filters to be installed")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
