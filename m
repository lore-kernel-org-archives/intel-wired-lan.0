From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 Mar 2017 19:06:40 +0000
Subject: [Intel-wired-lan] [PART1 PATCH 01/11] i40e: send correct
	port	number to AdminQ when enabling UDP tunnels
In-Reply-To: <20170206223846.31052-2-jacob.e.keller@intel.com>
References: <20170206223846.31052-1-jacob.e.keller@intel.com>
 <20170206223846.31052-2-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10403044@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, February 6, 2017 2:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PART1 PATCH 01/11] i40e: send correct port
> number to AdminQ when enabling UDP tunnels
> 
> The firmware expects the port numbers for offloaded UDP tunnels in Little
> Endian format. We accidentally sent the value in Big Endian format which
> obviously will cause the wrong port number to be put into the UDP tunnels
> list. This results in VxLAN and Geneve tunnel Rx offloads being essentially
> disabled, unless the port number happens to be identical after byte
> swapping. Note that i40e_aq_add_udp_tunnel() will byteswap the
> parameter from host order into Little Endian so we don't need worry about
> passing strictly a __le16 value to the command.
> 
> This patch essentially reverts b3f5c7bc88ba ("i40e: Fix for extra byte swap in
> tunnel setup", 2016-08-24), but in a way that makes the result much more
> clear to the reader.
> 
> Fixes: b3f5c7bc88ba ("i40e: Fix for extra byte swap in tunnel setup", 2016-08-
> 24)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 17 ++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


