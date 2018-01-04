From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 22:07:47 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 06/13] i40e: change flags
 to use 64 bits
In-Reply-To: <20171227131750.23824-1-alice.michael@intel.com>
References: <20171227131750.23824-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D701D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 5:18 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 06/13] i40e: change flags to
> use 64 bits
> 
> As we have added more flags, we need to now use more bits and have
> overflooded the 32 bit size.  So make it 64.
> 
> also change all the existing bits to unsigned long long bits.
> 
> Signed-off-by: Alice Michael <alice.michael@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 67 +++++++++++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  4 +-
>  2 files changed, 36 insertions(+), 35 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


