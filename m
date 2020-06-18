From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Jun 2020 19:46:09 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: fix crash when Rx
 descriptor count is changed
In-Reply-To: <20200612114731.144630-1-bjorn.topel@gmail.com>
References: <20200612114731.144630-1-bjorn.topel@gmail.com>
Message-ID: <BN6PR1101MB2145F6C2A5F5B5458B41845A8C9B0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bj?rn T?pel
> Sent: Friday, June 12, 2020 4:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; Topel, Bjorn
> <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net] i40e: fix crash when Rx descriptor
> count is changed
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> When the AF_XDP buffer allocator was introduced, the Rx SW ring "rx_bi"
> allocation was moved from i40e_setup_rx_descriptors() function, and was
> instead done in the i40e_configure_rx_ring() function.
> 
> This broke the ethtool set_ringparam() hook for changing the Rx descriptor
> count, which was relying on i40e_setup_rx_descriptors() to handle the
> alloction.
> 
> Fix this by adding an explicit i40e_alloc_rx_bi() call to i40e_set_ringparam().
> 
> Fixes: be1222b585fd ("i40e: Separate kernel allocated rx_bi rings from
> AF_XDP rings")
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>



