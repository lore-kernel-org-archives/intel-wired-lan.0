Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DA606A33D
	for <intel-wired-lan@archiver.kernel.org>; Mon,  9 Nov 2026 17:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=j5V0W8dj;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=TbvIhSbT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB13D6080E;
	Mon,  9 Nov 2026 17:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id apzv0Qhe4T7W; Mon,  9 Nov 2026 17:18:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8A605607B8
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244738;
	b=DJlEkLd4bEWJVRjfMca+jltppy86wnsLhB+dsMfViKKis8hUumJhkSbdpFIR6eJYhLB1
	 7z65Nof+sK1QBj4trlC/CozQrR4fsf1CP4Hs3OzcwuaAM2umtZeiOwBpQT0yERBVSGkQw
	 Sra2ZBjKA65T6+BvDdYpL+u0vTF0y0JGtWhLY2Qgl4zVUzDIyt6U79lhAO82jNG92zFkR
	 Zoczxn2vf5kQAJykE6+HZ06TDxCkln5IpA0+rM4AcgDBk+gsDjUyxbLcpOaZVtBTh37Y8
	 fWGWdkfDSGuexnMtX3093i9RmnpPTK/E5bS9yDPXOfy4d/Ic2KWmEyVxUwEcKLLTOoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ah3ZygR+c4YLpOShjlCccm4ACHvwsjqPcDugpOfZDmw=;
	b=X0Iyf2IHH+L6d/6tuWR+Hv2E7UdsrQ7DVPskI1c/l+s3zGFnIYTc+umNB4I7Doyxcr+o
	 vw6ul5cyCUon1wKLIDzo7cAOR1vgNouR4oZznSKcaRmxwBIcUOPiGR8AfWfEPdM22zrfI
	 rR9nX9KIV0XVrXIZ93RA9lpAiJ5Xehq2WH0FVpxTVE/mhyluBvKiXadqoIdjEmcEGNBmM
	 ocVZ+jp8KYBj7e6EI/YrRQVFTlpkalHZY1rAvIabn3pbDpcTFHJ8/XruB/bCuYR8pVWPP
	 AsaAIaiua/wKG3MLpOTPXwXbQgl8FVV5oZCxDVBsxjNtBgEsUhPp6HIFmDhnpW4fjbQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=TbvIhSbT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794244738;
	bh=ah3ZygR+c4YLpOShjlCccm4ACHvwsjqPcDugpOfZDmw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j5V0W8djZofg6NM9GQxMhrCDBbd+0iIhvS5MwdTcrx6rTTuAEh7jlvrH6ENI9CtBS
	 VrYqA/kULBSh3RilJdwVgQo0GpHse0AhSWGl5EUGUjsFlcbHClEL/HB40XoAyjAMtr
	 9qnwt5GfIWHce/js68LlG6AzKo5hDFCiWJKjaIw7Szvp6PilBE4F4Xe1IOXdAF8e7o
	 iVOV5IfaVHJdVhCPKTShu6Au49+a8XrLh2Yg/pnq5zSAAOMXRhL5ulGpmagEoOxGQD
	 maL+DkKSF/xZEcTaC1bQcdcPf00sBOF85RzGPo5hcJSo2rBQmC/HILS17jCTg/mRYN
	 wPJHrlPnzV+Lw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A605607B8;
	Mon,  9 Nov 2026 17:18:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 828E51E3
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7337D60628
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b99ZMK9w5RQS for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 18:44:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 05AD560609
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=omar@blockcast.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=blockcast.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=blockcast.net header.i=@blockcast.net
 header.a=rsa-sha256 header.s=google header.b=TbvIhSbT
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05AD560609
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 18:44:42 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-36f8cdd30beso649910eec.1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 07 Nov 2026 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blockcast.net; s=google; t=1794077082; x=1794681882; darn=lists.osuosl.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ah3ZygR+c4YLpOShjlCccm4ACHvwsjqPcDugpOfZDmw=;
 b=TbvIhSbTNUkX9s6t+yjaNsOjfggnWaGS5pFbwtkJ7M7/7IY7Yq5RdxjwbkLMAWev13
 oMLGN3U28DU/NlcGZnwoyGyMueX0FjZpuPajmVE5WK2jDMliBPgG8zz+bJ1CAof4WtdD
 eyh8RyiSoLePfhqSr/9gHOwCjmXpqoDZd2tg/QZXkMeRdMajITtoDwAxpTLp0lSf3G+1
 4nuNQYkvIbuPyQ42QQITa8Mjv1RyWXr/GVye2p+RXYYBX15YwXP6gqFaBYiy0lDlbqRN
 TxyqbCXCQluw91kc1lZmah2P3uhdmpWm2UqgGm6UKDLV3ZeOi3Mr1N/38BcOFdMBzHwJ
 G+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794077082; x=1794681882;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ah3ZygR+c4YLpOShjlCccm4ACHvwsjqPcDugpOfZDmw=;
 b=ZelFATLL6Ifg8aFHHdW0EOAGzbosdityzyoPxvcA3HQP5SRS1ydbh+LgQsLhVp1LxJ
 aH7uYMAc198OcgdlRmYrvE6O1g41HhW8ouOxVYUFTyOSYmqP1tSv7mEb9DFd4ZNO8Nsj
 cwyJ+2s65TZXlf91Dey4GzAwPaPMTwk1kQjQBk80p+FopTIG8o7I6puzBZf6gOnpb742
 T7iz6Ay1hVCosymnoLJUXTVo8Ul4nzE7UIXbhA6DSoYa7qFGctoh63MbGgQgCm0zZBV6
 znJHuVPMw2n2MGk7QOD5Z9Hz6kTUvT+5HgFlePuNvFoCXCi5hvktXS+INcauDmBpvbKr
 o77g==
