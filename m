From: David Miller <davem@davemloft.net>
Date: Sat, 19 Sep 2020 14:14:33 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] net: e1000: Remove set but
 not used variable
In-Reply-To: <20200919015020.22963-1-zhengyongjun3@huawei.com>
References: <20200919015020.22963-1-zhengyongjun3@huawei.com>
Message-ID: <20200919.141433.905827192285572567.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Zheng Yongjun <zhengyongjun3@huawei.com>
Date: Sat, 19 Sep 2020 09:50:20 +0800

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/intel/e1000/e1000_hw.c: In function e1000_phy_init_script:
> drivers/net/ethernet/intel/e1000/e1000_hw.c:132:6: warning: variable ?ret_val? set but not used [-Wunused-but-set-variable]
> 
> `ret_val` is never used, so remove it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied.
