Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94D606A321
	for <intel-wired-lan@archiver.kernel.org>; Thu, 26 Nov 2026 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=AsL/msGS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGiNmyIa
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C4977409E4;
	Thu, 26 Nov 2026 20:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lgt5Tj-19T0L; Thu, 26 Nov 2026 20:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 97348409EB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795725176;
	b=ehada5MMJWX0mW40s1yBBiUMPqlGKAXqBdcWX7iB/qv0F6a4vVapf0623+bwugCmJ0iX
	 f4kE8w86xzTa/r8FZMMd3TjuLug0sB4i+T9E5ix6bZ2pvskXQQeAnTANgKTLvQaH95iiC
	 HGLKx8wwg1gOqt4PKuaypd5VS1DgAJEz1kukTi0kRhHx8Ugw5YchN2zUrchahNU3yaVJi
	 vKWQ+WR9ekMC+0hSQDZzW0BWBeUjeJ3rGW7SD39BhxwPSkBM0BGsWQ2ZYvWWRrWlbdWWl
	 6vEdY5LBjLxr9T4f5OlgQakqj0MASbn5MIWgBvkYDdfnSrpyvtQgkX8YvI/yNn4CRwg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795725176;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hteBlJecuyLDEt+A2GyVPbp3T0CryFhITZ+ug8ST7OQ=;
	b=QG43bJP/A1d4FpQmkwf5R72Ys1BtA0qSTMC/Zz39/zMyZd+9ypiYReA3OUVc5VI3WOal
	 HjPukMDnORlFkZPa3+YRP66N0YCTgtsMPx5wIFPD8ijtrw//QQ/ayrbjWkAESxVIkgLeK
	 JZxzRi3ivfIcMErJdAuRgbTtqGN0SYPcnmOJ93GTp0vhLpeCdNOtg69Ovfzvp3wp7AI9Z
	 jcoH+lQhwceLIUKaqcwXF5/8F+lLqM8GfeQYtj2Lv0srHgM1wwPpav1onPJF8urDNmIw2
	 VEQQ1G+dq5bzfxQcupVQGT9hKdn/Kc2mTT7HpZ+u1/EeCJFnxhc8bZAgT5AVJFyesRw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGiNmyIa;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795725176;
	bh=hteBlJecuyLDEt+A2GyVPbp3T0CryFhITZ+ug8ST7OQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AsL/msGScJOMp5FlEz+937kDLkW3DeqfyGgIAvPzVIrgKoFlv0sav910Neib878Eh
	 5rRwTmHo9Lvdi7/LljrXEEMSS4skLcprZ13BqAq67I1riL/BmN0b3y21QnM11z+43h
	 bnlu/YHnjyq/4TttLpAxp9T/InUA2ti6XgBKyV+sBWCiDJv2xPlLUwStuLxRavuZiL
	 56quBsTVnY8DVpVKJjU/idu2R9pDrnOunkDS2PyAW3ZKpfQVo0Th/NC4ObU/BZCZWV
	 j5Moooq0xjJ+N1mKH+QiVg4D0M0GOtWHZVLNWjvkr6u+HncknIU+ShOhHJ3XVO074X
	 Vsl6cjdtcjkxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 97348409EB;
	Thu, 26 Nov 2026 20:32:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7493D1AB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A7A5409EB
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:32:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5q2J_JMvIbV1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 26 Nov 2026 20:32:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8B689409E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=hGiNmyIa
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B689409E4
 for <intel-wired-lan@lists.osuosl.org>; Thu, 26 Nov 2026 20:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795725171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hteBlJecuyLDEt+A2GyVPbp3T0CryFhITZ+ug8ST7OQ=;
 b=hGiNmyIac95YZaAyN2AghXWa7/ttR8aVMwuOeR/IcAQIt+nTnRaITi8cFKMDPa3MUV8BVA
 RXJK+zNhnXIDeFIk9jWzL6UUV+cJvA86H6dyHufdpL7BxGD4UrwP8NZl1o0dT7OjgeJmKc
 fbxHcAy+f1kZAH9PkKbsQa+RUrULVN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-oHFUvPaKNC2yfKu9wYyJ3Q-1; Thu,
 26 Nov 2026 20:32:44 +0000
