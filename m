From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 16 Apr 2015 03:54:30 +0000
Subject: [Intel-wired-lan] [net-next v2] igb: simplify and clean
	up	igb_enable_mas()
In-Reply-To: <20150403085138.6124.95003.stgit@gmw-smvitp108.amr.corp.intel.com>
References: <20150403085138.6124.95003.stgit@gmw-smvitp108.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DA3995@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Friday, April 03, 2015 1:52 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next v2] igb: simplify and clean up
> igb_enable_mas()
> 
> 
> igb_enable_mas() should only be called for the 82575 and has no clear
> return so changing it to void. Also simplify the odd conditional
> expression.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: made igb_enable_mas() static based on feedback from automated testing
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   27 +++++++-----------------
> ---
>  1 file changed, 7 insertions(+), 20 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
