Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C0BCD8CA8
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jun 2026 01:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 016F783089;
	Mon, 15 Jun 2026 01:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SrM9z48KNaIb; Mon, 15 Jun 2026 01:41:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1136783054
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781487661;
	bh=rkSJZJv6R0h/oeGm4YkXS/z977/uuGVq+lopNuX2gt8=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8max/Xw2EJQjaTcsoo0LUkeCymP/iuF9JVjRuOZaE4rWnutlZMmHaolwnLkQ60uxv
	 aCo7d/GEmexgeeJ7fQdtrfS7uOuTVikIztXOTaQbD2eKDV/A8zvCI5rlQQWKoPbziJ
	 rQSHvUrf9tx2VDH49fUX6NAEVASOQvw8D00Mp5vEhL+frUSbjmEjwkquZ4R7JZGAVj
	 7zyUptHghEsLYuSGRugqyGG7tvFSXHeaiJEEq0jMsp1ELS6ohoTotYcjK9aePKzJRq
	 B9qv/0v4FQ5wUKOrC3kCNzMyhJlvfP/F9XAYG2dP7aqYtjHPbmI7lRKw7OFXTHfjLS
	 QfyPeWHHnKAVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1136783054;
	Mon, 15 Jun 2026 01:41:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 789DE169
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 01:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A43183054
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 01:40:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NukeeE7mvIQZ for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Jun 2026 01:40:58 +0000 (UTC)
X-Greylist: delayed 742 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 15 Jun 2026 01:40:57 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 7471B83051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7471B83051
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=117.135.210.2;
 helo=m16.mail.163.com; envelope-from=clementwei90@163.com; receiver=<UNKNOWN> 
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7471B83051
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 01:40:57 +0000 (UTC)
Received: from [10.42.20.136] (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDnZ5caWC9q21ylDg--.7092S2; 
 Mon, 15 Jun 2026 09:40:43 +0800 (CST)
Message-ID: <9d3dfe98-676f-4a85-9e85-241f79ecfaea@163.com>
Date: Mon, 15 Jun 2026 09:40:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 Rongguang Wei <weirongguang@kylinos.cn>
References: <20260612080331.120096-1-clementwei90@163.com>
 <PH0PR11MB590263784927AAB47EE558BAF0182@PH0PR11MB5902.namprd11.prod.outlook.com>
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <PH0PR11MB590263784927AAB47EE558BAF0182@PH0PR11MB5902.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnZ5caWC9q21ylDg--.7092S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4xZFW3WryfWF4xJFykAFb_yoW8Cr1Dpr
 WUCa4DCr4UWr9Fga97Xw18ZF90k392qrWruF4fCw1Yg3s8JrWktr1xtF4UGryavw47C3y3
 JF1Yv3ZxA3Z8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uca9-UUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4huC7WovWBvqpgAA3c
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=rkSJZJv6R0h/oeGm4YkXS/z977/uuGVq+lopNuX2gt8=;
 b=jj/zqXFeTA0dWoN//f2z6vDL56BJfsqUUHvoSLib3FVpIsC85nYvjxKWoelmNX
 YwtnMDtWfd1i5QA364AKIP5ThuhMyli8owciGFTPiUQp265WAllpu4cvlr1f7DpO
 8rLYacTySYS97WF8/k8W68F7likyHtbeTiFE7hmGjvj2o=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=163.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=jj/zqXFe
Subject: Re: [Intel-wired-lan] [PATCH net-next v1] e1000: Initialize
 phy_data to avoid unexpected values
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



在 2026/6/12 16:58, Jagielski, Jedrzej 写道:
> From: Rongguang Wei <clementwei90@163.com> 
> Sent: Friday, June 12, 2026 10:04 AM
> 
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> The phy_data variable is not initialized. If e1000_read_phy_reg
>> returns an error, phy_data will not point to a valid value from
>> the PHY register, which may cause the regs_buff array to be populated
>> with unexpected values.
> 
> Hi,
> 
> Sounds like a fix, but i believe we would like to have any real
> scenario when the issue occurs and how it can be reproduced.
> If such is provided please target the patch against net tree and
> add fixes tag.
> 
Hi,
I was not face a real scenario. I just found out there is no check for 
e1000_read_phy_reg return value when I reading the driver code. 
Maybe is better to initialized the value or check the return value of e1000_read_phy_reg.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d
> 
> 
> i doubt this is a correct kernel commit tag
> 
>> ---
>> drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> index 4dcbeabb3ad2..f068108c5004 100644
>> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>> 	struct e1000_adapter *adapter = netdev_priv(netdev);
>> 	struct e1000_hw *hw = &adapter->hw;
>> 	u32 *regs_buff = p;
>> -	u16 phy_data;
>> +	u16 phy_data = 0;
>>
>> 	memset(p, 0, E1000_REGS_LEN * sizeof(u32));
>>
>> -- 
>> 2.25.1
> 

