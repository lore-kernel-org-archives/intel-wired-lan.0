From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 16:33:33 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 12/15] i40e: correct check
 for	reading TSYNINDX from the receive descriptor
In-Reply-To: <1475685046-16900-13-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-13-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FBEC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 12/15] i40e: correct check for
> reading TSYNINDX from the receive descriptor
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When hardware has taken a timestamp for a received packet, it indicates
> which RXTIME register the timestamp was placed in by some bits in the
> receive descriptor. It uses 3 bits, one to indicate if the descriptor index is valid
> (ie: there was a timestamp) and 2 bits to indicate which of the 4 registers to
> read. However, the driver currently does not check the TSYNVALID bit and
> only checks the index. It assumes a zero index means no timestamp, and a
> non zero index means a timestamp occurred.
> While this appears to be true, it prevents ever reading a timestamp in
> RXTIME[0], and causes the first timestamp the device captures to be ignored.
> 
> Fix this by using the TSYNVALID bit correctly as the true indicator of whether
> the packet has an associated timestamp.
> 
> Also rename the variable rsyn to tsyn as this is more descriptive and matches
> the register names.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I4437e8f3a3df2c2ddb458b0fb61420f3dafc4c12
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


