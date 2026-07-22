Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F24C44536
	for <intel-wired-lan@archiver.kernel.org>; Wed, 22 Jul 2026 15:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40D4F403D6;
	Wed, 22 Jul 2026 15:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oFMRgzVtiQCp; Wed, 22 Jul 2026 15:47:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3127C40793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784735225;
	bh=rOQtYMvADZ9GLCsvMLq3axtJoWiekLX/s0A7KPeUo5A=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pJuc1yF7X80fpHZXDmwST9BvQ/zYmyV/j6+gVOq19ZSuZZrEuLLvULW2gJFr4sUI1
	 ooJmae9rif/Qp2t8o2SqtmESmdxZ1ddBgFOGhswdavUHI+o/LMLu9rPuUbuUHml4k4
	 3dZqQQQjF8ZtTSMr1Ql6Bh5VNcNS/N8N0rmTk+l/cEDBJYN5mnAsXP6jW4EYtuTW6H
	 FjbYCPtQNnPj2zMtCVMTFw4a1Z6/fc7/oA2AQKxXmuXYoTSyCQ8BBOA+iLSAGIe0d/
	 p+AcMNwQBj93dIbTfuuNn4mx4YVflpjBXIjegf8f8M7WurVYCAe1TmxrEQ5zbKOhRq
	 JGYthBdndPj7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3127C40793;
	Wed, 22 Jul 2026 15:47:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C4B58313
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 15:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AAB8860602
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 15:47:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e9JDKI3JwRVK for <intel-wired-lan@lists.osuosl.org>;
 Wed, 22 Jul 2026 15:47:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=stephen@networkplumber.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 0F214605CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F214605CF
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0F214605CF
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 15:47:01 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2cae1a3a744so95462585ad.3
 for <intel-wired-lan@lists.osuosl.org>; Wed, 22 Jul 2026 08:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784735221; x=1785340021;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rOQtYMvADZ9GLCsvMLq3axtJoWiekLX/s0A7KPeUo5A=;
 b=jhzFV+jHnWtpZvzNXj2Ua1OnvlVo6z+GIbiQx0TbcrLBNuPMdPV8Aa7wvTlPkjTz2J
 prpyDZgH7rJ2fBYXuGahKxPbEA1b7RB28F6QDto85FJxNDiQ2hXg3bXj3HeYNTujF7po
 UaprX6JCoD9NJssmyjPW9O4igK8cW1cjbV3FwUVVcR6km8mf9/XN4/U0ijxsr6Ih6SRr
 qaQJoPzxRX6q+2RJxpv4kb3hYwdCgh/j0Kjh4UlNviu5tYJJTcZOadIBI2SJ+KAQhkqb
 RWXhu4Ct3U2nK0LBrwJY/vqrjwdLX/TBkVzecA1qB4ULSUNqJ8IGWN/8ZnyIdX8DnNKZ
 WJ4Q==
X-Gm-Message-State: AOJu0Yw+Lp90vIddyy+sSTz1p3a1AJqNfZ++nui1hN4RjE0TEpxMv3k4
 dJwEc4M4FzwfRnJUMTHPZyPQNaQavhCNDJni/56brwFtPnp2DHeMJRDStI4x5J6TN3Hx5YCpi/K
 j+DSD
X-Gm-Gg: AR+sD12bjqHEUEYNZ3N7rcDT0Ek/DpTfHjtUC5oU/Ac+lVO2neZnD4U8y6rBEITnMDO
 j/+7EAmCQ3F7FZ22ZphOCKqfo10BZwGCL3oyTta4DSqaWsrytfPiMmDXena/GFmMtk5UuzVWYBF
 oMzzAb5ETAS+/iPlBhdqgBke6ERDsqTavNfmOJk9gYOw6KnDR3F+Cjp8WhbuNg5cwo5uKlvR6Vw
 WbiE3n8Du3zwu/OC/6n0Mi11jnVdcFz3gf98HPlEQhoIH3Pl2ivjS781qSiKFcvydXQLammfWvM
 Drzw3QkgSwPIT2kzQ7WmLoQwbY/4SLyblKIazk7v/NHg7jng152uEKJTUJfJvLlvgXTS+rbOzLt
 XAu1IRXBlRmNW9F7N1O8zNneMNpR2JwW2oOkGhHYS92g6I7ZfxooYY319frnS+xHNtA30IrGh/x
 W8kxC7vp6ebW9cfvS4K6jWCO7sj+ODN3YnT5Y2C2QxdMI=
X-Received: by 2002:a17:903:2986:b0:2c9:deec:f564 with SMTP id
 d9443c01a7336-2cf3485ebf1mr274192575ad.13.1784735221019; 
 Wed, 22 Jul 2026 08:47:01 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1ca3efsm12881928eec.30.2026.07.22.08.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 08:47:00 -0700 (PDT)
