From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 1 Nov 2019 16:45:45 +0000
Subject: [Intel-wired-lan] [PATCH S32 15/15] ice: print opcode when
 printing controlq errors
In-Reply-To: <20191025143441.50151-15-anthony.l.nguyen@intel.com>
References: <20191025143441.50151-1-anthony.l.nguyen@intel.com>
 <20191025143441.50151-15-anthony.l.nguyen@intel.com>
Message-ID: <3981d5374fef476e985c550205f7b26e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, October 25, 2019 7:35 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 15/15] ice: print opcode when printing
> controlq errors
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> To help aid in debugging, display the command opcode in debug messages
> that print an error code. This makes it easier to see what command failed if
> only ICE_DBG_AQ_MSG is enabled.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_controlq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


