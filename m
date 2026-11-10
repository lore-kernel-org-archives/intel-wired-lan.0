Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD634606A206
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Nov 2026 17:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=bnanY7Xs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FydZvlHo
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F2C240534;
	Tue, 10 Nov 2026 17:53:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ndWJAW5DIr2k; Tue, 10 Nov 2026 17:53:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B467740555
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333235;
	b=XilnzLlWXNJWU/0q1WBgZgmsQ1xHwZrWfkSYzvqi2KJVr5rdUH4wJruLNxmSgCR3HFTY
	 BQrS0htdau7wyZxNkkvmfNrnH9CM4ca5AOFobkyyBHM3v4nNRoGP9xQzvjQuBTygoTVkv
	 6fXh87KK5Q30QAUPv+6aWs8ptuSTp2TzXxyS8VhaWlv81pHTbAShXeDHA58y0Aczk4P9x
	 Bgm2uPvvXgFWHyAdtL0iPVFxtzZc/3VqOyloQn/NtNrj1ekChM5rN6/10xxa7VFKT8t38
	 jLGPTWFeVFV7kCot7Soyq7MfEbVvFdAiy45e14hSpEF8DUfhhUksPyWLQIEgcPxSFoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333235;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hI4Ha1kxt9IoMVYOSTGtQXQwpIXjsw2bWliwYAlRPPg=;
	b=iV8xU7kfu2KbgbDIcu78ZAf+9QPxsjyePRf590Lz0H5LwN897ZgOLJd0yIgF0Jf9t0SR
	 LiJr5CgLa0DjV9BBLvmlVmgpiWwQbXnm79epiuzvQhdO1RoitPWyreU4gdzMcYPBVK+jw
	 u/vjd0aWeafk0PMxROpo9fq5o4HTHgdMNRWCTmCb1KvWgyC8QhMc1qsdB05cmV1dMNecp
	 IwNWDviNya/VDraC+MmSxrRmaiJaetdvIEPMJOj09uVL8PAJnUstub3VNA7P2qQmuGtFG
	 M2yQuJmxOWjL0ZzJoXCtomvordBPvzqh6pVHrGDJl91CfFMJzjycf9QsqUCxgQd7YOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794333235;
	bh=hI4Ha1kxt9IoMVYOSTGtQXQwpIXjsw2bWliwYAlRPPg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bnanY7XsuwPBPnIoensFFpuXWzdSt5KrY4XrYmLU0+deCDgV/gVhre1gvVN6MfsgI
	 q1l5gcwloNHXosKQj3bqGacEDfLS97z5Bv6xykvXdQmaWzKe+tqguLGlfQGlY4CfDf
	 KDd0TBapb8PCE9rRQHg7tjKlEwOc/TiS8WiqlV5Z0kcqmLYIC/NEpFsoTUT4vOdIdf
	 NYUdYpxFc+a0cok7r7snM+JQ3punQJ2OVo5gNT34lHdPGr6lp0eQwpxeb2l5BXzjyE
	 mdUKCdPAnWCeb3g764CyuMVNNkiJ7UboQJtQBaqtOhO8/150fxLc+gGlLuXPAz5CWf
	 hV+7nSQnwRgpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B467740555;
	Tue, 10 Nov 2026 17:53:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CECB928C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1E6024032F
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0WAMPBhZctL2 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Nov 2026 17:53:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 24A3B4030A
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FydZvlHo
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24A3B4030A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Nov 2026 17:53:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A273363ACE;
 Tue, 10 Nov 2026 17:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D971F008A1;
 Tue, 10 Nov 2026 17:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794333210;
 bh=hI4Ha1kxt9IoMVYOSTGtQXQwpIXjsw2bWliwYAlRPPg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=FydZvlHoIgAht0xMmulA4f5PoyF7lYoKg/cKKVcSunAa4QmK7nihh+MARdFVA02wW
 WlckplXlmEZYnDfodWDl+qr5zExS8Pe/UJhDECYzExQp0pCQuUk1qbfSvL3plwmZBD
 kbeXnsyWG9Q6MgtGvhf9uSqqRQGZpMEsHVvmy/eB4iP4HmkHBWF9FjptHJgLFkeF7c
 PFBP4sN6bLvmhZI6KMjjdHcLjOJZdexUrk+k1sGrSfsmITUZSVmqkdmu6Tu/IPE9M3
 KIeSR97nwg6F9hRdX/FCVEIcMZp5dtkADK7Qr7lgCXkBYSCgB9tNf/nJe8EmoRHCl8
 k4Blb2juux4KA==
