Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955DBCA600B
	for <intel-wired-lan@archiver.kernel.org>; Thu,  8 Oct 2026 13:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A22240AB6;
	Thu,  8 Oct 2026 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fzl1CypQgPCm; Thu,  8 Oct 2026 13:19:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9C29240A9F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791465542;
	b=rtRsFgCLfNhDTMaz5xPiGxD6OULXiQjL0gxqYeoA6FMqjOV4+wCft1MoIva/PDevcIc7
	 J9pvL+/6bIujT5I33GN2hzsTU8FglWloBCU+v5q9fKeTOT6Bk9pQxE6wE0M859txBcioh
	 h26EYYS7Lu6ToS2LiZ7dvvgqPbQi2CFb3oDBBVHnIA/1feCNYB2liO0TrIiEF3vDuGLpA
	 Vs2ZSYgsSp5JUliI/mSB5HxJh6NhE+pb2SQ5ADMS4zJvWzsRaxx5zra6PJeY5LX2Hewg2
	 ufm52To13AhiSaRC9Mrmvez7Zje4kT3wxW9FDTANA4b1mC2yhl+HFleuWTFYEcSS5Ug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791465542;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
	b=cB3xR0Y0EP3ZNXH5GZ4GOwCS9JrWCcpcpDHYTKIoR1OpryhpraLKHSKGnyLbRcVktdAT
	 1AVuragYP1cLICHHKUTX8V9xwoV294HqVXhaD0D3OuPjuf9qn9UBSgsorE1VGDR0ZlUEM
	 c1QeecdvCzsU58XCRGzq0v5ddY4kYgQ5oBksaZEa5DLAOX4RxxJrHf6PbgrLmsaz1rExR
	 /+YLtv8KDD50h0hSnBFRKLOZEAt93s+Bbs+a4hmaFkpyaH4VjkRRoExrujqeffeOmzUbw
	 94I4d8wiOyLlFIaNEe5Tr8Y+hwSnWf1Ne+kqurIVA6bHn5FMkqtjw2+y2H8Xt6vIDcg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791465542;
	bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=J8S13l58rI1A6B1vEuE5BGS9ewAQxtdm4kRQwMrN75p13cy+qc61IQZY1qb28cBpV
	 AamhLAecmc9fsUlmbIqRU43zxod7xK0Hmjk9jjE6jZqfnUgwpl2iXCANJJHV9+AgEQ
	 /1mSygBCXJtxwejkV2xGdcsOuBfWIOI8sqGAVViFk0lHvckVlQTb5UO+5QZqqjdhIc
	 up8qtQVQiQ2gIV/mIHS++6LSm+rDKbDt3sKBqKDUjl2t35TdBk8R9oEZ7NOqA1vDo8
	 cPFJo/FZT1P3NIFuba67to/gjxBO1BmhztqtIzKA7pyBz3RjbTJvbjDISxzvxrzcOq
	 LKZ7/RpWv6heg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9C29240A9F;
	Thu,  8 Oct 2026 13:19:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EF47434E
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D4E04811DA
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:19:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k9EEjCfY79JI for <intel-wired-lan@lists.osuosl.org>;
 Thu,  8 Oct 2026 13:19:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 55862811A8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791465541;
 b=p4yqZIvCPXKNNWQ9BJPK9m56p9bNjqVD5CjBavVjL04K1JDJHc8W5/RI90q1sWJbDAvw
 APF4juW4CgikPKje9ifbgvppa7dwr2YeSqPPDh/3IU9m8+nY2zyfROqhuSKQLSrW4orPj
 DibohNNm7qd4B3dldG9Ulcq7yG6m3H8UD088G2vT4/9D8GJ6f+9fX9R4k3fie8RqjvHGi
 UnnBQkbwZQp1fsqFludp7I7Smd4wQhtPSXhuN2EzIr6bOmA5tVo6k5XPuoUp9qpYlEhbk
 DlTbA3a5OxnrKShAf0vDbWKsluyT/XQTiU5a8ul81dYIgs5dJz6uttTpi6EF23FoF+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791465541;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
 b=rCBSAFDc+PuCH7N8VFJCwVTpKlPvDIAj6eTzlcaaA2weHQZEgTNJ32PQehW44OYlRjQl
 Qz4LsoO02x+RdYyNQcuDupoXWPz4zJvgwc7K6ZOhMamJpojzPEo5QOwoqmoP1OiM2vR7P
 +SQs9KULXPCD3nhkol1xI/fNZMNxIEyS9TlvVwBcEqC5k4pQVjb7bu51XRQp4eWahx7FV
 kCmQRv6ls7eps176S8PAZkbLQzf01eERILGPEWU3CXgaMiU5zZRoEUzJsZVMJjGweWXv6
 5FMZFLUZMdEWZh21l6m8whDZTqyf1VdRNbqQa5PdBFuBhbsm+vdJo9U93LdeEjCLpJA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="eLnCGgv/"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eLnCGgv/
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55862811A8
 for <intel-wired-lan@lists.osuosl.org>; Thu,  8 Oct 2026 13:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
 b=eLnCGgv/P0swEqJZJiQQZtDQ1v2fZEn66WY1jwEDv82S6yyPDTXhRXAf8IOB4+rjIAbCER
 JQYcWPIKAnoookUt0SxIbVh/umVZLskCrlpeq5YKwZnKripySm0hARszUqhlIunsB2X9Fj
 nmaUavDDSGfuaRNzJIuzn8bwDp15s+I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-g9owIutUMzK8V_A9Fw2V1w-1; Thu, 08 Oct 2026 09:18:53 -0400
