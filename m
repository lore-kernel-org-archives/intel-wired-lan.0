From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 27 Jan 2016 18:44:25 +0000
Subject: [Intel-wired-lan] [next PATCH v3 14/15] i40e: Update feature
 flags to reflect newly enabled features
In-Reply-To: <20160125051750.12004.24225.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
 <20160125051750.12004.24225.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98C826@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Sunday, January 24, 2016 9:18 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v3 14/15] i40e: Update feature flags to
> reflect newly enabled features
> 
> Recent changes should have enabled support for IPv6 based tunnels and
> support for TSO with outer UDP checksums.  As such we can update the
> feature flags to reflect that.
> 
> In addition we can clean-up the flags that aren't needed such as SCTP and
> RXCSUM since having the bits there doesn't add any value.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
ethtool shows proper flags, code changes present
