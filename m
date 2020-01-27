From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 27 Jan 2020 23:19:57 +0000
Subject: [Intel-wired-lan] [PATCH S38 14/15] ice: add function argument
 description to function header comment
In-Reply-To: <20200122152138.41585-14-anthony.l.nguyen@intel.com>
References: <20200122152138.41585-1-anthony.l.nguyen@intel.com>
 <20200122152138.41585-14-anthony.l.nguyen@intel.com>
Message-ID: <37a2fa6b73a84681b3121c6ccaf6c915@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S38 14/15] ice: add function argument
> description to function header comment
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Commit 0290bd291cc0 ("netdev: pass the stuck queue to the timeout
> handler") introduced a new argument to the function but missed adding the
> description of the argument to the function header comment.  Add it now.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


