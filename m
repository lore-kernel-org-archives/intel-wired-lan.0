Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A41D2E03C
	for <intel-wired-lan@archiver.kernel.org>; Wed, 23 Oct 2024 09:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6757780D7D;
	Wed, 23 Oct 2024 09:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JZDUMe38FAbv; Wed, 23 Oct 2024 09:54:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A642280A6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1729677274;
	bh=lywUuGQ0HqbhJlH9M/uwog44CmlV7EmyN3TEIywER+8=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JsEfvmai25XbdmKBHIxealCS9wBpNPRkWjC0qpWKz+XRqzdpHxGXSCcHFyGlS+YYP
	 FIOuefaXOu0HarUS0g3OF7iZ6VuJwM1A+ueHRqwgTJjogav5Ud7TSP4+ersCsLxe0s
	 l7OIMLi7F0Ixj2RBES5DQJn6gGfbQD6kMzd3MfOMHwO4Q5SZVWONMGL3E04iXfNJ8g
	 lm3Z4Ba9H8sZuHef1Ojxkp+TFURe2LTwD4md4xltv5ouweJ7wc1PkEgh8gNpoeKGKN
	 ofmBCN/knUctSeoPkXtxTo1dcwRjA+7AHhZPocsHvyWDFeoIT94Ah7/1v+Yclyf6u6
	 HXl1hUYIL8cHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A642280A6C;
	Wed, 23 Oct 2024 09:54:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F4D159B4
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 09:54:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D2DF40506
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 09:54:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DjmPFPcTeu5Z for <intel-wired-lan@lists.osuosl.org>;
 Wed, 23 Oct 2024 09:54:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=192.198.163.7;
 helo=mgamail.intel.com; envelope-from=konrad.knitter@intel.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B7B8D40524
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7B8D40524
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7B8D40524
 for <intel-wired-lan@lists.osuosl.org>; Wed, 23 Oct 2024 09:54:31 +0000 (UTC)
X-CSE-ConnectionGUID: DsYfmtf6RCmvpEAyywUVyQ==
X-CSE-MsgGUID: rxBQ0lkQRoG3pT4zKs4bwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="54658343"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; d="scan'208";a="54658343"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2024 02:54:31 -0700
X-CSE-ConnectionGUID: EI7M5COJSQSXlWq5fUG4CA==
X-CSE-MsgGUID: 5MHYm0OTQq+4KntEPBKkvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; d="scan'208";a="84771106"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa004.fm.intel.com with ESMTP; 23 Oct 2024 02:54:28 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 08EE527BDE;
 Wed, 23 Oct 2024 10:54:26 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: jacob.e.keller@intel.com, netdev@vger.kernel.org, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 Konrad Knitter <konrad.knitter@intel.com>,
 Marcin Szycik <marcin.szycik@linux.intel.com>
Date: Wed, 23 Oct 2024 12:07:01 +0200
Message-Id: <20241023100702.12606-2-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241023100702.12606-1-konrad.knitter@intel.com>
References: <20241023100702.12606-1-konrad.knitter@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729677272; x=1761213272;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y5fuP3gzG9HVKuf3LvmENOmJFpaBGnVQOJHDRKFkUzQ=;
 b=WOhNJ6yUlislBkRKjUsUVhRsQ3q5n/mXpvlZ0k04opJd1iMmYTZYPhYW
 9Wi/ULnnuefZH8HkhwoFX2XgGLnAsuZMRZt9zkgJ8Rtr//bjiY8RwOJBn
 6R7tPgowNE+WX6Si6DFfc64BhovBBVc8NOrbP9f6flsIeM8u8In9qqa0o
 L4sJfMoC7fd0TUoRJQZOQRqgbIVsrLEJPmOjgqq+NbpAtISdk6SdrGpwZ
 D7mnJigsbE+v91BaTYgg4L5nyGzJPwqfftrFYnqN5EMURkJw8Cju1A7j5
 8SNdupz6EylyPzsapFbK87171rTODlUnXkxaSF+MpSqumbbda6sEAk37E
 g==;
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=intel.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WOhNJ6yU
Subject: [Intel-wired-lan] [PATCH iwl-next v1 1/3] pldmfw: selected
 component update
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

Enable update of a selected component.

Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 include/linux/pldmfw.h | 8 ++++++++
 lib/pldmfw/pldmfw.c    | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/pldmfw.h b/include/linux/pldmfw.h
index 0fc831338226..f5047983004f 100644
--- a/include/linux/pldmfw.h
+++ b/include/linux/pldmfw.h
@@ -125,9 +125,17 @@ struct pldmfw_ops;
  * a pointer to their own data, used to implement the device specific
  * operations.
  */
+
+enum pldmfw_update_mode {
+	PLDMFW_UPDATE_MODE_FULL,
+	PLDMFW_UPDATE_MODE_SINGLE_COMPONENT,
+};
+
 struct pldmfw {
 	const struct pldmfw_ops *ops;
 	struct device *dev;
+	u16 component_identifier;
+	enum pldmfw_update_mode mode;
 };
 
 bool pldmfw_op_pci_match_record(struct pldmfw *context, struct pldmfw_record *record);
diff --git a/lib/pldmfw/pldmfw.c b/lib/pldmfw/pldmfw.c
index 6e1581b9a616..6264e2013f25 100644
--- a/lib/pldmfw/pldmfw.c
+++ b/lib/pldmfw/pldmfw.c
@@ -481,9 +481,17 @@ static int pldm_parse_components(struct pldmfw_priv *data)
 		component->component_data = data->fw->data + offset;
 		component->component_size = size;
 
+		if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+		    data->context->component_identifier != component->identifier)
+			continue;
+
 		list_add_tail(&component->entry, &data->components);
 	}
 
+	if (data->context->mode == PLDMFW_UPDATE_MODE_SINGLE_COMPONENT &&
+	    list_empty(&data->components))
+		return -ENOENT;
+
 	header_crc_ptr = data->fw->data + data->offset;
 
 	err = pldm_move_fw_offset(data, sizeof(data->header_crc));
-- 
2.38.1

