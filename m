Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C030F8D763
	for <intel-wired-lan@archiver.kernel.org>; Thu, 16 Apr 2026 17:50:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D734D60866;
	Thu, 16 Apr 2026 17:50:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G8cO0LS__LcI; Thu, 16 Apr 2026 17:50:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CE0760822
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1776361829;
	bh=zXhWQiWYqhCW6r3ekdup8+QEuKfSdHIfYm4xq2OKTH4=;
	h=Date:To:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=Kt7Ja/kf2OIY+Ahbe1w+GdUTpFNDlpTXbv9R2HHR2D8SPC14nNcZ2eRr/uITUNseO
	 mhpa03zflWDwC5dkN8X2p3nzclp0yOVPa7sozIQ66vVCEPGE2PkNQhfwxu/xGLUFUK
	 Q7jYLczStJxePZohk2JWPu4shmp+HqNPEtnBgerl98NmnR9C77TzuIyLHlujCEO/fQ
	 KgQ0KBBIjn+BrAhslKsnYKGpZDdfzu/H9tBT8/vhZcGSfdbnem49lZh8COFllr96gP
	 1zFOLfKrdJi1jFpq0yZO9MwHEHLhziAwQ2jw/dApBW+PYV5VrWvRhgNzzIPq648Co5
	 9rb/elJt0FXSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CE0760822;
	Thu, 16 Apr 2026 17:50:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DF5FC2CF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 17:50:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5A6160787
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 17:50:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Olyg9wVOs-Pl for <intel-wired-lan@lists.osuosl.org>;
 Thu, 16 Apr 2026 17:50:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com;
 envelope-from=vadim.fedorenko@linux.dev; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 44E9760822
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44E9760822
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 44E9760822
 for <intel-wired-lan@lists.osuosl.org>; Thu, 16 Apr 2026 17:50:23 +0000 (UTC)
Message-ID: <919ce78a-45fc-4f4c-817b-154dd7c1cd00@linux.dev>
Date: Thu, 16 Apr 2026 18:50:09 +0100
MIME-Version: 1.0
To: Petr Oros <poros@redhat.com>, netdev@vger.kernel.org
References: <20260416113952.389405-1-poros@redhat.com>
 <20260416113952.389405-2-poros@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260416113952.389405-2-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.dev; s=key1; t=1776361819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zXhWQiWYqhCW6r3ekdup8+QEuKfSdHIfYm4xq2OKTH4=;
 b=QiPVSyrejWyDHsNCEaiyiEI3lF/sWkn4f2E0ZTkTmh1mRiAXZke8yGWHta7//8qfE1RcSb
 4PsGSupK9A/Ti4o32zaomK3MBDt3jSHTa2SJcIbFW54xgOQY2ZyV8DkPfKdOM5dvBHHey5
 gO8RelDJx7140pEpKUOHav+cVsip4Ks=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linux.dev
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=QiPVSyre
Subject: Re: [Intel-wired-lan] [PATCH net v6 1/2] dpll: export
 __dpll_pin_change_ntf() for use under dpll_lock
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
Cc: Ivan Vecera <ivecera@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Rinitha S <sx.rinitha@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Simon Horman <horms@kernel.org>,
 intel-wired-lan@lists.osuosl.org, Jacob Keller <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On 16/04/2026 12:39, Petr Oros wrote:
> From: Ivan Vecera <ivecera@redhat.com>
> 
> Export __dpll_pin_change_ntf() so that drivers can send pin change
> notifications from within pin callbacks, which are already called
> under dpll_lock. Using dpll_pin_change_ntf() in that context would
> deadlock.
> 
> Add lockdep_assert_held() to catch misuse without the lock held.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Petr Oros <poros@redhat.com>

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
