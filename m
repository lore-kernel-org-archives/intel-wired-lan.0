From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:19:30 +0000
Subject: [Intel-wired-lan] [PATCH S38 13/15] ice: use proper format for
 function pointer as a function parameter
In-Reply-To: <20200122152138.41585-13-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-13-anthony.l.nguyen@intel.com>
Message-ID: <5dc1b0aa9f7e4b8e9ce1f563ef983799@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:22 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S38 13/15] ice: use proper format for
> function pointer as a function parameter
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Compiling with gcc-9.2.1 with W=1 points out warnings about the improper
> function parameter list.  Fix it.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