Date: Wed, 22 Jul 2026 08:46:55 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Cc: intel-wired-lan@lists.osuosl.org
Message-ID: <20260722084655.2d190adf@phoenix.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784735221;
 x=1785340021; darn=lists.osuosl.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rOQtYMvADZ9GLCsvMLq3axtJoWiekLX/s0A7KPeUo5A=;
 b=tELW+jzhQDU473CVjmQuUd2jgBzq08oC9kJYasN0J1fIN4p2lCkJ5M6IKW//udCw+K
 wz7KfTNr+RNh+NaMFEug1AQz4V8AvT/PuiA/HnZGWcYY9AzTQCSJojZ/UScJDfH9eomd
 sT78RexDIHPgsveKnXgDs299kp7hjTVVQXJeGUO47ulJ20l8iVd84iTsaU5Hs4HS2+Db
 P7qyiHu1NidOB54H6GKGE57XPwMl07LL+iXfsmrep0EkpjZWfZN3mxlGOOxgzf0vSLyn
 hHlL6kQJ5KKG+4bqQkJTXZCUleH8tVGovOFKhCnrKFW1nCMDbTWYr9mDOCnBATf17vvN
 R8sw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=networkplumber.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=networkplumber-org.20251104.gappssmtp.com
 header.i=@networkplumber-org.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=tELW+jzh
Subject: [Intel-wired-lan] Fw: [Bug 221750] New: igc: Intel I225 silently
 drops UDP broadcast to port 68 (DHCP) when interface is a bridge member
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Linux networking does not really use bugzilla, instead use email.

$ ./scripts/get_maintainer.pl drivers/net/ethernet/intel/igc
Tony Nguyen <anthony.l.nguyen@intel.com> (maintainer:INTEL ETHERNET DRIVERS)
Przemek Kitszel <przemyslaw.kitszel@intel.com> (maintainer:INTEL ETHERNET DRIVERS)
Andrew Lunn <andrew+netdev@lunn.ch> (maintainer:NETWORKING DRIVERS)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS)
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)


Begin forwarded message:

Date: Mon, 13 Jul 2026 16:20:22 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 221750] New: igc: Intel I225 silently drops UDP broadcast to port 68 (DHCP) when interface is a bridge member


https://bugzilla.kernel.org/show_bug.cgi?id=221750

            Bug ID: 221750
           Summary: igc: Intel I225 silently drops UDP broadcast to port
                    68 (DHCP) when interface is a bridge member
           Product: Networking
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: eslopez92@gmail.com
        Regression: No

## Description

When an Intel I225-LM NIC using the igc driver is added as a member of a Linux
bridge, UDP broadcast packets with destination port 68 (DHCP client port) are
silently dropped at the TX path. The kernel queues the packet for transmission
(visible via AF_PACKET capture on the interface showing PACKET_OUTGOING), but
the frame never appears on the physical wire.

All other UDP broadcast ports (e.g., port 9998) transmit correctly through the
same bridge, same interface, same code path. Only destination port 67/68 (DHCP)
is affected.

This breaks any DHCP server (e.g., dnsmasq) running on the bridge host, as DHCP
offers never reach clients.

### Keywords

igc, I225, bridge, DHCP, broadcast, TX drop, dnsmasq

### Kernel version

    Linux version 6.8.0-134-generic (Ubuntu 24.04)
    Also tested: 6.17.0-35-generic (Ubuntu 24.04 HWE) - same behavior

### How to reproduce

1. System: Supermicro X13SAZ-F with Intel I225-LM (PCI 8086:15f2), igc driver
2. Create a Linux bridge and enslave the igc interface:

        ip link add br-fvn type bridge
        ip link set eno1 master br-fvn
        ip addr add 172.31.0.3/16 dev br-fvn
        ip link set br-fvn up

3. Run dnsmasq as DHCP server on br-fvn:

        dnsmasq --interface=br-fvn
--dhcp-range=172.31.100.1,172.31.254.255,255.255.0.0,12h --dhcp-authoritative

4. Connect a DHCP client to eno1 (directly or via switch)
5. Observe: dnsmasq logs show DHCPDISCOVER received and DHCPOFFER sent, but the
client never receives the offer

### Verification that the bug is interface-specific

- Replacing eno1 (igc, I225-LM) with a USB ethernet adapter (r8152, RTL8153) in
the same bridge: DHCP works immediately
- Using an Intel I210 NIC (igb driver) in the same bridge on identical kernel:
DHCP works
- Sending UDP broadcast to port 9998 from the same bridge via the same igc
interface: packets arrive at client
- Sending UDP broadcast to port 68 from the same bridge via the same igc
interface: packets never arrive
- AF_PACKET raw capture on eno1 (host side) shows the DHCP offer as
PACKET_OUTGOING (type=4), confirming the kernel hands it to the driver, but the
frame never hits the wire
- Wireshark/tcpdump on the client confirms zero DHCP offers received

### Environment

    Processor: Intel Core i9-14900K
    Board: Supermicro X13SAZ-F
    NIC: Intel I225-LM (8086:15f2, subsystem 15d9:15f2)
    Driver: igc
    Firmware: 1073:8754
    Bus: 0000:01:00.0 (PCIe x1, 5.0 GT/s)
    OS: Ubuntu Core 24 (snap-based)

### Other notes

- ethtool -K br-fvn tx-checksum-ip-generic off was tested - no change
- bridge-nf-call-iptables=0 was tested - no change
- br_netfilter module unloaded - no change
- net.ipv4.ip_forward=1 was tested - no change
- No iptables, nftables, or ebtables rules present
- No eBPF/XDP programs attached
- The igb driver (Intel I210) does NOT exhibit this behavior on the same kernel

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.
