Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92D0C98307
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 64AA880E0E;
	Tue, 22 Sep 2026 18:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8YzaqAR7OK_H; Tue, 22 Sep 2026 18:44:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4602280E13
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790102666;
	b=K9/xVkc0yPV8+i73wd1QdsNmGOJVW8So0E1CuHZODRj6Wr/UEQ44c5+V2iOWFSxDyMcO
	 JCuhfbfQWR5afN6wFwviyT1IFIEst8bGvyyqqbRmSdaGQUnlkWQ8UWTZ7ytDmomd3Ma3J
	 LOfygHGQG8MVilr+Uap0N9b7v6FWe+knHS4cMn5IyxeMyB5pMu2d/rIYQfzB1c9vzEINY
	 sNDb6NPte38i5KvYAa0OfMy7MxeXBO8woN1NthUi3bkPPKNNpCLuEVpOI15QgB+5/gc29
	 afo97daoSBpk16tn0bOF/l3dck5GLR3NJtLznaUrYvYkWSFaZ8WoGtxJPrjqSabXfPQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790102666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1IxyZtZmcdhtuM2dKvn8d1mOOIfkqTrxHyUtB5yx34Q=;
	b=JTkoCtK7MB/NQtgDdTqzSkqpqCr21TynGOkfi7PYSSg3otb527SQ9kPHxKzxeQA3s7fw
	 tt9ksVfcPhZBJmY8w6m9xx5gapq8YVZ0o1dVhAAjiCPFiJgJPFPFYg1etqScdYg7MFzIY
	 L4vR2tFBPUhmk2XwwKgpitAfDftt/SYrFP2Oi348qyAalqGgQFCmx4H+KwtXTcjRfL9kq
	 qE+Rt8Mu9KYRo5fX1O5GG1GmwO0zVrq/GlyQqezKtKrDBXOC5UjSX+tGoBdakI2OLIPG9
	 hzoa468AMArhXX4tRr9730XwUf0081hBDyjbHkpEgZJnLH+HSdD0XOhr94OxtdCgO3A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ULqOnm5o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790102666;
	bh=1IxyZtZmcdhtuM2dKvn8d1mOOIfkqTrxHyUtB5yx34Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xhbBORKS5WxYcvAp6jhG/E8sY0UiWOHow8Cejcb3qhVIY9q5q5kUfkj0bchFmzxO8
	 URVV97P/c6vTO68RIUa51S8NhEaCgmkOpvm4ugGRTUKH9He2UwoinYpdDSaLMqb/hT
	 bju7SYYAx7YhkOAFKOjgAQ1HmPDKsT0VazmruCVQ4NqvijHPLk6FAuwZigjonTmtUI
	 TkVOlrCjL8baHPyhO0NxnOAFXi/zr+iBf1gzFNRBI+xNoHht3EKP2zpjlJj9kAI+47
	 8SCDEYkspkTv8WBlJnuNBjymQO1i8RIvDMLuWvQg7pfwLhf1ib0WporT5CJjiGV/G9
	 Qe5T/59b56UBg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4602280E13;
	Tue, 22 Sep 2026 18:44:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C3F3812C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5F5C80E13
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:44:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SJgLqzPcAGmX for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AFCBB80E0E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790102663;
 b=pVg7urAnsNFiEmsjGNkdHWcLc3Oj2+ooU3ocyl6CdUs2GufjChLWDvTyQwLDJeUhNzi1
 tKPKKjko10wl7aoDf8jpOlmjPq26EqD0iCBzROxLdwH+uHLrTbkWTAIuFRAZBJSwsz8Ta
 JGEXRevERB4kwKC2X2W/OJtRDos1waUTcmwMZpq314e3ajx7P7M1J5hHsx7skFRoFfQ4I
 e1NDLwA+uH5f9NeNXkaQCTJUoE5+QpZKUmuHRl7MPPjcd3LNSimzozmK5DsPXfNAgz7mf
 RteXcTqpmLicjUol2GjTtET2b63X9L6Fr7OXaIqqMlwNUSmwGCKZd/QGd5Ve8AORf3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790102663;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=1IxyZtZmcdhtuM2dKvn8d1mOOIfkqTrxHyUtB5yx34Q=;
 b=qlUia9pPD/TLTX2bf32TpXkv4bA+Ye/svAvPdca7w5bpv5nG1TQgD+5qP8zACEYk2tEX
 v2SNwnYhVFJLiPocPn5DAoXMSlbW6lD3UNujwsNSRLuTCYQwdJWzBKwko3yEkITFJ7KdL
 i36Ref4hpzBsMLjzXJ9euEEO2S4VQBQzTixacSe9mhQcQHRUzoldPwoR3sngWMKsSb/T+
 sW9Etw5Liq2csRCKKplZKfgwUEmQggCNP0AFktj++c1nDuFWQU4mPrdBW3PX+M7ptfym2
 HsX3tZSjGJsa1jUnFMS/+lJBhKs5xIQLTA+vdBIyZuzwUNCfxiNquIyXy9I+STHA+Sg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ULqOnm5o; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=netdev-bot+sashiko@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ULqOnm5o
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFCBB80E0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:44:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C158443A13;
 Tue, 22 Sep 2026 18:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A42C1F00893;
 Tue, 22 Sep 2026 18:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790102662;
 bh=1IxyZtZmcdhtuM2dKvn8d1mOOIfkqTrxHyUtB5yx34Q=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=ULqOnm5olO9jV8adygoNsZuOmn8oIHOEmnsVGOtWjLKoo9wQbcDWm9aR2sEVyAa5P
 xV8PP0GuJSs+MeZkf6/jt+3FTOKmFN3h/k/JlrGcdMfpwhTkrruHS+IhO9K2Wsj8sh
 351uf+RCPeL1LQMBYTh301MfjqFFk3O7RbjsfLTpJYNFppizAwZYww2vQFKb63Y/yY
 xUQBE1X+UGVTd1ZX/WndoRNElx59rsUwWC2c+tTzrXA7mdP8a3NyVE8A7Ku0AY0zwH
 MEktnmSp+MONIClqYr0NgDhG8dvwcc/XkcgoWk/UylAecU+cEy6xqgX7cr9or2G+Oa
 4d9WjI/4ulIOw==
