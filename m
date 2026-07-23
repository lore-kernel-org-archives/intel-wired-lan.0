Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A00C531D2
	for <intel-wired-lan@archiver.kernel.org>; Thu, 23 Jul 2026 14:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62684409B2;
	Thu, 23 Jul 2026 14:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sw_trrxu4sLp; Thu, 23 Jul 2026 14:05:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3167D40939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1784815547;
	bh=bnNSPSqjSTGJPtdLgfXOXWJwWqSENrN9xp6WtLBFRR8=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uegn0tTrojb+e4ZF6/sHJKygRTi3QJ8hJR9vJCDW/WcTQwbh4kOomzJRij8P/ApsN
	 ClrjTCmGM/orkogxmsvbcN874N4fG1DZezEK9NmqycoaJtPug+UrbRA0S42uhv3tEY
	 dcAgZlUFBXJFtNBnJ5kz7qQj02EMpe+Na5LHV+mGMMc9Sq9j0kuauBmVDKSgu2CDvb
	 5bDHqbRfMDelpciAYCjl4pft1/fiepyPxmuH0n2CuO2mfIqNLTTl8ZeiSjsysDxeBM
	 vWm+lqHPqDRgk8WHe5GZEgCQd0aZ/qu2XSwMgMsGGACcBLzf2NS6Xn60SM7WGZPBwP
	 Qm37SCATjwgFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3167D40939;
	Thu, 23 Jul 2026 14:05:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AB6F2E5
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C64E80E3F
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6unewXdy_oqe for <intel-wired-lan@lists.osuosl.org>;
 Thu, 23 Jul 2026 14:05:45 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EFF6080E07
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFF6080E07
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EFF6080E07
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 14:05:43 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-g4z5La4hPQiGRtD7W65Kmg-1; Thu, 23 Jul 2026 10:05:41 -0400
X-MC-Unique: g4z5La4hPQiGRtD7W65Kmg-1
X-Mimecast-MFC-AGG-ID: g4z5La4hPQiGRtD7W65Kmg_1784815540
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so6726515e9.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 23 Jul 2026 07:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815540; x=1785420340;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bnNSPSqjSTGJPtdLgfXOXWJwWqSENrN9xp6WtLBFRR8=;
 b=KBEomUROvixEv1K9gAaikA4jjb8dtFJ7b006qpoyk5oaojOrgJCb0zwglm/HOMJNWo
 Mv84Nt7LVWLbOpmex3APpEmT15rPE1CK3/4RdxNk9zayMnxbiMajVOVoi3rObzrkoV3+
 IweC/2iliDBzKOk4kgpwzzYoOmZjDwGqfW0oAjKRKG8NSSy627te1mvs4YniZQg6YHO3
 nwr1cGb1ceLPovHVJi93jX8uJSKEqaTuBaDRriVEBNVLMymlyfnlAV2/u6BMIMJRoxoL
 xuske5pn6g4ZyKKtOAMK0kqq1r+ci5v3GkA+MCWwGCoNjg1Tzy3pHvGXGZ0BT9dsa3tB
 C/Tw==
X-Gm-Message-State: AOJu0YwrJudgigUIoXL2DnKSiV64vs05b6GL+5HRLyu6dTU8iXneWiBO
 9gOpK1gZEwiU2j9L+bEgmSr+hNxFu5RlAAexM5XLC2MfkRCwp09PabyLfjO3lnmq0N/awe3RiuQ
 H02ca8de5+QPnI9D7Dos4hvrhncU3i+t656+xj8TpSAOGrV3TEi31h7u0DDOSjFtOuqYoCMqHTW
 llhFj2xF14Jtv+I5Ju3+pZ8fhig7yufzWQyTMEzF38W9h8toaHN8Y7+A==
X-Gm-Gg: AR+sD13hXIgDr+h5Ag5hWmt3Rw39mxvrynvy1Q9Eg/hfHxDR0jgjori0OvYUh4xXxuU
 BYorr3D62VHAR5B6diVKN04Mkb3TuLBwH8eUkMCQbA8mXmbLxM7i6s19bfWfC1yc7VFUgafA2fa
 EmEvnIiX7ofYkPBrqxg9bjJlFsCdme9oPhrvU+e6ydkjoQoDbTVgLRuHvJSu3ZnFIUwXjvN+gJi
 kD479CV50XGsEJjffQAAGW1uxc4zTGC1HClPvdZg45Kuapt6iWH2Atg3KZOnuaimRFnglAx94vG
 7uf4djGajf2xaEeQCoysarOef6OAuWb6aHtbSLtIUtRtVPp0DJ+AeAboDV9enIgX3k3IdG41wdd
 RNvWXX0+ibE+rFQ==
X-Received: by 2002:a7b:c302:0:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-49573cf2a0fmr25628755e9.34.1784815539893; 
 Thu, 23 Jul 2026 07:05:39 -0700 (PDT)
X-Received: by 2002:a7b:c302:0:b0:495:5943:b76c with SMTP id
 5b1f17b1804b1-49573cf2a0fmr25628065e9.34.1784815539011; 
 Thu, 23 Jul 2026 07:05:39 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:05:38 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Date: Thu, 23 Jul 2026 17:04:14 +0300
Message-ID: <20260723140510.184819-1-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GvdBaqTTyafpFbpJKkC6NwBLxYXwclW9Mdk2uTNcFWo_1784815540
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1784815542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bnNSPSqjSTGJPtdLgfXOXWJwWqSENrN9xp6WtLBFRR8=;
 b=XJKtbQoYgSQZYRPb1OXEBzSQwyyBeZ05UH8h2zO/j4jYCdw0KnM/V5VlFNcVw0Xq533r8I
 NelC6tjzBTssuDnWXEH5beh6b1rswbfk7+8E+gL9t8err3iYC3Ti+zqV9gRiPQ/R+yWbY2
 EQRZRv7MfbvFAI02ECZpWbRNzExd9gI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XJKtbQoY
Subject: [Intel-wired-lan] [PATCH iwl-next v4 0/3] i40e: add runtime-tunable
 ATR sample rate
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

From: Mohammad Heib <mheib@redhat.com>

This series makes the Flow Director ATR sample rate configurable at
runtime through a devlink parameter.

On systems with many queues and high-rate TCP workloads, the fixed
default sampling interval can cause frequent Flow Director
reprogramming and TCP packet reordering. The optimal interval depends
on the workload and system configuration.

Patch 1 moves atr_sample_rate from per-ring to PF level, since it is
a global policy.

Patch 2 exposes it as a devlink runtime parameter so administrators
can tune it without rebuilding the driver.

Patch 3 fixes a pre-existing issue where re-enabling ATR via ethtool
private flags did not trigger a ring reset, leaving fd_ena stale in
the TX queue HW context.

Changes since v3:
 - Added READ_ONCE() in i40e_atr() for lockless access to
   pf->atr_sample_rate (patch 1).
 - Added WRITE_ONCE()/READ_ONCE() in devlink setter/getter (patch 2)
 - New patch: trigger PF reset when re-enabling ATR (patch 3)

---
Mohammad Heib (3):
  i40e: move ATR sample rate from ring to PF level
  i40e: add devlink parameter for Flow Director ATR sample rate
  i40e: trigger PF reset when re-enabling ATR via ethtool

 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  7 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 ++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +-
 7 files changed, 72 insertions(+), 10 deletions(-)

-- 
2.53.0

