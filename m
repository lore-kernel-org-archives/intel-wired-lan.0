Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAE606A327
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Oct 2026 19:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=UWgcbWdO;
	dkim=pass (2048-bit key, unprotected) header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256 header.s=sig1 header.b=OkQM9rcG
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3714B40712;
	Tue, 27 Oct 2026 19:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wCH56wkSFx7L; Tue, 27 Oct 2026 19:57:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7086C406E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793131050;
	b=fFKnKucsw2L54jg6egH0EBP9VJPrMNB4IqIZW0+gy2f45bP3NmbM456Pr/mhYOx/Drab
	 tffuLUGzttzVcdbBSYUTyrqL7lJc7kfkWtQKqAZNBmZ4q9YG+PjU/gGdDnu5hhoYQeNsT
	 yLykq4Nr4cJLAyOxe4DW/fnIcbkNfRrxyiZalPMsGiTsa4D3ZCnq8fQgtl99HcDGjPE7m
	 CdOSwRhCuLMatxeYAUIaHDDraFOE6rYNzc70bXaOzTeGZz18CKBuW2Jj8UOaMBoYT9vN4
	 lvIsk6YHRcpnkQu9LOJ3aUnYefmcSdhWHreV7IS1IhujiNYgx9BUO7+eNYsR0aWSn1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793131050;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NOXq3GB19d77y3Iz4Ur6hSHpD6Dl4HBXAEowizutA1Q=;
	b=Yioy8moGJJIJK19fxi+4uqI7vx1hnyK9UEH5jYOoa8Y/6eB37994AQW+tYwQ89MDAkEW
	 SyVJPQC4auO/nZCB690tmKwQHrsK1lG8ReVDfs54Gdl5utjtRr8gX3eBS8K/ai30Msc1S
	 ta7NSOuZtAFkarLYo2GYLjhlnv6W0vN301FrOTxhhYjN8V+YWmR2kT2z6XINHhwQv5Vie
	 F45+eNFTQuA1hPq2/QSM2+zOeBzzJOlocWly+a3C25ITrfdK4hNKi3WEfO9Qm32anusxN
	 lAf5mk7ZpFQQpdr+Ls8DAByL2f1/VY5syVGxkun9YFH7A3UWumJS0kmRrhAhD+m62/Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793131050;
	bh=NOXq3GB19d77y3Iz4Ur6hSHpD6Dl4HBXAEowizutA1Q=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UWgcbWdOu8RaaGqVyPJPIHkrDxyR/ZYxl6kvaL9Nvyzw7xe7AWcGzZy0GghceQL/X
	 LTFHDUbvmWX5/9iREVyZBcOte0Jf5LhD4tKjaQnjH0nbnoBgEx+nI/3JxS1hyCqoMG
	 x05053nYyd3YwWjcnza/XmVGNbSJ1rlTkPC17p6T7CzLJfN3aJzwmhWkGXlRVzWWbX
	 bdqZq44tLGuuH0lR+Rv3bO3aNHCgGDbI8UkqKxAS817ZIlm7Mj0+d8LC2fkMBVbWLQ
	 j507IEEcKiHhd91J7h2gHmxIoYV3AAmc16FcvYHbdcH9IlfYX5UPoQTOHPabAcIugU
	 C5jF9o0v4+usA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7086C406E4;
	Tue, 27 Oct 2026 19:57:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D3BA579F
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 22:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B992C6069D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 22:28:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hLmaZmLFi4Sw for <intel-wired-lan@lists.osuosl.org>;
 Fri, 23 Oct 2026 22:28:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BC4236065A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=82.76.27.144
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792794511;
 b=f0gJ8MUhLKbLsyHGqYgP/0qb2IpBf5Hn3J3vSYNbIdnCK0lTEyrmOnaTn00T28994YlZ
 c7lJ8rhIY9JrrYZP5zLJh5YvYT/6qHsAt7U9SCx5U8IIsi8pZhIbU6TxwZDkyvSzrTkCE
 eHMJpqheucPreBfT1Bgbdh+GcJ/QLXoYduvzTRlUY4VY18KT5WTFsTYsMpkXqzFH9Rqn2
 13lpdmhdkJpGXB/3ate1gjTDWLyQOdUWSsWrotwWXnjZuwhBbadef/xmlvU0ybyb0wdu4
 Yudbjfkk1oQwQs1Rg9C9ZD3IYjnk+0dZ2D0cUwb4YN534f5Qbk2ODX6RUgRmCZyj0NA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792794511;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy;
 bh=NOXq3GB19d77y3Iz4Ur6hSHpD6Dl4HBXAEowizutA1Q=;
 b=i+wEDIPvLsd5magl97AsjQ9on6fv2PcJ5sB0OVivbx/DnnHqskM+RqluAwqVnVmZn6hj
 br5/PHDzp1+IspwP1N6syKlfgoS/W/40bhFXAUT11Lno9f1K35VtqaWly6irUNupEh3G/
 4P4h3lZvSojVUgvmwW26xEpqkn630Uq7IjXhrRG1zdc+r+Cpb9gNDAl1dwGq11r1oCU+Y
 zXaCqQLXDjIX0yD9AGb0AaVt3Kr8eKCpb15DzCc2daZjpXfgu/Rm77rCB2yS/4ZdykwCr
 W+ICUXDvnnGtf07B1XrQzYIbXqrEtNPLnSa1YdloM+Tf19FyckyUN8ShzC5gFZSjBeQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=andrei-z.com;
 dkim=pass header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256
 header.s=sig1 header.b=OkQM9rcG; 
 arc=none smtp.remote-ip=82.76.27.144
