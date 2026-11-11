Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B46606A330
	for <intel-wired-lan@archiver.kernel.org>; Wed, 11 Nov 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=I3AW3xvE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OYG/fM8T;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46A20813AA;
	Wed, 11 Nov 2026 16:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VGbN3U0V4yaT; Wed, 11 Nov 2026 16:40:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 562AC813AB
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794415240;
	b=ES8Jdv0Lrkm16ZSMx6h9bCA9/9KQyGRrJcpKIQRRw/yl/4cqsFaOQOg2Vw29s2p6DiY9
	 W9OeLHJ0ZSHH1pP8kDtbhHf7zSfEZvNY6L8oFUqd1pAFa3Jyk6wzxr5YPVwXcqiUDGm28
	 0zElzQKJbNdRlRo0Ex7WhJyvRsWmXlzSpzH3QTg6uZGir1Cugmq6ggbx4L+ts5gUqeSER
	 2/8oDHknMUvp6M0GW002pU2dJMo79gPrwn9QosgJFVdrchL3pplNFLji5hKwo+oO8t83R
	 G5kdJSIvPZrSqVrf/gOUQ66XXplhn2PtVRkykQy6pClmZgRPqNeAvSIuVIWycWugtHQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794415240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
	b=LV4R0ITnviT/iO1JmyfAYX5v9d6FNtdanlQuVocDmgczxQBKTTg8Vc9+Yw3mPL5mwIjL
	 9UqDMkDJIdYPdSKHxSJunQ4os8vX9vkXLKhLVGS2EVQjdkNUynb60IzPVhrvwzoU7Whhq
	 cwu3Blnihsrmum/+bg1Z1GgXe8yFNddovtwpYhvdA7hw4aq4auq5IhJM4zcW6s65Tz/Q2
	 1oqGaSKoGNZ18WXtNb/XuaDmQZrWteYrYpw2H4Zatgg84DLtwiBr31SrSJK+nB9EKX1CY
	 SpCzOcUnuqlNMn6sr6BG3tdkplhDpySlV8wPW11oVzImdaMONI9Kw9NPF3IWg0t5IQw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="OYG/fM8T";
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794415240;
	bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I3AW3xvEFf0YzdCdIVoohWc7XERTdOE5yVPjcLEKW9zooCYR0jwX75nwcbnAvm4OE
	 PfvKemYBkcx1H9/4DoAll9LjGfVgHT1au55MdqLsFPPjpkgvBdcRIYBx+IuLEQEr/O
	 YYR3tMr2duNzoZBQEGdVDnjniWQoiRHR2Kaj47lWVr8UCATbe43musJXfKJXS2dfcu
	 kjl73NRmOZKGIAiBOmkseS+dSMI+dUmwWhfGxkp47jgwebh+fprBv5WQ4GLn6IQiTX
	 oRkzmzrw0m2qGBwEU1x4utmqNwFEKUiVSLxzy6GdyP5qV0AEZ/PRfj5QLYu/xKwIDH
	 lYJK9ejkSNNdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 562AC813AB;
	Wed, 11 Nov 2026 16:40:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E39FF2FE
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C976A813AB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LNf40LOCHTLr for <intel-wired-lan@lists.osuosl.org>;
 Wed, 11 Nov 2026 16:40:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6B1AA813AA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BqyjPjMu; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OYG/fM8T; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BqyjPjMu; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BqyjPjMu; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BqyjPjMu
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B1AA813AA
 for <intel-wired-lan@lists.osuosl.org>; Wed, 11 Nov 2026 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
 b=BqyjPjMuSSu8swQenrlX6duVrwPVNgEEvV3tQ2YwO/lxXdJyoxCyJ73tDIvjVtgUKR4XZG
 Tv84sgsY79AXrwzFJKGWblyl3DrDumOIUahobUMFoWm/fSK/Q/h4vNkBipteJmOV4+AKyj
 04eTLCiwZri+ffsc6baUUnhaSSDelOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
 b=BqyjPjMuSSu8swQenrlX6duVrwPVNgEEvV3tQ2YwO/lxXdJyoxCyJ73tDIvjVtgUKR4XZG
 Tv84sgsY79AXrwzFJKGWblyl3DrDumOIUahobUMFoWm/fSK/Q/h4vNkBipteJmOV4+AKyj
 04eTLCiwZri+ffsc6baUUnhaSSDelOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
 b=OYG/fM8TXwqUDmH3xf79Rky5+7DZ93OEdYWuMIkc7tsMBiJYcMdkHU6bJeISZz+B+p0oXb
 9mOwe2Vl8r9/19dpXq249oa/1UYEQ1Yt+otEgn1qSIQiCV2NLNpoUqRSzqBSCvMffkaldg
 1HemyxaTf9yYkHxo5pVAAW5TvEkov/Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
 b=BqyjPjMuSSu8swQenrlX6duVrwPVNgEEvV3tQ2YwO/lxXdJyoxCyJ73tDIvjVtgUKR4XZG
 Tv84sgsY79AXrwzFJKGWblyl3DrDumOIUahobUMFoWm/fSK/Q/h4vNkBipteJmOV4+AKyj
 04eTLCiwZri+ffsc6baUUnhaSSDelOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
 b=BqyjPjMuSSu8swQenrlX6duVrwPVNgEEvV3tQ2YwO/lxXdJyoxCyJ73tDIvjVtgUKR4XZG
 Tv84sgsY79AXrwzFJKGWblyl3DrDumOIUahobUMFoWm/fSK/Q/h4vNkBipteJmOV4+AKyj
 04eTLCiwZri+ffsc6baUUnhaSSDelOI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794415235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NShsA9MlHZ9FwmFpGhwUtm1mborr1aSrRmco7ok7QSA=;
 b=BqyjPjMuSSu8swQenrlX6duVrwPVNgEEvV3tQ2YwO/lxXdJyoxCyJ73tDIvjVtgUKR4XZG
 Tv84sgsY79AXrwzFJKGWblyl3DrDumOIUahobUMFoWm/fSK/Q/h4vNkBipteJmOV4+AKyj
 04eTLCiwZri+ffsc6baUUnhaSSDelOI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-nIjXMsnDO9OwQ5BZKCeBBw-1; Wed,
 11 Nov 2026 11:40:32 -0500
