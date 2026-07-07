Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDA6C43602
	for <intel-wired-lan@archiver.kernel.org>; Tue,  7 Jul 2026 13:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AC38860797;
	Tue,  7 Jul 2026 13:14:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_umZ_HOR-cc; Tue,  7 Jul 2026 13:14:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E941960793
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1783430075;
	bh=gy5f1rBuEP4haLiJZu59Q3d5AY2Hnz80qE4DOJ24g3s=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cum/eEB3mbr/vTRDNhdkMYNaW50nnUz2NAoEQK6WxY4fa2/Zb2gr/7ldNwK7LZhoX
	 dsKQUD+StsqvzwO5PBPrkgVFu0rOpi5KZd19PHdXURRbULKyBqx9GIHX83FU71sONO
	 KgBwcUwNIRbvR9siQnFZBnO0/aFQNeVKuD1fJ4al8Ikfxdx/VkTBv+CKIS3i5Qr0t/
	 hjjVFVbXeks3vNWbkrbWuxgKlMmszy7RFNT3jC/zn4BpRFKBOspxQlkmNM8JrBUbOB
	 HFHlmb6U8IUfBdYbshp3wUYJrb3ZyKMJE8UJ4930S0HvmBdH/My55hOCZvZsFCQFpz
	 4itm8FT+Q+UDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E941960793;
	Tue,  7 Jul 2026 13:14:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E90E5315
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jul 2026 13:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D26C060794
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jul 2026 13:14:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vqPueLCwSkQo for <intel-wired-lan@lists.osuosl.org>;
 Tue,  7 Jul 2026 13:14:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2166B60793
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2166B60793
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2166B60793
 for <intel-wired-lan@lists.osuosl.org>; Tue,  7 Jul 2026 13:14:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 517A860018;
 Tue,  7 Jul 2026 13:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474F1F000E9;
 Tue,  7 Jul 2026 13:14:29 +0000 (UTC)
Date: Tue, 7 Jul 2026 14:14:27 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <20260707131427.GE1364329@horms.kernel.org>
References: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629091203.36482-1-michal.swiatkowski@linux.intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1783430071;
 bh=gy5f1rBuEP4haLiJZu59Q3d5AY2Hnz80qE4DOJ24g3s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GCDpl3dn5MdgX4OeFnhOET9KfX0HgmUZta/LwGXG7Q4e9TmgBILIN8ZvO/XvtPIJ5
 gcJR9BzsErQE0+3BxV28NNkoEOkc7Z27GkArLqoigSQ7wTRYlsHrhxsgpo7CWLVEGt
 7ccVTQfYZnyYy8Bn8PMoTxmhoH1kdrpJfqAazpJjb/wb0CzvSxW1TJ6cr+jqWsPL5r
 4jSkXNB2KGLuPWAswfVs0fpdihWEqRUEcw2Y+h+6azXv0lIrATmqlExBRA91+uvnWT
 GqMuc89rvBUNG3upyiyvTNUiD5GVcFZqHZiS0Rm704k/1E6m98hCb3W4WQwxl7JFEn
 0aeV25Nnoo5+Q==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GCDpl3dn
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: use global queue
 index in TC to-queue offload
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

On Mon, Jun 29, 2026 at 11:12:03AM +0200, Michal Swiatkowski wrote:
> Previously index within PF was used, which caused rules to fail on any PF
> other than PF0.
> 
> Switch to global queue index by adding first RX queue id from caps.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Fixes: 143b86f346c7 ("ice: Enable RX queue selection using skbedit action")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

