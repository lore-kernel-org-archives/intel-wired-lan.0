Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F8606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=aJ4E6rPq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsdNLrU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0DD9460A8C;
	Fri, 27 Nov 2026 02:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lIosCjKlrE3C; Fri, 27 Nov 2026 02:17:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 22A6260A4E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795745838;
	b=Q/3wJBGU7HUzgLRCp5zATHd6x+2756sgFVc+RDE/I8XBiBOKxhfhNrFVcb7XAQ7iNxGc
	 /TOI76Fo9q4VQ5Djcy17YGt83uYgRv6dwpY8LrGVsvPlIGox8eDaFf1GZE2sChXdJyK/x
	 uRZEH7QFs0VS04D3NMj8QY7L5NIqnV56aCGwAne9yDBKBbJk+1vAyPJlyrUhkTb23tPOA
	 vIe9Er20UaFOqN63L7eyR1yCOD3Otcj9KQaFDbStxpJTDvR0l6te1GgTZ7TIGg5xZKNW5
	 BFERZG1cKPoRIUTy28mz3l91ldZCpouUE97grDNDdE8jlcpYi4A7AKY2Zip4Poj1B4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795745838;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eptb+3/EXFgZ8fNsxkLPAmXNUSDaiv1rQ2/GDYvfOYo=;
	b=lXOB74pCcmzHNnCpdEftuaE6ZCHbejYNwntsKdi2CSGA+MGiV7052i5YlmgBGj59Rghh
	 yAYNE/xA+mu9KcY77NuNReEmyAZ1Uh/RtKpbIy8ovlHIwRMMQWD2dmVVhKIldPjGxcgh8
	 M7rOIGiRxrg9LTFJQGmsx7XraYZE3Mdfza3t1TgrIVDTq/8d25HSX/5vXYOrqSNTxppv4
	 UBw+gJBIvWBFnuSjwf1DDxEy23f3dVXbnY+201IP8tHVtr5mxODMiy+69rQNkNUjtOfAO
	 9SdRGz7ov1eTO7hasUTh2eH43KzpnN0r9d3kATLgbhbI2MpttETUAfSElm8CYkWEXDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795745838;
	bh=eptb+3/EXFgZ8fNsxkLPAmXNUSDaiv1rQ2/GDYvfOYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aJ4E6rPqWXmA5ZR5yVrppxLHHJav/hgpP4eF7ZGMJA7atvVaRzBKuYoRGjiuFVPPO
	 TYUbCfEovKFJHJKj8e4SCqgBHygMd8Ox5hNmGiDDs1ve1K0LCvDR6QZXxwV7lM7j7Y
	 WUjzQsRyFi5iK4GWyoNIuv/8Y3Q0zhYnmPjbyQJN/spAWdQI+Hjm+Texf6LXP1u83Z
	 /5zL10yqCIDeYfcHVFDnoeiMbEpV5P3ONwwKVbwz6woDLxVRqEoiyBA+mYzaqtLwag
	 4EO3rD0adWKvRmhLOBGgSKaACS5ygQ62qtk5+uSXiBRLJ7rzEYU6O8oLSUt86Rew7F
	 +b0Ot9yP+nzIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22A6260A4E;
	Fri, 27 Nov 2026 02:17:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD345D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 02:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A014F4053D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 02:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WOwLaBM3bSl for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 02:17:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 80105400D5
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cRsdNLrU
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 80105400D5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 02:17:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10E09451E8;
 Fri, 27 Nov 2026 02:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2201F000C1;
 Fri, 27 Nov 2026 02:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795745833;
 bh=eptb+3/EXFgZ8fNsxkLPAmXNUSDaiv1rQ2/GDYvfOYo=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=cRsdNLrUE3TIH7Gr+dgyRG8Zr6D8952UklD7szq0nbnCzXtNCWRkkv7BVP2taKsGc
 MnAAhopToZ2bzEyk5UD+3v7pYvg8eGPoLCasum3sSh3UMM6aUDaatnP3enyNR1LL3L
 +K5gV2ZbC3sT74xYIA3xY5fIYMTX6DerIhHsMZQ5RgOWhJEiTsoaUZP/7FzMd9x154
 wAQtmII2yVHPFFiw8fVCSG7+bmG0kwgtsrm1FD1y4jFwYiQZLUsvLzomDVmpagpBPe
 xoJN2tlWqUVnQ1xd7hAIfD9Mzqp1DKqMvY6Rg5gQb1AoSb/u/IcdL287q9lnxjYrmf
 3rX2QXPpHCF4Q==
Subject: Re: [PATCH] idpf: fix vport_id used as array index in MAC filter
 async handler
