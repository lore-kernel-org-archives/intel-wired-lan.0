From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 24 Aug 2021 16:23:26 +0000
Subject: [Intel-wired-lan] [next-queue v4 03/13] ice: add lock around Tx
 timestamp tracker flush
In-Reply-To: <20210824000158.1928482-4-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
 <20210824000158.1928482-4-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB3367898F2E14AA8AF53E7CA1FCC59@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Tuesday, August 24, 2021 5:32 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v4 03/13] ice: add lock around Tx
> timestamp tracker flush
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The driver didn't take the lock while flushing the Tx tracker, which could
> cause a race where one thread is trying to read timestamps out while
> another thread is trying to read the tracker to check the timestamps.
> 
> Avoid this by ensuring that flushing is locked against read accesses.
> 
> Fixes: ea9b847cda64 ("ice: enable transmit timestamps for E810 devices")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