X-Forwarded-Encrypted: i=1;
 AL+hErGiulwD9s4fbvVJ9NL7ZwtmFc/0BPLEGbYGJBQ3hUIWIYEFmG2bTuuosv5ejF+WXCXbn6DysZm+IA0xjMQ1urw=@lists.osuosl.org
X-Gm-Message-State: APuU4Z8O4+quZ1NJnMjkycblnnK0EplgmQMI2Bb79esx9yH+EvEDR1jZ
 7LSsw0HtiSLYTMi6HMGjcISLYR2Yu2crshmW2LEMCYpbsp3vc2llDS4RS9VjO2b0kwQ=
X-Gm-Gg: AYBFou1TVZOAzk4WCZc1MiwTIOHmXOZq4lsXY4+qcb3VCFnK6r9niBEvyWYjHgYIV45
 xtxCmTvIt8BGlXlHtd9+ykvOxQrXwXJuCeJc2Xaa1NfiWADTBt7bnUummu57cYzvH3JaAU8DLra
 ZmS6OxozcgpvZPvP1UVclkPAWglIWNXJu0b9mJpntzZo16ExgCiVRWKOWE/mfPLz8/OaqC7j0Ei
 uWQwFu/RKFOAjELIjKwdH01d4xMAzJVg/kJu4J1rnSoF3OSpXZa8gC3lFS034ljQABfzCRn8sJm
 pAFRt2qpGOzncbm9uLNopCRPhspFMx/qDhIb7yQotrw7JAd3abX+tWPNWmy66cALHoO2asOWgXt
 CWr2Ibt87c7POpTyAk4irmiujBoAw3AZmfyokQdPxIFZdmGptPvqVOn6/mwc7071hHK8iIx3ELC
 K9pIzpqHnqsxK/6eHmfXg38qBYPLLaOESC7l7uTriSkAxe7QrkYSfw2JanfkSD3wg84hz00nGaN
 Gji1cu4hgB9k9e734Bmd+ZgCstQBNY9RzAKL/enMOj7d7+lQl9TW/ebMFs4tUfLbkB7xYu/X1Fg
 PF7loxptpsM6X9aAkSYY8uwJLmwrgS6i808m/jvCNv/sRDsH/9Yr340U7jquC5v/v6D3iBM=
