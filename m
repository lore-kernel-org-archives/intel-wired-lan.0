Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76186C982CD
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 07:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 280B9607CE;
	Thu, 17 Sep 2026 07:14:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N3yo10yTHYCp; Thu, 17 Sep 2026 07:14:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 374026062B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789629295;
	b=kw9eSsgBhImG+gSl+Qg2NUKMLIzhr+UDbDe235PxXF1lpVJJsfpal6Maeacy3JtSDShp
	 pcvT+zR0HvU7zcIgLRq1Indzj4Ylj/Nh57bbKhvXYqpzzH/jn7oEIgKvARNfTXXhhTp4L
	 usWWZSzL9+LAEzfuxihBueyoBoEOegbnIc/aYjTzSGjGO2IapDUDePDhLDUXHwKtGQTN6
	 LP9UyG0uc1GfQ3xaKn8dIvkqoH37t+1wJ17MO4Bb6U4UuR5gpBprSlCQ8gvXC2f6tPqfb
	 owJU3DWHea9LR7pDOkdLHs10+ExsgevW5t6L7L0vVRMLou4qbLsaciIByZvTCFWA3PA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789629295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dipoDHFX57jnaEmHMtdQX+Ggi0lRYpsDPlvh9ECu+jI=;
	b=md/19L6C/nmSikYKyToRIWo6djlMpEDMv/sQXryAXGbo6U3zFEeTCh4+CB0JZNI4EGZS
	 GuRATqKMipnxocOsqPiGtA4qRKmWyoE8Bu2U1SGljex1cu4uJbDca2wKX77G+/knU6AHW
	 J9Ijfpwb53JWsIQ5FC8NEIxlbbKnSdloq1I62L6RCDU228oCSnIl/XVO8JEQQZ/9PrQg6
	 oN3PdkoBaY2WETRS24EQb8WOlddeUuUQN5oNQdv9xW7GlsLJ5dU3PNsBV+xws+QNjXyyl
	 jjfauh/pFw0uVC3FmzWF6puq3srEXcXPM4Q0XkDKLzoXbPBMwbxoS8fNrhzIiyoFpyg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789629295;
	bh=dipoDHFX57jnaEmHMtdQX+Ggi0lRYpsDPlvh9ECu+jI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=334xA774RnP81GrokjY3HkbcUHKPlCZ8rd+Iv2/7UsY/aduMhKnG9yRUExDnaArbt
	 1gNDzcGU+SxoNRqwBxNSaWhlEQQTP66VD1VtzYMy+DmQThsv7IOhQRNiWWx3lW2lOO
	 1VKLV4x/XY/mfcn36dR25cvBC+hp5Pp/TcoMO8SW0tDFzXe/UZ4oDazOOd5UhlA2Cx
	 viop0Pl5jE3zMNknhq/+jeM6rzws1PJn1JWjAsxRv1G4bFoQCOPkBOuWalYt5qdzf8
	 NDDk0fx3Ud5tAGaLLWqhm7D0FVhGsWuLuKMeECx4YG4G0ouHmVbEUbj5zNzkofo66k
	 d8KCV/c0qDhjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 374026062B;
	Thu, 17 Sep 2026 07:14:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8672843A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C48F80E19
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:14:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fKMFsepC6BVk for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 07:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AE90080E17
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789629292;
 b=h1ZcP/hZiCmp1ttNm37zfmnVnXaHaHz5ycrbj6cQMHHLkeI1b5Ui3Rbrrmr8MtlNHj2r
 Fte0w852OcwA3gpiY8tEl8yAWX17Ic2HqwLtRHotPLLGEIrhK26y+ZCwkgP5zsryT8Fo9
 ZjUQB0/DLeJRdmKqD2NSssLt7I1tZopGM9Z0IyZPaJ0O8bttK/fe0RX7Kg6Kw1PuE0DT2
 AuMDPZYwO8BHwg2wrIBjnkCoL97FEc+a760ie7LNku8V+qW1zJxyxsSAyNU/ynrEegWpL
 XOsfymnoEhJAOAmq2wcCCTOVMgF3nLebyUo6y8l+NPi83RZC0Y+MhVUkdsehwut8I0Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789629292;
 h=Received-SPF:Received:Message-ID:Date:MIME-Version:User-Agent:
 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
 bh=dipoDHFX57jnaEmHMtdQX+Ggi0lRYpsDPlvh9ECu+jI=;
 b=Yn+dXykUHYDi3MRIu2ZwzRRLMNe4r4RWNpD5X0CNcwvfxzE4efu7nD8F+eAAXafl0VHQ
 h3lsh1ik34sMFrAbLggwXevU2jaJISe9CgzwXLxkwRvW5zOj/WjjTI4C+XqB/SfwTOqZO
 wahdKJaVr52rHy6XjvLVVSY9pFrVRv9WWekX2286s/EflJrkhoEDLhgK/DhSXlY/OVNVt
 9XEfDygBvArKp6auW8YIT+kzr7POrL5zuldx+4S+ewxyfjDMhOd4C6/c9o101sZ1sI4r3
 CiaCxH9kfDxfCdc01xQ+UjDRWyWxbu+/3eOX1Ev6GJ2Djr0N0XuSoCRXp+UHPWUqNyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=molgen.mpg.de; 
 dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256
 header.s=20260906 header.b=PgAl7Gw5; 
 arc=none smtp.remote-ip=141.14.17.11
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.14.17.11;
 helo=mx3.molgen.mpg.de; envelope-from=pmenzel@molgen.mpg.de;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de
 header.a=rsa-sha256 header.s=20260906 header.b=PgAl7Gw5
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE90080E17
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 07:14:51 +0000 (UTC)
Received: from [192.168.2.217] (p5dc55dbb.dip0.t-ipconnect.de [93.197.93.187])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 873484C442F868;
 Thu, 17 Sep 2026 09:13:10 +0200 (CEST)