Subject: Re: [PATCH net-next 09/10] ice: dpll: update locking comments
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:28 +0000
Message-ID: <179433320858.994134.3648996641880038315@kernel.org>
In-Reply-To: <20261106121005.1327603-10-ivecera@redhat.com>
References: <20261106121005.1327603-10-ivecera@redhat.com>
X-sashiko-severity: Low
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
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The locking note this patch adds to the struct ice_dplls kernel-
  doc (drivers/net/ethernet/intel/ice/ice_dpll.h, lines 168-170) is…

--

ice: dpll: update locking comments

This commit updates the ice DPLL locking comments now that callbacks run
under the DPLL core domain locks instead of dpll_lock. It also adds a note
saying that callbacks of the external DPLL's pins run under that DPLL's
domain, so only pf->dplls.lock serializes them with the rest of the
driver.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index 4ba76e2e2e0b0..39e041a30090d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
> @@ -165,6 +165,9 @@ struct ice_dpll {
>   *     tx_refclks usage map), acquire pf->dplls.lock first, then
>   *     ctrl_pf->dplls.lock. Skip the second acquire when pf == ctrl_pf
>   *     to avoid recursive locking.
> + *   - Callbacks of the SYNCE and TIME_REF pins of an external DPLL run under
> + *     the DPLL core domain lock of that DPLL, not of the TXC and TSPLL DPLLs,
> + *     so only @lock serializes them with the callbacks of these DPLLs.

[Severity: Low]
Could this note be clearer that TXC and TSPLL are not in the same core
domain either?

As written, it presents the external fwnode pins as the special case. A
reader could take that to mean the other ice objects share one core
domain, which would serialize their callbacks against each other.

Looking at ice_generate_dpll_clock_id(), each PF gets three different
clock_ids:

drivers/net/ethernet/intel/ice/ice_dpll.c:ice_generate_dpll_clock_id() {
    ...
		if (d->dpll_idx >= E825_DPLL_TXCLK_BASE_IDX)
			return mac_clock_id;

		if (d->dpll_idx == E825_DPLL_TSPLL_BASE_IDX)
			return mac_clock_id | BIT_ULL(63);
	}

	return pf->dplls.clock_id;
}

dpll_domain_get() keys domains on (clock_id, module). That gives three
separate domains on one PF:

  - TXC, plus the EXT_EREF0 pin, which ice_dpll_init_txclk_pins() creates
    with the TXC clock_id
  - TSPLL
  - the DSN-based objects, such as the rclk pin

Each PF's TXC and TSPLL domains are also separate from those of other PFs.
The struct dpll_domain comment in dpll_core.h says only one domain lock is
held at a time.

So the core does not serialize TXC callbacks against TSPLL callbacks, or
either of them against rclk callbacks. pf->dplls.lock (with
ctrl_pf->dplls.lock and cgu_synce_lock) is what does that, and the fwnode
pins are one more case of the same thing.

The new sentence is accurate per DPLL, and the first bullet still says
@lock serializes all DPLL state mutations. Since this patch exists to
document the domain-lock rules, though, would it make sense to say that
TXC, TSPLL and the DSN-domain objects are each in their own domain?

>   *   - @txclk_notify_rwsem is held for read across
>   *     ice_txclk_update_and_notify(), including the out-of-lock
>   *     dpll_*_change_ntf() calls. ice_dpll_deinit() takes the write side

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
