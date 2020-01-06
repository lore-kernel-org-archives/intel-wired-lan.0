From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 6 Jan 2020 20:19:23 +0000
Subject: [Intel-wired-lan] [PATCH v2] fm10k: use txqueue parameter in
 fm10k_tx_timeout
In-Reply-To: <20191219201000.1712-1-jacob.e.keller@intel.com>
References: <20191219201000.1712-1-jacob.e.keller@intel.com>
Message-ID: <a5bd2b6577e04a46a91e9257a095bef1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Thursday, December 19, 2019 12:10 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH v2] fm10k: use txqueue parameter in
> fm10k_tx_timeout
> 
> Make use of the new txqueue parameter to the .ndo_tx_timeout function.
> In fm10k_tx_timeout, remove the now unnecessary loop to determine
> which Tx queue is stuck. Instead, just double check the specified queue
> 
> This could be improved further to attempt resetting only the specific queue
> that got stuck. However, that is a much larger refactor and has been left as a
> future improvement.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> 
> Woops, sorry for the quick v2. Had missed a semicolon and apparently my
> config I used to check this after a last minute move to add the Tx queue
> warning didn't have CONFIG_FM10K enabled.. Woops.
> 
>  drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


