Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063D8C61DA4
	for <intel-wired-lan@archiver.kernel.org>; Mon, 13 Mar 2023 16:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 863D781770;
	Mon, 13 Mar 2023 16:34:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 863D781770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1678725240;
	bh=LZ+Yle9e2lRIdeqXYAizJUDcGJq3+qZbki5b8pmurTA=;
	h=From:Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Cc:From;
	b=jOy7cVA0XzWGXShbb0DwV9v9ztE6t7vnoTPphL48+K+DAgTwlBCttW5NLU72bh710
	 jULNo24mjbTNym82e0WXch2RXpzrD5pKTr++9d3jiHzWpNtr3O9TAm4/rlTniA6m9D
	 7jD8MqVTEPbFAtOy9fylOktU0ax7XgS+eSVPOTdgnhIazJ7+tAF46EOkGsBGPjtTcO
	 aOED30TdD8UYXOyX7BsJCtg8kGNQ0R5repYURcFdGn4PBpXBu5+rb8oOM49trs+mqd
	 hIH56lSzBYqYjmvY3/Isu8+Q8WNJxFfRrXWNw9espwr6Iwa99XtPbe5SHiLlyNg5Ij
	 mIwDbu32ysdQw==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLHyOYHy5Wy2; Mon, 13 Mar 2023 16:33:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D9E281771;
	Mon, 13 Mar 2023 16:33:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D9E281771
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by ash.osuosl.org (Postfix) with ESMTP id 640461BF909
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 16:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B5E460807
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 16:32:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B5E460807
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48T-0pBVo6Xw for <intel-wired-lan@lists.osuosl.org>;
 Mon, 13 Mar 2023 16:31:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7B4260592
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7B4260592
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 16:31:58 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id cy23so51000993edb.12
 for <intel-wired-lan@lists.osuosl.org>; Mon, 13 Mar 2023 09:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678725117;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=izuBuxwdIPWQ5BlFBYrEudMxJy/3eKoBODl3Q7pVmOg=;
 b=S/B1sEIHPoUvD0TSculS8+Mc8I0vCSUk/xv83AJF3o+BWTWnxWy8c15bD28WhK2DPf
 Tz/eoMpLummYCA/hrdTPHufvNq4Gh7S4xst7kJbJHKHdpkVFwNHctf3d2csAwnndDgws
 8ZgulzysiiKZZqNflGAslhHkdVyN9DlHmF1AiujuL7Fek02gAW26/X+gY4l/5nPPUdlt
 h8ZD8bxGuMg8agP354MXf7LFaVrJVP88ReLw1296OZwgBDO3FqyAoCUDETzrdSaau7/g
 LkAZEz+MYuH4AK8VayaPT7e/+TrRaaKL5U6G/fwZbwkHAc2y8sGwSxVqHHYym4iuwZ8g
 WQXg==
X-Gm-Message-State: AO0yUKXjIiVMqju0PvYnp6g+c/X5pGv3RuJ0ahy4ERK41O5mMApzwcJ+
 ztReFzspkqTRgh1zLV+ZZKU=
X-Google-Smtp-Source: AK7set/EfQ2Eu+Z0rlqqlk9uoROfYt6ba42FXHP99LpzKZ2/SvQ9MQr3forX2MDa4CtuYQQWwKeLtw==
X-Received: by 2002:a17:906:308e:b0:8b1:3ba7:723b with SMTP id
 14-20020a170906308e00b008b13ba7723bmr32930522ejv.30.1678725116892; 
 Mon, 13 Mar 2023 09:31:56 -0700 (PDT)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
 by smtp.googlemail.com with ESMTPSA id
 lc22-20020a170906dff600b00922b009fc79sm2816144ejc.164.2023.03.13.09.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Mar 2023 09:31:56 -0700 (PDT)
