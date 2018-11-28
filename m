From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Nov 2018 21:46:04 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: extend PTP gettime function to
 read system clock
In-Reply-To: <20181128160749.14040-1-mlichvar@redhat.com>
References: <20181128160749.14040-1-mlichvar@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32C043@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Miroslav Lichvar
> Sent: Wednesday, November 28, 2018 8:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Richard Cochran <richardcochran@gmail.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: extend PTP gettime function to read
> system clock
> 
> This adds support for the PTP_SYS_OFFSET_EXTENDED ioctl.
> 
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


