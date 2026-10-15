Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5246FCC6B3A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 15 Oct 2026 14:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0249640744;
	Thu, 15 Oct 2026 14:06:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YFHAI6qU3HWg; Thu, 15 Oct 2026 14:06:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A885E40761
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792073175;
	b=bWusOL4RqC2jAU8lpCjt8e64SCZ0Ba8svLjegax4uvGq7x04GF7THEOu6OWlFgm1b7yw
	 ChS/kaZYImBfCpQJ9/JnWGJrQNa3J7TcHpfeSq4bVB4d+TLkJBAb0p7ggmuIAjg9x6/jS
	 jb8dnQgI8jEGK7cEO1C3gad3H+/Yr4vdjgrFSVTSeVEQSSacQwlcUoyNxccpiO+hlq/n3
	 f43ZCPLJBqvIrCEG/+JsaybqNfmrfNh7WvNMCW11cpTVoWUk0gmGAs3o2+7jRZTbdXrzA
	 IjP/8vmZqTZpf+lBRgRfLisdDaXz+M4BMT8DIq5crJyvPfusvPKBYStCP+O6wylmoSg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792073175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jst0QHyN6A0jHHiQzqvzYjJlwV1FzDgu9YBbdv3vSLw=;
	b=Hj8/X2cvunA7/xxrxlAvuBiaeF5d2BaQKhnol1uZ39IsNjbuYWpMZ8uavUEzdcgQz+Z1
	 2JtWwHlDqpoJtPC8I1owrD/WHV/2f0c+fyUzNOkMBidiM4g8D8DGzTJtvc9+wQ4+Hzzh/
	 8U95rvyCQMSdTPdZb560WJc+LCm9hX4vNO29Zb1tQNAC5MjY23WCYAwjdF2PWXR92Txsf
	 lFJEf2G9DaUKOuvUIK+0uxnjXigCBCi7TP3sWa3JUR8Wdj6VYe8IbqrF+CA/SEEK0uOJK
	 NxGniWe5VqX7FeVa8Eg/M174+rpSOOemOw0vDtmkRXjOBbH0Y3X2w89ZxlazLyIgQHg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792073175;
	bh=jst0QHyN6A0jHHiQzqvzYjJlwV1FzDgu9YBbdv3vSLw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=yrxclsLxcw+fz7AukDQaJsx69IQMaZHzIBTFqMn0HOdpM/wRZCLpFIXa3+ZuL8gGE
	 6Y/wayuaSK2rj8uAGh+XrWD36ynE9yA06tT4rDSszOVClHlMwngW3Smdup/3mZjxsj
	 FG5jpaj+f55BVmrEHNDlfn1EhII6/MOPGkKWoMhDk/TpZt++sPFSs+1A5TVdX8urVi
	 dkgGuKstWLhCUdvLZkRsPYmVyYBjdmGovSBrAE00IG4URlSTG8sUSZnVKGmKOj7iBA
	 QOfJhFbzr7HoEM/+V3cIC23kFqqZfpDvn+AvJpY3SKPUrf/w2YJZmCnsX3Q2eJgNLs
	 5IF5sdxzd3TnA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A885E40761;
	Thu, 15 Oct 2026 14:06:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 627E32AC
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 14:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48710810E9
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 14:06:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 25hMIVqiRy5t for <intel-wired-lan@lists.osuosl.org>;
 Thu, 15 Oct 2026 14:06:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D96B810E3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792073173;
 b=nViZIZJIRartgLJwHO0j3yMHWJF63HF0MzfZpSPOhqN5cZP0Ok65g548qjvlIhRv45L7
 8xPWbByE001oLW190GOQ3n5cbrIOe8Z5UK+Qu+W4si8n20XUV6wsAtUWfSZUjBNt2spwe
 hujAC2jfnWn8z5ABT++F3upCPPkqPogVkUC9sRa//ywPkSx7pGsjWCdusodaVZCPYxo7C
 mTRsOJcPLglRYf4OlNLUUPUpAfgQwhvB+Mo0t6y+akjz0O4VvZHH/owmndV+i4jK+zJhN
 xdu6YjPmGLBErRfwMzz2D/9VU40GteDBjQpn6l+yLlApiBGS0SfkPJ3Z3P+vR7UXYyQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792073173;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=jst0QHyN6A0jHHiQzqvzYjJlwV1FzDgu9YBbdv3vSLw=;
 b=s3x+nQ3BXklWBxzQN2vIhbS7czUuhNq88eLNc04VdfxGrK3xg+nTVGQzTVOc0KCzpcZa
 IUz6V4KZuB7YS6Wms7SO7uf3spevSkay3huGkNCj1xqQjTQaqBQpVGSCw5bp7WkAw2Zaz
 78RI27dDjeDKWEXtf2+4Dvfzu4p1immzwyt/7LcCH7M1sJzkW4MomZqJnxAkU5viq6DJG
 wUkMVcc0q0dtVbRaK1D5bTIB77LG4P2I3UrjCSEeR7yxys0sBw6t1oBbPkDGyPA38FJ8z
 3ZtPfT9ihFjPJHiMJCjEjfoQxQKpZijpxu7RXhGnkQLe8PjZEY2wC7mOSb1QRlyyJ9Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=linux.intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=L+IBpiZM; 
 arc=none smtp.remote-ip=198.175.65.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.175.65.11;
 helo=mgamail.intel.com; envelope-from=tomasz.lichwala@linux.intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=L+IBpiZM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D96B810E3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 15 Oct 2026 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792073173; x=1823609173;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T7ZbxMcqmGf74IWYC8ZzlErZ8aw0kWFqR4kjFPhkv2Y=;
 b=L+IBpiZM8Y6mNS+6sR4ui1zzsAuSPDcQtEdgI5KXH59VlGqG+VH2YsOm
 hA435XfA32JdGyoTr9b8vNFNOliHcc2pR8LIQmoTlQUXL2IMzPC4jsk3e
 xl5OD7uXdDFf8wytd8uNvp4XKLEyOd5XnnoCYU4kAf7ElL0T/1G4+GQLr
 5lbk93n9FFxO2RQIxiBdF6YxodNTzbSfZvz2NNpNRfAeNnm3y8zBISqpL
 tho+p1BHO2EhqfBdFYp9yt8lSVzobjGMdsVbXZVSe6K0xnxIWmJktIOm2
 aJyBu0zUDsfzVmZ0mT8SXHmiXz/g/Dq39tJrSLToDvyXof1g6X/sJATNZ g==;
