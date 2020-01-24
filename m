From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:08 +0000
Subject: [Intel-wired-lan] [PATCH S37 07/15] ice: Modify link message
 logging
In-Reply-To: <20200122152041.41498-7-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-7-anthony.l.nguyen@intel.com>
Message-ID: <464317bd572c4b5a8caedbd3c53c4fb2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 07/15] ice: Modify link message logging
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch modifies link message logging to include "Full Duplex" and
> "Negotiated" for FEC, so as to distinguish it from "Requested" FEC.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


