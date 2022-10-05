Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159A4C433FE
	for <intel-wired-lan@archiver.kernel.org>; Wed,  5 Oct 2022 08:32:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9FC760B77;
	Wed,  5 Oct 2022 08:32:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9FC760B77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1664958769;
	bh=ge9S5GLfQUIdjt7xzM+hlOKSwXvSpiaXP6dL04+49sw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=EJpDOgnplvXR8WCHg5vyG/HcGUINLfiNUJR1KCqP07pzrDlLaPtgHMtoaKfUAfcaX
	 rUJ6hP7fPfKBZjNR9DB5DXMCLMvfMIq8GOmWWEvPfzrXWl8HzVqyfvxbn87m4VJV/f
	 WZyrnspWDHe2nhDM594EH6CYJCRwqs0IB8jiSljzQybARP+Dd0BRSkAHTq9cBlqRUN
	 3gvyyP2KZbkoGdKkZhMhfDk3Bo0XT+yfcxAYjC3si+4Ypwfl/r+b65RTRjD3QR82oN
	 cFCzteWq0wSQcSu2/qsxrFGRRk7/i6DCzwipFLI5dFpfgZvgKqdzgUHuUGNn3PVtgf
	 9XOIrG9I+KHzA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZbstp5FIA2v; Wed,  5 Oct 2022 08:32:47 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp3.osuosl.org (Postfix) with ESMTP id C525F60D77;
	Wed,  5 Oct 2022 08:32:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C525F60D77
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B42C31C1148
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 08:32:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95860415EF
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 08:32:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95860415EF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M_59yzQgnyzh for <intel-wired-lan@lists.osuosl.org>;
 Wed,  5 Oct 2022 08:32:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3614A4151E
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3614A4151E
 for <intel-wired-lan@lists.osuosl.org>; Wed,  5 Oct 2022 08:32:40 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d11so14830030pll.8
 for <intel-wired-lan@lists.osuosl.org>; Wed, 05 Oct 2022 01:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date;
 bh=KYs5i1UtSKwff4LZqDYKTEYs6XamWF2jUJRPKUQ5EPA=;
 b=t0HzkG4oU6U0dcwy/1Fl94SdoMZfy2sAWgmKZGr9CBRI2YJvgTw9q0jpdsEQ3RmX1t
 BBsQ8U8hPRbWIFHu9QxGwiR1kfQPiPtZYvBtjBGjmlTeVLViJthBYvk0Stm/LgLpfkb5
 oReQ18I188H+7BfpSX9gS5XUmiGCvNHJnI4G5kuORWf35OhXl36khIyOvtDUMSdsGFCD
 AagsHYyXpmrqfyFNmVCa0EfszdV04RooxSlehQgBwH85UuxJADDem7375ap4Da7H37li
 RT+oiLuwcT1ivzjuiSQQcoZjX+ANyVOQa60N3LU/e4CyH4bBrKDlhWo6kDzUd7Sruzum
 tA9w==
X-Gm-Message-State: ACrzQf1/lNX4qCp1zKJia14ab4UurIfdW7do0BiaGA6fuIl7NvDb22hR
 nQEcLWSfgPTEYPtIZ520icBXIZcOauPKWP+3zEpoCIWEYgmjr+kqnKYCYCxoEGUBSx+Dhf5EJaB
 wALdGbGsk4OA3nRRtPHjOz5OuDG50VtCLoGqQ0kB09vIgsIB9tt4XuZ0Bs6Uw3YY6vcf6sEDEoc
 9iNsNUMQ==
X-Google-Smtp-Source: AMsMyM5uvV2N+z8o7Lps/R5jdrkwdk2pbiCEvdcvFm3zqeAqi/0UM8OGHPa6MZ/YEzKEVyK9Rq3/Vw==
X-Received: by 2002:a17:90a:ea95:b0:20a:f65b:143b with SMTP id
 h21-20020a17090aea9500b0020af65b143bmr167924pjz.230.1664958759422; 
 Wed, 05 Oct 2022 01:32:39 -0700 (PDT)
Received: from localhost.localdomain (c-73-223-190-181.hsd1.ca.comcast.net.
 [73.223.190.181]) by smtp.gmail.com with ESMTPSA id
 jj9-20020a170903048900b0017ec1b1bf9fsm5899320plb.217.2022.10.05.01.32.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Oct 2022 01:32:39 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: intel-wired-lan@lists.osuosl.org
Date: Wed,  5 Oct 2022 01:31:41 -0700
Message-Id: <1664958703-4224-2-git-send-email-jdamato@fastly.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664958703-4224-1-git-send-email-jdamato@fastly.com>
References: <1664958703-4224-1-git-send-email-jdamato@fastly.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fastly.com; s=google;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date;
 bh=KYs5i1UtSKwff4LZqDYKTEYs6XamWF2jUJRPKUQ5EPA=;
 b=BNpQVvhEgCIekoG+t0cPqZeXurSlQZRXpEwPW8enJ92DBNA0QI4277kT1cO1fEJR/0
 b3GLCRn3d3x34ITuilfh48b1uO2erhW6yFJlzyj6F+puarqJPa0G7TQtEz308oFKzkMi
 DTNWQc6KBRHqjUVKmtk+dcsjciI3D6zVRGM98=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com
 header.a=rsa-sha256 header.s=google header.b=BNpQVvhE
Subject: [Intel-wired-lan] [next-queue 1/3] i40e: Store the irq number in
 i40e_q_vector
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: netdev@vger.kernel.org, Joe Damato <jdamato@fastly.com>, kuba@kernel.org,
 davem@davemloft.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Make it easy to figure out the IRQ number for a particular i40e_q_vector by
storing the assigned IRQ in the structure itself.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 9926c4e..8e1f395 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -992,6 +992,7 @@ struct i40e_q_vector {
 	struct rcu_head rcu;	/* to avoid race with update stats on free */
 	char name[I40E_INT_NAME_STR_LEN];
 	bool arm_wb_state;
+	int irq_num;		/* IRQ assigned to this q_vector */
 } ____cacheline_internodealigned_in_smp;
 
 /* lan device */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6b7535a..6efe130 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -4123,6 +4123,7 @@ static int i40e_vsi_request_irq_msix(struct i40e_vsi *vsi, char *basename)
 		}
 
 		/* register for affinity change notifications */
+		q_vector->irq_num = irq_num;
 		q_vector->affinity_notify.notify = i40e_irq_affinity_notify;
 		q_vector->affinity_notify.release = i40e_irq_affinity_release;
 		irq_set_affinity_notifier(irq_num, &q_vector->affinity_notify);
-- 
2.7.4

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
