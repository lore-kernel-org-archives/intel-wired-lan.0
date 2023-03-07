Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEAAC6FD1E
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Mar 2023 15:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 338AC40AC9;
	Tue,  7 Mar 2023 15:59:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 338AC40AC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678204756;
	bh=BDpFI98DrV77glyfSGBxHGa/5Pt36kYWnsK+5q/BI0g=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=cEut1cWvubGYjmfgrHFsfIr7XEVxNtv2uPQK1uO7Gud3wi1kIONINb2jXq9L++ScX
	 g6GSmUIXn+fCo/y5V5ENBGKlWk8Sd/0ilIUreRW+3PC1/UpsW9PQcxfzJP5ZWHznsT
	 ygGQZXxGEyK+EhV6Y42fDtxy5WVirp1SFgkvWigX/0P2Vmvq49WaAhFcM6LVOp9noA
	 aGY3US0FCb8aStDQk/Z8PprlxNByUAeEPA5ENgwLVrtUDI+B5LXoPdqbx0xxM7FE5H
	 KkjmcKzg5yF7OR6UoUxw9Y7KBqpbw8bzT0lboxB3V7mY26/Sp0FX6/aIHIDjTWzrbx
	 EIEN1nDTV3XGw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0QCf9cjCPN8j; Tue,  7 Mar 2023 15:59:15 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3822E40B34;
	Tue,  7 Mar 2023 15:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3822E40B34
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id C65411BF34E
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 06:45:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AAB03416D6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 06:45:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AAB03416D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kq278ENlh5Hc for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Mar 2023 06:45:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F05424088B
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F05424088B
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Mar 2023 06:45:51 +0000 (UTC)
Received: by mail-pl1-x633.google.com with SMTP id x11so8534152pln.12
 for <intel-wired-lan@lists.osuosl.org>; Mon, 06 Mar 2023 22:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678171551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tWUDbUcn72lVUggRq+lO9GshVKKZ994KDZUSopdffjk=;
 b=IVGbdetmiv5YnpamnjYzhTfMNiUkemBl0UzmthWKJwSEokVnz5dPoHfaXdv/TL96Xs
 NdoRnmEkNZ1u5eCjhQAsYOzT6PM460ZwWqtFMdpjI90FqmO2JJqFqddhSHD3l0JeMwvm
 vBLzWm0bcCsXBWMcY/ujhQxOMLenAjaab0G8E+LdwNyn2sRa6vd+yvOyS4DXq041e28I
 X6nja/yBXiT+CqAVjXLu/7SOCdAWK2AxwyR+41RNu7/EwZb/NgDn+wXDIJEWzO8RyLGz
 KR+Au99KjS8T0FCVxMZaNRpMtg3Y48r5J8fXCte77yI6rr/1MaM+c7XBCoJtcjSQ/oJT
 Tykg==
X-Gm-Message-State: AO0yUKUiCIJ+z5UbPl5of+XAfYf9DtsjcMLqQuMBeYMlC9JnD9srAVri
 uRGlT/vxgr+uAZC8qeuu6ZbP9w==
X-Google-Smtp-Source: AK7set8rh2u5j/0EPcSDVJEwvP75wz/kiHS1dWTOFQI1LbU9KthiLs7z+VQlDEDHd30q5GeV3Klvvg==
X-Received: by 2002:a05:6a20:7f9c:b0:cb:af96:9436 with SMTP id
 d28-20020a056a207f9c00b000cbaf969436mr18950112pzj.0.1678171551249; 
 Mon, 06 Mar 2023 22:45:51 -0800 (PST)
Received: from laputa.. ([2400:4050:c3e1:100:5c46:b5f3:8bc0:caeb])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a62ab10000000b0059261bd5bacsm7175297pff.202.2023.03.06.22.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Mar 2023 22:45:50 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com
Date: Tue,  7 Mar 2023 15:45:31 +0900
Message-Id: <20230307064531.68840-1-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 07 Mar 2023 15:59:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1678171551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tWUDbUcn72lVUggRq+lO9GshVKKZ994KDZUSopdffjk=;
 b=SWYj+1CHK2cbF079IF9kquFU+AA7SkK8E72Uxxd7ctBL7wuPHzQhPc6jdfJGnrwZEG
 s/+v28kS3XHNrPAu7flZwfZZ6L3SfXqx/WKzzRRcHxZbAMonjh8bSp7FA115xNX4Udko
 u2XnGvtxkUWR1VuVaSb1kRPHxvlFM1YDJ6JFe/ABxvFZXNU6yYfKO9782+1WS/nFugvM
 uJ3UwodhQ9UB2GIL3xNihNd14tUajsc3q5KJHtoho+VPy0e1MUaP+rjHi4/9i7rppcAZ
 eP18cCLNl/6dv7sS23naWg31nJF+QeB/SxTEvGi59GbM7tiRFIc6ZO0F7WNkabKbxFKZ
 G74w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=SWYj+1CH
Subject: [Intel-wired-lan] [PATCH] igc: fix the validation logic for
 taprio's gate list
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
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, kurt@linutronix.de,
 intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The check introduced in the commit a5fd39464a40 ("igc: Lift TAPRIO schedule
restriction") can detect a false positive error in some corner case.
For instance,
    tc qdisc replace ... taprio num_tc 4
	...
	sched-entry S 0x01 100000	# slot#1
	sched-entry S 0x03 100000	# slot#2
	sched-entry S 0x04 100000	# slot#3
	sched-entry S 0x08 200000	# slot#4
	flags 0x02			# hardware offload

Here the queue#0 (the first queue) is on at the slot#1 and #2,
and off at the slot#3 and #4. Under the current logic, when the slot#4
is examined, validate_schedule() returns *false* since the enablement
count for the queue#0 is two and it is already off at the previous slot
(i.e. #3). But this definition is truely correct.

Let's fix the logic to enforce a strict validation for consecutively-opened
slots.

Fixes: a5fd39464a40 ("igc: Lift TAPRIO schedule restriction")
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2928a6c73692..25fc6c65209b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6010,18 +6010,18 @@ static bool validate_schedule(struct igc_adapter *adapter,
 		if (e->command != TC_TAPRIO_CMD_SET_GATES)
 			return false;
 
-		for (i = 0; i < adapter->num_tx_queues; i++) {
-			if (e->gate_mask & BIT(i))
+		for (i = 0; i < adapter->num_tx_queues; i++)
+			if (e->gate_mask & BIT(i)) {
 				queue_uses[i]++;
 
-			/* There are limitations: A single queue cannot be
-			 * opened and closed multiple times per cycle unless the
-			 * gate stays open. Check for it.
-			 */
-			if (queue_uses[i] > 1 &&
-			    !(prev->gate_mask & BIT(i)))
-				return false;
-		}
+				/* There are limitations: A single queue cannot
+				 * be opened and closed multiple times per cycle
+				 * unless the gate stays open. Check for it.
+				 */
+				if (queue_uses[i] > 1 &&
+				    !(prev->gate_mask & BIT(i)))
+					return false;
+			}
 	}
 
 	return true;
-- 
2.37.3

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