X-MC-Unique: nIjXMsnDO9OwQ5BZKCeBBw-1
X-Mimecast-MFC-AGG-ID: nIjXMsnDO9OwQ5BZKCeBBw_1794415229
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A797C1955BC4; Wed, 11 Nov 2026 16:40:28 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40D41421; Wed, 11 Nov 2026 16:40:22 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Min Li <min.li@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Grzegorz Nitka <grzegorz.nitka@intel.com>,
 Karol Kolacinski <karol.kolacinski@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 0/9] dpll: do not serialize driver callbacks under
 global dpll_lock
Date: Wed, 11 Nov 2026 17:40:11 +0100
Message-ID: <20261111164021.273409-1-ivecera@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: wwIdnxiPWQbUrz_K5XNbhEDAG_yLHXYKD4vpbVC17S4_1794415229
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dpll_lock protects topology and object lifetime, but it also serializes
all driver callbacks in the system, so one slow device stalls every other
DPLL device, whichever driver it belongs to. mlx5 callbacks issue firmware
commands with a 60 s default timeout, and zl3073x callbacks can wait
seconds on a driver lock held across ToD writes and phase steps.

Make dpll_lock an rwsem for topology and lifetime and add a mutex per
domain for callbacks. A domain is all objects created with one (module,
clock_id), in practice one chip or card, so channels of one chip stay
serialized as drivers expect, and they still block each other. Device
callbacks run under the domain of the device, pin callbacks under the
domain of the pin, whichever driver registered them. Only one domain lock
is ever held, so domains have no lock order. A lock per device would not
work, because pins are N:M with devices and callbacks notify sibling
channels.

The driver API does not change, but a callback can now notify only
objects of its own domain. Patch 1 changes the one in-tree callback that
does not follow this.

Registrations across domains exist in the tree only on E825, where ice
registers fwnode pins of an external DPLL with its TXC and TSPLL DPLLs.
These callbacks are no longer serialized with TXC and TSPLL, they rely on
pf->dplls.lock, and requests about these pins wait while the external
DPLL is busy. Intel folks, please check that this is fine.

Each complex of a dual complex E825 has its own DSN and so its own
domain, but both use the CGU of complex 0. The lock for the registers
they share is in a fix sent to net [1], which this series needs. Without
it a test lost updates of them.

Patch 4 is the only patch that lets callbacks run concurrently. Patch 5
adds KUnit tests. I also tested each commit with a mock driver and YNL in
QEMU, with lockdep and KASAN, and the tip with lockdep on two systems:

- A board with ZL30732A: every notification the driver sends from a
  callback, concurrent traffic with PTP, driver reload and rebind.
- GNR-D with dual complex E825 and zl3073x: callbacks of the pins shared
  by both drivers, TX clock switches, RCLK pins of both complexes, a port
  going down and up, and both drivers unloaded and loaded in either order
  under load.

mlx5 is build tested only.

On GNR-D, with ToD writes running on the zl3073x and requests waiting for
them, requests to an ice DPLL took 1448 ms in median and 3.9 s at most
before this series, 0.2 ms and 0.3 ms with it, the same as when idle.
Requests about the pins shared by both drivers still wait for the zl3073x.

Changes in v2:
- Dropped "ice: dpll: serialize changes of the SyncE CGU registers", sent
  to net with a fix of the SyncE divider [1]
- Addressed the Sashiko review, see the patches for details
- Added Reviewed-by tags from Petr

v1: https://lore.kernel.org/netdev/20261106121005.1327603-1-ivecera@redhat.com/

[1] https://lore.kernel.org/netdev/20261110094350.184185-1-ivecera@redhat.com/

Ivan Vecera (9):
  ice: dpll: notify TSPLL lock status from the periodic work only
  dpll: add domain object
  dpll: take domain locks around driver callbacks
  dpll: convert dpll_lock to rwsem
  dpll: add KUnit tests for core locking
  dpll: reject measured_freq_get for foreign and on-pin registrations
  dpll: zl3073x: update locking comments
  ice: dpll: update locking comments
  dpll: document locking rules

 Documentation/driver-api/dpll.rst         |   48 +
 drivers/dpll/.kunitconfig                 |    5 +
 drivers/dpll/Kconfig                      |   13 +
 drivers/dpll/Makefile                     |    1 +
 drivers/dpll/dpll_core.c                  |  204 ++-
 drivers/dpll/dpll_core.h                  |   34 +-
 drivers/dpll/dpll_core_kunit.c            | 1580 +++++++++++++++++++++
 drivers/dpll/dpll_netlink.c               |  117 +-
 drivers/dpll/zl3073x/dpll.c               |    9 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c |   24 +-
 drivers/net/ethernet/intel/ice/ice_dpll.h |    5 +
 11 files changed, 1919 insertions(+), 121 deletions(-)
 create mode 100644 drivers/dpll/.kunitconfig
 create mode 100644 drivers/dpll/dpll_core_kunit.c


base-commit: 368fbf5d82da9ebce309449c74fc0b128f7d0219
-- 
2.56.0

