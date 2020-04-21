From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2020 15:45:55 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] i40e: Remove unneeded conversion to
 bool
In-Reply-To: <20200420123448.7382-1-yanaijie@huawei.com>
References: <20200420123448.7382-1-yanaijie@huawei.com>
Message-ID: <20200421.154555.572490249375777103.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jason Yan <yanaijie@huawei.com>
Date: Mon, 20 Apr 2020 20:34:48 +0800

> The '==' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:1614:52-57: WARNING:
> conversion to bool not needed here
> drivers/net/ethernet/intel/i40e/i40e_main.c:11439:52-57: WARNING:
> conversion to bool not needed here
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to net-next.