Message-ID: <636c578a-b88e-4d76-861c-85b37e014f19@molgen.mpg.de>
Date: Thu, 17 Sep 2026 09:13:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net v2 2/2] ixgbe: rename the EMP reset
 timeout constant
To: Linkui Xiao <xiaolinkui@126.com>, Linkui Xiao <xiaolinkui@kylinos.cn>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jedrzej.jagielski@intel.com, kees@kernel.org, aleksandr.loktionov@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260917065436.1181073-1-xiaolinkui@126.com>
 <20260917065436.1181073-2-xiaolinkui@126.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260917065436.1181073-2-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de;
 s=20260906; t=1789629191; 
 h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding;
 bh=dipoDHFX57jnaEmHMtdQX+Ggi0lRYpsDPlvh9ECu+jI=; 
 b=PgAl7Gw54zLQmoV8LNZsKV7nubghYfI17ZjLQCZWK9YHSvOqOo8KjwD0sLzWFAWdT5V4az8917Yf
 RfrF2czesILqWDZ2wdbWEoGV0wabgaIbHa81IKuJC33+MC3mUQaTuaqRRMifQmZH05LR+PwPZCPM56
 4fjB6zW0NTWSA09xr7SK5+BImKfiMl4R0muJ7IDB1demAyL52uz7PzWWZI2oQFFxmBy7CYsPdCWSIz
 NiPIFOSiaHr33HYlVrTzOCTOuhLil4zMjn8YqAZeHUr8p6I4FrIJadUufFLSuv3d5LghF2oRFb3F07
 WKC9MeclXkZLJnHT4bT3JqkgmsqF1YBg==
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

Dear Linkui,


Thank you for your patch.

Am 17.09.26 um 08:54 schrieb Linkui Xiao:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC is misleading: the value counts 0.5 s
> poll iterations, not seconds, as the comment right above it already
> explains. Rename it to IXGBE_DEVLINK_RELOAD_MAX_ITER, which says what the
> value actually is.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>   drivers/net/ethernet/intel/ixgbe/devlink/devlink.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> index 781f13240a0d..15b14c5a7c4e 100644
> --- a/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
> @@ -430,7 +430,7 @@ static int ixgbe_devlink_reload_empr_start(struct devlink *devlink,
>   }
>   
>   /*Wait for 10 sec with 0.5 sec tic. EMPR takes no less than half of a sec */
> -#define IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC	20
> +#define IXGBE_DEVLINK_RELOAD_MAX_ITER	20
>   
>   /**
>    * ixgbe_devlink_reload_empr_finish - finishes EMP reset
> @@ -464,7 +464,7 @@ static int ixgbe_devlink_reload_empr_finish(struct devlink *devlink,
>   
>   		fwsm = IXGBE_READ_REG(hw, IXGBE_FWSM(hw));
>   
> -		if (i++ >= IXGBE_DEVLINK_RELOAD_TIMEOUT_SEC)
> +		if (i++ >= IXGBE_DEVLINK_RELOAD_MAX_ITER)
>   			return -ETIME;
>   
>   	} while (!(fwsm & IXGBE_FWSM_FW_VAL_BIT));

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
