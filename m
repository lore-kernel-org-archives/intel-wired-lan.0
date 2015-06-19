From: Young, James M <james.m.young@intel.com>
Date: Fri, 19 Jun 2015 20:32:21 +0000
Subject: [Intel-wired-lan] [net-next S5 09/15] i40evf: don't delete all
 the	filters
In-Reply-To: <1430161042-28494-10-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1A0CE@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, April 27, 2015 11:57 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next S5 09/15] i40evf: don't delete all the
> filters
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Due to an inverted conditional, the driver was marking all of its MAC filters
> for deletion every time set_rx_mode was called. Depending upon the timing
> of the calls to set_rx_mode and the processing of the admin queue, the
> driver would (accidentally) end up with a varying number of functional filters.
> 
> Correct this logic so that MAC filters are added and removed correctly.
> Add a check for the driver's "hardware" MAC address so that this filter
> doesn't get removed incorrectly.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ib3e7c4a5b53df6835f164fe44cb778cb71f8aff8
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Tested-by: Jim Young <james.m.young@intel.com>
