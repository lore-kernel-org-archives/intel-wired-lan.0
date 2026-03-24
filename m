Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B1CF54ADB
	for <intel-wired-lan@archiver.kernel.org>; Tue, 24 Mar 2026 17:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 886064108E;
	Tue, 24 Mar 2026 17:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oProIoZ_XzTH; Tue, 24 Mar 2026 17:09:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1EBE41087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1774372143;
	bh=jyHsLzXWaR2zRPbZGuPTHNB97BRLzepDzCHvvesUcbY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ihOQAsvFdibQQkiIWWoh/dig/6VSn0ohxYv/HMeMqRkvFtPUIQtpjzllawiBY8btj
	 rWOWkfhcwZ7oPwLpBQry4MrmaZSNIcrPc4N8lrjdm6vab2B1ioFONS6AaY6LnzjO6F
	 FKwlLUeuEjAuyfQiTJ7KltvnW/phZkGckLrRUTM+1P1oaZNPOOO9ZC4tLabKRv+lVg
	 uJ9lRHSb3oMv5NIsrbOQ0sU2+Z+wRZQDbNEbOm9oj0yIMhqT0IlwhkVgwWnzEnBpen
	 vROIEHdZ8BF5mlMYJ7W/laCxA9kKJjYfGO7hwWk+H8rDI2D5vcxe628SYsudgXnFO0
	 6rYRnaZawXniQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1EBE41087;
	Tue, 24 Mar 2026 17:09:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 77A41353
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 17:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5D53881F43
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 17:09:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rpd189-JUZvh for <intel-wired-lan@lists.osuosl.org>;
 Tue, 24 Mar 2026 17:09:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4CED081B6D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4CED081B6D
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4CED081B6D
 for <intel-wired-lan@lists.osuosl.org>; Tue, 24 Mar 2026 17:09:00 +0000 (UTC)
Received: from x1 (39.25.31.150.dy.iij4u.or.jp [150.31.25.39])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62OH8Sa1000982
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Mar 2026 02:08:29 +0900 (JST) (envelope-from kohei@enjuk.jp)
Date: Wed, 25 Mar 2026 02:08:28 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <acLExfyijq7HCEc4@x1>
References: <20260318163505.31765-1-aleksander.lobakin@intel.com>
 <20260318163505.31765-4-aleksander.lobakin@intel.com>
 <abripOPt4oVu-Ksb@x1> <abrzq5_S7p-YjqhE@x1>
 <1ec79e7b-50e8-4c64-9e79-fc377a505cfa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ec79e7b-50e8-4c64-9e79-fc377a505cfa@intel.com>
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=jyHsLzXWaR2zRPbZGuPTHNB97BRLzepDzCHvvesUcbY=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20251215; t=1774372110; v=1;
 b=JBlhowD/CR2vejrT+7U7Cxl5IYnPvFmZUiK3tbHfRagOgB7FoVa9MJ1xWBUGSHSd
 XTmWEs4NUzP3MSUn6swQFFM/wTR2uEXrAWQ4T8iMTELmZHefn6IBOGcOpz4lN1fu
 kPHcrgUMksSyFYHPatAhihvA1svL11+70oA+Q0M4ug8s73eq/zSlofVTBpryBTU2
 zLNmzNOW3yUp7Mowq1Yp/GACjryfTfwGEW0FTrgyREkCdInBpNQHieprh18+E95q
 P6u2VY9EQVIaJR4eIUlQLMgOL032xdm/2iFg4fDean0qnDnkwE5NIoieYHPhf06x
 R3lKQMhBZL3lgf7Uu5uEew==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=JBlhowD/
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 3/5] ice: migrate to
 netdev ops lock
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

On 03/24 17:56, Alexander Lobakin wrote:
> From: Kohei Enju <kohei@enjuk.jp>
> Date: Thu, 19 Mar 2026 03:56:19 +0900
> 
> > On 03/19 02:55, Kohei Enju wrote:
> >> On 03/18 17:35, Alexander Lobakin wrote:
> >>> Queue management ops unconditionally enable netdev locking. The same
> >>> lock is taken by default by several NAPI configuration functions,
> >>> such as napi_enable() and netif_napi_set_irq().
> >>> Request ops locking in advance and make sure we use the _locked
> >>> counterparts of those functions to avoid deadlocks, taking the lock
> >>> manually where needed (suspend/resume, queue rebuild and resets).
> >>
> >> Hi Alexander,
> 
> 
> Uff, sorry, I didn't notice this thread for some reason. Maybe it landed
> into the IWL folder in my mail client and I haven't checked it for some
> time... But I read LKML online on a daily basis and missed this reports =\

NP, thanks for taking a look!

Regards,
Kohei

> 
> >> After applying this patch (3/5) along with the preceding ones on top of
> >> net-next, I got some WARNING splats when changing the admin state
> >> (up/down) using the ip link command. [1, 2]
> >>
> >> Since I haven't looked into this series in detail, I'm reporting the
> >> splats anyway. 
> >> I'm wondering why I haven't seen anyone report this type of issue up to
> >> v3. Maybe there is something wrong with my setup or devices?
> >>
> >> Device: Intel Corporation Ethernet Controller E810-XXV for SFP (rev 02)
> > 
> > Ah, I think I figured out the reason. My adapter accidentally fell into
> > safe mode. When the adapter is in the safe mode, netdev->queue_mgmt_ops
> > == NULL and netdev->request_ops_lock == false, so
> > netdev_assert_locked_or_invisible() complains about not holding the
> > netdev lock.
> > 
> > Setting netdev->request_ops_lock = true in the safe mode path also
> > worked fine for me.
> > 
> > ---
> > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > index 9ef258d5ab48..3477c53316ba 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > @@ -3519,6 +3519,7 @@ static void ice_set_ops(struct ice_vsi *vsi)
> > 
> >         if (ice_is_safe_mode(pf)) {
> >                 netdev->netdev_ops = &ice_netdev_safe_mode_ops;
> > +               netdev->request_ops_lock = true;
> 
> This fix looks good to me, thanks!
> 
> >                 ice_set_ethtool_safe_mode_ops(netdev);
> >                 return;
> >         }
> 
> Tony, could you please pick it up to patch 3/5 when sending a new PR?
> 
> Thanks,
> Olek
