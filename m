Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA3606A31C
	for <intel-wired-lan@archiver.kernel.org>; Mon, 16 Nov 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=d+uEk0sV;
	dkim=pass (2048-bit key, unprotected) header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256 header.s=sig1 header.b=BFJZkQ+L
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B7704405AB;
	Mon, 16 Nov 2026 16:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qQk6iJDbW8Ho; Mon, 16 Nov 2026 16:31:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1467F405C5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846705;
	b=n/u9wgkM1e99w8MFwbQ56zh7SR5XFsToaPRwAvS18DZCL6wKs5NS/AIz87MeV9B5RftF
	 ptseiJ5U7OFGD9r84j1oYFe0oGoUDSrzUowE2cgYl246GNVvqKUBWrhOKKKLE8f0M1wr3
	 NeER9IBY4aef8JYcI/3TNoqVi7CeLfOkzr+4Kfci3s2Kgi0mKtT8U4vakaOoSagdQmK8D
	 ZqKtmpiqQU1FbEuRmuu44ULdkp85wXsN+bdFph2s7mS/BwY3S4RrIFgx3XNYGhJ6wFb1D
	 z/ccPVTlAxJv10OUl1RgIyG/CoODHNA6ZZrPblVSYTt/heNiHu+bwRck2ab6wW+LYqw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lN6lv10nb8Hj9ZoBc4u2NsxzTta/2A4Lc4QtvNhDqTE=;
	b=fxuvkvy8gXIQHdezwTtTlObrUvyJlaervzcYZDsDhTzdHhIn64S6C5CeK23LRaT/p/wA
	 1Cf4Cu4mfwj9iaF/2lvZf7mSwms2rJXsrqiDBFDaCckr42tsRT3scbvVzN0kuDGHbT1jg
	 okjK540YisCSg/gOPf6S+HGeGbUpr70t34AEpz7+ZsmBlbWVZmNUbFi/3D7UDuX7x1ryu
	 O+3E3aeiwQ8l9LJeA24WGpt/BvYd5CUchs/QToO0j4O3vIuWtum7Je68ED9s/LOtUgOZn
	 qad3sqx86KpWNpOZNmd6pwlJrclXHEHLOIKohVSOotK4jTotONB0sUbbA6aIeEJKhNw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794846705;
	bh=lN6lv10nb8Hj9ZoBc4u2NsxzTta/2A4Lc4QtvNhDqTE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d+uEk0sVryJoh1ztSfBPEElrLO+k/FZR9CWRk6Y0mYnx761TncTzDrxiiryUNrrtk
	 CzfroKig4m/3WmGjn2YSQrQBKkTHtVYjuMZUvCJDojrSHSlhbZUhdEwuuEsMUtFwoV
	 0QQSOICuwYVqHzk48bZMrwxF2mP/PlmM42ztgYDp3gnPyzsoetvs72jjqq8iRs96+X
	 E6RLawjA+bvz90D3S/XxthWn2tZyMdb+VeRzn5x9ZXbTznbDR/DexFUtIyfIDsqj5N
	 PfH23fV1nRF45xKbuTNrDitf+10KFD7IC85Ry12EyRTdzLC3cdSzubJZGFLkefsbt0
	 +rIRwSdHB6PNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1467F405C5;
	Mon, 16 Nov 2026 16:31:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D1BF2E5
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 18:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AE7360D80
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 18:26:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K2tGSwmQ1ILc for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Nov 2026 18:26:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5B58260D6E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=82.76.27.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=82.76.27.144;
 helo=vtj.irix.systems; envelope-from=me@andrei-z.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=andrei-z.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=andrei-z.com header.i=@andrei-z.com header.a=rsa-sha256
 header.s=sig1 header.b=BFJZkQ+L
Received: from vtj.irix.systems (vtj.irix.systems [82.76.27.144])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B58260D6E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Nov 2026 18:26:18 +0000 (UTC)
Received: from MAILGW-DELL.dell.vtj.corp.irix.systems (localhost [127.0.0.1])
 by vtj.irix.systems (Proxmox) with ESMTP id BD2061A3FE;
 Fri, 13 Nov 2026 20:26:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andrei-z.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=sig1; bh=lN6lv10nb8Hj9ZoBc4u2
 NsxzTta/2A4Lc4QtvNhDqTE=; b=BFJZkQ+LOFCpFRt8TzjHVkt13Mtf3YgnCFx8
 nkW+TVCLm3TjlTK4HLb8RhnACf0YmPBFUuJesLXZEPhKM2wA/3sea8O+sPdjoQS7
 4c7t+X7hCSKMZ2/azPGT1KST3Y5z3GcjIy3dMuKmBYR1O/BWinOr3cQuwByO4NGD
 048515s5quJOWYXfzpbbT8pblrMwoIAxuiOaSjhJXjhIltrJMV47CUeJ5oAYxa+d
 uF+rSE1lPp8hVTiQ9+b1GFkYm1l2s27jx6szyLTN5xIuQOti24X+OM3JkWwhw4jp
 J+NyTynXHPj8UT0bptionlKenmQt6Qkbs+GKkueROQQxoGgK9Q==
