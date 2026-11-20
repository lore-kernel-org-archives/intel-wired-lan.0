Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97495606A325
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Nov 2026 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=fh/kPafq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGktkx2f
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FF9E815D3;
	Fri, 20 Nov 2026 15:17:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XXRBy7-ptBw3; Fri, 20 Nov 2026 15:17:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 90D4C81662
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795187856;
	b=TEa7NhaZ6kSnw71mPnGRuy05ThxNbuLUBu0r4K/9jh07W5m7N4o7TTBFRlMuCbSb+480
	 5BqQJsBKWz6hPIS1h0O/awOr5+viuEOj22Iasqoezrh21yDwyQNf5IYbFvP/3uFwMBI5M
	 wlMyAD6pzcV7pbSLFjtmw2dKcrR2zeD96cS2ESXEnA6lFUbk48XDxWKw1KdIgyM8U6szr
	 koSuy9z/1Ui6mo+NQ9q8BSmwMjv2vfz+eEXYo3hWoKZ5ENXihszGyv2m89OGKH+wzyarD
	 ViK5wfut86lalVuDCn2klRhQVy9JGSrImrN6fDuh70Mbma2cLpq5duY+WB08mD933FQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795187856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=dmbMKKC7rHPR8z5diAydnlP9jK6mYRhdlxvy7H5liH4=;
	b=bnm2sFTgBACCnU+2VRxixnBx6kEzHSEbnWw1ZNpOiyUX7UNzG4MrXokKr20OSM8Q1zG2
	 sxgafULSJ02DoNdv5wOlH9usao8NJe8IbiloLKzn76z9GxW3am2yd7Oy8eXY7lp5i/mDL
	 mDMpyI38KO7uXrBfkkkk9MVex21jhCkK7LWcXLF9MCvhceunQ1JesHCcc6LonzRGLWj9B
	 B6nwBrGP++0mpRudc5ZPQt1lf8NzB8ovBwje1SwSsEjPVUphUoWJYZRSdVH5O+HFm4y36
	 w/uCCgSYpOCNLeIKkkdTWGXk/oJfM1ZxueaFwTMilqLiDKkvRsGGZu9iZ1JuagsAgEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795187856;
	bh=dmbMKKC7rHPR8z5diAydnlP9jK6mYRhdlxvy7H5liH4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fh/kPafqAUza68e5aEL+d5gqvEgzemuFhMz923dT11Wjkq8mC8Dqyz3ZfjMOmil52
	 bfTI4QDEvSyzre7+P6WWVstyES0oGEs7Gq6KTV86n4YyR/qdfmhsyxnsmc/UQY4MYT
	 sONk0FJ8HhqMtXJmZ6LI0y7UnnodVxzLtATEAPak7ERWtteoSD+FPB72+qr1KfQq9L
	 y4eRyiSj1qs2uX3/7Ym/aOaNw2JdUceT+aoprLv3BLD+TqmJH1HtvAAcYBeB2NeyqM
	 55UAT1tsFxr2Nuzo+N24bdH2tSjOl34XD+FdBwrGx45CQgOlma9QoDvWs32pqjiQ3w
	 Bz2rpyNp8F7BQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90D4C81662;
	Fri, 20 Nov 2026 15:17:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80C0F1C9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:17:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 726CC40E4B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:17:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yaAl9RyuFv7b for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Nov 2026 15:17:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81FF440E10
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sashiko-bot@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=AGktkx2f
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81FF440E10
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Nov 2026 15:17:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7301844DE3;
 Fri, 20 Nov 2026 15:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC441F000C6;
 Fri, 20 Nov 2026 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795187852;
 bh=dmbMKKC7rHPR8z5diAydnlP9jK6mYRhdlxvy7H5liH4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AGktkx2fgM8Ou6BrHhu2+3ILBwHUT1hf50XO6E7eL8YLAGBRXp/EzUsBPbYpp3vw1
 nFO67zXhzUj99prudR1sWffY3eqyqTznu0rCe8BuhBlN0a4KkhDq+HeSVE41jjvyFE
 Jt3aheaILapHi6lDfrRjAiVe2ZMl9epnwy3E9ISSXwrZOH5qOFtdSTcUwzq6+/Geav
 1EwsKvjL/y4tIXdGMHO464YIRuGqG8RLJTX1XaZh8fCPb3gWIkxTjsWLAVAbU3qZIf
 5BvPckdXNbbACbHy1YRXVTuDWer22e7Mi9cZ8O5VkeHAba1/9vxLBVg9kgDLrKNTSL
 wDzIP0yY5FSlA==
Message-ID: <sashiko-outbox-225447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH iwl-next 1/2] i40e: wait for one RCU grace period in
 i40e_down(), not one per queue
To: "Shitalkumar Gandhi" <shital.gandhi45@gmail.com>,
 intel-wired-lan@lists.osuosl.org
Cc: bpf@vger.kernel.org
In-Reply-To: <20261120150527.14649-2-shital.gandhi45@gmail.com>
References: <20261120150527.14649-1-shital.gandhi45@gmail.com>
 <20261120150527.14649-2-shital.gandhi45@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 15:17:31 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] i40e: unpaired napi_disable() in i40e_vsi_open() [1]
--

commit e3081b5b3e5283a7fdd835e0d6be52ee866385e0
Author: Shitalkumar Gandhi <shital.gandhi45@gmail.com>

i40e: wait for one RCU grace period in i40e_down(), not one per queue

This commit moves the RCU wait in i40e_down() out of the per-queue loop
and replaces synchronize_rcu() with a single synchronize_net() call when
XDP is enabled.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/et=
hernet/intel/i40e/i40e_main.c
> index 98d2fcdcee68f..e0c76ba566ea5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7609,15 +7609,18 @@ void i40e_down(struct i40e_vsi *vsi)
>  		i40e_force_link_state(vsi->back, false);
>  	i40e_napi_disable_all(vsi);

[Severity: High]
This problem wasn't introduced by this patch, but can
i40e_napi_disable_all() hang here when i40e_vsi_open() fails in
i40e_up_complete() [1]?

If i40e_vsi_start_rings() fails in i40e_up_complete(), it returns before
i40e_napi_enable_all() runs:

drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_up_complete() {
	...
	err =3D i40e_vsi_start_rings(vsi);
	if (err)
		return err;

	clear_bit(__I40E_VSI_DOWN, vsi->state);
	i40e_napi_enable_all(vsi);
	...
}

The err_up_complete error path in i40e_vsi_open() then calls i40e_down() ->
i40e_napi_disable_all() -> napi_disable() on NAPI instances where
NAPIF_STATE_SCHED and NAPIF_STATE_NPSVC were never cleared by
napi_enable(), sleeping forever while holding rtnl_lock().

[1] https://sashiko.dev/#/bug/linux-f4bedeae-9add-4cf7-9ab5-6f1f169023a5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120150527.1464=
9-1-shital.gandhi45@gmail.com?part=3D1
