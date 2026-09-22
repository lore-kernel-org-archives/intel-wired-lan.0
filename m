Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9EFC98302
	for <intel-wired-lan@archiver.kernel.org>; Tue, 22 Sep 2026 18:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD920607B7;
	Tue, 22 Sep 2026 18:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZ0W7SuEP62c; Tue, 22 Sep 2026 18:44:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4AA9F606E0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790102664;
	b=UxxTAvkNj8PhF10xNzt0yFpYPZK6rCWkXVIVbQH+Q7nIUmam91oy1rJOFsOfCbqQhkkS
	 98ubIC6gP33DecfSr2LtFWmR1X9hq/yg1wecWOkF+D/SiY7JvISdEBa7+dgqg5DEio7Xe
	 Fer1NEYFp+OCFIUOGp1669WIhbDI0WfKimQi5vFaKOnxv+6P82GdmkIeFAsBLOrJtPOYM
	 vLFPC5hvgavS0WuhpDl0jhBUL/JpTQO+qyHO8DIBot1SDqVeIrLixcvZOEst1NJhziIL7
	 yw/kGy6m5cFDJLmCNgbn254mMtxWh1f5XIkp+IAGCPxXRKHefzfAEAJuLVMf0ZWyL8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790102664;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UjEou/Ftu9I+L9AdcUk1ScJDdFJXrMrfvwt0cglL1Ok=;
	b=f0wIksOgSbfZEWeZS7bR75Pyie1ejwsCiPJPdraZy2wZGlIZhxYCwFIuRNRoU3KrH/y2
	 M8kaczbGMw+93x/NDyxWTXwA0TYFN9SvGZ4TxznStAqsENlvJVoAjlUkvMTrQNIY/EZjm
	 1q57gqE8cKJKtQVrXOuOUOyZk0fBT91z7Lv5Wx84BWna9T+hKF8CfYvLrILopOPGy5bw5
	 xEeIR61PPong/wjIgc1HqGu6TxLyyJgap6U/nFMCnzfXEuJL0wpzcqpdbihV/4B+vOmuV
	 atPN22rnVk1qH2uPN3jIvTeY/kTxfglE3P3v5uiRFwwdFl0Po/MGekiMn4QkUuUJesg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790102664;
	bh=UjEou/Ftu9I+L9AdcUk1ScJDdFJXrMrfvwt0cglL1Ok=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8nnwl2BYQZwhBhxUwPW894I3gR0dFSRuhOewTLNzHnryxLOGJ8NVWSW3a/O232El3
	 r/yFTiFijwy0xNIAtD8xohKEo48+102j20pzDXXZt9ziS4pbZF4uHLRRqut4pC/3II
	 hZaTUtZDqz8hJ0m3SvBPzhRd7zGAC8UWBV0oYN/vKrcDelUmUhAusE6E42poIXFt6L
	 S7WrRuzLwl1gVfuTWUc9xvHf0jfHOVjKmY+73MPhxDr3On6NbIrwDT3/4z/0oZflYA
	 HO8YnQJeovNIqWj3h4Renjw8teOsigXLDzezNuY+asYCsYRHOhlu2Km30UceFWaiEU
	 VVGJwIBXea5KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AA9F606E0;
	Tue, 22 Sep 2026 18:44:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D20B12C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E68FA80E13
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aT4s9vfJBuMP for <intel-wired-lan@lists.osuosl.org>;
 Tue, 22 Sep 2026 18:44:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EDC8680E0E
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790102662;
 b=AJvau/yeQ5EE7o8xHx777fQRooNDfz5w1skHF2C/HnLXRVAwF4OnuHE06Xb0Fa4JVc2f
 vgO/3Y0wZeA7iPl3idX961bHPj1OA1SM8HcvWjtp84rzSLU31IEmiYh+cXZeQSheTs9ic
 Cp2hCIsAaiHXuXcoSn9UmzfSEG44pvbOkvOpGCrfR+ZI7sv3IGrO8PyYi8QvZWFNTtVAq
 9aK+xPX2PGnoCzyI+DatA30hcpejAdFeW1FSGEk7ZNeGJ+xqN1E6apkAQL93JdqoRPLWU
 N9+QjpC7A+bQrq09iIRZZf5Gm7lhwbTS6bTxeNHeNOHOPIuIUHxFjW3qTFhrGJqEPDQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790102662;
 h=Received-SPF:Received:Received:DKIM-Signature:Subject:From:To:Cc:
 Date:Message-ID:In-Reply-To:References:X-sashiko-severity:
 Content-Type:Content-Transfer-Encoding:MIME-Version;
 bh=UjEou/Ftu9I+L9AdcUk1ScJDdFJXrMrfvwt0cglL1Ok=;
 b=hCbuf/GZ2eygMEp/8Zkpp7wdYBEz1qOYX5g3YYlMGZQ+woJ1IWk4nqJiOnbsNMCFQgzA
 trpXCzzlUIpUhT/cmskWmoFgdDIsFYSfWBZjIjHDtkOIyf44Brdl8FQvqAO7kwnWztDXz
 Y2QSuCSFSyYsDD3Zz3K330O8uI2fst5sJ2qsJMP/46HBSWCZYPdBJLYCxu8MoftQfvMKE
 0A+d5a1TLtiQST+RzA91uRGTmHy7tuCllY9DNRBSptiqQyHPBKq/08fOqc8tPUGjDiU1X
 MMBp6U5S+gzHL0cT+jhIdBI4E/iaJvZh9vvGg5Dlu1Z0KpyZYP2OI+TR8Nx5a2Rq+pg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=kAXyt4bd; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=netdev-bot+sashiko@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=kAXyt4bd
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EDC8680E0E
 for <intel-wired-lan@lists.osuosl.org>; Tue, 22 Sep 2026 18:44:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C439F437E9;
 Tue, 22 Sep 2026 18:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7911F000FF;
 Tue, 22 Sep 2026 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790102660;
 bh=UjEou/Ftu9I+L9AdcUk1ScJDdFJXrMrfvwt0cglL1Ok=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=kAXyt4bdygdTvDTWP9ntXNYI0zgVyiwrs67bi2HRbSIo7Wxqaz2v4x7icoTZqR80V
 4/QXnH3/sd24yVc/cs5JtVq0uYoQMMUbKh9FzQIi0n7njAPMg37w9FzAXz4QGiiZd9
 cI31Q4kq6LXby1RYeHzlYuo3ZEp/1U0JGUj2rYqNShaGDbQN5YdP7kgEX4mDj5klRd
 NHFVCZ0Zd+RfrOSR9297bdJEI3sU2cF4MTUYjZMEBGDYtx2tPm56BZ0LFh/EAKBU5Z
 CDn92FXS8UicEfgNeEv+Az9kh+5afz1FxuSaETQ6grP7RiGfWcErFY5TR+u1cPTj7D
 GACtiByAkm2XA==
