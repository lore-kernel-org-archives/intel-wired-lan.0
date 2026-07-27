Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C635C531D0
	for <intel-wired-lan@archiver.kernel.org>; Mon, 27 Jul 2026 11:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8ECE80DE1;
	Mon, 27 Jul 2026 11:58:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qpsmJBZ5E-Jc; Mon, 27 Jul 2026 11:58:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93BCE80DC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785153503;
	bh=a57vSMFq6QWWBI84IcyNzkcoKvzeM6bUbIgH5iMpCrE=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kWRLMN9tjnXrJ650CYoxk+hXysdKi7/ihMoUdgKzEeBjbUtGDdvF8/LwqzFV7Sf1O
	 lrx5OnmGGSqYAOo4TVSWMwYBAPCvAYw0J53wnicYnFFvSCRsb3ND/Q4Nqsec3qB+sc
	 pf5Gea2nYns8hzuUViElw/GzJBtIQOHhNUktXIt4Isn9uQgcOP7rWyLQkUdRPLSmXR
	 dG4fSv/Z5u5tnod0bGCGGTBuOEsPATbGPHa8fA6AIWQGnQfSehNBMD9ILT4fbxfph0
	 Ung+KgiSenUWpAF2SSwrTx79nHat0Iu3Q7wfgG/Mwe2j8L1wZ4dwwlr3O+2NroibyT
	 YMjFZWLPEtp2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93BCE80DC9;
	Mon, 27 Jul 2026 11:58:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D9D11357
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 11:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D4BDA606E3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 11:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zDMItmyH2qZp for <intel-wired-lan@lists.osuosl.org>;
 Mon, 27 Jul 2026 11:58:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BDD0A606DA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BDD0A606DA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDD0A606DA
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 11:58:19 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JIvwaUKZNaWMyPe2nTu1-A-1; Mon, 27 Jul 2026 07:58:17 -0400
X-MC-Unique: JIvwaUKZNaWMyPe2nTu1-A-1
X-Mimecast-MFC-AGG-ID: JIvwaUKZNaWMyPe2nTu1-A_1785153496
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49560dddaa4so14877655e9.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 27 Jul 2026 04:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785153496; x=1785758296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a57vSMFq6QWWBI84IcyNzkcoKvzeM6bUbIgH5iMpCrE=;
 b=LmT5ypGzJFAnp2H/xny5kqI1807l7UwzX5nP/zkSu8VwikdINiZSoNe4QgPfBzZKFM
 RqtT/dieOqG6gi9XdBBLmIps9ELSFyoakXbLoIq8mPQN14HqeYkVeJlRkLb4SlTUVU0X
 oaWs8pzKomGeZTji00av0vQCZHMalFsE8cxLrvzvp5CRZXoHnjUQzKMKPabRkNt+/M2k
 Z0foiU385HhZHYuHwz5BzQEQZ/2CSM6xOxA1ZTKKgN+bBtevkXddTXy8pnw2cVoE6iR4
 VlFw/LHQuKMon8WvsWD7SJAgNaBjD8HdeiL7dCtl9hgUs9bajKfCF/I+WyIYyDRycPYa
 CHOg==
X-Gm-Message-State: AOJu0YwPx+GkserC0h+Ck18R/SSUTfEuj2sWxLcC6GSi4kvJ/A1LXMSv
 HGKkuLaef8q3X6KrWgq80OKb4LNQzlfDpbOnwSZdurChTiATfb3vBjiEpZp+AlxRBwfbt8icV1X
 M0aBNNHlBytdXfAKdJbAHPdDvxQB1Mr8bQIWnS0pCuLtb3JzUbBG7M8sCqLF89D1KwQDVf0MYfV
 tycRIUxk8kHss2W/f4Tq6z82hpuzPh8gN9YspfA5zqdv1RzfymjkkfUA==
X-Gm-Gg: AR+sD12i4V7yhwyxfOg//QenECjDkVRRVzeFRFx9aHm1Zz3E4KyDacQfJxMNPKbpUYR
 DKtyQOaL95w91tBLmgeIdRnvRzOeSANccaGV/ig3DMQ2BM+9b+gugw+iQFTnYkplccHt6i5ayKT
 6wsBGvIm06iPSKjAwX16hm0RWE+PipINUMxIJw98FTMDURbLjfGG4sFPQPDPNoiFZz5DEmix/+/
 qhlhQtZvBpk8s1o+o3/HETsqx3hvsctrtvZQ2DqyvA+TtuL27tWjEFvxXGGOOt5usD/g411xmij
 JB7/+ALt6S2juMqYpKUxxYarPmT8JSkeZdLoR3OPDknAwz0p5CqwkwTbqhPDHVMQHvB7tmjE1au
 bgtUaBkijvt4xMQ==
X-Received: by 2002:a05:600c:1d0d:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-496b56da6d6mr96685665e9.3.1785153496246; 
 Mon, 27 Jul 2026 04:58:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1d0d:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-496b56da6d6mr96685235e9.3.1785153495810; 
 Mon, 27 Jul 2026 04:58:15 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.178])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9b8b67sm262590285e9.4.2026.07.27.04.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 04:58:14 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, sln@onemain.com,
 jbrandeb@kernel.org, Mohammad Heib <mheib@redhat.com>
Date: Mon, 27 Jul 2026 14:57:56 +0300
Message-ID: <20260727115756.105038-1-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZA08woHuIpjrwmiAqVt-TPEkzic02TtYMWfcvBlqb44_1785153496
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1785153498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=a57vSMFq6QWWBI84IcyNzkcoKvzeM6bUbIgH5iMpCrE=;
 b=P4nqluKugn1jnh2aumCwPA6C/SBQCgVPGVlA2/t++gd/FK3lO1tcxj7B9hcZdK2Xh5+Yad
 rvdAF/4EK14IZQX5TI/3oiEKajfkHRKNaUnPS2nPzb1sW4pimMZNkUzCzFamYi6xofwnuZ
 AjI39a/KLypViTYyysstye0v1FNHJvc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=P4nqluKu
Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: fix napi_disable hang in
 i40e_down() during firmware update
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

i40e_down() expects its caller to set __I40E_VSI_DOWN before calling it,
as noted in the comment at the top of the function. All callers do this
except i40e_vsi_reinit_locked(), which calls i40e_down() directly
without setting the flag.

Normally this doesn't cause problems because NAPI drains cleanly on its
own. But when the hardware is in a bad state, like during an NVM
firmware update, the ring descriptors can contain garbage that
i40e_napi_poll() sees as real work. Since __I40E_VSI_DOWN isn't set, the
poll function has no reason to bail out. It keeps returning budget,
napi_disable() keeps waiting, and the whole thing hangs. The thread
stuck in napi_disable() is usually NetworkManager, and because it holds
the RTNL lock, the system can end up completely frozen.

Set __I40E_VSI_DOWN in i40e_vsi_reinit_locked() before calling
i40e_down(). i40e_up_complete() already clears the flag when the VSI
comes back up, so no additional cleanup is needed.

Fixes: 41c445ff0f48 ("i40e: main driver core")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 878e0c46e5bb..78f95f63b588 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7463,6 +7463,8 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
 
 	while (test_and_set_bit(__I40E_CONFIG_BUSY, pf->state))
 		usleep_range(1000, 2000);
+	/* required by i40e_down() */
+	set_bit(__I40E_VSI_DOWN, vsi->state);
 	i40e_down(vsi);
 
 	i40e_up(vsi);
-- 
2.53.0