X-Received: by 2002:a05:7300:109:b0:36a:79e7:2fd with SMTP id
 5a478bee46e88-36f77ce5f5fmr9933762eec.40.1794077081392; 
 Sat, 07 Nov 2026 10:44:41 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8c4f28dsm17286897eec.9.2026.11.07.10.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 10:44:40 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 brett.creeley@amd.com, sgoutham@marvell.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 Ido Schimmel <idosch@nvidia.com>, Satish Kharat <satishkh@cisco.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [RFC PATCH net-next 0/9] amt: relay replication offload provider
 contract (RFC, not for merge, seeking a provider)
Date: Sat,  7 Nov 2026 18:44:28 +0000
Message-ID: <20261107184437.2783174-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 09 Nov 2026 17:18:54 +0000
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is an RFC and is NOT for merge. We are posting it to find a
provider: a Linux-attached device (DPU, SmartNIC, switch ASIC or P4
target) whose driver would implement the contract below. We will not
post a for-merge version until one in-tree driver with a named
maintainer implements it, either as a co-authored patch on this list
or as a public commitment from that driver's maintainer. Until then
the contract has no in-tree user other than netdevsim, and we do not
think it should be merged on netdevsim alone.

Problem

An AMT relay (RFC 7450) replicates every multicast data packet once
per gateway tunnel: one UDP-encapsulated unicast copy per gateway that
joined the group. In drivers/net/amt.c that is the loop in
amt_dev_xmit(), one skb copy and one route lookup per tunnel. At the
relay's egress the copy count, not the input rate, sets the
ceiling. We are bringing up an AMT relay port at the SFMIX exchange,
which is where that ceiling becomes concrete for us.

Hardware that can replicate one packet to N unicast destinations
exists, but there is no way for the amt driver to hand that work to
it. This series proposes one.

What the series does

  Patch 1 adds include/net/amt_offload.h: provider capabilities,
    opaque provider-owned endpoint and group handles, struct
    amt_offload_ops, the TX and ingress paths, the FALLBACK /
    CONSUMED / BUSY results and a per-binding u64 epoch. It is an
    in-kernel interface with no ABI promise.
  Patch 2 adds the provider registry, keyed by the lower netdev
    (amt_offload_register() / amt_offload_unregister()), and the
    lower-device lifecycle: a relay in auto or required mode binds
    when its stream device is a registered lower and the provider
    accepts it (otherwise it stays unbound, counted), and unbinds in
    a fixed order on NETDEV_UNREGISTER, provider unregister or relay
    deletion.
  Patch 3 adds one group object per (family, group) with its member
    endpoints, a generation and the desired state, plus a reconciler
    that programs the provider from process context, never under
    amt->lock, with a per-tick op budget, ENOSPC hysteresis with a
    software remainder, and reset-and-replay on op timeout.
  Patch 4, on a TX binding, hands each relay data packet of a group
    whose commit amt has published to the provider before the
    software loop, while the binding admits packets and its desired
    state is in sync; every other packet goes to software. Exactly
    one actor handles each packet handed over: CONSUMED means the
    provider handled every copy (sent it, or dropped and counted it)
    and owns the skb; FALLBACK and BUSY mean the provider sent no
    copy and amt runs the software loop once. It also exports
    amt_offload_encap_xmit(), so a simulated provider emits copies
    byte-identical to amt's own.
  Patch 5 adds IFLA_AMT_OFFLOAD_MODE (software, the default; auto;
    required). required with no usable provider refuses the link with
    -ENODEV and extack.
  Patch 6 adds 26 KUnit cases for the contract against an in-file
    fake provider.
  Patch 7 adds a TX reference provider to netdevsim. It keeps its own
    endpoint, group and generation tables, decides replication from
    them and emits each copy over the peer link. debugfs injects
    ENOSPC, reset and BUSY; devlink resources and an amt health
    reporter are registered on netdevsim's own devlink instance.
  Patch 8 adds tools/testing/selftests/net/amt_offload.sh. It counts
    the copies each gateway receives, and reads the provider's own
    hardware copy count, in the no-member, commit, generation-replace,
    BUSY, per-group forwarding, reset, partial-commit, disable and
    unlink-under-traffic cases. It also checks that required mode
    with no provider is refused, and that deleting a lower carrying
    two amt devices removes both without a warning.
  Patch 9 adds the new header and the netdevsim provider to the AMT
    MAINTAINERS entry.

