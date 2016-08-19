From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 22:29:39 +0000
Subject: [Intel-wired-lan] [net] ixgbe: Do not clear RAR entry when
 clearing VMDq for SAN MAC
In-Reply-To: <147154969452.19009.9564111024941912803.stgit@ahduyck-desk.amr.corp.intel.com>
References: <147154969452.19009.9564111024941912803.stgit@ahduyck-desk.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F949A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.h.duyck at intel.com]
> Sent: Thursday, August 18, 2016 12:48 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [net] ixgbe: Do not clear RAR entry when clearing VMDq for SAN
> MAC
> 
> The RAR entry for the SAN MAC address was being cleared when we were
> clearing the VMDq pool bits.  In order to prevent this we need to add an
> extra check to protect the SAN MAC from being cleared.
> 
> Fixes: 6e982aeae ("ixgbe: Clear stale pool mappings")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


 
