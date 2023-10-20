Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BABCDB47E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 20 Oct 2023 06:56:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0514D402F6;
	Fri, 20 Oct 2023 06:56:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0514D402F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1697784986;
	bh=+FQNulMCtwC9VoR4ztK5SChtIVY6S4IGKI4Dm6UOFYw=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=85NudXxtnZut6CBvIL/3PZZNzu8hf23aVUFFtXxnFWzY107A624qXh58yPb73TrR1
	 LhHjeciSavX7BGdusoCS0D6Sgu43CDE9Atvdj+l0BpgKq27JtG/kabTFRJX33UHNk1
	 ky3nfv0vFCiuGBsY7W5VhtojR8fHNaKf+zJjy5IAQ+WUMdSsAqfpJ+yz8lqfCUQpdz
	 PxvLR0mkwwwsmN8ZMcq0tTREjd3ZDxFtKelVf/TSGGORkIjepHPYr31FJjVclsaUd6
	 yIpSrGS5ITbhXspzOKDqCruQbZHpXy0svbDcyaOFSLv3w88bu6H43P4BPkNwWLfSAV
	 gBVbKhfDypa6w==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xlcgeKJKUZaT; Fri, 20 Oct 2023 06:56:25 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9D7C431E7;
	Fri, 20 Oct 2023 06:56:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C9D7C431E7
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by ash.osuosl.org (Postfix) with ESMTP id 35FA61BF2FD
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 06:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3879431E7
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 06:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3879431E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m1Z4QfzbBxxi for <intel-wired-lan@lists.osuosl.org>;
 Fri, 20 Oct 2023 06:56:22 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5774402F6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 20 Oct 2023 06:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5774402F6
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4084b0223ccso3569255e9.2
 for <intel-wired-lan@lists.osuosl.org>; Thu, 19 Oct 2023 23:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697784979; x=1698389779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9LEiI73HKl/yMmpsQOiFinCN5KnlO7an5SddP9Ej00=;
 b=g95CcLkGnbo/YXNQ1VVT0RWc8yYb6IQgAn3OUdX7NONW9gMk4Fwpi6NKXPX53vuje9
 YNskpfslQsyOh2EQwjsuigho25+eqJhYNpi29JKx03ZNpvx+jqz+jO7d62j8ySxlI28e
 TI5dIflXFrsRRcMYiwXLJS6jlQ9AnKDrxwsgD7TwU6gUcFGIfr7IKl990lvVZHEflqWL
 v4IxYXqi1TkRNnseZjqN6sbyyiS4pdBxVNY3RQBBorBf2o9gh+FsKOLIH7Ewm8hQHkyE
 hFYkWM8B/SKT3K6nW8BgpYidNtjDc4Ltt88V2ErEtGaMlw3ei/IsrcCx8gY8i9tYYpjm
 FvXw==
X-Gm-Message-State: AOJu0YwnbrUcWnxeRZcq5yXZsTcCM7soiQNnWjxNZuQFHB93aC2V+3ZC
 bnDqweoOvfgjal+A6CFJOChF2A==
X-Google-Smtp-Source: AGHT+IEvEEtQGpyk+q26WaO58peFpV+y2bXO492uWGPLm75ilrOY/3/PfE6IuqfhDBM16huGVo92EA==
X-Received: by 2002:a05:600c:4f12:b0:408:3696:3d51 with SMTP id
 l18-20020a05600c4f1200b0040836963d51mr833558wmq.4.1697784979490; 
 Thu, 19 Oct 2023 23:56:19 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 ay10-20020a05600c1e0a00b00405442edc69sm3580447wmb.14.2023.10.19.23.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 23:56:19 -0700 (PDT)
Date: Fri, 20 Oct 2023 09:56:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Message-ID: <be0b618a-4732-467f-bb99-f623fe4da962@kadam.mountain>
References: <20231020024308.46630-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231020024308.46630-1-suhui@nfschina.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697784979; x=1698389779; darn=lists.osuosl.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I9LEiI73HKl/yMmpsQOiFinCN5KnlO7an5SddP9Ej00=;
 b=OnqL3aTAK1KuvcPG94bS+5pKWYFz4sD1pfWAPg9zmoynuzQc2M5nKzTu9jgyDh6iQT
 BL+iH9QLyLGupC2kjZ9Lgib8yNQtNhOGW/VO4EUSfw1Sgx1aRwJq3gpOD/zVFjVmwf8R
 dH24hzlEorUohYXusSp3YUut9Sulrec1Vi2JfxEFRoYAmOK3f1RZdabYlc4nogA4zv5r
 hby/+PY90lpQZ2cdFLzut5r26qiPRRD4rrzBpsGvDb13UOay2rdnG1fFZU0HzIflrEqq
 UToPvT/zbdbr7wsVW5UypPkx9fl+Finvv0IWJ+6mVWdWeMv7J/R1e0DPT0hR4x/i/DxX
 InXQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=OnqL3aTA
Subject: Re: [Intel-wired-lan] [PATCH v2] i40e: add an error code check in
 i40e_vsi_setup
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
Cc: intel-wired-lan@lists.osuosl.org, kernel-janitors@vger.kernel.org,
 jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Fri, Oct 20, 2023 at 10:43:09AM +0800, Su Hui wrote:
> check the value of 'ret' after calling 'i40e_vsi_config_rss'.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
> v2: 
> - call i40e_vsi_clear_rings() to free rings(thank dan carpenter for
>   pointing out this).

Looks okay now.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