X-MC-Unique: oHFUvPaKNC2yfKu9wYyJ3Q-1
X-Mimecast-MFC-AGG-ID: oHFUvPaKNC2yfKu9wYyJ3Q_1795725161
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CA771955F3A; Thu, 26 Nov 2026 20:32:40 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E3B21800286; Thu, 26 Nov 2026 20:32:32 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Min Li <min.li@microchip.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH RFC net-next 00/19] dpll: single-owner pins,
 board wiring as pin links
Date: Thu, 26 Nov 2026 21:32:12 +0100
Message-ID: <20261126203231.934632-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: FKKHfhztViO4Ttd14km9uVI_H_Pc-IO-KMbp7HSrrz0_1795725161
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sorry for the size, I know 19 patches is over the netdev limit of 15.
For the RFC I kept each step in its own patch, so all the changes are
easy to see one by one. The final series will squash some of them.

In the thread on "dpll: do not serialize driver callbacks under global
dpll_lock" [1], Jakub was not convinced: relations between DPLL objects
are hard to follow, objects of one driver plug into objects of another,
and the driver API should be much more "dummy-proof" [2]. Vadim agreed
and asked to step back, because the subsystem was shaped to model one
NIC family and is getting more complex for its next generation [3].
Jiri agreed with Vadim [4]. This RFC removes the sharing of pin objects
between drivers instead of picking a lock scheme for it.

Problems in DPLL today
Model:
- One pin, two owners: on E825, ice registers zl3073x output pins with
  its DPLLs (c191b319f208) and hangs its recovered clock pins under
  zl3073x inputs, so one request runs callbacks of two drivers.
- Per-registration needs on one object: a state change bypass for
  firmware node pins (521b6d5de08d), zl3073x inputs typed MUX although
  the mux is in the NIC, one pin that is both an output and an input.
Driver API:
- ice waits for the zl3073x pins on a notifier chain (2be467588d6b) and
  holds references to them, so probe order and lifetime are its job.
- Core code exists only for that: the owner check exception, the
  notifier source id (0bf47f722fa9), the owner ref selection
  (2c1bd78dc8e2, 84e85c325e5e) and a cached module name.
- Callbacks run under dpll_lock and must use __dpll_*_change_ntf(),
  notifications go out without driver locks. Only comments say so.
Locking:
- dpll_lock serializes every callback of every driver. With a dual NAC
  E825 and a ZL80132B, ice DPLL requests during zl3073x ToD writes took
  a median of 1448 ms, at most 3.9 s (idle 0.1 ms). zl3073x is narrowing
  its waits, but callbacks that wait for hardware stay (planned zl3073x
  resync, up to 1 s; mlx5 commands, 60 s timeout).
- No lock scheme fits pins shared between drivers. Options A-E from the
  thread each cost something, from callbacks invisible to lockdep (A)
  to one domain for everything connected, the global lock again (D).
Fragility: 13 fixes in a year in the (un)register, on-pin and
notification paths, e.g. 32239d600236, df0ba51ccf87, 1a2292101c0d.

All of these come from one dpll_pin being both a pad of a chip and a
wire on the board, so two drivers end up sharing one object.

Proposal
- I1: a pin is registered only with DPLLs and parent pins of its owner,
  the module and clock_id it was created with. The core enforces it.
- I2: so a request about an object runs only its owner's callbacks.
- I3: a wire between pins of two devices is a link. The driver of one
  end adds it to its own pin with dpll_pin_link_add() and names the
  other end by its firmware node, so no driver holds a pin of another.
- I4: a link is only a wire, with no state and no callbacks. pin-get
  reports DPLL_A_PIN_LINK with the peer id for both pins while both are
  registered, the peer is notified when one of them comes or goes.
