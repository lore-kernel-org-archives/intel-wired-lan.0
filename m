Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AF5606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=FQUNpcYc;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT02Zom2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EE4981210;
	Fri, 27 Nov 2026 09:35:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y7DxgMnNKbIz; Fri, 27 Nov 2026 09:35:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C71181211
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795772145;
	b=nZFiQs4O+bIUPAec1zUNE5CkBcB77HRfIDe3bMRdzNd29ylTSdc9mHTnkJZYczcOuUCi
	 +1bmEE3Z62S2CZdUrJXS57gQ8aXbx9+gAEg0AHJd9XkCc8sHwrsBe99Tvo9dGTBPudsr5
	 yXQSWIk7r3Yed/EVfJtyocLSVW9NIn9zLbI29LNEPYpprUDngXn4+jdX7w4kbk0XrQhrv
	 DLrVuKFQkDVtmGAbToNi1lDHac8gnYeoid2Ynoc5ZujOQ626HPehVVQlXHhjRSscgTtHT
	 gDqTKyaOxvYO0PTumgt4mYepKp8s18wWGrn5v/unbwitMK1MgDICVzEyfiPd2ftwTNw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hwQ67UPDDBpBlNdOHdQzfI33A0euocSSF71ObVKBPMQ=;
	b=XHZgNE3R03ywQaPoEVsJrIL+o0Vnt2TW7meo6iTEWKV2Qjg09iT24+oe8nwbuIVphD1Q
	 dTBKmYZqS+JtaVlguXh+kkGAiRkJDzQCchkH2pJ5KshcG/s1cOoa5mVfO7iiF4zVJACXd
	 t3D7r11jLusXRfZIxkT6ZJwy4y4UTspgNuEwreEm0l9ybrtEK9srWviaUUzuleFn0c42t
	 TrCDwUs6+oK08+0SmmMFPEFJ76vkKQX0WUBh4uzbuM61PWIvUp+ahxj9RtHdEmelhkzeP
	 ytYtZ/bbKGYSpWUDGDCvZI6mkNF6dOTDDA8mA6AN1h0cKJNTWVLOB8DEeO+2s8reh/g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795772145;
	bh=hwQ67UPDDBpBlNdOHdQzfI33A0euocSSF71ObVKBPMQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FQUNpcYcoZUP6oruhuyZlM2WX3YyyXcVaOKRBnwifYoRYXeQwvHZYF3+dqP59ClWA
	 cXuIc5EHh7EuY6c5iTBnUePPNOGoUXACYvN+re84ZomQdKlSSAoqwpXMif/KRGeA1y
	 J6I77TVEBJ7UVALEb/iOuI+BCx3S+144IhZlibhEqb1avliyvyJTXLqo3OH4ov5Myb
	 YRxzWb3q+HsTzuP4tebnJRy4aT4GfjHfsl5Th7I00hBuVyoEFKarhscRe5LgWSBZ4P
	 JddpFsO4Dh0uj2pOTjTKlBejCalqwyMJ48NolT2TH6kvnxg6gR4lRAEv/M4pdBZxYz
	 bWJ8ANfgI0CgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C71181211;
	Fri, 27 Nov 2026 09:35:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC59B311
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 09:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B23C34056F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 09:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5vJBuLolgzlQ for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 09:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 90BF14004D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KT02Zom2
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90BF14004D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 09:35:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A982624E4;
 Fri, 27 Nov 2026 09:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C7B1F0089A;
 Fri, 27 Nov 2026 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795772140;
 bh=hwQ67UPDDBpBlNdOHdQzfI33A0euocSSF71ObVKBPMQ=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=KT02Zom2To/SSGxUt7pByiwxpkW4tayb6INs8CYUn3wwvvldjtiWAUtfnJbL4yr6E
 /YBg+LmKFBf36XYHDw99BG4wO2v+3fT1yBRsFjowboqCglXMD3Q6xOKIVDZTFJkgP6
 Nuihh+rrD3OoUmS8lSF2lgtfhbVJNUUL/s45/8OO8tizYPYSPXJAHGXuYTP4wj+YRn
 i/mdnc6KT5PfzyiUODza2ZOuhJKhL8hJuY4HzIGqmffTI04E1XVRKrY8Q8LfUZ5u/U
 o3ahufR3CDlQe/03dgy5BiAnASU428/4Rtz6vjh8afPqWfu5K6ZF1bNhaKCDJYWTMx
 ErWGGqOjnGNWw==
Subject: Re: [PATCH v2] idpf: fix vport_id used as array index in MAC filter
 async handler
From: netdev-bot+sashiko@kernel.org
To: guohongyu@cmss.chinamobile.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, alan.brady@intel.com,
 stable@vger.kernel.org, 13057616121@163.com
Date: Fri, 27 Nov 2026 09:35:39 +0000
Message-ID: <179577213934.3135.4441263933524263637@kernel.org>
In-Reply-To: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
References: <20261126092627.255454-1-guohongyu@cmss.chinamobile.com>
X-sashiko-severity: High
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
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new `test_bit(IDPF_REMOVE_IN_PROG)` check in
  idpf_mac_filter_async_handler()…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the commit
  message's own reasoning ('during driver removal the vports are freed…

