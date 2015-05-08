From: Young, James M <james.m.young@intel.com>
Date: Fri, 8 May 2015 19:24:55 +0000
Subject: [Intel-wired-lan] [net-next S4 03/15] i40e/i40evf: Add ATR
 support	for tunneled TCP/IPv4/IPv6 packets.
In-Reply-To: <1429229172-143692-4-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783E9F9851@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, April 16, 2015 5:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [net-next S4 03/15] i40e/i40evf: Add ATR support
> for tunneled TCP/IPv4/IPv6 packets.
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> Without this RSS would have done inner header load balancing. Now we can
> get the benefits of ATR for tunneled packets to better align TX and RX
> queues with the right core/interrupt.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I07d0e0a192faf28fdd33b2f04c32b2a82ff97ddd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 77 +++++++++++++++--------
> ----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  1 +
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 34 ++++++------
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  1 +
>  4 files changed, 62 insertions(+), 51 deletions(-)

I cannot verify this as a pass since I cannot use netperf or iperf through the vxlan tunnel using IPv6 inner protocol.  Pings do not trigger ATR hits so cannot verify that way. IPv4 iperf and netper do cause hits that advance the count. 

