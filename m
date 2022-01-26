From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 26 Jan 2022 11:59:59 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: remove enum i40e_client_state
In-Reply-To: <bb6675f9-63ce-77a2-e4fe-76cc592e5f41@intel.com>
References: <20220126185544.2787111-1-kuba@kernel.org>
 <bb6675f9-63ce-77a2-e4fe-76cc592e5f41@intel.com>
Message-ID: <20220126115959.56eee765@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 26 Jan 2022 11:53:29 -0800 Jesse Brandeburg wrote:
> On 1/26/2022 10:55 AM, Jakub Kicinski wrote:
> > It's not used.  
> 
> minor nit, you didn't say if you wanted this to go to net or net-next or 
> add a Fixes: tag?

Right, I'm not targeting net or net-next directly. I should have put
something like "intel-next", probably.

> maybe:
> Fixes: e3219ce6a775 ("i40e: Add support for client interface for IWARP 
> driver")
> 
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> for the patch itself, it looks fine to me, so if you spin this
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
