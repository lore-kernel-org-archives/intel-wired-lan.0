Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E11CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 13:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19979406E2;
	Sun, 11 Oct 2026 13:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0iCodk2SqAP6; Sun, 11 Oct 2026 13:50:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78EB940604
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791726621;
	b=NMPm8MToQzp7hbUWG6333DH2Lxr6afRHWCZkDrN97UI/16HC+ZEPrMIWY2uxE0H9cGlW
	 0/PciYnEhc0pil475zP2db+B3gI6PBjd85xNghR4ls308f0ZWUrHoBrX4x0fBWSPrm+8D
	 955/Xp9T+jozgD+vx41agQN7x+qpBbYEiopiV3fzINp8ZQojBNuevEf0hi7tNHEEAJZKb
	 e5DGB0HFGalamiKRPCCIf7IPTQza8VCTcExJY0/20M/4LfiqiSicc05CQqfazTQfy0Lfo
	 9P6CK4jsUTgo/QU7BLot9cRET5Fkceg8FZtVsJVnSElAECS6Q7oxHsxmmABLiIOk+YA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791726621;
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
	bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
	b=Qwjj1gwR32IotMwCxj/B/HJRMbB9vbtWnYJN/ZwdqZPy/J/pNsWvopUyURNxkcZ48f/s
	 azqBeDfAgV9vY7/fnkowl1kOhw4YKUCfAuMmNEs9sPR8Q+kEKNJtZDyOoRlpmdC+PIi8h
	 18F9fWFuZoPYHAhbHpbxVF8Xav4fleumLNs8SURU5zuVOpIHBUPGtbZJPKJ5i2EaQQTmo
	 RqAnj44A/frauGO+OY8Gv5dxdNKGXdDsfToeNfv9uHDsFy+AlZ0aBsI7Gz4lhkxyo5sdp
	 96FJO14QLOXz8VFfqN9Xsasg2JZLMLnVw1dNri8dirFOVWTR+Nw5g4j4pn9MnUH35fQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791726621;
	bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cTmm2z2YVvBojPtIpYlF486Vz2Dzc+q9ycHuRVQXTu/1lWdpqGgSLGo26XDOmoiBz
	 hNgD2yORdjJyMqB4l4XFz9kmQE1IJkP03ConbB3E77I1AHf9+wLWJtpUzEhLFDTHC6
	 2q/FdT4KzGs1kDYGI+p37LtfD46BV70sP4ijXpiNNdN2PZm3Ve98bRIsCOyFWhxhtR
	 zuXqEQm9Uz0HJ6zHLzdLbZDYz3I1ZDQu8w1ec2wK149wCSY4xI3YHrtfYFMplzsZX3
	 dlcKqqkNRjtnKCNMEiuEwJy2IvmF8evjoxpz7CSOZMf2qXISzNU5vVGGDkdLxhwsu7
	 K6+TQUdmg+I/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78EB940604;
	Sun, 11 Oct 2026 13:50:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40ABA1A6
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 326B060616
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CrwUtJKtJg3r for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 13:50:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B1E946060E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791726619;
 b=VFl4O0ZUjKFqSITG457eyFaS9DGIvJy8IxTzTPPxG8FtSv5vKMajAgt33VMRaBnRN84W
 twoyQe5JBxAycullDblp9I38ttEKKTGycJ4TuuAA3wIC2T+T39OrHm3t6Mi+9IAvloZi6
 m5+btGQw6KoxLs4XrtpE27esoUQU6iF41uI5wIqk5EhGOKi9OuA3s33P7fc1Vcs0gH5ba
 YryBNsBSzvmkTyurBHb1IUJjT3DGlP7+cvdV8fsC5IofUam+uiYyetqDy9WMkwfC1SW4Y
 KLai5ZCy/5Vu2od631KAeiKI+GTjsFH5wABrpsRfc2jQW1PL9H4BemhzRHZhOPb6bgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791726619;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
 b=QamvuOH9yMSh8uoCAqBIg2B6Vp25g2n3VGjaTljv55+5Wp96dAwjmTZG8cE6GuS1TPle
 AbTnwVLsQIzGMbYHORtuA9QvhVQ8ioLoiD5lnXw1zXJjgSOdsUw5cTiY+Wbdnvj9DjLYY
 SYic7x89ktgZ9kaG5k2frDDHfkPQ16WyvI1D9wCr6YTlTEGsa2uC9Pu8Lr5ew7r4j0cq6
 dHf01vJW5SCAShPtFsRM6YtYgW2CSnPWpt0nSAf4XStiXFb4v98h2L/dRcF3aQ2YZ8x5Z
 f8aMACSeDHtWKnQXlPC06kJf4zXgeBcv6bn2w0h97qr2lhTmS4zAiHW1CzOaqfWv4Kg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=I30DvK7s; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=I30DvK7s
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTP id B1E946060E
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791726615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
 b=I30DvK7sbJyzul4eZWDD0zvkofGvQcbbpLQq+fH4mFOb/KvxFcPZigx26k+Uh58bL7UPpH
 MowQMWegQdvJ+7eYrl7oX5DkFy4kIj1Fd75pECE8KIkYdNJIj42+0CIUXZYSGZUakXHfZo
 zFqJj9TZ5/RsSsqelJ20sbjow1Hyy4U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-J-WouHVlPzKFxiuk-wHzqw-1; Sun, 11 Oct 2026 13:50:14 +0000