Forwarding semantics are unchanged by design. The hardware key is
(family, group), because that is what the software path forwards on
today: a tunnel with only an INCLUDE(S1) membership still receives S2
for that group. A provider that keyed on (S, G) would change what
gateways receive, so the feature bit for it is reserved with no
semantics in this version.

With no provider registered, or with offload=software (the default),
amt_dev_xmit() runs the same loop it runs today, after one more RCU
pointer read and test (patch 4).

Questions for the list

1. This RFC registers providers in a registry keyed by the lower
   netdev and adds nothing to struct net_device or net_device_ops.
   Once a real driver exists, would you rather see a struct net_device
   field or an ndo instead?
2. Is netdevsim the right home for the reference provider, given it
   has no ingress classifier to simulate and so can only exercise the
   TX path?
3. Is an in-kernel provider contract for a single tunnel driver
   acceptable at all, or would you want it expressed through an
   existing offload framework? We did not find one that models
   one-to-N unicast replication with per-destination encapsulation.
4. The per-relay offload state and counters are exposed in a sysfs
   offload/ group on the amt device for this RFC. We expect to move
   them to netlink (link xstats) for a for-merge version, and would
   like guidance on that.

Performance

This series makes no performance claim. With no provider it adds one
more RCU pointer read and test per packet to the software path
(patch 4), which we have not measured, and netdevsim demonstrates the
contract's semantics, not speed.

For context only, we measured a separate software fan-out change,
which is not part of this series and has not been posted: it clones
each copy instead of copying it, clears the copy's hash and caches
each tunnel's outer route. Base and branch are both builds of our
downstream 6.18-based amt.c, out of tree against v6.18.48, not of
net-next's driver. Base is that driver just before the change. Branch
adds the change and an earlier 6.18 form of this series' patches 1, 2
and 5, which add no code to the data path; patch 4 was not in it. CPU
time per copy, median ns over 6 interleaved runs on two days,
virtme-ng guest, software path, no provider bound:

    N tunnels   base    branch   branch/base
            8   1898      1326         0.699
           64   1974      1392         0.705
          512   2480      1612         0.650

The table pools both days. Day 2 reproduced the direction but not the
spread: on day 2 alone the branch/base ratio was 0.706-0.730 (a 27-29%
saving), and the branch's day-2 medians at N=64 and N=512 fell outside
their day-1 ranges. The saving we would defend is therefore ~27-35%,
not a single figure.

No drops were counted on any step. We have not yet measured a
hardware AMT relay (a router-terminated relay, which would measure
relay capacity rather than this contract) against the Linux software
path, and the first-loss point is not yet measured on a physical NIC,
so we quote no hardware rate here.

We have also prepared a vendor capability appendix covering Linux amt,
Junos, Cisco, Arista and DPU/SmartNIC replication, with every row
either cited or marked unconfirmed. It is available on request to
anyone evaluating whether their device could be a provider.

Known limitation: tunnel lifetime

The offload desired state is only as sound as the relay's tunnel
lifetime, and the hooks in patches 3 and 4 inherit three windows that
exist in amt.c today:

  - an Update can add a group node, and with this series an offload
    member, after amt_clear_groups() on a tunnel that is about to be
    freed by kfree_rcu();
  - an Update can re-arm a tunnel's gc_wq while amt_tunnel_expire()
    unlinks and frees it, so the expiry, and with this series
    amt_ofl_tunnel_gone(), can run again on freed memory;
  - amt_dev_stop() unlinks a tunnel before
    cancel_delayed_work_sync(gc_wq).

None is introduced here. All three are closed by the in-review net
series "[PATCH net v6 0/6] amt: relay tunnel lifetime, validation and
request-path hardening"
(<20261107004935.2627329-1-omar@blockcast.net>), which a for-merge
version of this series will depend on.

Dependencies