--

idpf: fix vport_id used as array index in MAC filter async handler

This commit changes idpf_mac_filter_async_handler() so that it indexes
adapter->vport_config[] with vport->idx instead of the raw vport_id from
the message. It also returns early if IDPF_REMOVE_IN_PROG is set. It fixes
the filter removal loop so that removed entries are freed and never
deleted twice.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index c89783966bae3..4ffb8f9df2797 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -3837,6 +3837,10 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!status || status == -ETIMEDOUT)
>  		return;
>  
> +	/* vports are freed during removal, before this work is cancelled */
> +	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
> +		return;
> +
>  	ma_list = buff->iov_base;
>  	/* make sure at least struct is there */
>  	if (buff->iov_len < sizeof(*ma_list))

[ ... ]

> @@ -3852,7 +3856,7 @@ static void idpf_mac_filter_async_handler(void *ctx,
>  	if (!vport)
>  		goto invalid_payload;
>  
> -	vport_config = adapter->vport_config[le32_to_cpu(ma_list->vport_id)];
> +	vport_config = adapter->vport_config[vport->idx];

[Severity: High]

Does the IDPF_REMOVE_IN_PROG check close the removal race described in the
commit message? The test_bit() is a lockless snapshot. Nothing keeps the
vport alive once the check has passed.

The handler runs from mbx_task, and the only lock held is xn->xn_lock:

idpf_mbx_task()
  libie_ctlq_xn_recv()
    libie_ctlq_xn_process_recv()
      xn->resp_cb() -> idpf_mac_filter_async_handler()

If the handler sees the bit clear, idpf_remove() can set it right after
and carry on:

idpf_remove()
  set_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
  idpf_vc_core_deinit()
    idpf_deinit_task()
      idpf_vport_dealloc()
        idpf_vport_rel()
          kfree(vport);
        adapter->vports[i] = NULL;

idpf_vid_to_vport() reads adapter->vports[i] without a lock. It can
therefore return a vport that has already been freed but whose slot has
not been cleared yet. The new vport->idx read would then come from freed
memory. The spin_lock_bh(), list_del() and kfree(f) that follow would act
on whatever vport_config that stale index selects.

Before this patch, the handler only NULL-checked vport and never
dereferenced it.

Normally the synchronous DESTROY_VPORT in idpf_vport_rel() bounds this
window, because only mbx_task completes sync transactions. But there are
two cases where teardown doesn't wait on mbx_task:

  - idpf_send_mb_msg() returns -EBUSY right away when
    idpf_is_reset_detected() is true.
  - libie_ctlq_xn_send() can fail fast with -EAGAIN when no xn is free.

On PREEMPT_RT, or under vCPU preemption, the handler can also stall between
the test_bit() and the vport->idx read.

Could the handler avoid touching the vport at all? idpf_vid_to_vport()
already finds the slot i where adapter->vport_ids[i] == v_id, and
vport->idx == i. adapter->vport_config[i] stays allocated until after
mbx_task is cancelled. Using the matched slot index would fix the out of
bounds read without needing the flag check.

Another option is to shut down xn and flush mbx_task before the vports are
freed.

[Severity: High]

This isn't a bug introduced by this patch, but the commit message's
reasoning ("During driver removal the vports are freed before the mailbox
work is cancelled") applies equally to idpf_handle_event_link(). That
handler runs from the same mbx_task, via idpf_recv_event_msg(), for
VIRTCHNL2_EVENT_LINK_CHANGE:

drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:idpf_handle_event_link() {
	vport = idpf_vid_to_vport(adapter, le32_to_cpu(v2e->vport_id));
	...
	np = netdev_priv(vport->netdev);

	np->link_speed_mbps = le32_to_cpu(v2e->link_speed);
	...
	vport->link_up = v2e->link_status;
	...
}

In idpf_vport_dealloc(), idpf_decfg_netdev() frees the netdev and sets
vport->netdev = NULL. adapter->vports[i] stays published until
idpf_vport_rel() returns:

drivers/net/ethernet/intel/idpf/idpf_lib.c:idpf_vport_dealloc() {
	...
		idpf_decfg_netdev(vport);
	...
	idpf_vport_rel(vport);

	adapter->vports[i] = NULL;
	...
}

That window includes the synchronous DESTROY_VPORT round trip, and mbx_task
keeps dispatching ARQ events during it.

Could a link change event processed in that window hit netdev_priv(NULL)
and oops on the np->link_speed_mbps write? If the event arrives after
kfree(vport) in idpf_vport_rel(), the vport->link_up write would also land
in freed memory.

Neither idpf_mbx_task() nor idpf_recv_event_msg() checks
IDPF_REMOVE_IN_PROG. Copying the test_bit() check here would leave the same
race as above.

Either of these might cover both handlers:

  - clear adapter->vports[i] before tearing down the netdev and the vport
  - stop mbx event dispatch before the vports are freed

>  	ma_list_head = &vport_config->user_config.mac_filter_list;
>  
>  	/* We can't do much to reconcile bad filters at this point, however we

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126092627.255454-1-guohongyu%40cmss.chinamobile.com