X-MC-Unique: J-WouHVlPzKFxiuk-wHzqw-1
X-Mimecast-MFC-AGG-ID: J-WouHVlPzKFxiuk-wHzqw_1791726613
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a170fa0879so8033825e9.3
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 06:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791726613; x=1792331413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1N6bIdacRp0M0H1pJUiWwskkKxr0wGWO9NcWl5lfvN8=;
 b=bMfhju/hdjm2vSYXksGe4kNnRp6Xqi6ZKGWAGVVhBf/tSoNOsgR6SH4mwNf2YjwAEy
 RWCih9J9kPcBoMp0q9iCcLQxj+krurmF6FWUBmsBHcpXmG+9DXvXm7rFV6VX/WE2b2lZ
 6l5YSM+Lb+fnnl4OOcTxywPP7XI63LmYzp7hSRiglLSY2PVF9VMxM2SqfaYo/luuA1HG
 pYs04hy4+FRj5fXkryqcy8epaLVpoFq9KIZstdFyO7Zcnh8n+L7Q/IfnPjFUIsqFkRrr
 1yWsLYTm8oxLxEV8Rt3WyAlmaruFPzJdqDciMTyZBXHnmrnq8WVpGt1juwF8wCUYHrfO
 mkyQ==
X-Gm-Message-State: AFq9FYJ5/KqBUdk2nG1DqiOwIZlhMAKoJUileFjJXJqjqrLJxqSPeKt5
 qvbVu1bjfDkKkHKo41v7JoMRw3MMAWqsAHPg79RM3CSM1MIPLWj2LlDmFCAhVFspSE9+GUzxncs
 cgGVyk5KqT/e1BZdh5ErCGDMMy+AyU3mbB6nu+dWYvMXhEty4AHN1S6+6qaGOTGKkfO51xZBQp6
 jcf2BhZO0CrMQAGMdnht5j/Xyne5unVX/wHab9RRjvdRrjR0X7U2hzVw==
X-Gm-Gg: AYBFou1xf/69vZL5IpKlGuIWsQzhKCkKatbGbsDPFrjXVJlauvA8eEkZIl2XLPcCvpB
 7OUdg5hlG/qPa0gottVbQeAVRfIQ+ROwdurwTQzlSonDuBTnufBPar7xvx4B5h6UpcOxk0G8aU2
 0P+cqvp6WRvLycRmmsMpbei+AzKEwjJo5lf8wDx/JAQrnwqGBFWhIFmxc8T+lWGTHPcK5afJyfM
 K0640Lu/couTEKzRlXasSaKnBEYxJ27x2wJhukQczgjxHhIvBDdpX3TNXoU9a5dr/TxwtBF18YL
 D6VZXALkiyVaVG5oEajjnLfVKrPtoXrXrG+JD1KqhyrTuoYuImjeyFeIpAINYbzYIUrizmZCM92
 ebWP9SFwA1PMSv2kngbp4HMCpfPgAsApY
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr128003565e9.14.1791726612887; 
 Sun, 11 Oct 2026 06:50:12 -0700 (PDT)
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr128003135e9.14.1791726612398; 
 Sun, 11 Oct 2026 06:50:12 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm13334125e9.3.2026.10.11.06.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:50:11 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v6 0/2] i40e: add runtime-tunable ATR sample rate
Date: Sun, 11 Oct 2026 16:49:50 +0300
Message-ID: <20261011134952.54887-1-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R_FTDD-6-AWQVrR4icvvbtLYAGqEpoe3YaA-3jjQQV4_1791726613
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

Changes since v5:
- Use '|=' instead of '=' when setting reset_needed for the ATR
  re-enable path, to avoid overwriting unrelated reset requests
  (Sashiko)

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

