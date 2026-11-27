Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346A606A327
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=3d9gieGl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N1lafoPx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E1440919;
	Fri, 27 Nov 2026 13:35:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZGgTBqzUWA8z; Fri, 27 Nov 2026 13:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F28D2408E1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795786536;
	b=BGqeJzJzayb0kVEVaCXa28w7jG2gPn2U18/LFaa/C6O0msXP0h0z6kadlSX38iwuGVvb
	 J/05vIdJEI2roFL1rVv4bArQyGS4tf1OYdFU1usZgUQ0PGO3QLlqS5Q6arykvX7M+aBGG
	 0AqixRvPbMAAZTJ4DtcY/lq5GIWwvMQGCJ6mIur/rboHpaFhsDzkCQO7uCIHXHAMhCieu
	 A0U67KYcFHBi5Ma293RlN/c2n0t8X7LJaqo/Ta5vJkp8dEGxk8UsjEzAaEq8NYJCrKd/N
	 Sz3bSdNn672F5SJwAnD//WeJUTiekwFA9CNKabvNVG162cGQYt5NS1rnyhFU0JiGnWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795786536;
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
	bh=LZsrkdjo3wiY3MXe7EcjLmqxXpAd3Z9lQW5+QTgaLK0=;
	b=cZ2mVV2lT0bMOKoN4OHu3ujWyEMUvB8tjJO9acK8eoqHTD4Xyi3a3CtZJ5gB25Eo7XDV
	 IcGWXyXCRsuq3yy4Dw5NHGA9bhdukTXvm6qB9pVIQ05WmZ3xiF0Lch5XZVz65d8KY0bhI
	 AXdB39S8lxb8XqebFalav3IKZkgbPXT9d21sbn974haKyI+e4mbus1CnNtQc+0gDqkSCp
	 g++/CtjMdu5BFM5hUxUg6/iHohGbqCks5cBoJiBxc3q0GLsTcqhoh4hG4ucgkR6AW7LGU
	 z5YsvNLpeTRevmMWJiCVVghdxTU8TpZnSLDvk+8UdDOXuG82ylQfj9eMdnj/lzwzrXg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795786536;
	bh=LZsrkdjo3wiY3MXe7EcjLmqxXpAd3Z9lQW5+QTgaLK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=3d9gieGljQEG9aEwi2j6n7GniVyEuxv7RCONpXX2UhZSDV1QMVJWZ6dWAx48Bm/oa
	 OhymPk29CMmPkiVCbOtDpdrgE/HzpzSGCnsh5i1OisnUe5eXWRti3dQYQuw2aSyXie
	 O3o4OHQSOM0yZsC1DCGEhZrH/qdb3xUvTjOAkLx3bx34mz/bim7bdJim2Wjwy3Depb
	 GCUx/gHP3GxATduPTnfsybNcpYJpeG7+87XUOF0WqM31qHWV9YilKiKUz5kFiJqL5r
	 LJ/DrVukc00FDT7kBN4HOv4WUQhHF72meEzKhzM0vFtzPE1tQv4VrXVms0NcTo/7pP
	 g4qdcNqJTInXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F28D2408E1;
	Fri, 27 Nov 2026 13:35:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AD2D7D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:35:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB0CD400F5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:35:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yWmjvZAYQ2HX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 13:35:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A30B04004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=N1lafoPx
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A30B04004D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795786531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZsrkdjo3wiY3MXe7EcjLmqxXpAd3Z9lQW5+QTgaLK0=;
 b=N1lafoPxl3rwLIsvosj+iSs9A6zbWqyw0ayCu1UWgeuKhY77ii9iJBWR6IhGoasdhyyz4Q
 oi7O1Cy9qFye7tq0Owj3Xq+Fzf8+0k74pQTEsD7JeJ6+8IT90rwlSwcGRS5EF4p6DNER+M
 xd/PYn/xktYAkDWlIOdCbgznI+Y4cOw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-547-0W-AsCljPnWmi9wQUUBBaw-1; Fri,
 27 Nov 2026 13:35:28 +0000
X-MC-Unique: 0W-AsCljPnWmi9wQUUBBaw-1
X-Mimecast-MFC-AGG-ID: 0W-AsCljPnWmi9wQUUBBaw_1795786525
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4338918004F6; Fri, 27 Nov 2026 13:35:25 +0000 (UTC)
Received: from [100.91.101.41] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52F6B30000E5; Fri, 27 Nov 2026 13:35:19 +0000 (UTC)
Message-ID: <eaa97495-15aa-4675-89c4-6c491bed6cd8@redhat.com>
Date: Fri, 27 Nov 2026 14:35:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 3/4] ice: resync uplink filters after a switchdev
 session
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
 <20261127085714.1207361-4-poros@redhat.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20261127085714.1207361-4-poros@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: rXlPY1oTiMhUl9udOOCqaN8eJi3clXzmgkoaaXYFiRA_1795786525
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
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/27/26 09:57, Petr Oros wrote:
> A switchdev session leaves the uplink filters out of sync with its
> netdev. ice_eswitch_setup_env() removes the multicast promisc rules and
> the address filters, and ice_eswitch_release_env() removes the default
> VSI (DFLT) Rx rule that a promiscuous uplink needs. ice_set_rx_mode()
> ignores the uplink during the session and nothing syncs it when the
> session ends, so these are not installed again, and flag changes made
> meanwhile are lost.
> 
> Let the eswitch own the uplink promisc configuration during a session.
> While the new ICE_VSI_ESWITCH_UPLINK bit is set, ice_vsi_sync_fltr()
> leaves it alone. When the session ends, after is_running is cleared,
> ice_eswitch_resync_uplink() clears the bit and queues a full filter
> sync, which programs the uplink from the netdev flags. Also subscribe a
> promiscuous VSI to multicast when it already holds the DFLT rule, and
> enable VLAN pruning on every promisc off, because it can be off without
> our DFLT rule after a session or with LAG.
> 
> This does not restore the uplink VLAN filters that
> ice_eswitch_setup_env() removes, a separate problem that now also shows
> when promisc is cleared after a promiscuous session.
> 
> Found by AI code review, starting with the Sashiko review of v4, and
> reproduced on an E810-C (FW 8.1.1, ICE COMMS package 1.3.55.0) without
> kernel changes:
> 
>    ip link set $PF promisc on
>    devlink dev eswitch set pci/$BDF mode switchdev
>    echo 1 >/sys/class/net/$PF/device/sriov_numvfs
>    echo 0 >/sys/class/net/$PF/device/sriov_numvfs
> 
> after which unknown unicast no longer reaches the PF, and with this
> patch it does again. Also tested on that E810-C with promisc changed
> before, during and after sessions, allmulti across a session, and PF
> resets and driver removal during sessions. LAG and switchdev setup
> errors were not tested. No kernel selftests cover this.
> 
> Fixes: 1a1c40df2e80 ("ice: set and release switchdev environment")
> Fixes: 2571a3fa6251 ("ice: Prohibit rx mode change in switchdev mode")
> Fixes: 5c07be96d8b3 ("ice: Avoid setting default Rx VSI twice in switchdev setup")
> Fixes: 776fe19953b0 ("ice: block default rule setting on LAG interface")
> Signed-off-by: Petr Oros<poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