Subject: Re: [PATCH net-next v3 2/2] net: bridge: fail link info that does not
 fit in a netlink attribute
From: netdev-bot+sashiko@kernel.org
To: iprintercanon@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, kuniyu@google.com, 
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, oss-drivers@corigine.com, wintera@linux.ibm.com,
 aswin@linux.ibm.com, linux-s390@vger.kernel.org
Date: Tue, 22 Sep 2026 18:44:20 +0000
Message-ID: <179010266085.2160803.3521506082186980077@kernel.org>
In-Reply-To: <20260919134333.49379-3-iprintercanon@gmail.com>
References: <20260919134333.49379-3-iprintercanon@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] New error path discards already-consumed CFM status.
- [Low] Missing `Fixes:` tag / stable routing information for a user-
  visible uAPI bug fix.
- [Low] The single `nla_nest_too_large` label emits "AF_SPEC info too
  large, use per-object dumps (e.g. RTM_GETVLAN)" for all three overflow…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but it
  undermines the notification behaviour the commit message describes:…
- [Medium] This problem wasn't introduced by this patch, but it sits
  directly in the rewritten function: in `br_fill_ifinfo()` the return…

--

net: bridge: fail link info that does not fit in a netlink attribute

br_fill_ifinfo() now finalizes the IFLA_AF_SPEC, IFLA_BRIDGE_CFM and
IFLA_BRIDGE_MST nests with nla_nest_end_safe() and returns -E2BIG with an
extack message when a nest payload exceeds what the u16 nla_len can
describe.  br_fill_ifinfo() gains an extack argument, passed through from
br_getlink() and NULL from br_info_notify().

A few questions on the change below.

