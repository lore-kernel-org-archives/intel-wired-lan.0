Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0F0CD8CA8
	for <intel-wired-lan@archiver.kernel.org>; Mon, 15 Jun 2026 01:31:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD68B60B4C;
	Mon, 15 Jun 2026 01:31:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p-h5u9S_6XkS; Mon, 15 Jun 2026 01:31:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8662C60AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781487074;
	bh=M483btWre2cnhhj8gL56GG70ENRhHk5py6rwm6CMRmU=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mQiTVX1IoyLiTrxZw8iXhe30uwiLnTtXgt4mCl8UfJLOYMXfxWpoavb6l4I7YZnkD
	 mM/0AkmC0UrhQ3nCvQ30Ni5EXqfPNoqva13PkimDAn/zmGMRa9YDHiq3kH32yUeMG0
	 3eEyhasnUuNudifmyp2Y6cvtHsCvJtU2/4hMDs//vRXvwsIiJde3bJ0Z5Qn8aSmgXq
	 L3+l8iy2IIYnb1uiBdI6qEvhnxPKgm5/Qi/IFQDHUE7ODhrK73at3IVApIaaYT88La
	 R6hQk8+OeWWnDSW8HdVdt0OrM48txWyWpOmIfx5seLA07qQ/JG8og1mFcZMAyP0Vk0
	 Hf8q4Z1t/I1Vg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8662C60AEA;
	Mon, 15 Jun 2026 01:31:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5A74B169
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 01:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 442C640520
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 01:31:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LXD0QOwBAOIC for <intel-wired-lan@lists.osuosl.org>;
 Mon, 15 Jun 2026 01:31:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=220.197.31.4;
 helo=m16.mail.163.com; envelope-from=clementwei90@163.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CE71D403F0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CE71D403F0
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CE71D403F0
 for <intel-wired-lan@lists.osuosl.org>; Mon, 15 Jun 2026 01:31:11 +0000 (UTC)
Received: from [10.42.20.136] (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBXRPIwVS9qIyKeDA--.149S2;
 Mon, 15 Jun 2026 09:28:18 +0800 (CST)
Message-ID: <6a4bb07e-dbfb-4017-b0c3-b01ef2fc5432@163.com>
Date: Mon, 15 Jun 2026 09:28:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrew Lunn <andrew@lunn.ch>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Rongguang Wei <weirongguang@kylinos.cn>
References: <20260612080331.120096-1-clementwei90@163.com>
 <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
Content-Language: en-US
From: Rongguang Wei <clementwei90@163.com>
In-Reply-To: <1578c474-ffbf-46f7-b906-49da4ea48142@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBXRPIwVS9qIyKeDA--.149S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1UAF48JrWxGw17Xr17trb_yoW8tF45pr
 47Xa4qyF4UXr9Fg397Jw18Ary5X397t3yfCF4fuw1Ygr95JrWvqF1xKFWUGF1avwsrurWa
 vF1jvasxAan8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcSdkUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-hLHM2ovVTLRgQAA3q
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=163.com; 
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
 Content-Type; bh=M483btWre2cnhhj8gL56GG70ENRhHk5py6rwm6CMRmU=;
 b=N7Eeqduo/7+BR2+dxEpXDvc7w9quwS9MrtopAynm951PhPbQiXEY9d0IHyyMgW
 nVom+bFZ+bQID10cltGcxkj+0OoIg/pXFcPfI0IinZFiRPWD+176wnUcAUFUnaON
 WUXnuJpD87XBuKEC6z1l1NS/w9yxbn4SSXYkBUCS7Pz88=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=163.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=N7Eeqduo
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



在 2026/6/13 03:39, Andrew Lunn 写道:
> On Fri, Jun 12, 2026 at 04:03:31PM +0800, Rongguang Wei wrote:
>> From: Rongguang Wei <weirongguang@kylinos.cn>
>>
>> The phy_data variable is not initialized. If e1000_read_phy_reg
>> returns an error, phy_data will not point to a valid value from
>> the PHY register, which may cause the regs_buff array to be populated
>> with unexpected values.
>>
>> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
>> Change-Id: I46071b3b21a566f8da650168d38d6968251b077d
> 
> What does this Change-Id mean?
> 
Sorry, it just a auto generate id when I push this patch on my own repos.
I forget to delete.
>> ---
>>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> index 4dcbeabb3ad2..f068108c5004 100644
>> --- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> +++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
>> @@ -327,7 +327,7 @@ static void e1000_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
>>  	struct e1000_adapter *adapter = netdev_priv(netdev);
>>  	struct e1000_hw *hw = &adapter->hw;
>>  	u32 *regs_buff = p;
>> -	u16 phy_data;
>> +	u16 phy_data = 0;
> 
> 	if (hw->phy_type == e1000_phy_igp) {
> 		e1000_write_phy_reg(hw, IGP01E1000_PHY_PAGE_SELECT,
> 				    IGP01E1000_PHY_AGC_A);
> 		e1000_read_phy_reg(hw, IGP01E1000_PHY_AGC_A &
> 				   IGP01E1000_PHY_PAGE_SELECT, &phy_data);
> 		regs_buff[13] = (u32)phy_data; /* cable length */
> 
> Isn't a cable length of 0 also unexpected?
> 
> How does this patch actually make the situation better?
> 
Uninitialized variables may be initialized to 0 by the system, explicit initialization
is performed to avoid accidents. 

The 0 is from e1000_read_phy_reg_ex in e1000_main.c and e1000_power_down_phy when use
e1000_read_phy_reg function the last paramenters is initialized 0. So I used this value.

There are many other function which use e1000_read_phy_reg also not initialize the last paramenters
eg. e1000_phy_reset_clk_and_crs. I can do it in V2.
>     
>     Andrew
> 
> ---
> pw-bot: cr

