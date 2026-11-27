Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04A606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=ArCvOgth;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xp8ZM7UT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E473160AD0;
	Fri, 27 Nov 2026 13:36:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuyKauZ5YF3w; Fri, 27 Nov 2026 13:36:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B041860AA5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795786578;
	b=Ou7FXqvHow4ACFvCbKrIZONvYcG/8TCS93hRN2TRVO8iQrjynPsSpgDnjnNqw01Qj5JN
	 x/bJDlp9SarmJwswLHNYPiGFyef906jHMeUdDNRujUpro2H4zRKceLePOTopAaIsTq1I2
	 Bycc/8lAR4JP9v7wu7X07E8hXz5fqTJTDauXfIo0HtaxvylYl4fAS7ZMiU+ESi/kF9SNA
	 Dpja0F0GeAvLkbpwealNOwPSqNFl6iyfL6eCzUSqcg3/T46COsk7zE7ltPE/WG7fSTyi9
	 soRte80/rfNXXq7RDSo7StMtIncXqiD93QYAuzVJNCAgurJ8mqfp6HDKLK/3PmtfzxA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786578;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:In-Reply-To:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Language:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2zwWUQKFRVBnh1e/1qUGMrFHMuSVTqbKwP//bS3MkZc=;
	b=C5dgC9odhDXJLK/uRd7WxXOqN0+tV4Mi6Z8B8oAbReZY2Abf0AqEvLk+X3dVAX78+Ka5
	 ZiC0aOi+uR90w4v8gy11qXOFo+wW8851ui4fCVjjAuhuqMDV5K8n+Jzi6NGbGIMEim+sO
	 GxXsqL+6cEimEpJunJdQc+xOUsvlzPodPUktPfj7dYueU+VFCM4tD7cQaBcA49pWzzsZy
	 FkhVM/2qkaL5++xpuUPlCXagUbIDL/yCXBBIQBsePRch77YVOT0/43RM0ZjWAS+q6gXvT
	 J514I3ECGYYSKsuDZNhPYZLS7g4YNqqm0PjuMnSbM2yPdWdVRHOSOD26fDGoP0C2oiw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795786578;
	bh=2zwWUQKFRVBnh1e/1qUGMrFHMuSVTqbKwP//bS3MkZc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ArCvOgthzHWGiOHdWDLKcCXnsOh1kWoGgZQQ1/VBwK+cB1vbWc7WytaxIrlWZ0Wux
	 jaap0rdY/Pk5peIJsvkmjIqE9g3Fni21Fsus0+neinSMr5YPMmJste2iRlWwVZdcSW
	 tqZL5q8o01lohQDuDzUe0F3fVpHMcWOq08eiq+R+gt/jMzq0Bu4cbrAxyiSs2NoxYm
	 DlK/8yj5mMx8xYlEVaBipeq7DEInMQK8xyWO3HlK3XUMlvWfJBi9TSmFSFPUChVi9v
	 PnF0hl6X4xMWbNxNLSKD3/v09FAE//JvfQ9I68ERr0pBDsQSQ5RFghzYh97HpDl9DQ
	 d9afqBnOvFtfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B041860AA5;
	Fri, 27 Nov 2026 13:36:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31D162BD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 175BC40A34
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MFr7jRUVH811 for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 13:36:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C936940A32
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Xp8ZM7UT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C936940A32
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795786574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zwWUQKFRVBnh1e/1qUGMrFHMuSVTqbKwP//bS3MkZc=;
 b=Xp8ZM7UT0SYSkOeKbE/eY4O/DuigJ2+zCRvE3tFigPe5vxxIYHox1N9N32T1UEm26U7fjQ
 WkbyP2SGMTxO4rcSlRUp+eKvUh7puH0Y/W/Lh3U8fSNt8JeVaAYtt4PkVFSMmRS28d7FvG
 R62D0KZSFGv0SjjNq+mRX3BsKd95U4w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ggFaK2BCNQu3bFHK3zP90g-1; Fri,
 27 Nov 2026 13:36:10 +0000
