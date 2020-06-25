From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Jun 2020 17:03:43 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 2/3] i40e: eliminate
 division in napi_poll data path
In-Reply-To: <1592905458-850-3-git-send-email-magnus.karlsson@intel.com>
References: <1592905458-850-1-git-send-email-magnus.karlsson@intel.com>
 <1592905458-850-3-git-send-email-magnus.karlsson@intel.com>
Message-ID: <BN6PR1101MB2145FF352A257C2E96089FC08C920@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Tuesday, June 23, 2020 2:44 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Cc: maciejromanfijalkowski at gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 2/3] i40e: eliminate division in
> napi_poll data path
> 
> Eliminate a division in the napi_poll data path. This division is executed even
> though it is only needed in the rare case when there are not enough
> interrupt lines so they have to be shared between queue pairs. Instead, just
> test for this case and only execute the division if needed. The code has been
> lifted from the ice driver.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