Subject: Re: [PATCH net-next v3 1/2] rtnetlink: pass extack to
 ndo_bridge_getlink()
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
Date: Tue, 22 Sep 2026 18:44:18 +0000
Message-ID: <179010265895.2160803.373522142695973642@kernel.org>
In-Reply-To: <20260919134333.49379-2-iprintercanon@gmail.com>
References: <20260919134333.49379-2-iprintercanon@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Patch 1 ("rtnetlink: pass extack to ndo_bridge_getlink()")
  threads a `struct netlink_ext_ack *extack` through the…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but in
  `br_fill_ifinfo()` (net/bridge/br_netlink.c) the VLAN-fill result is…

--

rtnetlink: pass extack to ndo_bridge_getlink()

The patch adds a struct netlink_ext_ack *extack argument to the
ndo_bridge_getlink op, to ndo_dflt_bridge_getlink() and to br_getlink(),
and updates the eight in-tree implementations plus the two rtnetlink call
sites. The commit describes itself as no functional change.

> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index e3444fd24061..a341e06f47d3 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5420,7 +5420,8 @@ int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
>  			    u32 filter_mask,
>  			    int (*vlan_fill)(struct sk_buff *skb,
>  					     struct net_device *dev,
> -					     u32 filter_mask))
> +					     u32 filter_mask),
> +			    struct netlink_ext_ack *extack)
>  {
>  	struct nlmsghdr *nlh;
>  	struct ifinfomsg *ifm;

[Severity: Low]
Taken on its own, does this patch leave extack unused in every callee it
touches?

ndo_dflt_bridge_getlink() gains the parameter but none of its failure
paths reference it:

net/core/rtnetlink.c:ndo_dflt_bridge_getlink() {
	...
	nlh = nlmsg_put(skb, pid, seq, RTM_NEWLINK, sizeof(*ifm), nlflags);
	if (nlh == NULL)
		return -EMSGSIZE;
	...
nla_put_failure:
	nlmsg_cancel(skb, nlh);
	return err ? err : -EMSGSIZE;
}

So for the eight drivers that use the default helper the extack stays
empty, and the commit message statement "So the bridge can say why filling
the link info failed" is only realized by the next patch in the series,
which adds the extack argument to br_fill_ifinfo() and emits
NL_SET_ERR_MSG_MOD() there. Would it help to say in the changelog that
this is preparation and that the message is added by the following patch?

[ ... ]

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index ae76df0de05a..855a46aec3a8 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -680,7 +680,8 @@ void br_ifinfo_notify(int event, const struct net_bridge *br,
>   * Dump information about all ports, in response to GETLINK
>   */
>  int br_getlink(struct sk_buff *skb, u32 pid, u32 seq,
> -	       struct net_device *dev, u32 filter_mask, int nlflags)
> +	       struct net_device *dev, u32 filter_mask, int nlflags,
> +	       struct netlink_ext_ack *extack)
>  {
>  	struct net_bridge_port *port = br_port_get_rtnl(dev);
>  

[Severity: Low]
br_getlink() accepts extack here but drops it, since the call below is
left unchanged:

net/bridge/br_netlink.c:br_getlink() {
	...
	return br_fill_ifinfo(skb, port, pid, seq, RTM_NEWLINK, nlflags,
			      filter_mask, dev, true);
}

br_fill_ifinfo() is the function that actually returns -EMSGSIZE, so does
anything in the bridge get to use the new argument until the follow-up
patch wires it into br_fill_ifinfo()?

While looking at br_fill_ifinfo() for the above, one unrelated
observation:

[Severity: Medium]
This isn't a bug introduced by this patch, but in br_fill_ifinfo() the
VLAN fill result is overwritten before it is tested:

net/bridge/br_netlink.c:br_fill_ifinfo() {
	...
		if (filter_mask & RTEXT_FILTER_BRVLAN_COMPRESSED)
			err = br_fill_ifvlaninfo_compressed(skb, vg);
		else
			err = br_fill_ifvlaninfo(skb, vg);

		if (port && test_bit(BR_VLAN_TUNNEL_BIT, &port->flags))
			err = br_fill_vlan_tunnel_info(skb, vg);
		rcu_read_unlock();
		if (err)
			goto nla_put_failure;
	...
}

Can an -EMSGSIZE from br_fill_ifvlaninfo[_compressed]() be lost here?
br_fill_vlan_tunnel_info() in net/bridge/br_netlink_tunnel.c skips every
VLAN that has no tinfo.tunnel_dst and returns 0 without touching the skb,
which happens after "bridge link set dev X vlan_tunnel on" with no
tunnel_info id mappings configured:

net/bridge/br_netlink_tunnel.c:br_fill_vlan_tunnel_info() {
	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
		if (!br_vlan_should_use(v))
			continue;

		if (!v->tinfo.tunnel_dst)
			continue;
	...
	return 0;
}

In that configuration a partially filled VLAN list appears to be
finalized as success, and rtnl_bridge_getlink() then advances idx and
records it in cb->args[0], so the port is not retried in the next dump
round:

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
}

Would testing the VLAN fill error before calling
br_fill_vlan_tunnel_info() be the right fix? This code is identical in
the baseline and is unchanged by the series, so it is a separate patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919134333.49379-1-iprintercanon%40gmail.com