X-CSE-ConnectionGUID: tHz5ZeumSu6VY4eVBzGsjQ==
X-CSE-MsgGUID: FUPog5ufSXeCu7LaVJLUqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="729401"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="729401"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 07:04:12 -0700
X-CSE-ConnectionGUID: Cz5zpk2qTxOMpUfPhGv84g==
X-CSE-MsgGUID: ScFK/6JkQVyNE6LhDod3Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3478235"
Received: from os-delivery.igk.intel.com ([10.123.220.8])
 by fmviesa013.fm.intel.com with ESMTP; 15 Oct 2026 07:04:10 -0700
From: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [iwl-net v2] iavf: fix VF stats not updating due to PTP command
 preemption
Date: Thu, 15 Oct 2026 16:04:09 +0200
Message-ID: <20261015140409.3124712-1-tomasz.lichwala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since the introduction of PTP support in iavf, commit 7c01dbfc8a1c
("iavf: periodically cache PHC time"), the periodic PTP clock caching
task always provides a pending admin queue command, causing
iavf_process_aq_command() to always return success and permanently
preventing the stats fallback path from executing, which results in VF
statistics remaining at zero despite traffic flowing.

Fix this by making the stats request unconditional when the adapter is in
the running state, rather than relying on it as a fallback when no other
admin queue commands were processed.

Making the stats request unconditional exposes a separate, preexisting
gap: iavf_virtchnl_send_ptp_cmd() sends VIRTCHNL_OP_1588_PTP_GET_TIME
without setting adapter->current_op. A GET_STATS request can now follow
it in the same watchdog pass, and if the PTP reply arrives first,
iavf_virtchnl_completion() unconditionally clears adapter->current_op,
dropping the completion tracking for the still-outstanding GET_STATS
reply. Fix this by setting current_op around the PTP send, matching
every other virtchnl command sender.

Fixes: 7c01dbfc8a1c ("iavf: periodically cache PHC time")
Fixes: 52e3beac764d ("iavf: add support for indirect access to PHC time")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tomasz Lichwala <tomasz.lichwala@linux.intel.com>
---
v2:
 - Set adapter->current_op around the PTP command send in
   iavf_virtchnl_send_ptp_cmd(), so a GET_STATS request issued right
   after it in the same watchdog pass no longer loses its completion
   tracking when the PTP reply lands first (found by Sashiko auto
   review on v1).
v1: https://lore.kernel.org/netdev/20260928230429.495442-6-anthony.l.nguyen@intel.com/

 drivers/net/ethernet/intel/iavf/iavf_main.c     | 14 ++++----------
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c |  2 ++
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c7f69a904058..2cd01081ad85 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -2932,18 +2932,12 @@ static int iavf_watchdog_step(struct iavf_adapter *adapter)
 				iavf_send_api_ver(adapter);
 			}
 		} else {
-			int ret = iavf_process_aq_command(adapter);
-
-			/* An error will be returned if no commands were
-			 * processed; use this opportunity to update stats
-			 * if the error isn't -ENOTSUPP
-			 */
-			if (ret && ret != -EOPNOTSUPP &&
-			    adapter->state == __IAVF_RUNNING)
-				iavf_request_stats(adapter);
+			iavf_process_aq_command(adapter);
 		}
-		if (adapter->state == __IAVF_RUNNING)
+		if (adapter->state == __IAVF_RUNNING) {
+			iavf_request_stats(adapter);
 			iavf_detect_recover_hung(&adapter->vsi);
+		}
 		break;
 	case __IAVF_REMOVE:
 	default:
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 680a28a739bf..acd1ed61af3a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1537,6 +1537,7 @@ void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter)
 		goto out_unlock;
 	}
 
+	adapter->current_op = cmd->v_opcode;
 	err = iavf_send_pf_msg(adapter, cmd->v_opcode, cmd->msg, cmd->msglen);
 	if (!err) {
 		/* Command was sent without errors, so we can remove it from
@@ -1546,6 +1547,7 @@ void iavf_virtchnl_send_ptp_cmd(struct iavf_adapter *adapter)
 		kfree(cmd);
 	} else {
 		/* We failed to send the command, try again next cycle */
+		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		pci_err(adapter->pdev, "Failed to send PTP command %d\n",
 			cmd->v_opcode);
 	}
-- 
2.54.0