On E825 this covers the TX reference (zl3073x output to the ice TXC
DPLL), the time reference (zl3073x output to the ice TSPLL) and the
recovered clock crossbar: two ice mux devices, one per CGU output, with
the port pins as inputs and outputs linked with zl3073x inputs.

This removes the model and driver API problems and options A-E. The
code of one fix is gone, the cross-owner cases behind other fixes cannot
happen. The stall and unenforced rules stay, per-owner locks become
possible. Not addressed: a netdev names only its recovered clock pin.

For a driver
TX reference and recovered clock, before and after (the first PF of the
adapter creates the muxes):

  pin = fwnode_dpll_pin_find(fwnode, &tracker); /* or wait for it */
  dpll_pin_register(txc_dpll, pin, &txclk_ops, priv);
  dpll_pin_on_pin_register(zl_input, rclk_pin, &rclk_ops, priv);

  pin = dpll_pin_get(txc_clock_id, idx, THIS_MODULE, &prop, &tracker);
  dpll_pin_link_add(pin, fwnode);
  dpll_pin_register(txc_dpll, pin, &txclk_ops, priv);
  dpll_device_register(mux, DPLL_TYPE_GENERIC, &mux_ops, adapter_mux);
  dpll_pin_link_add(mux_out, rclk_fwnode);
  dpll_pin_register(mux, mux_out, &out_ops, adapter_mux);
  dpll_pin_register(mux, rclk_pin, &rclk_ops, priv);

For user space (ids from the GNR-D below)
The zl3073x output OUT3 (id 36) no longer lists the ice TXC DPLLs as
parents; it is linked with the EXT_SYNCE pins of the eight PFs, which
are inputs of their TXC DPLLs:

  {'id': 36, 'module-name': 'zl3073x', 'package-label': 'OUT3',
   'parent-device': [{'parent-id': 11, 'direction': 'output', ...}],
   'link': [{'id': 4}, {'id': 8}, ..., {'id': 26}]}
  {'id': 4, 'module-name': 'ice', 'board-label': 'EXT_SYNCE',
   'parent-device': [{'parent-id': 1, 'direction': 'input', ...}],
   'link': [{'id': 36}]}

The port pin of eno1np0 (id 2) had the zl3073x inputs as parent pins.
It is now an input of the muxes 2 and 3, and RCLK0 (id 0) is linked
with REF1P (id 29):

  {'id': 2, 'module-name': 'ice', 'type': 'synce-eth-port',
   'parent-device': [{'parent-id': 2, 'state': 'connected', ...},
                     {'parent-id': 3, 'state': 'disconnected', ...}]}
  {'id': 0, 'board-label': 'RCLK0', 'link': [{'id': 29}], ...}

pin-set {"id": 2, "parent-device": {"parent-id": 2, "state":
"connected"}} routes the port and disconnects the one routed before.
The clock-id of the port pin is the adapter index instead of the DSN.
The E825 pins exist without zl3073x too.

What it removes
Core: everything under driver API above, cross-owner on-pin registration
is rejected. ice: the notifier work, the firmware node parent pins and
the foreign pin references. The tolerance for a DPLL without
registrations (33f016b23a21) stays: on E810 the recovered clock pins of
the PFs without the CGU stay registered with the DPLLs of the PF with
the CGU when that PF goes first.

  core (dpll_core, dpll_netlink, dpll.h)  +224/-173
  ice                                     +727/-503
  KUnit tests and build                   +563
  docs, spec, uapi                        +69
  exported symbols 21 -> 20 (+2 for KUnit only), ops unchanged

ice grows, as the PFs of an ASIC share the muxes and the adapter
records the routing. An E825 with N ports had N+1 DPLL devices (TXC per
port, TSPLL) and 2N ice pins, now N+3 devices and 3N+3 ice pins. A mux
is not a DPLL, but the generic type is for devices outside the EEC and
PPS classes, and two driver-local devices replace two core mechanisms:
cross-owner on-pin registration and a MUX parent of another driver.

Locking series: v3 is on hold until the direction is agreed. On top of
this the rule for drivers becomes "your callbacks run under your lock",
and options A-E are not needed.