Received: from VTJ-MX.corp.irix.systems (unknown [10.57.36.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by vtj.irix.systems (Proxmox) with ESMTPS id 21F3D1A523;
 Fri, 13 Nov 2026 20:26:14 +0200 (EET)
Received: from workspace.corp.irix.systems (2a02:2f04:1:9c23::c) by
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 20:26:13 +0200
From: Andrei-Alexandru Bleortu <me@andrei-z.com>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [BUG] e1000e: I219 with jumbo MTU: RX CRC errors for unicast DAs
 not in the RAR (promiscuous/bridged ports)
Date: Fri, 13 Nov 2026 20:26:08 +0200
Message-ID: <20261113182608.24628-1-me@andrei-z.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <87fa6cd1-9a98-4c9b-aab3-6ac782c413fa@intel.com>
References: <87fa6cd1-9a98-4c9b-aab3-6ac782c413fa@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6) To
 VTJ-MX.corp.irix.systems (2a02:2f04:1:9c24::6)
X-Mailman-Approved-At: Mon, 16 Nov 2026 16:31:43 +0000
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

On 12/11/2026 16:21, Ruinskiy, Dima wrote:
> Would it be possible to ask you to run a few additional tests, if you
> haven't yet?

Hi Dima,

Thanks. Both tests are done, on the same two machines and kernel as
before: host 1 = OptiPlex 7060, host 2 = ProDesk 600 G5. lan0 was taken
out of OVS for the tests, so it was not promiscuous: promiscuity 0,
RCTL 0x06038422 (UPE/MPE clear), against 0x0603843A as an OVS port.
Traffic as before: 1 GiB of TCP over ssh, MSS 8948, from a 10GbE
sender, rx_crc_errors counted per GiB. Unless noted, every run
delivered the full 1 GiB, rx_errors rose by twice rx_crc_errors,
length/align stayed at 0, rx_missed_errors at ~0, and rx_smbus moved
only by its background rate.

Test 1

The upper is a macvlan with a distinct MAC on lan0.13 (a VLAN device
on lan0 that has lan0's MAC), created after lan0 was up. Its address
reaches lan0's unicast list through dev_uc_sync() ("bridge fdb show
dev lan0" lists it). Adding it did not set UPE, so it went to SHRA.

                                                  host 1     host 2
  control: DA = lan0's own MAC (RAR[0])             0          0
  d. DA = the live-added secondary                418, 418   387, 390
  e. same, after ethtool -G lan0 rx 4088            0, 0       0, 0
     (e1000e_down()/e1000e_up(), uppers stay up)
  e. same, after ip link set lan0 down; up        427, 416   394, 385
  for reference, lan0 back in OVS (promiscuous)   416, 424   395, 398

The live-added address behaves like one that is not in the RAR at all,
and a reconfiguration with the address present fixes it.

A plain down/up does not, and I believe that is down to how a
VLAN-stacked address comes back. lan0 down closes the VLAN device, and
vlan_dev_stop() unsyncs its list from lan0. On lan0 up,
e1000_configure() runs e1000e_set_rx_mode() and then e1000_setup_rctl()
before NETDEV_UP reopens the VLAN device and dev_uc_sync() writes the
address back, so it arrives live again. (The workaround runs in
e1000_setup_rctl(); my first mail said e1000_configure_rx(), which was
wrong.) A fix that refreshes the workaround only on reset would miss
this case.

Test 2

lan0's MAC changed to a locally administered address while up and not
promiscuous. The VLAN device carrying the host's IP keeps the original
MAC explicitly, so the original moved to SHRA as a secondary.

                                                  host 1     host 2
  b. DA = the new MAC, changed live               422, 423   379, 399
  c. after a reset (ethtool -G), MAC unchanged      0, 0       0, 0
  d. original MAC restored live                   nothing received
                                                  until the next reset
     after that reset                               0, 0       0, 0
  MAC set while lan0 was down, then up              0, 0       0, 0

So updating RAR[0] in e1000_set_mac() leaves the old CRC seed and the
PHY's copy in place until the next reset.

Step d is worse than CRC errors, and it reproduced every time, on both
hosts. Once the original MAC is written back into RAR[0] while the port
is up, nothing addressed to it is received on any VLAN until the next
adapter reset. A tc ingress counter on lan0 for that DA stays at 0;
rx_crc_errors, rx_errors, rx_missed_errors and rx_smbus do not move;
transmit carries on. The host's IS-IS adjacencies time out on their
hold timer. Without a reset it lasted 4 min 19 s; with the host
resetting the adapter 30 s later it lasted 26-42 s, and a second
secondary address being present made no difference. In that step the
address does two things at once: rar_set() puts it into RAR[0], and
dev_uc_del() removes it from the SHRA slot it held at the last reset,
where the PHY's copy still has it. My guess from the outside is that
the PHY matches the DA against its stale copy and crops it, and the MAC
then finds no valid entry in that slot.

If the analysis holds, the PCH_RAICC and
e1000_copy_rx_addrs_to_phy_ich8lan() refresh looks needed after every
RAR/SHRA write while the jumbo workaround is on, in e1000_set_mac() and
e1000e_write_uc_addr_list(), not only in e1000_configure(). I can test
a patch on both machines.

As before, I ran this with the help of an AI assistant (Claude); the
numbers were measured on my two machines.

Thanks,
Andrei

