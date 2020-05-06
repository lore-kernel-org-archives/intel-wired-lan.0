From: David Miller <davem@davemloft.net>
Date: Wed, 06 May 2020 14:02:39 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make
 i40e_shutdown_adminq() return void
In-Reply-To: <20200506061835.19662-1-yanaijie@huawei.com>
References: <20200506061835.19662-1-yanaijie@huawei.com>
Message-ID: <20200506.140239.2129195871879981516.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jason Yan <yanaijie@huawei.com>
Date: Wed, 6 May 2020 14:18:35 +0800

> Fix the following coccicheck warning:
> 
> drivers/net/ethernet/intel/i40e/i40e_adminq.c:699:13-21: Unneeded
> variable: "ret_code". Return "0" on line 710
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Jeff, please pick this up.

Thank you.
