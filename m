Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C97E73153
	for <intel-wired-lan@archiver.kernel.org>; Mon,  2 Feb 2026 10:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8678B80E12;
	Mon,  2 Feb 2026 10:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 485MfWqCtB0w; Mon,  2 Feb 2026 10:25:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B297980DC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770027938;
	bh=CMSaxGP3eIqKcu8euueIQtFERGGu7GUah0ApqSAjdjM=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BJzPT6tftOoh0MtCVWynhKQJuOS65lg6f64pHHANDcU8AQmZ02X9xxSfA0v9HxC9g
	 9BzaFDFRqtznZY+tgJBNqU2T1BOzga98ipVWyia+KxMWgEiBzJ/oCRi0iTXDRHqqk+
	 LKFVGlGFRgfF4G6IYnoiVr5VNlH7yktf1ltNUWEsSTev0qLBwtU9pA0QY7xS1uWVmY
	 tNxSLyUnDwAEj5IyriwKf/d9C8yPjRcmT5nzf+F0A4bRSBndtPFGha87NjiLFClTpn
	 Ej3/YrM9DplWuQI5AUq73mdr4QDZxztOQgtdhTIKCuQfOSQ+kAmxo1Y+fOQH3so51X
	 NYJE3PAPJuOEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B297980DC6;
	Mon,  2 Feb 2026 10:25:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01DBF149
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 10:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F05C040266
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 10:25:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HQhiJhMHg6Io for <intel-wired-lan@lists.osuosl.org>;
 Mon,  2 Feb 2026 10:25:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 07817401FE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 07817401FE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 07817401FE
 for <intel-wired-lan@lists.osuosl.org>; Mon,  2 Feb 2026 10:25:35 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 71EDC60008;
 Mon,  2 Feb 2026 10:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F7EC116C6;
 Mon,  2 Feb 2026 10:25:31 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
To: takkozu@amazon.com
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, kuba@kernel.org, netdev@vger.kernel.org,
 enjuk@amazon.com, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com, piotr.kwapulinski@intel.com, pmenzel@molgen.mpg.de
Date: Mon,  2 Feb 2026 10:25:20 +0000
Message-ID: <20260202102520.1844644-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260127085410.79645-8-takkozu@amazon.com>
References: <20260127085410.79645-8-takkozu@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770027934;
 bh=CMSaxGP3eIqKcu8euueIQtFERGGu7GUah0ApqSAjdjM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YzkJizAgZc+iayIvgmIYgUy/wRE0dWGjOOraVoCQzHW1iAXzeBVrIPZo2COX9bxAG
 hUx+cwqBm+6wVdbCnAFPpk60TcZgYEYzm+KqfXfcVG/06/BPIMhk3oKrNQ9Q6aT5W7
 F1J32sQ9AOvAuDr+tli6RfcS0yyLUQNbE8A0hsx14PLDKRP/rCxnOUHlVHkSeguhfm
 hMNKRom1K1G/30dDqbhfnFFyNjRrDfZ3B7ZBAOL4R37TenYu+RM4kY60FQm4NWbnXB
 FCkXSb+JNuBIAD67ep4b1bOsgs/GY4Yg/IZmubE9KmanbMB+iWyp1TSBLx8nJrX7RU
 KtL6x1hMHdjSw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=YzkJizAg
Subject: Re: [Intel-wired-lan] [iwl-next, v5,
 3/3] igb: allow configuring RSS key via ethtool set_rxfh
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

This is an AI-generated review of your patch. The human sending this
email says "I'm releasing this report for completeness. And while I
do think it is correct. I don't think it needs to block progress"

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
igb: allow configuring RSS key via ethtool set_rxfh

This patch adds support for configuring the RSS key via ethtool's
set_rxfh interface. The change accepts a userspace-provided RSS key,
stores it in the adapter structure, and writes it to hardware registers.

> Change igc_set_rxfh() to accept and save a userspace-provided
> RSS key.

This isn't a code bug, but the commit message references "igc_set_rxfh()"
when the function being modified is actually igb_set_rxfh() in
drivers/net/ethernet/intel/igb/igb_ethtool.c. This typo was noted by
Aleksandr Loktionov in the v1 review:
https://lore.kernel.org/intel-wired-lan/IA3PR11MB89860A16782937C7E8C2E2DEE5A7A@IA3PR11MB8986.namprd11.prod.outlook.com/

Should this be corrected to igb_set_rxfh() to match the actual code?