X-Greylist: delayed 327 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 23 Oct 2026 22:28:30 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andrei-z.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256
 header.s=sig1 header.b=OkQM9rcG
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=82.76.27.144;
 helo=vtj.irix.systems; envelope-from=me@andrei-z.com; receiver=<UNKNOWN> 
Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC4236065A
 for <intel-wired-lan@lists.osuosl.org>; Fri, 23 Oct 2026 22:28:30 +0000 (UTC)
Received: from MAILGW-HP.hp.vtj.corp.irix.systems (localhost [127.0.0.1])
 by vtj.irix.systems (Proxmox) with ESMTP id 8837923B83;
 Sat, 24 Oct 2026 01:22:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :from:from:message-id:mime-version:reply-to:subject:subject:to
 :to; s=sig1; bh=NOXq3GB19d77y3Iz4Ur6hSHpD6Dl4HBXAEowizutA1Q=; b=
 OkQM9rcGAwcKEgqE2ANE2u4tJYZSzsgzwoAaNnTKmy8DwEtir4yN9B5cJEN1hZ2i
 xUHtOgW0zJsIh30dPJa6FK63iOw/l7f/BbRiGs2EqBptI5tfZar20kqmp8Tztp3F
 aNlr+qhCrUOTYELxBq8jhgEYWB1NYOLTujqy5nOCJTXMeSVBFGnKiPCOrZM2JSA5
 weysTCGnl8mu+RXVoOguBp2VGk0L/R1sHJfWtHgIdP8d2KKcWWEGfVgy2M5QDDvm
 Nd7CFnvSX6byhfRkzhfhQnUfNcBrCgE9XQVF3eqqDrtRU7iF3Cp7QhDF4NidS4qB
 5zUfSZou5MqivXmZlOct2A==
