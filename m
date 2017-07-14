From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Jul 2017 22:34:44 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 06/11] i40e: prevent
 snprintf	format specifier truncation
In-Reply-To: <20170712094614.76501-6-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
 <20170712094614.76501-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1C30@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, July 12, 2017 2:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S75-V3 06/11] i40e: prevent snprintf
> format specifier truncation
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Increase the size of the prefix buffer so that it can hold enough characters for
> every possible input. Although 20 is enough for all expected inputs, it is
> possible for the values to be larger than expected, resulting in a possibly
> truncated string. Additionally, lets use sizeof(prefix) in order to ensure we
> use the correct size if we need to change the array length in the future.
> 
> New versions of GCC starting at 7 now include warnings to prevent
> truncation unless you handle the return code. At most 27 bytes can be
> written here, so lets just increase the buffer size even if for all expected hw-
> >bus.* values we only needed 20.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 4 ++--
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


