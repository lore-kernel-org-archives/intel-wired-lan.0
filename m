From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Dec 2019 18:53:58 +0000
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Remove limit of 10
 entries for unicast filter list
In-Reply-To: <20191125142452.21819-1-radoslawx.tyl@intel.com>
References: <20191125142452.21819-1-radoslawx.tyl@intel.com>
Message-ID: <57803068b5944aac9606418c4cb110a1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Radoslaw Tyl
> Sent: Monday, November 25, 2019 6:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: pmenzel at molgen.mpg.de; Gangadhar, Mukesh
> <mukesh.gangadhar@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Remove limit of 10 entries for
> unicast filter list
> 
> Currently, though the FDB entry is added to VF, it does not appear in RAR
> filters. VF driver only allows to add 10 entries. Attempting to add another
> causes an error. This patch removes limitation and allows use of all free RAR
> entries for the FDB if needed.
> 
> Fixes: 46ec20ff7d ("ixgbevf: Add macvlan support in the set rx mode op")
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 5 -----
>  1 file changed, 5 deletions(-)

Exceeding the filter limits causes a call trace on reboot and locks the system up until you do a hard power cycle.


