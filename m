Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C91ACD68E1
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Oct 2023 00:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7AFA4159D;
	Tue, 10 Oct 2023 00:25:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7AFA4159D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1696897542;
	bh=GfplIxttgrJYgjkaXucWtOrfbKHMQ/xM768MHX1beuI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=buFSpgZVMXEspw2+0SfqeqXmXMeTlVW3l4inxvc5lXKdVcu0j05ygIExjRa7Re2pZ
	 NulP9Cp2pt6vd741GJRO3RMFEqDxIKElm2tjtVML5gRMEuNEIExgzVf31DRxLE23ZI
	 3UlcZAHNKNpYc9A6FW7cpwn7nULHKfZiqR7ZMOsFmwRH0Yt7epdqkQ/G4kiitwgz6I
	 L9GxVeO5EIdhp85f18eF0pZC4v40/H+kqxS1DsZuW5iyhloWnRcdxn0qrkum/OvDFO
	 IUieo1a+OTvC1CsmLq1x4Oz58V5CABiOmuZUQNaJiEiVeC8+DvNWCOTjy5/ExzfQpj
	 LHeBdSq0+WG+w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bRuHTIl8RVeT; Tue, 10 Oct 2023 00:25:41 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id A90A0416B5;
	Tue, 10 Oct 2023 00:25:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A90A0416B5
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id B51871BF969
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 00:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D43E40AB9
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 00:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D43E40AB9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9wFW6whMsgpB for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Oct 2023 00:25:24 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6789540857
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Oct 2023 00:25:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6789540857
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-rhGN1PrNM4yeRUtLMmFgfg-1; Mon, 09 Oct 2023 20:25:20 -0400
X-MC-Unique: rhGN1PrNM4yeRUtLMmFgfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61405101AA68;
 Tue, 10 Oct 2023 00:25:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C11C1C060AE;
 Tue, 10 Oct 2023 00:25:17 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: intel-wired-lan@lists.osuosl.org
Date: Tue, 10 Oct 2023 02:24:44 +0200
Message-ID: <20231010002444.43507-6-mschmidt@redhat.com>
In-Reply-To: <20231010002444.43507-1-mschmidt@redhat.com>
References: <20231010002444.43507-1-mschmidt@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; 
 s=mimecast20190719; t=1696897522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nWuMeAnZHtcodzxZJSgkchrAPsxYSKSRbVv/xoVnbnA=;
 b=HAS7bxqgl4y9PJiXMq74oCHDzqShg9d59OnuAZrI8TYggsz4HLCq4eYFPTWkZJqneaie0O
 cnCTwBcetD5vEfsHTPgu1sJLr68g0UDInkd+tYOLrIAnuDszOnadfRj4Jt3h0CvU8rDCcC
 oxp8eDFesxRgv40xE3sGD+B3/rwTnj4=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=HAS7bxqg
Subject: [Intel-wired-lan] [PATCH net-next 5/5] iavf: fix the waiting time
 for initial reset
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
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Radoslaw Tyl <radoslawx.tyl@intel.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Every time I create VFs on ice, I receive at least one "Device is still
in reset (-16), retrying" message per VF. It recovers fine, but typical
usecases should not trigger scary-looking messages.

The waiting for reset is too short. It makes no sense to check every 10
microseconds. Typical reset waiting times are at least tens of
milliseconds and can be several seconds. I suspect the polling interval
was meant to be 10 milliseconds all along.

IAVF_RESET_WAIT_COMPLETE_COUNT is defined as 2000, so the total waiting
time could be over 20 seconds. I have seen resets take 5 seconds (with
128 VFs on ice).

The added benefit of not triggering the "Device is still in reset" path
is that we avoid going through the __IAVF_INIT_FAILED state, which would
take a full second before retrying.

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2ab08b015b85..f35d74566faa 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -4791,7 +4791,7 @@ static int iavf_check_reset_complete(struct iavf_hw *hw)
 		if ((rstat == VIRTCHNL_VFR_VFACTIVE) ||
 		    (rstat == VIRTCHNL_VFR_COMPLETED))
 			return 0;
-		usleep_range(10, 20);
+		msleep(IAVF_RESET_WAIT_MS);
 	}
 	return -EBUSY;
 }
-- 
2.41.0

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