From: Jakob Koschel <jkl820.git@gmail.com>
Date: Mon, 13 Mar 2023 17:31:50 +0100
MIME-Version: 1.0
Message-Id: <20230301-ice-fix-invalid-iterator-found-check-v1-1-87c26deed999@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPVPD2QC/x2NQQ7CMAwEv1L5jKW0gQtfQRycxCEW4CCnrZCq/
 p2U42i0sxs0NuEG12ED41WaVO0wngaIhfTBKKkzTG7yzrsRJTJm+aLoSi9JKDMbzdUw10UTxsL
 xiY48X8LZpxw89FSgxhiMNJYj9qbWV4f4GPfY//8GyjPc9/0H8Gx3HpQAAAA=
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678725116; l=2303;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=WjMjEPfty/nItSmP8wasMGB1SdFJhn1Xtbp3MghZjCI=;
 b=jGby7KQI+wBKqCv86pOj7AXtN0VEVq+RnsbhBAVivykpoAIcDyFE8MHkejVkEKHqLu2yKKv3bC2G
 706m/EvgBNjfklWYHPdDXUUnsN/0U77WE5aZpZW+GW19dbh6e313
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Mailman-Approved-At: Mon, 13 Mar 2023 16:33:57 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678725117;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=izuBuxwdIPWQ5BlFBYrEudMxJy/3eKoBODl3Q7pVmOg=;
 b=TO9SHC1L76A030IlfBQdRZXsYVblsYUnuEnrg9Jp7bigY9gICjXS9gpdz0+2hHzq9O
 QbhwIllnbRszvTC3+1rjU+Htx/GQft05w9puK7+zIogdV/oGgv3QsuiCUe0NcZRdhg0I
 /bvqDVSy6HcrWvfcb9Ujwz+VZw7RQbuGk/QYI3Nkgz6dJqqCy8yjzJN+bJtWx6dKr/cr
 supZ31QqVRdXJfyvYX4dN8CA3Bm2fCEKBe3IU7ROZAi7UM3K3pXCW3RN+yacyGDFfuI/
 1k4/G0b8NWV1tFRTySYJl0TlT2IlmKqlboe07fqOm2cPIcX1QzpQExVMKKSuzybgy4dT
 Yv8A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=TO9SHC1L
Subject: [Intel-wired-lan] [PATCH net] ice: fix invalid check for empty list
 in ice_sched_assoc_vsi_to_agg()
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
Cc: netdev@vger.kernel.org, Pietro Borrello <borrello@diag.uniroma1.it>,
 linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>, intel-wired-lan@lists.osuosl.org,
 Jakob Koschel <jkl820.git@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The code implicitly assumes that the list iterator finds a correct
handle. If 'vsi_handle' is not found the 'old_agg_vsi_info' was
pointing to an bogus memory location. For safety a separate list
iterator variable should be used to make the != NULL check on
'old_agg_vsi_info' correct under any circumstances.

Additionally Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the macro to avoid any potential misuse after
the loop. Using it in a pointer comparision after the loop is undefined
behavior and should be omitted if possible [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 drivers/net/ethernet/intel/ice/ice_sched.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
index 4eca8d195ef0..b7682de0ae05 100644
--- a/drivers/net/ethernet/intel/ice/ice_sched.c
+++ b/drivers/net/ethernet/intel/ice/ice_sched.c
@@ -2788,7 +2788,7 @@ static int
 ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 			   u16 vsi_handle, unsigned long *tc_bitmap)
 {
-	struct ice_sched_agg_vsi_info *agg_vsi_info, *old_agg_vsi_info = NULL;
+	struct ice_sched_agg_vsi_info *agg_vsi_info, *iter, *old_agg_vsi_info = NULL;
 	struct ice_sched_agg_info *agg_info, *old_agg_info;
 	struct ice_hw *hw = pi->hw;
 	int status = 0;
@@ -2806,11 +2806,13 @@ ice_sched_assoc_vsi_to_agg(struct ice_port_info *pi, u32 agg_id,
 	if (old_agg_info && old_agg_info != agg_info) {
 		struct ice_sched_agg_vsi_info *vtmp;
 
-		list_for_each_entry_safe(old_agg_vsi_info, vtmp,
+		list_for_each_entry_safe(iter, vtmp,
 					 &old_agg_info->agg_vsi_list,
 					 list_entry)
-			if (old_agg_vsi_info->vsi_handle == vsi_handle)
+			if (iter->vsi_handle == vsi_handle) {
+				old_agg_vsi_info = iter;
 				break;
+			}
 	}
 
 	/* check if entry already exist */

---
base-commit: eeac8ede17557680855031c6f305ece2378af326
change-id: 20230301-ice-fix-invalid-iterator-found-check-0a3e5b43dfb3

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