X-MC-Unique: g9owIutUMzK8V_A9Fw2V1w-1
X-Mimecast-MFC-AGG-ID: g9owIutUMzK8V_A9Fw2V1w_1791465532
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1813fea7dso24317455e9.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 08 Oct 2026 06:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465532; x=1792070332;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vtdV3wLKtPAzjm/w0DmkFenOgTDJUitz5K0GdmCiFi4=;
 b=o4L2g6+G+EqSP2S5FVZ3eEoRWXu1HSv3c8I2jEBWiIRSYJ+o77BoixfxOEPIP5TRK5
 Pz3AHdCGVDrnrBdKLe1PKauOP9JSdO4sT/26mAjyirUuvZq+/Z0TU8DfeR+sucZEnROB
 MHRYSGeIdMC8+L6UwJY2ApxQpHjbE+GVSJkJaUpsyT16AVCWiMZIdGC3XJI5v3/+Zbbq
 X+CD+f7nPjzI6uPp2kzFwydSLrKO9XLkt4/7lU43Ix6gFg+Aufs8KCh1EXbT0DdKNCBo
 e+R63HgdTz2UCh1AhE0hCIrUf1OxC+MvdWFakYhTRFrb7yHLBLCwiE3EuNM+3PhMuhLS
 iAdw==
X-Gm-Message-State: AFuF++nSovD7VqtrX4Y5/dlXp0uk9YB8Kv0xyoKm93Su01nPDElUDLNP
 3WktVD1uvR4MeHDzw3VeJ6u6Mp+/phMv9NAguL/MLjjbxzfD6uYSZeZ/Jj43izp2ngD3np5lb/Y
 1HQk4kw0txQ7HsoR5jIz8c372fTildaN7IBvgtEMXXW5iIS5CTC5DwjNxJn+ckeEsvJHK9Njjsy
 IzwKlZ7SIZsm5dImEwChnP5yUsYNFzdAxFtskYC7dOJdNla/D+9lulTw==
X-Gm-Gg: AYBFou0mPfuygXUPzZsu0bbs64g9UTX3N0rh3IDfjlta6ntsNuBk2etMz8dUCaZO6rt
 zZCa8lSsoD9dJgSwdY9BOsmVbmiLKAVwf/vUMR1v5VrsbuRIBADbMQ5Q4XBaUk2TYtgEmJDtFYv
 ulYbjIGQiwShRv9AJLTBLFXrcJOwnB6wLT3Wwwh3qV4SUN9G8cPXSrklu3sPOb8TuYz7li/f3lR
 iGBZ8n/X+flahEjkN94whPbPflp7Qzj7vSYhL/Y+U6wBu72LYToK4sFj5Lts8DLCAbS/56F+AnZ
 R6zmF5HGZfl72A1sd2nbY38sYU7zejwzImTSzFhSIzsPwe0eyNKedg5kdsKO1U00SdFJd8wPIYY
 hMr1oEwLlOZGihB9hoqRkGquPmc8pXBYp
X-Received: by 2002:a05:600c:6099:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4a18043be70mr99629035e9.14.1791465532345; 
 Thu, 08 Oct 2026 06:18:52 -0700 (PDT)
X-Received: by 2002:a05:600c:6099:b0:4a0:1fb9:2f51 with SMTP id
 5b1f17b1804b1-4a18043be70mr99628345e9.14.1791465531873; 
 Thu, 08 Oct 2026 06:18:51 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843e3356sm62947465e9.14.2026.10.08.06.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:18:51 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v5 0/2] i40e: add runtime-tunable ATR sample rate
Date: Thu,  8 Oct 2026 16:18:22 +0300
Message-ID: <20261008131824.248508-1-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qrCPSTjJ8qhJyHEjfzwaxv0EKoy90sG_9NcXXLe3-TQ_1791465532
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Mohammad Heib <mheib@redhat.com>

This series makes the Flow Director ATR sample rate configurable at
runtime through a devlink parameter.

On systems with many queues and high-rate TCP workloads, the fixed
default sampling interval can cause frequent Flow Director
reprogramming and TCP packet reordering. The optimal interval depends
on the workload and system configuration.

Patch 1 moves atr_sample_rate from per-ring to PF level, since it is
a global policy. It also triggers a PF reset when re-enabling ATR via
ethtool private flags so that fd_ena is reprogrammed in the TX queue
HW context.

Patch 2 exposes atr_sample_rate as a devlink runtime parameter so
administrators can tune it without rebuilding the driver.

Testing with iperf3 -t 60 showed ~7k TCP reordering events at the
default sample rate (20). Setting atr_sample_rate to 10000 reduced
reordering to ~769 (~90% reduction).

Changes since v4:
- Folded the PF reset patch into patch 1 for bisect cleanliness
  (was patch 3/3 in v4)
- Skip PF reset when FD_SB (ntuple) already holds fd_ena high,
  avoiding unnecessary traffic disruption
- Fix LLDP EEXIST path to not drop unrelated reset requests
  (reset_needed &= ~REBUILD_FLAG instead of = 0)
- Flush existing ATR entries when setting atr_sample_rate to 0 via
  devlink, so stale filters do not persist on devices without HW
  ATR eviction
- Documentation: clarify that the sampling interval is per Tx queue
  and counts TCP packets only; fix formatting

Mohammad Heib (2):
  i40e: move ATR sample rate from ring to PF level
  i40e: add devlink parameter for Flow Director ATR sample rate

 Documentation/networking/devlink/i40e.rst     | 21 +++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 46 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 12 ++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +-
 7 files changed, 87 insertions(+), 11 deletions(-)

-- 
2.56.0

