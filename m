From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 22 Sep 2020 05:52:59 +0000
Subject: [Intel-wired-lan] [next-queue v7] igb: add XDP support
In-Reply-To: <20200921095821.jmle6qdcn2ksmtee@SvensMacbookPro.hq.voleatech.com>
References: <20200902203222.185141-1-anthony.l.nguyen@intel.com>
 <20200921095821.jmle6qdcn2ksmtee@SvensMacbookPro.hq.voleatech.com>
Message-ID: <MW3PR11MB4554FACD3AC02DD37CBC36D19C3B0@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Sven Auhagen
Sent: Monday, September 21, 2020 3:28 PM
To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan at lists.osuosl.org
Subject: Re: [Intel-wired-lan] [next-queue v7] igb: add XDP support

On Wed, Sep 02, 2020 at 01:32:22PM -0700, Tony Nguyen wrote:
> From: Sven Auhagen <Sven.Auhagen@voleatech.de>
> 
> Add XDP support to the IGB driver.
> The implementation follows the IXGBE XDP implementation closely and I 
> used the following patches as basis:
> 
> 1. commit 924708081629 ("ixgbe: add XDP support for pass and drop 
> actions") 2. commit 33fdc82f0883 ("ixgbe: add support for XDP_TX 
> action") 3. commit ed93a3987128 ("ixgbe: tweak page counting for 
> XDP_REDIRECT")
> 
> Due to the hardware constraints of the devices using the IGB driver we 
> must share the TX queues with XDP which means locking the TX queue for 
> XDP.
> 
> I ran tests on an older device to get better numbers.
> Test machine:
> 
> Intel(R) Atom(TM) CPU C2338 @ 1.74GHz (2 Cores) 2x Intel I211
> 
> Routing Original Driver Network Stack: 382 Kpps
> 
> Routing XDP Redirect (xdp_fwd_kern): 1.48 Mpps XDP Drop: 1.48 Mpps
> 
> Using XDP we can achieve line rate forwarding even on an older Intel 
> Atom CPU.
> 
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>

Hello Tony,

thanks for the patch update.
How is the process to get this accepted?

Best
Sven

> ---
> v7:
>  * Fix issue with applying to dev-queue branch; utilize net_prefetch()
>  * Fix build issue; remove XDP_QUERY_PROG
>  * Replace fallthrough comment with fallthrough macro to resolve 
> checkpatch warning
>  * Fix reverse Christmas tree
> 
> v6:
> * igb_xdp_ring_update_tail changed to static
> * bump to 5.8
> 
> v5: resubmission with function names in patch
> 
> v4:
> * use HARD_TX_LOCK in XDP xmit
> * do not pass adapter to igb_setup_rx_resources
> * account for timestamp in frame size
> 
> v3: igb_xdp_ring_update_tail should be static
> 
> v2: original did not apply to my dev-queue branch, so fixed the
>     conflicts in the patch
> 
>  drivers/net/ethernet/intel/igb/igb.h         |  81 +++-
>  drivers/net/ethernet/intel/igb/igb_ethtool.c |   4 +
>  drivers/net/ethernet/intel/igb/igb_main.c    | 433 +++++++++++++++++--
>  3 files changed, 482 insertions(+), 36 deletions(-)
> 
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
