From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:28:05 +0000
Subject: [Intel-wired-lan] [next PATCH S9 4/7] i40e: mark additional
 missing bits as reserved
In-Reply-To: <20190826181655.15106-4-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <20190826181655.15106-4-alice.michael@intel.com>
Message-ID: <f4c164da309e4f30b82302c7822049eb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 4/7] i40e: mark additional missing
> bits as reserved
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Mark bits 0xD through 0xF for the command flags of a cloud filter as
> reserved. These bits are not yet defined and are considered as reserved in
> the data sheet.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


