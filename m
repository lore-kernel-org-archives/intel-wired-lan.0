From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:26:46 +0000
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbe: return early instead of
 wrap block in if statement
In-Reply-To: <20170120221150.7616.59999.stgit@localhost6.localdomain6>
References: <20170120221145.7616.93906.stgit@localhost6.localdomain6>
 <20170120221150.7616.59999.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D642@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, January 20, 2017 2:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/3] ixgbe: return early instead of wrap
> block in if statement
> 
> Since we exit at the end of the block, we can save a level of indentation by
> performing an early return, and make the next several sections of code more
> legible, with fewer 80 character line breaks.
> 
> Also moved allocating vfinfo at the beginning and the notification for
> enabling SRIOV at the end of the function when we know that it will succeed.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   85 ++++++++++++---------
> ---
>  1 file changed, 41 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


 

