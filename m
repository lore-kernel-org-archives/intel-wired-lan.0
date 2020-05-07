From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Thu, 7 May 2020 00:51:16 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: Make
 i40e_shutdown_adminq() return void
In-Reply-To: <20200506.140239.2129195871879981516.davem@davemloft.net>
References: <20200506061835.19662-1-yanaijie@huawei.com>
 <20200506.140239.2129195871879981516.davem@davemloft.net>
Message-ID: <61CC2BC414934749BD9F5BF3D5D940449868CF1C@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: David Miller <davem@davemloft.net>
> Sent: Wednesday, May 6, 2020 14:03
> To: yanaijie at huawei.com
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Azarewicz, Piotr
> <piotr.azarewicz@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH net-next] i40e: Make i40e_shutdown_adminq() return void
> 
> From: Jason Yan <yanaijie@huawei.com>
> Date: Wed, 6 May 2020 14:18:35 +0800
> 
> > Fix the following coccicheck warning:
> >
> > drivers/net/ethernet/intel/i40e/i40e_adminq.c:699:13-21: Unneeded
> > variable: "ret_code". Return "0" on line 710
> >
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> Jeff, please pick this up.
> 
> Thank you.
[Kirsher, Jeffrey T] 

Yep already added it to my queue, thanks.
