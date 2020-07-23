From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 23 Jul 2020 01:24:45 +0000
Subject: [Intel-wired-lan] [PATCH S49 01/15] ice: refactor
 ice_discover_caps to avoid need to retry
In-Reply-To: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
References: <20200709161614.61098-1-anthony.l.nguyen@intel.com>
Message-ID: <BN6PR1101MB2145018A97B366959F2193E88C760@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, July 9, 2020 9:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S49 01/15] ice: refactor ice_discover_caps
> to avoid need to retry
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice_discover_caps function is used to read the device and function
> capabilities, updating the hardware capabilities structures with relevant data.
> 
> The exact number of capabilities returned by the hardware is unknown
> ahead of time. The AdminQ command will report the total number of
> capabilities in the return buffer.
> 
> The current implementation involves requesting capabilities once, reading
> this returned size, and then re-requested with that size.
> 
> This isn't really necessary. The firmware interface has a maximum size of
> ICE_AQ_MAX_BUF_LEN. Firmware can never return more than
> ICE_AQ_MAX_BUF_LEN / sizeof(struct ice_aqc_list_caps_elem) capabilities.
> 
> Avoid the retry loop by simply allocating a buffer of size
> ICE_AQ_MAX_BUF_LEN. This is significantly simpler than retrying. The extra
> allocation isn't a big deal, as it will be released after we finish parsing the
> capabilities.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 43 ++++++---------------
>  1 file changed, 12 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