X-MC-Unique: ggFaK2BCNQu3bFHK3zP90g-1
X-Mimecast-MFC-AGG-ID: ggFaK2BCNQu3bFHK3zP90g_1795786567
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C9A71955F03; Fri, 27 Nov 2026 13:36:07 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73D041956052; Fri, 27 Nov 2026 13:36:01 +0000 (UTC)
Message-ID: <70c538f4-3878-4da4-bcb3-a96b67cedf52@redhat.com>
Date: Fri, 27 Nov 2026 14:36:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 4/4] ice: use a VLAN agnostic multicast promisc
 rule pair for PF VSIs
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Simon Horman <horms@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>,
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
 Alice Michael <alice.michael@intel.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>, Patryk Holda
 <patryk.holda@intel.com>, Rinitha S <sx.rinitha@intel.com>,
 Aaron Ma <aaron.ma@canonical.com>, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20261127085714.1207361-1-poros@redhat.com>
 <20261127085714.1207361-5-poros@redhat.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261127085714.1207361-5-poros@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: cKjfKTJSIWtx9Wrrvo_um-Q9ea02EHQnaRulzsGwMFE_1795786567
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 09:57, Petr Oros wrote:
> An allmulticast or promiscuous PF VSI with VLANs is subscribed to
> multicast with an ICE_SW_LKUP_PROMISC_VLAN rule pair for every VID, and
> each rule takes an entry of the switch lookup table (FLU), which has 32K
> entries for all PFs of the device. A port of a vlan_filtering bridge is
> allmulticast, so a wide trunk (vid 2-4094) over several such ports
> overruns the table. Firmware then rejects Add Switch Rules with ENOSPC,
> the trunk of the last port is only partly installed, and the default VSI
> (DFLT) Rx rule fails to install when a port turns promiscuous:
> 
>    ice 0000:5c:00.1: Failed to set VSI 14 as the default forwarding
>                      VSI, error -5
>    ice 0000:5c:00.1 ens1f1: Error -5 setting default VSI 14 Rx rule
> 
> Subscribe PF VSIs with the VLAN agnostic pair (ICE_SW_LKUP_PROMISC, vid
> 0) only. Drop the per-VID handling from ice_vlan_rx_add_vid() and
> ice_vlan_rx_kill_vid(), and stop clearing the multicast rules in
> ice_eswitch_resync_uplink(), whose queued sync now reconciles them. The
> pair matches multicast on every VLAN. VLAN pruning still limits what it
> delivers to the VLANs of the VSI, and with pruning off, as for the DFLT
> holder, it delivers on every VLAN. The subscription now follows
> IFF_PROMISC and IFF_ALLMULTI in one place, so clearing allmulti no
> longer unsubscribes a promiscuous VSI unless another VSI holds the DFLT
> rule, and a failed DFLT install does not remove it before the retry.
> ice_set_promisc() adds the Rx and the Tx rule one at a time, so a rule
> left by an earlier failure does not keep the other one from being added.
> 
> A trusted VF that holds the DFLT rule no longer gets through it the
> multicast on VLANs the PF is not a member of, because the promisc recipe
> has a higher priority than the default one. It keeps what its own
> multicast promisc rules match.
> 
> The overrun was observed on a machine in real use, and the allmulti
> problem was found by the Sashiko review of v4. The overrun reproduces on
> an E810-C (FW 8.1.1, ICE COMMS package 1.3.55.0) without kernel changes:
> 
>    for p in $P0 $P2 $P3; do
>            ip link add br-$p type bridge vlan_filtering 1
>            ip link set br-$p up
>            ip link set $p master br-$p
>            bridge vlan add vid 2-4094 dev $p
>    done
>    ip link set br-$P0 promisc on
> 
> With the per-VID pairs a trunked port took 12292 FLU entries, the third
> bridge vlan add failed part way and the promisc on logged the errors
> above. With this patch a trunked port takes 4104 entries, all three
> trunks fit with 20387 of the 32768 entries free, and the DFLT rule
> installs. The FLU numbers come from a test-only debugfs file that issues
> Get Resource Allocation (AQ 0x0204). Also tested with multicast to
> joined and unjoined groups on member and non-member VLANs, with promisc
> and allmulti changed in every order, with VLANs added and removed while
> allmulticast, with a trusted promiscuous VF, and with the DFLT install
> made to fail by a test-only change. No kernel selftests cover this.
> 
> Fixes: 1273f89578f2 ("ice: Fix broken IFF_ALLMULTI handling")
> Fixes: 43fbca02c2dd ("ice: fix lost multicast packets in promisc mode")
> Signed-off-by: Petr Oros<poros@redhat.com>
> ---
> v5:
> - Reworked after the Sashiko review of the v4 pull. PF VSIs now always
>    use the VLAN agnostic multicast pair, and the per-VID multicast rules
>    and their handling in ice_vlan_rx_add_vid() and ice_vlan_rx_kill_vid()
>    are gone.
> - The multicast subscription is reconciled from IFF_PROMISC and
>    IFF_ALLMULTI in one place, so clearing allmulti keeps the subscription
>    of a promiscuous VSI unless another VSI holds the DFLT rule.
> - ice_set_promisc() adds the Rx and the Tx rule separately.
> - New title, was "ice: skip per-VLAN promisc rules when default VSI Rx
>    rule is set".
> - Added the Fixes tag for 43fbca02c2dd.
> - Dropped the Reviewed-by and Tested-by tags because of the rework.
> 
> v4:https://lore.kernel.org/all/20260708125755.706263-2-poros@redhat.com/
> v3:https://lore.kernel.org/all/20260701133601.2118382-2-poros@redhat.com/
> v2:https://lore.kernel.org/all/20260622113428.2565255-2-poros@redhat.com/
> v1:https://lore.kernel.org/ 
> all/89efbea9831175e6f57e9fe8557f7a0e48e050b7.1781786935.git.poros@redhat.com/

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