Received: from VTJ-MX.corp.irix.systems (unknown [IPv6:2a02:2f04:1:9c24::6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by vtj.irix.systems (Proxmox) with ESMTPS id 3BC4023B37;
 Sat, 24 Oct 2026 01:22:58 +0300 (EEST)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 24 Oct 2026 01:22:57 +0300
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: <intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Vitaly Lifshits
 <vitaly.lifshits@intel.com>, Sasha Neftin <sasha.neftin@intel.com>, Dima
 Ruinskiy <dima.ruinskiy@intel.com>
Subject: [BUG] e1000e: I219 with jumbo MTU: RX CRC errors for unicast DAs not
 in the RAR (promiscuous/bridged ports)
Date: Sat, 24 Oct 2026 01:22:52 +0300
Message-ID: <20261023222252.2528909-1-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)
X-Mailman-Approved-At: Tue, 27 Oct 2026 19:57:26 +0000
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On I219-LM (8086:15bb rev 10, pch_cnp) with MTU 9000, frames addressed
to a unicast MAC that is not in the RAR fail with rx_crc_errors at
roughly 0.1% of frames (rx_errors rises by exactly twice that; the
length and alignment counters stay at 0), while the same stream
addressed to the port's own MAC is clean. A port enslaved to a bridge or
OVS is always in this state, since e1000e_set_rx_mode() skips
e1000e_write_uc_addr_list() under IFF_PROMISC.

Hardware: Dell OptiPlex 7060 (BIOS 1.32.0) and HP ProDesk 600 G5 Mini
(BIOS R22 02.24.00), both I219-LM 8086:15bb rev 10, NVM 0.5-4. Kernel
7.0.14 (Proxmox); e1000e_set_rx_mode(), e1000e_write_uc_addr_list(),
e1000_rar_set_pch_lpt() and e1000_lv_jumbo_workaround_ich8lan() are
unchanged in net-next.

Setup: lan0 (the I219) is an OVS port, so IFF_PROMISC and RCTL UPE|MPE
are set. A VLAN device on lan0 carries the host's IP with its own MAC
(different from lan0's). The sender is behind 10GbE switch ports; the
receiver's switch port is 1GbE.

Test: 1 GiB of TCP (ssh, MSS 8948) pushed into the I219 host, counting
rx_crc_errors before and after:

                                              host 1      host 2
  DA = lan0's own MAC (RAR[0])                  0, 0        0, 0     per GiB
  DA = the VLAN device's MAC (not in RAR)     438, 429    416, 417   per GiB

Workaround, confirmed on both hosts: giving the VLAN device the port's
own MAC, so the host's traffic is addressed to RAR[0], brings the same
test to 0, 0 per GiB. Frames to the MACs of bridged guests behind the
port cannot be helped that way and remain affected.

All of the following are needed. Removing any one gives 0 errors:
  - frame size: path MTU 3000/5000/7000/9000 -> 0 / 0 / 80 / ~370
  - back-to-back line rate: the same jumbo frames paced at ~1000/s -> 0;
    the same 1 GiB from a 1GbE sender through the same switch -> 0
    (only a faster ingress port drained into the 1GbE port produces
    minimum-IPG back-to-back frames)
  - a DA that is not in the RAR (table above)

Not affected (each tested, no change in the error rate): CPU C-states
(holding /dev/cpu_dma_latency at 0 -> 380/GiB), the disable-k1 private
flag, GRO, cable, switch EEE/jumbo settings. rx_missed_errors stays at
~0, so this is not an RX FIFO/descriptor overrun.

My reading of why (please correct me): the I219's PHY-MAC interconnect
runs at 1.25 Gb/s 8b/10b (datasheet section 2.2), i.e. no headroom over
1000BASE-T. e1000_lv_jumbo_workaround_ich8lan() copies the RAR into the
PHY (e1000_copy_rx_addrs_to_phy_ich8lan()), seeds PCH_RAICC(i) with
~ether_crc_le() of each RAR address and sets FFLT_DBG; the PHY register
fields described as "Crop ANM DA Jumbo" / "Filter on 1Gbps ... jumbo
fix" suggest the PHY drops the DA of known addresses to gain bandwidth
and the MAC restarts the CRC from the per-address seed. A frame whose
DA is not in that table gets no crop, and back-to-back long frames then
overrun the interconnect.

Two consequences in the driver, from reading the code:

1. Under IFF_PROMISC, secondary unicast addresses (a VLAN, macvlan or
   bridge MAC on top of the port) are never written to the RAR, so they
   never get the jumbo fix. This is the case measured above.

2. Even without promiscuous mode, e1000e_write_uc_addr_list() ->
   rar_set() writes only RAL/RAH (SHRAL/SHRAH), while PCH_RAICC and
   the PHY's copy are refreshed only in e1000_configure_rx(). An address
   added after the interface is up should have the same problem until
   the next reset or MTU change. (Not tested.)

Possible directions, if the analysis holds:
  - while the jumbo workaround is enabled, program secondary unicast
    addresses into RAR/SHRA even under IFF_PROMISC, and re-run the
    PCH_RAICC + PHY copy whenever the RAR changes;
  - for DAs that cannot be in the RAR at all (bridged guests' MACs, or
    an ME holding SHRA via FWSM.WLOCK_MAC), is there a hardware way to
    sustain line-rate jumbo for them? If not, a one-time warning when a
    jumbo MTU is combined with promiscuous mode on pch2lan+ would save
    the next person a long hunt.

I worked through this with the help of an AI assistant (Claude); the
numbers above were measured on my two machines.

I can test patches on both machines (Secure Boot is on, so that goes
through a MOK-signed module) and run further measurements if useful.

Thanks,
Andrei