Status: W=1 build at every patch, full build, sparse, kernel-doc,
ynl-regen, htmldocs, KUnit (12 tests, UML, lockdep). Tested on a GNR-D
platform with a dual NAC E825 and a ZL80132B: links, routing of all
eight ports with notifications, the recovered clock at the zl3073x
inputs, PF reset, CORER, GLOBR, PF unbind and bind, zl3073x reload and
the TX reference; the test script and its results are in [5]. Not
tested: EMPR, and the recovered clock of the second NAC, whose ports had
no link. Prepared with the help of an AI coding assistant.

Questions
1. The E825 TX reference and recovered clock views change. Fine, or
   should netlink translate the old view?
2. Is a mux fine as a generic DPLL device that reports locked while it
   routes a port, and are N+3 DPLL devices for N ports fine?
3. The two muxes share module, clock-id and type, so device-id-get
   finds neither. Is finding them through their output pins enough?
4. The firmware still types the zl3073x inputs as MUX. Leave it?
5. The ice pin does not know the frequency on the wire. Omit it, as
   now, or read it from a firmware node property?
6. Should the locking series be rebased on top of this?

[1] https://lore.kernel.org/netdev/20261111164021.273409-1-ivecera@redhat.com/
[2] https://lore.kernel.org/netdev/20261119133851.3f25074c@kernel.org/
[3] https://lore.kernel.org/netdev/ff8b63b7-b943-444a-bd37-b6fb493b5d9f@linux.dev/
[4] https://lore.kernel.org/netdev/awMP9Gj3Xhia0ZeI@FV6GYCPJ69/
[5] https://gist.github.com/ivecera/b31f67adac6deac318719bbe0f282707

Ivan Vecera (19):
  dpll: add pin links
  dpll: report pin links
  dpll: notify linked pins when a pin is registered or unregistered
  dpll: add KUnit tests for pin links
  ice: dpll: use own pins for the TX and time references
  ice: dpll: drop the filter of notifications from own registrations
  dpll: register pins only with a DPLL of their owner
  dpll: drop the state change exception for pins with a firmware node
  dpll: drop the source clock id from pin notifications
  dpll: drop device events from the in-kernel notifier
  dpll: drop the cached module name of a pin
  ice: dpll: track the E825 recovered clock routing in the adapter
  ice: dpll: register the E825 recovered clock muxes as DPLL devices
  ice: dpll: route the E825 recovered clock through the mux devices
  dpll: register pins only with a parent pin of their owner
  dpll: drop the in-kernel notifier chain
  dpll: require a registered DPLL for pin registration
  dpll: drop the owner reference selection of pins
  dpll: add KUnit tests for the pin owner checks

 Documentation/driver-api/dpll.rst            |   53 +
 Documentation/netlink/specs/dpll.yaml        |   15 +
 drivers/dpll/.kunitconfig                    |    5 +
 drivers/dpll/Kconfig                         |   18 +
 drivers/dpll/Makefile                        |    2 +
 drivers/dpll/dpll_core.c                     |  253 ++--
 drivers/dpll/dpll_core.h                     |   20 +-
 drivers/dpll/dpll_netlink.c                  |   82 +-
 drivers/dpll/dpll_netlink.h                  |   10 +-
 drivers/dpll/tests/dpll_kunit.c              |  538 ++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c |    3 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h |   33 +
 drivers/net/ethernet/intel/ice/ice_dpll.c    | 1175 ++++++++++--------
 drivers/net/ethernet/intel/ice/ice_dpll.h    |   11 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  |    8 -
 include/linux/dpll.h                         |   32 +-
 include/uapi/linux/dpll.h                    |    1 +
 17 files changed, 1583 insertions(+), 676 deletions(-)
 create mode 100644 drivers/dpll/.kunitconfig
 create mode 100644 drivers/dpll/tests/dpll_kunit.c


base-commit: 2388bb763e323442f4dd8189238ac0c5f334c4a0
-- 
2.56.1

