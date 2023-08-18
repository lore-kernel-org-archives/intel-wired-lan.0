Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96099EE4992
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Aug 2023 21:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFFF0840DB;
	Fri, 18 Aug 2023 21:03:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EFFF0840DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1692392593;
	bh=827aILc5Zbg+qISoYkzJBBN/W0cFbHgaT4gtxrv+vtc=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=4IWG/MLWNryOu0fT8fVJ2QpZlevoUoyNYBbPw2706fmXlWdXUvVDxBjDl89KrZzgp
	 SXoPjePjoyk8+RWZp7lxoLCy1Db8I5zJVUMCGLbL0IOT2zIH8qdzNcTcGM1RMg6GJC
	 kPJWj0qUogUd8RN6dvAKIPHiBdLTdcw7WTOEiajfc/YUpnQV0NjjF3+/1donpAHtTA
	 jgwTO/lRR/loZHdO2jgIyfMrS1jiQu7BPNeyn3j3dkVdfnmudUB9dvjRM0vBraU+0c
	 OL6EX7D/J8m+oNrd+pVqA5G9mO/YPAplrH6txjy1YPl1TzO4shYG9CcirRsHmwHHkf
	 X9PqVH376kxfQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOuuEQ8-A7kN; Fri, 18 Aug 2023 21:03:12 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3112840DC;
	Fri, 18 Aug 2023 21:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3112840DC
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id B1E3F1BF31D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 21:03:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89735419AC
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 21:03:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 89735419AC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 66Q45nJWEbAs for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Aug 2023 21:03:07 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8E78240127
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Aug 2023 21:03:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8E78240127
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 72F73645F3;
 Fri, 18 Aug 2023 21:03:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C68C433C8;
 Fri, 18 Aug 2023 21:03:05 +0000 (UTC)
Date: Fri, 18 Aug 2023 14:03:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Message-ID: <20230818140304.11f316c9@kernel.org>
In-Reply-To: <DM6PR11MB4657374BF0A9361647444D239B1BA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
 <20230814194528.00baec23@kernel.org>
 <43395307-9d11-7905-0eec-0a4c1b1fc62a@linux.dev>
 <ZNtm6v+UuDIex1+s@nanopsycho> <20230815100203.4e45fc7e@kernel.org>
 <DM6PR11MB4657374BF0A9361647444D239B1BA@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1692392585;
 bh=HHxNOIqgqP6yYIqo8lV6m5wy51W8npjOcTEiKx/jJO0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UQ1G45rnUtbvnxhcsWbx94oyx/wuL9JR9EKknlg1Rfs7gLKRAS21Q1lpWqWQvVRC2
 iOmH4tn0t06UkvIGfIt+2qfahKr1Kz03lQErN6upF0ZVjlOvvnUINWvnIpjnCzbm3B
 RaAlSN+ps5J0EQHtpdCz20fhEHxYKPQesS9UOYpobQyA84U55WUl3u/Lm0bdY22FlQ
 oZYz1T7zmnqkYOAEPY2jRBxMOPmdMuLw74TamIhMLB+kdrQiUtI1bxD8a/znjgNI8E
 qJYqUziTnO9PQbKD3EoJqkvBNygwT85YbrzZzFfLp6OuVrrp6SK/x00Qcw0CUzCqnU
 LPis6trKOy8ew==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=UQ1G45rn
Subject: Re: [Intel-wired-lan] [PATCH net-next v4 0/9] Create common DPLL
 configuration API
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
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Bart Van Assche <bvanassche@acm.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Paolo Abeni <pabeni@redhat.com>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "Olech,
 Milena" <milena.olech@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, 18 Aug 2023 10:15:34 +0000 Kubalewski, Arkadiusz wrote:
> HW agnostic tests were submitted by Michal as RFC for test framework
> with fake modules implemented here:
> https://lore.kernel.org/netdev/20230817152209.23868-1-michal.michalik@intel.com/#t
> We had an agreement on latest dpll-meeting that we will follow up with
> patches that would test dpll over fake modules, and we have started it.
> As there was no requests to add HW-aware tests yet, we are not ready for
> such submission yet. We could probably extended Michal's framework to
> make it possible test real HW, but Michal's patches were just submitted,
> we do expect some review/changes there, thus we could think of adding
> something simpler for now..
> 
> Is simple bash script wrapping around cli.py and talking to ice dpll
> while verifying the outputs, an acceptable solution?

Okay, it is what it is, let's leave tests as follow up.

I'll reply to Michal on the RFC thread/
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
