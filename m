From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Thu, 26 Aug 2021 03:46:52 +0000
Subject: [Intel-wired-lan] [next-queue v4 07/13] ice: use 'int err'
 instead of 'int status'
In-Reply-To: <20210824000158.1928482-8-anthony.l.nguyen@intel.com>
References: <20210824000158.1928482-1-anthony.l.nguyen@intel.com>
 <20210824000158.1928482-8-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33674E92C6DBAF9C7F831F7EFCC79@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [next-queue v4 07/13] ice: use 'int err' instead of
> 'int status'
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_ptp_hw.c file introduced a bunch of uses of "int status" instead of
> the more traditional "int err" or "int ret". These are actually traditional Linux
> error codes (as opposed to the ice_status enumeration values), so lets
> convert them all now to use "int err" for clarity. This is likely an artifact of
> refactoring this code to minimize the use of ice_status enumeration in
> preparation for removing it. We want to avoid adding any new usages of the
> status enum.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 206 ++++++++++----------
>  1 file changed, 103 insertions(+), 103 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
