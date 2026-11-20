Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C0606A33F
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 20:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AgdrvUA2;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=IGPBkBBm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA602606D5;
	Fri, 20 Nov 2026 20:33:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6cz2lHpTcrpK; Fri, 20 Nov 2026 20:33:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7FB8C60698
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795206827;
	b=Op9Lg0dfWAU/J27RvnYbQ9TijmZdBtcXv4cAgAmKS8gIxn2aQcl6xfbCjUaF6MU+VW76
	 DO/D4oZgfykOFP4ExWqAos/cdA+V0HrJRXw6dbc52arKp+F3wrKH2Bo9cje8mhBejVM8Q
	 1tsUbcVgeu1qQtHplYUuNGb3bgFBZGpONKT8Pwv6J4R4kgmgb9ygqrlDtxyNRZ37f1Tmp
	 cHNmKyPphRqcExwLYCcWz1Vf+qBgMUNHjJ8W+/MYIR0Dgaw7T4+joFPmGCCAifQyEc+oP
	 h9YEaaypO9+8j2gOgE1F6tScXdv4D79tQMC9uP1fjY03Cxt4gvEh2mi1MuKJrK/L43w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795206827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hZm9lZhgjP3OUdGyGGXPNH376tgpFhHxDRPWMChVfQo=;
	b=BtIh1AtcBMDnkgxK7JmA/YZJXnnRCCnPl26GSg5arbRiLTsw0eR87h7lSKocLxRAfbqz
	 Ghju1YikjN+PA1bQ+mediCOfWA5WRSXbcYiZi4F+iulZzcXYRV8pazeAZHwVwX1KVPOs0
	 2Bph28noQoyxImx4fyHmtqYboZGZ+6SrX9EkbCa17DgQkqftvnZsFEKrdtuBY1R6N3J3V
	 Kv32LWkGdkpST5cf7Xqw/TzhHFLagkOjTzSsqXtU8SiARKMS9miuvAU50X9nsEvQo0pJw
	 Ym8tGt+J1hHrirj4l8OITtiySy9MM6585Xsi9AZqVTfvfA7vxobpJIUj14+LfaHCHBw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795206827;
	bh=hZm9lZhgjP3OUdGyGGXPNH376tgpFhHxDRPWMChVfQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AgdrvUA2un+Xjy/K/7jfPoM574na433JtM+xNU4e+9+9vn1mcj2GIaVh+usMCFYqt
	 iEJiP10rn4yBbT0d7OwkCWOeYWTfFiNAeEdFiVw4h1ToNP05cHsBBvpU56UEdwKJ/d
	 Qt9QH5spSrF35dys9Fv9Xx+k7izQrRNJmu4cShfy0115DbopkKw/6MYfEG6wSV3vGM
	 MnFqxHCSY6oV5SI3mcbqMHUOimTz6mrkNGMukCIBr9TxIXSoOMmZfUwSXvG3V1s35N
	 MrBdFR5biYcUvwlyZ0a+vnKn6RXdUnkkvB/zdpr4uxCvfYOw0nBy8egEm61OsivAJs
	 wizM41sFtuiiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7FB8C60698;
	Fri, 20 Nov 2026 20:33:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF22F971
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 20:33:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0F7040208
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 20:33:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DTbgRLKFJ0qq for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 20:33:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C2DAA400BE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:102:465::112"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:102:465::112; helo=mout-b-112.mailbox.org;
 envelope-from=antonio@mandelbit.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mandelbit.com header.i=@mandelbit.com
 header.a=rsa-sha256 header.s=MBO0001 header.b=IGPBkBBm
Received: from mout-b-112.mailbox.org (mout-b-112.mailbox.org
 [IPv6:2001:67c:2050:102:465::112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2DAA400BE
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 20:33:44 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-b-112.mailbox.org (Postfix) with ESMTPS id 4jWRr33fXHz5vlP;
 Fri, 20 Nov 2026 21:33:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
 s=MBO0001; t=1795206819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hZm9lZhgjP3OUdGyGGXPNH376tgpFhHxDRPWMChVfQo=;
 b=IGPBkBBmfyWPT9KNs3XohQTh3sgzvSyuVUOo9WmuovDUMwEzWssc5oyugKzRgf1dL7Os7H
 Plung0i0xrH0Y1cYq4OO9vbr/ttVWaGIzgtvU8M6zFihqTTAOUBIgI/lKFdGcslON1dvr5
 qHhMjkFhcq/xwW+DLiXZwKasVBPYaVN8FNkYNLqHeUX+0Gi/CowhfgHOpuHs/Dn+wSZJKt
 aR1RaERl+nq7pB4Aez+1w+lfpjy1sgx4ZsYZjCAe4OmISJ/18QdN1YqE90YHtUQ3P2quB4
 qH4St5k4QpF5pHu7uxUX/0EYaZ5W9hUZYu4YPOsu7mqbb8xb6bjMlw8mVADRiA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of antonio@mandelbit.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=antonio@mandelbit.com
Message-ID: <02a73961-95ab-4caa-85d8-ea92f916a0ab@mandelbit.com>
Date: Fri, 20 Nov 2026 21:33:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] igb: don't disable rings that don't exist when
 disabling an XSK pool
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Janis Edvarts Lacis <janislacis06@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261119140412.163202-1-antonio@mandelbit.com>
 <20261119140412.163202-2-antonio@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Organization: Mandelbit SRL
In-Reply-To: <20261119140412.163202-2-antonio@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jWRr33fXHz5vlP
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Apparently Sashiko has hit a little, but valid, interesting hitch on 
this patch.

Will need a respin.

Regards,

pw-bot: cr

On 19/11/2026 15:04, Antonio Quartulli wrote:
> xsk_get_pool_from_qid() checks the queue id against the stack's real
> queue counts, which can be higher than the number of rings the device
> has, e.g. after igb falls back from MSI-X to MSI on resume. Disabling
> the pool of such a queue then passes a NULL ring to
> igb_txrx_ring_disable().
> 
> Only disable and re-enable the rings the device has, as
> igb_xsk_pool_enable() and igb_xsk_wakeup() already check.
> 
> Compile-tested only: the XSK pool path isn't reachable with the QEMU
> 82576 setup used for the rest of the series.
> 
> Fixes: 80f6ccf9f116 ("igb: Introduce XSK data structures and helpers")
> Cc: stable@vger.kernel.org # 6.14+
> Link: https://lore.kernel.org/netdev/20261116153041.3002666-2-antonio@mandelbit.com/
> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> ---
> v3: new patch.
> 
>   drivers/net/ethernet/intel/igb/igb_xsk.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b5..8ed82bb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -148,7 +148,12 @@ static int igb_xsk_pool_disable(struct igb_adapter *adapter, u16 qid)
>   		return -EINVAL;
>   
>   	rx_ring = adapter->rx_ring[qid];
> -	if_running = netif_running(adapter->netdev) && igb_xdp_is_enabled(adapter);
> +	/* The stack can know more queues than the device has, e.g. after a
> +	 * fallback to fewer queues on resume: skip the rings it doesn't have.
> +	 */
> +	if_running = netif_running(adapter->netdev) &&
> +		     igb_xdp_is_enabled(adapter) &&
> +		     qid < adapter->num_rx_queues;
>   	if (if_running)
>   		igb_txrx_ring_disable(adapter, qid);
>   

-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com