> nla_len is a u16, and a port with enough VLANs, tunnels or MST entries
> makes the IFLA_AF_SPEC nest wrap, so userspace reads garbage. Same for
> the inner MST and CFM nests.

[Severity: Low]
Since the commit message describes pre-existing user-visible breakage
("userspace reads garbage") rather than a cleanup, should this carry a
Fixes: tag so it gets routed to stable?

The overflow does look reachable: __get_vlan_tinfo_size() in
br_netlink_tunnel.c charges 28 bytes per tunnel mapping

	return nla_total_size(0) + nla_total_size(sizeof(u32)) +
	       nla_total_size(sizeof(u16)) + nla_total_size(sizeof(u16));

so roughly 4094 VLANs with non-consecutive tunnel IDs push the AF_SPEC
payload past U16_MAX, and br_info_notify() allocates an skb of exactly
br_nlmsg_size() bytes for it.

Candidate anchors would be the commit that introduced the AF_SPEC nesting
(b6c02ef54913) and the later CFM/MST reporting additions.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a8..fbd91b86d426 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -588,7 +588,8 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  				goto nla_put_failure;
>  		}
>  
> -		nla_nest_end(skb, cfm_nest);
> +		if (nla_nest_end_safe(skb, cfm_nest) < 0)
> +			goto nla_nest_too_large;
>  	}

[Severity: Medium]
Can this new exit throw away CFM status that has already been consumed?

br_getlink() calls br_fill_ifinfo() with getlink = true, and
br_cfm_status_fill_info() clears the "seen" indications as it serializes
each record:

net/bridge/br_cfm_netlink.c:br_cfm_status_fill_info() {
	...
	if (getlink) {
		/* Clear all 'seen' indications */
		mep->status.opcode_unexp_seen = false;
		mep->status.version_unexp_seen = false;
		mep->status.rx_level_low_seen = false;
	}
	...
		if (getlink) { /* Only clear if this is a GETLINK */
			/* Clear all 'seen' indications */
			peer_mep->cc_status.seen = false;
			peer_mep->cc_status.tlv_seen = false;
			peer_mep->cc_status.seq_unexp_seen = false;
		}
	...
}

Nothing bounds the peer MEP count so that the IFLA_BRIDGE_CFM nest stays
below U16_MAX (each peer status record is around 76 bytes, so roughly 860
peers overflow it).  The nest check then jumps to nla_nest_too_large, which
cancels the whole message and returns -E2BIG, after the flags were already
cleared.

A retry returns -E2BIG again, so that generation of defect and
unexpected-opcode information is gone.  Before this patch the malformed
message was at least delivered.  The existing nla_put_failure path has the
same clear-then-cancel shape; would validating the nest size before
consuming the state be preferable to adding another cancel-after-clear
exit?

> @@ -608,20 +609,27 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  		if (err)
>  			goto nla_put_failure;
>  
> -		nla_nest_end(skb, mst_nest);
> +		if (nla_nest_end_safe(skb, mst_nest) < 0)
> +			goto nla_nest_too_large;
>  	}
>  
>  done:
>  	if (af) {
> -		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
> -			nla_nest_end(skb, af);
> -		else
> +		if (nla_nest_end_safe(skb, af) < 0)
> +			goto nla_nest_too_large;
> +		if (!nla_len(af))
>  			nla_nest_cancel(skb, af);
>  	}
>  
>  	nlmsg_end(skb, nlh);
>  	return 0;
>  

[Severity: Medium]
This isn't a bug introduced by this patch, but it lands right in the
rewritten function: can the done: block finalize a truncated AF_SPEC nest
and report success?

Earlier in br_fill_ifinfo() the VLAN fill result is clobbered:

	if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
		err = br_fill_ifvlaninfo_compressed(skb, vg);
	else
		err = br_fill_ifvlaninfo(skb, vg);

	if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
		err = br_fill_vlan_tunnel_info(skb, vg);
	rcu_read_unlock();
	if (err)
		goto nla_put_failure;

