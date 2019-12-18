From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:31:35 +0000
Subject: [Intel-wired-lan] [PATCH S35 11/15] ice: Demote MTU change
 print to debug
In-Reply-To: <20191212111307.33566-11-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-11-anthony.l.nguyen@intel.com>
Message-ID: <d4fc8dd26fb349bf8e57ad735842559c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 11/15] ice: Demote MTU change print
> to debug
> 
> Following the changes of commit 12299132b3d3 ("net: ethernet: intel:
> Demote MTU change prints to debug"), change the MTU change message to
> netdev_dbg()
> 
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


