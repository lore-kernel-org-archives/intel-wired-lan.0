From: David Miller <davem@davemloft.net>
Date: Wed, 19 Sep 2018 23:09:42 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] e1000: remove set but not
 used variable 'txb2b'
In-Reply-To: <1537409078-2374-1-git-send-email-yuehaibing@huawei.com>
References: <1537409078-2374-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <20180919.230942.1647513192306122153.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: YueHaibing <yuehaibing@huawei.com>
Date: Thu, 20 Sep 2018 02:04:38 +0000

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/intel/e1000/e1000_main.c: In function 'e1000_watchdog':
> drivers/net/ethernet/intel/e1000/e1000_main.c:2436:9: warning:
>  variable 'txb2b' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
