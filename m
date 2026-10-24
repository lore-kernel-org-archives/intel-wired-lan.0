Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDEE606A322
	for <intel-wired-lan@archiver.kernel.org>; Sat, 24 Oct 2026 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=iNCp5vX7;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=e31LB5AQ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5FE2816D3;
	Sat, 24 Oct 2026 16:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AEOZ7dCz_Hha; Sat, 24 Oct 2026 16:48:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C7A2C815D1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792860488;
	b=bv2b2A/RsmGkFpgsReJR0PkUgn8oybXTrhuZROoCRUF2g4pInaiABtmgGAjUqac5ahK8
	 Z9Cxxe+hw/zXo8EBRithEqDK93tltvnj5IJCXaqD/vNEzEsRrPZRsGurc1As4voGPRXNV
	 mDBHOF38P1ODKve4bSh70on+gClmBTzZjpYgEyORnPyPSn+zR5OcNK+hPdmGiQ+ICQh57
	 CpNeguNQC8iSWdqys6Jj4npTXHTZMtN0qPYWMxcRfjZU6nPR024/mxTImYa8OOJlaXQ+2
	 Ph5UpFU5UTTzuzbTZ6yeW3VWsn1cKmBhdM6av+kWE7fubn64c1OAagKi1kJYx0s1dvg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792860488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mbU9X2UNU9qtZBr/wdUxFxhl8PrMpPVNXDJWyqmuRX4=;
	b=L5ajMXRQd7XaKUNhJ1yA6O6iC2ggAridqCq0UG+tMTSWmtqBAIJ8+1wF9wLofEuCxJC6
	 j6aKDMwjmOV4lSbeb/dK8hNQZYyTKX5IFEYI7GogcQTaSsQ/pIILt5lsoZ5fq7g4RdA22
	 JoJ+ElWTDeNSx9WLnouDt3M0ozPtZxFiHX6DZYXd81XPGdOOblp/ZfWMNjBp+NeRocWvG
	 XtTrKBUceUEk0YUjZlhLFhL044FjqGi+naSpGYjHhYmo/Cl5uuK3WCNNritp6XY+PXsrI
	 mFQIxh5XCwiBSti5DcNrXn9tqQnxh2EugEWrcfZIajh2k0ru5OHy0pBH18sjKkMcbTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792860488;
	bh=mbU9X2UNU9qtZBr/wdUxFxhl8PrMpPVNXDJWyqmuRX4=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iNCp5vX7Kt+q3ETSa6tXXiAJi/Clo8rlAh7ozDnSWGTchj5Dl6mBJ5XvAz9Z6sU5a
	 IP/32oHAC8Kg5kpdmhQlxmhascy+QXBZJ6myKmx1C6xLjf0hhZXt0ZUNiIdzeklu5A
	 GY0EgHyB8hiBAOp9ctpDZXDW/Y/2a9Q4Umyg3GsRV3p3HOvFngzDV9lWp+dVGHCy6O
	 NCsJm58Ry5XigIl6hA6gj4zoVMXyrGhRFPWeURfM04tHE4VCDBco9oBIxcUnvIqXOV
	 jbPoCm8d1X/Xj4jdG3BxxS9XTLlm0uuBgsPNgt+l8rrMRyDpmzJanfpOLUGUTqn2zh
	 YR5XhzrB+2Krg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C7A2C815D1;
	Sat, 24 Oct 2026 16:48:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F0CB04D1
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 16:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E26D760648
 for <intel-wired-lan@lists.osuosl.org>; Sat, 24 Oct 2026 16:48:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WtOsz9y9NeA4 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 24 Oct 2026 16:48:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1FB560638
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792860485;
 b=Zwzkw6SRG+Awm3Ztg3MAhp9DpMVlrPfMAUVpQ59wH1oKrtM0JQUiENYcALlIDTC42yFn
 7vxhp+xnR2SiLIFWIDqJZW50aphLy/OXKsjiu1knE5dlubxDydac+ZaAauBNRb+0wuyDx
 VvGwrIa0PvzXvTdVV8Ej9ASYOm+jeoUdPiM9AyzUB+SJh6ognIDbA/+p1MtIezI1M3ov5
 fa83vKbO+7Wctpx5lEFVZBrvN3UwPP0qlaGNnfwJyiSh3+7Jo0IgDPBW6jRHFizUKvzF3
 zBcjzN0zJ5/Pg0TcEk7vTXuO6g9z0wCGCc7QzU2MJm64Y/7M3jnVtbXce/UPu1+/sxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792860485;
 h=X-Greylist:Received-SPF:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:References:Content-Language:Cc:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=mbU9X2UNU9qtZBr/wdUxFxhl8PrMpPVNXDJWyqmuRX4=;
 b=WD/lmnEhqtzoqbbMj0nE4ZoB/FmotT+qGjmalIqsJ8fT9EYu0wbnvaWA1X8AZtlOYxfQ
 Al/5nU4hepS6yEYKx9RosgcliGMJjCHOeix35Y+mBhRBcr5Qep3ohxzdJUz15z5p4sF8c
 ZOqi4T9135P5/O47+AhkgSvuypXEm9YDMiC3hDv+Ism+zUh9u//HNc76lrpiYszyIUAg3
 5NtcSNbzqSdM+NeZWpticJqTucYnIfbi6y7cwE5u7WIWhw+HuhYOjqUoGU6qMN/oZQqZJ
 SGxM1Y3t651QL0PtcF+zn6LT0VvBUueTDlwDiLX2Vo13Pwwp0Xh1J1QhPL8bGuUkXpw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=molgen.mpg.de;
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=e31LB5AQ; 
 arc=none smtp.remote-ip=141.14.17.11
