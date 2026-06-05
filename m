Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B066CD6E7E
	for <intel-wired-lan@archiver.kernel.org>; Fri,  5 Jun 2026 23:26:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E84261175;
	Fri,  5 Jun 2026 23:26:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W9vychMz3sjj; Fri,  5 Jun 2026 23:26:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F2F8610E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1780701980;
	bh=IG96N48IaU0YB7Fwkuesk+PO+SJtj7KaqjiAzFCI5Ao=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AUS2T8zZfWPpi12y0PzXCQEsrzXse5QMKvgp+4W/UbIBNTVrFK76ByrAhh+MvHgk6
	 jlVebado+aK68KH00SKrqotdsUw1UyJEzBeGdqenYiVlmSywxH6GeTyB/YiaCS4R+9
	 jyxXNN1GWLsOZeNeTcAVMigXa4Fi1ciP6eWJr1K16gdQcQaZx1XvYfbmIm9Fc82LZk
	 HxnQucSkjoc4XeSa9dLejVZa12L0kvniQGKhS/1CeIKr2dOauNkLm3Q+XYDO4N/w5o
	 6TuOZ6IG2gJMLedDtDBVkQ/LeI4rxJG8K1ynQy0RI6wDWA8iVmpuhDlMRtqy9z7N5B
	 fOYLCuMKjmnzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F2F8610E4;
	Fri,  5 Jun 2026 23:26:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5A45187
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 23:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B36840697
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 23:26:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i9kQOKyfYKLS for <intel-wired-lan@lists.osuosl.org>;
 Fri,  5 Jun 2026 23:26:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=kuba@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BA06D40636
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BA06D40636
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA06D40636
 for <intel-wired-lan@lists.osuosl.org>; Fri,  5 Jun 2026 23:26:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10D744324E;
 Fri,  5 Jun 2026 23:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29FBD1F00893;
 Fri,  5 Jun 2026 23:26:16 +0000 (UTC)
Date: Fri, 5 Jun 2026 16:26:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nitka, Grzegorz" <grzegorz.nitka@intel.com>
Message-ID: <20260605162615.0987ff2a@kernel.org>
In-Reply-To: <IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
References: <20260529142628.1678955-1-grzegorz.nitka@intel.com>
 <20260603183036.7c4762d2@kernel.org>
 <IA1PR11MB62197FC8E64BE92FBC108E6992102@IA1PR11MB6219.namprd11.prod.outlook.com>
 <20260604155422.167314ff@kernel.org>
 <IA1PR11MB6219C1EF3BF8160226E5826992112@IA1PR11MB6219.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1780701976;
 bh=IG96N48IaU0YB7Fwkuesk+PO+SJtj7KaqjiAzFCI5Ao=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=E7403+OodPvRrNF8Mu0tD+WtYtsyw6n74A4QVl6z/iRe4WKlz9LJkPJfmpHf8WcEk
 1RoDOPsMm31w8ml9+DhR3SJuo4i5omE65p5UL1zp/fKi3IRzx7dAgtqZ5rB2T8JHCX
 Dz9pAASe2FCFJq9BUaXNeKC2l5HTg31yR9IBmDe20nYxJ4F0p0oVMy8Xo4U2YnDTVd
 aPuAr9BrPNqhLX/3NoBy45reAkNQtPNpTS8l5iFhQ1GBAUwCeD17ddf7dnSCNsbjhD
 d1AN7RDTojfSWFZDgAjDYl2DNqgpHj0oojBw5JQooiRDROVnTS9avrCEA2JPartTrY
 rZpFXnToUrJMg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=E7403+Oo
Subject: Re: [Intel-wired-lan] [PATCH v12 net-next 0/8] dpll/ice: Add
 generic DPLL type and full TX reference clock control for E825
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
Cc: "Vecera, Ivan" <ivecera@redhat.com>,
 "vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
 "jiri@resnulli.us" <jiri@resnulli.us>,
 "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kubalewski,
 Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "Prathosh.Satish@microchip.com" <Prathosh.Satish@microchip.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "horms@kernel.org" <horms@kernel.org>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "Nguyen,
 Anthony L" <anthony.l.nguyen@intel.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 5 Jun 2026 16:10:19 +0000 Nitka, Grzegorz wrote:
> Hi Kuba. Just submitted v13.
> 
> It includes the following fixes for pre-existing issues:
>   - dpll core fixes. Each AI review concern (3) is addressed in separate
>     commit. If you think it's better to squash them, let me know (however
>     it addresses issues from two different 'old' commits).
>     Also, the hint form AI  to use different dpll xa_array (parent not pin) to
>     address one of the issues, it simply does not work (WARNING flood observed,
>     more details in patch 3/11)
>   - ice driver fix for potential hung on flush_workqueue in error path for FW node pins
> 
> As you noted, two other pre-existing issues are covered by ICE_FLAG_DPLL.
> I left the code as it is for those concerns.
> There is one more pre-existing one, related to ice_ptp_link_change. As the fix seems to be
> rather simple one, I believe I need more time for more comprehensive testing.
> So my preference is to go with standard fix-path on 'net'.

SG, thanks!

BTW either you or Arkadiusz should chime in on the NCO thread, please:
https://lore.kernel.org/all/20260531194423.383366-2-ivecera@redhat.com/
Shouldn't take much time to express an opinion, I hope.
