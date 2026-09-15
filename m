Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F30C88E77
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 18:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E78224033B;
	Tue, 15 Sep 2026 18:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nf7Qeys-XID4; Tue, 15 Sep 2026 18:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0A4E040346
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789498322;
	b=K8gMz+2A2oRlgMACxc632wAG37i+E6EN+BCJPiy1OHLrxKtMgpevygpZQs4ccJHjl5VO
	 Gvl2JK5BlBfD0N+I0yGsY7gSuJXJ4birQLjjhhEfku1HgM8EZAxC1w6Q/KbebHmeTP37N
	 CdrEI4ev8SeMlbRvtk5rPrJfx02hwhs9q75Ur0IlwTsrCZn237yAvjTtD+MF3wvjEvOCw
	 90uTVsUj1daW7nLHzIIQQbhQbM5o7CskUDneyV3j1w2IKJLgQMlxNTQL7sIoCapv6C3tE
	 ojlt1Q/RKYkOvKgFH3gkKYvPCzUgNTAr67o2vfomipJIwKbQEcf39wMvRTiuig4hPEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789498322;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6Zd0kC+Yy9Ng843KwX37t61erK5Sw7cuOKPZQI6ppzc=;
	b=GsmfODah54QXSq7rVxxIEIkn4vbqYiDUVy0JBLUY8XdnrvDf4ZvhPpM/TATWO8pwteOu
	 3svpyK4ZsI2sICkI0ydcEav56FGmrOAUe2GCGxadveYZw3UwsU9S01VerpX3sh9KrAAFZ
	 Oa81mGAoGAyHIOpyXY0u8C6UPZM+14+nkY+Jufdrx1LlRHhHaugyknLtWu52wfxrPWFG2
	 UB3srZj31ipbLxTRh4TmivTEczbsV/3gidR/1Bi4NiClawsO3I/5JFj6tECQE5W3d3XJB
	 1mVWiFbgXhV8Jv0myGJK4jVegHRFGemq9qXl+uTspB4K548/mjoil4kpPEWnF0hmbQw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789498322;
	bh=6Zd0kC+Yy9Ng843KwX37t61erK5Sw7cuOKPZQI6ppzc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qTAw8IJlsvAzHIy7MGZBh8Aiq3pfN1FvzsB1SOA/oLLbaPLMSffBEtvevmS1bLtvL
	 GVPQqjqFoQW47aSmUR2E7hpk58w9fFIj1A/CgBVysqyJy5+yk7JITHophNLs2hRYfQ
	 5+iGo1vLEgjsWBpiWcFgn3SybZOZnchhV6Pd2rDbG4j8DMXE4/1NGVlvyXp7KsambA
	 IIfAhzqcPhd4vL05oNKDq58xidyroPI13VxVNqV0ADaVSuSqBspdEq0WCZcYWt7YGV
	 TbTafPHSfVzKXcDACdUCLtU66Mrd4TpzwMLHJwsSuSPYASrUeRF2NjLz6JF+VlFwQF
	 pT8ISNIB8Ih6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A4E040346;
	Tue, 15 Sep 2026 18:52:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B34F62D0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9903180A9B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruqPip-hQ9A3 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 18:51:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8D17680A9A
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789498319;
 b=SKY6lIX0iiINrIIkBVtDo3IOUiLllWC+LXtex8EW545ZtIjDLG2EIFeBthbN0gNzziy3
 y52emfhV3pO6ZssrmBbD40lKqvlwxzkdMMyP3ZPNSWGb6lBOOBsi3l5Z/owAAr0cCS7xs
 8+0xJ806HRT7mWrTEzYgvkVHuJqTfoU8fMnq1lIs76D7yoAJAidI4n4y+dyCU+8MWqwuw
 zWMT+jNw1P1zXq9Z3b8ysZqNafF9vEcojRA0HlnUjahLiPpUVI/QjX5HPoWx5/EXHUji9
 PYVIDpcVuUHJ+0e0eobyS7NgFzROUKr5PcerVQj9yFO9qD1vAje6dlHIvr7ZyTpV8wg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789498319;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=6Zd0kC+Yy9Ng843KwX37t61erK5Sw7cuOKPZQI6ppzc=;
 b=PFXzxu0IgqBpYlCjokuwwiiLvJ1xcZ5ipxnB3rhZ1g17AE40Fc4wI2SI2Vhq0pwmOCrm
 Mza7U8rctDmuBNb7r2D+c4cKlCd4x28h2GHJPgxyrFF6/yYtBFYHhLEpSalvMIpev+Iwm
 lNf/VFJECTQtFH/TTbAtqx8J/FyOJyaNWWE+Uxd0g1qO6tpd1cOIPxhe2Vq3kCvDcUh9t
 f9mXdrPz75XEDfuApY7kkHpVKmAmcjJXeAA/uTTVVckrLt/DeX+zYd8teUN9eHSkcl0Xn
 kzC0GFkGlcyzCaD/oNRVUm75aUpC87jjEPHMho3vmCND35mZfRkHGhzePoG9TPv3KNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IvOpH985; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=IvOpH985
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D17680A9A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 18:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EEA5060142;
 Tue, 15 Sep 2026 18:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4C51F000FF;
 Tue, 15 Sep 2026 18:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498317;
 bh=6Zd0kC+Yy9Ng843KwX37t61erK5Sw7cuOKPZQI6ppzc=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=IvOpH985U8Dx0YGCxtSn8aHcEX1CsCN7dkKQBfKqsCUJxJaSEMSDxOtT9GEI/HLAH
 r+Li9ccW37WAm4wjjstzLwP1TJ3US4KKO4u5/3MoMxyN+VwcUuZQpVsZLd0W5oFS1k
 PTRavUfay78CMXmlR5BBpInf71aJP9vbFfUWDobmsq5ntitzBLSbkGpUJkbdOUCJAI
 a8yE97PKje1S1hWktfvA1Cf82YQuZIQVK/43roT41GIyGdIIRemo4wMlh4JvQe/OOs
 abuuKhaDqjTv8/0TM5HJBjnYbahUulcKROHkrQ8vjMSehqWVR+XiB5S0D/V8+g69LM
 lAjlNHyYU5nWw==
