Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987D8C88E53
	for <intel-wired-lan@archiver.kernel.org>; Sat, 12 Sep 2026 08:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43B3E4077B;
	Sat, 12 Sep 2026 08:37:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a2EGYB0BTe8w; Sat, 12 Sep 2026 08:37:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3905E4077C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789202273;
	b=Bc4BR0G2NHXJCp+t6MD6PbWZi1xLxQt6dV/+wlh2LHZD4o51YJDMHSuEVDtCa2MfnnTz
	 7qqhlEsNtuailL+096Xv0dAF8M0EIPasVGe85SOI5Xym2uZQdc1Gv+0JSwVUgFDN8YRoi
	 7RrEqGNT1hh04dhMk9g6wl3+z73exXlCGlqJo2pNxdwUX77SJFjc344JKSypTr2OiumY7
	 I/3ugyYZB1lszXP6/+HgyYNou1cBaYjECmd9I+muV+M3CkbysACcXs6MdMXpEd5XI/uiv
	 EzQNuvDDbV9dnSCW06CA9bQcLBjNCwwBZfVmhu44IpR6gPVl1DwWqD2jl2fABIP0Ngg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789202273;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jYuQLTMwiyaPE07yAyZPAsztTLqGZd4PsNnTSOMeCMw=;
	b=ApR7vjQZU/Q5X9+5MOTH4brPFvdfhLjNPnp586sucHpep1t1hmArk2mmI7OR6RX0XlTL
	 zG8Aka1YM525PWrWsmwLiuIYVcWHFaybpkS0rWhEyRJp76RSJUMUTN0INk5JDlV0X18DD
	 gPd586cQcWLxz6tfZc68s+49JauocRuIZ2Tuv68sZj1r7+/IeKSHCpj0XmVizFKkV7lNr
	 B0Fly7wsrmwXCHPkd7wEUYaNmyUh5rforAS9WiCOrR/hbuzfIKZU2VuuTKNOTKSwtaPHt
	 AgMwe5m0U4x4tEpXCzxQzNsROfxrsjRrCWAsH9OJvBYndyZh6/XGzTugZCzFjabXVoQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789202273;
	bh=jYuQLTMwiyaPE07yAyZPAsztTLqGZd4PsNnTSOMeCMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V/8TMBej0Sscq+OVhJIQkB6+8jV1TwR47vwFIbS+VLuuVInf7ZJhTQy8hrysNRD2n
	 c5mT0z9jr3mYxjjqcJMbPTxA4e/ojlC2nSW7YmtaASKbUkWtFNBUKiHlqtwZn+ETqf
	 n8PBVyY7XYiEw9Ux4+t1y+doCcboMW3Hz0mkV2fY0YcQy9F/CanspFrj4tBSRAr23+
	 x+eVw5CA75JOX6qSdaMrMqKI7DP5Ks+YoCKuOSwMMGSku7KnotvjLcTnPihnyaBQRM
	 Npo2vN6ImS9njLRQ4uleI5PpAogJXsZxjFdw4J6LZUp5XjiNPuHpC1E9hVU6xVcqBE
	 5fbrC/zCnBW7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3905E4077C;
	Sat, 12 Sep 2026 08:37:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5B5AD32F
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 08:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58FFB4009E
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 08:37:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2sEPgOgeEGfU for <intel-wired-lan@lists.osuosl.org>;
 Sat, 12 Sep 2026 08:37:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3F42640076
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789202271;
 b=NhIPh88j6x3O9SOITG2TaT+DFcKqDSpFVXsOuH5IEW4KgFO5/8nKLFbDhqRwOVX4ohgx
 vQyruXnUaFOfLNtNtJKSoz4QhBmxlmEp4ptrVAK4G8nYcZZ3PPJ7yXpRfPA1pq78cNVdc
 GqLyKbhV3OoAx3q1NDt2a3q5pMBzWJf2YE0f2WoAvj+6Z+RV33ICvlBFxK5aF9mpT8Apb
 K1bDmmQq9OxvYY4zJ3f7NI1y+gYKnKC9BXTLPNKafYiW1F7M5OIWwpi7HtLak6nazv1XC
 d8bTPL4KOeQpXIdHr4Cs5zVlDPLkGPae2L40ZkNlfCLMZm8ltD04K9zO/P527CJrvcQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789202271;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=jYuQLTMwiyaPE07yAyZPAsztTLqGZd4PsNnTSOMeCMw=;
 b=ZR9slSQYCZoBs+tcVp2vFaOaLZOTkqiNka60vCxx9hoSK2wFyNtm2I7PfMKz62mvgQSH
 FlIZZnZAoSSTqEuHjAQ46LIZPKkx9/wr9yEvPAVIFWSfemZ/GOxCHPedGSzkVLrj9VtSs
 MJU1NN3w1pWFz/8kYY2VdiWmpA7nS67v8ZKfYtihrtdQ+P+01VLuw31k++4HBlI/kav1y
 ViqhPNm5gbwV1PSgb4HGMzTTd5DnkRMh3d1i0BodT3laWk0WNBR3fSqMjBtDmiwXJKafZ
 AY3ldBXDQwW43VpO7Vo1Udngi+L2jDJ81F0V0wM/O5Os1ibmYCoNTky/NEnzdX4jBdQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=G0hcuqMR; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=horms@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=G0hcuqMR
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F42640076
 for <intel-wired-lan@lists.osuosl.org>; Sat, 12 Sep 2026 08:37:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BCC4C60209;
 Sat, 12 Sep 2026 08:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44571F000FF;
 Sat, 12 Sep 2026 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202269;
 bh=jYuQLTMwiyaPE07yAyZPAsztTLqGZd4PsNnTSOMeCMw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=G0hcuqMRhFQD49vP9s9+MnKvk5ZreRqyFPMJbXdEaPn3H0OKuP1csff7WrV/011rx
 7izYLupgqhPUCn0qldD6oktyMvZJKjH9hh4UyHy6QnAleccklxH0HTsd43a8DabXHt
 8LVL3wioH3hP4KN20+xU4lXrIXyoijeHyY2MMB7lt337vFZBrRquOT42cWE0eIHhdm
 AkSdXnnBM51VbadjzuzpV6Yc0aqndzM0SrzkLFLlM1+nIhY/zffG+HM7qWkCMJQi9z
 ndjgGhRMma1cDRBjuGSVLf2SRqXBAJ/3E0YXtCDzNV1a8D5ziTbBTrhGJktguN5QfB
 JMBSyJ+2ZLSyg==