X-Greylist: delayed 468 seconds by postgrey-1.37 at util1.osuosl.org;
 Sat, 24 Oct 2026 16:48:02 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=e31LB5AQ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E1FB560638
 for <intel-wired-lan@osuosl.org>; Sat, 24 Oct 2026 16:48:02 +0000 (UTC)
Received: from [192.168.0.5] (ip-095-090-245-100.vkd79.pools.vodafone-ip.de
 [95.90.245.100])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3201B4C4047E65;
 Sat, 24 Oct 2026 18:40:08 +0200 (CEST)
Message-ID: <b48f890c-c5e3-47f3-bec4-08a442dad168@molgen.mpg.de>
Date: Sat, 24 Oct 2026 18:40:07 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [iwl-next, v1] igc: remove unused igc_update_nvm_checksum()
To: Sasha Neftin <sashaneftin@gmail.com>
References: <20261024163701.134489-1-sashaneftin@gmail.com>
Content-Language: en-US
Cc: intel-wired-lan@osuosl.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261024163701.134489-1-sashaneftin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1792860008; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=mbU9X2UNU9qtZBr/wdUxFxhl8PrMpPVNXDJWyqmuRX4=; 
 b=e31LB5AQ0NPHb6HhS3iHvOb9zTB1rjmQmk//jjdlxMSi51MTnLxQ5Lhrh+OVQ4Pdl3mfgNmtfLhT
 BFCIW4Iatvrinmuzn83HtFPz0QIfGNFOSe+G97KCKr4jZFZVWLoONR7T6pBBFW2sFyXNChkh3DhgQL
 4LQ2Fz3f4rSmg7lYb+Ky6VDzX4kwzTvD5aIxi1VD09Ha4xqhpsAnlSCsH573GBnhxAYpZQFkr1R08R
 nXtC5vIsJMSOtST+nTivjR9QKo0DGH6t9tMit2bxyWoL2YE6fGcjN5D0qXqRUsgwbLZuoE0MPs5IUs
 Tw8w1a1PxegHf0ozvBJKm5c73sxDQdIA==
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dear Sasha,


Thank you for your patch.


