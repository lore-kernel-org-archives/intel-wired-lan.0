From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 May 2017 01:38:06 +0000
Subject: [Intel-wired-lan] [PATCH] igb: make a few local functions static
In-Reply-To: <20170427175911.15477-1-colin.king@canonical.com>
References: <20170427175911.15477-1-colin.king@canonical.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5F2C01@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Thursday, April 27, 2017 10:59 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] igb: make a few local functions static
> 
> From: Colin Ian King <colin.king@canonical.com>
> 
> clean up a few sparse warnings, these following
> functions can be made static:
> 
> drivers/net/ethernet/intel/igb/igb_main.c: warning: symbol
>   'igb_add_mac_filter' was not declared. Should it be static?
> drivers/net/ethernet/intel/igb/igb_main.c: warning: symbol
>   'igb_del_mac_filter' was not declared. Should it be static?
> drivers/net/ethernet/intel/igb/igb_main.c: warning: symbol
>   'igb_set_vf_mac_filter' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
