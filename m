Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4077DC7EE2F
	for <intel-wired-lan@archiver.kernel.org>; Wed,  7 Jun 2023 15:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D000C8210D;
	Wed,  7 Jun 2023 15:12:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D000C8210D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1686150740;
	bh=r/Qx8zzjJ8QJZqRLrLjh6g1xM4S2lEp+theTwQ4qgmo=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=zU/ti+WtL+mT7uNnYCH70rRg7G5FX5mvxzF2V960tb/60WHy9YeWhYgO650iv/qsC
	 rKU2Axv0efQgqoiw+7pHnafSKFC2MG8aVuCNYPVqyrw7lvDbX7OlKgZDI9BCnuW7G9
	 uJD2+g5UbJ6PKEH+r+y+QJsOAsfsCLrUMpowuFz2qJnVKR9NYNdMPMjM/KT9JhLJXv
	 5sVZis4MONcIIxQcxLnYGshKYVcxFekJkseLCahI7MCiPq6Bu3du0n0YCQxTZinJeb
	 4YFXcq05MWdUjV3PCbonwT19HyEjn1v6xUXqLIbukUlhxjplcM7owymEPkk/aE4LmS
	 u5/m7C1HmcIhA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w44ostair4Lz; Wed,  7 Jun 2023 15:12:20 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 97ECC81E2E;
	Wed,  7 Jun 2023 15:12:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97ECC81E2E
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id D8EDA1BF3E0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Jun 2023 08:48:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 84DFF82098
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Jun 2023 08:48:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 84DFF82098
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y20yMWyUjZ0x for <intel-wired-lan@lists.osuosl.org>;
 Wed,  7 Jun 2023 08:48:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B78C882095
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B78C882095
 for <intel-wired-lan@lists.osuosl.org>; Wed,  7 Jun 2023 08:48:19 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; d="scan'208";a="155909736"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 07 Jun 2023 01:48:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 7 Jun 2023 01:48:15 -0700
Received: from DEN-LT-70577 (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 7 Jun 2023 01:48:14 -0700
Date: Wed, 7 Jun 2023 08:48:13 +0000
From: Daniel Machon <daniel.machon@microchip.com>
To: Dave Ertman <david.m.ertman@intel.com>
Message-ID: <20230607084813.qc3mtpxlavputju7@DEN-LT-70577>
References: <20230605182258.557933-1-david.m.ertman@intel.com>
 <20230605182258.557933-8-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230605182258.557933-8-david.m.ertman@intel.com>
X-Mailman-Approved-At: Wed, 07 Jun 2023 15:12:04 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1686127699; x=1717663699;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fLHBK9PmihZK5WV+yHKsWwDeQtTTMPDtL/lE06zSvGQ=;
 b=P5SCcTYB48disvFxC2O5uAOmKd1a0PAp7ZIwx4g7mLNuAgP7vqwGBiu7
 1pskNfWTMp5l/N/iu5sFSxbckgTw6zcwPBz2B1/AehIzUvAe3Ap1gAs1g
 15ZNCKBkHS+fcXZnWaPLoZD3zvRFeDyKM8jYlrjFzb0GndZ7jKqbAZrbS
 /XKBjU7iXiwOnIDle7R8sTBDNGEv3tKau3V+TpuHegx/OcWoUFIKVuuc9
 XuJZ9KxrSAPQnz1VCzg9XkoZ+jOmFIDz3CBcTNuCbWEZAUx7n06dxDNZ2
 aPR0xpwymSjSkpkdnx+R8ePK0RbJqSfEOKsE+PWFO8oxK1FCHbMBLXGAX
 A==;
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=P5SCcTYB
Subject: Re: [Intel-wired-lan] [PATCH net v2 07/10] ice: support
 non-standard teardown of bond interface
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
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

> Code for supporting removal of the PF driver (NETDEV_UNREGISTER) events for
> both when the bond has the primary interface as active and when failed over
> to thew secondary interface.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