Am 24.10.26 um 18:37 schrieb Sasha Neftin:
> igc_update_nvm_checksum() has no callers in the tree. The i225 NVM
> operations use their own implementation, igc_update_nvm_checksum_i225(),
> which is what nvm->ops.update points to in igc_init_nvm_params_i225().
> 
> Remove the dead generic function and its prototype from igc_nvm.h.
> While at it, add the include guard name as a comment to the closing #endif
> in igc_nvm.h.
> 
> No functional change.

Add a Fixes: tag, so it’s easier to review the change, making the 
function unused?

> Signed-off-by: Sasha Neftin <sashaneftin@gmail.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_i225.c |  4 +--
>   drivers/net/ethernet/intel/igc/igc_nvm.c  | 31 -----------------------
>   drivers/net/ethernet/intel/igc/igc_nvm.h  |  3 +--
>   3 files changed, 3 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_i225.c b/drivers/net/ethernet/intel/igc/igc_i225.c
> index 5226d10cc95b..0971debca3a4 100644
> --- a/drivers/net/ethernet/intel/igc/igc_i225.c
> +++ b/drivers/net/ethernet/intel/igc/igc_i225.c
> @@ -220,7 +220,7 @@ static s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
>    *
>    * Writes data to Shadow Ram at offset using EEWR register.
>    *
> - * If igc_update_nvm_checksum is not called after this function , the
> + * If igc_update_nvm_checksum_i225 is not called after this function , the
>    * Shadow Ram will most likely contain an invalid checksum.
>    */
>   static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
> @@ -275,7 +275,7 @@ static s32 igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
>    *
>    * Writes data to Shadow RAM at offset using EEWR register.
>    *
> - * If igc_update_nvm_checksum is not called after this function , the
> + * If igc_update_nvm_checksum_i225 is not called after this function , the
>    * data will not be committed to FLASH and also Shadow RAM will most likely
>    * contain an invalid checksum.
>    *
> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.c b/drivers/net/ethernet/intel/igc/igc_nvm.c
> index a47b8d39238c..b69889bfeb42 100644
> --- a/drivers/net/ethernet/intel/igc/igc_nvm.c
> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.c
> @@ -132,34 +132,3 @@ s32 igc_validate_nvm_checksum(struct igc_hw *hw)
>   out:
>   	return ret_val;
>   }
> -
> -/**
> - * igc_update_nvm_checksum - Update EEPROM checksum
> - * @hw: pointer to the HW structure
> - *
> - * Updates the EEPROM checksum by reading/adding each word of the EEPROM
> - * up to the checksum.  Then calculates the EEPROM checksum and writes the
> - * value to the EEPROM.
> - */
> -s32 igc_update_nvm_checksum(struct igc_hw *hw)
> -{
> -	u16 checksum = 0;
> -	u16 i, nvm_data;
> -	s32  ret_val;
> -
> -	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
> -		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
> -		if (ret_val) {
> -			hw_dbg("NVM Read Error while updating checksum.\n");
> -			goto out;
> -		}
> -		checksum += nvm_data;
> -	}
> -	checksum = NVM_SUM - checksum;
> -	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
> -	if (ret_val)
> -		hw_dbg("NVM Write Error while updating checksum.\n");
> -
> -out:
> -	return ret_val;
> -}
> diff --git a/drivers/net/ethernet/intel/igc/igc_nvm.h b/drivers/net/ethernet/intel/igc/igc_nvm.h
> index ab78d0c64547..d5f1f1a449eb 100644
> --- a/drivers/net/ethernet/intel/igc/igc_nvm.h
> +++ b/drivers/net/ethernet/intel/igc/igc_nvm.h
> @@ -7,6 +7,5 @@
>   s32 igc_read_mac_addr(struct igc_hw *hw);
>   s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
>   s32 igc_validate_nvm_checksum(struct igc_hw *hw);
> -s32 igc_update_nvm_checksum(struct igc_hw *hw);
>   
> -#endif
> +#endif /* _IGC_NVM_H_ */

I’d prefer a separate change, but clean-up commits are frowned upon in 
this subsystem.


Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
