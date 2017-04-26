From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Apr 2017 22:32:56 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct thermal sensor event
 check
In-Reply-To: <20170425205525.47399-1-anthony.l.nguyen@intel.com>
References: <20170425205525.47399-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA17D8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, April 25, 2017 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Correct thermal sensor event check
> 
> From: Mark Rustad <mark.d.rustad@intel.com>
> 
> The thermal sensor event logic is messed up, because it can execute the
> code when there is no thermal event. The current logic is that it will exit
> when !capable && !event whereas it really should exit when !capable ||
> !event. For one thing, it means that the service task is doing too much work.
> It probably has some other symptoms as well. So, correct the logic,
> simplifying to only execute when there is a thermal event. The capable check
> is redundant.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