From: Simon Horman <horms@kernel.org>
To: poros@redhat.com
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, priyalee.kushwaha@intel.com,
 kiran.patil@intel.com, wojciech.drewek@intel.com,
 michal.swiatkowski@linux.intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next 2/2] ice: don't offload drop filters that bypass
 higher priority filters
Date: Sat, 12 Sep 2026 09:36:44 +0100
Message-ID: <20260912083645.145790-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910154824.3603687-3-poros@redhat.com>
References: <20260910154824.3603687-3-poros@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
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
Errors-To: intel-wired-lan-bounces@osuosl.org

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/#/patchset/20260910154824.3603687-2-poros@redhat.com?part=2
---
ice: don't offload drop filters that bypass higher priority filters

This commit tracks software-only TC filters to prevent the hardware from
incorrectly offloading lower priority drop rules that would override them.
It tracks un-offloaded filters within a device block and rejects conflicting
drop offloads.

> diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> --- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
[ ... ]
> @@ -2269,6 +2269,112 @@ ice_find_tc_flower_fltr(struct ice_pf *pf, unsigned long cookie)
[ ... ]
> +static void ice_tc_track_sw_fltr(struct ice_pf *pf,
> +				 struct net_device *filter_dev,
> +				 struct flow_cls_offload *cls_flower,
> +				 enum ice_eswitch_fltr_direction direction)
> +{
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
> +		if (sw_fltr->cookie == cls_flower->cookie)
> +			return;

[Severity: High]
Does this early return break tracking for TC shared blocks?

When a shared block is bound to multiple interfaces, the driver will only
track the cookie for the first interface because this check returns early
when it sees the same cookie.

> +
> +	sw_fltr = kzalloc_obj(*sw_fltr);
[ ... ]
> +static bool
> +ice_tc_drop_bypasses_fltr(struct ice_pf *pf, struct net_device *filter_dev,
> +			  u32 prio, enum ice_eswitch_fltr_direction direction)
> +{
> +	struct ice_tc_flower_fltr *fltr;
> +	struct ice_tc_sw_fltr *sw_fltr;
> +
> +	hlist_for_each_entry(sw_fltr, &pf->tc_sw_fltr_list, node)
> +		if (sw_fltr->filter_dev == filter_dev &&

[Severity: High]
Because the tracking entry is bound strictly to the first interface's
filter_dev, won't this check fail to protect other ports sharing the same
block?

> +		    sw_fltr->direction == direction && sw_fltr->prio < prio &&
> +		    !sw_fltr->is_drop)
> +			return true;
[ ... ]
> @@ -2336,6 +2471,9 @@ ice_del_cls_flower(struct ice_vsi *vsi, struct flow_cls_offload *cls_flower)
>  	struct ice_pf *pf = vsi->back;
>  	int err;
>  
> +	if (ice_tc_untrack_sw_fltr(pf, cls_flower->cookie))
> +		return 0;
> +

[Severity: High]
When deleting a filter from a shared block, the first net_device will delete
the unique tracking entry here. Won't subsequent callback invocations for the
other ports in the shared block fall through to the hardware failure path
and incorrectly return -EINVAL?

>  	/* find filter */
>  	fltr = ice_find_tc_flower_fltr(pf, cls_flower->cookie);
>  	if (!fltr) {

Later in ice_del_cls_flower(), the filter is removed and freed:

drivers/net/ethernet/intel/ice/ice_tc_lib.c:ice_del_cls_flower() {
    ...
	/* delete filter from an ordered list */
	hlist_del(&fltr->tc_flower_node);

	/* free the filter node */
	kfree(fltr);
    ...
}

[Severity: High]
This is a pre-existing issue, but is it safe to modify tc_flower_fltr_list
and free the filter here?

While this runs under the rtnl_lock, the background device reset task
(ice_reset_subtask) calls ice_rem_all_chnl_fltrs(), which iterates over
pf->tc_flower_fltr_list and frees filters using kfree() without holding
the rtnl_lock or any driver-specific lock protecting the list.

Could this concurrent access during a hardware reset result in list corruption
or a use-after-free?
