From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 17:02:10 +0000
Subject: [Intel-wired-lan] [next PATCH S16 06/15] i40e: Add support
	for	non-willing Apps
In-Reply-To: <1443463964-148204-7-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2C10@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bowers, Gregory J
> Subject: [Intel-wired-lan] [next PATCH S16 06/15] i40e: Add support for non-
> willing Apps
> 
> From: Greg Bowers <gregory.j.bowers@intel.com>
> 
> Adds support for setting a new bit in the Set Local LLDP MIB AQ command
> Type field.  When set to 1, the bit indicates to FW that Apps should be
> treated as non-willing.  When 0, FW behaves as before.
> 
> Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
> Change-ID: I0d2101c1606c59c7188d3e6a0c7810e0f205233a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 7 +++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h       | 2 ++
>  2 files changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
