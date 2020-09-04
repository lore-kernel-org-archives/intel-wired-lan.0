From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 4 Sep 2020 20:21:31 +0000
Subject: [Intel-wired-lan] [PATCH] igb: read PBA number from flash
In-Reply-To: <20200830054529.3980-1-ghammer@redhat.com>
References: <20200830054529.3980-1-ghammer@redhat.com>
Message-ID: <DM6PR11MB289033DD7B7C778FA977F617BC2D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Gal Hammer <ghammer@redhat.com>
> Sent: Saturday, August 29, 2020 10:45 PM
> To: linux-kernel at vger.kernel.org
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S . Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; Marcel Apfelbaum
> <mapfelba@redhat.com>; Gal Hammer <ghammer@redhat.com>
> Subject: [PATCH] igb: read PBA number from flash
> 
> Fixed flash presence check for 82576 controllers so the part
> number string is read and displayed correctly.
> 
> Signed-off-by: Gal Hammer <ghammer@redhat.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