br_fill_vlan_tunnel_info() in br_netlink_tunnel.c returns 0 without writing
anything when no VLAN in the group has a tunnel_dst:

	if (!v->tinfo.tunnel_dst)
		continue;
	...
	return 0;

vlan_tunnel is a port flag that can be set without any per-VLAN tunnel
mapping, so an -EMSGSIZE from the VLAN fill is overwritten with 0, the
goto nla_put_failure is skipped, and control reaches done: which ends the
nest and returns 0.  In a dump rtnl_bridge_getlink() then does

	idx++;

and moves past the device, so the missing VLANs are never emitted.

> +nla_nest_too_large:
> +	NL_SET_ERR_MSG_MOD(extack,
> +			   "AF_SPEC info too large, use per-object dumps (e.g. RTM_GETVLAN)");
> +	nlmsg_cancel(skb, nlh);
> +	return -E2BIG;
> +

[Severity: Low]
All three overflow sites share this label, so an oversized
IFLA_BRIDGE_CFM nest also tells userspace to retry with RTM_GETVLAN.

The bridge only registers PF_BRIDGE handlers for the VLAN and MDB commands:

net/bridge/br_vlan.c:
	{THIS_MODULE, PF_BRIDGE, RTM_GETVLAN, NULL, br_vlan_rtm_dump, 0},

There is no RTM_GET* command that dumps CFM MEP config or status; those
attributes are only produced by br_cfm_config_fill_info() and
br_cfm_status_fill_info(), reachable solely from br_fill_ifinfo(), and
include/uapi/linux/rtnetlink.h has no CFM command.  The same applies to the
per-port IFLA_BRIDGE_MST nest, for which RTM_GETVLAN returns only the
indirect per-VLAN state.

Would a per-site message be better here, so the advice matches what the
kernel can actually return?

>  nla_put_failure:
>  	nlmsg_cancel(skb, nlh);
>  	return -EMSGSIZE;
> @@ -654,7 +662,8 @@ void br_info_notify(int event, const struct net_bridge *br,
>  	if (skb == NULL)
>  		goto errout;
>  
> -	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err = br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>  	if (err < 0) {
>  		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>  		WARN_ON(err == -EMSGSIZE);

[Severity: Medium]
This is a pre-existing issue, but it affects the notification behaviour
described in the changelog: on the CFM status notification path the skb can
be too small, so this WARN_ON fires before the new -E2BIG check is reached.

br_cfm_status_fill_info() opens one nest per record:

net/bridge/br_cfm_netlink.c:br_cfm_status_fill_info() {
	...
	tb = nla_nest_start(skb, IFLA_BRIDGE_CFM_MEP_STATUS_INFO);
	if (!tb)
		goto nla_info_failure;
	...
}

and likewise one IFLA_BRIDGE_CFM_CC_PEER_STATUS_INFO nest per peer MEP, but
br_get_link_af_size_filtered() only charges the outer nest plus the child
attributes:

net/bridge/br_netlink.c:br_get_link_af_size_filtered() {
	...
	vinfo_sz += nla_total_size(0);	/* IFLA_BRIDGE_CFM */
	/* For each status struct the MEP instance (u32) is added */
	vinfo_sz += num_cfm_mep_infos *
		    (nla_total_size(sizeof(u32)) ...
	...
}

No nla_total_size(0) is added for the enclosing per-record nests, so the
estimate is 4 bytes short per record.  br_cfm_notify() reaches this path:

net/bridge/br_cfm.c:br_cfm_notify() {
	u32 filter = RTEXT_FILTER_CFM_STATUS;

	br_info_notify(event, port->br, NULL, filter);
}

The deficit grows with the record count while the slack from kmalloc bucket
rounding does not, so for some MEP/peer counts nla_nest_start() fails with
-EMSGSIZE, the "implies BUG in br_nlmsg_size()" WARN_ON triggers and the
notification is dropped instead of taking the new -E2BIG path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919134333.49379-1-iprintercanon%40gmail.com
