From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Oct 2019 23:17:07 +0000
Subject: [Intel-wired-lan] [PATCH S30 9/9] ice: allow 3k MTU for XDP
In-Reply-To: <20191009140925.13997-9-anthony.l.nguyen@intel.com>
References: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
 <20191009140925.13997-9-anthony.l.nguyen@intel.com>
Message-ID: <3a4e393b0a234591b9e9020a1f57ee16@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 9/9] ice: allow 3k MTU for XDP
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> At this point ice driver is able to work on order 1 pages that are split onto two
> 3k buffers. Let's reflect that when user is setting new mtu size and XDP is
> present on interface.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


