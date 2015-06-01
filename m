From: Young, James M <james.m.young@intel.com>
Date: Mon, 1 Jun 2015 17:29:54 +0000
Subject: [Intel-wired-lan] [net-next S5 10/15] i40evf: add MAC
	address	filter in open, not init
In-Reply-To: <1430161042-28494-11-git-send-email-catherine.sullivan@intel.com>
References: <1430161042-28494-1-git-send-email-catherine.sullivan@intel.com>
 <1430161042-28494-11-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA08BEB@ORSMSX102.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net-next S5 10/15] i40evf: add MAC address filter
> in open, not init
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> During close, all of the MAC filters are cleared, so the driver would be unable
> to receive unicast packets after being closed and reopened.
> 
> Add the adapter's "hardware" MAC address filter in open, not init. This
> ensures that the correct filter is present each time.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I51a11e9c1200139dab6f66a5353bd38c7d26f875
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Tested-by: Jim Young <james.m.young@intel.com>