From: netdev-bot+sashiko@kernel.org
To: guohongyu@cmss.chinamobile.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Date: Fri, 27 Nov 2026 02:17:12 +0000
Message-ID: <179574583226.3135.4850818709708500001@kernel.org>
In-Reply-To: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
References: <20261126020854.233971-1-guohongyu@cmss.chinamobile.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Possible use-after-free introduced by the patch.
- [Low] The commit message describes only part of what the old code did
  wrong.

--

idpf: fix vport_id used as array index in MAC filter async handler

This patch changes idpf_mac_filter_async_handler() so that it indexes
adapter->vport_config[] with the software slot index of the vport
returned by idpf_vid_to_vport(). Before, it used the raw device-side
vport_id from the virtchnl message, which could be out of range.

> vport_config[] has num_max_vports entries and vport_id is an opaque
> device-side identifier that the protocol does not bound by it, so
> a vport id not smaller than num_max_vports makes the handler read
> past the end of the array and use the garbage result as a
> struct idpf_vport_config (spinlock taken, filter list walked,
> entries list_del()'ed through out-of-bounds pointers).

[Severity: Low]
This isn't a bug, but could the changelog also cover the in-range
cases that the old code got wrong?

idpf_add_del_mac_filters() sends the device-side vport->vport_id.
idpf_vid_to_vport() maps it back to a slot by searching
adapter->vport_ids[]. So the device id and vport->idx are unrelated
values.

If the device id is below num_max_vports but names a slot that belongs
to another vport, the old code silently removed MAC filters from that
other vport's mac_filter_list.

If the device id names a slot that was never allocated, the entry is
NULL, because idpf_vport_alloc() fills vport_config[] lazily:

idpf_vport_alloc() {
    ...
    adapter->vport_config[idx] = vport_config;
    ...
}

In that case spin_lock_bh(&vport_config->mac_filter_list_lock)
dereferences NULL.

The code change fixes all three cases; only the description is
incomplete. The wrong-vport filter deletion may be the symptom stable
backporters are most likely to recognise.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index c89783966bae3..2e173d0cb7e63 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3852,7 +3852,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!vport)
>  		goto invalid_payload;
>  
> -	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config = adapter->vport_config[vport->idx];

[Severity: Medium]
Can this read vport->idx from a freed struct idpf_vport?

idpf_vid_to_vport() takes no lock, no RCU read lock and no reference:

    for (i = 0; i < num_max_vports; i++)
        if (adapter->vport_ids[i] == v_id)
            return adapter->vports[i];

This handler runs from mbx_task, through libie_ctlq_xn_process_recv()
-> xn->resp_cb(). Only xn->xn_lock is held there, and teardown never
takes that lock.

On PCI remove, IDPF_REMOVE_IN_PROG is set. idpf_vc_core_deinit() then
frees the vports before it shuts down the transaction manager and
cancels mbx_task:

idpf_vc_core_deinit() {
    ...
    idpf_deinit_task(adapter);
    ...
    if (remove_in_prog)
        libie_ctlq_xn_shutdown(adapter->xnm);

    cancel_delayed_work_sync(&adapter->serv_task);
    cancel_delayed_work_sync(&adapter->mbx_task);
    ...
}

idpf_deinit_task() -> idpf_vport_dealloc() -> idpf_vport_rel() does
kfree(vport). idpf_vport_dealloc() clears the slot only after that:

    idpf_vport_rel(vport);

    adapter->vports[i] = NULL;

An error response to an earlier ADD/DEL_MAC_ADDR request could arrive
in that window. The handler could then get the vport pointer just
before the kfree, or the stale pointer between the kfree and the NULL
store.

If that memory has been reused, idx is garbage. That gives an
out-of-bounds read of adapter->vport_config[], followed by
spin_lock_bh() and list_del() on wild memory.

The old code never dereferenced vport here. The vport_config[] entries
are freed only in idpf_remove(), after the workqueues are destroyed.

The window is narrow. idpf_vport_rel() sends destroy_vport
synchronously, so the race needs the control plane to answer a pending
MAC request after the destroy_vport response. The reset path is not
affected: there libie_ctlq_xn_shutdown() runs first and drops async
transactions without calling resp_cb.

Would it be safer to have the lookup return the slot index i instead?
adapter->vports[i] == vport implies i == vport->idx, and i is always
below num_max_vports. adapter->vport_config[i] could then be used
without reading through the vport pointer.

>  	ma_list_head = &vport_config->user_config.mac_filter_list;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126020854.233971-1-guohongyu%40cmss.chinamobile.com