This does not apply to bare net-next, and patchwork will report it as
not applying. It is written on v7.1 plus eight of our other amt
series, not all of them posted:

  - relay endpoint keying and visible pre-Query report drops, later
    versions of which are part of the net series cited above;
  - sending the relay's General Query directly, a later version of
    which is in mainline as commit afae89de73dd ("amt: send the
    relay's General Query directly from the receive path");
  - the IPv6 relay and gateway modes, a reworked version of which was
    posted, in a different split, as "[PATCH net-next 00/13] amt: add
    an IPv6 outer transport"
    (<20261009122426.551178-1-omar@blockcast.net>), on which changes
    were requested;
  - relay scaling (configurable hash buckets, group limit and queue
    count), the relay sending IGMPv3/MLDv2 host reports upstream, and
    a configurable per-source tunnel cap, none of which has been
    posted.

The net series instead bounds the tunnels admitted per source address
at a fixed 16. Our "[PATCH net-next v2] amt: make the per-tunnel group
and source limits configurable"
(<20261015231825.2852054-1-omar@blockcast.net>), on which changes were
requested, overlaps the scaling group limit, and its planned v3 also
sizes the hash buckets.

Patch 8's case for a lower carrying two amt devices also needs our fix
"amt: tear down every amt device on an unregistering lower"
(<20261105232302.494171-1-omar@blockcast.net>), posted to net
separately. Without it, amt_device_event() unregisters only the first
amt device on an unregistering lower, so the second stays linked and
trips the upper-device WARN in unregister_netdevice_many_notify().

To build the series and run its KUnit suite and the existing amt.sh
selftest, fetch this git branch:

  https://github.com/Blockcast/linux.git amt-offload-rfc-v1

It carries v7.1, the eight series, this RFC and a copy of that fix,
rebased onto this series, in that order.

IFLA_AMT_OFFLOAD_MODE is 16 on this base, after the seven attributes
those series add. None of those attributes is upstream, so it will be
renumbered to follow whatever is accepted. An iproute2 patch (ip link
... offload {software|auto|required}) is held until the uapi is
accepted. The patch 8 selftest skips when ip lacks the offload
keyword.

On that branch, under KASAN and lockdep, amt_offload.sh passes all 11
cases, amt.sh all 5 and the amt KUnit suite all 29, with no splat. The
ip came from our held iproute2 patches, the offload one renumbered for
this base (IFLA_AMT_OFFLOAD_MODE = 16); we can send them on request.

Testing: on this base, every patch builds with W=1 and the amt KUnit
suite (the 3 existing cases plus the 26 new ones) passes under UML
with CONFIG_IPV6=y and =n. net-next has no amt KUnit suite: the suite
and its 3 existing cases come from the unposted series that has the
relay send host reports upstream.

Omar Ramadan (9):
  amt: add the relay replication offload provider header
  amt: offload provider registry and lower-device lifecycle
  amt: offload group object, desired state and reconciler
  amt: offload TX handoff, ingress punt rule and counters
  amt: add IFLA_AMT_OFFLOAD_MODE
  amt: KUnit cases for the offload contract
  netdevsim: add a TX reference provider for AMT relay offload
  selftests: net: add amt_offload.sh for AMT relay offload
  MAINTAINERS: amt: cover the offload header and netdevsim provider

 MAINTAINERS                                |    2 +
 drivers/net/Kconfig                        |    1 +
 drivers/net/amt.c                          | 5036 +++++++++++++++++---
 drivers/net/netdevsim/Makefile             |    4 +
 drivers/net/netdevsim/amt.c                |  600 +++
 drivers/net/netdevsim/dev.c                |   68 +
 drivers/net/netdevsim/health.c             |   28 +-
 drivers/net/netdevsim/netdev.c             |   19 +-
 drivers/net/netdevsim/netdevsim.h          |   27 +
 include/net/amt.h                          |   72 +
 include/net/amt_offload.h                  |  353 ++
 include/uapi/linux/amt.h                   |   27 +
 tools/testing/selftests/net/Makefile       |    1 +
 tools/testing/selftests/net/amt_offload.sh |  608 +++
 tools/testing/selftests/net/config         |    2 +
 15 files changed, 6214 insertions(+), 634 deletions(-)
 create mode 100644 drivers/net/netdevsim/amt.c
 create mode 100644 include/net/amt_offload.h
 create mode 100755 tools/testing/selftests/net/amt_offload.sh

-- 
2.43.0

