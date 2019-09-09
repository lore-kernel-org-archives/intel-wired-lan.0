From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 Sep 2019 21:03:36 +0000
Subject: [Intel-wired-lan] [PATCH] net/ixgbevf: make array api static
 const, makes object smaller
In-Reply-To: <20190906113356.9985-1-colin.king@canonical.com>
References: <20190906113356.9985-1-colin.king@canonical.com>
Message-ID: <22d993817a224209b9ac37013d1d8c54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Colin King
> Sent: Friday, September 6, 2019 4:34 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] net/ixgbevf: make array api static const,
> makes object smaller
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array api on the stack but instead make it static const.
> Makes the object code smaller by 58 bytes.
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   82969	   9763	    256	  92988	  16b3c	ixgbevf/ixgbevf_main.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   82815	   9859	    256	  92930	  16b02	ixgbevf/ixgbevf_main.o
> 
> (gcc version 9.2.1, amd64)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


