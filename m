Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2F0EB64DD
	for <intel-wired-lan@archiver.kernel.org>; Fri, 21 Jul 2023 22:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6952B83260;
	Fri, 21 Jul 2023 22:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6952B83260
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1689978665;
	bh=X5bJV61iZ8tcQ2IgTQeWnP/IANusmgA1zWh5DC5qkVM=;
	h=From:To:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=C0Z68H47Z2JBXiB6Ee6UgpqZtANawy3ewSa3IWI2bBITVS329tSs3J9nNZwxxe4Es
	 Lvn9+eZL1DB1yHWJgRbIpT6W4jTZVvOLXPH2nTG+hgG1d4zaxIBoIdAvB6UNLnBI7i
	 We2RnTbQiR8zYzq48pa8Xm+MXy2k54IY2yPq20c19F5qwLh9+mzODhnb7+iDTmqOPJ
	 QPq4q9SipQVLF2ig0DfC5QHhu2JL0W8G3BLNC2jQ0HZ7R7eSBcx1U9CeAyV/15TkXU
	 hGb44khYVGlcYpHs+ZudDJg1dPf/F9a84/5JxszRRFd9jp9a3lKB+mSAbn7NpHrjfY
	 BYP6u3XrwdAOg==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZxZrKnmet9f0; Fri, 21 Jul 2023 22:31:03 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89B56838ED;
	Fri, 21 Jul 2023 22:31:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 89B56838ED
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 8F3A71BF982
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jul 2023 17:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E40C4055E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jul 2023 17:58:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5E40C4055E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K8cxjY8AKusB for <intel-wired-lan@lists.osuosl.org>;
 Fri, 21 Jul 2023 17:58:02 +0000 (UTC)
Received: from smtp.portwell.com (smtp.portwell.com [38.88.18.152])
 by smtp2.osuosl.org (Postfix) with ESMTP id 51E7B4036E
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jul 2023 17:58:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51E7B4036E
Received: from APTEXCH01.APT.local by smtp.portwell.com (MDaemon PRO v13.5.1)
 with ESMTP id md50002405511.msg
 for <intel-wired-lan@lists.osuosl.org>; Fri, 21 Jul 2023 10:57:59 -0700
X-Return-Path: easonl@portwell.com
X-Envelope-From: easonl@portwell.com
X-MDaemon-Deliver-To: intel-wired-lan@lists.osuosl.org
Received: from APTEXCH01.APT.local (192.168.0.243) by APTEXCH01.APT.local
 (192.168.0.243) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 21 Jul
 2023 10:57:59 -0700
Received: from APTEXCH01.APT.local ([::1]) by APTEXCH01.APT.local ([::1]) with
 mapi id 15.00.1497.012; Fri, 21 Jul 2023 10:57:59 -0700
From: "Eason  Lin (3383)" <easonl@portwell.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Neftin, Sasha" <sasha.neftin@intel.com>
Thread-Topic: Ubuntu Kernel 5.4 to support Intel I225
Thread-Index: Adm7ZthKb82qg0E7QY6QvI52QapUqQAymYWAAA0rsPA=
Date: Fri, 21 Jul 2023 17:57:59 +0000
Message-ID: <6a59df5ae6e346c3979dc7645c018ab5@APTEXCH01.APT.local>
References: <484b485adfa8430bb1436479d915bb81@APTEXCH01.APT.local>
 <4472b54e-79bf-8c1c-485b-88fc8bcb1e00@intel.com>
In-Reply-To: <4472b54e-79bf-8c1c-485b-88fc8bcb1e00@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.96.126]
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 21 Jul 2023 22:31:02 +0000
Subject: Re: [Intel-wired-lan] Ubuntu Kernel 5.4 to support Intel I225
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
Cc: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

Hi Tony,
Thank you for quick response.
Let's put Ubuntu aside and focus on i225 driver. Is it possible that you can help to write a i225 driver to support Linux Kernel version 5.4? Thank you again.

Best regards,
Eason

-----Original Message-----
From: Tony Nguyen <anthony.l.nguyen@intel.com> 
Sent: Friday, July 21, 2023 10:13 AM
To: Eason Lin (3383) <easonl@portwell.com>; intel-wired-lan@lists.osuosl.org; Neftin, Sasha <sasha.neftin@intel.com>
Cc: jesse.brandeburg@intel.com
Subject: Re: Ubuntu Kernel 5.4 to support Intel I225

On 7/20/2023 5:07 PM, Eason Lin (3383) wrote:
> Hi Intel Ethernet Driver team,
> 
> Hope this note finds you well. This is Eason, a Technical Project 
> Manager from American Portwell, and here is our website in case you 
> want to refer. https://portwell.com/ <https://portwell.com/>
> 
> We know starting from _Kernel 5.8_ Intel i225 can be supported. 
> However, is it possible that you can make _Kernel 5.4_ to support i225 as well?
> We have such request from certain customers, so would like to see any 
> possibility.
> 
> Are you able to consider it? If yes, of course we can discuss about 
> term and condition, plus any fee incurred. Thank you so much and any 
> of your response will be appreciated!

Hi Eason,

The Ubuntu kernel is not something under our control. I would advise you check with Canonical/Ubuntu about enabling i225 support in their kernel.

Thanks,
Tony

> Best regards,
> 
> Eason
> 
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
