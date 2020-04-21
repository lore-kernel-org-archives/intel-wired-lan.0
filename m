From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2020 15:46:01 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] e1000: remove unneeded conversion to
 bool
In-Reply-To: <20200420123506.7716-1-yanaijie@huawei.com>
References: <20200420123506.7716-1-yanaijie@huawei.com>
Message-ID: <20200421.154601.158772582316590260.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jason Yan <yanaijie@huawei.com>
Date: Mon, 20 Apr 2020 20:35:06 +0800

> The '==' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
> 
> drivers/net/ethernet/intel/e1000/e1000_main.c:1479:44-49: WARNING:
> conversion to bool not needed here
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to net-next.
