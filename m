Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E730CC982C1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 15 Sep 2026 17:18:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1580606F7;
	Tue, 15 Sep 2026 17:18:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jjmFprHmnrRq; Tue, 15 Sep 2026 17:18:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0C55B60769
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789492688;
	b=cGiaTQEPAVXVEHgckV5bsz0ij7PvVNQ84EgMIadRJ7Q3C+HjSlEnK3qjV7kt96gg5Xq/
	 iL5aNr17dmcp9S2xnv8mGVK2dtA7CvTu71Jv3/RA7XYJ4JS/snJHfcG5ajldqCV9zCwkU
	 Iomogxh2N9fKYEc6WnAbcMUVg6sWMYJLNXZkFOclbJOxMly4yVKGqw+SFbvy8PUk9mUrE
	 fyFeyAdQ8L4AkaB+T2QxuaA1C11IpgPAwKbFsDNa+C4IuM7mQRKlalyoRVo6HnNEmxvWq
	 MYIIZAh7CvvN24s4nLGM3DdzHs0uSVy1kp6H+AtRbB6BOypKrjH7q/HuagjDS4TQyDA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789492688;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
	b=RjCipqX+rxLtYI0kxRttK18xhZ+8fSYsyLssnUiBUH+RlU89F1XKO8Lo9LSdTQ3M5hix
	 /LZeDe0whKapipAdzqN4sU6kiEDN3KIeHctbq7BVlWZYpEpU8iQBIjb3KKbza+SQzWDg7
	 BoXRZF8jG27DpShQE8/HMpY+0HkOHzEjCH1Le9rLK0XyBN2Vz5KKWBiQp0wl7pve42Mp6
	 gw6eqtC5DY+WrqLBWFNSzY/0GSpgIN7ws0+Yrgv+pNwjZJmvlKCa2uWPZFNDaftHZpORh
	 RziB2X3FsYgbSeL25F6X5MLgRbkT3Ka5oDkxFBXWpnqZPxg/Q/OrOlQ6WGD8kiQ31SQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789492688;
	bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ptBy2e2LKv1sUJv5AnzR1KxZdS+PGeoqHKsZgw7Se6aH9Ll5wZ24nRl1RKYiqtscq
	 VrKU35nQoxpHmh5kjDPs5NgDor0SWyHQZBBICG61Tp26enoCcxmiRZigjmmE6yfkN8
	 VBimCEuFc46VPE470HH8jKhFyVpg8BJ1HxyImrX7QAPQm3Zp8mJo/rXm4VL3PO7Dwz
	 WPjf6vn9bozyDeMr4mkT3jbZFNR0966nsdifJ9LA/vC6Zs6uai419Aj9iiq/pI45C+
	 +ZxjMk6kzPZyWJWzIYqzza6s8l+DjV0kTKUugdjBEbySWZ87IBRRvNB3K99vrl9P7D
	 QoPaAbcLJIqdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0C55B60769;
	Tue, 15 Sep 2026 17:18:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B76A4259
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9D161400D1
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dDE6Am0zYTZk for <intel-wired-lan@lists.osuosl.org>;
 Tue, 15 Sep 2026 08:57:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A0AFF4005A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789462678;
 b=KGmGPCg/UR7JvyckSNsbatduuHi+RQPfTskRyUfqtBc+QiciSONzjnNjS3VmA6Z8KsuA
 NHgdKz2HERo0fH+fPBen/hjE5VsEj3jIPvQ4M1Y6kTDhqjSZmDPkZKKh8MHuwcgj0StMD
 fdLIjHppgKmofZLCYpQNStqhgESw7eP7b0tqq5ybKYcYDkML3egjMIUOPQdP47TZ9FKWy
 iGHurtY20hIF3/aojvUWmg2VFYGJwMmMRSGJkfAcKFkC4u6cM46kFYaKc9wDrUZlwcW2s
 xORiZrWKAXubTy1cwlZFcf+4/kfz7W6lmG21BeWLKFA6XciT4J1h/d65bfBDl3ESG+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789462678;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
 bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
 b=Bo1buIJEyRfdaBhVCYK1cXSw+gC0zniyZ+3VlTYB4MYvv2Ypysbhn7z4YnBhrNbbpFO/
 u/dZS7fyn8LCzBpcWkyvmyrss5i7hrN8VoytwtJUpxr0JBiyMBPnVENYg9jAERkyHtrWu
 wuXjvnFiH8tzmu5o3ghT9X5bUHTYGVhJ+g1gAICNUNa8LS3pCSBejJ2vATtkw/q97gM7A
 cRPGvEXWiOULpSjw/9A3dut4SYs7wXS01AWZl3E4vL1M3iB4l2bOMHudajtlLwE36GH1c
 iYgnVAmZG3Ne/gbf4C4CT/3pvzBKCO5P5PHzMjplrAzt/BcFwKCeNhSruQp48L/s0Fw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=afronta.com; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:34::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com;
 envelope-from=javier.herrera@afronta.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=afronta.com
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com
 [IPv6:2607:f8b0:4864:34::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0AFF4005A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 08:57:58 +0000 (UTC)
Received: by mail-qk2-x11.google.com with SMTP id
 d75a77b69052e-530fa0716f6so28179711cf.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 15 Sep 2026 01:57:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789462677; cv=none;
 d=google.com; s=arc-20260327;
 b=PYpqVtPYaS9EhQvp9NHW3MLfecoc4KLTBqVijTpeYIwuuiroatjNZ3qe7n7KBOy7Qq
 T5Ht4IvqxpiXXrqO3Sv/nke21j4PbFalOglygnQ4O61OlpvMzk01nimZnXMrZofguEt2
 Fjdw6D66Gia1JoXyKKx2FtdmlvBb58MgFt7yD2wc8fGtrqPNSYK28Vzsu+qx12XGFl7e
 F0yAW/BnK/tdwvQ/kYKtYIaTeP7bJNdA9nNNodMkO2bVFqhcug0eSDiAkgqbkOWF6Mr9
 TrtCHquqUpKlnzaXUQ3rdn5n0z2TpwNx5NapUWsGfCIQIGpEGNxPcvvQX/jGhyvJdgq5
 vRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
 fh=v7mt88KtZ+XdUNRxHb4uOZZevvFpQJmfu7BAmkEfB3Q=;
 b=WjfvqZyKEfZcSm7rNJRGhhmiH9Ei2b8EogSCp677zxla7sZRaiu6FSKqv8B9RaRdsM
 ULaxI0dlPN7QdHi9pX9MJooihY3dEQoKhtX9oU+sNTSkbECFVBF5rQC6FGfWniVyj7zA
 sseaguIS3m6itXeyWN34K7JLDEJE04iz33SNB7inP0MCqVE39xpM/yGRDYsEDI/Yhw1V
 r0o7QB+vLEqAnST1YtWgnpos59nA3ZFNFe51NwTRo3ilpPEBI8NuJbwSU6SWKBLWJOe8
 NjW+9vVQNdf/A9WoSz77OjJ20INK6oav3pzK4RPzj8mPys1dVZZVb7Jcu1v8pJVOh/PL
 bEhw==; darn=lists.osuosl.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=afronta.com; s=google; t=1789462677; x=1790067477; darn=lists.osuosl.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
 b=fbhmnmwN8SzqvmQusvqNe0jXjRa9TwcKiBIwOKqMMKf/gYiGnmSa50nHi55jlFciiN
 XBGZomRzw45ScUCd6355i0sByyczxUaDYCjRksRt3K98jGTxTGjTg/lOLmKbFU7GEQrI
 Rzxj0RsO1kPKzjPu/iIXHiDFpEZ6/8L6U7jHUawuDmDv3Ubuu45gBgukRp7BvXLLiAMq
 Hp4efbedyKI34DMROgxG/WEoAM7vFmIqyktEcqnfwPgJ+8G6I2vN//T53VvOv998wN7o
 lEiguv8Vjmvr7JtFFfwuOzOGxL48wlZfrk9RBKw5X9RL++NC6sWtqlPUYg+p+QKfeZi8
 0xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789462677; x=1790067477;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lhidRH+9Pkcz5W8FSzL02l8b5bot/SDbfN4RFTRjNFY=;
 b=LbrDPGwskU8ZcqDZWgrMkr8Iv1uGNACdJ6PnnQyOCM5tICEYSMnrQS5KDTzdpwpd1K
 bpm5NDlo/Z1ywwyOrN6U9l1wcvSs8ssyp9e+cudv9imHc9KW0S4qxBI5iuNj38RXS48z
 kmhWx9BATQssVTCY/oQnt1qyKmTiJftexz6yUZP7hV9P/AGDcj/6VGhooIfrhUjhf6yR
 ylTfJlSOOWXTXXyfgCgjHkYxTyP5wxwyOss5rmrlZW4q81WSZkfZ0RfmgwAN/AOVgF8I
 UlAC/cipn9aQ919xJaB8pjLHgPufydHma1QA4PP8h7eLqDA4tPv9U3l7tOBf/5ghGJwJ
 g8Zg==
X-Gm-Message-State: AFuF++lVtLhM++eY4noY/Sm2hm+4wQ6Grs+Vsd+MWJJvE9OwSGpgHCsh
 wVjKx2/z1F6aJwHkDW4+HbvD0euG9zRP5LWAajbv5hgF/jZItOOkOkQJGWdbldPvxWVIOOGUeWb
 khm40Aivno/+qelCOZmzVuLg9oAHVN+Pk5wdC0r9HvwSvbOJXuolB5Wg=
X-Gm-Gg: AYBFou0y7acNgdnsvyEN7cTtlRByRutTtW5T765+BguEGGg7UBVJAAF7QvzQuXPbI/j
 MYVzkDXwV6UBAuaVJw+MJVKQ0jJzxYyRb8nWKVJZ1m5D3jlvQeBD7rRbu+djXbVMSxMek2YOmA1
 8h7pJCwxLkVF470SI3g/pzHu+pJII91gFfB2jY0/7kxk97mRiseQg4mv7KASvfuaEe5Qwu8gjN1
 8prVcxEaXCgWygo41co5dNbevmpqX5970aNByVBD7t6s89AQ9OuEQmo0Qf3/XhAQ3bZRnVE7eJO
 1sIJrUgDsZDVVDArCPJEwdtCI5+4VzFW/ZVSnyxWyF0qkSkhwiwGMfoJtPiSfxcNJNavoxemLru
 1VK4t0OvXZw==
X-Received: by 2002:a05:622a:15c5:b0:530:f729:d7af with SMTP id
 d75a77b69052e-5310d093675mr86900221cf.54.1789462676763; Tue, 15 Sep 2026
 01:57:56 -0700 (PDT)
MIME-Version: 1.0
From: Javier Herrera <javier.herrera@afronta.com>
Date: Tue, 15 Sep 2026 10:57:45 +0200
X-Gm-Features: AcwNN1Xje16APL8FB5kW-5dTK80nHClMRqtoCTZOipRNVUfKOw5E0o2_Qmwv9rs
Message-ID: <CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com>
Subject: [REGRESSION] e1000e: heavy packet loss on Lenovo ThinkPad P14s Gen 5
 (I219-LM, Meteor Lake) after K1 re-enable; fixed by disable-k1
To: intel-wired-lan@lists.osuosl.org
Cc: dima.ruinskiy@intel.com, vitaly.lifshits@intel.com, 
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
 netdev@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 15 Sep 2026 17:17:37 +0000
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

Hi,

Since commit 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and
re-enable K1 on Meteor Lake") the integrated I219-LM in a Lenovo ThinkPad
P14s Gen 5 (Intel variant, Core Ultra 9 185H) shows constant packet loss
and erratic latency on the wired link. Wi-Fi and a USB-C RTL8152 adapter on
the same cable, switch and router are fine, so the network itself is not
the problem.

Setting the private flag "disable-k1" fixes it immediately, so this looks
like another system where the PLL clock gate reconfiguration is not enough
and the DMI quirk table introduced by that commit should be extended.

System
------
  Laptop:          Lenovo ThinkPad P14s Gen 5 (Intel)
  DMI sys_vendor:  LENOVO
  DMI product_name:    21G2CTO1WW
  DMI product_version: ThinkPad P14s Gen 5
  DMI board_name:  21G2CTO1WW
  BIOS:            R2DET43W (1.28), 2026-06-22
  CPU:             Intel(R) Core(TM) Ultra 9 185H (Meteor Lake)
  NIC:             00:1f.6 Ethernet Connection (18) I219-LM [8086:550a] (rev 20)
  dmesg:           MAC: 16, PHY: 12, PBA No: FFFFFF-0FF
  Kernel:          7.2.3-arch1-3 (Arch Linux)
  e1000e:          version 7.2.3-arch1-3, firmware-version 1.1-4
  Link:            1000 Mbps Full Duplex, Flow Control: Rx/Tx
  Link partner:    consumer GbE switch/router at 192.168.10.1

Reproduction
------------
Plug the cable and ping the default gateway on the LAN. No suspend/resume
involved, machine freshly booted and on AC power. Nothing e1000e-related in
dmesg apart from the link up/down messages; no "Hardware Unit Hang".

Default (K1 enabled):

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 18 received, 40% packet loss, time 29734ms
  rtt min/avg/max/mdev = 0.211/0.315/0.384/0.046 ms

The lost packets are spread over the run (seq 6, 8, 9, 11, 13, 14, 16, 19,
20, 24, 25, 30), not a single burst. DHCP on this link also takes 1-2
minutes to get a lease, consistent with incoming packets being dropped.

With K1 disabled at runtime:

  # ethtool --set-priv-flags enp0s31f6 disable-k1 on
  $ ethtool --show-priv-flags enp0s31f6
  Private flags for enp0s31f6:
  s0ix-enabled: on
  disable-k1  : on

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 30 received, 0% packet loss, time 29713ms
  rtt min/avg/max/mdev = 0.169/0.251/0.468/0.054 ms

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 30 received, 0% packet loss, time 29677ms
  rtt min/avg/max/mdev = 0.101/0.222/0.360/0.064 ms

The result is stable across repeated runs and survives link down/up. I am
currently working around it with a udev rule that sets the flag on device
add.

Suggested change
----------------
Add the machine to disable_k1_list. Lenovo encodes the model in
DMI_PRODUCT_VERSION (product_name is the per-configuration machine type
21G2CTO1WW), so matching on that is more robust:

{
.ident = "Lenovo ThinkPad P14s Gen 5",
.matches = {
DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
},
},

Only the Intel variant (machine types 21G2/21G3) has an I219-LM, so the
match cannot hit the AMD version of the same model.

I am happy to test patches or collect more data (register dumps, ethtool
-S, different link partners) if useful.

#regzbot introduced: 578294b8b60d

Thanks,
Javier Herrera