Subject: Re: [PATCH net-next v2 2/2] net: bridge: fail link info that does not
 fit the IFLA_AF_SPEC nest
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
Date: Tue, 15 Sep 2026 18:51:55 +0000
Message-ID: <178949831579.22033.2772389608829417270@kernel.org>
In-Reply-To: <20260912135022.1701-3-iprintercanon@gmail.com>
References: <20260912135022.1701-3-iprintercanon@gmail.com>
X-sashiko-severity: High
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 1

- [High] Incomplete bounds check: the new U16_MAX guard only measures the
  outer IFLA_AF_SPEC nest and only runs at the 'done:' label, i.e. after…
- [Medium] Returning -E2BIG from br_fill_ifinfo()/br_getlink() aborts the
  whole RTM_GETLINK/AF_BRIDGE dump at the offending device:…
- [Low] The patch changes user-visible behaviour to fix a data-corruption
  bug (the commit message itself says 'a large enough port produces a…

--

net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest

br_fill_ifinfo() now measures the IFLA_AF_SPEC nest at the done: label and,
if the accumulated payload exceeds U16_MAX, cancels the message and returns
-E2BIG with an extack.  An extack argument is threaded into br_fill_ifinfo()
from br_getlink(), while br_info_notify() passes NULL.

A couple of questions on the placement of the check and on the resulting
dump behaviour.

First, on the commit message trailers:

>     Assisted-by: Claude:claude-opus-5
>     Signed-off-by: Artem Lytkin <iprintercanon@gmail.com>

[Severity: Low]
The commit message describes a user-visible corruption ("a large enough port
produces a nest whose length wraps and userspace reads garbage"), but there
is no Fixes: tag.  Should one be added naming the commit that first made more
than 64 KiB of IFLA_AF_SPEC content possible, for example the per-VLAN
tunnel-info netlink support or the IFLA_BRIDGE_MST support, so that stable
tooling picks this up and the affected range is clear?

Also, Assisted-by: is not one of the documented trailers.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..53676df9e4d11 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c

[ ... ]

> @@ -613,6 +613,12 @@ static int br_fill_ifinfo(struct sk_buff *skb,
>  
>  done:
>  	if (af) {
> +		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
> +			NL_SET_ERR_MSG_MOD(extack,
> +					   "VLAN information does not fit in one message, use RTM_GETVLAN");
> +			nlmsg_cancel(skb, nlh);
> +			return -E2BIG;
> +		}

[Severity: High]
Does this check come too late to cover the inner nests?

The MST and CFM nests are closed earlier in br_fill_ifinfo(), before control
reaches done:

net/bridge/br_netlink.c:br_fill_ifinfo() {
	...
		err = br_mst_fill_info(skb, vg);
		if (err)
			goto nla_put_failure;

		nla_nest_end(skb, mst_nest);
	}

done:
	if (af) {
		if (skb_tail_pointer(skb) - (unsigned char *)af > U16_MAX) {
	...
}

and nla_nest_end() both warns and performs the truncating store:

include/net/netlink.h:nla_nest_end() {
	unsigned long diff = skb_tail_pointer(skb) - (unsigned char *)start;

	DEBUG_NET_WARN_ON_ONCE(diff > U16_MAX);
	start->nla_len = diff;
	...
}

Can IFLA_BRIDGE_MST alone exceed 65535 bytes?  br_mst_fill_info() emits one
roughly 20 byte IFLA_BRIDGE_MST_ENTRY per distinct MSTI, with no aggregate
size accounting:

net/bridge/br_mst.c:br_mst_fill_info() {
	list_for_each_entry(v, &vg->vlan_list, vlist) {
		if (test_bit(v->brvlan->msti, seen))
			continue;

		nest = nla_nest_start_noflag(skb, IFLA_BRIDGE_MST_ENTRY);
	...
}

With up to 4094 distinct MSTIs that is roughly 82 KB, and the same applies to
IFLA_BRIDGE_CFM where each peer-MEP status entry is roughly 76 bytes.  The
dump skb is sized from br_get_link_af_size_filtered() via rtnl_calcit() into
cb->min_dump_alloc, which is a u32 with no 64 KiB cap, so the oversized nest
is actually written out.

So for the inner nests the wrapped nla_len is still stored, and on
CONFIG_DEBUG_NET kernels the DEBUG_NET_WARN_ON_ONCE fires from an ordinary
unprivileged RTM_GETLINK/AF_BRIDGE dump.  Would the size have to be bounded
while each nest is being filled, rather than once after the whole message has
been serialized?

[Severity: Medium]
Does returning -E2BIG here stop the rest of the dump?

The chain is rtnl_bridge_getlink() -> br_getlink() -> br_fill_ifinfo(), and
rtnl_bridge_getlink() treats any negative error other than -EOPNOTSUPP as
terminal for the whole walk:

net/core/rtnetlink.c:rtnl_bridge_getlink() {
	...
				if (err < 0 && err != -EOPNOTSUPP) {
					if (likely(skb->len))
						break;

					goto out_err;
				}
			}
			idx++;
	...
	err = skb->len;
out_err:
	rcu_read_unlock();
	cb->args[0] = idx;
}

Since idx is not incremented for the failing device, cb->args[0] still points
at it on the retry round.  That round starts with skb->len == 0, so it takes
goto out_err and the dump ends with -E2BIG.  Are all ports after the
offending one then never enumerated, and does every subsequent dump fail at
the same device again?  Before the patch the same configuration produced one
message with a wrapped AF_SPEC length but the walk continued.

The commit message says only that "the error goes to userspace"; should it
mention that the remainder of the dump is dropped?

On the extack text: the same overflow is reachable for a request that sets
only RTEXT_FILTER_MST or only RTEXT_FILTER_CFM_CONFIG / RTEXT_FILTER_CFM_STATUS,
where no VLAN data is emitted at all and RTM_GETVLAN is not a substitute.
Could the message be made specific to what actually overflowed?

>  		if (nlmsg_get_pos(skb) - (void *)af > nla_attr_size(0))
>  			nla_nest_end(skb, af);
>  		else

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912135022.1701-1-iprintercanon%40gmail.com
